Return-Path: <linux-fsdevel+bounces-56137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76014B13CD3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 16:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3DB188CF98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 14:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D50526B74A;
	Mon, 28 Jul 2025 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OkKEnL0d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093635336D;
	Mon, 28 Jul 2025 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712010; cv=none; b=jU/ZWStnX6lg84gbsr/aqo91ss9RxukzZz3qQtrCvUrh1DAG38eY6u4zq10bt7pSRlWm6GywrkVDQsbJkv1+C+ZfgF/XQzLuVldYW83RjT77efHVAV4Yj6O8wd6kkz0zYDuJRUnHI2K8v1f3c0TvQ5RBCiAfUgJlc93LyQeP6YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712010; c=relaxed/simple;
	bh=Dk5ph/7Htrz2MTnRgUMQRDvoE1dNxuuIMLdQFaZtP/0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q2DF8mlRGfBm07XvJE1fzsNyKfScWb0HByrMwDG1QR4AJNLmJkOr/wK245u3cjrKdITVkdw6uM3SCfM3fbX6eefCTShLn83pPFY300UHWELYoXKNY9wmkRDxU3iqaveasKn4AzG6o2No9DtE00hQH96XQHUex60pmsYtM9uTAnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OkKEnL0d; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=DH
	2El2kn7UALwc5FVenb/moxGLKzeZcyMv9bOLEEj8Q=; b=OkKEnL0d4L6MH/0I3E
	EykB+NolSJPIYO63RWhWLNi3EfEUqL8A1ZBPtf0Tw6wtbojOEE4dE6m5cD7ek675
	P/NYSBE2zZzH3HElBeJTR1g5Y3roPe1inUPHEHCVZZ+3uJhkDe8o+7JcDvl5Hepv
	XrSthwcrv3N70ito1KiN3twSE=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBH2dp2hYdoKkbcBw--.29646S2;
	Mon, 28 Jul 2025 22:13:10 +0800 (CST)
From: laishangzhen <laishangzhen@163.com>
To: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	laishangzhen <laishangzhen@163.com>
Subject: [PATCH] mm: Removing the card during write
Date: Mon, 28 Jul 2025 07:13:06 -0700
Message-Id: <20250728141306.23451-1-laishangzhen@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBH2dp2hYdoKkbcBw--.29646S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr1UXr4DZF1UXrW8WFyfZwb_yoW8ZrWxpF
	90k3s2krW8Xr4Igrn7WaykWryYgFWrCFW7XryUXa43Zwn0gF1xKFZFgFy7KFyYkr95Cw1a
	qrs0v342gw1jyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UBGQ9UUUUU=
X-CM-SenderInfo: podl2xhdqj6xlhq6il2tof0z/1tbiERyYI2iHhRsJsgAAs8

operations blocks the I/O process
when during the process
Issue encountered:
When formatting an SD card to ext4 using mkfs.ext4,
if the card is ejected during the process,
the formatting process blocks at
balance_dirty_pages_ratelimited.

task:mkfs.ext4       state:D stack:
 0 pid:  900 ppid:   889 flags:0x00000000
 (__schedule)
 (schedule) from
 (schedule_timeout)
 (io_schedule_timeout)
 (balance_dirty_pages_ratelimited)
 (generic_perform_write)
 (__generic_file_write_iter)
 (blkdev_write_iter)
 (vfs_write)
 (ksys_pwrite64)
 Exception stack(0xc2283fa8 to 0xc2283ff0)

Modification approach:
After card ejection,
the dev in the bdi (backing_dev_info) is
released in del_gendisk.
Within generic_perform_write,
if writeback is supported,
it directly checks whether bdi->dev is NULL to determine
if the card has been ejected.
Once ejected, it becomes unnecessary to proceed
with page allocation and data writing.

Signed-off-by: laishangzhen <laishangzhen@163.com>
---
 mm/filemap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 6af6d8f29..5d6ba9f02 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4087,6 +4087,8 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 	struct address_space *mapping = file->f_mapping;
 	const struct address_space_operations *a_ops = mapping->a_ops;
 	size_t chunk = mapping_max_folio_size(mapping);
+	struct inode *inode = mapping->host;
+	struct backing_dev_info *bdi = inode_to_bdi(inode);
 	long status = 0;
 	ssize_t written = 0;
 
@@ -4101,6 +4103,12 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 retry:
 		offset = pos & (chunk - 1);
 		bytes = min(chunk - offset, bytes);
+		if (bdi->capabilities & BDI_CAP_WRITEBACK) {
+			if (bdi->dev == NULL) {
+				status = -ENODEV;
+				break;
+			}
+		}
 		balance_dirty_pages_ratelimited(mapping);
 
 		if (fatal_signal_pending(current)) {
-- 
2.25.1


