Return-Path: <linux-fsdevel+bounces-71902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C03CD784E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 01:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC6CD304C1ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 00:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC8420C029;
	Tue, 23 Dec 2025 00:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kr0O7K/f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDE11F4613
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 00:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766450211; cv=none; b=chcnJuzD2hrDmHnHoif0B2nvn6i8wJjbK2Hw4KP50QY5OF3xeBt8wfXFqV68Vt09Q35D3LT3Gt4TMQW7/j4yC+4jVPXtzg11F6uBDUCmfQbjz6uxt/6BRnGBBhyIVtMjjwb7K7YElbm34vJvwmk8LGryHdOuqmD2PpKNPXZbE4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766450211; c=relaxed/simple;
	bh=dCE9Ifsy53U4i9ZoCVgrqAcptT5uW4tuuXml9xDq4zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nbl13X+6MEQjDekahwa7Oqcv6Cs95H3KBrmGNUclaeQjnJ7cpjDq4QaofIm9oIKc20c02RZ8fN2z2HrOeLHseNTJIsNBeGHqlbU/RPRWLMiq1/KKZz7Ivl9z132D26EqX192f2zQrUp+gCY+WdbF6s/JeNNvwTIEcHZggpWLT1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kr0O7K/f; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so4191436b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 16:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766450208; x=1767055008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9L/4yXbNzZtfTE9c852n7Fp8KTBsMqoDKIABPL39CrI=;
        b=Kr0O7K/f+yR7Xts04IRWah+DPAWBsv++iHiSujESvuVvsib9pewvhMvDlMc/WxF9Dy
         MI4E+0nOl01k1FdY7Bd3c51zWopmtExlTNjY4FmCQaabJg/cGmLD6ie5mrFWWNAUWAm4
         Xn4TZmT7Xg90bqpd5eVg0DDNiglDWZz7IEfqHge7W+RGzq04cB/m/CRMoOeMA67QxVdZ
         ocOia5pTbTYd9l6SXGtQ+nLrGrzPXJ46DUUGsFZOWOtGE5MDoP58dXFjx1bllPAoT+dT
         p+vHRRAf6dXCGw5EP2ZLvEI87CS7a+7JotLkEuGWFpM/A8jcfIzNO5PP/SvwPXZCeBYM
         JF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766450208; x=1767055008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9L/4yXbNzZtfTE9c852n7Fp8KTBsMqoDKIABPL39CrI=;
        b=Me4bP3u5CPgaNdKFalKiGWmoKyKB6r7sJ8wBa60WWLUhlVT3rmLZdEQ7BjzCceuH5j
         ovLuzDZ6SNeMuSmxPTCQ6gjB90r9PeSVxcpSuMphNtyR4tWYvEyy/uhY0kTzlzGwYv8w
         81qiYHXJLom4iGDTgbvap1UE3cinPtyXv1FVVfq/FbggqDBVdeVuYO3siTYRYzppy3aN
         DomR5qxmrlV4oClNGp5GxWmbfekcXihnP6gNQAq7PTbRuPsVT538oNHZAD/NFxXxrU1n
         qRH/pkXW+BFb6XDzXD5FnQuUAYvUFbGE8AUOW9s3lh+SOR30Fjjanyrsvwtn+Y0HqtOT
         6j7g==
X-Forwarded-Encrypted: i=1; AJvYcCUu+VVzyvBYnMxlpEq4fhLwGYAReWazLUJkqDDKoh7uWIy5UtvFrMZ8e4zKUpJ00625A2dzKVi7CaeAVPbJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwAASBFhXU5cAW0hQXa6xrqk9ShrRtkMddjWRqo20AvZU0WHlFR
	nlmq1y4l7tRExVt6lxkbqr5Ze6sNDIa4caXytwHMr80pzvrg3/lyFHaXZ9f6LmNc
