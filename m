Return-Path: <linux-fsdevel+bounces-7604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1015A8284FB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 12:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4482845BE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 11:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D51E381C6;
	Tue,  9 Jan 2024 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OopZzPMe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FCC381AD;
	Tue,  9 Jan 2024 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704799500;
	bh=Wn4ecH1GNnkPZ7jx7eZ6iiftyWhdMfTiRzbfmCdSNsI=;
	h=From:To:Cc:Subject:Date:From;
	b=OopZzPMexnJA9WO4ltmJ2GaJf0sLZBuWRX3VOrYwXUgHsZmOcio5QV7DfDGTbkeJg
	 vSVUsIH0R/IyEo0v0x0twpVhymcDIqQBikyER3Y37OnTqSTupJag5LLq+umN+hbr7k
	 ATV3Hnga2PrjrNfQne58DqtFCcLF9W+vfU7+adTXmZtsZs6+jfr6to39/pludbD0e5
	 D5icx+dtpAruHv/OmnuIrjXObjmqyR4LPFYFUDYV1zRQ3v68vyG/meyrWM1+olctTM
	 4mpWDOf2kMgTnN7se6UxzCIy+VNkpcsjaPTZir6VpJaZ5f3gswuoehb1I364QsE98u
	 LHwpcm/Ew1d8w==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6EEC63782056;
	Tue,  9 Jan 2024 11:24:55 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Andrei Vagin <avagin@google.com>,
	Peter Xu <peterx@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Arnd Bergmann <arnd@arndb.de>
Cc: kernel@collabora.com,
	syzbot+81227d2bd69e9dedb802@syzkaller.appspotmail.com,
	Sean Christopherson <seanjc@google.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/proc/task_mmu: move mmu notification mechanism inside mm lock
Date: Tue,  9 Jan 2024 16:24:42 +0500
Message-ID: <20240109112445.590736-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move mmu notification mechanism inside mm lock to prevent race condition
in other components which depend on it. The notifier will invalidate
memory range. Depending upon the number of iterations, different memory
ranges would be invalidated.

The following warning would be removed by this patch:
WARNING: CPU: 0 PID: 5067 at arch/x86/kvm/../../../virt/kvm/kvm_main.c:734 kvm_mmu_notifier_change_pte+0x860/0x960 arch/x86/kvm/../../../virt/kvm/kvm_main.c:734

There is no behavioural and performance change with this patch when
there is no component registered with the mmu notifier.

Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
Reported-by: syzbot+81227d2bd69e9dedb802@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/000000000000f6d051060c6785bc@google.com/
Cc: Sean Christopherson <seanjc@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 fs/proc/task_mmu.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 62b16f42d5d2..56c2e7357494 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2448,13 +2448,6 @@ static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
 	if (ret)
 		return ret;
 
-	/* Protection change for the range is going to happen. */
-	if (p.arg.flags & PM_SCAN_WP_MATCHING) {
-		mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA, 0,
-					mm, p.arg.start, p.arg.end);
-		mmu_notifier_invalidate_range_start(&range);
-	}
-
 	for (walk_start = p.arg.start; walk_start < p.arg.end;
 			walk_start = p.arg.walk_end) {
 		long n_out;
@@ -2467,8 +2460,20 @@ static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
 		ret = mmap_read_lock_killable(mm);
 		if (ret)
 			break;
+
+		/* Protection change for the range is going to happen. */
+		if (p.arg.flags & PM_SCAN_WP_MATCHING) {
+			mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA, 0,
+						mm, walk_start, p.arg.end);
+			mmu_notifier_invalidate_range_start(&range);
+		}
+
 		ret = walk_page_range(mm, walk_start, p.arg.end,
 				      &pagemap_scan_ops, &p);
+
+		if (p.arg.flags & PM_SCAN_WP_MATCHING)
+			mmu_notifier_invalidate_range_end(&range);
+
 		mmap_read_unlock(mm);
 
 		n_out = pagemap_scan_flush_buffer(&p);
@@ -2494,9 +2499,6 @@ static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
 	if (pagemap_scan_writeback_args(&p.arg, uarg))
 		ret = -EFAULT;
 
-	if (p.arg.flags & PM_SCAN_WP_MATCHING)
-		mmu_notifier_invalidate_range_end(&range);
-
 	kfree(p.vec_buf);
 	return ret;
 }
-- 
2.42.0


