Return-Path: <linux-fsdevel+bounces-56163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43285B14317
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 22:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1858E3A9B08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 20:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2457E27A928;
	Mon, 28 Jul 2025 20:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HoM9Aznw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDB52798F5
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 20:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734692; cv=none; b=rkUnRZBtbNArTQryIKBZVhE5cB++un2dlVebWbhYnsLH0y9RLkZCSDnq7TToBmEd1Ct38BX7sxs/zZuKK9MpraEgE0NYZDQp5tyW1jpQWRyTRV35/WBalJY9fsvvKklcGBbxEAC7HnjuauGxwEBlp8sxt2Ghuq4zfWBWjUKbSWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734692; c=relaxed/simple;
	bh=4jwM6yZoG2QL8nW1AaAsyE3BFv603Ald1wasU+AZ8z8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h5juA6+7xk6g6KM5vji8ccsX9oufvQzAc6VeJWaGJlY/UuiiSdnNhnV6yf97OyeNXmV3FmB2A9WxG76ZpmqijLmPbRiekzj+E9xOURzx+b/8PhSZioZSPz8PSKbEfGKAwj4xyXlb1cO/IMSrzmev17K4LMJ+ZfpT7FTp9AQ4MHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HoM9Aznw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753734688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xWwhSxOUUlFkr21WMezNeO1NDRzof5IufK1F2aPQDsc=;
	b=HoM9AznwUtAkHVMoHTpkcdm8knobhDx8J9Y5Wg6A1SemFWSVob01PIWv7N1k4a1wIChlHb
	R5E+GHwTQnkNifZzOFgO7bFxLwg6tK8OCsBjTn4Loz3WusZimt+zNCyzQj08gycFUf9BDq
	xM/wxz5N9CpLI4Jg2/fwsqAPNPmS8vk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-Q5qkaGRvNeq0eG8KFyGUbA-1; Mon, 28 Jul 2025 16:31:27 -0400
X-MC-Unique: Q5qkaGRvNeq0eG8KFyGUbA-1
X-Mimecast-MFC-AGG-ID: Q5qkaGRvNeq0eG8KFyGUbA_1753734686
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-61544020fdeso998968a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 13:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734686; x=1754339486;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWwhSxOUUlFkr21WMezNeO1NDRzof5IufK1F2aPQDsc=;
        b=KO3Z/rddBIzrTW2LLQs7eLZ1cvaawX3sXPOOSaUkjHHBMcZHkwo9OaRivAljhpBWV5
         TEg1XH14uv84u1BGl7djY5zzv1Jv7BJUbpEeuL/+7BrUePYE/I9MHkFKcY73UDSTqa2a
         QkD9RkBwElK17iE74Ftf4F7N5V9JSiMyf5ebS1Tw98xnMptsud2aIRjXEOg5pPcofVcA
         RTmOMJIM8Y/UHNYUaBPrmaJLMEryi1nESx3lC2+y5zJeJeMszL5N2aLdj6xul4H75GO7
         4NOZTxlXD3FgdTyGGw/66OeAdz8Y4ARDiMSe4psITjeLS9Gaj6RtSSSX0vRWjCFhbTsb
         eoLg==
X-Forwarded-Encrypted: i=1; AJvYcCWbSOhQ0w9JRkxB7AN4tBWTnaau8OR+tteeoyBQ9nmUW9OHRpNQedF2V3dsjX6+WkCCFYWqOc/o7XPHgrao@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs0Y0Ax7yjMuWz2ygz42/hFTSggqBzqaD6/cWyUoG5vj9yMNdE
	2csoSvHl4GIioRXtFASkPsvCt6Ft8RSuHkDvb0Y8+FILAuduk4EPPp/y+ZXGPqNnqwYvVv5rCQg
	bSOVJAW89A8NYzgmIozefmAgBBT0oMSOZYmSE95s2QAE3+pPMGVlaLxaxN1mXKgdmXg==
X-Gm-Gg: ASbGncuCs4t6cQUnRrVqV1zzXIJxu0v07I0rJEQ+FA5N1pQTkTlqdBxJpN3MyicW7zR
	8H7GKnYYMhZ0VSJHtG5KYUikg/V8cIc2LJWTtcMFSPL57ItUmThLh960E1JWmoPRC7y8VLajAuu
	Ww7jG6KBxU7KH/jwdVnZ95zRxeHL4a3FJp3E2N1aUFoUBKtcWpCmWXjiSrz57DX6XbYktjP8N2N
	XCQ1Lkwg5JgnFuNVpAK+FQhNKaThEfjxX/MbQKpjaP23uaVFMUW7PQV0vNQATe4QTjAeHj/aAlo
	zb2C75y4dqDDh0aFYi+i4uT7vo9JA1wZJ2JTmJCMW5CHqQ==
