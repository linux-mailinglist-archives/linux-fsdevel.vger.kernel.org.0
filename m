Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FEC51B74F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 07:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240980AbiEEFFK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 01:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiEEFFH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 01:05:07 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50C32CE17
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 22:01:28 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id d132so1600630vke.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 May 2022 22:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4jJUgw4Kf4K49y9qVmoODXMFjGhVbHPO7OkkAetlJAw=;
        b=cRoLvUKFOtmf792dMYv0ElxIK6jRVKDL/NpD8y/LVfYrsZWL97HCd2V8ug7BtG9237
         xE8Ivh5OiYcR7LuCxZzYQJHmlFPs8EAnk/HCSbhZGYPk9Xt35f3S8bKFlb6lpwFGSOm+
         if6wyKA0M2v4NeQeh/LiG8eaKwQq/1hZyjUIsJWbWO62oeASXo+pXnd/+v0Z534plAUQ
         Zn+KHQMujfxczHBunH1kbeH2IloLAtKXg14fj0N5MZCIPMP7NcLe0aJn+FJvXszN0Td8
         4f0hiuQbSy61Tt9BF7ynNtmfSoOHNiwSs84lcGZs76uU7OORpsibhkhY2n6Rx4N8juAX
         6ELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4jJUgw4Kf4K49y9qVmoODXMFjGhVbHPO7OkkAetlJAw=;
        b=55CDVxegFRNh+PeqRpKq+deStOsMV06SpHIsR63t7LkkAhX+qe6xHo5OepTyFis7Nx
         Ma0vlv7k7Nr4HbUfRYIAHRTBdlDKiIKyTo3gWcTvYS2lq1tYZRyo/ChxFVTabYE7FjK3
         fRbHqJCmp2BSTg1eWy51PEfzv2vAwALNmMU0PkIrzyP77pOFqQ70alEkEh2WrTaZ8R8F
         P/PtbQFEEX5+ScJMXjU4J9IFFm2Ap7RBeZ4UwFvuyamVAYnTlRL6V1osRFaXDQHTej9Q
         a8yTOHJfMJFxXUrT30JVfHusWkeeJTLWiOZTb0shvwugGEkOUTsVxsvT1x8L2h/nEWEy
         e8Uw==
X-Gm-Message-State: AOAM533vnj3KpabZJvz/3wyRjhqkW4Le65lwWYeNm5zvyPExomYnTb34
        Miclb+KPjjMLXlLzsjUq7tmcd/SKgx0ADEgpxk8=
X-Google-Smtp-Source: ABdhPJx54iExsG/JBH46JxzGnM3toEbJmHk0IXjAzwq3ovF904dfSkoKqUMykbEqadPhLYwxtVRr7+UxzkFpcm4rA14=
X-Received: by 2002:a1f:5842:0:b0:34e:7a9e:9579 with SMTP id
 m63-20020a1f5842000000b0034e7a9e9579mr6799227vkb.16.1651726887922; Wed, 04
 May 2022 22:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220504143924.ix2m3azbxdmx67u6@quack3.lan> <20220504182514.25347-1-sunjunchao2870@gmail.com>
 <20220504193847.lx4eqcnqzqqffbtm@quack3.lan>
In-Reply-To: <20220504193847.lx4eqcnqzqqffbtm@quack3.lan>
From:   Jchao sun <sunjunchao2870@gmail.com>
Date:   Thu, 5 May 2022 13:01:16 +0800
Message-ID: <CAHB1NahcbDhwSxWqmEOakD42pcYdRmXZ5eDfc=NTWgufTddJvA@mail.gmail.com>
Subject: Re: [PATCH v3] writeback: Fix inode->i_io_list not be protected by
 inode->i_lock error
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 5, 2022 at 3:38 AM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 04-05-22 11:25:14, Jchao Sun wrote:
> > Commit b35250c0816c ("writeback: Protect inode->i_io_list with
> > inode->i_lock") made inode->i_io_list not only protected by
> > wb->list_lock but also inode->i_lock, but inode_io_list_move_locked()
> > was missed. Add lock there and also update comment describing things
> > protected by inode->i_lock.
> >
> > Fixes: b35250c0816c ("writeback: Protect inode->i_io_list with inode->i_lock")
> > Signed-off-by: Jchao Sun <sunjunchao2870@gmail.com>
>
> Almost there :). A few comments below:
>
> > @@ -2402,6 +2404,9 @@ void __mark_inode_dirty(struct inode *inode, int flags)
> >                       inode->i_state &= ~I_DIRTY_TIME;
> >               inode->i_state |= flags;
> >
> > +             wb = locked_inode_to_wb_and_lock_list(inode);
> > +             spin_lock(&inode->i_lock);
> > +
>
>
> > We don't want to lock wb->list_lock if the inode was already dirty (which
> > is a common path). So you want something like:
> >
> >                 if (was_dirty)
> >                         wb = locked_inode_to_wb_and_lock_list(inode);
> >
> > (and initialize wb to NULL to make sure it does not contain stale value).

