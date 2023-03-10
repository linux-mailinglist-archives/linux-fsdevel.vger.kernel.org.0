Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39E76B34DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 04:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjCJDch (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 22:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCJDcf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 22:32:35 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339F810C704;
        Thu,  9 Mar 2023 19:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5nYji9aiOTPkm277QrYAaIqlTmxJJ+NstcSRT3Yv5A4=; b=BlyYntEGWpWNJHstS6q6njadFa
        P58IUANDyb039xyu+2aDp2c7OzdJYDBxQ5K36A+DuuZuUxMwyf+wQEWfkoOhKX//l4UgaNIAhZroj
        raHHfhXFjHkvEhH5SRgjFwVGqN5H037vB9hI2lc0ttLBBrZkpqsiVlRQ+zDDlDn2nXR/ym7JEaTMj
        k6jnj+0wNV9kTXPfzi28opkBB44CtxTJKx85YoHPGh4jQsUxI800+WVVKUEpFmH/vlz+1X4VI7tC3
        aHldI5fbRXyo7CAXw46+xJ66nAVzuZUZqoth8N05jHB92fCaFVa+cWyRpHY1w0o7SEQpAJUAyFnMg
        lssdi5Fg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1paTUM-00FCbC-06;
        Fri, 10 Mar 2023 03:32:14 +0000
Date:   Fri, 10 Mar 2023 03:32:13 +0000
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
Subject: Re: [PATCH v3 4/6] ext4: convert to use i_blockmask()
Message-ID: <20230310033213.GG3390869@ZenIV>
References: <20230309152127.41427-1-frank.li@vivo.com>
 <20230309152127.41427-4-frank.li@vivo.com>
 <20230310031940.GE3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310031940.GE3390869@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 10, 2023 at 03:19:40AM +0000, Al Viro wrote:
> On Thu, Mar 09, 2023 at 11:21:25PM +0800, Yangtao Li wrote:
> > Use i_blockmask() to simplify code.
> > 
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > ---
> > v3:
> > -none
> > v2:
> > -convert to i_blockmask()
> >  fs/ext4/inode.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index d251d705c276..eec36520e5e9 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -2218,7 +2218,7 @@ static int mpage_process_page_bufs(struct mpage_da_data *mpd,
> >  {
> >  	struct inode *inode = mpd->inode;
> >  	int err;
> > -	ext4_lblk_t blocks = (i_size_read(inode) + i_blocksize(inode) - 1)
> > +	ext4_lblk_t blocks = (i_size_read(inode) + i_blockmask(inode))
> >  							>> inode->i_blkbits;
> 
> Umm...  That actually asks for DIV_ROUND_UP(i_size_read_inode(), i_blocksize(inode)) -
> compiler should bloody well be able to figure out that division by (1 << n) is
> shift down by n and it's easier to follow that way...

BTW, here the fact that you are adding the mask is misleading - it's true,
but we are not using it as a mask - it's straight arithmetics.

One can do an equivalent code where it would've been used as a mask, but that
would be harder to read -
	(((i_size_read(inode) - 1) | i_blockmask(inode)) + 1) >> inode->i_blkbits
and I doubt anyone wants that kind of puzzles to stumble upon.
