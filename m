Return-Path: <linux-fsdevel+bounces-72065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8394CDC886
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 15:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEA4C3029C79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 14:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4F73587AD;
	Wed, 24 Dec 2025 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUNh3e//"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D737357A50
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766587082; cv=none; b=KvIApyT3O1LUZxrdhGmb1yS3Oiqlo704lmz02OJL8bPk0Pj4mlKH/6MiAqJQ2VI79R84s//ahEPmNpaQDuY+2dAmam83oh0L2sVw8VKn2mJXv/GRrA0PBOLiJtlpT/OY/853c1ymMQNQtzwQ1yPa2tcbFHGDhprfieWxgDC0J14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766587082; c=relaxed/simple;
	bh=QXBCkMKncjbVvgYao5NtYW1W28f7FkMdaqdlELJMfRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dm5G1SxXIl4nLEinzOy8OHXNwLPeSrUPsGJDRM+PSc9BgruoS47L0Eo4OzGDCwDgnow8AV5EOrUY46zixJXPOhNolfXL/FNj8JXUHaf352jFfV2V9+9F6HvlnIituBC+UMrZJTWHGyZ0JRGGT1XUbwbAWGnM3ROpipSlVo+79QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUNh3e//; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so6381757b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 06:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766587077; x=1767191877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7viBrygQfBJ9dsJSYJ1JbTPrbjesC9vR0UO5lc+/GI=;
        b=AUNh3e//5hbRJov5opjPiQVCRFGrnznny8eBFBEbYHAh+Kt3CUvazIPX5pN602iPEz
         Vhriz6KzERoJkit0s7fAyEMY8WqR3OublK4MksfBKH7Oq7WclUoaODm8C1tJufuvcokI
         XgBQBjxlGHK8EHU50R4n58n7FviBsC64hXbDwZC/iKXHSYvLXSM/U3hocPkPmqmeaunL
         sRh30rqMXU3Tbt2PR8utcMu02RpB0ofCsfbZbQeIGc+v7awD2nfhoT/pvNh/Doue+1D9
         lDUj69sgacWo5VtYOH0McDZHiTquujk2Kb+rRrCXa/q1HzI9XiCu0Buk+fbPX1Otp0vX
         3hIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766587077; x=1767191877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z7viBrygQfBJ9dsJSYJ1JbTPrbjesC9vR0UO5lc+/GI=;
        b=v2BRnNhusJfy6IsmHHR6BYTM/VHwu6VRpPAahSYt7DymdE0FyNkxAY3d/f00nTvrQL
         Mp7tPGIBhMBlXI65FnSiMKvQLRBUSMnnvGUKB7+qrKGBYkbC3SKPJOKBxxUEBdsAFkKF
         g3adppIfpuZgjwbwvH5Hyo3YpzaCW4GsU1EE50nRCs9e+69dYECIbUoIE6M6WCUGaB7/
         vhQt1U/5u0K+1kl3kQ/9jOIyMCiy1UeK9pSEpuAQK7LpnULVIL2OC4nFjjVJSK6nKdcv
         NUzoJDyd/N2R7gRdYr83sBVzNSkgCxq/yPuzDMokkjPE27ngFXHsGxeFcsOX/+9ykGiz
         HYww==
X-Gm-Message-State: AOJu0YxqJ4pf10Vc6XdYULsYSUPiCzLHx60B1XU3PT+FsFX3iGXKsNt9
	L9YwPOLCvmlW/eNoelq+CiUZreTEyyLwRqinl37zoZ5caKFJwSfLcFd+
X-Gm-Gg: AY/fxX6wb5pOb2SReiGRQ5I85q4oL/rtvLdjZn9f6p0IAjPxR7FCD46srczqvG/sl37
	RAi6TMjM027hLK5QMG7CgNjgIyZU6MHrIiysnv8awSOkJWJHqoHs9pUmElLVY5MUYkuPyxQl7gJ
	JNewqSBc1JiPWxclwDiBM2qVw4mREzYcpgtGoiIbn6zJoToU/VVepTNxWBQfD3pYTsj64Lyq97o
	Do5U8hiahVcXt7nEbGMmu0CgX78X1b5XLJ8uVJFHy1uHPPcMmpaZcAgy8CnqT1vIHE7hvd9li4G
	zKrpkD+xK4c3UReXMNjRSfhwf+Tslp4OB/jXfCE6ssRfxfAZDpRzSW+d+yjwAU4/6AbIfi9vOPX
	xHMPLDG1WJkABvuqnFef+17muSo3UjSQ0N5gydhe8zyzlFpRMdKVdYm+z2X1vihZiaQF++54Kg+
	Uek2uaK4VwSbL0W8/Sn69hYS9Q9gBg
X-Google-Smtp-Source: AGHT+IEf6OnhraAPlEJvOzxSDGd+A4+uIZDVV4h7OLSgrckMixR5lFY+H3H+PtcPc58QuGkNN61Ecg==
X-Received: by 2002:a05:6a20:9149:b0:35d:2984:e5fd with SMTP id adf61e73a8af0-376a8eb2ab9mr14055823637.32.1766587077446;
        Wed, 24 Dec 2025 06:37:57 -0800 (PST)
Received: from localhost.localdomain ([111.125.235.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e79a17fdesm14972689a12.8.2025.12.24.06.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 06:37:57 -0800 (PST)
From: Prithvi Tambewagh <activprithvi@gmail.com>
To: syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com,
	brauner@kernel.org,
	jack@suse.cz,
	viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Prithvi Tambewagh <activprithvi@gmail.com>
Subject: [PATCH] io_uring: Fix filename leak in __io_openat_prep
Date: Wed, 24 Dec 2025 20:07:48 +0530
Message-Id: <20251224143748.45491-1-activprithvi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <694bcb49.050a0220.35954c.001a.GAE@google.com>
References: <694bcb49.050a0220.35954c.001a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git b927546677c876e26eba308550207c2ddf812a43

Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
---
 io_uring/openclose.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/io_uring/openclose.c b/io_uring/openclose.c
index bfeb91b31bba..fc190a3d8112 100644
--- a/io_uring/openclose.c
+++ b/io_uring/openclose.c
@@ -75,8 +75,11 @@ static int __io_openat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe
 	}
 
 	open->file_slot = READ_ONCE(sqe->file_index);
-	if (open->file_slot && (open->how.flags & O_CLOEXEC))
+	if (open->file_slot && (open->how.flags & O_CLOEXEC)) {
+		putname(open->filename);
+		open->filename = NULL;
 		return -EINVAL;
+	}
 
 	open->nofile = rlimit(RLIMIT_NOFILE);
 	req->flags |= REQ_F_NEED_CLEANUP;

base-commit: b927546677c876e26eba308550207c2ddf812a43
-- 
2.34.1


