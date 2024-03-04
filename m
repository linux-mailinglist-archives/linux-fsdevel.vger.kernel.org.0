Return-Path: <linux-fsdevel+bounces-13528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC58870A42
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 20:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A89281457
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909237B3F8;
	Mon,  4 Mar 2024 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CcKKciCb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968F879927
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579544; cv=none; b=GNtHlRIDluSt7etSEDUyee9Ykj8S2cHOIoPIzqS6v75vBZnnO4TDpVzwZ68xzaVqucNCu74ZGkaYK0+yhgb+aHVq4vcW2bfxZhHlLPTa3a0OmJgjI3Gd0ZSmlZSTTPp53uFDiKtAqIHmSlggkKa8y6paVMtXOSwlmcyczQnKYxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579544; c=relaxed/simple;
	bh=sDEThmqM++bMzqlKwK8x625GnHfcmb9hJfMfz6jgYZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpZ+VJiRZhrU7W06ky9kpNQlyVdIfRrDhY+aRAGA6vZ19/HdTlutwnb1c324kQQ2y1Xpw0wPtAuJsxPn6eX/fj+u3ExHYSbYnS+LBNv27bt3A0H821OGCqFlY16Ynt16jCh7V5zfREBxzXD1xGmd7SoOA1IVFqItGpOhUUAXlUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CcKKciCb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709579541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=graH8ZPzxtQsrhXogzHScmOx9ifMSR2CUgJkhEM1Cxs=;
	b=CcKKciCbjXLmMJS5LkA3SWclW1XcqLMniZG9z2pAsNDFN7k+BkO5U90TMHZvAVE+QSe2si
	Qwy6EXEFk9EmdzPixVfVEzbvCUmY+uOA3SLdHHQROm8YKAIrXxrXod9/Nw2khPdOJr/haA
	e68pUb/zaR3BkreCaZLOBai/MYHIdGg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-18JOiBcLNna9O-DPZPjE4g-1; Mon, 04 Mar 2024 14:12:20 -0500
X-MC-Unique: 18JOiBcLNna9O-DPZPjE4g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a45095f33fdso185609066b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 11:12:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579539; x=1710184339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=graH8ZPzxtQsrhXogzHScmOx9ifMSR2CUgJkhEM1Cxs=;
        b=a+dwdixpp5L/8IaGBlMzrB4goIBQzQbQlgnWY9yU9DqYJ5cfCgwLkIrPT5UTvEwhqS
         z/T7gDfgV70l4mhO6Z0P/pM8SLLEdLdSv7K6NRsjEgi92zl3Ak+mdyhEuRjIIooO5CFW
         tp5uTVRw71/mgzWGufpIhlOTG5jSzTg3ASByLKWTvR/0VKeRjdCJRc1IJWHSc6o6Idsc
         8/EO0q3Ho7qNPRFNkSxjKlsU4idEKoK7yyhqgu5nHqPtrZjGMM4mrNd2PfDysWFtLVdL
         k6sv+Lo+KJMtaN93mJxYoYgvdFWk4Kx3AcaCqWLdoWsiXPF9TYQHY9Y0ZOn+M0QjcboT
         h7gg==
X-Forwarded-Encrypted: i=1; AJvYcCWtkt3PQcEhqB6F3ECwYlYKMeBeGSTgwN6mMvFyu47BSYw8RY34g20MJyCVrlZyRMnNQLUS9vVxtK85R0T7p5R1IdwmOGKyGPQ/35wMOQ==
X-Gm-Message-State: AOJu0YzQPjZGlAFAToMGBo7U+cT9c3/f0auQXAVLvu26Vn6HyFCVFrph
	AkirSeg+lHNiw8+/7KPCODqnPg/899jqi+6vWcESsReIcuj9bxD7NrsBdHT+lDt4fjeDBaDRO6a
	JFqjDYA4wavsjtk+9VZ4kFpI24N1jnIfDI6nWo9lznwgO3moBw1zaHmjRptW/iA==
