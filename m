Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F519201D03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 23:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgFSVSC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 17:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgFSVR7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 17:17:59 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857DBC0613EE
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2020 14:17:59 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id e11so1082587qkm.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2020 14:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=7LDyKEvDCeK2bTQvEW6e6Y00tldHJdl97MvgL72D8lU=;
        b=JhPbHfNoAxbxaeCzu4kNk88Us/qBlnq+wJARFPqlXb8zmfT6PmFJO1JlVezgGW8eX4
         lSBY8MkGimS4T4FiueJLLipjRdne/5FAPk9ZCgroQFsQUj7i4TvJs4Db5mFPjN0zV1qp
         1ce/In3rWAtvv/ojP7pMUYXToOxopZQj8KUoGtFPe62hTKPqGzGTp0JF2Hwwhfh0UFyZ
         xhKfNWjyNuSm1RlItYJXvKxZENrDVdSWEosWmzhht4VKWbFjJcw8NwTNpNk54UX/PTiR
         qfoLJ7UoEal+OmAZNDuHLREhxT2ldJRfJ2+EwOJrXSZS1YRBvlf2tZ+ykOteU8WzGkBE
         9qUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=7LDyKEvDCeK2bTQvEW6e6Y00tldHJdl97MvgL72D8lU=;
        b=Cw+KyR7h0L7rxsjtgEY20VwRltmnPVwas/dwGg+N2F052dxDB7AkpdYDdi+R7G+7rO
         y6arx2uRn9+XK8VLrCZXtzpI0wdq5oYpuu2VLv86yyK9SBZnV3wnYnAjaYdM/fEZu6bN
         7H++qONYNL1Jf68xMCS64m+GbzJz6qOGv9VI+gMO2d8Cl6K8Lw4ncvWnW0kpTEu3O8uJ
         vbmyK2wvYd1v40y6g8v8FuiAM7nu3ee0XypgX4NETrhZ2yT5d5UhulRdx0HCtympZBl7
         V4GXWPSxnNNg+7SO89GJpQ4OY+j6gTnIIJfdYMCSpqc975Hc37o0f3YNDB+qVW8Zu4aW
         S5cQ==
X-Gm-Message-State: AOAM532m/w2Z6jgBafDGlEvJdrKobh7Tp2Id1l1wGqacuBCvHdYbNAfx
        nw3mZrb/o8kUYeuBU3+2syNB1w==
X-Google-Smtp-Source: ABdhPJylwa7XlbxV5B8JvGdBABT6AOYPssAJiJyBXJ2EBIQ4LyHLUbQAUwYSHCBrWDXeMC8Ip/edKg==
X-Received: by 2002:a37:8f46:: with SMTP id r67mr5531888qkd.312.1592601477657;
        Fri, 19 Jun 2020 14:17:57 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id f203sm1244457qke.135.2020.06.19.14.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 14:17:57 -0700 (PDT)
Date:   Fri, 19 Jun 2020 17:17:50 -0400
From:   Qian Cai <cai@lca.pw>
To:     darrick.wong@oracle.com, hch@infradead.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: WARN_ON_ONCE(1) in iomap_dio_actor()
Message-ID: <20200619211750.GA1027@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Running a syscall fuzzer by a normal user could trigger this,

