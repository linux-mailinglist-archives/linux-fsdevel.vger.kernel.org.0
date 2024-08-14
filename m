Return-Path: <linux-fsdevel+bounces-26006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 967C89524C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 23:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5338D285FAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 21:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B3E1D278B;
	Wed, 14 Aug 2024 21:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="JkBpJjdH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542721D1F42
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 21:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723670782; cv=none; b=qnl4sE0IQ4wvPoR8wgBbuF1kbGruPdIM9pTt+HnTqgxdwtg1gkmPeDcIjjiXKdZte1N0TRkobb7mKShLQAmKULuzxPVDK3QNoORRCzVwPqP5Y5fKLiwonh+C52MbRuoklqk8tI+ZCPdZRTLBVnNrJ6xpJdhKH4nv0Um3luBWjZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723670782; c=relaxed/simple;
	bh=NSHxxZRLFbsIgAXbtW5uSuQCtRZde7l6XJ/+Bc0hmhU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcadTqpGvSWIXcuf6+luZkC9Rf5OdSvkFCVUVnxZ+fi3UWwGQEw0FFzM54qbkHJ9f2dnUy3wDPPuxjU7L3fy9sbOOsYT2TKJviJ2/NYfvDIvNNtbRIWlJUowKw8b0g8JmPPDWogKD+Dvl7EghLYKYBmwoRunQxq54EA59O+DECQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=JkBpJjdH; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7093705c708so277205a34.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 14:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723670780; x=1724275580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nOXg5Kh3dRzVUCha6XNrLJPIFEv9dDgQMOq3uyVXRLk=;
        b=JkBpJjdHT0nr8y7rL8HeY2I866l2ae0wbXcN22jjs8VfDIDzAU7TwCjd0SowQT0Pp9
         cH16jFw9xISJc3kn6MjOn+w/Bzkm1V970jOmuzvCTbD9vacuRiG0a9gtwpcnRwMz24Du
         MTP6wcx8anMOCNqYbIJWOo7bgNjY54IniLbtrBGePpdTAaV9p97fG60F9cApSCn8gofZ
         Ea8GDSl/14hEMp23KrnI874k+3gig+mrKcC98nTUmh0waf8jLw57j2B0N92xGbr59B7f
         twbESphI5/jr7Lkxx1tuWVF9g5HAMaLJYD6W51K8PHahW2K+w+9pfVEDo87m76zvNb++
         SeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723670780; x=1724275580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOXg5Kh3dRzVUCha6XNrLJPIFEv9dDgQMOq3uyVXRLk=;
        b=UXwK5W42QHjfU34zD/L8zWsoHRPNNDk8PJoCrM2mv5ESdazEhDGnjMYPOqOgMP3TRT
         sM6WzYIxgpVMP1FYsIom4dW5eK8FT7LzWT6mI5Rohj2GinLb4E2qmQyFaetJZUFPBjNt
         4ZE8Ybml2MQ8WvvZwp7STjZnjCXAiDuQDcVtjlexp6vqDsFDh6Mz28AH++m+LKA5YDow
         OOylTpnj67QWrFsFSjvij5xA/MRPsOOZvQ1XxE+1d3P7jvFA/snWcCFUvax8wH27PAEz
         a5A6lAT2Qhe7qVIn9Xg9daaqt7MtQkGc2mN5JETtq/A8eC6IcGn4YGysGOfac9vcRFzL
         EcLA==
X-Forwarded-Encrypted: i=1; AJvYcCXePvzfXt7Q966y3u2y9O5UL8UGaxnc1yG4PstAiybSsYcyvxL66KMS/biMiFtaUrEBvnv/xbHkD018htMTaoAyXsYFcfhimnLjiz+bPA==
X-Gm-Message-State: AOJu0YwOczeDHD9RmEkrEiUYePxFfj0RegbhQcf4eoFe4ee1V46C3oJi
	w8/Vq6woIqT62tcJcapkfQq1dB3HMVZE6UvOP98TBPI0teWLtFlXN9SUaoDD3HQ=
X-Google-Smtp-Source: AGHT+IH8MPr5SHX8NbOpfre4Dyt2H2WS5ph4VEJ8agevnX7RI8saF6DZ/UBE7sdnWVD/jUXsHLxmXQ==
X-Received: by 2002:a05:6358:6486:b0:1ac:ec74:a00a with SMTP id e5c5f4694b2df-1b1aab9017cmr527013655d.17.1723670780544;
        Wed, 14 Aug 2024 14:26:20 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0e5b09sm8115785a.73.2024.08.14.14.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 14:26:20 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v4 15/16] gfs2: add pre-content fsnotify hook to fault
Date: Wed, 14 Aug 2024 17:25:33 -0400
Message-ID: <2bd333be8352f31163eac7528fdcb8b47a1f97b4.1723670362.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723670362.git.josef@toxicpanda.com>
References: <cover.1723670362.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gfs2 takes the glock before calling into filemap fault, so add the
fsnotify hook for ->fault before we take the glock in order to avoid any
possible deadlock with the HSM.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/gfs2/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 08982937b5df..d4af70d765e0 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -556,6 +556,10 @@ static vm_fault_t gfs2_fault(struct vm_fault *vmf)
 	vm_fault_t ret;
 	int err;
 
+	ret = filemap_maybe_emit_fsnotify_event(vmf);
+	if (unlikely(ret))
+		return ret;
+
 	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
 	err = gfs2_glock_nq(&gh);
 	if (err) {
-- 
2.43.0


