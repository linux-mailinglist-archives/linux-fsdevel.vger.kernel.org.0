Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E45B3B9531
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jul 2021 19:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbhGARG3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jul 2021 13:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhGARG2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jul 2021 13:06:28 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28E5C061762
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jul 2021 10:03:57 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id g13-20020a4ac4cd0000b029024c717ed8aeso1741918ooq.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Jul 2021 10:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mqySa9MjwQnU1bYm8as2WDDNqDRmJzoFqcDnym8p06M=;
        b=sD7W0qxR73U3cBQgRvVdLuQcslszCyRfIqoro4pNgSGccbAglf8K6VagW4MAxL0FGx
         eJWnFSF4U4MCWLAPJmJbcsJNOrnbd2O0dgiWpjwQdD2RGLcDHj9Jyi+SouaYUWISb1bh
         H+YduH0M1lMhOmVTXWUBJuaGDT/X2hHfVKA1yYkaZVpUO4m2LcuLK6BIN+lRsA+iU2jL
         aqw45Vp3Tsj8zH70BCI4CRTLG+wpIq3EIB8o72YWVZYSa370Kcpb+/m72XtPKY9lykVE
         fUeICU89WxzUA/0c2LraEr2LQYA3B/itg9GOvcAlqxGetRjCIt6CW5oD+PBhZprYqQ97
         AVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mqySa9MjwQnU1bYm8as2WDDNqDRmJzoFqcDnym8p06M=;
        b=iHjc9ZOrM8K+NMtkiMLsVRl+ISZZ2lqjGOaZn6nkpmoFrKs9avasUYbXVHdUI5Kp4C
         s4L29GFfwyt3sQ+1jkxXNhlFb5sopRRl1dotBRR7Qm/AyQodkRT3EcbkU9vugzP+Ny+/
         7m/gDMz4gMV/b5eJhKxY2Jcv80x0zIKFnJ4xKA+P9cLAl+zedTW07qYqZClKYzsCwNO4
         ctn4N/cbmwHFbpEBV2XB36MF4p3tKHRJwSVG4MOz526cXyf/mjAMaO/bRCR3T1IFwLam
         MCA2EmaV97E+oCNmzxkU3Qjl29GE37VLQYsx8Zbdzhl3wttONy4livdQabjwX8L1Inb0
         4cUQ==
X-Gm-Message-State: AOAM530Cjody0xvIQ12f5izWNU2qb/kbrMX20uRUPOu2mRf5cjZoVM64
        NzJ1rJec8Oa6pAEGwEh08JR6IA==
X-Google-Smtp-Source: ABdhPJwf0UGyCOyvBCUfUE1xu6FIhN3sHTl1RtJD7unMhXB7CnjbmxrWvyBjlvTmISqM6tBwg3MI7Q==
X-Received: by 2002:a4a:1a84:: with SMTP id 126mr690558oof.77.1625159037231;
        Thu, 01 Jul 2021 10:03:57 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:4d57:e39e:c32f:13d2])
        by smtp.gmail.com with ESMTPSA id l10sm57404oti.9.2021.07.01.10.03.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jul 2021 10:03:56 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v2 2/3] hfs: fix high memory mapping in hfs_bnode_read
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20210701030756.58760-3-desmondcheongzx@gmail.com>
Date:   Thu, 1 Jul 2021 10:03:55 -0700
Cc:     gustavoars@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <721882F7-4A7C-4405-8188-6DA0FDB59EC5@dubeyko.com>
References: <20210701030756.58760-1-desmondcheongzx@gmail.com>
 <20210701030756.58760-3-desmondcheongzx@gmail.com>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 30, 2021, at 8:07 PM, Desmond Cheong Zhi Xi =
<desmondcheongzx@gmail.com> wrote:
>=20
> Pages that we read in hfs_bnode_read need to be kmapped into kernel
> address space. However, currently only the 0th page is kmapped. If the
> given offset + length exceeds this 0th page, then we have an invalid
> memory access.
>=20
> To fix this, we kmap relevant pages one by one and copy their relevant
> portions of data.
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
> fs/hfs/bnode.c | 25 ++++++++++++++++++++-----
> 1 file changed, 20 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> index b63a4df7327b..c0a73a6ffb28 100644
> --- a/fs/hfs/bnode.c
> +++ b/fs/hfs/bnode.c
> @@ -15,16 +15,31 @@
>=20
> #include "btree.h"
>=20
> -void hfs_bnode_read(struct hfs_bnode *node, void *buf,
> -		int off, int len)
> +void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int =
len)
> {
> 	struct page *page;
> +	int pagenum;
> +	int bytes_read;
> +	int bytes_to_read;
> +	void *vaddr;
>=20
> 	off +=3D node->page_offset;
> -	page =3D node->page[0];
> +	pagenum =3D off >> PAGE_SHIFT;
> +	off &=3D ~PAGE_MASK; /* compute page offset for the first page =
*/
>=20
> -	memcpy(buf, kmap(page) + off, len);
> -	kunmap(page);
> +	for (bytes_read =3D 0; bytes_read < len; bytes_read +=3D =
bytes_to_read) {
> +		if (pagenum >=3D node->tree->pages_per_bnode)
> +			break;
> +		page =3D node->page[pagenum];
> +		bytes_to_read =3D min_t(int, len - bytes_read, PAGE_SIZE =
- off);
> +
> +		vaddr =3D kmap_atomic(page);
> +		memcpy(buf + bytes_read, vaddr + off, bytes_to_read);
> +		kunmap_atomic(vaddr);
> +
> +		pagenum++;
> +		off =3D 0; /* page offset only applies to the first page =
*/
> +	}
> }
>=20
> u16 hfs_bnode_read_u16(struct hfs_bnode *node, int off)
> --=20
> 2.25.1
>=20

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.=