[55649.329999][T515839] WARNING: CPU: 6 PID: 515839 at fs/iomap/direct-io.c:391 iomap_dio_actor+0x29c/0x420
[55649.339490][T515839] Modules linked in: vfio_pci vfio_virqfd vfio_iommu_type1 vfio processor efivarfs ip_tables x_tables sd_mod mlx5_core ahci firmware_class libahci libata dm_mirror dm_region_hash dm_log dm_mod
[55649.358315][T515839] CPU: 6 PID: 515839 Comm: trinity-c21 Not tainted 5.8.0-rc1-next-20200618 #1
[55649.367100][T515839] Hardware name: HPE Apollo 70             /C01_APACHE_MB         , BIOS L50_5.13_1.11 06/18/2019
[55649.377624][T515839] pstate: 80400009 (Nzcv daif +PAN -UAO BTYPE=--)
[55649.383987][T515839] pc : iomap_dio_actor+0x29c/0x420
[55649.389040][T515839] lr : iomap_apply+0x31c/0x14e8
[55649.393830][T515839] sp : ffff00953540f670
[55649.397925][T515839] x29: ffff00953540f670 x28: 0000000000000000
[55649.404022][T515839] x27: ffff00953540f7b0 x26: ffffa00012113000
[55649.410119][T515839] x25: 000000000000d904 x24: ffffa00011553400
[55649.416216][T515839] x23: ffff0095c49d1288 x22: ffff0095c49d1288
[55649.422313][T515839] x21: 0000000000000080 x20: 000000000000d904
[55649.428416][T515839] x19: ffff0088f9ad9b80 x18: 0000000000000000
[55649.434516][T515839] x17: 0000000000000000 x16: 0000000000000000
[55649.440613][T515839] x15: 0000000000000000 x14: 0000000000000022
[55649.446709][T515839] x13: ffff80113ef86764 x12: 1fffe0113ef86763
[55649.452808][T515839] x11: 1fffe0113ef86763 x10: ffff80113ef86763
[55649.458913][T515839] x9 : dfffa00000000000 x8 : ffff0089f7c33b1b
[55649.465034][T515839] x7 : 0000000000000001 x6 : dfffa00000000000
[55649.471144][T515839] x5 : ffff00953540f7c8 x4 : ffff00953540f7b0
[55649.477248][T515839] x3 : ffff0088f9ad9b80 x2 : 0000000000000001
[55649.483346][T515839] x1 : 0000000000000001 x0 : ffff0095c49d1288
[55649.489452][T515839] Call trace:
[55649.492700][T515839]  iomap_dio_actor+0x29c/0x420
[55649.497411][T515839]  iomap_apply+0x31c/0x14e8
iomap_apply at fs/iomap/apply.c:80 (discriminator 4)
[55649.501860][T515839]  iomap_dio_rw+0x600/0xb60
iomap_dio_rw at fs/iomap/direct-io.c:503
[55649.506312][T515839]  xfs_file_dio_aio_read+0x204/0x7a0
xfs_file_dio_aio_read at fs/xfs/xfs_file.c:186
[55649.511543][T515839]  xfs_file_read_iter+0x3f0/0x628
xfs_file_read_iter at fs/xfs/xfs_file.c:260
[55649.516514][T515839]  new_sync_read+0x300/0x4f0
call_read_iter at include/linux/fs.h:1920 (discriminator 1)
(inlined by) new_sync_read at fs/read_write.c:415 (discriminator 1)
[55649.521051][T515839]  __vfs_read+0x88/0xe8
__vfs_read at fs/read_write.c:431
[55649.525152][T515839]  vfs_read+0xd8/0x228
[55649.529167][T515839]  ksys_pread64+0x110/0x158
[55649.533614][T515839]  __arm64_sys_pread64+0x84/0xc0
[55649.538498][T515839]  do_el0_svc+0x124/0x220
[55649.542771][T515839]  el0_sync_handler+0x260/0x408
[55649.547565][T515839]  el0_sync+0x140/0x180
[55649.551662][T515839] irq event stamp: 257496
[55649.555941][T515839] hardirqs last  enabled at (257495): [<ffffa000107185ec>] free_unref_page_list+0x5ec/0x940
[55649.565951][T515839] hardirqs last disabled at (257496): [<ffffa0001020c154>] do_debug_exception+0x304/0x524
[55649.575783][T515839] softirqs last  enabled at (256808): [<ffffa000101e1b38>] efi_header_end+0xb38/0x1204
[55649.585355][T515839] softirqs last disabled at (256801): [<ffffa000102c046c>] irq_exit+0x2dc/0x3d0

371 static loff_t
372 iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
373                 void *data, struct iomap *iomap, struct iomap *srcmap)
374 {
375         struct iomap_dio *dio = data;
376
377         switch (iomap->type) {
378         case IOMAP_HOLE:
379                 if (WARN_ON_ONCE(dio->flags & IOMAP_DIO_WRITE))
380                         return -EIO;
381                 return iomap_dio_hole_actor(length, dio);
382         case IOMAP_UNWRITTEN:
383                 if (!(dio->flags & IOMAP_DIO_WRITE))
384                         return iomap_dio_hole_actor(length, dio);
385                 return iomap_dio_bio_actor(inode, pos, length, dio, iomap);
386         case IOMAP_MAPPED:
387                 return iomap_dio_bio_actor(inode, pos, length, dio, iomap);
388         case IOMAP_INLINE:
389                 return iomap_dio_inline_actor(inode, pos, length, dio, iomap);
390         default:
391                 WARN_ON_ONCE(1);
392                 return -EIO;
393         }
394 }

Could that be iomap->type == IOMAP_DELALLOC ? Looking throught the logs,
it contains a few pread64() calls until this happens,

