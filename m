Return-Path: <linux-fsdevel+bounces-69275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47236C7658A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 841674E2776
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 21:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41A2302CAB;
	Thu, 20 Nov 2025 21:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4ahJ2y9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D59D3009CA
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 21:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763673242; cv=none; b=YDCLOgMBBWC2bEtqpqpSbsvJmLqDeEsEphjJFRkWDUsHirFdeG7EgRkA0AinA99oToODNXfKzw7q04qVEVSWQUEI8epmy80/UUs3Y/9BVdx90r+8GJOvTQ5wfn3DzuB5G/5rzgyxEGlWU7F0inBvE8NMZHHdl1w9FIogFwCkuv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763673242; c=relaxed/simple;
	bh=cQMX/usI8gqcSln2UFa8v99XXRwzaizYb3BPi10FYFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BNT5cPtiM4Y+KSgHOk9O8KBXGuCW+1eMQw8BkEO81IGrJLp9H7Bf0kEhNbsXD1croJEF1kiFki/UwBPx5L3BQ1BEESoz/yOao+XJHg6D2WnU4crGv2crKEqM6zMcSLE8Z1mBZuDd3SONcNyA2bCpdSwzBiDA6yM7qae9D1Zbl8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4ahJ2y9; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59577c4c7c1so2243007e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 13:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763673238; x=1764278038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4d7IAZGUxK1m7h2GDkMHE2QpE3zLGipSmtQ9os7xNBI=;
        b=E4ahJ2y9Dr2smEtT2XU7QMybWZpsABlFm76xydDHK7yLVYpHSwFhDwbcviGStzq334
         JJJEAfwMv81Ef68b2dNmyXqfDmDdWG+u34jhB7EfefVRttZ7yxCG61ufnY9rsx9LZIRD
         Bp4/u//7kgVbUw3Qq9z/vk5TtJjyhxzpgvodzKI8AlDGGZ21cCg8Jtlnqj9M3cuzEYm5
         3p0MAf35RtCEwgI7XoLTIkoXXrVPMxpbdr5KrQcTAWOq3CdDsjmObKlqIHBLwzAGmGqv
         yGWIp6n6m7pfY0fp2qQ6oCJeWuhYi5D4djkxCIyR1K4vFBZBoRXJUgqmxYQPpkLBjBSi
         /odQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763673238; x=1764278038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4d7IAZGUxK1m7h2GDkMHE2QpE3zLGipSmtQ9os7xNBI=;
        b=QGxZWQH0CCkXqoxnK7rPk1IHrxEkXeujowKz6f5g2aYYxHBLvCi8VnEGWAapJCTHIv
         ILfsfPn5ioKlqcfoSC/nd+guXLz0DZYDrkboWVNmr+FLTUcuO2C0LFjWVK33okWqhTrV
         NJdfvFXFLjCYz6GinqIvsqsmRBJPFpz8pPK1nff+T9SCzBGCJxF8LGPJ8jiapZVteN86
         iBGFuzdVnK28VmBqqHf4MOZsvxKTm1M5xK61h2yUGHmFg99rZ3exfiuAzFlP5fLhyp+K
         ABYd6JkPZMHcbcfrw4sfTEOdtNnBIQRcLCmvwvRJaeSemJcXumIQbwEIFpdY0ncD3cLF
         K1/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwQ/zInHHg/Jq0PgTFjd9/i0rVQKLOTFuhgVsMIxIlsERSeF4kw70UZsBqoLQYti8eLUXnMPfpHqsECUtJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyeBcDujvsEsFWDrD0L+TQs84FpSpkgoeQV6fF+WlSzNYGFu0pR
	/zKVGcsZdJNpB9u+3YUaSQWG7zCNtRVEt8Zfd6qC0nQn8MhOQMwrDNoG
X-Gm-Gg: ASbGncuZGCjcZbZKhWLMZ2NcsvtX1GkxI8tw9OA+2L2y8m8dN+IT61mANhFyShHLBZZ
	qVmesYZvD0KPFzeDkTZKNrcJ5VQvLn7fiEhaFDfSLXmdt8WUxS/bRhR4LhE4zuSFZfXp4Hj0ASx
	t82uOD9ibkVWSTri1Zt/FB73imek1z3Ds6XoVayd8Blo3nAtDMrjT7PTuBO3v/lN9Qn63dGkjbV
	qVKcMuyRI8EflNx8MHAJUI6jIacYYWxspyA5aWdQSVjt141QhulRf21cYPqkNkwo2eV91XO+WVP
	odo1FMgVAiyzOxBsZykLUSO7KpF9UXemg8lA0HPWlO2P0OpWQU6aJLhpDNenuLDPQSgjxQOMfjz
	ivTudQ2TWQBZybPz2chNtXQWib04+SbxgWarN5yqJiLttMYe/BbIwSDXZOOtLWiSlBTciaXhLuD
	+vq38frupV
X-Google-Smtp-Source: AGHT+IGhpshH5PO4QTdDzSqAVgMyMOZ968ZCv3rtjofzqeUqpZ5T2qu6vbZdUcrZQBx0KF/2QP0meA==
X-Received: by 2002:a05:6512:1293:b0:595:8a7d:87cc with SMTP id 2adb3069b0e04-5969ea2237dmr1408150e87.16.1763673238128;
        Thu, 20 Nov 2025 13:13:58 -0800 (PST)
Received: from localhost ([109.167.240.218])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-5969dbc5964sm991716e87.70.2025.11.20.13.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 13:13:57 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: patches@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] fs/splice.c: trivial fix: pipes -> pipe's
Date: Thu, 20 Nov 2025 21:13:16 +0000
Message-ID: <20251120211316.706725-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trivial fix.

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/splice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index f5094b6d0..d338fe56b 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1498,7 +1498,7 @@ static int pipe_to_user(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
 
 /*
  * For lack of a better implementation, implement vmsplice() to userspace
- * as a simple copy of the pipes pages to the user iov.
+ * as a simple copy of the pipe's pages to the user iov.
  */
 static ssize_t vmsplice_to_user(struct file *file, struct iov_iter *iter,
 				unsigned int flags)

base-commit: fd95357fd8c6778ac7dea6c57a19b8b182b6e91f
-- 
2.47.3


