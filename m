Return-Path: <linux-fsdevel+bounces-56171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B62B14320
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 22:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D5618C2D59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 20:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460CD27FB32;
	Mon, 28 Jul 2025 20:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fh6M79Eh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DF427EFEF
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 20:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734701; cv=none; b=sOodlrx6mDeEmVkrxRy3VjkAemTNnwWBlyPvSunFktRke7ArwikxtRAADbAaAos3NttoyJ3qKjkc679fr27A7bS4EC12qhs6OvRrGVPh6EjID3jtM7Q111ntFiid1274rRI5KN6A03dfGIV3OnQMwwdBvHDOSbMsKOiV0w0uXnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734701; c=relaxed/simple;
	bh=7y2AFsFUtHlKUtMlN3bWkhMdtdvOCRb36aeVqGybfmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GJPpb/vezSWBpzcFfvLNLjiC1NHXBR1wBPUFuUUnyph9dMGfe4X1kwqol30/ZNzqEN7C1H6VcN1dQyBhNkxyPrM2gedpA8qmvaHXeKvAMp59q5ZCe2XEEwPDiBXotj8Dpr6u9+NMhZ8D3auNd811amTmyPVQ0/20xgrHTTwLHrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fh6M79Eh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753734699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7i2vN8r2qGAStJwd2XHOVZqln7AWQXVAdnWk945Mkc8=;
	b=fh6M79Ehi8GteMJJVNlCZk5nWNw2yyy1Gzp/NJxcYmYQd977VJXJWFa4xWc5ESaS2fzeFv
	zujWCQv8SRRzfhMD4WwjN9jFr60zPwI4iObqQQ/cR+sPBWxoRIIpAzCzXVO8bUq3mBv5IG
	ohIOMqbYJb/URENbzKdE8YmL7cvpLU8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-cF9f_rK9PVqRA8FiDImhNQ-1; Mon, 28 Jul 2025 16:31:37 -0400
X-MC-Unique: cF9f_rK9PVqRA8FiDImhNQ-1
X-Mimecast-MFC-AGG-ID: cF9f_rK9PVqRA8FiDImhNQ_1753734697
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-612b700c54eso3942674a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 13:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734696; x=1754339496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7i2vN8r2qGAStJwd2XHOVZqln7AWQXVAdnWk945Mkc8=;
        b=jRg+8Vdxv2rIfnS1rTCDoKlWLfyOFbcGR7qxdSt+fvBatFzO9mw3nKfI/4+omwzzyi
         VkWLuat5VPxu8+pZlUEKMAPna43QZqcrX9Hm2NkW++schN2DUQ7dOhteJ8fG92aREa8+
         EZobXI0VrGldqhpd9sgwY0DN3Ho1LoDa3YDt8SI/NyPK+c8siEIi6JwHqCiz9hOLXO4Y
         Se4uN5bGBkBUmB7Qb8Q/8OJZeYkdFJ1OUFb7Tu1W01KWXcYxyMtwUblHtKKx+aPi4Q4Q
         ph8U6BkOywmeDAydClXhMIOHIpO0ZJ+hilDy0oNpWKwb+Xncy1qiVKnHQfND91LiiFal
         kPjg==
X-Forwarded-Encrypted: i=1; AJvYcCU0PeORWA7j5+2JNZXkXG6G8i0u3KQE4FE9v8pIZ1a72j4AHFGNTa2GS7OwWq8nhEzMfUx6fKWYO9CHLOd0@vger.kernel.org
X-Gm-Message-State: AOJu0YyV5NpeAuIKmcWIs+b6UimIjefL5cZZ8LQCujJvC5hzbKqnuNPL
	km5ZQ7lrXUCQvdLN7GRVCGnNKbg1YlfuHTL7MzFU3n/2gP2Ag4gk9Au33PwULOWf4yJ8hyFQj56
	h5StZoFeh1QEUDEnKkLq76azYrZBkSXabk8qhjnu0K2STKxunr29PBIN60elvDGvMqQ==
X-Gm-Gg: ASbGnctGEjNIQk5vSNt+ZIf6F1wxyOxZyGNxzKq8ljrOWFDNLdZEBnmCah6a6DekEYw
	isugnIb0V3cslPRA9W0vVak7+7nloW+wy1wD3oELD4PLkwz/vKOWtMBh58TwYVSXaOJqhZvzTuz
	DSsxn3TMMyJr5cUHqrNNAhPCtjTDzzx57Dp0DdGH/DoKZr0B/btremng6AagRaYk0zVW9Mgs4ap
	r8EDLa04WcVDpx8WfrCOXqmmaBIXJIZ38sLknuapsgFYF1vOSXkXDzySfmQX8HnGZz4Hb4Yh6BU
	QXVhqkE+VPvN3t8w3aeSIb07HKjphA8oGwBV2fCbu4hC3w==
