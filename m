Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C906B3520
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 05:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjCJEFa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 23:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjCJEF2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 23:05:28 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB277F24A2;
        Thu,  9 Mar 2023 20:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sXO3jdqVtcE9IkmkZO6INMTY092zGfYbJtv9fnxM+sA=; b=s4GPi5XiLpgFxOlwC+NflMG4/X
        5HbPrHSvN06Y/6GM49O0nUugEJWHbzRYk7+EIhVHCxwEJLArUtCzzLmbb/w8xsdE1ryBSkDa4o/UH
        /N3oi9I6KVELpO4jbxOBBgqadEWL8k8Wl3X6o65G0ZkCGO7az4JwtM2Xp0Ugz8+6prxwsSFqzhWjX
        uX2Z+9SprefB8puk0M9v8g355tcJYOHb6tD4sgQOoxH5zYgTMjICW2GSKbf5ZGmTfecoDhGe3HaF4
        TTuzOp2phpd65QIpwrHo9QfKuhFLoKM1nmI+Zh35Eab3siV3m/GriED+HcHPd+vQqeBt2OFkrlOnZ
        M5IC4GPQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1paU0C-00FCuh-1q;
        Fri, 10 Mar 2023 04:05:08 +0000
Date:   Fri, 10 Mar 2023 04:05:08 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        brauner@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: erofs: convert to use i_blockmask()
Message-ID: <20230310040508.GN3390869@ZenIV>
References: <20230310031547.GD3390869@ZenIV>
 <20230310035121.56591-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310035121.56591-1-frank.li@vivo.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 10, 2023 at 11:51:21AM +0800, Yangtao Li wrote:
> Hi AI,
> 
> > Umm...  What's the branchpoint for that series?
> > Not the mainline - there we have i_blocksize() open-coded...
> 
> Sorry, I'm based on the latest branch of the erofs repository.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git/log/?h=dev-test
> 
> I think I can resend based on mainline.
> 
> > Umm...  That actually asks for DIV_ROUND_UP(i_size_read_inode(), i_blocksize(inode))
> > - compiler should bloody well be able to figure out that division by (1 << n)
> > is shift down by n and it's easier to follow that way...
> 
> So it seems better to change to DIV_ROUND_UP(i_size_read_inode(), i_blocksize(inode))?
> 
> > And the fact that the value will be the same (i.e. that ->i_blkbits is never changed by ocfs2)
> > is worth mentioning in commit message...
> 
> How about the following msg?
> 
> Use i_blockmask() to simplify code. BTW convert ocfs2_is_io_unaligned
> to return bool type and the fact that the value will be the same
> (i.e. that ->i_blkbits is never changed by ocfs2).
> 
> 
> 
> A small question, whether this series of changes will be merged
> into each fs branch or all merged into vfs?

Depends.  The thing to avoid is conflicts between the trees and
convoluted commit graph.

In cases like that the usual approach is
	* put the helper into never-rebased branch - in vfs tree, in this
case; I've no real objections against the helper in question.
	* let other trees convert to the helper at leisure - merging
that never-rebased branch from vfs.git before they use the helper, of
course.  Or wait until the next cycle, for that matter...

I can pick the stuff in the areas that don't have active development,
but doing that for e.g. ext4 won't help anybody - it would only cause
headache for everyone involved down the road.  And I'd expect the gfs2
to be in the same situation...
