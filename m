Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D98C595E06
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 16:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbiHPOFE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 10:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235945AbiHPOEc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 10:04:32 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893BC5FAC1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 07:04:11 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id f15so4047505uao.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 07:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=xtRUSQr8O+ysT7jAkgK1TbbpsDVfSQJinm4xiH0h1Bw=;
        b=PrRxMJCp6C9sn9w6Y8cfBsPV7LwQT5aTtK0KcVlrF9MifanGX3RA7tm/97IRip0Udt
         /55YBQmgtDaI4QUMm86Vb9P+UcQM/6peEQUBIGRBQMl4Zd2CpQkuYKUm7NV8LyYqDXta
         uqb8AjD83hhogHq3G13bHnPOPoHRqWId6IRuH6EmUKHkCpeN/F5u6vvAelydpwyUBbiQ
         uZXBJ8wnfGhpu+iZyb9AX1c2kH8fsTsJCEG9SGrTbIm/EG2O9BzURolXbyK80cPZLiMZ
         /R7zwiV1VVvRGhFlKf1Kmaft8D+75y499Pf+EzvSTA0e7mG6TCujpPIdPY7HnX5axzz0
         xeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=xtRUSQr8O+ysT7jAkgK1TbbpsDVfSQJinm4xiH0h1Bw=;
        b=2/nKTmeDA6B7bJsFttJlM4KWp9s/xYrXhHB9eMiNQNZJzeWz14Mh6+U5KL2mZtLtln
         N7ZqyatTvxtgBsVGK5ibggDEFKBEIISMV3segoI/ZoLiXI0YxYfyWSqOZwkyy57H9MIA
         xYF5m7v5i0hqcklYM+VVgnXNNPP23LwULb97B3R/E1rAI9PTrSjcwwfu2orRRR/aBWtG
         Xl79V32wTtpxpUWXM3x6kehEdVGVN3dfnio3c5Ubl56V+i4992d20p2SYGCd3Qbpfu7Z
         nAzt/+uT7F+wGLgxE13Ta8pK82cNAQ/8SZ7ZbiXpinNghmZJiKY+ek/43N+Sbxxq/ySm
         U0TA==
X-Gm-Message-State: ACgBeo3ZaKqYXreCdBzDCkvdTdZrGj+em1KLEl1QhW2YZ4CJDHAV7AYa
        ToDfdlzFC0PIVeDK+vBKAX0KRr5+3Q0Fi3YtpJNaf2WwgCU=
X-Google-Smtp-Source: AA6agR4823zV5GGwsEZQPzdX9ZVSPmbvYA65ARDmjbstWbVdAnuNxZxhnBOXHKEw+8UdKrDl4v5Ks9i/D4WsFyeR2pY=
X-Received: by 2002:ab0:2986:0:b0:38c:672e:9c12 with SMTP id
 u6-20020ab02986000000b0038c672e9c12mr8542379uap.102.1660658649997; Tue, 16
 Aug 2022 07:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220814152322.569296-1-amir73il@gmail.com> <d910e1ef7c8fcf65fbdb0bc438ebba2d7a1d6f83.camel@kernel.org>
