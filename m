Return-Path: <linux-fsdevel+bounces-70544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8130EC9E93C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 10:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C90D3A891F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 09:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534B72E0413;
	Wed,  3 Dec 2025 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHkbEXTq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4273D24A051
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764755326; cv=none; b=hEzc2pMrb9hrEnpOIG+AbXHeOidyeVHeH6CaBa1yl88LhEeIU+MXC+VUwI1A1VruYuspgFOyi1fY/u5ld6cZ/WTttTmQdoLRlBtM2KuE34/cbvJx9CwFQMKu5AEuUVQJHWI2GmmBtpRT1k0nc5t8VXxg2ymxtOGQ9gJZPprl9WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764755326; c=relaxed/simple;
	bh=tzAHs/NW8hzxVyE7YgViwF3ICFGUKDmj3FMEsxS6U1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mlfFtJkToqDcDWW0zAzgNAwzZFuJemrsIEegBOYF0lVnK8WsXvw2lko40N02jaeRJZCNRHB4qV0k9yu8duYtl/1ixDgQRkNLm5oua2xsm3T2JrRUhnIp8dwxDaHotHTL5p2IUFZ/exZx5C2gYeDGE86TjD6uWNgL8V5xCOQGTj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHkbEXTq; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b735487129fso940270066b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Dec 2025 01:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764755322; x=1765360122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ONlXezZ8rYOFy9RaN+13wK2rQQVa66Pyx3TL3D7WvBY=;
        b=IHkbEXTqZWGO4y1eS3wdAH/RabhJgM0KyF7Egw2P1x8kgbmB2eKS1pjaGlZ1RT4AE+
         KayVNhMVbTzN9K6bWJH+wUCWmVGzqJtnNZTplH2w0kkBkpHkFL9hs57eW4v+2XFrAr8i
         4hLgMQWvrIVzcdGepQOMpjJYjwqUmE2sadtV+AUDgYfwTXlkY5Eh7rxLSam8rdXW7xpa
         oiD2usFMe77lV8DCAlI/yFz0+/ldHqioF1k8gdF/LTGddxmcz76Yoo9gWcFgqAA6rh24
         ZeTOeuyXZG2y7VwLidaD+080uEMqBK42Q4lweoJjx/ZYRs/BqCig4Z9MGf68gxbquCo5
         ea9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764755322; x=1765360122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONlXezZ8rYOFy9RaN+13wK2rQQVa66Pyx3TL3D7WvBY=;
        b=Z467eS+Lzb2D5GjzIOyGVAJDIITPqcLIvzP5+9rdgLGD1pJ2mPKDH1tOWOqoTY4GKA
         TC+9RGgS3P7dt+auJpyLub1HYaI/h9tfgM9U2l6QkVMBIgMRqtRjDlqEd42FxssQK/NZ
         XopJybTaqx/uv6Wnf+/PiZUWlSNN5jZWz41IYN0YlwQCABoNwYzw+8V0Eeb/HDRSqjN4
         RfhNgNPvigO9Uz/k4FeAY7WbjgDFkVw2Ngm9qqG3iew47ovxiImU9EaLhijFYukK2Iwh
         K97RF8csj1OBdNh9nStNisvwIi/JlkFgknb6xWYZ4AIRKzpOV7VJkCtH33ePRBWMWcbS
         68OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLMS0SMfRaexQQ9vhuAECVpfyDMdoXCaZPc3IkKHc3IAC+ukWsmJ3Fz6U0yyZYPcCc0sDejKRp+6JwEj70@vger.kernel.org
X-Gm-Message-State: AOJu0YyaIdgoR8MMnOLD4jXYQIi6ydjyRJEOVixOZi+2ymkMulqtdtGc
	PjtiEdcUsk1/FErszad9gy3miOpNJF/NaCoVNjQdQdFCnx5ze9Wuu3Nq
X-Gm-Gg: ASbGncsBqHVp/6jjlCoMrJ8ae9DhFfnF9uowcp6GynWD8yHFWRHgpWYI/ugjeOF21vx
	x2Tio1CSuPw5e67rj8m/jxu3Nlwwdq3bp2EdZ8ibgf2/8lVvycDM0GSop1wTJRG3wNkhI6stk0R
	3L9BMJGTBuT/IBKnC5FQuDa+lKAA9ZTFm4ggRxyquKwLEpStFzPo5kOon0plkVzLcgk4t3TypBH
	F/CsKrGJybeNpQT4OTlwapBgCT4F35KDKMj9Wda2qOnWTb3kMxC8UAd2bKg0gFjgfrBo5X6hJ2+
	OC2PSCRPbdtREMsZHdFPrv40Lwmm88CuRdNZTbHsHm+lrUlmNIf9KJ0n8GBr3q8H9ZmofDnYowN
	DASXzc80jqm+Dko1rJk0rqvHVheNKKUi8364/V1JRuB4YcyOP2EL5nTiDYuRRBduvwAcqGH4Gdx
	b9WgCJgQ7XrsFuEH5JEBit/CT80MojneX5iJpk9mPKle8vL7Po1SVvLh0IbINgf4BiQDCiEw==
X-Google-Smtp-Source: AGHT+IFsXTiMvUyafaQ2YhhwQoLf9qgKC9IhU98mZGdwCNH1FN/zxbSo4VZZ0NE8Zun8h1TzC2anGA==
X-Received: by 2002:a17:907:7e99:b0:b71:edef:b1e0 with SMTP id a640c23a62f3a-b79dbe71b9emr158544266b.1.1764755322213;
        Wed, 03 Dec 2025 01:48:42 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5a4a652sm1779148366b.65.2025.12.03.01.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 01:48:41 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v4 1/2] filelock: use a consume fence in locks_inode_context()
Date: Wed,  3 Dec 2025 10:48:36 +0100
Message-ID: <20251203094837.290654-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Matches the idiom of storing a pointer with a release fence and safely
getting the content with a consume fence after.

Eliminates an actual fence on some archs.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/filelock.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 54b824c05299..dc15f5427680 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -241,7 +241,10 @@ bool locks_owner_has_blockers(struct file_lock_context *flctx,
 static inline struct file_lock_context *
 locks_inode_context(const struct inode *inode)
 {
-	return smp_load_acquire(&inode->i_flctx);
+	/*
+	 * Paired with the fence in locks_get_lock_context().
+	 */
+	return READ_ONCE(inode->i_flctx);
 }
 
 #else /* !CONFIG_FILE_LOCKING */
-- 
2.48.1


