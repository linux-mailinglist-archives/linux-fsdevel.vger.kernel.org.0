Return-Path: <linux-fsdevel+bounces-36610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4E39E67FD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 08:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9DAA18830A2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 07:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D750B1DACB4;
	Fri,  6 Dec 2024 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H46jn/RC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDD132C8B;
	Fri,  6 Dec 2024 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733470531; cv=none; b=Yke9m9sq1YUUPm3ruPhJf7fnDtLgKL3SLtzHS0XhMBUe481HGrTK+f+5pa/VlkuM43pr/JqBExjoduYG3O4Y7E6HCTWRz/q8k6Jr76wtyT8IyjDt9abOPElMJA+sJ//gRjoahQeZ6t6nLSGaJD5DAdowCi41WYRHeqep4dPRUMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733470531; c=relaxed/simple;
	bh=6n5GDqAB3dPrW24WSfYH/MjGUyww6GJYiit9UGygWws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJN6QxmhhhTGNl1FcQ1s8o7svHSe81K+GY0IA7/zTT1TiviqdlNsA53jnUZ4uLwWw7pC4XcoM9iyEarOXHwY4sD4+9Alyt6808enjlXVwNJefOltjT7kU9kRDen2HknZCyK1vknLk/kLCSDUb/Gl4pTgi3Io/AMqp4zS48sWhk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H46jn/RC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9118FC4CED1;
	Fri,  6 Dec 2024 07:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733470530;
	bh=6n5GDqAB3dPrW24WSfYH/MjGUyww6GJYiit9UGygWws=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H46jn/RCbqvSDZCy+JSM4PFTDAhAoGwTGoqcgHC78BNsKGb1TdLt8/FSX6vlIdFAn
	 oRQ4nBCCjquRVJOgIhBNHedva5CSZ0DovEO36YjFr87+beyk0fBZ5lMHzVQ5EXQ1+l
	 utPj8WAsZair64pkvR8Qq3MFcc6F55A7nVRSaZt/dqxbE8PuVqmfxGFp0RN1mqtkSv
	 /ohSK5eg/s60iOJQ3enEssozOSpxJWNpeK/XE4iTINY0f6WyLQe8ZAqjdTDKegAvGB
	 2L8Re8zS4PkfUvep+0x4mcxCiErSTd3tMOo8ETJ1PUs0xSs0Od06/P4LNmP4vyyht7
	 VLieuhbfihn8Q==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-294ec8e1d8aso1747784fac.1;
        Thu, 05 Dec 2024 23:35:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX+ME2LZbkB3qUPykYxDLuGKLInuUgFOvLHYpPkgce9FC4CVYNzfQZNbw9jSseyc5iWlxYERNCqi7d+YvWTrw==@vger.kernel.org, AJvYcCXsHJ9TXZIoZbmucY85GVBV1ASTdOmfHsi+Yi0by2E5lpoEJ/cTO8aaNTZktA5/X9/aPenDdUJLRh58@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6EAzkRmW3v1yL4/HY1F0M8pXBvcww1McDn0+wKryhdIfvCgdL
	y2ck3czGSXxWNl7OpejWQbGjPumLsw3a+dztA0uVlbkeFkEjB3QEw8U5qtrC5EJxgfqhAdPkteD
	7t6vjCaSxX8Qw9s4Gqr5/2mkVB2c=
X-Google-Smtp-Source: AGHT+IFHyuVMJfRX+LH1ADbFA3lrsXi6u/znmWCgu9CsS0VrYIIqfhdEGEEkUG9HFqQt57EDJ1O3G2tk3hlTbddScqk=
X-Received: by 2002:a05:6870:d9b:b0:29e:6765:863a with SMTP id
 586e51a60fabf-29f7337262dmr1068638fac.24.1733470529881; Thu, 05 Dec 2024
 23:35:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206164155.3c80d28e.ddiss@suse.de>
In-Reply-To: <20241206164155.3c80d28e.ddiss@suse.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 6 Dec 2024 16:35:18 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8U-kQa5+fg4QvcUeOkAuX128v_VLxNz5=trF85ZONrYA@mail.gmail.com>
Message-ID: <CAKYAXd8U-kQa5+fg4QvcUeOkAuX128v_VLxNz5=trF85ZONrYA@mail.gmail.com>
Subject: Re: ksmbd: v6.13-rc1 WARNING at fs/attr.c:300 setattr_copy+0x1ee/0x200
To: David Disseldorp <ddiss@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, 
	"linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 2:42=E2=80=AFPM David Disseldorp <ddiss@suse.de> wro=
