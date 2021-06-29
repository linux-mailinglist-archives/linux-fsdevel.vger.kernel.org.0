Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573123B78B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 21:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbhF2Tee (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 15:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbhF2Tec (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 15:34:32 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6841C061760
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jun 2021 12:32:04 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id r14-20020a4ad4ce0000b029024b4146e2f5so5980867oos.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jun 2021 12:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NnGqF5i8LvWI4EhF9coOqefPqY2kcPhPYW+PqMZT3MI=;
        b=AkbnlocjnC9D/sMNkHUTlQe2l961wltIILRlW75VEZby9nkNErd0f3GilLrcB4o+Xk
         NBA8dsUIamjOMhh6JLoGP5/zQij1UUSqR5lFQeV2ICN6dPG2Bxm3k57/sHOwePkibIO3
         /9rwK3EHtYDgS7hmGQPnBHCqXOKlHAmNTF9yQEo7WmlbVpx9woJZWT/P6fAJmrpWfo5b
         Ha4kXdOtZQiI3Ypk4oiT1ZIT1/iFKA4FUoJjY9AgehKKSr++Ek5AE1DySFmlB6RBxW1k
         nk5xBbj0eqMZMWcMAXpPWxmkHJn8TSgfMRvirHiSPigg58hqE1Wsu86A8Mo9AmURbS+L
         QYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NnGqF5i8LvWI4EhF9coOqefPqY2kcPhPYW+PqMZT3MI=;
        b=tKuhJo5F8mAAbF+i+jxDi8xXMvrIz9rTpTUNDeESpB9oWhG4M1G5kVdhBkYLNc+vHC
         twYDi2zfqlDIRCVoqs5DVsyh/JwWDO8045+49HNGs7J/knZkBF7K+cqZPFUXD0kPEeD1
         a5fRCdg0I4UaJLK1QWeaa1yYiEp/5oZ2pCiTREx+hYmmNCnhkBGadGW9iJfdQWg8ob6C
         th4ze4GHbsdSBEuIF2IVfaKJHB1cOoHZdSI6YyYdrk9ljDg389KP8DOYYht2Ijsc2xOl
         SagijVkgDRFL1rkcb3+sTHNOzOQOYEhm6Is5Q4HGjYBivALdMZnqwpQof4D7XZm4Ezir
         RUMw==
X-Gm-Message-State: AOAM530YfaRSehLlrqmz6Qm22uqpJ9enfTcJdEh+tUoXm7eRBvHbs26V
        4ZM0MZX7gU5I+2pmFVudyqcJ2g==
X-Google-Smtp-Source: ABdhPJzMAoJNlT4cn96farSb/2+ZZVyAAujQ8xgfMZFGEYPL43QFmc07ld1kFpq0GFHajFV/ZsdXyA==
X-Received: by 2002:a4a:956f:: with SMTP id n44mr5400466ooi.54.1624995124003;
        Tue, 29 Jun 2021 12:32:04 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:f8e3:a853:8646:6bc8])
        by smtp.gmail.com with ESMTPSA id k14sm2522483oon.5.2021.06.29.12.32.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jun 2021 12:32:03 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH 2/3] hfs: fix high memory mapping in hfs_bnode_read
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20210629144803.62541-3-desmondcheongzx@gmail.com>
Date:   Tue, 29 Jun 2021 12:31:58 -0700
Cc:     gustavoars@kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4E2B2BE9-3C0F-4D99-A099-601A780E0CED@dubeyko.com>
References: <20210629144803.62541-1-desmondcheongzx@gmail.com>
 <20210629144803.62541-3-desmondcheongzx@gmail.com>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 29, 2021, at 7:48 AM, Desmond Cheong Zhi Xi =
