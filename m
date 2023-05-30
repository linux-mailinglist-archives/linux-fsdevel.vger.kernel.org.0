Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD4A716820
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 17:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjE3PzY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 11:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbjE3Pyx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 11:54:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF6DE8;
        Tue, 30 May 2023 08:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 098DB6151F;
        Tue, 30 May 2023 15:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDFEC433D2;
        Tue, 30 May 2023 15:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685462091;
        bh=W7HyuEs9eRSylX98QC0ucC92RskTVhlHWIeR+1802Ac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MDQmc10MhvIBRvlB1emFAmsbvZWyfln5YhrmGnBcKKzRcVckXpESn25NXQ/6W+m8g
         9ykJNvj/tPzCw8vfUwQAZQPsSvHscWocz6u3iYDO8VWRyP5QIBw3u1z8CUZCDhFLIy
         mgFyU0CGUfYE3pHW2KFn6SRTkXXeJ8UvvckyqV8EGZ7xkmClm4qu57adEaaPC+J12C
         ltBToZwZFmdnIG8U7sLQBuMc6xK+Px7L54oTiKfduaxobe5sixsLGE4wpNE736T4iC
         BOu0Xeh8LbhL7Hklo9X2o5LEoVgEtUYb9IlF3ci/sstuzjvCzdFHRgj3VJm7XG1bUf
         e21HdYsv55/Sg==
Date:   Tue, 30 May 2023 17:54:46 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Prince Kumar Maurya <princekumarmaurya06@gmail.com>
Cc:     skhan@linuxfoundation.org, viro@zeniv.linux.org.uk,
        chenzhongjin@huawei.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org,
        syzbot+aad58150cbc64ba41bdc@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] fs/sysv: Null check to prevent null-ptr-deref bug
Message-ID: <20230530-gefangen-ersonnen-d1f1b6eea903@brauner>
References: <000000000000cafb9305fc4fe588@google.com>
 <20230528184422.596947-1-princekumarmaurya06@gmail.com>
 <20230530-zenit-radeln-06417ce5fe85@brauner>
 <CAF0B0eKxMf7-uzgRJcWsWW6hgxP25bPG8U9nF0by7mSNvhZmbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF0B0eKxMf7-uzgRJcWsWW6hgxP25bPG8U9nF0by7mSNvhZmbQ@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 30, 2023 at 07:59:16AM -0700, Prince Kumar Maurya wrote:
> On Tue, May 30, 2023 at 1:26 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Sun, May 28, 2023 at 11:44:22AM -0700, Prince Kumar Maurya wrote:
> > > sb_getblk(inode->i_sb, parent) return a null ptr and taking lock on
> > > that leads to the null-ptr-deref bug.
> > >
> > > Reported-by: syzbot+aad58150cbc64ba41bdc@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=aad58150cbc64ba41bdc
> > > Signed-off-by: Prince Kumar Maurya <princekumarmaurya06@gmail.com>
> > > ---
> > > Change since v2: Updated subject and added Reported-by and closes tags.
> > >
> > >  fs/sysv/itree.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
> > > index b22764fe669c..3a6b66e719fd 100644
> > > --- a/fs/sysv/itree.c
> > > +++ b/fs/sysv/itree.c
> > > @@ -145,6 +145,8 @@ static int alloc_branch(struct inode *inode,
> > >                */
> > >               parent = block_to_cpu(SYSV_SB(inode->i_sb), branch[n-1].key);
> > >               bh = sb_getblk(inode->i_sb, parent);
> > > +             if (!bh)
> > > +                     break;
> >
> > When you break here you'll hit:
> >
> > /* Allocation failed, free what we already allocated */
> > for (i = 1; i < n; i++)
> >         bforget(branch[i].bh);
> > for (i = 0; i < n; i++)
> >         sysv_free_block(inode->i_sb, branch[i].key);
> >
> > below. The cleanup paths were coded in the assumption that sb_getblk()
> > can't fail. So bforget() can assume that branch[i].bh has been allocated
> > and set up. So that bforget(branch[i].bh) is your next pending NULL
> > deref afaict.
> 
> 
> I doubt that would happen. There is a break above as well, before we do
> sb_getblk().
> 
> /* Allocate the next block */
> branch[n].key = sysv_new_block(inode->i_sb);
> if (!branch[n].key)
>    break;
> 
> The clean up code path runs till i is less than n not equal to n which
> would have caused the problem.

But then aren't you leaking branch[n].key if you break after failed sb_getblk()
after sysv_new_block() succeeded?
