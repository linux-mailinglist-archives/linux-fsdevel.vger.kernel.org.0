Return-Path: <linux-fsdevel+bounces-23190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9139283C6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 10:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514DB1C249E8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 08:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF4E14533A;
	Fri,  5 Jul 2024 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VARVREWA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CA513C8E1
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jul 2024 08:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720168633; cv=none; b=NCs8LIjD1KIB/4F0jrLS8um81wrUzcM02jX/x63pBKPciDOi7w4aTjp3EWHutmh055dekaxvx5U733YHtroqsqhrnJaMWV0XVSCOilpaaDCy7dKlxGlax5uH3vhZEy3N8GS7uBgKd/o+0FjMxhMtU6RFrmVjlwFAAlYsDQKFCMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720168633; c=relaxed/simple;
	bh=L8T4fAd+i6lMJOb0mGnIHqh1BQFIZ6jQKgxnSfg9FrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pmKKhqtq9KPND+S864UA5bjGuBrEQ7CiT4IBe46XJJq9wgIauZVqfvyAeh9dGVFK7mFiAvEAVfAVkvLij5ZiyreeeNlnM/XQNlubjpO8lblj2YNRDhDSFTSWEgsdI+zJeaCCr1tn0Vw4ajBO8DkOMWb3iNHBkHQBfyvnIXjABac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VARVREWA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4257c6eea33so125245e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jul 2024 01:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720168630; x=1720773430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UQwA3Kp6rY7GN1bt0gq+5iMS6ewVmIpRpM/Zdufy9I=;
        b=VARVREWA9SzjYvL664OsP2TnNWutoDzNS1aEvVmKwTAdXhHpBL+AVvbraeVfhRbelt
         GNT0eByjQF/Htq8JHTbDAw3uZ2SdXGf+eMbDkkFUDKNoS6Xni717mnKGeMEmE9bqzLxs
         imfxd0bBcXjM0x6LkaoXqtKqyNiVwoafwP0m2LnAzeUheyhYrtAuo0t3O78MEDxU9/a1
         62Is3CG7ocG0Xcjve4qX7895NIADnJAGMLdnfPsd8Xw1GxE4TXwhB+rqrPC71MlDoQMa
         hWsQX/6JGLe71d5S4DKvHsX5XDVIM+fq8Gly+nLv+mNC57lsfOTPxu0tGT+0TLbHBhOX
         TgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720168630; x=1720773430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UQwA3Kp6rY7GN1bt0gq+5iMS6ewVmIpRpM/Zdufy9I=;
        b=rAe6TmGS+3KYRziN3I04XpOBeseZPUZlQHRZyXVUK2zy/kaxsihhXgJhMEwt2WME0O
         CiUC3PbkJs99y9te9FNQ+trgPZCmNqlQdqG/WtUce9vCodbq80Qm+wzKslb8zKKITU+1
         NwYOuHxsAtao1syZO4t9ivQnC/uIZgrri9/4W6pCACHtq3/JA8U1HGo2V4CWMgwxJ4Iw
         qk7FZGzE4V7owAj2JlwMI606ZT9W/iDbStZ9cBRd6U5LLRbAiKWKmnRfU66vUtCzHxUa
         b4Pz4YtTrbm64IbYyoOxgGoU2YFJk6dE1Fy7MIbp4ut2dI/qJD6MQa6TerbuTViGzG6v
         LIUw==
X-Forwarded-Encrypted: i=1; AJvYcCVa1R5/DhEluvCIio9pNxViWRvAOO9sN5WzOM9boyN6mKCvDp2Vd4ldAly70VRO1r8Q8rDLH3AKHj+6YyFMrN2UhrJZE63/+t8FAHiIcg==
X-Gm-Message-State: AOJu0YxAEa0h50EnW+IZPo0aw7SBnCGWZYvDrhLuaRZuA24sU7nzdvOd
	61SUZh5vgYzqHlP8BaRxqsSQMbCDXguA2Cusm5i+DDhNRltdrSpteCTzY4k8TN0/OVwU7d6wElw
	swAmPnQjaY/wt8Ot70RkTBuuHhENgmktg3qSn
X-Google-Smtp-Source: AGHT+IE7PPaz2kR1hrZLhrp9YIkibkDV5gYhRR1e+GtMFeCW2vNamP6F96QyI9kufvXEqg0Z4TnmRnrXhMzqqf212bs=
X-Received: by 2002:a05:600c:1c9e:b0:424:891e:a9ff with SMTP id
 5b1f17b1804b1-426482a60ebmr3010915e9.2.1720168629888; Fri, 05 Jul 2024
 01:37:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000dc5b12061c6cac00@google.com> <CACT4Y+Zk0ohwwwHSD63U2-PQ=UuamXczr1mKBD6xtj2dyYKBvA@mail.gmail.com>
 <CAOQ4uxj78ZbHgB+Vyhd-mRKNjbv+kPX8hMsrkSZPkmr5MAvQWg@mail.gmail.com>
In-Reply-To: <CAOQ4uxj78ZbHgB+Vyhd-mRKNjbv+kPX8hMsrkSZPkmr5MAvQWg@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 5 Jul 2024 10:36:58 +0200
Message-ID: <CACT4Y+bHG2KWut-wm8i==dm9j954gAsYFU0YkYitsdchg9i5Xg@mail.gmail.com>
Subject: Re: [syzbot] [fs?] KCSAN: data-race in __fsnotify_parent /
 __fsnotify_recalc_mask (5)