<desmondcheongzx@gmail.com> wrote:
>=20
> Pages that we read in hfs_bnode_read need to be kmapped into kernel
> address space. However, currently only the 0th page is kmapped. If the
> given offset + length exceeds this 0th page, then we have an invalid
> memory access.
>=20
> To fix this, we use the same logic used  in hfsplus' version of
> hfs_bnode_read to kmap each page of relevant data that we copy.
>=20
> An example of invalid memory access occurring without this fix can be
> seen in the following crash report:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: use-after-free in memcpy =
include/linux/fortify-string.h:191 [inline]
> BUG: KASAN: use-after-free in hfs_bnode_read+0xc4/0xe0 =
fs/hfs/bnode.c:26
> Read of size 2 at addr ffff888125fdcffe by task syz-executor5/4634
>=20
> CPU: 0 PID: 4634 Comm: syz-executor5 Not tainted 5.13.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 01/01/2011
> Call Trace:
> __dump_stack lib/dump_stack.c:79 [inline]
> dump_stack+0x195/0x1f8 lib/dump_stack.c:120
> print_address_description.constprop.0+0x1d/0x110 mm/kasan/report.c:233
> __kasan_report mm/kasan/report.c:419 [inline]
> kasan_report.cold+0x7b/0xd4 mm/kasan/report.c:436
> check_region_inline mm/kasan/generic.c:180 [inline]
> kasan_check_range+0x154/0x1b0 mm/kasan/generic.c:186
> memcpy+0x24/0x60 mm/kasan/shadow.c:65
> memcpy include/linux/fortify-string.h:191 [inline]
> hfs_bnode_read+0xc4/0xe0 fs/hfs/bnode.c:26
> hfs_bnode_read_u16 fs/hfs/bnode.c:34 [inline]
> hfs_bnode_find+0x880/0xcc0 fs/hfs/bnode.c:365
> hfs_brec_find+0x2d8/0x540 fs/hfs/bfind.c:126
> hfs_brec_read+0x27/0x120 fs/hfs/bfind.c:165
> hfs_cat_find_brec+0x19a/0x3b0 fs/hfs/catalog.c:194
> hfs_fill_super+0xc13/0x1460 fs/hfs/super.c:419
> mount_bdev+0x331/0x3f0 fs/super.c:1368
> hfs_mount+0x35/0x40 fs/hfs/super.c:457
> legacy_get_tree+0x10c/0x220 fs/fs_context.c:592
> vfs_get_tree+0x93/0x300 fs/super.c:1498
> do_new_mount fs/namespace.c:2905 [inline]
> path_mount+0x13f5/0x20e0 fs/namespace.c:3235
> do_mount fs/namespace.c:3248 [inline]
> __do_sys_mount fs/namespace.c:3456 [inline]
> __se_sys_mount fs/namespace.c:3433 [inline]
> __x64_sys_mount+0x2b8/0x340 fs/namespace.c:3433
> do_syscall_64+0x37/0xc0 arch/x86/entry/common.c:47
> entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x45e63a
> Code: 48 c7 c2 bc ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 88 =
04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d =
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f9404d410d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000020000248 RCX: 000000000045e63a
> RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f9404d41120
> RBP: 00007f9404d41120 R08: 00000000200002c0 R09: 0000000020000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
> R13: 0000000000000003 R14: 00000000004ad5d8 R15: 0000000000000000
>=20
> The buggy address belongs to the page:
> page:00000000dadbcf3e refcount:0 mapcount:0 mapping:0000000000000000 =
index:0x1 pfn:0x125fdc
> flags: 0x2fffc0000000000(node=3D0|zone=3D2|lastcpupid=3D0x3fff)
> raw: 02fffc0000000000 ffffea000497f748 ffffea000497f6c8 =
0000000000000000
> raw: 0000000000000001 0000000000000000 00000000ffffffff =
0000000000000000
> page dumped because: kasan: bad access detected
>=20
> Memory state around the buggy address:
> ffff888125fdce80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ffff888125fdcf00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> ffff888125fdcf80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>                                                                ^
> ffff888125fdd000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ffff888125fdd080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> ---
> fs/hfs/bnode.c | 18 ++++++++++++++----
> 1 file changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> index b63a4df7327b..936cfa763224 100644
> --- a/fs/hfs/bnode.c
> +++ b/fs/hfs/bnode.c
> @@ -18,13 +18,23 @@
> void hfs_bnode_read(struct hfs_bnode *node, void *buf,
> 		int off, int len)
> {
> -	struct page *page;
> +	struct page **pagep;
> +	int l;
>=20
> 	off +=3D node->page_offset;
> -	page =3D node->page[0];
> +	pagep =3D node->page + (off >> PAGE_SHIFT);

I would like to have a check here that we are not out of the page array. =
Could you add this check?

Also, maybe, node->page[index] could look much safer here. What do you =
think?

> +	off &=3D ~PAGE_MASK;
>=20
> -	memcpy(buf, kmap(page) + off, len);
> -	kunmap(page);
> +	l =3D min_t(int, len, PAGE_SIZE - off);

Maybe, it makes sense to use more informative name of the variable =
instead of =E2=80=9Cl=E2=80=9D?

> +	memcpy(buf, kmap(*pagep) + off, l);

I suppose that it could be good to have a check that we do not overflow =
the buffer. How do you feel about it?

> +	kunmap(*pagep);

What=E2=80=99s about kmap_atomic/kunmap_atomic in this function?

Thanks,
Slava.

> +
> +	while ((len -=3D l) !=3D 0) {
> +		buf +=3D l;
> +		l =3D min_t(int, len, PAGE_SIZE);
> +		memcpy(buf, kmap(*++pagep), l);
> +		kunmap(*pagep);
> +	}
> }
>=20
> u16 hfs_bnode_read_u16(struct hfs_bnode *node, int off)
> --=20
> 2.25.1
>=20

