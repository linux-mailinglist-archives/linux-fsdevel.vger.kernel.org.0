Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F38477A42A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Aug 2023 01:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjHLXJf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Aug 2023 19:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjHLXJe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Aug 2023 19:09:34 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031A6E71
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Aug 2023 16:09:36 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-92.bstnma.fios.verizon.net [173.48.82.92])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37CN6mVO014307
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Aug 2023 19:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1691881612; bh=9bn+ohKg+ghUW2txD551p5T3wS+9+MovG54qvNqbRtM=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=mvguaUSTYs57TQv3jE1NcPKPtmbX+5P1FJK3x4qCT7X7+bxjdR9Da7i5n+Wdwgk5p
         HpWEh4oW7R+ksSyDy2MW1+MdMprUA+1ehBahLGxtHI0tPTXxx0MMyU7N/cjN5Z0A//
         yDGDWbI6O4TXx++t1HdBSgudrdO3uxUME72iHJ4jasVdEhIt3X4MpaY4aJRILqC3xz
         cXOYr7kDi2j76PJzGU5v7aSZ6J0OkWPbcuqxJHFfsfRSLb4X8LhfuuWBz8HDJjt8BC
         nPvbXt4W4hDMoNjHJ5DgNDZIndXKWXXSVRPp2ihQmnHlSZNeoeUi73hQTpExwxBDaQ
         QEnWpIsLP0MDw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8E17015C04FF; Sat, 12 Aug 2023 19:06:47 -0400 (EDT)
Date:   Sat, 12 Aug 2023 19:06:47 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Gabriel Krisman Bertazi <krisman@suse.de>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jaegeuk@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v5 01/10] fs: Expose helper to check if a directory needs
 casefolding
Message-ID: <20230812230647.GB2247938@mit.edu>
References: <20230812004146.30980-1-krisman@suse.de>
 <20230812004146.30980-2-krisman@suse.de>
 <20230812015915.GA971@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812015915.GA971@sol.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 06:59:15PM -0700, Eric Biggers wrote:
> 
> To be honest I've always been confused about why the ->s_encoding check is
> there.  It looks like Ted added it in 6456ca6520ab ("ext4: fix kernel oops
> caused by spurious casefold flag") to address a fuzzing report for a filesystem
> that had a casefolded directory but didn't have the casefold feature flag set.
> It seems like an unnecessarily complex fix, though.  The filesystem should just
> reject the inode earlier, in __ext4_iget().  And likewise for f2fs.  Then no
> other code has to worry about this problem.

It's not enough to check it in ext4_iget, since the casefold flag can
get set *after* the inode has been fetched, but before you try to use
it.  This can happen because syzbot has opened the block device for
writing, and edits the superblock while it is mounted.

One could say that this is an insane threat model, but the syzbot team
thinks that this can be used to break out of a kernel lockdown after a
UEFI secure boot.  Which is fine, except I don't think I've been able
to get any company (including Google) to pay for headcount to fix
problems like this, and the unremitting stream of these sorts of
syzbot reports have already caused one major file system developer to
burn out and step down.

So problems like this get fixed on my own time, and when I have some
free time.  And if we "simplify" the code, it will inevitably cause
more syzbot reports, which I will then have to ignore, and the syzbot
team will write more "kernel security disaster" slide deck
presentations to senior VP's, although I'll note this has never
resulted in my getting any additional SWE's to help me fix the
problem...

> So just __ext4_iget() needs to be fixed.  I think we should consider doing that
> before further entrenching all the extra ->s_encoding checks.

If we can get an upstream kernel consensus that syzbot reports caused
by writing to a mounted file system aren't important, and we can
publish this somewhere where hopefully the syzbot team will pay
attention to it, sure...


						- Ted
