Return-Path: <linux-fsdevel+bounces-40864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4E6A27FED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 01:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FA3F7A2CA7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 00:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9273C17555;
	Wed,  5 Feb 2025 00:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="Oqbmznqs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com [209.85.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF7ABE5E
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 00:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738713810; cv=none; b=phJ0JtMaXBYZUOoGCF7J6FgflVWeSIyDdkXCpoAAf4coOvsKfKdA0TF4wb3Qokx9snKJy8mxOpcNMVxD0DrI0odn4Q20XStuJ9x2jdun02P6+GM14avm68ZROOQJy2XCJmHcPWk2zhgziA/WxljkPpoEuFY1bmu/R1/M0fsd4hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738713810; c=relaxed/simple;
	bh=zPIWy3D5CiSJ2J/wfsbwpOA4++sgKqfkOjjA3WT5nkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOOQKcqMbMEXLutCsqJ38jCyYyByVNj8NKwv0pGkPifFlBiecP6qilPhHUlJonoIciIWUmLFwj28YvgMSL7CiP/ur2XPtIy74jegKB8Xz6mq8ImLcNkryI/5F3LdgaVYWry4bC34AaAxGluVK3Vdgi9VPc/bl0SO8wJMb9GeU9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=Oqbmznqs; arc=none smtp.client-ip=209.85.161.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-oo1-f65.google.com with SMTP id 006d021491bc7-5f4d935084aso2147377eaf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 16:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1738713806; x=1739318606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLOwU2JVIbz6wIo2X179JkMI/+Xuy+L7Fq5G04GdqK0=;
        b=OqbmznqsfLwGx5/a+QZXNrFoRxt19aoDTYogYJraAJSYIhj2LsiZ+D0MAWXls9w2ho
         9ZuGasarVv2UTDug8HtLk+vyQWwMJQ6lsxfNuX46BNJBrehyv0vyzk0BxL+eRXYo3bxn
         /68zB/EnygFO3OTUEh90gGDxVeDqm9Y0KG80jE/ACnfbmhLmBdC9Yyi8AKk3lWUnQ7XB
         LzLyyh4QdCA4C2dGIhTH30OI+HuCw0YiKofKcu2VshqNsjx+YYUbYAa2wEzoEDzxF+q3
         g5F7ca0jSsrdWsvbe//eWf+eWKNMLxGDk+8s3LmNnUCqVNTK6ZR5m98gpgkV3ERxSG3T
         OOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738713806; x=1739318606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLOwU2JVIbz6wIo2X179JkMI/+Xuy+L7Fq5G04GdqK0=;
        b=D8p2FZnJZCSvFWNCOGiuZWnR3U1Qojzxli885PuaVByRpDvZ2jOTbhVrnO0jROG2bb
         /Qp5FxZUB1tDwP74efnV4Zu9suD4J75x93iZ8M6StsKvW/YY963b45k5TwMGVHSuCfK4
         9ApBxmKWOs+JC2ivf3HvTRCo7elhIjvvyq5IzuJ93kG8F/F6AfS6UDpPCKB5WDjKF8Kc
         YWc70i/EUDE7w6WV7XJKJKip2PTFhKrBdHav7juIlAijhjxtfESw6720UjZVVleazvGF
         2+dUafYA7LOBMwDQnvP/W2xx9eVa1i7GyqJYM2xMQUPjitCe1XrZuoMWBj7jjPsN16Df
         69tA==
X-Forwarded-Encrypted: i=1; AJvYcCWFrVjHqqVDQCNxQayDGujjJyKOZIZQUl4swjdFHoFuRyQmR9UkDnZkG2BSB5C6yx3BKVLSCXWiFefJanTR@vger.kernel.org
X-Gm-Message-State: AOJu0YwpfO/uEI2S/WvEkMFq4nxbmxFBilanEJbdwbVVEZnWsEjR1ED6
	CGwefh9aR0RjJZ9HJi8JIJbVHdDemxgU7aapv0AlKo2wtL/iheD88N1kbe+fDrI=
