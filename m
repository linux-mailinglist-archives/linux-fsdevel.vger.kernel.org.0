Return-Path: <linux-fsdevel+bounces-70513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A40C1C9D6E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 01:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A52AD34B0C2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 00:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9612566E9;
	Wed,  3 Dec 2025 00:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmw+/6B1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53C9255F5E
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 00:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764722224; cv=none; b=Ymozs6cUqGXovO8d48o+G8ZzcPWnv5HIVeE0JLuFklb54rmUq+l1C5In4Bherk9QumuUjLSpZp9MP1bCpvx9lKqlX4YUr5Sw/w9mgIaIVcGSXxYp+Z+WDV8YMRE4rZj3w/4MawXAvqxttDhu5tp9JUSMXoOwU2HkDLjo4w5Axg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764722224; c=relaxed/simple;
	bh=ZkMe4/6Dx+pmQX8ki8G7Upa84OZlBwKQ3m0/1EW95NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bF3UW4IEEoOnc5K32PcSpNxLoKzE/MnVmVg0YbmJV2r5BYX9gHQdVRd//goRUgjtY6Y4SZ+LP2ZxJe0xD7bFqoCux+YkuPvAq5Xmcsmj65jlOuYyNzj/JfJlEfuR74FRXAcmB+0/lwvP5muFamuIynCBEJTMRYl4/ao4MBqK1Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmw+/6B1; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3437c093ef5so6436143a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 16:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764722222; x=1765327022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tw36/s5nwa0exNv0eee1S2uesxu6r6RLUjOdbIOB9QI=;
        b=bmw+/6B1d33rMRKj5To5fsK+H80aXlzw+Lj4YEEmhhKzJO82odB3pcU0ktbDaAJdak
         UtwkSti8J3vPBAloAeBX+7UuRZJZgwnOTeZIBDMH+8zWpdotD3fvDtjV7c0Rwn+CtL7N
         UI0HCfQkvi98d291xDeGvidNKF0ljUw6GSdjFcKhLOWeYjbxU1UHlu5Ev+zio7rfdOy6
         MCVjs++3/j06/AOBi+q0qdcPp9qWancee7vDD3iP+MN0Pw3JIWR5rd1tKwrJvAVIPMPm
         L+TsZ0Yrr0sgi6ul5lQ+hKI3J+trm8LmnGVcknKcr3ioA7IucyE6K+9RGMuW6U0Qho7v
         hMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764722222; x=1765327022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tw36/s5nwa0exNv0eee1S2uesxu6r6RLUjOdbIOB9QI=;
        b=KTtOiaIM2cM14c0Xxy3jYje7zTMnGHEbvUV/9mcWo+Lpsyy8uWkbgwm+QGi/lNpy9K
         7pXqduVXuQZ7/MoEzy2Mj2izvdfM16yScR/La7TrxpP+IeqcVItxUwSYfIznmCkXodKU
         O6O0MaqKl/VhA/ZhWgc4MeLwTDOBo20TrtUkjE5hRcrjYM5bqapQaXFQNUgR3jPQuyTr
         o8wPOMjcoHwSiMiKSLtywpQ5s1JXOfMUyDEGl8yuMIB+Z3GUmGKKVnUM049pSXQPZwcm
         uTaDX8TMPaYasynSa/hbZ9o2ZFa6ggCCJn7/t/Q/1QlV4kli0pY8IYq7EXYt+Zk/6YIu
         +QZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN5kmEv5aktr1GV/+cW+5eSvCXbTYodcpFJ0JGw3ftpYm1N+3zXUqS449gBhtTq1afJBrAJ0SUOGYt9CeJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwjshjTxeMuY2J3Ay9oDPly2YfSVg8GWQEcH+s19p2EToR+W3f0
	74orzmzjLAceCM0d4b6iwYWCyeeRiWW8BHAPQjO14KDHx5Ssi7zyzqPW
