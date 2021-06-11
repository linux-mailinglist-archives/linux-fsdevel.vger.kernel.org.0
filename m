Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892113A41D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 14:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhFKMRe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 08:17:34 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:40828 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhFKMRd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 08:17:33 -0400
Received: by mail-pg1-f181.google.com with SMTP id j12so2300848pgh.7;
        Fri, 11 Jun 2021 05:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t1u9Kg4JMHG8AuyBxIOLDD49m8H3Xy4GHpaZKpkmPPE=;
        b=X2bCRW23R38/R7qKRQ27HLuaMpjp3uV6n99g8xbEE42zaHOSq+20YIQd6e6+D5uZht
         3Sujxd0Fbcas2ESLOsQkEWNpQhalPEDa9gdKoOQxALMkcbq920y68bmgjx6txTXzIWwi
         dGl4D/GfGfs1gigv1aKnERMQyb3k7v893U0AZ4BJ50IITNQYinYGXIFPDqqtLTp/gvAj
         jpY8d70t/x7jRUAJ855uCSTWnhO0yf6qJQrR+Exjtc8dPkOr8rep7sDGCAacp1soz2ks
         0efq2nOorRARULmr6bWr675aIA2VkuVzfF05jGuQuoOuoO1hxRaqK/KQ22KC2ZJGHCTX
         CvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t1u9Kg4JMHG8AuyBxIOLDD49m8H3Xy4GHpaZKpkmPPE=;
        b=QDEPIm2hGucs78lZP3TVSUC1cHPajNLHs/G/RMbvlYIvAZdubgxN5qcNt5TSB0os3N
         w+BSpzanl1qEsH/SVWEPD2nGe3q4sqJ+I0heZhIOAsSaYGoMsKXKltja8rVE8+M6nenv
         YrysBJ2x8udmt/72KPwCO7owEv7VNVc4AwEugZI77hXX+oR8lIU9SH8UXovBZKY2gxtw
         HoZIdSUMko1iU7CfalC6LbiQ0o/QiazMPSL2JAMelB1MF5QTNOoOIwrGa/yPrJCeH2OF
         OtIu79ysMI5vM6FlWXbXsbP7QfF1ZCvbJb7b2Q4Zuzecji9WzUoLPqLzMmv+5eSS1PbP
         WPMw==
X-Gm-Message-State: AOAM532I+mSq58kqJ4Abz9qnMqpHZPg7tr3BKqh7F3STFqFSML3BKNtk
        BUrgarLbpL+YPKBhrM1ukH7IUb5dYSN0olN+
X-Google-Smtp-Source: ABdhPJzgyzyqgVl2b/ngwnV1AWtEK/yQzt/fcL/EtZtlMjlSChNqZjdT0mRY8f7RBvTcNRh2QvTKMg==
X-Received: by 2002:a62:8204:0:b029:2ea:2647:bb4f with SMTP id w4-20020a6282040000b02902ea2647bb4fmr8020547pfd.23.1623413667705;
        Fri, 11 Jun 2021 05:14:27 -0700 (PDT)
Received: from mi-HP-ProDesk-600-G5-PCI-MT.mioffice.cn ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id iq15sm9970027pjb.53.2021.06.11.05.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 05:14:27 -0700 (PDT)
From:   chenguanyou <chenguanyou9338@gmail.com>
X-Google-Original-From: chenguanyou <chenguanyou@xiaomi.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        chenguanyou@xiaomi.com
Subject: Re:[PATCH] fuse: alloc_page nofs avoid deadlock
Date:   Fri, 11 Jun 2021 20:14:20 +0800
Message-Id: <20210611121420.31796-1-chenguanyou@xiaomi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAJfpegsEkRnU26Vvo4BTQUmx89Hahp6=RTuyEcPm=rqz8icwUQ@mail.gmail.com>
References: <CAJfpegsEkRnU26Vvo4BTQUmx89Hahp6=RTuyEcPm=rqz8icwUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PID: 9652 TASK: ffffffc0c9ce0000 CPU: 4 COMMAND: "kworker/u16:8"
#0 [ffffff802e793650] __switch_to at ffffff8008086a4c
#1 [ffffff802e7936c0] __schedule at ffffff80091ffe58
#2 [ffffff802e793720] schedule at ffffff8009200348
#3 [ffffff802e793770] __fuse_request_send at ffffff8008435760
#4 [ffffff802e7937b0] fuse_simple_request at ffffff8008435b14
#5 [ffffff802e793930] fuse_flush_times at ffffff800843a7a0
#6 [ffffff802e793950] fuse_write_inode at ffffff800843e4dc
#7 [ffffff802e793980] __writeback_single_inode at ffffff8008312740
#8 [ffffff802e793aa0] writeback_sb_inodes at ffffff80083117e4
#9 [ffffff802e793b00] __writeback_inodes_wb at ffffff8008311d98
#10 [ffffff802e793c00] wb_writeback at ffffff8008310cfc
#11 [ffffff802e793d00] wb_workfn at ffffff800830e4a8
#12 [ffffff802e793d90] process_one_work at ffffff80080e4fac
#13 [ffffff802e793e00] worker_thread at ffffff80080e5670
#14 [ffffff802e793e60] kthread at ffffff80080eb650