X-Gm-Gg: ASbGnct/DSv/TVJhSLMnIF1kQ5AFDm8aOqaZm1Cxrhij5QZFhfQa0/9eg82+0evP0SI
	oyTLx2fgCGNSpzrPdROyX/5zVIRr1EfbOyzyaUWOUzqX+rXLpliiPW6ZQUiJkvJItFX3NJQUNBg
	rb9U2TxFNCKtsTee1uFdP8dXiKl2AAZMThFSwzbL/kCkAbb8NJRl6i5ks2Exe6oEFQMZxRmdaib
	uSgFXYgfcW5ccUf+EzkAVrs2FeaIHodOlUHVxjKO7s+KZuZiFXx1UcZxx6bbZ05VReW0poPzLpm
	vfYD794jOvJQt9TGERw3yCoq2GUkRu0T
X-Google-Smtp-Source: AGHT+IGSbEFi0Utm4vZ2ntfp8J7/+E7892y7Pa1y4ClKmFnnk4aOD5y9wcVRrPhB7C12NdCPmqKczA==
X-Received: by 2002:a05:6871:3a11:b0:29e:55c1:229a with SMTP id 586e51a60fabf-2b804f2080dmr526107fac.14.1738713806367;
        Tue, 04 Feb 2025 16:03:26 -0800 (PST)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:d53:ebfc:fe83:43f5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726617eb64csm3666413a34.37.2025.02.04.16.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 16:03:25 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	dhowells@redhat.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [RFC PATCH 3/4] ceph: introduce ceph_submit_write() method
Date: Tue,  4 Feb 2025 16:02:48 -0800
Message-ID: <20250205000249.123054-4-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205000249.123054-1-slava@dubeyko.com>
References: <20250205000249.123054-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Final responsibility of ceph_writepages_start() is
to submit write requests for processed dirty folios/pages.
The ceph_submit_write() summarize all this logic in
one method.

The generic/421 fails to finish because of the issue:

Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.894678] INFO: task kworker/u48:0:11 blocked for more than 122 seconds.
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.895403] Not tainted 6.13.0-rc5+ #1
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.895867] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.896633] task:kworker/u48:0 state:D stack:0 pid:11 tgid:11 ppid:2 flags:0x00004000
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.896641] Workqueue: writeback wb_workfn (flush-ceph-24)
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897614] Call Trace:
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897620] <TASK>
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897629] __schedule+0x443/0x16b0
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897637] schedule+0x2b/0x140
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897640] io_schedule+0x4c/0x80
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897643] folio_wait_bit_common+0x11b/0x310
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897646] ? _raw_spin_unlock_irq+0xe/0x50
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897652] ? __pfx_wake_page_function+0x10/0x10
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897655] __folio_lock+0x17/0x30
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897658] ceph_writepages_start+0xca9/0x1fb0
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897663] ? fsnotify_remove_queued_event+0x2f/0x40
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897668] do_writepages+0xd2/0x240
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897672] __writeback_single_inode+0x44/0x350
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897675] writeback_sb_inodes+0x25c/0x550
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897680] wb_writeback+0x89/0x310
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897683] ? finish_task_switch.isra.0+0x97/0x310
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897687] wb_workfn+0xb5/0x410
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897689] process_one_work+0x188/0x3d0
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897692] worker_thread+0x2b5/0x3c0
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897694] ? __pfx_worker_thread+0x10/0x10
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897696] kthread+0xe1/0x120
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897699] ? __pfx_kthread+0x10/0x10
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897701] ret_from_fork+0x43/0x70
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897705] ? __pfx_kthread+0x10/0x10
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897707] ret_from_fork_asm+0x1a/0x30
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897711] </TASK>

There are two problems here:

if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
     rc = -EIO;
     goto release_folios;
}

(1) ceph_kill_sb() doesn't wait ending of flushing
all dirty folios/pages because of racy nature of
mdsc->stopping_blockers. As a result, mdsc->stopping
becomes CEPH_MDSC_STOPPING_FLUSHED too early.
(2) The ceph_inc_osd_stopping_blocker(fsc->mdsc) fails
to increment mdsc->stopping_blockers. Finally,
already locked folios/pages are never been unlocked
and the logic tries to lock the same page second time.

This patch implements refactoring of ceph_submit_write()
and also it solves the second issue.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 fs/ceph/addr.c | 461 +++++++++++++++++++++++++++----------------------
 1 file changed, 257 insertions(+), 204 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 739329846a07..02d20c000dc5 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1395,6 +1395,245 @@ int ceph_process_folio_batch(struct address_space *mapping,
 	return rc;
 }
 
