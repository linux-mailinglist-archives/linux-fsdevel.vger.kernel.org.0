Return-Path: <linux-fsdevel+bounces-74264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2ADD38A2D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 00:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7309A3062BF2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 23:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD41325732;
	Fri, 16 Jan 2026 23:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGhxS76w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E213168E1
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 23:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606292; cv=none; b=dceyaBoNAcJIceLItAOm/RxC1ScSEnNUZh4rSNZpi0mXJpia+jaY2/agV8eIb6pNAN0mgCPL9LFCtjxDFioSr7gfc4Pt/y1HFBQugFH+WW6f59YDcOyaEzwG7ifzhY+DSN/CIiAvt5LZmx2PrkVtMfF5v4ykf0mEnr+tWQaX7jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606292; c=relaxed/simple;
	bh=7StnbW/TqmHUc1vg9s38n043pYlTzeZZxclo5H0fKUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0Ac+CQGh5fOZDAyYdiHU5laji+2oM79Z7kZ9xwgZG9Fzc4DeNFZrDDd2rAusHJDI+2pK6cbzH9WMoz9h+7g98JHXGQKyfgyHCZV9GjGD2GYdLEeQcmP197TC3NnrmLe8v4VrGJZBIQLU2ZrOoR/3juGahSr5TKpk5WGfrYtXwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGhxS76w; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a3e89aa5d0so25172335ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 15:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768606291; x=1769211091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+ttqcfQ3T5zSOFv2YhovKb1gWr/JPYacZE2ZQZbU7Y=;
        b=FGhxS76wty1orKznut30+WppXmYBESFeGJjQFo1aY3CsQ1mXZj6gHEVCZxLImilcK7
         rIXeMT6O33MdRsY5qYAPUG1snqBRlKNB2T+TqHA5pLimU4QaQsNRT1JDsR4BZCJavDn4
         UTpK+DwOhiaNmRZPgKuSp5RjuEUtfNFBo5TcpH3slsjKgKH5Qjz8C9dqcKFT6BIMkZq2
         vXXJZ/ICo62JepIkh/mf8TezGoa1z61gG+Rr8CvAn5g5LOtZmi9bidIc/HOyIebPM9XU
         UroEs4DHnFlTHs97cQZNtuqCVmSnDCU/ib8ZHLrLpRRwAkJ0ohCpWTTycF6ggfA8Ll9y
         NR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768606291; x=1769211091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w+ttqcfQ3T5zSOFv2YhovKb1gWr/JPYacZE2ZQZbU7Y=;
        b=QQgnORDMOwxVULK18yRjCi4HZZyqH3bolSiOzYbIou86dT/+meryJg+7po0uXhGuab
         jF5+ha4wPvMnzC46G0+GPfXIGeGmVuQwzIPU3LcLFYB++LSzdg+hvNUdRflRCtLleygN
         zozorqMV+5TfHpbCkWv26e1uIqQ6mEnDt5w1YtYRGL40mBCpJ8tp/jeVF2AJuArDumzu
         GCPkdGCH15PTUkiz1/oRZqRtDzpLOnZcK/TG9hfqq+P7NEVY8WEG8irO8gt5DnYU5+ir
         Qpv79phUh/aEu2P7QrIuqs3JEhXFhOnmXUfIAwO6lwCTDovVDoubUoYy3T8PVgFHhtcA
         s8Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWeOC9s7vABxWbau2zDPku1VXq9oxlZmEjH7d91nyGK65Jsw8WSHA4+aJX6UMoQ9MbgKKdNnWDXIBwjdtHL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0FyfVwiHEKyrtUMqnGwunEtlfksdyqYNIC63aVobjoZETdJuj
	SKnW46IKpnXp6T+MRjCdX/7C/nimUkPOvINxKkg1q8rdMqn+GB+yCUNB
X-Gm-Gg: AY/fxX6lDcr8WpF+HjAFrHuvgq8d60QxOuZNLeqTuQlP3c5gI1/+/yQ193hxWTxrmPp
	8IyMm2e0nYlmWIV2qKpepqkzD335x6g9oVvFp7u6hRJYE+kH1XxUqwxiO0CzuMN53hBqhhevAYv
	bvX+/kCFfxXvaVvGElFFN3jMC2sKbf5smQ06EQhpleibVSn4CjeVolkIyXiOCliYQPNp4kQkZo0
	Q2jYTrvIX6Yv0RNAsa7SLZMUt5EDc7XxHmGXYEpTrAhKPjBpg9ZoKK1D7twTpWptq62eWzljbkZ
	5Mg80UJBEbQhoiO29iO7FrQ2YJlL7pv1HFH5owUcjXzrHnIaQUsHKvtHHBFqGvBNV5GtgvGGHAM
	qlrOi/BCOUkHc0VfOOmb/Yg5k+HGuAErFtbYdCG9DIAD7yzhvH0vRyi38KmL7ifcq/bUyldWSWB
	CChdKWWQ==
X-Received: by 2002:a17:902:db0a:b0:2a3:bf5f:9269 with SMTP id d9443c01a7336-2a7174f0127mr53253535ad.3.1768606290943;
        Fri, 16 Jan 2026 15:31:30 -0800 (PST)
Received: from localhost ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dbfcasm30757085ad.53.2026.01.16.15.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 15:31:30 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk,
	miklos@szeredi.hu
Cc: bschubert@ddn.com,
	csander@purestorage.com,
	krisman@suse.de,
	io-uring@vger.kernel.org,
	asml.silence@gmail.com,
	xiaobing.li@samsung.com,
	safinaskar@gmail.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 15/25] fuse: refactor io-uring header copying from ring
Date: Fri, 16 Jan 2026 15:30:34 -0800
Message-ID: <20260116233044.1532965-16-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116233044.1532965-1-joannelkoong@gmail.com>
References: <20260116233044.1532965-1-joannelkoong@gmail.com>
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