X-Gm-Gg: AY/fxX7f+kNHNplPW0YNwrTroorHRGLnN32vQ1xIZT42+lthx3eIH6UiLl7tSv6ixXp
	7rlZ3JRnWzHt+dQKu0HDeDZQ0usu5f6sq9hseZLxQOkcx3J7lhKWyUSn5J4p8eg4wkuurUt4+Wk
	UqmLXfaVepl/sXmgmtHOMB+/WP/SrIC3nDHS2cS4sOLZXQu9KWTGiyHhvNLhHGzv29Q+RttPjsy
	vlmJQ9bZA6Es+9McwNKlE6/wa/vo9kPypF5ytZRtuCXwF5yZZmNWjf7GKfNj6jLJTwK989C8eVy
	gTfbRnYCgTldilqs1FRaLb7e4mOkBy7jdp5F8c22+23MAQnI2Ec7uQB8MHWhDRzA639jpEXvw+L
	Ut6MXoS407F34Mdlwco/PK3jMgpNrA1tV7JZjq2wXykDt2PzPbiZ+9DAUDHMav5uX7sZNNoy2Dt
	2AmgixaWKJCuA4HUUi6g==
X-Google-Smtp-Source: AGHT+IHVdbjckMfiuEk88UJEb1waxjTNLZMmz6/YhqW8vhxBy6d9JfnViDgdIFqCP3BFIXY3RksA0g==
X-Received: by 2002:a05:6a00:3489:b0:7ef:3f4e:9182 with SMTP id d2e1a72fcca58-7ff67965e2amr11079021b3a.47.1766450207863;
        Mon, 22 Dec 2025 16:36:47 -0800 (PST)
Received: from localhost ([2a03:2880:ff:51::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7a93ab3csm11529868b3a.7.2025.12.22.16.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 16:36:47 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 14/25] fuse: refactor io-uring header copying to ring
Date: Mon, 22 Dec 2025 16:35:11 -0800
Message-ID: <20251223003522.3055912-15-joannelkoong@gmail.com>
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

Move header copying to ring logic into a new copy_header_to_ring()
function. This consolidates error handling.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev_uring.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 1efee4391af5..7962a9876031 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -575,6 +575,18 @@ static int fuse_uring_out_header_has_err(struct fuse_out_header *oh,
 	return err;
 }
 
+static __always_inline int copy_header_to_ring(void __user *ring,
+					       const void *header,
+					       size_t header_size)
+{
+	if (copy_to_user(ring, header, header_size)) {
+		pr_info_ratelimited("Copying header to ring failed.\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 				     struct fuse_req *req,
 				     struct fuse_ring_ent *ent)
@@ -637,13 +649,11 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 		 * Some op code have that as zero size.
 		 */
 		if (args->in_args[0].size > 0) {
-			err = copy_to_user(&ent->headers->op_in, in_args->value,
-					   in_args->size);
-			if (err) {
-				pr_info_ratelimited(
-					"Copying the header failed.\n");
-				return -EFAULT;
-			}
+			err = copy_header_to_ring(&ent->headers->op_in,
+						  in_args->value,
+						  in_args->size);
+			if (err)
+				return err;
 		}
 		in_args++;
 		num_args--;
@@ -659,9 +669,8 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 	}
 
 	ent_in_out.payload_sz = cs.ring.copied_sz;
-	err = copy_to_user(&ent->headers->ring_ent_in_out, &ent_in_out,
-			   sizeof(ent_in_out));
-	return err ? -EFAULT : 0;
+	return copy_header_to_ring(&ent->headers->ring_ent_in_out, &ent_in_out,
+				   sizeof(ent_in_out));
 }
 
 static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
@@ -690,14 +699,8 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
 	}
 
 	/* copy fuse_in_header */
-	err = copy_to_user(&ent->headers->in_out, &req->in.h,
-			   sizeof(req->in.h));
-	if (err) {
-		err = -EFAULT;
-		return err;
-	}
-
-	return 0;
+	return copy_header_to_ring(&ent->headers->in_out, &req->in.h,
+				   sizeof(req->in.h));
 }
 
 static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,
-- 
2.47.3


