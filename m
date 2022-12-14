Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B742F64CFFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Dec 2022 20:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237464AbiLNTTC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Dec 2022 14:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239190AbiLNTSo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Dec 2022 14:18:44 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0C92B625
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Dec 2022 11:18:18 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id cg5so3278444qtb.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Dec 2022 11:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyIMB4aEXbSB/ScB2Z9iWYKFxuCY76NBvLKj0Z9Cka8=;
        b=lqVQ04g+K8H0vQxnHcPEdP0C8ZtjVr94RzJUqtsq6gCo8F0KEKdnd5us4urq3FADUE
         SHp0jzKfwNPNmj2EC1hKU6sesci1Y31JqlPkJmq1RkImcw4USFqVulx8nvA1UU3ztibc
         XNviS3yO9XTrX60oOEZhB42pcBzjbdatOqQG5lTJKc89ZuOYq8avkrRODG5KOz47mrbz
         4eFWv5Us+85f2enJ0/Qm6Ldids0pj8PwL9iVqTd/UWMLptdsT/hPK4mcHwx10bnaMmjL
         XxOsovwM2TiQ7g4DIoLz2JBUJW4tgYTr+KfJgj6YOKj8vVd64bOjqeYetWe+vr1ofZYl
         c0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QyIMB4aEXbSB/ScB2Z9iWYKFxuCY76NBvLKj0Z9Cka8=;
        b=lDDnNPko19QJ/NwsDy93dLrOmXP4TMQaZLFLBKL8wTju0dCceZZ6SawxrAWpXTlMgy
         ayBhzBnOA6jftJzsGoHmv/0RL52YJpPDaC+VsqfhxneFGFhUaM0+xjos6kR0sq9SB6zf
         blNvdYIgLis2BzwLNpTsdKbh2homyd/86bgnkWXFxyaBvgD2UpKPrVRwWMTO05wBdZUf
         pEgnFcpU73bwur00hlDzkaNSNScKh1kbXBiiyoDhfT36PCwwFr5ycCyVj+sZ2QjLgZLr
         9zf7KsT+8ZBEjS8vt7bSk9dGr0MjFtdTTmlWxZXRfwcF3zpy7JWz/aOP+eo4m4zALfeS
         sPdw==
X-Gm-Message-State: ANoB5pnkTNkk+rxP+9QiDC43ihxU6nPsDvrtKo0M7Lt0ZMRz0GBErt+4
        IWsvM82C5XkL3OOwXi+TIUHQ3Q==