X-Received: by 2002:a05:6402:42c4:b0:615:23ce:9031 with SMTP id 4fb4d7f45d1cf-61523ce97fbmr7194092a12.16.1753734686038;
        Mon, 28 Jul 2025 13:31:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnwYXbiQvsvhwEuBOadWhri8UX7ZwmJgBSjpO9xkCEvTMLDLn+RlfJRfVKMPjI2dCi1WnbCw==
X-Received: by 2002:a05:6402:42c4:b0:615:23ce:9031 with SMTP id 4fb4d7f45d1cf-61523ce97fbmr7194064a12.16.1753734685493;
        Mon, 28 Jul 2025 13:31:25 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615226558d3sm2730656a12.45.2025.07.28.13.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:31:24 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 28 Jul 2025 22:30:08 +0200
Subject: [PATCH RFC 04/29] fsverity: add per-sb workqueue for post read
 processing
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-fsverity-v1-4-9e5443af0e34@kernel.org>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
In-Reply-To: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
To: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org, 
 ebiggers@kernel.org, hch@lst.de
Cc: Andrey Albershteyn <aalbersh@redhat.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3951; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=fzST6C8J9XGl2wB+UoSLkV5QHNlJbuLG+ZHaPWv62hs=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtrviRv55T/1SLbkuXFk3aL/R1yNT4WYcjIfM+mwX
 dvLPN3szMaOUhYGMS4GWTFFlnXSWlOTiqTyjxjUyMPMYWUCGcLAxSkAE3l0mOGfeUnG2Y2r05Jj
 tR/cqu+MaDRy/Wfc3Xt5op4DY/16plczGP575r1KexLAyS/Xw7xB9YL+JZ2Ctu8HnESqkrewZBf
 bPWIHAOcYRic=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: Andrey Albershteyn <aalbersh@redhat.com>

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
[djwong: make it clearer that this workqueue is for verity]
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/super.c               |  3 +++
 fs/verity/verify.c       | 14 ++++++++++++++
 include/linux/fs.h       |  2 ++
 include/linux/fsverity.h | 18 ++++++++++++++++++
 4 files changed, 37 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 80418ca8e215..f80fe7395228 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -37,6 +37,7 @@
 #include <linux/user_namespace.h>
 #include <linux/fs_context.h>
 #include <uapi/linux/mount.h>
+#include <linux/fsverity.h>
 #include "internal.h"
 
 static int thaw_super_locked(struct super_block *sb, enum freeze_holder who,
@@ -639,6 +640,8 @@ void generic_shutdown_super(struct super_block *sb)
 			sb->s_dio_done_wq = NULL;
 		}
 
+		fsverity_destroy_wq(sb);
+
 		if (sop->put_super)
 			sop->put_super(sb);
 
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 4fcad0825a12..30a3f6ada2ad 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -334,6 +334,20 @@ void fsverity_verify_bio(struct bio *bio)
 EXPORT_SYMBOL_GPL(fsverity_verify_bio);
 #endif /* CONFIG_BLOCK */
 
+int fsverity_init_wq(struct super_block *sb, unsigned int wq_flags,
+		     int max_active)
+{
+	WARN_ON_ONCE(sb->s_verity_wq != NULL);
+
+	sb->s_verity_wq = alloc_workqueue("fsverity/%s", wq_flags, max_active,
+					  sb->s_id);
+	if (!sb->s_verity_wq)
+		return -ENOMEM;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fsverity_init_wq);
+
 /**
  * fsverity_enqueue_verify_work() - enqueue work on the fs-verity workqueue
  * @work: the work to enqueue
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 040c0036320f..abe31e9959fa 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1350,6 +1350,8 @@ struct super_block {
 #endif
 #ifdef CONFIG_FS_VERITY
 	const struct fsverity_operations *s_vop;
+	/* Completion queue for post read verification */
+	struct workqueue_struct *s_verity_wq;
 #endif
 #if IS_ENABLED(CONFIG_UNICODE)
 	struct unicode_map *s_encoding;
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 1eb7eae580be..9b91bd54fb75 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -174,6 +174,17 @@ bool fsverity_verify_blocks(struct folio *folio, size_t len, size_t offset);
 void fsverity_verify_bio(struct bio *bio);
 void fsverity_enqueue_verify_work(struct work_struct *work);
 
+int fsverity_init_wq(struct super_block *sb, unsigned int wq_flags,
+		       int max_active);
+
+static inline void fsverity_destroy_wq(struct super_block *sb)
+{
+	if (sb->s_verity_wq) {
+		destroy_workqueue(sb->s_verity_wq);
+		sb->s_verity_wq = NULL;
+	}
+}
+
 #else /* !CONFIG_FS_VERITY */
 
 static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
@@ -251,6 +262,13 @@ static inline void fsverity_enqueue_verify_work(struct work_struct *work)
 	WARN_ON_ONCE(1);
 }
 
+static inline int fsverity_init_wq(struct super_block *sb)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void fsverity_destroy_wq(struct super_block *sb) { }
+
 #endif	/* !CONFIG_FS_VERITY */
 
 static inline bool fsverity_verify_folio(struct folio *folio)

-- 
2.50.0