I'm a little confused about here. The logic of the current source tree
is like this:
                       if (!was_dirty) {
                               struct bdi_writeback *wb;
                               wb =  locked_inode_to_wb_and_lock_list(inode);
                               ...
                               dirty_list = &wb-> b_dirty_time;
                               assert_spin_locked(&wb->list_lock);
                       }
The logic is the opposite of the logic in the comments, and it seems
like that wb will
absolutely not be NULL.
Why is this? What is the difference between them?

If run with the logic in the comments, wb will only be initialized
when was_dirty != 0,
suppose was_dirty is 0, wb will not be initialized, and continue
running, will hit
                      if (!was_dirty) {
                              dirty_list = &wb->b_dirty_time;
                      }
will hit NULL pointer.
Is there something I have missed?

>
> > @@ -2409,7 +2414,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
> >                * list, based upon its state.
> >                */
> >               if (inode->i_state & I_SYNC_QUEUED)
> > -                     goto out_unlock_inode;
> > +                     goto out_unlock;
> >
> >               /*
> >                * Only add valid (hashed) inodes to the superblock's
> > @@ -2417,22 +2422,19 @@ void __mark_inode_dirty(struct inode *inode, int flags)
> >                */
> >               if (!S_ISBLK(inode->i_mode)) {
> >                       if (inode_unhashed(inode))
> > -                             goto out_unlock_inode;
> > +                             goto out_unlock;
> >               }
> >               if (inode->i_state & I_FREEING)
> > -                     goto out_unlock_inode;
> > +                     goto out_unlock;
> >
> >               /*
> >                * If the inode was already on b_dirty/b_io/b_more_io, don't
> >                * reposition it (that would break b_dirty time-ordering).
> >                */
> >               if (!was_dirty) {
> > -                     struct bdi_writeback *wb;
> >                       struct list_head *dirty_list;
> >                       bool wakeup_bdi = false;
> >
> > -                     wb = locked_inode_to_wb_and_lock_list(inode);
> > -
> >                       inode->dirtied_when = jiffies;
> >                       if (dirtytime)
> >                               inode->dirtied_time_when = jiffies;
> > @@ -2446,6 +2448,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
> >                                                              dirty_list);
> >
> >                       spin_unlock(&wb->list_lock);
> > +                     spin_unlock(&inode->i_lock);
> >                       trace_writeback_dirty_inode_enqueue(inode);
> >
> >                       /*
> > @@ -2460,6 +2463,8 @@ void __mark_inode_dirty(struct inode *inode, int flags)
> >                       return;
> >               }
> >       }
>
> > > +out_unlock:
> > > +     spin_unlock(&wb->list_lock);

Ouch, this is so obvious now that you mention it. Really stupid
mistake on my side. It surprised me that local compile do not have warnings..
>
> wb->list lock will not be locked in some cases here. So you have to be more
> careful about when you need to unlock it. Probably something like:
>
>         if (wb)
>                 spin_unlock(&wb->list_lock);
>
> and you can put this at the end inside the block "if ((inode->i_state &
> flags) != flags)".
>
>
> > Also I'd note it is good to test your changes (it would likely uncover the
> > locking problem). For these filesystem related things xfstests are useful:
> >
> > https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/

Thanks a lot! I'll test this patch for ext4 fs using this tool.
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
