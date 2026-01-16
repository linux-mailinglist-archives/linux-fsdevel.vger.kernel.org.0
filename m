Return-Path: <linux-fsdevel+bounces-74272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AC6D38A3C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 00:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 625D030B78C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 23:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48C3315775;
	Fri, 16 Jan 2026 23:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="modJAawU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6EC318BB4
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 23:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606306; cv=none; b=hRaXyyvZ2L8/b1W9St54AbVUhQGeHQsfyxK5Hb6Ndro9NgStGYT3B36mNPnHYjFx4TXiRaosgkMfmetvjWD8B7PSvc6P7GUJogJHxDDnN68WDRIEgN/dZFrIeekCgwRiXVkr8xaa9NGm1LFW5Q6+5tN4CNYE4LyPrl3pzNGDqyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606306; c=relaxed/simple;
	bh=56Fb7wzUTSl0oceb1oef2fxtQTLKsyxfarQ2lNZJJu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAEOTqxDpB8TOG1yPKNlrXhF9m4BljAOGlha1twz/CVMpZhOaKhIwwlWZOkMFOyKW/QHlDjq8w+T/JcNVq1loWQkn7dismTqOiOAKhF/89ptHhJRfppTPOtM8Nui6jkU121CGd7LIZgQSUBYmZh3uza27/wePel+Z6Jndm+PZdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=modJAawU; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a07fac8aa1so18176445ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 15:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768606305; x=1769211105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1uswQbwaALq1AcVwcuYPMRPVeMNvBx5ucL/SDcIxQA=;
        b=modJAawUQvrXgxvx+l3Cg9HIQMFXzwzyGIgjfNFR3N90QEQyMWsBb5gVJQW6zisMtJ
         jYkUmGOqrfnrNtj+y6+9apeOmnRI9CTmrF/b0f27Kff0U8MFUYieA0dHfn2kK0SxnUrc
         oYRKyKI5QmhLs6rlZsoRGkIRos54HWHZ8jL9rAmKo+VOIufNUzFgdu0AfuEnKhean7Rc
         mVk83syqrBGdPsU7pTD/Cn3V/ICoRKyIwWkxqAZQeDL0WXyulguFt4aTgwmSqmGeMtsY
         +oq2Ly/0kuTbL9xYnVHXG3NuamSi7Gl8+DE0Bhdb/zQ8zQwgXIRYbilTC3bKcpd1Nqr5
         7DtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768606305; x=1769211105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A1uswQbwaALq1AcVwcuYPMRPVeMNvBx5ucL/SDcIxQA=;
        b=pwslYxpXvoPE2n7f9sR8FlaSB7F41KL67yxlIQkfWSZFnsvvVTmHSz0rM1FtLfl+TX
         fFXdty8oRF4mSksSsk+xJyzlKLDjheh56MjsXBHU1gy26TGaLO2tX4MCD6HJBWntEvv7
         8gtawbeJ9OyJIMV1R9YuAm7V4i2SxLgYRHx3gdL0b7Wm3X9jBpb9EH8OzGaGIiVe9GD7
         RVJsk7HbqUqdH/9YBd4UqYjJ30Ocgypckd7PcNTxXujKaYFF6ODILiDBq9JgLQRUKdf2
         KW8D8OGCudunHHPfvQ/1lUFDrIQNjijsy20roBQUmyZOUfZDORbXPRcfqZodvA1fqkjy
         /Uxg==
X-Forwarded-Encrypted: i=1; AJvYcCVtg99nH3FTVYHHIstnpAE9dB5Ck8URsZ2BhwTlS6ljZJdDT4nR7Ct2tmeXz6H9iiTBpoecLzQ08f1xpnl6@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9RGSuiXkqJIEXxMXNL9t8vw983l1Xrdt++8w9mafNFHd2Zo5U
	EH/z39mrbmcPnKDfyCwQDYZ92euK92BBnkC8s7WTZHjbprZ7x62K+0ZGrvqWYQ==
