Return-Path: <linux-fsdevel+bounces-74397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E843AD3A064
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3E2D303C119
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C563382E5;
	Mon, 19 Jan 2026 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gay7B73G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CEE3382CD;
	Mon, 19 Jan 2026 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768808727; cv=none; b=UqzUPM5PhZAeMZs72YpXZTQCDgDNnYTchm66M1cjA5f6Gv7hIn1+DwiLqiKVjFMyMIVM6e/ffGF3LFrHyRgITQPg2MWjPbwO7qgK5l83Z9l8YUw2Qk5xRYQrGOLPB/23gvniqCnmewHYoxJka1Uo8yBAhfE03ymsfM+9ga3NYd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768808727; c=relaxed/simple;
	bh=eMCt5Bk8dxJKZvt0kWB+MCKMgzQ7r3kkqjcfb8YMzYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNicKzxTCNv4/ubHxqFAt73DgOLO0i+aLy9ZYfKIECaIewhyF9OEl0eYsXHb2j+47D22YE3oyyX4HFKeNp/R4jsx+pHYWR1FH2wI9WM1lJ9cS+SFSkbFtpAF2d4g6tMhP2bKXKDn/+xgrd+psvgqf8u6LPqL8te/xy7JLL8EyGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gay7B73G; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=xYo9ZJySOOSi7c/rP8mEH/tx3ezwTWHQ/FNGar6as5c=; b=Gay7B73G3A1jGqyy5h61792xpu
	jhBDzqGXF7gOCQAFO9cAqOqrTCURiR4hMkz/hy4uuNfIA99VT7L8S/Ei9yGK1ZHV/eOWMpkhASosO
	t8sD8T+ge+lQn5PPWvkG55BUCwESdXeyGDzZ1sX84QjG5ROcRsZuMDQPIxw0zr3o/AEmPoNATS4ga
	Qyxw5z5AhkF8rlSlDni2BaeZ7AwlYnf9r1Izfe+l1VDY/qe5oRVyeivHFQHAffGZbEBPzbF49FbEt
	L71MomQWduTy7kq/MruBf4jeFnSVB2MAVrWr1D2d4FvHSmN8sewdiBDYnt0JL7EJJV4l0eNPnl7Gp
	egnvdJLQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhjwy-00000001WGO-1xvj;
	Mon, 19 Jan 2026 07:45:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/14] iomap: support ioends for direct reads
Date: Mon, 19 Jan 2026 08:44:19 +0100
Message-ID: <20260119074425.4005867-13-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260119074425.4005867-1-hch@lst.de>
References: <20260119074425.4005867-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Support using the ioend structure to defer I/O completion for direct
reads in addition to writes.  This requires a check for the operation
to not merge reads and writes in iomap_ioend_can_merge.  This support
will be used for bounce buffered direct I/O reads that need to copy
data back to the user address space on read completion.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/ioend.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index 86f44922ed3b..800d12f45438 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -299,6 +299,14 @@ EXPORT_SYMBOL_GPL(iomap_finish_ioends);
 static bool iomap_ioend_can_merge(struct iomap_ioend *ioend,
 		struct iomap_ioend *next)
 {
+	/*
+	 * There is no point in merging reads as there is no completion
+	 * processing that can be easily batched up for them.
+	 */
+	if (bio_op(&ioend->io_bio) == REQ_OP_READ ||
+	    bio_op(&next->io_bio) == REQ_OP_READ)
+		return false;
+
 	if (ioend->io_bio.bi_status != next->io_bio.bi_status)
 		return false;
 	if (next->io_flags & IOMAP_IOEND_BOUNDARY)
-- 
2.47.3