[child21:124180] [17] pread64(fd=353, buf=0x0, count=0x59b5, pos=0xe0e0e0e) = -1 (Illegal seek)
[child21:124180] [339] pread64(fd=339, buf=0xffffbcc40000, count=0xbd71, pos=0xff26) = -1 (Illegal seek)
[child21:124627] [136] pread64(fd=69, buf=0xffffbd290000, count=0xee42, pos=2) = -1 (Illegal seek)
[child21:124627] [196] pread64(fd=83, buf=0x1, count=0x62f8, pos=0x15390000) = -1 (Illegal seek)
[child21:125127] [154] pread64(fd=345, buf=0xffffbcc40000, count=9332, pos=0xffbd) = 9332
[child21:125169] [188] pread64(fd=69, buf=0xffffbce90000, count=0x4d47, pos=0) = -1 (Illegal seek)
[child21:125169] [227] pread64(fd=345, buf=0x1, count=0xe469, pos=1046) = -1 (Bad address)
[child21:125569] [354] pread64(fd=87, buf=0xffffbcc50000, count=0x4294, pos=0x16161616) = -1 (Illegal seek)
[child21:125569] [655] pread64(fd=341, buf=0xffffbcc70000, count=2210, pos=0xffff) = -1 (Illegal seek)
[child21:125569] [826] pread64(fd=343, buf=0x8, count=0xeb22, pos=0xc090c202e598b) = 0
[child21:126233] [261] pread64(fd=338, buf=0xffffbcc40000, count=0xe8fe, pos=105) = -1 (Illegal seek)
[child21:126233] [275] pread64(fd=190, buf=0x8, count=0x9c24, pos=116) = -1 (Is a directory)
[child21:126882] [32] pread64(fd=86, buf=0xffffbcc40000, count=0x7fc2, pos=2) = -1 (Illegal seek)
[child21:127448] [14] pread64(fd=214, buf=0x4, count=11371, pos=0x9b26) = 0
[child21:127489] [70] pread64(fd=339, buf=0xffffbcc70000, count=0xb07a, pos=8192) = -1 (Illegal seek)
[child21:127489] [80] pread64(fd=339, buf=0x0, count=6527, pos=205) = -1 (Illegal seek)
[child21:127489] [245] pread64(fd=69, buf=0x8, count=0xbba2, pos=47) = -1 (Illegal seek)
[child21:128098] [334] pread64(fd=353, buf=0xffffbcc90000, count=0x4540, pos=168) = -1 (Illegal seek)
[child21:129079] [157] pread64(fd=422, buf=0x0, count=0x80df, pos=0xdfef6378b650aa) = 0
[child21:134700] [275] pread64(fd=397, buf=0xffffbcc50000, count=0xdee6, pos=0x887b1e74a2) = -1 (Illegal seek)
[child21:135042] [7] pread64(fd=80, buf=0x8, count=0xc494, pos=216) = -1 (Illegal seek)
[child21:135056] [188] pread64(fd=430, buf=0xffffbd090000, count=0xbe66, pos=0x3a3a3a3a) = -1 (Illegal seek)
[child21:135442] [143] pread64(fd=226, buf=0xffffbd390000, count=11558, pos=0x1000002d) = 0
[child21:135513] [275] pread64(fd=69, buf=0x4, count=4659, pos=0x486005206c2986) = -1 (Illegal seek)
[child21:135513] [335] pread64(fd=339, buf=0xffffbd090000, count=0x90fd, pos=253) = -1 (Illegal seek)
[child21:135513] [392] pread64(fd=76, buf=0xffffbcc40000, count=0xf324, pos=0x5d5d5d5d) = -1 (Illegal seek)
[child21:135665] [5] pread64(fd=431, buf=0xffffbcc70000, count=10545, pos=16384) = -1 (Illegal seek)
[child21:135665] [293] pread64(fd=349, buf=0x4, count=0xd2ad, pos=0x2000000) = -1 (Illegal seek)
[child21:135790] [99] pread64(fd=76, buf=0x8, count=0x70d7, pos=0x21000440) = -1 (Illegal seek)
[child21:135790] [149] pread64(fd=70, buf=0xffffbd5b0000, count=0x53f3, pos=255) = -1 (Illegal seek)
[child21:135790] [301] pread64(fd=348, buf=0x4, count=5713, pos=0x6c00401a) = -1 (Illegal seek)
[child21:136162] [570] pread64(fd=435, buf=0x1, count=11182, pos=248) = -1 (Illegal seek)
[child21:136162] [584] pread64(fd=78, buf=0xffffbcc40000, count=0xa401, pos=8192) = -1 (Illegal seek)
[child21:138090] [167] pread64(fd=339, buf=0x4, count=0x6aba, pos=256) = -1 (Illegal seek)
[child21:138090] [203] pread64(fd=348, buf=0xffffbcc90000, count=0x8625, pos=128) = -1 (Illegal seek)
[child21:138551] [174] pread64(fd=426, buf=0x0, count=0xd582, pos=0xd7e8674d0a86) = 0
[child21:138551] [179] pread64(fd=426, buf=0xffffbce90000, count=0x415a, pos=0x536e873600750b2d) = 0
[child21:138988] [306] pread64(fd=436, buf=0x8, count=0x62e6, pos=0x445c403204924c1) = -1 (Illegal seek)
[child21:138988] [353] pread64(fd=427, buf=0x4, count=0x993b, pos=176) = 0
