Return-Path: <linux-fsdevel+bounces-71053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAA7CB2D3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 12:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DA6F305B590
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 11:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFA330BF5C;
	Wed, 10 Dec 2025 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agRU7ec4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30A62D6E6A
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765366103; cv=none; b=uIDc3LNh8gKFtFypttKWl1HdE6wdZIhyV6wGY7iLE0PJPtI8tLiX6CBm8OfhLC6X81oLbxjVUuMSTB6qWMoKxvB5Qkt18q6fbnPrfdFNLRKlpFf1CtPwQOUBPBv9EKzRi7qUo/UobTHow5N/bakfqIGPQMSYOcz9IfzT74gktYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765366103; c=relaxed/simple;
	bh=XAXYptBcDX2fvYO//82dlDUOddwhzfae/Zs/jle65rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXraOvrkU+Mf54UpnQt1wip8dVUTS1UGGz7GMx8fErEQBO3HtIS9Fm2v7vo6YOgMpSg1f6whLYBC5NpfIYq5TbJUhS8mM+q6AbF+XKMjNAbV7FwlR1wsjUtzTWYm9hjL9y5e9QQ1mBdM0bVdcxo5f10hruvPBJ3yNgYUICmEIcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agRU7ec4; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64198771a9bso12154937a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 03:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765366100; x=1765970900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/OlIs4fA7vyKE19uOvZgraqstFeGDQidWxB59d9RmY=;
        b=agRU7ec4D1hvkt+pkcI0OCutV0bn5Pfe3K40vFwGaHl4CKfiLBZD1EtiNBvsQLXc5R
         Ebi4kToCI3Fj/RFuAe603cb2agaL+XNgwK/2rExVr3P/T6yAFave+b21FWBPrBQ91w3V
         Wym/7TGLOxULNmsnaMCwitR4B0sZHWmL31hwh7H9Ieu4e2nUo9joEUmk9SrZRBXVyO48
         KqtIvqwDQndWOfil9c3ZzPBepkbkblY8y1VDlIb8aHNYIbbWzil3dZIMQJE8q4CI88oY
         qmFbNox0Qu2nsDded/bO1nZVy5ofKQ15PwkVkrvFDZtyhj68VgIi96Jhp/dYSoDrChWx
         pEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765366100; x=1765970900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3/OlIs4fA7vyKE19uOvZgraqstFeGDQidWxB59d9RmY=;
        b=of1EPiUJs6s1u0G5wMZsEvqfr70YdD/N1ES8eV+bjVwMTL6U129vMLG82z6K7oOQtZ
         oNRLDuvcUjcOcYtNZV+/FO9GybeCTav53ZfrLCoj86/pd5zMEdmvnSXKsuq0LhQs37R8
         HiQd0k4rOv1xjJ0POK1Q2l0sd5NQFBuCJ6PX4DIZZ6iQ+FQip0cN08Lo5fVVFHpigeF6
         Uvqs2mn94vZ2rToJnUiKJ9An7lR2jjqJee+aJVK5J/Zg0e8zDsMcs4NZjFnvHqP0DIUU
         nlM3qJaKNkr2cfzy7derWqh+KtpxP2Dq8v78VisqAIj3+n//Tc96H4w8e+YPTYHC3AMz
         rA3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJb+6EKrdMEeLUGTpfC/CrHuq8Jws7NdqdthVgPU65ly960QokMUolx2QJvnyLl0UQUwedZXbWcmrixsxY@vger.kernel.org
X-Gm-Message-State: AOJu0YyJUbFnVAwWtQdb/22Gl2BBxaWXhC3eDiLVje3hZ+huf5kHH4rK
	WVi82zyVa7kdSy4kpDPHaLY06dRKJV/QLiC6AGj0JqSJ0jRN3UyjNdOdKbH0aS/juodsOM/tr5x
	eOk2HLbcY02yrKLcEwo4kVJbu1gpMJOM=
X-Gm-Gg: AY/fxX47WNF4XK+WDvW9wwoWkD+MGnwKgfP0qzpBzvB14axHTZ1EiVhuR6YEOufDwKp
	cDcUNy8npAnIxhG5KitaqFg2HzB9lBZAdHIknbvLDAcL+cAt6QBWS2FoqoPTP8OhX574rI3J2Vk
	jRHeWpA8lap99YW/thVUmWl41hcnbcuvHknAl2DAlwLJbWomsUImV1mOviC6uNzC227KKoInAel
	HdWClHSn6dKXY53xGxCy6JcXDoBLcecPA85d4MailbndaR+b/t8kfTPEjx2GIGBp+I8b81nVz3Z
	pqP9OqDkKWrQ2xeAqtHJRxCLFD4=
X-Google-Smtp-Source: AGHT+IGI9z2LZl2WibgGATCYde2aL+JH7VhrQQY/TMvTfGol8TxjwJQZ+8ocqbRLU4TLms/TZMLHiCAIyDj9wQZG4H8=
X-Received: by 2002:a05:6402:27cc:b0:640:c640:98c5 with SMTP id
 4fb4d7f45d1cf-6496d5e5fc8mr1967549a12.34.1765366100233; Wed, 10 Dec 2025
 03:28:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f2ui7rofuos4vcuj7t7pa5tcyq5m3agm44ouk7hcdl7opiwmwd@dyctf7rrsuqw> <69395726.a70a0220.33cd7b.0006.GAE@google.com>
In-Reply-To: <69395726.a70a0220.33cd7b.0006.GAE@google.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 10 Dec 2025 12:28:07 +0100
X-Gm-Features: AQt7F2oNOko-4QXcehKn_iA5o50dm0UpHnz99JthCcbiFS8x7mF9mDdJg9Jb8S8
Message-ID: <CAGudoHH5KvF4aJiLSiEqu_UkHrqoCKt2XXRozDDh-Bub_usuSg@mail.gmail.com>
Subject: Re: [syzbot] [exfat?] [ocfs2?] kernel BUG in link_path_walk
To: syzbot <syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mark@fasheh.com, 
	ocfs2-devel@lists.linux.dev, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 12:25=E2=80=AFPM syzbot
<syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch but the reproducer is still triggeri=
ng an issue:
> kernel BUG in ocfs2_journal_toggle_dirty
>
> (syz.0.554,7359,0):ocfs2_assign_bh:2417 ERROR: status =3D -30
> (syz.0.554,7359,0):ocfs2_inode_lock_full_nested:2512 ERROR: status =3D -3=
0
> (syz.0.554,7359,0):ocfs2_shutdown_local_alloc:412 ERROR: status =3D -30
> ------------[ cut here ]------------
> kernel BUG at fs/ocfs2/journal.c:1027!
>  <TASK>
>  ocfs2_journal_shutdown+0x524/0xab0 fs/ocfs2/journal.c:1109
>  ocfs2_mount_volume fs/ocfs2/super.c:1785 [inline]
>  ocfs2_fill_super+0x5574/0x63a0 fs/ocfs2/super.c:1083
>  get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1691
>  vfs_get_tree+0x92/0x2a0 fs/super.c:1751
>  fc_mount fs/namespace.c:1199 [inline]
>  do_new_mount_fc fs/namespace.c:3636 [inline]
>  do_new_mount+0x302/0xa10 fs/namespace.c:3712
>  do_mount fs/namespace.c:4035 [inline]
>  __do_sys_mount fs/namespace.c:4224 [inline]
>  __se_sys_mount+0x313/0x410 fs/namespace.c:4201
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

That's a different bug.

