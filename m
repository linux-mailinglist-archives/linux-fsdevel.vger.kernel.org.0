Return-Path: <linux-fsdevel+bounces-57361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86020B20BAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 16:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598FD2A7D5E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 14:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D4221858E;
	Mon, 11 Aug 2025 14:18:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EA0130E58
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921920; cv=none; b=oap7gmG94WSHjJRXIYWFwBB7bgam0nI+7Lfh8yEt8s0OvdZ5dVpvNFr0VskzCk0bguf7luZ3eLnVDqOcRSG9ehtVBw72dD29WBlYPZaVzJOSXu1FPXMEBbbDLoxOrwqEH2n4MjmM2G8t47+S6S8v3WAWVYrcVcUYWjH1H8R0H7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921920; c=relaxed/simple;
	bh=V4aSu0PXLZI44H/I1IxZP5P+SIjwXfvJSWY1R8xdfkw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=SQ8wSLBZxYai8LawBqi61q4xpfFqStrhTgsmXxuOoec9iD419hsIn9IdrNgqLf/O3JMPNN1xGfCRumieE4/dWMZUvVKv0ZQxZgl23GWrgtDDk7GjThkz0k1Sp64N2G/NiJRPMwK1UWqRUuOHibSyvuRtWoAcDrPIK0vEbyrly6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c0xZK4yqszKHMnt
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 22:18:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DF8721A07BB
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 22:18:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
	by APP4 (Coremail) with SMTP id gCh0CgDXUxS3+5loVRRVDQ--.30563S4;
	Mon, 11 Aug 2025 22:18:32 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	yebin@huaweicloud.com,
	yebin10@huawei.com
Subject: [PATCH RFC] fs/buffer: fix use-after-free when call bh_read() helper
Date: Mon, 11 Aug 2025 22:18:30 +0800
Message-Id: <20250811141830.343774-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXUxS3+5loVRRVDQ--.30563S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZw45Cr1UWw1rAFy5WFy7GFg_yoW5XF47pr
	90kFW7tr4kXFsFyr4jyF9xWr18JF4DXF47CF4rJ3W3Za45J3sa9ryUtF1qqF4jyrZFvFW8
	Xr48Kas5WryUZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUBVbkUUU
	UU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

There's issue as follows:
BUG: KASAN: stack-out-of-bounds in end_buffer_read_sync+0xe3/0x110
Read of size 8 at addr ffffc9000168f7f8 by task swapper/3/0
CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted 6.16.0-862.14.0.6.x86_64
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
Call Trace:
 <IRQ>
 dump_stack_lvl+0x55/0x70
 print_address_description.constprop.0+0x2c/0x390
 print_report+0xb4/0x270
 kasan_report+0xb8/0xf0
 end_buffer_read_sync+0xe3/0x110
 end_bio_bh_io_sync+0x56/0x80
 blk_update_request+0x30a/0x720
 scsi_end_request+0x51/0x2b0
 scsi_io_completion+0xe3/0x480
 ? scsi_device_unbusy+0x11e/0x160
 blk_complete_reqs+0x7b/0x90
 handle_softirqs+0xef/0x370
 irq_exit_rcu+0xa5/0xd0
 sysvec_apic_timer_interrupt+0x6e/0x90
 </IRQ>

 Above issue happens when do ntfs3 filesystem mount, issue may happens
 as follows:
           mount                            IRQ
ntfs_fill_super
  read_cache_page
    do_read_cache_folio
      filemap_read_folio
        mpage_read_folio
	 do_mpage_readpage
	  ntfs_get_block_vbo
	   bh_read
	     submit_bh
	     wait_on_buffer(bh);
	                            blk_complete_reqs
				     scsi_io_completion
				      scsi_end_request
				       blk_update_request
				        end_bio_bh_io_sync
					 end_buffer_read_sync
					  __end_buffer_read_notouch
					   unlock_buffer

            wait_on_buffer(bh);--> return will return to caller

					  put_bh
					    --> trigger stack-out-of-bounds
In the mpage_read_folio() function, the stack variable 'map_bh' is
passed to ntfs_get_block_vbo(). Once unlock_buffer() unlocks and
wait_on_buffer() returns to continue processing, the stack variable
is likely to be reclaimed. Consequently, during the end_buffer_read_sync()
process, calling put_bh() may result in stack overrun.
If it is not a stack variable, since the reference count of the
buffer_head is released after unlocking, it cannot be released during
drop_buffers. This poses a risk of buffer_head leakage.
To solve above issue first call put_bh() before unlock_buffer. This
should be safe because during the release, discard_buffer() will call
lock_buffer().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index ead4dc85debd..6a8752f7bbed 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -157,8 +157,8 @@ static void __end_buffer_read_notouch(struct buffer_head *bh, int uptodate)
  */
 void end_buffer_read_sync(struct buffer_head *bh, int uptodate)
 {
-	__end_buffer_read_notouch(bh, uptodate);
 	put_bh(bh);
+	__end_buffer_read_notouch(bh, uptodate);
 }
 EXPORT_SYMBOL(end_buffer_read_sync);
 
-- 
2.34.1