+static inline
+void ceph_shift_unused_folios_left(struct folio_batch *fbatch)
+{
+	unsigned j, n = 0;
+
+	/* shift unused page to beginning of fbatch */
+	for (j = 0; j < folio_batch_count(fbatch); j++) {
+		if (!fbatch->folios[j])
+			continue;
+
+		if (n < j) {
+			fbatch->folios[n] = fbatch->folios[j];
+		}
+
+		n++;
+	}
+
+	fbatch->nr = n;
+}
+
+static
+int ceph_submit_write(struct address_space *mapping,
+			struct writeback_control *wbc,
+			struct ceph_writeback_ctl *ceph_wbc)
+{
+	struct inode *inode = mapping->host;
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	struct ceph_client *cl = fsc->client;
+	struct ceph_vino vino = ceph_vino(inode);
+	struct ceph_osd_request *req = NULL;
+	struct page *page = NULL;
+	bool caching = ceph_is_cache_enabled(inode);
+	u64 offset;
+	u64 len;
+	unsigned i;
+
+new_request:
+	offset = ceph_fscrypt_page_offset(ceph_wbc->pages[0]);
+	len = ceph_wbc->wsize;
+
+	req = ceph_osdc_new_request(&fsc->client->osdc,
+				    &ci->i_layout, vino,
+				    offset, &len, 0, ceph_wbc->num_ops,
+				    CEPH_OSD_OP_WRITE, CEPH_OSD_FLAG_WRITE,
+				    ceph_wbc->snapc, ceph_wbc->truncate_seq,
+				    ceph_wbc->truncate_size, false);
+	if (IS_ERR(req)) {
+		req = ceph_osdc_new_request(&fsc->client->osdc,
+					    &ci->i_layout, vino,
+					    offset, &len, 0,
+					    min(ceph_wbc->num_ops,
+						CEPH_OSD_SLAB_OPS),
+					    CEPH_OSD_OP_WRITE,
+					    CEPH_OSD_FLAG_WRITE,
+					    ceph_wbc->snapc,
+					    ceph_wbc->truncate_seq,
+					    ceph_wbc->truncate_size,
+					    true);
+		BUG_ON(IS_ERR(req));
+	}
+
+	page = ceph_wbc->pages[ceph_wbc->locked_pages - 1];
+	BUG_ON(len < ceph_fscrypt_page_offset(page) + thp_size(page) - offset);
+
+	if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
+		for (i = 0; i < folio_batch_count(&ceph_wbc->fbatch); i++) {
+			struct folio *folio = ceph_wbc->fbatch.folios[i];
+
+			if (!folio)
+				continue;
+
+			page = &folio->page;
+			redirty_page_for_writepage(wbc, page);
+			unlock_page(page);
+		}
+
+		for (i = 0; i < ceph_wbc->locked_pages; i++) {
+			page = ceph_fscrypt_pagecache_page(ceph_wbc->pages[i]);
+
+			if (!page)
+				continue;
+
+			redirty_page_for_writepage(wbc, page);
+			unlock_page(page);
+		}
+
+		ceph_osdc_put_request(req);
+		return -EIO;
+	}
+
+	req->r_callback = writepages_finish;
+	req->r_inode = inode;
+
+	/* Format the osd request message and submit the write */
+	len = 0;
+	ceph_wbc->data_pages = ceph_wbc->pages;
+	ceph_wbc->op_idx = 0;
+	for (i = 0; i < ceph_wbc->locked_pages; i++) {
+		u64 cur_offset;
+
+		page = ceph_fscrypt_pagecache_page(ceph_wbc->pages[i]);
+		cur_offset = page_offset(page);
+
+		/*
+		 * Discontinuity in page range? Ceph can handle that by just passing
+		 * multiple extents in the write op.
+		 */
+		if (offset + len != cur_offset) {
+			/* If it's full, stop here */
+			if (ceph_wbc->op_idx + 1 == req->r_num_ops)
+				break;
+
+			/* Kick off an fscache write with what we have so far. */
+			ceph_fscache_write_to_cache(inode, offset, len, caching);
+
+			/* Start a new extent */
+			osd_req_op_extent_dup_last(req, ceph_wbc->op_idx,
+						   cur_offset - offset);
+
+			doutc(cl, "got pages at %llu~%llu\n", offset, len);
+
+			osd_req_op_extent_osd_data_pages(req, ceph_wbc->op_idx,
+							 ceph_wbc->data_pages,
+							 len, 0,
+							 ceph_wbc->from_pool,
+							 false);
+			osd_req_op_extent_update(req, ceph_wbc->op_idx, len);
+
+			len = 0;
+			offset = cur_offset;
+			ceph_wbc->data_pages = ceph_wbc->pages + i;
+			ceph_wbc->op_idx++;
+		}
+
+		set_page_writeback(page);
+
+		if (caching)
+			ceph_set_page_fscache(page);
+
+		len += thp_size(page);
+	}
+
+	ceph_fscache_write_to_cache(inode, offset, len, caching);
+
+	if (ceph_wbc->size_stable) {
+		len = min(len, ceph_wbc->i_size - offset);
+	} else if (i == ceph_wbc->locked_pages) {
+		/* writepages_finish() clears writeback pages
+		 * according to the data length, so make sure
+		 * data length covers all locked pages */
+		u64 min_len = len + 1 - thp_size(page);
+		len = get_writepages_data_length(inode,
+						 ceph_wbc->pages[i - 1],
+						 offset);
+		len = max(len, min_len);
+	}
+
+	if (IS_ENCRYPTED(inode))
+		len = round_up(len, CEPH_FSCRYPT_BLOCK_SIZE);
+
+	doutc(cl, "got pages at %llu~%llu\n", offset, len);
+
+	if (IS_ENCRYPTED(inode) &&
+	    ((offset | len) & ~CEPH_FSCRYPT_BLOCK_MASK)) {
+		pr_warn_client(cl,
+			"bad encrypted write offset=%lld len=%llu\n",
+			offset, len);
+	}
+
+	osd_req_op_extent_osd_data_pages(req, ceph_wbc->op_idx,
+					 ceph_wbc->data_pages, len,
+					 0, ceph_wbc->from_pool, false);
+	osd_req_op_extent_update(req, ceph_wbc->op_idx, len);
+
+	BUG_ON(ceph_wbc->op_idx + 1 != req->r_num_ops);
+
+	ceph_wbc->from_pool = false;
+	if (i < ceph_wbc->locked_pages) {
+		BUG_ON(ceph_wbc->num_ops <= req->r_num_ops);
+		ceph_wbc->num_ops -= req->r_num_ops;
+		ceph_wbc->locked_pages -= i;
+
+		/* allocate new pages array for next request */
+		ceph_wbc->data_pages = ceph_wbc->pages;
+		__ceph_allocate_page_array(ceph_wbc, ceph_wbc->locked_pages);
+		memcpy(ceph_wbc->pages, ceph_wbc->data_pages + i,
+			ceph_wbc->locked_pages * sizeof(*ceph_wbc->pages));
+		memset(ceph_wbc->data_pages + i, 0,
+			ceph_wbc->locked_pages * sizeof(*ceph_wbc->pages));
+	} else {
+		BUG_ON(ceph_wbc->num_ops != req->r_num_ops);
+		/* request message now owns the pages array */
+		ceph_wbc->pages = NULL;
+	}
+
+	req->r_mtime = inode_get_mtime(inode);
+	ceph_osdc_start_request(&fsc->client->osdc, req);
+	req = NULL;
+
+	wbc->nr_to_write -= i;
+	if (ceph_wbc->pages)
+		goto new_request;
+
+	return 0;
+}
+
+static
+void ceph_wait_until_current_writes_complete(struct address_space *mapping,
+					     struct writeback_control *wbc,
+					     struct ceph_writeback_ctl *ceph_wbc)
+{
+	struct page *page;
+	unsigned i, nr;
+
+	if (wbc->sync_mode != WB_SYNC_NONE &&
+	    ceph_wbc->start_index == 0 && /* all dirty pages were checked */
+	    !ceph_wbc->head_snapc) {
+		ceph_wbc->index = 0;
+
+		while ((ceph_wbc->index <= ceph_wbc->end) &&
+			(nr = filemap_get_folios_tag(mapping,
+						     &ceph_wbc->index,
+						     (pgoff_t)-1,
+						     PAGECACHE_TAG_WRITEBACK,
+						     &ceph_wbc->fbatch))) {
+			for (i = 0; i < nr; i++) {
+				page = &ceph_wbc->fbatch.folios[i]->page;
+				if (page_snap_context(page) != ceph_wbc->snapc)
+					continue;
+				wait_on_page_writeback(page);
+			}
+
+			folio_batch_release(&ceph_wbc->fbatch);
+			cond_resched();
+		}
+	}
+}
+
 /*
  * initiate async writeback
  */
