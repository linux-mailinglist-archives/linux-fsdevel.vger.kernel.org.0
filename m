Return-Path: <linux-fsdevel+bounces-71903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A243CD7854
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 01:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4F90304EDAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 00:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173F71F4613;
	Tue, 23 Dec 2025 00:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3a9VoQE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A981F8AC5
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 00:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766450211; cv=none; b=bdD6sSiYSPcsPB6PvmkDCPurFYJaUca7lnPD8ySdCc0TH8e82UAyu+N0y2W6hPGVHlDRHXzwNijZpNWSku6Tz8THMqAECYAeDFk3e4eq2lNduQM7+xdBVQTL80Vg0q7vvEsj1lNOasJCs4OtPy9rlBc/OrKu4yLeqW23cHGbLTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766450211; c=relaxed/simple;
	bh=7StnbW/TqmHUc1vg9s38n043pYlTzeZZxclo5H0fKUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LfYaapBdjUSrXogwcL6AZZUO4d/WPtWrxYRuoI4VCrq8O8Sjg6aTGKM5ryYizIh1Xe10NbJDyocvYg6ub08y2YFVurAYal72Ilm5JSgLrG7e5/Z4Yrwit7AhVBmlJdqe7z08RoznLdCGiJ3PGrbt2j2o0RqkglzIaa4gC19BHgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3a9VoQE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29efd139227so59935065ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 16:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766450209; x=1767055009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+ttqcfQ3T5zSOFv2YhovKb1gWr/JPYacZE2ZQZbU7Y=;
        b=k3a9VoQEfMtFU5eFpe8Ramn6QNsP59pf8Ut98dfXo/vtPxW0Cmvg98i1WLMr3KvbZf
         kUSLgxzeE/PxXSyLj3vi3erdlEaHnyUiCAI6gC9Y6FGglMA0nrsW8jOjc2TAMbzt6F3+
         8TMO1TIwv/K+x+FVoN0uXbJf6Gsmk564H1FVFfD5DjI0KBKmhr42yiSNmMrsGRJwkyL3
         i2QGwN7Ayf5EnGHlcfwEsDxlm/cBixqARdq/bbB8Hpwq+oYQzSVO8fZBx40lbWwpZ/7I
         tCjE1CQAUpSWf6nOWjJqFn8+pJE5FEoi28OGfOHl3jo1DVDJgOHylG68yZqj+4NGYHKs
         9HKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766450209; x=1767055009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w+ttqcfQ3T5zSOFv2YhovKb1gWr/JPYacZE2ZQZbU7Y=;
        b=oQ6j0Aq97+lbrGpQNbxBtB0uFlBvlNBS/KbMeX9jg99vgsnoQdQI2a2M0I3GfZ3HBq
         0p/a6hj9ZcA2kLUmYRPdLlD1i0p5Oyhc8GMXVZX9FadVuuKgAL20opWEwr3RWzRK4VWD
         XsfF/R9W7PUvB5GCVGmysFm4usrf2CGBzxVxgcEVNiztzLu0Jz298B02K+mXa9+utnQb
         jExDKOVgDz6mGySsq4gwrZF3vDJuvgcjYAmIgDM3KwDPKXfU6lcmrYPPBE0ZGbLYV/O6
         zMlNxOq65VDr2/5F5Bs0v9P+wg78Y6nto1tLDp0HDwfejIFSngzERpCoL+Z+166PrxBS
         KhKA==
X-Forwarded-Encrypted: i=1; AJvYcCX5OgCh8chyIGWTFCGrRf1iGCnW6ZtXtYr/H9wRFpXRCxFxANY1c+OhAyl40wLnXvcxzys6xX3VvIqSZKA4@vger.kernel.org
X-Gm-Message-State: AOJu0YxkGGnHjhoKAkfGj90C5Xx6hykvi0n6JJLrOslLuAK0bY4mwxhq
	OmyFQHCY+J2Mme/srvfSxnfSjBkJmDf905YkUHn8ouVSlDMxvU60v3oD
X-Gm-Gg: AY/fxX6GzHFZJ5p82kkjKcOA5uFL9PFr2N9+t1pEtmxyCVS8vBbdC7566hhavrglrbI
	GSSJnKeaCdTv3KPrAwXI+mM4WD2pLtrNNoaDKF7C+jtJzBO1mvzZHmOCbkmTc6IgSQy+YgnjpTr
	MqKP41axL921/Gi0alSE+246dlykqrykK0pDUEeL7/eRhRF3tT7GQ9b1c5rKIef7HJWVJtTF1cF
	HOPYPOwGiyP4QvmUgJSfImaOjGz8XqyzMt8pMEdSoYy/Ds/A6p1EEw+tgw0YetUXPYlHLRcAmpc
	OeQH0PNqPiVniEiL6KFd2qsnpyKpk3j1fIRMDyRReOCguKY0mHInb0bgvdUWR3YdnIgj/XVXZkW
	fNnkUoYFh/i/zA1G4BBtiV4DLGZ64x6PaTenYwEsIeZQBop+cZq+BeSX6fB6h6UuGXhNyvex1At
	EtHsNpCGodaRT/vRD+
X-Google-Smtp-Source: AGHT+IEG2ZslDRIBVszUST8fjCQfpuscl1VfHChhLWfIfgGL+anHgSStZkgHL/p5tjHNzxd0QrnJ2A==
X-Received: by 2002:a17:902:cecd:b0:2a0:909a:1535 with SMTP id d9443c01a7336-2a2f21fc33fmr129619795ad.11.1766450209461;
        Mon, 22 Dec 2025 16:36:49 -0800 (PST)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5d566sm107593665ad.71.2025.12.22.16.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 16:36:49 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 15/25] fuse: refactor io-uring header copying from ring
Date: Mon, 22 Dec 2025 16:35:12 -0800
Message-ID: <20251223003522.3055912-16-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251223003522.3055912-1-joannelkoong@gmail.com>
References: <20251223003522.3055912-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move header copying from ring logic into a new copy_header_from_ring()
function. This consolidates error handling.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev_uring.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 7962a9876031..e8ee51bfa5fc 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -587,6 +587,18 @@ static __always_inline int copy_header_to_ring(void __user *ring,
 	return 0;
 }
 
+static __always_inline int copy_header_from_ring(void *header,
+						 const void __user *ring,
+						 size_t header_size)
+{
+	if (copy_from_user(header, ring, header_size)) {
+		pr_info_ratelimited("Copying header from ring failed.\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 				     struct fuse_req *req,
 				     struct fuse_ring_ent *ent)
@@ -597,10 +609,10 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 	int err;
 	struct fuse_uring_ent_in_out ring_in_out;
 
-	err = copy_from_user(&ring_in_out, &ent->headers->ring_ent_in_out,
-			     sizeof(ring_in_out));
+	err = copy_header_from_ring(&ring_in_out, &ent->headers->ring_ent_in_out,
+				    sizeof(ring_in_out));
 	if (err)
-		return -EFAULT;
+		return err;
 
 	err = import_ubuf(ITER_SOURCE, ent->payload, ring->max_payload_sz,
 			  &iter);
@@ -794,10 +806,10 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 	struct fuse_conn *fc = ring->fc;
 	ssize_t err = 0;
 
-	err = copy_from_user(&req->out.h, &ent->headers->in_out,
-			     sizeof(req->out.h));
+	err = copy_header_from_ring(&req->out.h, &ent->headers->in_out,
+				    sizeof(req->out.h));
 	if (err) {
-		req->out.h.error = -EFAULT;
+		req->out.h.error = err;
 		goto out;
 	}
 
-- 
2.47.3


