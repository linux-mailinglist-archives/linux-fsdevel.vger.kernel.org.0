Return-Path: <linux-fsdevel+bounces-41215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC33A2C55C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 15:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818C1167B30
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 14:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFA7240611;
	Fri,  7 Feb 2025 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ynazx5yG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D66E23ED7A
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938640; cv=none; b=tYXesngRexUljSalfcZHRRNm6DwNvPCi9qop8MzBWJe+a/wwsWRFkgR7Mqw/EepdHttxbxHZOe/IJ9+MuH2W8OtcJpCwjeikm1ifvqzkXWTZyFwlHls6oqNOvfaX1Cp38DU8nwCFYvYiVALW6FddQjrdP58NlpsozbEXbQx3P9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938640; c=relaxed/simple;
	bh=na4YSH4CgAqiXwMdm22Qrd8QQiGd54/+znYyiV2Wt18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Je83Pg0u6JVIApOQF+96AxxNKYKfT8tCBsWbskbB9lKf4q2j9LHnWFIiXxzSn/ypEjKhkUX5RUOG4bye2ysr4vSQv38Rv3KskefO0ugfW08+JPWnHxuohxiCNQhEBM8Qwp0He/XZFmzzc0fquUb2XABrzku/VqLvuAUocPEkJuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ynazx5yG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738938638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4FSdbsKwRT9woJafVkICOpQsJw2U8CFO8aaAxAD6Ms0=;
	b=Ynazx5yGVna9hh2+eKjghkb8kwMEcA3nzketeftbuU/Nyrk6ZsmtIPPA2mzcwqBtd7xGSO
	iJEnc21tSb0F/XYFaEk48PSedxITWH9ikJLBK0XYDz1qHneHtV+eYoYSE7TZL36ONHUqIZ
	HHJQj4bvQ5RNEzhB1eWR64u2h+qJ4RA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-FG_heTiFO-muDCvp-KrNpQ-1; Fri,
 07 Feb 2025 09:30:33 -0500
X-MC-Unique: FG_heTiFO-muDCvp-KrNpQ-1
X-Mimecast-MFC-AGG-ID: FG_heTiFO-muDCvp-KrNpQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 71C781955D53;
	Fri,  7 Feb 2025 14:30:32 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.48])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 87E701800879;
	Fri,  7 Feb 2025 14:30:31 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v6 04/10] iomap: lift error code check out of iomap_iter_advance()
Date: Fri,  7 Feb 2025 09:32:47 -0500
Message-ID: <20250207143253.314068-5-bfoster@redhat.com>
In-Reply-To: <20250207143253.314068-1-bfoster@redhat.com>
References: <20250207143253.314068-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The error code is only used to check whether iomap_iter() should
terminate due to an error returned in iter.processed. Lift the check
out of iomap_iter_advance() in preparation to make it more generic.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/iter.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index a2ae99fe6431..1db16be7b9f0 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -30,8 +30,6 @@ static inline int iomap_iter_advance(struct iomap_iter *iter, s64 count)
 	bool stale = iter->iomap.flags & IOMAP_F_STALE;
 	int ret = 1;
 
-	if (count < 0)
-		return count;
 	if (WARN_ON_ONCE(count > iomap_length(iter)))
 		return -EIO;
 	iter->pos += count;
@@ -71,6 +69,7 @@ static inline void iomap_iter_done(struct iomap_iter *iter)
  */
 int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 {
+	s64 processed;
 	int ret;
 
 	trace_iomap_iter(iter, ops, _RET_IP_);
@@ -86,8 +85,14 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 			return ret;
 	}
 
+	processed = iter->processed;
+	if (processed < 0) {
+		iomap_iter_reset_iomap(iter);
+		return processed;
+	}
+
 	/* advance and clear state from the previous iteration */
-	ret = iomap_iter_advance(iter, iter->processed);
+	ret = iomap_iter_advance(iter, processed);
 	iomap_iter_reset_iomap(iter);
 	if (ret <= 0)
 		return ret;
-- 
2.48.1