X-Google-Smtp-Source: AA0mqf6X0Y/BkSyGzWCp0VIlRyouMIyhiy8Ec9HnM6lvFzcvoh5fTt/W+N7JigU0Ax3eab/Yu4VVbA==
X-Received: by 2002:a05:622a:4d89:b0:3a5:c024:7ed4 with SMTP id ff9-20020a05622a4d8900b003a5c0247ed4mr12046055qtb.17.1671045497992;
        Wed, 14 Dec 2022 11:18:17 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id ca20-20020a05622a1f1400b003a5fb681ae7sm2182617qtb.3.2022.12.14.11.18.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Dec 2022 11:18:17 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] hfsplus: fix uninit-value in hfsplus_delete_cat()
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20221214103707.3893954-1-chenxiaosong2@huawei.com>
Date:   Wed, 14 Dec 2022 11:18:14 -0800
Cc:     roman.gushchin@linux.dev, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0A20C187-6B3E-4C97-8D5C-6AE066781B6E@dubeyko.com>
References: <20221214103707.3893954-1-chenxiaosong2@huawei.com>
To:     ChenXiaoSong <chenxiaosong2@huawei.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Dec 14, 2022, at 2:37 AM, ChenXiaoSong <chenxiaosong2@huawei.com> =
wrote:
>=20
> Syzkaller reported BUG as follows:
>=20
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>  BUG: KMSAN: uninit-value in hfsplus_subfolders_dec
>                              fs/hfsplus/catalog.c:248 [inline]
>  BUG: KMSAN: uninit-value in hfsplus_delete_cat+0x1207/0x14d0
>                              fs/hfsplus/catalog.c:419
>   hfsplus_subfolders_dec fs/hfsplus/catalog.c:248 [inline]
>   hfsplus_delete_cat+0x1207/0x14d0 fs/hfsplus/catalog.c:419
>   hfsplus_rmdir+0x141/0x3d0 fs/hfsplus/dir.c:425
>   hfsplus_rename+0x102/0x2e0 fs/hfsplus/dir.c:545
>   vfs_rename+0x1e4c/0x2800 fs/namei.c:4779
>   do_renameat2+0x173d/0x1dc0 fs/namei.c:4930
>   __do_sys_renameat2 fs/namei.c:4963 [inline]
>   __se_sys_renameat2 fs/namei.c:4960 [inline]
>   __ia32_sys_renameat2+0x14b/0x1f0 fs/namei.c:4960
>   do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
>   __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
>   do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
>   do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
>   entry_SYSENTER_compat_after_hwframe+0x70/0x82
>=20
>  Uninit was stored to memory at:
>   hfsplus_subfolders_inc fs/hfsplus/catalog.c:232 [inline]
>   hfsplus_create_cat+0x19e3/0x19f0 fs/hfsplus/catalog.c:314
>   hfsplus_mknod+0x1fd/0x560 fs/hfsplus/dir.c:494
>   hfsplus_mkdir+0x54/0x60 fs/hfsplus/dir.c:529
>   vfs_mkdir+0x62a/0x870 fs/namei.c:4036
>   do_mkdirat+0x466/0x7b0 fs/namei.c:4061
>   __do_sys_mkdirat fs/namei.c:4076 [inline]
>   __se_sys_mkdirat fs/namei.c:4074 [inline]
>   __ia32_sys_mkdirat+0xc4/0x120 fs/namei.c:4074
>   do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
>   __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
>   do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
>   do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
>   entry_SYSENTER_compat_after_hwframe+0x70/0x82
>=20
>  Uninit was created at:
>   __alloc_pages+0x9f1/0xe80 mm/page_alloc.c:5581
>   alloc_pages+0xaae/0xd80 mm/mempolicy.c:2285
>   alloc_slab_page mm/slub.c:1794 [inline]
>   allocate_slab+0x1b5/0x1010 mm/slub.c:1939
>   new_slab mm/slub.c:1992 [inline]
>   ___slab_alloc+0x10c3/0x2d60 mm/slub.c:3180
>   __slab_alloc mm/slub.c:3279 [inline]
>   slab_alloc_node mm/slub.c:3364 [inline]
>   slab_alloc mm/slub.c:3406 [inline]
>   __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
>   kmem_cache_alloc_lru+0x6f3/0xb30 mm/slub.c:3429
>   alloc_inode_sb include/linux/fs.h:3125 [inline]
>   hfsplus_alloc_inode+0x56/0xc0 fs/hfsplus/super.c:627
>   alloc_inode+0x83/0x440 fs/inode.c:259
>   iget_locked+0x2a1/0xe20 fs/inode.c:1286
>   hfsplus_iget+0x5f/0xb60 fs/hfsplus/super.c:64
>   hfsplus_btree_open+0x13b/0x1cf0 fs/hfsplus/btree.c:150
>   hfsplus_fill_super+0x12b0/0x2a80 fs/hfsplus/super.c:473
>   mount_bdev+0x508/0x840 fs/super.c:1401
>   hfsplus_mount+0x49/0x60 fs/hfsplus/super.c:641
>   legacy_get_tree+0x10c/0x280 fs/fs_context.c:610
>   vfs_get_tree+0xa1/0x500 fs/super.c:1531
>   do_new_mount+0x694/0x1580 fs/namespace.c:3040
>   path_mount+0x71a/0x1eb0 fs/namespace.c:3370
>   do_mount fs/namespace.c:3383 [inline]
>   __do_sys_mount fs/namespace.c:3591 [inline]
>   __se_sys_mount+0x734/0x840 fs/namespace.c:3568
>   __ia32_sys_mount+0xdf/0x140 fs/namespace.c:3568
>   do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
>   __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
>   do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
>   do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
>   entry_SYSENTER_compat_after_hwframe+0x70/0x82
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>=20
> Fix this by initializing 'subfolders' of 'struct hfsplus_inode_info'
> in hfsplus_iget().
>=20
> Link: =
https://syzkaller.appspot.com/bug?id=3D981f82f21b973f2f5663dfea581ff8cee1d=
dfef2
> Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
> ---
> fs/hfsplus/super.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index 122ed89ebf9f..612c07857667 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -72,6 +72,7 @@ struct inode *hfsplus_iget(struct super_block *sb, =
unsigned long ino)
> 	mutex_init(&HFSPLUS_I(inode)->extents_lock);
> 	HFSPLUS_I(inode)->flags =3D 0;
> 	HFSPLUS_I(inode)->extent_state =3D 0;
> +	HFSPLUS_I(inode)->subfolders =3D 0;
> 	HFSPLUS_I(inode)->rsrc_inode =3D NULL;
> 	atomic_set(&HFSPLUS_I(inode)->opencnt, 0);
>=20

Looks good. Thanks for the fix.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

But we have more fields in struct hfsplus_inode_info:

struct hfsplus_inode_info {=09
atomic_t opencnt;
/*
 * Extent allocation information, protected by extents_lock.
 */
u32 first_blocks;=09
u32 clump_blocks;
u32 alloc_blocks;
u32 cached_start;
u32 cached_blocks;
hfsplus_extent_rec first_extents;
hfsplus_extent_rec cached_extents;
unsigned int extent_state;
struct mutex extents_lock;
/*
 * Immutable data.
 */=09
struct inode *rsrc_inode;=09
__be32 create_date;
/*
 * Protected by sbi->vh_mutex.
 */=09
u32 linkid;=09
/*
 * Accessed using atomic bitops.
 */=09
unsigned long flags;=09
/*
 * Protected by i_mutex.
 */=09
sector_t fs_blocks;=09
u8 userflags;		/* BSD user file flags */
u32 subfolders;		/* Subfolder count (HFSX only) */
struct list_head open_dir_list;
spinlock_t open_dir_lock;
loff_t phys_size;
struct inode vfs_inode;
};

I believe we need to set initialized more fields in hfsplus_iget() =
method.
Could you add the initialization of other missed fields?

Thanks,
Slava.

> --=20
> 2.31.1
>=20