X-Received: by 2002:a17:906:d95:b0:a45:6d38:60aa with SMTP id m21-20020a1709060d9500b00a456d3860aamr399033eji.30.1709579539070;
        Mon, 04 Mar 2024 11:12:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzsPizPQwgDmQjOA0fvjsoFryAmLstNe6rEfScpBzV8bLlIXJnNFMQAze9lhLTuBX2T/E13Q==
X-Received: by 2002:a17:906:d95:b0:a45:6d38:60aa with SMTP id m21-20020a1709060d9500b00a456d3860aamr398975eji.30.1709579538451;
        Mon, 04 Mar 2024 11:12:18 -0800 (PST)
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709064a4b00b00a44a04aa3cfsm3783319ejv.225.2024.03.04.11.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:12:17 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v5 08/24] fsverity: add per-sb workqueue for post read processing
Date: Mon,  4 Mar 2024 20:10:31 +0100
Message-ID: <20240304191046.157464-10-aalbersh@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240304191046.157464-2-aalbersh@redhat.com>
References: <20240304191046.157464-2-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For XFS, fsverity's global workqueue is not really suitable due to:

1. High priority workqueues are used within XFS to ensure that data
   IO completion cannot stall processing of journal IO completions.
   Hence using a WQ_HIGHPRI workqueue directly in the user data IO
   path is a potential filesystem livelock/deadlock vector.

2. The fsverity workqueue is global - it creates a cross-filesystem
   contention point.

This patch adds per-filesystem, per-cpu workqueue for fsverity
work. This allows iomap to add verification work in the read path on
BIO completion.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/super.c               |  7 +++++++
 include/linux/fs.h       |  2 ++
 include/linux/fsverity.h | 22 ++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index d6efeba0d0ce..03795ee4d9b9 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -637,6 +637,13 @@ void generic_shutdown_super(struct super_block *sb)
 			sb->s_dio_done_wq = NULL;
 		}
 
+#ifdef CONFIG_FS_VERITY
+		if (sb->s_read_done_wq) {
+			destroy_workqueue(sb->s_read_done_wq);
+			sb->s_read_done_wq = NULL;
+		}
+#endif
+
 		if (sop->put_super)
 			sop->put_super(sb);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1fbc72c5f112..5863519ffd51 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1223,6 +1223,8 @@ struct super_block {
 #endif
 #ifdef CONFIG_FS_VERITY
 	const struct fsverity_operations *s_vop;
+	/* Completion queue for post read verification */
+	struct workqueue_struct *s_read_done_wq;
 #endif
 #if IS_ENABLED(CONFIG_UNICODE)
 	struct unicode_map *s_encoding;
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 0973b521ac5a..45b7c613148a 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -241,6 +241,22 @@ void fsverity_enqueue_verify_work(struct work_struct *work);
 void fsverity_invalidate_block(struct inode *inode,
 		struct fsverity_blockbuf *block);
 
+static inline int fsverity_set_ops(struct super_block *sb,
+				   const struct fsverity_operations *ops)
+{
+	sb->s_vop = ops;
+
+	/* Create per-sb workqueue for post read bio verification */
+	struct workqueue_struct *wq = alloc_workqueue(
+		"pread/%s", (WQ_FREEZABLE | WQ_MEM_RECLAIM), 0, sb->s_id);
+	if (!wq)
+		return -ENOMEM;
+
+	sb->s_read_done_wq = wq;
+
+	return 0;
+}
+
 #else /* !CONFIG_FS_VERITY */
 
 static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
@@ -318,6 +334,12 @@ static inline void fsverity_enqueue_verify_work(struct work_struct *work)
 	WARN_ON_ONCE(1);
 }
 
+static inline int fsverity_set_ops(struct super_block *sb,
+				   const struct fsverity_operations *ops)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif	/* !CONFIG_FS_VERITY */
 
 static inline bool fsverity_verify_folio(struct folio *folio)
-- 
2.42.0