X-Gm-Gg: ASbGncsdk1pPEAqhrZEkKZp/qLPno/q/peLQbcs1YREehSshu1oLbWoLr9jrZUZhgH4
	wikMnTuPCKI1AfRmXwwEqaAvoi+W2ojGdRDcL+XFnHaQhgziKqTWiawlDdqCO05BZp9SCer8zV2
	GQuDXZF/4XN7Tj2uVnXIdDvf1OA41K5PcjHzNvEIEzrBOcqXhBHCedvcIL/mhQjiMGc8Z7nGT21
	ZnU6f06y+iP+VRccxh3VEP3/SYO3byjAAvxJnC/i7aJGyQrWeInZfesroVQ1kGFNo/QUiiCDVzL
	dBx3PfwlRgmHf0jcY6JHIC3OsGQmmK3/qvqMfc5BmI+nBAmR0vCqNhE7uTV0tFTXPXeI9tQI+0c
	8zFNQZ0vZJL9hJT6tgf/pLAwBGovB3+J8qCfSl3pMuEWVa00N47HEf5lL83Q7juAI3JxFtjrq7Z
	AVeULyfsTZMPxOyJY1+1B/ucU6
X-Google-Smtp-Source: AGHT+IEfQBwfERL3tHhQM9LIF/pf665YqQMJW9YkdHylacss2LHAlfTrA7E+oLb/HwDCseUtee8Dsg==
X-Received: by 2002:a17:90b:3e45:b0:343:6611:f21 with SMTP id 98e67ed59e1d1-349125ac880mr527379a91.1.1764722222047;
        Tue, 02 Dec 2025 16:37:02 -0800 (PST)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34912d27040sm144072a91.5.2025.12.02.16.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 16:37:01 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 19/30] fuse: refactor setting up copy state for payload copying
Date: Tue,  2 Dec 2025 16:35:14 -0800
Message-ID: <20251203003526.2889477-20-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251203003526.2889477-1-joannelkoong@gmail.com>
References: <20251203003526.2889477-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new helper function setup_fuse_copy_state() to contain the logic
for setting up the copy state for payload copying.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index d16f6b3489c1..b57871f92d08 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -636,6 +636,27 @@ static __always_inline int copy_header_from_ring(struct fuse_ring_ent *ent,
 	return 0;
 }
 
+static int setup_fuse_copy_state(struct fuse_copy_state *cs,
+				 struct fuse_ring *ring, struct fuse_req *req,
+				 struct fuse_ring_ent *ent, int dir,
+				 struct iov_iter *iter)
+{
+	int err;
+
+	err = import_ubuf(dir, ent->payload, ring->max_payload_sz, iter);
+	if (err) {
+		pr_info_ratelimited("fuse: Import of user buffer failed\n");
+		return err;
+	}
+
+	fuse_copy_init(cs, dir == ITER_DEST, iter);
+
+	cs->is_uring = true;
+	cs->req = req;
+
+	return 0;
+}
+
 static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 				     struct fuse_req *req,
 				     struct fuse_ring_ent *ent)
@@ -651,15 +672,10 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 	if (err)
 		return err;
 
-	err = import_ubuf(ITER_SOURCE, ent->payload, ring->max_payload_sz,
-			  &iter);
+	err = setup_fuse_copy_state(&cs, ring, req, ent, ITER_SOURCE, &iter);
 	if (err)
 		return err;
 
-	fuse_copy_init(&cs, false, &iter);
-	cs.is_uring = true;
-	cs.req = req;
-
 	err = fuse_copy_out_args(&cs, args, ring_in_out.payload_sz);
 	fuse_copy_finish(&cs);
 	return err;
@@ -682,15 +698,9 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 		.commit_id = req->in.h.unique,
 	};
 
-	err = import_ubuf(ITER_DEST, ent->payload, ring->max_payload_sz, &iter);
-	if (err) {
-		pr_info_ratelimited("fuse: Import of user buffer failed\n");
+	err = setup_fuse_copy_state(&cs, ring, req, ent, ITER_DEST, &iter);
+	if (err)
 		return err;
-	}
-
-	fuse_copy_init(&cs, true, &iter);
-	cs.is_uring = true;
-	cs.req = req;
 
 	if (num_args > 0) {
 		/*
-- 
2.47.3


