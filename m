Return-Path: <linux-fsdevel+bounces-70512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C95C9D6D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 01:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7AE754E4E05
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 00:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B84B255E34;
	Wed,  3 Dec 2025 00:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mR6/ssUA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F16A3A1B5
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 00:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764722222; cv=none; b=ZUwEAJOovk4/uTxWxPiJXpF2KCbOytmUZr/J+xUZ3j/WZoD8DSh/d4k7wrl+2ccmxQiwjva+qAHe6a1X+bhUZQzIHXphx884qxZxHptooZwFOvfaDFGKqxWa/q6ObsJkGvPhEeSOjPta6r5CTyiAzt5C0d56pQKjUPAq2RFMGxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764722222; c=relaxed/simple;
	bh=9zbdRQa5U1WLeoH5boQGAcxtyf4ds0If1PxNAfsMtqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJToCXFc3QfmCZFDhW6btD43+0oWUUgLdV38ll5V5CXQeD2MYtReaf6E3ksJm9RCl4Vx8JvW3iLRSqiGDrCG/3FI/mkjG72Ewxc8yuUZAfNvTPH7km58gfFxWwgAC0ol1/DUUdxDSRMlultxl44D0S9aQR6Uz3SYA+WwNQMAsgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mR6/ssUA; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso7068797b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 16:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764722220; x=1765327020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfmCPWKHjdJmwvEJc9zhie0v6QHYRdYOxmgZuC/D3tU=;
        b=mR6/ssUA0CzGA/k/rIex5D5XxlyvlMwUodWcj/Ua4M0fXUP/z0IYWhd/lQ1ffn8Rcj
         UmehPYQAxb/164p/Gla4SDEu3U7j8iiP+VFS0urqrDAGmt0jC6LTVWKUFypOK7EwqSgr
         HxOOqNnDqR3/hwDOgO5v8tIqTZ7mq8VAeuKucXDFITPNhaVryQXVexLmJ3mbUxlPhefE
         KielOEV8DFM1NMvkc7o73t7U5z0XL5szavQeY82d34MzbpMvm0WwLmOJv2ISVD629SUb
         erHEsS0Qs2FEISqFrlaCjP7Q3SxD6f+cCmWqUfp8NQ1j1FCjS/ZbR2BY8KhTD5dUKld6
         cv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764722220; x=1765327020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZfmCPWKHjdJmwvEJc9zhie0v6QHYRdYOxmgZuC/D3tU=;
        b=vh8jH/c0MgzxAbHWH841uzSDTpvySXOFOu0+xld/0ves5UaAgKZDm4PxIsWhf5k/mf
         T3+lH05hG4dZU4YkP2Z6gatgQCZBnnela+j9YzYOtS5qh3UKtM5JTgOoDLd6DYjjq19T
         VGWENPpIFXgHRqcTwhE9DUnPgQ2V0xV1w8CTrd2anvhRChiYHbCzGp8LHKwa78IcS8pq
         MGJ4EZ2acdd4fiECyO2t7Xu5gdaSC0gLOvd/rI8zT/goNWMKVXLktvUZKTQP+aLDl7i8
         Am9Dcx7bSEzRm7A9jlhzQbNlkR/8YB5ECk1Ov98EUotsGWLKgNETJp8l191qgLOAU9AB
         BCiA==
X-Forwarded-Encrypted: i=1; AJvYcCX2vvvx5SVMjuQznnRNCBOAKG3HTs+zBMjbl+3R0VxHC81WBre6Xu0ht0kX52XrjqYCDS5xBu8kTz7P2NcT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw22YPRN3nnKqMeydTQAXL3Fvur0GqUdO5RL8Z/QK02xhtmJtG3
	yvToiaGwt88PRtiokdwIPuPC7RC8NPqvPOnrpIq52qKkhOgFAO3zhfzg
X-Gm-Gg: ASbGncvhiuvarj1/ZNpuN44+Y4PlT23NZJdbCm0KaRRtJ5Xj8LW8kGXXbpQd+0HuJ4x
	ioie0K8nQrCJgc22OxbM3LmhL5PVFr/Mu/0eIo8iCUKRWJd81CzEae/x4tWCBaLm6kzoDEMWLh6
	+BvdT1R+1fRW0iAfRKqzDDZJF18XNExgU3aIWzFDsYbGmvsZMGnPHqgjC1MK6QpMZGrfblf+GUL
	jq5v5Fv/8+YEQJI4XeeZaCwLm9BycjmcwPkhdwfBmG+h920gBo8vOLSeyqZffslTPS4CmPw54wg
	ZAiFKB3PvSjTiUwLIefhi4fMm5/fhk/i+7W1l1+TcDt9wc1CPZX6n+3AnsUS3RUBOImGv2rDHZt
	qDaRs4PsUvjKjUim26AMfkNf5ngEDWdh4pYarwAalR15f4IEP9HWoMIA/a+L75k9cAx45yixO62
	runYiF+cTBKdxZz0ZuJg==