In-Reply-To: <d910e1ef7c8fcf65fbdb0bc438ebba2d7a1d6f83.camel@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 16 Aug 2022 17:03:59 +0300
Message-ID: <CAOQ4uxikUbTbMqBRfqEx7n=UMSMH5DWPvVGKbZLCNef0Dp-nbQ@mail.gmail.com>
Subject: Re: [PATCH] locks: fix TOCTOU race when granting write lease
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 15, 2022 at 2:21 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Sun, 2022-08-14 at 18:23 +0300, Amir Goldstein wrote:
> > Thread A trying to acquire a write lease checks the value of i_readcount
> > and i_writecount in check_conflicting_open() to verify that its own fd
> > is the only fd referencing the file.
> >
> > Thread B trying to open the file for read will call break_lease() in
> > do_dentry_open() before incrementing i_readcount, which leaves a small
> > window where thread A can acquire the write lease and then thread B
> > completes the open of the file for read without breaking the write lease
> > that was acquired by thread A.
> >
> > Fix this race by incrementing i_readcount before checking for existing
> > leases, same as the case with i_writecount.
> >
>
> Nice catch.
>
> > Use a helper put_file_access() to decrement i_readcount or i_writecount
> > in do_dentry_open() and __fput().
> >
> > Fixes: 387e3746d01c ("locks: eliminate false positive conflicts for write lease")
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Hi Jeff,
> >
> > This fixes a race I found during code audit - I do not have a reproducer
> > for it.
> >
> > I ran the fstests I found for locks and leases:
> > generic/131 generic/478 generic/504 generic/571
> > and the LTP fcntl tests.
> >
> > Encountered this warning with generic/131, but I also see it on
> > current master:
> >
> >  =============================
> >  WARNING: suspicious RCU usage
> >  5.19.0-xfstests-14277-gbd6ab3ef4e93 #966 Not tainted
> >  -----------------------------
> >  include/net/sock.h:592 suspicious rcu_dereference_check() usage!
> >
> >  other info that might help us debug this:
> >
> >
> >  rcu_scheduler_active = 2, debug_locks = 1
> >  5 locks held by locktest/3996:
> >   #0: ffff88800be1d7a0 (&sb->s_type->i_mutex_key#8){+.+.}-{3:3}, at: __sock_release+0x25/0x97
> >   #1: ffff88800909ce00 (sk_lock-AF_INET){+.+.}-{0:0}, at: tcp_close+0x14/0x60
> >   #2: ffff888006847cc8 (&h->lhash2[i].lock){+.+.}-{2:2}, at: inet_unhash+0x3a/0xcf
> >   #3: ffffffff82a8ac18 (reuseport_lock){+...}-{2:2}, at: reuseport_detach_sock+0x17/0xb8
> >   #4: ffff88800909d0b0 (clock-AF_INET){++..}-{2:2}, at: bpf_sk_reuseport_detach+0x1b/0x85
> >
> >  stack backtrace:
> >  CPU: 1 PID: 3996 Comm: locktest Not tainted 5.19.0-xfstests-14277-gbd6ab3ef4e93 #966
> >  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> >  Call Trace:
> >   <TASK>
> >   dump_stack_lvl+0x45/0x5d
> >   bpf_sk_reuseport_detach+0x5c/0x85
> >   reuseport_detach_sock+0x65/0xb8
> >   inet_unhash+0x55/0xcf
> >   tcp_set_state+0xb3/0x10d
> >   ? mark_lock.part.0+0x30/0x101
> >   __tcp_close+0x26/0x32d
> >   tcp_close+0x20/0x60
> >   inet_release+0x50/0x64
> >   __sock_release+0x32/0x97
> >   sock_close+0x14/0x1b
> >   __fput+0x118/0x1eb
> >
> >
> > Let me know what you think.
> >
> > Thanks,
> > Amir.
> >
> >  fs/file_table.c    |  7 +------
> >  fs/open.c          | 11 ++++-------
> >  include/linux/fs.h | 10 ++++++++++
> >  3 files changed, 15 insertions(+), 13 deletions(-)
> >
> > diff --git a/fs/file_table.c b/fs/file_table.c
> > index 99c6796c9f28..dd88701e54a9 100644
> > --- a/fs/file_table.c
> > +++ b/fs/file_table.c
> > @@ -324,12 +324,7 @@ static void __fput(struct file *file)
> >       }
> >       fops_put(file->f_op);
> >       put_pid(file->f_owner.pid);
> > -     if ((mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ)
> > -             i_readcount_dec(inode);
> > -     if (mode & FMODE_WRITER) {
> > -             put_write_access(inode);
> > -             __mnt_drop_write(mnt);
> > -     }
> > +     put_file_access(file);
> >       dput(dentry);
> >       if (unlikely(mode & FMODE_NEED_UNMOUNT))
> >               dissolve_on_fput(mnt);
> > diff --git a/fs/open.c b/fs/open.c
> > index 8a813fa5ca56..a98572585815 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -840,7 +840,9 @@ static int do_dentry_open(struct file *f,
> >               return 0;
> >       }
> >
> > -     if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode)) {
> > +     if ((f->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ) {
> > +             i_readcount_inc(inode);
> > +     } else if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode)) {
> >               error = get_write_access(inode);
> >               if (unlikely(error))
> >                       goto cleanup_file;
> > @@ -880,8 +882,6 @@ static int do_dentry_open(struct file *f,
> >                       goto cleanup_all;
> >       }
> >       f->f_mode |= FMODE_OPENED;
> > -     if ((f->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ)
> > -             i_readcount_inc(inode);
> >       if ((f->f_mode & FMODE_READ) &&
> >            likely(f->f_op->read || f->f_op->read_iter))
> >               f->f_mode |= FMODE_CAN_READ;
> > @@ -935,10 +935,7 @@ static int do_dentry_open(struct file *f,
> >       if (WARN_ON_ONCE(error > 0))
> >               error = -EINVAL;
> >       fops_put(f->f_op);
> > -     if (f->f_mode & FMODE_WRITER) {
> > -             put_write_access(inode);
> > -             __mnt_drop_write(f->f_path.mnt);
> > -     }
> > +     put_file_access(f);
> >  cleanup_file:
> >       path_put(&f->f_path);
> >       f->f_path.mnt = NULL;
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 9eced4cc286e..8bc04852c3da 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -3000,6 +3000,16 @@ static inline void i_readcount_inc(struct inode *inode)
> >       return;
> >  }
> >  #endif
> > +static inline void put_file_access(struct file *file)
> > +{
> > +     if ((file->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ) {
> > +             i_readcount_dec(file->f_inode);
> > +     } else if (file->f_mode & FMODE_WRITER) {
> > +             put_write_access(file->f_inode);
> > +             __mnt_drop_write(file->f_path.mnt);
> > +     }
> > +}
> > +
> >  extern int do_pipe_flags(int *, int);
> >
> >  extern ssize_t kernel_read(struct file *, void *, size_t, loff_t *);
>
> Looks good to me. I like the new helper.
>
> In addition to Al's comment about which header this should go in, it
> might also be good to put a kerneldoc comment over it.
>

I'm sorry, I couldn't come up with a good description of
this arbitrary helper and I don't think this is so important
for an internal helper like this one.

For now, I will post without the kerneldoc.
If you disagree, please provide a description.

Thanks,
Amir.
