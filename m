Return-Path: <linux-fsdevel+bounces-40916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD82A28D00
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 14:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095483A9534
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 13:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC78155342;
	Wed,  5 Feb 2025 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXNHVt2u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587AF13C9C4
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763766; cv=none; b=CzY9/O7qR0d/bL/5a86eFRUVB5GeYFH5fJdKrdyktEpkPg9iDcsTenr3wHlmR3IsNTmW8cw55+DO7jQ6efVaVK6u3U7g+Xrf6zcWtc4I/LrzyipRiZhFk9XM9qnUPRB4lPIx3dbtQ2RE9fqXQhVaPNAdvMi1DQtj2uMs/7Eq2Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763766; c=relaxed/simple;
	bh=9oB6PemU0c5CJwosJMK1zk8OzCjgnQ4O5fW4v1NJf6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BPDAsiLdHGa4gm6v/DL9UZxJMPqainV6Kng4zatXTDE7U8Kj6oVEKctqVhr28axqziIVVXB6vBeONS+2JHVbBsnq9yXQbSoLL3R+KG/QkMVVRP78WXQTt4WD1RPN/OeuQgSVaaGcGJHGSWxYp+62ZwD74uS/k80Jgw64Uj0C4DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXNHVt2u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738763764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7QRCZkyDB49xYeWgWJH729XS1migioCTCHviGIWDHFo=;
	b=cXNHVt2uq72SPFPwTeKP6T9MLN7p67CbDh91LVsLjnDs8tuGfHxLofG/qLZboBwbqgSz7w
	p1igP1vPB9+pEprZRPJ3brUm4O77L4MJfMJBnpjYEsEhGmM5XOHoRA1OWTbdz+sonJx9Lb
	bgMst9RMmKqQgshLwzmxzzr2TKzx2uc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-rgNnY8stN020ZcrdMEWzOQ-1; Wed,
 05 Feb 2025 08:56:01 -0500
X-MC-Unique: rgNnY8stN020ZcrdMEWzOQ-1
X-Mimecast-MFC-AGG-ID: rgNnY8stN020ZcrdMEWzOQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C09FA1800877;
	Wed,  5 Feb 2025 13:55:59 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CBC783000197;
	Wed,  5 Feb 2025 13:55:58 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v5 03/10] iomap: refactor iomap_iter() length check and tracepoint
Date: Wed,  5 Feb 2025 08:58:14 -0500
Message-ID: <20250205135821.178256-4-bfoster@redhat.com>
In-Reply-To: <20250205135821.178256-1-bfoster@redhat.com>
References: <20250205135821.178256-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

iomap_iter() checks iomap.length to skip individual code blocks not
appropriate for the initial case where there is no mapping in the
iter. To prepare for upcoming changes, refactor the code to jump
straight to the ->iomap_begin() handler in the initial case and move
the tracepoint to the top of the function so it always executes.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/iter.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index 731ea7267f27..a2ae99fe6431 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -73,7 +73,12 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 {
 	int ret;
 
-	if (iter->iomap.length && ops->iomap_end) {
+	trace_iomap_iter(iter, ops, _RET_IP_);
+
+	if (!iter->iomap.length)
+		goto begin;
+
+	if (ops->iomap_end) {
 		ret = ops->iomap_end(iter->inode, iter->pos, iomap_length(iter),
 				iter->processed > 0 ? iter->processed : 0,
 				iter->flags, &iter->iomap);
@@ -82,14 +87,12 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 	}
 
 	/* advance and clear state from the previous iteration */
-	trace_iomap_iter(iter, ops, _RET_IP_);
-	if (iter->iomap.length) {
-		ret = iomap_iter_advance(iter, iter->processed);
-		iomap_iter_reset_iomap(iter);
-		if (ret <= 0)
-			return ret;
-	}
+	ret = iomap_iter_advance(iter, iter->processed);
+	iomap_iter_reset_iomap(iter);
+	if (ret <= 0)
+		return ret;
 
+begin:
 	ret = ops->iomap_begin(iter->inode, iter->pos, iter->len, iter->flags,
 			       &iter->iomap, &iter->srcmap);
 	if (ret < 0)
-- 
2.48.1


