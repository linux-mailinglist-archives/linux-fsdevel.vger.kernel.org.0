Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D5064E17F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Dec 2022 20:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiLOTDq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 14:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiLOTDo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:03:44 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25271DDDA
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 11:03:40 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1447c7aa004so424493fac.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 11:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wohv7z+JwiKe9cOdXdlsksxbRe2JPdyVdNu4qM2pQFk=;
        b=3QHNsfeablT/QpvK4owra201WL8bfWPIyQwzFrlg312b76F9trfEzDRD+MifUr1MrF
         SamkBUdZ3YlGpmkjSCiHyqPb2E8h86sVxeU+4aGgix4+K3T+DXm8NsTWG+ZbKUTiyI0h
         PStAmMw2CcNZZq6DoIBciAOu22olyz7++lG8qU9HyXFu75DjB7iJ8TNWHhW3Ke/YGndA
         NTomibt/STZ+39kBXokkq1hFRrHYop9PPRaQA7J8yzM6Mz5j2FLj8Iw43zxxtf7fkdko
         bMhy7QViKfFMTtEE7QEgz/Z6Krey2wDJ+k8r1nMuO5Y0V617ffqG2npC9dj0hb7Y9QeK
         qktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wohv7z+JwiKe9cOdXdlsksxbRe2JPdyVdNu4qM2pQFk=;
        b=5VQWOKJ0jwMDx0jx8oGRI7Ny3sZ53asF8HWexBHsR1oRFIZPcUqXCc4fX+8CrZkKJn
         dDfd6syI9MC90TgkT/HJdjAV1cyEVfCEX0pBH1hq4YywEeqZ+D52Ro/Gls+oyX4u498j
         s+wbIjResfnj8MeNOAu8g9NNJDR/dNhjB65za2wn8AJ+pBI8QmdOoe9YDHE44ilUCdlI
         9SJKP5wnLiS9LHIWbGLmOKQRdr/tL+TmV4vDx9772yZ4AwysX6/OwWp9PXxbQBgwo2rG
         3Hr5jQGnzuWeSeYVO8BD5LSjgffxvYjWLMVIYuF0X+SAEtMLwAlnb17yypSaCFQGwe6k
         yf8w==
X-Gm-Message-State: ANoB5pnfnVWQXysj6UpRU+bRZUStp9xr2HXbV48HU+//8bjXw1IhgQK/
        tqABNdoSbjuCLxKyN7LG+oDD0A==
X-Google-Smtp-Source: AA0mqf5oRgNsSl9cesnS1xYQ4/yGJCKqg8e95mw6mtK6RHBYnESLv4UzLTylktTHhliFzjngqO68wQ==
X-Received: by 2002:a05:6870:f29b:b0:143:d9f7:8127 with SMTP id u27-20020a056870f29b00b00143d9f78127mr14900062oap.42.1671131020108;
        Thu, 15 Dec 2022 11:03:40 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id f1-20020a05620a408100b006ecfb2c86d3sm12387368qko.130.2022.12.15.11.03.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Dec 2022 11:03:39 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v2 2/2] hfsplus: fix uninit-value in hfsplus_delete_cat()
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20221215081820.948990-3-chenxiaosong2@huawei.com>
Date:   Thu, 15 Dec 2022 11:03:34 -0800
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aditya Garg <gargaditya08@live.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jeff Layton <jlayton@kernel.org>, hannes@cmpxchg.org,
        "Theodore Y . Ts'o" <tytso@mit.edu>, muchun.song@linux.dev,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6258B9FC-0A00-46BC-9C6C-720963D58A06@dubeyko.com>
References: <20221215081820.948990-1-chenxiaosong2@huawei.com>
 <20221215081820.948990-3-chenxiaosong2@huawei.com>
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



> On Dec 15, 2022, at 12:18 AM, ChenXiaoSong <chenxiaosong2@huawei.com> =
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
> Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
> Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
> ---
> fs/hfsplus/super.c | 8 +-------
> 1 file changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index 122ed89ebf9f..5812818759dd 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -67,13 +67,7 @@ struct inode *hfsplus_iget(struct super_block *sb, =
unsigned long ino)
> 	if (!(inode->i_state & I_NEW))
> 		return inode;
>=20
> -	INIT_LIST_HEAD(&HFSPLUS_I(inode)->open_dir_list);
> -	spin_lock_init(&HFSPLUS_I(inode)->open_dir_lock);
> -	mutex_init(&HFSPLUS_I(inode)->extents_lock);
> -	HFSPLUS_I(inode)->flags =3D 0;
> -	HFSPLUS_I(inode)->extent_state =3D 0;
> -	HFSPLUS_I(inode)->rsrc_inode =3D NULL;
> -	atomic_set(&HFSPLUS_I(inode)->opencnt, 0);
> +	hfsplus_init_inode(HFSPLUS_I(inode));
>=20


Maybe, I am missing something. But where in the second version of the =
patch
initialization of subfolders?

Thanks,
Slava.

> 	if (inode->i_ino >=3D HFSPLUS_FIRSTUSER_CNID ||
> 	    inode->i_ino =3D=3D HFSPLUS_ROOT_CNID) {
> --=20
> 2.31.1
>=20