@@ -1402,17 +1641,12 @@ static int ceph_writepages_start(struct address_space *mapping,
 				 struct writeback_control *wbc)
 {
 	struct inode *inode = mapping->host;
-	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_client *cl = fsc->client;
-	struct ceph_vino vino = ceph_vino(inode);
 	struct ceph_writeback_ctl ceph_wbc;
-	struct ceph_osd_request *req = NULL;
 	int rc = 0;
-	bool caching = ceph_is_cache_enabled(inode);
 
-	if (wbc->sync_mode == WB_SYNC_NONE &&
-	    fsc->write_congested)
+	if (wbc->sync_mode == WB_SYNC_NONE && fsc->write_congested)
 		return 0;
 
 	doutc(cl, "%llx.%llx (mode=%s)\n", ceph_vinop(inode),
@@ -1439,9 +1673,6 @@ static int ceph_writepages_start(struct address_space *mapping,
 		tag_pages_for_writeback(mapping, ceph_wbc.index, ceph_wbc.end);
 
 	while (!has_writeback_done(&ceph_wbc)) {
-		unsigned i;
-		struct page *page;
-
 		ceph_wbc.locked_pages = 0;
 		ceph_wbc.max_pages = ceph_wbc.wsize >> PAGE_SHIFT;
 
@@ -1459,6 +1690,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 		if (!ceph_wbc.nr_folios && !ceph_wbc.locked_pages)
 			break;
 
+process_folio_batch:
 		rc = ceph_process_folio_batch(mapping, wbc, &ceph_wbc);
 		if (rc)
 			goto release_folios;
@@ -1466,187 +1698,30 @@ static int ceph_writepages_start(struct address_space *mapping,
 		/* did we get anything? */
 		if (!ceph_wbc.locked_pages)
 			goto release_folios;
-		if (i) {
-			unsigned j, n = 0;
-			/* shift unused page to beginning of fbatch */
-			for (j = 0; j < ceph_wbc.nr_folios; j++) {
-				if (!ceph_wbc.fbatch.folios[j])
-					continue;
-				if (n < j) {
-					ceph_wbc.fbatch.folios[n] =
-						ceph_wbc.fbatch.folios[j];
-				}
-				n++;
-			}
-			ceph_wbc.fbatch.nr = n;
 
-			if (ceph_wbc.nr_folios && i == ceph_wbc.nr_folios &&
+		if (ceph_wbc.processed_in_fbatch) {
+			ceph_shift_unused_folios_left(&ceph_wbc.fbatch);
+
+			if (folio_batch_count(&ceph_wbc.fbatch) == 0 &&
 			    ceph_wbc.locked_pages < ceph_wbc.max_pages) {
 				doutc(cl, "reached end fbatch, trying for more\n");
-				folio_batch_release(&ceph_wbc.fbatch);
 				goto get_more_pages;
 			}
 		}
 
-new_request:
-		ceph_wbc.offset = ceph_fscrypt_page_offset(ceph_wbc.pages[0]);
-		ceph_wbc.len = ceph_wbc.wsize;
-
-		req = ceph_osdc_new_request(&fsc->client->osdc,
-					&ci->i_layout, vino,
-					ceph_wbc.offset, &ceph_wbc.len,
-					0, ceph_wbc.num_ops,
-					CEPH_OSD_OP_WRITE, CEPH_OSD_FLAG_WRITE,
-					ceph_wbc.snapc, ceph_wbc.truncate_seq,
-					ceph_wbc.truncate_size, false);
-		if (IS_ERR(req)) {
-			req = ceph_osdc_new_request(&fsc->client->osdc,
-						&ci->i_layout, vino,
-						ceph_wbc.offset, &ceph_wbc.len,
-						0, min(ceph_wbc.num_ops,
-						    CEPH_OSD_SLAB_OPS),
-						CEPH_OSD_OP_WRITE,
-						CEPH_OSD_FLAG_WRITE,
-						ceph_wbc.snapc,
-						ceph_wbc.truncate_seq,
-						ceph_wbc.truncate_size, true);
-			BUG_ON(IS_ERR(req));
-		}
-		BUG_ON(ceph_wbc.len <
-			ceph_fscrypt_page_offset(ceph_wbc.pages[ceph_wbc.locked_pages - 1]) +
-				thp_size(ceph_wbc.pages[ceph_wbc.locked_pages - 1]) -
-					ceph_wbc.offset);
-
-		if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
-			rc = -EIO;
+		rc = ceph_submit_write(mapping, wbc, &ceph_wbc);
+		if (rc)
 			goto release_folios;
-		}
-		req->r_callback = writepages_finish;
-		req->r_inode = inode;
-
-		/* Format the osd request message and submit the write */
-		ceph_wbc.len = 0;
-		ceph_wbc.data_pages = ceph_wbc.pages;
-		ceph_wbc.op_idx = 0;
-		for (i = 0; i < ceph_wbc.locked_pages; i++) {
-			struct page *page =
-				ceph_fscrypt_pagecache_page(ceph_wbc.pages[i]);
-
-			u64 cur_offset = page_offset(page);
-			/*
-			 * Discontinuity in page range? Ceph can handle that by just passing
-			 * multiple extents in the write op.
-			 */
-			if (ceph_wbc.offset + ceph_wbc.len != cur_offset) {
-				/* If it's full, stop here */
-				if (ceph_wbc.op_idx + 1 == req->r_num_ops)
-					break;
-
-				/* Kick off an fscache write with what we have so far. */
-				ceph_fscache_write_to_cache(inode, ceph_wbc.offset,
-							    ceph_wbc.len, caching);
-
-				/* Start a new extent */
-				osd_req_op_extent_dup_last(req, ceph_wbc.op_idx,
-							   cur_offset -
-								ceph_wbc.offset);
-				doutc(cl, "got pages at %llu~%llu\n",
-					ceph_wbc.offset,
-					ceph_wbc.len);
-				osd_req_op_extent_osd_data_pages(req,
-							ceph_wbc.op_idx,
-							ceph_wbc.data_pages,
-							ceph_wbc.len, 0,
-							ceph_wbc.from_pool, false);
-				osd_req_op_extent_update(req, ceph_wbc.op_idx,
-							 ceph_wbc.len);
-
-				ceph_wbc.len = 0;
-				ceph_wbc.offset = cur_offset;
-				ceph_wbc.data_pages = ceph_wbc.pages + i;
-				ceph_wbc.op_idx++;
-			}
-
-			set_page_writeback(page);
-			if (caching)
-				ceph_set_page_fscache(page);
-			ceph_wbc.len += thp_size(page);
-		}
-		ceph_fscache_write_to_cache(inode, ceph_wbc.offset,
-					    ceph_wbc.len, caching);
-
-		if (ceph_wbc.size_stable) {
-			ceph_wbc.len = min(ceph_wbc.len,
-					    ceph_wbc.i_size - ceph_wbc.offset);
-		} else if (i == ceph_wbc.locked_pages) {
-			/* writepages_finish() clears writeback pages
-			 * according to the data length, so make sure
-			 * data length covers all locked pages */
-			u64 min_len = ceph_wbc.len + 1 - thp_size(page);
-			ceph_wbc.len =
-				get_writepages_data_length(inode,
-							ceph_wbc.pages[i - 1],
-							ceph_wbc.offset);
-			ceph_wbc.len = max(ceph_wbc.len, min_len);
-		}
-		if (IS_ENCRYPTED(inode)) {
-			ceph_wbc.len = round_up(ceph_wbc.len,
-						CEPH_FSCRYPT_BLOCK_SIZE);
-		}
 
-		doutc(cl, "got pages at %llu~%llu\n",
-			ceph_wbc.offset, ceph_wbc.len);
+		ceph_wbc.locked_pages = 0;
+		ceph_wbc.strip_unit_end = 0;
 
-		if (IS_ENCRYPTED(inode) &&
-		    ((ceph_wbc.offset | ceph_wbc.len) & ~CEPH_FSCRYPT_BLOCK_MASK))
-			pr_warn_client(cl,
-				"bad encrypted write offset=%lld len=%llu\n",
-				ceph_wbc.offset, ceph_wbc.len);
-
-		osd_req_op_extent_osd_data_pages(req, ceph_wbc.op_idx,
-						 ceph_wbc.data_pages,
-						 ceph_wbc.len,
-						 0, ceph_wbc.from_pool, false);
-		osd_req_op_extent_update(req, ceph_wbc.op_idx, ceph_wbc.len);
-
-		BUG_ON(ceph_wbc.op_idx + 1 != req->r_num_ops);
-
-		ceph_wbc.from_pool = false;
-		if (i < ceph_wbc.locked_pages) {
-			BUG_ON(ceph_wbc.num_ops <= req->r_num_ops);
-			ceph_wbc.num_ops -= req->r_num_ops;
-			ceph_wbc.locked_pages -= i;
-
-			/* allocate new pages array for next request */
-			ceph_wbc.data_pages = ceph_wbc.pages;
-			ceph_wbc.pages = kmalloc_array(ceph_wbc.locked_pages,
-							sizeof(*ceph_wbc.pages),
-							GFP_NOFS);
-			if (!ceph_wbc.pages) {
-				ceph_wbc.from_pool = true;
-				ceph_wbc.pages =
-					mempool_alloc(ceph_wb_pagevec_pool, GFP_NOFS);
-				BUG_ON(!ceph_wbc.pages);
-			}
-			memcpy(ceph_wbc.pages, ceph_wbc.data_pages + i,
-			       ceph_wbc.locked_pages * sizeof(*ceph_wbc.pages));
-			memset(ceph_wbc.data_pages + i, 0,
-			       ceph_wbc.locked_pages * sizeof(*ceph_wbc.pages));
-		} else {
-			BUG_ON(ceph_wbc.num_ops != req->r_num_ops);
-			ceph_wbc.index = ceph_wbc.pages[i - 1]->index + 1;
-			/* request message now owns the pages array */
-			ceph_wbc.pages = NULL;
+		if (folio_batch_count(&ceph_wbc.fbatch) > 0) {
+			ceph_wbc.nr_folios =
+				folio_batch_count(&ceph_wbc.fbatch);
+			goto process_folio_batch;
 		}
 
-		req->r_mtime = inode_get_mtime(inode);
-		ceph_osdc_start_request(&fsc->client->osdc, req);
-		req = NULL;
-
-		wbc->nr_to_write -= i;
-		if (ceph_wbc.pages)
-			goto new_request;
-
 		/*
 		 * We stop writing back only if we are not doing
 		 * integrity sync. In case of integrity sync we have to
@@ -1666,32 +1741,12 @@ static int ceph_writepages_start(struct address_space *mapping,
 	if (ceph_wbc.should_loop && !ceph_wbc.done) {
 		/* more to do; loop back to beginning of file */
 		doutc(cl, "looping back to beginning of file\n");
-		ceph_wbc.end = ceph_wbc.start_index - 1; /* OK even when start_index == 0 */
+		/* OK even when start_index == 0 */
+		ceph_wbc.end = ceph_wbc.start_index - 1;
 
 		/* to write dirty pages associated with next snapc,
 		 * we need to wait until current writes complete */
-		if (wbc->sync_mode != WB_SYNC_NONE &&
-		    ceph_wbc.start_index == 0 && /* all dirty pages were checked */
-		    !ceph_wbc.head_snapc) {
-			struct page *page;
-			unsigned i, nr;
-			ceph_wbc.index = 0;
-			while ((ceph_wbc.index <= ceph_wbc.end) &&
-			       (nr = filemap_get_folios_tag(mapping,
-						&ceph_wbc.index,
-						(pgoff_t)-1,
-						PAGECACHE_TAG_WRITEBACK,
-						&ceph_wbc.fbatch))) {
-				for (i = 0; i < nr; i++) {
-					page = &ceph_wbc.fbatch.folios[i]->page;
-					if (page_snap_context(page) != ceph_wbc.snapc)
-						continue;
-					wait_on_page_writeback(page);
-				}
-				folio_batch_release(&ceph_wbc.fbatch);
-				cond_resched();
-			}
-		}
+		ceph_wait_until_current_writes_complete(mapping, wbc, &ceph_wbc);
 
 		ceph_wbc.start_index = 0;
 		ceph_wbc.index = 0;
@@ -1702,15 +1757,13 @@ static int ceph_writepages_start(struct address_space *mapping,
 		mapping->writeback_index = ceph_wbc.index;
 
 out:
-	ceph_osdc_put_request(req);
 	ceph_put_snap_context(ceph_wbc.last_snapc);
 	doutc(cl, "%llx.%llx dend - startone, rc = %d\n", ceph_vinop(inode),
 	      rc);
+
 	return rc;
 }
 
-
-
 /*
  * See if a given @snapc is either writeable, or already written.
  */
-- 
2.48.0