To: Amir Goldstein <amir73il@gmail.com>
Cc: syzbot <syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com>, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Jul 2024 at 08:02, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Jul 4, 2024 at 5:28=E2=80=AFPM Dmitry Vyukov <dvyukov@google.com>=
 wrote:
> >
> > On Thu, 4 Jul 2024 at 16:22, syzbot
> > <syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    795c58e4c7fc Merge tag 'trace-v6.10-rc6' of git://git=
.kern..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D16a6b6b99=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D5b9537cd0=
0be479e
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D701037856c2=
5b143f1ad
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for=
 Debian) 2.40
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/3d1d205c1fdf=
/disk-795c58e4.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/641c78d42b7a/vm=
linux-795c58e4.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/45ecf25d8b=
a3/bzImage-795c58e4.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com
> > >
> > > EXT4-fs (loop3): unmounting filesystem 00000000-0000-0000-0000-000000=
000000.
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > BUG: KCSAN: data-race in __fsnotify_parent / __fsnotify_recalc_mask
> > >
> > > write to 0xffff8881001c9d44 of 4 bytes by task 6671 on cpu 1:
> > >  __fsnotify_recalc_mask+0x216/0x320 fs/notify/mark.c:248
> > >  fsnotify_recalc_mask fs/notify/mark.c:265 [inline]
> > >  fsnotify_add_mark_locked+0x703/0x870 fs/notify/mark.c:781
> > >  fsnotify_add_inode_mark_locked include/linux/fsnotify_backend.h:812 =
[inline]
> > >  inotify_new_watch fs/notify/inotify/inotify_user.c:620 [inline]
> > >  inotify_update_watch fs/notify/inotify/inotify_user.c:647 [inline]
> > >  __do_sys_inotify_add_watch fs/notify/inotify/inotify_user.c:786 [inl=
ine]
> > >  __se_sys_inotify_add_watch+0x66f/0x810 fs/notify/inotify/inotify_use=
r.c:729
> > >  __x64_sys_inotify_add_watch+0x43/0x50 fs/notify/inotify/inotify_user=
.c:729
> > >  x64_sys_call+0x2af1/0x2d70 arch/x86/include/generated/asm/syscalls_6=
4.h:255
> > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > read to 0xffff8881001c9d44 of 4 bytes by task 10004 on cpu 0:
> > >  fsnotify_object_watched fs/notify/fsnotify.c:187 [inline]
> > >  __fsnotify_parent+0xd4/0x370 fs/notify/fsnotify.c:217
> > >  fsnotify_parent include/linux/fsnotify.h:96 [inline]
> > >  fsnotify_file include/linux/fsnotify.h:131 [inline]
> > >  fsnotify_open include/linux/fsnotify.h:401 [inline]
> > >  vfs_open+0x1be/0x1f0 fs/open.c:1093
> > >  do_open fs/namei.c:3654 [inline]
> > >  path_openat+0x1ad9/0x1fa0 fs/namei.c:3813
> > >  do_filp_open+0xf7/0x200 fs/namei.c:3840
> > >  do_sys_openat2+0xab/0x120 fs/open.c:1413
> > >  do_sys_open fs/open.c:1428 [inline]
> > >  __do_sys_openat fs/open.c:1444 [inline]
> > >  __se_sys_openat fs/open.c:1439 [inline]
> > >  __x64_sys_openat+0xf3/0x120 fs/open.c:1439
> > >  x64_sys_call+0x1057/0x2d70 arch/x86/include/generated/asm/syscalls_6=
4.h:258
> > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > value changed: 0x00000000 -> 0x00002008
> > >
> > > Reported by Kernel Concurrency Sanitizer on:
> > > CPU: 0 PID: 10004 Comm: syz-executor Not tainted 6.10.0-rc6-syzkaller=
-00069-g795c58e4c7fc #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 06/07/2024
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >
> > I think __fsnotify_recalc_mask() can be compiled along the lines of:
> >
> > *fsnotify_conn_mask_p(conn) =3D 0;
> > hlist_for_each_entry(mark, &conn->list, obj_list) {
> >    ...
> >    *fsnotify_conn_mask_p(conn) |=3D fsnotify_calc_mask(mark);
> >    ...
> > }
> >
> > And then fsnotify_object_watched() may falsely return that it's not
> > watched (if it observes 0, or any other incomplete value).
>
> As far as I know, this is by design that fsnotify_object_watched()
> is a relaxed test that allows for false negatives right after watch was a=
dded.
> At least this has always been the case.
>
> The question is whether a system call (e.g. open) that started strictly
> after the inotify_add_watch() syscall returned success can realistically
> observe an incomplete mask, because if the two syscalls are racing
> this data race is not interesting.
>
> Jan,
>
> WDYT?
> If this is the case, then is there a way to annotate access to
> *_fsnotify_mask to
> silence KCSAN warnings?

I meant a case when one notification object is watching inode and set
inode->i_fsnotify_mask to something. Then another unrelated
notification object starts watching the same inode and temporarily
resets the mask to 0 during recalculation. As a result the first
object can miss a notification.
But I am looking at this code for the first time, so I may be missing somet=
hing.