X-Gm-Gg: AY/fxX71W6vYRAo0iJrnsGBSi7KEwqMjMBQBoyYmzpBUvAPVhYhjr2MjAXrOSobEcbM
	Ji11QS9F7ewK/T+70c1hT3ykRUqz2W4tTbAlQeog8DbysxS7lNg9+qb0Rky8A4uNklIpWOf3MRd
	nxoNKDM/H23TB3K3Za5SFjiM2jaVxKD+n4LL7mjDbiFm57rclTP4h27Y11vl+n/OyN2EToK2fTd
	iZh4L3yxfiHzuuVEBj8OLltZBrTpNijoyF/mtD/nTaWqLTuV+rGRHaPSrTj5gObDjh21S304X0V
	5pfX8U1VWeQbyuWNLPLN3SH3C79/NwLBr8y4PdLU/MSryQGn3Zb6t6adc8hXFMX7GxJJIf+HbS1
	W/ejhwLDadfxsq2B8QfHLQH72R55T25GZ3/hV/sGfsM8godHXmbphfeHfmKs2TeuuYc+Y65mhSr
	6jPQME
X-Received: by 2002:a17:903:b84:b0:2a0:be5d:d53d with SMTP id d9443c01a7336-2a7177d1bddmr43945115ad.53.1768606304678;
        Fri, 16 Jan 2026 15:31:44 -0800 (PST)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dd532sm30608055ad.66.2026.01.16.15.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 15:31:44 -0800 (PST)
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
Subject: [PATCH v4 23/25] io_uring/rsrc: add io_buffer_register_bvec()
Date: Fri, 16 Jan 2026 15:30:42 -0800
Message-ID: <20260116233044.1532965-24-joannelkoong@gmail.com>
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

Add io_buffer_register_bvec() for registering a bvec array.

This is a preparatory patch for fuse-over-io-uring zero-copy.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/linux/io_uring/cmd.h | 12 ++++++++++++
 io_uring/rsrc.c              | 31 +++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 73f8ff9317d7..7dde6e2af05b 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -107,6 +107,9 @@ bool io_uring_is_kmbuf_ring(struct io_uring_cmd *cmd, unsigned int buf_group,
 int io_buffer_register_request(struct io_uring_cmd *cmd, struct request *rq,
 			       void (*release)(void *), unsigned int index,
 			       unsigned int issue_flags);
+int io_buffer_register_bvec(struct io_uring_cmd *cmd, const struct bio_vec *bvs,
+			    unsigned int nr_bvecs, unsigned int total_bytes,
+			    u8 dir, unsigned int index, unsigned int issue_flags);
 int io_buffer_unregister(struct io_uring_cmd *cmd, unsigned int index,
 			 unsigned int issue_flags);
 #else
@@ -197,6 +200,15 @@ static inline int io_buffer_register_request(struct io_uring_cmd *cmd,
 {
 	return -EOPNOTSUPP;
 }
+static inline int io_buffer_register_bvec(struct io_uring_cmd *cmd,
+					  const struct bio_vec *bvs,
+					  unsigned int nr_bvecs,
+					  unsigned int total_bytes, u8 dir,
+					  unsigned int index,
+					  unsigned int issue_flags)
+{
+	return -EOPNOTSUPP;
+}
 static inline int io_buffer_unregister(struct io_uring_cmd *cmd,
 				       unsigned int index,
 				       unsigned int issue_flags)
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index dc43aab0f019..b6350812255b 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1019,6 +1019,37 @@ int io_buffer_register_request(struct io_uring_cmd *cmd, struct request *rq,
 }
 EXPORT_SYMBOL_GPL(io_buffer_register_request);
 
+/*
+ * This internally makes a copy of the bio_vec array. The memory bvs points to
+ * can be freed as soon as this returns.
+ */
+int io_buffer_register_bvec(struct io_uring_cmd *cmd, const struct bio_vec *bvs,
+			    unsigned int nr_bvecs, unsigned int total_bytes,
+			    u8 dir, unsigned int index,
+			    unsigned int issue_flags)
+{
+	struct io_ring_ctx *ctx = cmd_to_io_kiocb(cmd)->ctx;
+	struct io_mapped_ubuf *imu;
+	struct bio_vec *bvec;
+	unsigned int i;
+
+	io_ring_submit_lock(ctx, issue_flags);
+	imu = io_kernel_buffer_init(ctx, nr_bvecs, total_bytes, dir, NULL,
+				    NULL, index);
+	if (IS_ERR(imu)) {
+		io_ring_submit_unlock(ctx, issue_flags);
+		return PTR_ERR(imu);
+	}
+
+	bvec = imu->bvec;
+	for (i = 0; i < nr_bvecs; i++)
+		bvec[i] = bvs[i];
+
+	io_ring_submit_unlock(ctx, issue_flags);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(io_buffer_register_bvec);
+
 int io_buffer_unregister(struct io_uring_cmd *cmd, unsigned int index,
 			 unsigned int issue_flags)
 {
-- 
2.47.3