X-Received: by 2002:a05:6402:2810:b0:612:9e3b:ff99 with SMTP id 4fb4d7f45d1cf-614f1bdd0ccmr10731745a12.9.1753734696463;
        Mon, 28 Jul 2025 13:31:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaC0c3MpMoqnbG8xUhTGHoaDuL73lZSJnL7cBsHhGP48c/lcInjGrmBMSkIob2Ujz9GQVRNA==
X-Received: by 2002:a05:6402:2810:b0:612:9e3b:ff99 with SMTP id 4fb4d7f45d1cf-614f1bdd0ccmr10731731a12.9.1753734695990;
        Mon, 28 Jul 2025 13:31:35 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615226558d3sm2730656a12.45.2025.07.28.13.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:31:35 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 28 Jul 2025 22:30:19 +0200
Subject: [PATCH RFC 15/29] xfs: add fs-verity ro-compat flag
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-fsverity-v1-15-9e5443af0e34@kernel.org>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
In-Reply-To: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
To: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org, 
 ebiggers@kernel.org, hch@lst.de
Cc: Andrey Albershteyn <aalbersh@redhat.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2599; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=UGW6IC+hs9WqEi7Nb4NFJ3Osu82F6RaLqbhdO6XoOf8=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtrvSfhpf0mPer5hQuG1Sve9oS1L3cIb671rXlVX2
 vO0fbszOaijlIVBjItBVkyRZZ201tSkIqn8IwY18jBzWJlAhjBwcQrARFL3MTIst1bOv6RX+MFu
 Y3zRx+eXtX7li8q+y1tkM+26nueWLJFahr+S3wrVcs5PWrh4v4zjCuGyFaFXT9XtvdI5w6xxSkt
 122Z2ALthSck=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: Andrey Albershteyn <aalbersh@redhat.com>

To mark inodes with fs-verity enabled the new XFS_DIFLAG2_VERITY flag
will be added in further patch. This requires ro-compat flag to let
older kernels know that fs with fs-verity can not be modified.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_format.h | 1 +
 fs/xfs/libxfs/xfs_sb.c     | 2 ++
 fs/xfs/xfs_mount.h         | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 9566a7623365..3a8c43541dd9 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -374,6 +374,7 @@ xfs_sb_has_compat_feature(
 #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
 #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
 #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
+#define XFS_SB_FEAT_RO_COMPAT_VERITY   (1 << 4)		/* fs-verity */
 #define XFS_SB_FEAT_RO_COMPAT_ALL \
 		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
 		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index 711e180f9ebb..e32cd2874bcd 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -167,6 +167,8 @@ xfs_sb_version_to_features(
 		features |= XFS_FEAT_REFLINK;
 	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
 		features |= XFS_FEAT_INOBTCNT;
+	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_VERITY)
+		features |= XFS_FEAT_VERITY;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
 		features |= XFS_FEAT_FTYPE;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index d85084f9f317..90a4ca0d7a65 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -383,6 +383,7 @@ typedef struct xfs_mount {
 #define XFS_FEAT_EXCHANGE_RANGE	(1ULL << 27)	/* exchange range */
 #define XFS_FEAT_METADIR	(1ULL << 28)	/* metadata directory tree */
 #define XFS_FEAT_ZONED		(1ULL << 29)	/* zoned RT device */
+#define XFS_FEAT_VERITY		(1ULL << 30)	/* fs-verity */
 
 /* Mount features */
 #define XFS_FEAT_NOLIFETIME	(1ULL << 47)	/* disable lifetime hints */
@@ -442,6 +443,7 @@ __XFS_HAS_FEAT(exchange_range, EXCHANGE_RANGE)
 __XFS_HAS_FEAT(metadir, METADIR)
 __XFS_HAS_FEAT(zoned, ZONED)
 __XFS_HAS_FEAT(nolifetime, NOLIFETIME)
+__XFS_HAS_FEAT(verity, VERITY)
 
 static inline bool xfs_has_rtgroups(const struct xfs_mount *mp)
 {

-- 
2.50.0


