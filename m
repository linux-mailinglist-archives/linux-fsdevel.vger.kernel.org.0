Return-Path: <linux-fsdevel+bounces-27291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2DF9600DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 07:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D391C21F08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 05:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086D712C80F;
	Tue, 27 Aug 2024 05:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Oqh43pau"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B724671B3A;
	Tue, 27 Aug 2024 05:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724735435; cv=none; b=tzBE1d/p6agnFgZpBvZ9CAr1+E7vQ9W2bqT3Ao5rqnOqi5XVnrgio3h3enaFaKCvnP1hZB86+NNd49iEQAuiKH5ZytEZF8jdAoRvLtCW9oatnwKutTfgZjtZIxub6lIu4QVWCpazf7Jb7l+TnHtD1/V+3CElEcYtxsC3OCQPGRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724735435; c=relaxed/simple;
	bh=S4t0YJTaUsVaXaw2toaWNEboaIubRMWMnQ8nWtOZio4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnrkzLzw2mJ3MuLYoMsXJdMVjmJPx3qDZwM2BhaBeUJbp20uXfPM29AHiX22asp1e3b1dw9+Ansihk0bIYVnBgw40vf3JOAeNvtTsJyeRD51EYj+lcqKBNy3vSpas8XV85d7eIq8bYFQVbCdLg7T39BL6LEUymF0MwHqUH8gBnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Oqh43pau; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gaLvMRbUaWGWc7eCBYjA9sjU57Va5YYkXOlLMnWX0pk=; b=Oqh43pauk3NkAmTm96dahQtRGR
	hDfALRqBZgH9rjyccbuVhjvttLY6i0uuTNn425m7DhxHec09u6GagJ3UTkv7CjVlLVCYwCio8lTAF
	TWd2girRs+9pyrvyDAH8bs2ZqjKvBIUO7SKahkHIjm1b3MwPdiWxSFgo3YLvCO0lKqfPWn0ISY2MD
	BPBOfBSAUyoomiPFEOpztzRJFPmSw8e2+Jcg+DnXKgsKXcL/e/QbctRhFbv1rRt2onWsvwibJBWeQ
	038nyv70tg6e+Dhf1dy83fr+KZKDS/U7xDpMIaeeDUzRG6YiHPbpbhRgJ65WG2hIJAXoZMfkp0/67
	JQ8J7OXA==;
Received: from 2a02-8389-2341-5b80-0483-5781-2c2b-8fb4.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:483:5781:2c2b:8fb4] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sioTQ-00000009oqB-3GIT;
	Tue, 27 Aug 2024 05:10:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/10] iomap: handle a post-direct I/O invalidate race in iomap_write_delalloc_release
Date: Tue, 27 Aug 2024 07:09:48 +0200
Message-ID: <20240827051028.1751933-2-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827051028.1751933-1-hch@lst.de>
References: <20240827051028.1751933-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

When direct I/O completions invalidates the page cache it holds neither the
i_rwsem nor the invalidate_lock so it can be racing with
iomap_write_delalloc_release.  If the search for the end of the region that
contains data returns the start offset we hit such a race and just need to
look for the end of the newly created hole instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f420c53d86acc5..69a931de1979b9 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1241,7 +1241,15 @@ static int iomap_write_delalloc_release(struct inode *inode,
 			error = data_end;
 			goto out_unlock;
 		}
-		WARN_ON_ONCE(data_end <= start_byte);
+
+		/*
+		 * If we race with post-direct I/O invalidation of the page cache,
+		 * there might be no data left at start_byte.
+		 */
+		if (data_end == start_byte)
+			continue;
+
+		WARN_ON_ONCE(data_end < start_byte);
 		WARN_ON_ONCE(data_end > scan_end_byte);
 
 		error = iomap_write_delalloc_scan(inode, &punch_start_byte,
-- 
2.43.0