crash> p __writeback_single_inode
__writeback_single_inode = $119 =
{int (struct inode *, struct writeback_control *)} 0xffffff8008312040 <__writeback_single_inode>

0xffffff8008312040 <__writeback_single_inode>: stp x29, x30, [sp,#-96]!
0xffffff8008312044 <__writeback_single_inode+4>: stp x28, x27, [sp,#16]
0xffffff8008312048 <__writeback_single_inode+8>: stp x26, x25, [sp,#32]
0xffffff800831204c <__writeback_single_inode+12>: stp x24, x23, [sp,#48]
0xffffff8008312050 <__writeback_single_inode+16>: stp x22, x21, [sp,#64]
0xffffff8008312054 <__writeback_single_inode+20>: stp x20, x19, [sp,#80]
0xffffff8008312058 <__writeback_single_inode+24>: mov x29, sp

0xffffff8008311374 <writeback_sb_inodes>: sub sp, sp, #0x120
0xffffff8008311378 <writeback_sb_inodes+4>: stp x29, x30, [sp,#192]
0xffffff800831137c <writeback_sb_inodes+8>: stp x28, x27, [sp,#208]
0xffffff8008311380 <writeback_sb_inodes+12>: stp x26, x25, [sp,#224]
0xffffff8008311384 <writeback_sb_inodes+16>: stp x24, x23, [sp,#240]
0xffffff8008311388 <writeback_sb_inodes+20>: stp x22, x21, [sp,#256]
0xffffff800831138c <writeback_sb_inodes+24>: stp x20, x19, [sp,#272]
0xffffff8008311390 <writeback_sb_inodes+28>: add x29, sp, #0xc0

0xffffff80083117d8 <writeback_sb_inodes+1124>: add x1, sp, #0x60
0xffffff80083117dc <writeback_sb_inodes+1128>: mov x0, x27
0xffffff80083117e0 <writeback_sb_inodes+1132>: stp x21, xzr, [sp,#96]
0xffffff80083117e4 <writeback_sb_inodes+1136>: bl 0xffffff8008312040 <__writeback_single_inode>

x27 = inode，sp + 0x60 = writeback_control

#7 [ffffff802e793980] __writeback_single_inode at ffffff8008312740
ffffff802e793980: ffffff802e793aa0 ffffff80083117e8
ffffff802e793990: ffffffc0791dd1c8 ffffffc0791dd140

so : #7 [ffffff802e793980] __writeback_single_inode(0xffffffc0791dd140, 0xffffff802e793a40) at ffffff8008312740

crash> p __fuse_request_send
__fuse_request_send = $124 =
{void (struct fuse_conn *, struct fuse_req *)} 0xffffff8008435604 <__fuse_request_send>

0xffffff8008435604 <__fuse_request_send>: sub sp, sp, #0x70
0xffffff8008435608 <__fuse_request_send+4>: stp x29, x30, [sp,#48]
0xffffff800843560c <__fuse_request_send+8>: stp x24, x23, [sp,#64]
0xffffff8008435610 <__fuse_request_send+12>: stp x22, x21, [sp,#80]
0xffffff8008435614 <__fuse_request_send+16>: stp x20, x19, [sp,#96]
0xffffff8008435618 <__fuse_request_send+20>: add x29, sp, #0x3

0xffffff8008435b0c <fuse_simple_request+368>: mov x0, x19
0xffffff8008435b10 <fuse_simple_request+372>: mov x1, x20
0xffffff8008435b14 <fuse_simple_request+376>: bl 0xffffff8008435604 <__fuse_request_send>

x19 = fuse_conn，x20 = fuse_req

#3 [ffffff802e793770] __fuse_request_send at ffffff8008435760
ffffff802e793770: ffffff802e7937b0 ffffff8008435b18
ffffff802e793780: ffffffc0791dd1c8 ffffffc0c9ce0000
ffffff802e793790: ffffffc0c6feb1f8 ffffff802e7938b8
ffffff802e7937a0: ffffffc0c6feb148 ffffffc0901f2f80

#3 [ffffff802e793770] __fuse_request_send(0xffffffc0901f2f80, 0xffffffc0c6feb148) at ffffff8008435760

crash> struct -x fuse_req.flags ffffffc0c6feb148
flags = 0x9  = 0000 0000 1001  ===>> FR_WAITING | FR_ISREPLY

--------------------------------------------------------------------------------------------------------------------

PID: 17172 TASK: ffffffc0c162c000 CPU: 6 COMMAND: "Thread-21"
#0 [ffffff802d16b400] __switch_to at ffffff8008086a4c
#1 [ffffff802d16b470] __schedule at ffffff80091ffe58
#2 [ffffff802d16b4d0] schedule at ffffff8009200348
#3 [ffffff802d16b4f0] bit_wait at ffffff8009201098
#4 [ffffff802d16b510] __wait_on_bit at ffffff8009200a34
#5 [ffffff802d16b5b0] inode_wait_for_writeback at ffffff800830e1e8
#6 [ffffff802d16b5e0] evict at ffffff80082fb15c
#7 [ffffff802d16b620] iput at ffffff80082f9270
#8 [ffffff802d16b680] dentry_unlink_inode at ffffff80082f4c90
#9 [ffffff802d16b6a0] __dentry_kill at ffffff80082f1710
#10 [ffffff802d16b6d0] shrink_dentry_list at ffffff80082f1c34
#11 [ffffff802d16b750] prune_dcache_sb at ffffff80082f18a8
#12 [ffffff802d16b770] super_cache_scan at ffffff80082d55ac
#13 [ffffff802d16b860] shrink_slab at ffffff8008266170
#14 [ffffff802d16b900] shrink_node at ffffff800826b420
#15 [ffffff802d16b980] do_try_to_free_pages at ffffff8008268460
#16 [ffffff802d16ba60] try_to_free_pages at ffffff80082680d0
#17 [ffffff802d16bbe0] __alloc_pages_nodemask at ffffff8008256514
#18 [ffffff802d16bc60] fuse_copy_fill at ffffff8008438268
#19 [ffffff802d16bd00] fuse_dev_do_read at ffffff8008437654
#20 [ffffff802d16bdc0] fuse_dev_splice_read at ffffff8008436f40
#21 [ffffff802d16be60] sys_splice at ffffff8008315d18
#22 [ffffff802d16bff0] __sys_trace at ffffff8008084014

crash> p fuse_dev_do_read
fuse_dev_do_read = $259 = 
 {ssize_t (struct fuse_dev *, struct file *, struct fuse_copy_state *, size_t)} 0xffffff8008437170 <fuse_dev_do_read>

0xffffff8008437650 <fuse_dev_do_read+1248>: mov x0, x19
0xffffff8008437654 <fuse_dev_do_read+1252>: bl 0xffffff8008438110 <fuse_copy_fill>

0xffffff8008438110 <fuse_copy_fill>: sub sp, sp, #0x50
0xffffff8008438114 <fuse_copy_fill+4>: stp x29, x30, [sp,#32]
0xffffff8008438118 <fuse_copy_fill+8>: str x21, [sp,#48]
0xffffff800843811c <fuse_copy_fill+12>: stp x20, x19, [sp,#64]
0xffffff8008438120 <fuse_copy_fill+16>: add x29, sp, #0x20

#18 [ffffff802d16bc60] fuse_copy_fill at ffffff8008438268
ffffff802d16bc60: ffffff802d16bd00 ffffff8008437658
ffffff802d16bc70: 0000000000000028 ffffff8008437620
ffffff802d16bc80: ffffffc0901f2f80 ffffff802d16bd68   // fuse_copy_state

#4 [ffffff802d16bd00] fuse_dev_do_read(ffffffc0af775e00, ffffffc07ab65340, ffffff802d16bd68 ,0000000000021000) at ffffff8008437654

crash> struct -x fuse_copy_state ffffff802d16bd68
struct fuse_copy_state {
write = 0x1,
req = 0xffffffc0c6feb148,   // #3 [ffffff802e793770] __fuse_request_send(ffffffc0901f2f80, ffffffc0c6feb148) at ffffff8008435760
iter = 0x0, 
pipebufs = 0xffffffc0d1dd2000,
currbuf = 0x0,
pipe = 0xffffffc015bd7440,
nr_segs = 0x0,
pg = 0x0,
len = 0x0,
offset = 0x0,
move_pages = 0x0
}

0xffffff80082fb158 <evict+156>: mov x0, x19
0xffffff80082fb15c <evict+160>: bl 0xffffff800830e14c <inode_wait_for_writeback>

crash> p inode_wait_for_writeback
inode_wait_for_writeback = $107 =
{void (struct inode *)} 0xffffff800830e14c <inode_wait_for_writeback>

x19 = inode

crash> dis inode_wait_for_writeback
0xffffff800830e14c <inode_wait_for_writeback>: sub sp, sp, #0x80
0xffffff800830e150 <inode_wait_for_writeback+4>: stp x29, x30, [sp,#80]
0xffffff800830e154 <inode_wait_for_writeback+8>: stp x22, x21, [sp,#96]
0xffffff800830e158 <inode_wait_for_writeback+12>: stp x20, x19, [sp,#112]
0xffffff800830e15c <inode_wait_for_writeback+16>: add x29, sp, #0x50

#5 [ffffff802d16b5b0] inode_wait_for_writeback at ffffff800830e1e8
x19 = sp + 0x78 ===>>  x29 + 0x28 = ffffff802d16b5b0 + 0x28 = ffffff802d16b5d8

crash> rd ffffff802d16b5d8
ffffff802d16b5d8: ffffffc0791dd140 @..y.

crash> struct -x inode.i_state ffffffc0791dd140
i_state = 0xa0  = 1010 0000 = I_SYNC | I_FREEING

--------------------------------------------------------------------------------------------------------------------

                 9652                                                   17172
__fuse_request_send(ffffffc0901f2f80, ffffffc0c6feb148)
               ...                                              fuse_dev_do_read
	   	request_wait_answer   <<=========================				...
														|	|=> inode_wait_for_writeback
-----------------------------------------------------------------------------------------
 inode_sync_complete(0xffffffc0791dd140) ===============|==>| wake up 17172		
                                                        |
                                                        |<<== request_end(xxx, 0xffffffc0c6feb148) wake up 9652


static unsigned long super_cache_scan(struct shrinker *shrink,
                      struct shrink_control *sc)
{
    ...
    /*
     * Deadlock avoidance.  We may hold various FS locks, and we don't want
     * to recurse into the FS that called us in clear_inode() and friends..
     */
    if (!(sc->gfp_mask & __GFP_FS))   // page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
        return SHRINK_STOP;
	...
}

static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
                    nodemask_t *nodemask)
{
	...
    /*
     * If the caller cannot enter the filesystem, it's possible that it
     * is due to the caller holding an FS lock or performing a journal
     * transaction in the case of a filesystem like ext[3|4]. In this case,
     * it is not safe to block on pfmemalloc_wait as kswapd could be
     * blocked waiting on the same lock. Instead, throttle for up to a
     * second before continuing.
     */
    if (!(gfp_mask & __GFP_FS)) {
        wait_event_interruptible_timeout(pgdat->pfmemalloc_wait,
            allow_direct_reclaim(pgdat), HZ);

        goto check_pending;
    }

    /* Throttle until kswapd wakes the process */
    wait_event_killable(zone->zone_pgdat->pfmemalloc_wait,
        allow_direct_reclaim(pgdat));
	...
}

The fix will cause other problems?

Thanks,
Guanyou.Chen