te:
>
> Hi Namjae,
Hi David,
>
> I'm hitting the following warning while running xfstests against a
> v6.13-rc1 ksmbd server:
Thanks for your report:)
>
> [  113.215316] ------------[ cut here ]------------
> [  113.215974] WARNING: CPU: 1 PID: 31 at fs/attr.c:300 setattr_copy+0x1e=
e/0x200
> [  113.216988] Modules linked in: btrfs blake2b_generic xor zlib_deflate =
raid6_pq zstd_decompress zstd_compress xxhash zstd_common ksmbd crc32_gener=
ic cifs_arc4 nls_ucs2_utis
> [  113.219192] CPU: 1 UID: 0 PID: 31 Comm: kworker/1:1 Not tainted 6.13.0=
-rc1+ #234
> [  113.220127] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
> [  113.221530] Workqueue: ksmbd-io handle_ksmbd_work [ksmbd]
> [  113.222220] RIP: 0010:setattr_copy+0x1ee/0x200
> [  113.222833] Code: 24 28 49 8b 44 24 30 48 89 53 58 89 43 6c 5b 41 5c 4=
1 5d 41 5e 41 5f 5d c3 cc cc cc cc 48 89 df e8 77 d6 ff ff e9 cd fe ff ff <=
0f> 0b e9 be fe ff ff 66 0
> [  113.225110] RSP: 0018:ffffaf218010fb68 EFLAGS: 00010202
> [  113.225765] RAX: 0000000000000120 RBX: ffffa446815f8568 RCX: 000000000=
0000003
> [  113.226667] RDX: ffffaf218010fd38 RSI: ffffa446815f8568 RDI: ffffffff9=
4eb03a0
> [  113.227531] RBP: ffffaf218010fb90 R08: 0000001a251e217d R09: 000000006=
75259fa
> [  113.228426] R10: 0000000002ba8a6d R11: ffffa4468196c7a8 R12: ffffaf218=
010fd38
> [  113.229304] R13: 0000000000000120 R14: ffffffff94eb03a0 R15: 000000000=
0000000
> [  113.230210] FS:  0000000000000000(0000) GS:ffffa44739d00000(0000) knlG=
S:0000000000000000
> [  113.231215] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  113.232055] CR2: 00007efe0053d27e CR3: 000000000331a000 CR4: 000000000=
00006b0
> [  113.232926] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [  113.233812] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [  113.234797] Call Trace:
> [  113.235116]  <TASK>
> [  113.235393]  ? __warn+0x73/0xd0
> [  113.235802]  ? setattr_copy+0x1ee/0x200
> [  113.236299]  ? report_bug+0xf3/0x1e0
> [  113.236757]  ? handle_bug+0x4d/0x90
> [  113.237202]  ? exc_invalid_op+0x13/0x60
> [  113.237689]  ? asm_exc_invalid_op+0x16/0x20
> [  113.238185]  ? setattr_copy+0x1ee/0x200
> [  113.238692]  btrfs_setattr+0x80/0x820 [btrfs]
> [  113.239285]  ? get_stack_info_noinstr+0x12/0xf0
> [  113.239857]  ? __module_address+0x22/0xa0
> [  113.240368]  ? handle_ksmbd_work+0x6e/0x460 [ksmbd]
> [  113.240993]  ? __module_text_address+0x9/0x50
> [  113.241545]  ? __module_address+0x22/0xa0
> [  113.242033]  ? unwind_next_frame+0x10e/0x920
> [  113.242600]  ? __pfx_stack_trace_consume_entry+0x10/0x10
> [  113.243268]  notify_change+0x2c2/0x4e0
> [  113.243746]  ? stack_depot_save_flags+0x27/0x730
> [  113.244339]  ? set_file_basic_info+0x130/0x2b0 [ksmbd]
> [  113.244993]  set_file_basic_info+0x130/0x2b0 [ksmbd]
> [  113.245613]  ? process_scheduled_works+0xbe/0x310
> [  113.246181]  ? worker_thread+0x100/0x240
> [  113.246696]  ? kthread+0xc8/0x100
> [  113.247126]  ? ret_from_fork+0x2b/0x40
> [  113.247606]  ? ret_from_fork_asm+0x1a/0x30
> [  113.248132]  smb2_set_info+0x63f/0xa70 [ksmbd]
>
>
> 284 static void setattr_copy_mgtime(struct inode *inode, const struct iat=
tr *attr)
> 285 {
> 286         unsigned int ia_valid =3D attr->ia_valid;
> 287         struct timespec64 now;
> 288
> 289         if (ia_valid & ATTR_CTIME) {
> 290                 /*
> 291                  * In the case of an update for a write delegation, w=
e must respect
> 292                  * the value in ia_ctime and not use the current time=
.
> 293                  */
> 294                 if (ia_valid & ATTR_DELEG)
> 295                         now =3D inode_set_ctime_deleg(inode, attr->ia=
_ctime);
> 296                 else
> 297                         now =3D inode_set_ctime_current(inode);
> 298         } else {
> 299                 /* If ATTR_CTIME isn't set, then ATTR_MTIME shouldn't=
 be either. */
> 300                 WARN_ON_ONCE(ia_valid & ATTR_MTIME);
>                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^--- here.
>
> Looking at smb2pdu.c:set_file_basic_info() it's easy enough to see how
> we can get here with !ATTR_CTIME alongside ATTR_MTIME.
>
> The following patch avoids the warning, but I'm not familiar with this
> code-path, so please let me know whether or not it makes sense:
mtime and atime will probably not be updated.
I will change it so that ATTR_CTIME is also set when changing mtime.
Thanks.
>
> --- a/fs/smb/server/smb2pdu.c
> +++ b/fs/smb/server/smb2pdu.c
> @@ -6013,7 +6013,7 @@ static int set_file_basic_info(struct ksmbd_file *f=
p,
>
>         if (file_info->LastAccessTime) {
>                 attrs.ia_atime =3D ksmbd_NTtimeToUnix(file_info->LastAcce=
ssTime);
> -               attrs.ia_valid |=3D (ATTR_ATIME | ATTR_ATIME_SET);
> +               attrs.ia_valid |=3D ATTR_ATIME_SET;
>         }
>
>         attrs.ia_valid |=3D ATTR_CTIME;
> @@ -6024,7 +6024,7 @@ static int set_file_basic_info(struct ksmbd_file *f=
p,
>
>         if (file_info->LastWriteTime) {
>                 attrs.ia_mtime =3D ksmbd_NTtimeToUnix(file_info->LastWrit=
eTime);
> -               attrs.ia_valid |=3D (ATTR_MTIME | ATTR_MTIME_SET);
> +               attrs.ia_valid |=3D ATTR_MTIME_SET;
>         }
>
>         if (file_info->Attributes) {

