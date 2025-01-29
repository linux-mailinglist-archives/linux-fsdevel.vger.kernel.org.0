Return-Path: <linux-fsdevel+bounces-40279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D92A217C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 07:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5020E1889B7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 06:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668271917C2;
	Wed, 29 Jan 2025 06:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kX5o/Z/F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069C3823DE
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 06:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738132684; cv=none; b=ZpYMZPiAoj8Z+91gXvV8He7ql5EgxI1/mNBvbHHlItoSNnkoLjeMfwMEbOWAzbQJfmt5NPJ4abzOjvKUfkPJ01wlbbUTx+ArgejJ1bpu9llj8fhQfGcZYvavN4QK9C/pfYj4rhifU18ojJGh29ZFyPD61pBi/uG8QnIJY0IraFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738132684; c=relaxed/simple;
	bh=ja99L19tyzg1f2oieyS7aY+RGqgTZFbMGBmYwghi+XE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j1W5BJ5g7pqkIDqB2ljvqiAlBPuuqglxKuQQei/G8MljNPB1rj2bk8IDbnBN5Pfl8jEhtNI/3UeKhZ6M9b0afOX8c1aE/sj9cGFoQj836p2LeutYzacGfhVG3ReL1KfA5vkpdfNUUMidOQDv6iftrCAh0F2YD21FV4NHLnn9wQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kX5o/Z/F; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=5xn3IQWMJ0ADbIZ3DGYymHjJ7XOcOQdXNRfTv4KnLkc=; b=kX5o/Z/FVOZN0VIyGdFi/6C7ft
	N2U4Az3y91mCTsoU7MWSR8fR4ABQRq7j2eFRJpzmw8nlo5AT2+bn2WGrqq7fYfH9Mjv/w8wPOQf8c
	5Qdq20UFdycwrtJ2Os9S2c9ZlmbIv1cQRJrw/33Y6U5W6SZMwihu9HD+u7s1OBt0/PV9ad6UgJgjB
	VvVT9g75tHGCpauX1n+KzfskfpNCN83ysOgP1/L6z9xYjZ/xWIkmffw5+7ARv7u3j8WCAkByyXs4U
	BwM7U3XSrC+duEsGrPUDHc3epCT7MFKjl8IbnSgflbcu3SumKoo1IuMHYWxSdmF4OU/+Bj1Lf2pxQ
	s0usNmsQ==;
Received: from 2a02-8389-2341-5b80-9363-724e-578a-a8b5.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9363:724e:578a:a8b5] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1td1i6-00000006QSv-0jas;
	Wed, 29 Jan 2025 06:38:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: pack struct kstat better
Date: Wed, 29 Jan 2025 07:37:57 +0100
Message-ID: <20250129063757.778827-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Move the change_cookie and subvol up to avoid two 4 byte holes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/stat.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/stat.h b/include/linux/stat.h
index 9d8382e23a9c..be7496a6a0dd 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -50,11 +50,11 @@ struct kstat {
 	struct timespec64 btime;			/* File creation time */
 	u64		blocks;
 	u64		mnt_id;
+	u64		change_cookie;
+	u64		subvol;
 	u32		dio_mem_align;
 	u32		dio_offset_align;
 	u32		dio_read_offset_align;
-	u64		change_cookie;
-	u64		subvol;
 	u32		atomic_write_unit_min;
 	u32		atomic_write_unit_max;
 	u32		atomic_write_segments_max;
-- 
2.45.2