X-Google-Smtp-Source: AGHT+IEqZu3aQkfNLXXgbqXRDKhCyzeWgCHn5gWirZsFGdWGcy02UvsRGyw2W+fl/OvavhCSloNsPA==
X-Received: by 2002:a05:6a20:6a1d:b0:334:912f:acea with SMTP id adf61e73a8af0-363f5efe97bmr812965637.59.1764722219823;
        Tue, 02 Dec 2025 16:36:59 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be508b06867sm16005992a12.23.2025.12.02.16.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 16:36:59 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 18/30] fuse: use enum types for header copying
Date: Tue,  2 Dec 2025 16:35:13 -0800
Message-ID: <20251203003526.2889477-19-joannelkoong@gmail.com>
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

Use enum types to identify which part of the header needs to be copied.
This improves the interface and will simplify both kernel-space and
user-space header addresses when kernel-managed buffer rings are added.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 57 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index e8ee51bfa5fc..d16f6b3489c1 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -31,6 +31,15 @@ struct fuse_uring_pdu {
 
 static const struct fuse_iqueue_ops fuse_io_uring_ops;
 
+enum fuse_uring_header_type {
+	/* struct fuse_in_header / struct fuse_out_header */
+	FUSE_URING_HEADER_IN_OUT,
+	/* per op code header */
+	FUSE_URING_HEADER_OP,
+	/* struct fuse_uring_ent_in_out header */
+	FUSE_URING_HEADER_RING_ENT,
+};
+
 static void uring_cmd_set_ring_ent(struct io_uring_cmd *cmd,
 				   struct fuse_ring_ent *ring_ent)
 {
@@ -575,10 +584,32 @@ static int fuse_uring_out_header_has_err(struct fuse_out_header *oh,
 	return err;
 }
 
-static __always_inline int copy_header_to_ring(void __user *ring,
+static void __user *get_user_ring_header(struct fuse_ring_ent *ent,
+					 enum fuse_uring_header_type type)
+{
+	switch (type) {
+	case FUSE_URING_HEADER_IN_OUT:
+		return &ent->headers->in_out;
+	case FUSE_URING_HEADER_OP:
+		return &ent->headers->op_in;
+	case FUSE_URING_HEADER_RING_ENT:
+		return &ent->headers->ring_ent_in_out;
+	}
+
+	WARN_ON_ONCE(1);
+	return NULL;
+}
+
+static __always_inline int copy_header_to_ring(struct fuse_ring_ent *ent,
+					       enum fuse_uring_header_type type,
 					       const void *header,
 					       size_t header_size)
 {
+	void __user *ring = get_user_ring_header(ent, type);
+
+	if (!ring)
+		return -EINVAL;
+
 	if (copy_to_user(ring, header, header_size)) {
 		pr_info_ratelimited("Copying header to ring failed.\n");
 		return -EFAULT;
@@ -587,10 +618,16 @@ static __always_inline int copy_header_to_ring(void __user *ring,
 	return 0;
 }
 
-static __always_inline int copy_header_from_ring(void *header,
-						 const void __user *ring,
+static __always_inline int copy_header_from_ring(struct fuse_ring_ent *ent,
+						 enum fuse_uring_header_type type,
+						 void *header,
 						 size_t header_size)
 {
+	const void __user *ring = get_user_ring_header(ent, type);
+
+	if (!ring)
+		return -EINVAL;
+
 	if (copy_from_user(header, ring, header_size)) {
 		pr_info_ratelimited("Copying header from ring failed.\n");
 		return -EFAULT;
@@ -609,8 +646,8 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 	int err;
 	struct fuse_uring_ent_in_out ring_in_out;
 
-	err = copy_header_from_ring(&ring_in_out, &ent->headers->ring_ent_in_out,
-				    sizeof(ring_in_out));
+	err = copy_header_from_ring(ent, FUSE_URING_HEADER_RING_ENT,
+				    &ring_in_out, sizeof(ring_in_out));
 	if (err)
 		return err;
 
@@ -661,7 +698,7 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 		 * Some op code have that as zero size.
 		 */
 		if (args->in_args[0].size > 0) {
-			err = copy_header_to_ring(&ent->headers->op_in,
+			err = copy_header_to_ring(ent, FUSE_URING_HEADER_OP,
 						  in_args->value,
 						  in_args->size);
 			if (err)
@@ -681,8 +718,8 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 	}
 
 	ent_in_out.payload_sz = cs.ring.copied_sz;
-	return copy_header_to_ring(&ent->headers->ring_ent_in_out, &ent_in_out,
-				   sizeof(ent_in_out));
+	return copy_header_to_ring(ent, FUSE_URING_HEADER_RING_ENT,
+				   &ent_in_out, sizeof(ent_in_out));
 }
 
 static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
@@ -711,7 +748,7 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
 	}
 
 	/* copy fuse_in_header */
-	return copy_header_to_ring(&ent->headers->in_out, &req->in.h,
+	return copy_header_to_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->in.h,
 				   sizeof(req->in.h));
 }
 
@@ -806,7 +843,7 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 	struct fuse_conn *fc = ring->fc;
 	ssize_t err = 0;
 
-	err = copy_header_from_ring(&req->out.h, &ent->headers->in_out,
+	err = copy_header_from_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->out.h,
 				    sizeof(req->out.h));
 	if (err) {
 		req->out.h.error = err;
-- 
2.47.3


