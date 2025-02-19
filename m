Return-Path: <linux-fsdevel+bounces-42104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 042A4A3C696
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 18:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC5F3AC6DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 17:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4086214A6C;
	Wed, 19 Feb 2025 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sj1Q/kDy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F30214A6D
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 17:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987309; cv=none; b=czJVleOf/ikOR2IBz5sayrGZq74m/PDHqGfo1bOi7DwPHlHXCs5uB8pwFAz1+gaazhRfSzlW/GrlXdxRyetD6Atf07d7J9UNJEqMCIXqK+0A/CYp8IyUlfRFQSTQUEit8VPlFxIuzsiVngfN/b7FdRyufK7PbamGv8iMlgG/Hd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987309; c=relaxed/simple;
	bh=TJhPfCpHHrk0QoHd0ww3r+fTIndQ0XEkWC4GeZ2m/qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lTXghsx5d35fncobGF43looC3FYlg5ycKtRsqVuq7qA8gz1z7kmduaZxTiNQi1tP9fXkhfsvgdwSo7Cwj50z8RvE56IyMm2ZuwAzqxS3/KsY/fIn+yKFRilsbWvmbZLUos7lR0IWPq/2qQhN8cMDjKqUhJNqNEzqdU2qTk60cGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sj1Q/kDy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739987306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i0/1y43pgdZP03yE4cQ5PiDKyBLP+U1es9y9NctDUwY=;
	b=Sj1Q/kDyypQNuZa5tQ0MkS4GMZwo4SXFGj1iXda3Q/mR545TkKNT7QXwqxjVBjDyEirS+o
	/LYh/ssqe8JSUdPkDSF8Gf0r/w/VIbXN4xdKUnldQg3XRxi46pD/etqCXRl950/0Ffr58Q
	d38BuWJlxTXKnXk69TPF1zYqvDOcfU0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-tk5WNqtAP6SfF7ZaQGhHhA-1; Wed,
 19 Feb 2025 12:48:23 -0500
X-MC-Unique: tk5WNqtAP6SfF7ZaQGhHhA-1
X-Mimecast-MFC-AGG-ID: tk5WNqtAP6SfF7ZaQGhHhA_1739987302
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 565301800992;
	Wed, 19 Feb 2025 17:48:22 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.79])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 64ADF1800265;
	Wed, 19 Feb 2025 17:48:21 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v2 07/12] dax: advance the iomap_iter on unshare range
Date: Wed, 19 Feb 2025 12:50:45 -0500
Message-ID: <20250219175050.83986-8-bfoster@redhat.com>
In-Reply-To: <20250219175050.83986-1-bfoster@redhat.com>
References: <20250219175050.83986-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Advance the iter and return 0 or an error code for success or
failure.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/dax.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index f4d8c8c10086..c0fbab8c66f7 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1266,11 +1266,11 @@ static s64 dax_unshare_iter(struct iomap_iter *iter)
 	u64 copy_len = iomap_length(iter);
 	u32 mod;
 	int id = 0;
-	s64 ret = 0;
+	s64 ret = iomap_length(iter);
 	void *daddr = NULL, *saddr = NULL;
 
 	if (!iomap_want_unshare_iter(iter))
-		return iomap_length(iter);
+		return iomap_iter_advance(iter, &ret);
 
 	/*
 	 * Extend the file range to be aligned to fsblock/pagesize, because
@@ -1307,7 +1307,9 @@ static s64 dax_unshare_iter(struct iomap_iter *iter)
 
 out_unlock:
 	dax_read_unlock(id);
-	return dax_mem2blk_err(ret);
+	if (ret < 0)
+		return dax_mem2blk_err(ret);
+	return iomap_iter_advance(iter, &ret);
 }
 
 int dax_file_unshare(struct inode *inode, loff_t pos, loff_t len,
-- 
2.48.1


