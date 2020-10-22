Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD31295586
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 02:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507514AbgJVAa2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 20:30:28 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:42471 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2507509AbgJVAa2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 20:30:28 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-oIN6swO4Mbe1CG0iD4HOOw-1; Wed, 21 Oct 2020 20:30:21 -0400
X-MC-Unique: oIN6swO4Mbe1CG0iD4HOOw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46CC91074659;
        Thu, 22 Oct 2020 00:30:20 +0000 (UTC)
Received: from ovpn-66-201.rdu2.redhat.com (ovpn-66-201.rdu2.redhat.com [10.10.66.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DAB219C4F;
        Thu, 22 Oct 2020 00:30:18 +0000 (UTC)
Message-ID: <645a3f332f37e09057c10bc32f4f298ce56049bb.camel@lca.pw>
Subject: kernel BUG at mm/page-writeback.c:2241 [
 BUG_ON(PageWriteback(page); ]
From:   Qian Cai <cai@lca.pw>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-mm@kvack.org
Date:   Wed, 21 Oct 2020 20:30:18 -0400
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cai@lca.pw
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: lca.pw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Today's linux-next starts to trigger this wondering if anyone has any clue.

[ 9765.086947][T48578] LTP: starting iogen01 (export LTPROOT; rwtest -N iogen01 -i 120s -s read,write -Da -Dv -n 2 500b:$TMPDIR/doio.f1.$$ 1000b:$TMPDIR/doio.f2.$$)
[ 9839.423703][T97227] ------------[ cut here ]------------
[ 9839.429819][T97227] kernel BUG at mm/page-writeback.c:2241!
[ 9839.435459][T97227] invalid opcode: 0000 [#1] SMP KASAN PTI
[ 9839.441066][T97227] CPU: 56 PID: 97227 Comm: doio Tainted: G          IO      5.9.0-next-20201021 #1
[ 9839.450251][T97227] Hardware name: HPE ProLiant DL560 Gen10/ProLiant DL560 Gen10, BIOS U34 11/13/2019
[ 9839.459532][T97227] RIP: 0010:write_cache_pages+0x95f/0xeb0
[ 9839.465137][T97227] Code: 03 80 3c 02 00 0f 85 e5 04 00 00 49 8b 46 08 48 c7 c6 40 fb ca 9c 48 8d 50 ff a8 01 4c 0f 45 f2 4c 89 f7 e8 33 e3 08 00 0f 0b <0f> 0b 3d 00 00 08 00 0f 84 c3 00 00 00 48 8b 54 24 30 48 c1 ea 03
[ 9839.484715][T97227] RSP: 0018:ffffc9003063f610 EFLAGS: 00010282
[ 9839.490672][T97227] RAX: 01bfffc00000803f RBX: ffffea0024e68500 RCX: ffffffff9b8d232e
[ 9839.498547][T97227] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffea0024e68500
[ 9839.506422][T97227] RBP: ffffc9003063f708 R08: fffff940049cd0a1 R09: fffff940049cd0a1
[ 9839.514297][T97227] R10: ffffea0024e68507 R11: fffff940049cd0a0 R12: ffffc9003063fa20
[ 9839.522171][T97227] R13: ffffea0024e68500 R14: ffffea0024e68500 R15: dffffc0000000000
[ 9839.530044][T97227] FS:  00007f23ef12a740(0000) GS:ffff88a01f280000(0000) knlGS:0000000000000000
[ 9839.538878][T97227] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9839.545355][T97227] CR2: 0000000001c79000 CR3: 0000000c15786004 CR4: 00000000007706e0
[ 9839.553229][T97227] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 9839.561104][T97227] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 9839.568976][T97227] PKRU: 55555554
[ 9839.572395][T97227] Call Trace:
[ 9839.575559][T97227]  ? iomap_writepage_map+0x23a0/0x23a0
[ 9839.580900][T97227]  ? clear_page_dirty_for_io+0x990/0x990
[ 9839.586420][T97227]  ? rcu_read_lock_sched_held+0x9c/0xd0
[ 9839.591850][T97227]  ? rcu_read_lock_bh_held+0xb0/0xb0
[ 9839.597021][T97227]  ? find_held_lock+0x33/0x1c0
[ 9839.601670][T97227]  ? xfs_vm_writepages+0xc2/0x130
[ 9839.606575][T97227]  ? lock_downgrade+0x700/0x700
[ 9839.611305][T97227]  ? rcu_read_unlock+0x40/0x40
[ 9839.615949][T97227]  ? do_raw_spin_lock+0x121/0x290
[ 9839.620854][T97227]  ? rwlock_bug.part.1+0x90/0x90
[ 9839.625669][T97227]  iomap_writepages+0x3f/0xb0
iomap_writepages at fs/iomap/buffered-io.c:1576
[ 9839.630225][T97227]  xfs_vm_writepages+0xd7/0x130
[ 9839.634955][T97227]  ? xfs_vm_readahead+0x10/0x10
[ 9839.639686][T97227]  ? find_held_lock+0x33/0x1c0
[ 9839.644327][T97227]  do_writepages+0xcd/0x250
do_writepages at mm/page-writeback.c:2355
[ 9839.648707][T97227]  ? page_writeback_cpu_online+0x10/0x10
[ 9839.654224][T97227]  ? do_raw_spin_lock+0x121/0x290
[ 9839.659129][T97227]  ? rwlock_bug.part.1+0x90/0x90
[ 9839.663945][T97227]  ? rcu_read_lock_bh_held+0xb0/0xb0
[ 9839.669113][T97227]  __filemap_fdatawrite_range+0x250/0x310
__filemap_fdatawrite_range at mm/filemap.c:423
[ 9839.674717][T97227]  ? delete_from_page_cache_batch+0xaa0/0xaa0
[ 9839.680669][T97227]  ? rcu_read_lock_bh_held+0xb0/0xb0
[ 9839.685836][T97227]  ? rcu_read_lock_sched_held+0x9c/0xd0
[ 9839.691265][T97227]  file_write_and_wait_range+0x85/0xe0
file_write_and_wait_range at mm/filemap.c:761
[ 9839.696607][T97227]  xfs_file_fsync+0x192/0x710
fs_file_fsync at fs/xfs/xfs_file.c:105
[ 9839.701163][T97227]  ? xfs_file_read_iter+0x490/0x490
[ 9839.706242][T97227]  ? up_write+0x148/0x460
[ 9839.710446][T97227]  ? iomap_write_begin+0xde0/0xde0
[ 9839.715438][T97227]  xfs_file_buffered_aio_write+0x82a/0xa30
generic_write_sync at include/linux/fs.h:2727
(inlined by) xfs_file_buffered_aio_write at fs/xfs/xfs_file.c:684
[ 9839.721129][T97227]  ? xfs_file_aio_write_checks+0x620/0x620
[ 9839.726820][T97227]  ? lockdep_hardirqs_on_prepare+0x3d0/0x3d0
[ 9839.732691][T97227]  new_sync_write+0x3aa/0x610
[ 9839.737247][T97227]  ? new_sync_read+0x600/0x600
[ 9839.741888][T97227]  ? vfs_write+0x36c/0x5b0
[ 9839.746181][T97227]  ? rcu_read_lock_any_held+0xcd/0xf0
[ 9839.751433][T97227]  vfs_write+0x3e9/0x5b0

