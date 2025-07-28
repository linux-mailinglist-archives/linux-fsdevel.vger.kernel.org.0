Return-Path: <linux-fsdevel+bounces-56135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D62DCB13C83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 16:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E83F4E5C38
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 14:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287DD28643C;
	Mon, 28 Jul 2025 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="B+UCZ155"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1692F2749D2;
	Mon, 28 Jul 2025 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710986; cv=none; b=O0tTpc3PV5aybUJZzvFpajcZc+GYGBM4sWViLT/mzK/6IAv4B8+wPFcbce7PTuiGJLbYNtHFeyG8IF8u/hhJXFkoWAwVehBVtwouvoxMh3FPca4BMLPHVbfHR9dDHsJXor6Frgjy+wWcIFsnlwJGIPpQitZK5BnFksC1+Fw2y1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710986; c=relaxed/simple;
	bh=M7lnc7klguOFW0Jnl78Y6Htaz7nDBI55ytpfcb52tVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sa+M15jOr1MLhOrcrhp7jGFo6zaMcrcAiBh3MMA9q8t4UEodU/BF32Ce4xisc9T7hav4ZMklzJvha3lVloiOxG/IUYv/5IpM41r/ZOgn9eimZaL0CA2AEMnShTqNdp8hte2kXlGdmAkC/Qp3OflIwOD0VquGK4x3LRYPlIx36SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=B+UCZ155; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=H8
	Z98UX2QpJKHJm1iEKGrjeoRwfUPLLQylyfYu9g+Dk=; b=B+UCZ155/X6hYKzgMP
	Hs3muIDpDejfuzqVxcbn7PY3B74oWEJvr+G5EPiadC6sLa33MOJkoYNgnE61Zt5d
	rEJJh7Vr/yd+H6/eWlFTXItSI+IHcc/YwGWoqVs9LSWJv0oQK4ILx98Hsdhl8aKo
	7PYCfSLTEs/5iFzm9YoEEDYts=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDXGWVugYdoBTOdBA--.31694S2;
	Mon, 28 Jul 2025 21:55:59 +0800 (CST)
From: laishangzhen <laishangzhen@163.com>
To: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	laishangzhen <laishangzhen@163.com>
Subject: [PATCH] mm: Removing the card during write operations blocks the I/O process when during the process Issue encountered: When formatting an SD card to ext4 using mkfs.ext4, if the card is ejected during the process, the formatting process blocks at balance_dirty_pages_ratelimited.
Date: Mon, 28 Jul 2025 06:55:56 -0700
Message-Id: <20250728135556.20583-1-laishangzhen@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDXGWVugYdoBTOdBA--.31694S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrW7XryrKr1kGF4rZF13Jwb_yoW8GF18pF
	yak39akrWUZr42gw1xGayDur4Y9FyrG3yUXFyUZa4avwnxWF1xKFWIga47KFy5tr95Cr12
	qrs0y34Uuw1jyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UMlk-UUUUU=
X-CM-SenderInfo: podl2xhdqj6xlhq6il2tof0z/1tbiYh6YI2iHfU4PGQABsM

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


