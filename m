Return-Path: <linux-fsdevel+bounces-46100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C02FA827F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 16:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B40B8C2DC8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 14:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0663266EF5;
	Wed,  9 Apr 2025 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1MhdMu5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E80B266B71;
	Wed,  9 Apr 2025 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209106; cv=none; b=QGYJFmRTYtz9u9xAzvMFuanvchVI/0YKbLTV5PaAgoM/ZuoKPGzpRt0Ut5gEFuZsg3nTSA/hsdfA5XyibwxmmNfQVl7OAMvBxmHhsq+tP0l+mOLjjHTyBpWBLCocdBoRsKZqosM00P57iPkmVJnUMf0tKcQGF8dcb1rtlXcqQhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209106; c=relaxed/simple;
	bh=kehAxItDvgtX+tKg7TkyId9CAXsLYlIqEI/xXHXIkZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G47Ugdz+czwmlxPXCNCM1P4e0t6a1hNtVmg/RNyNVX7JSNnVuusqSbkOS54MSPGP49anr3F/Aa1QK0qSw3iFV+mNuXPCFcJUVobr6Avv4iW9ul6M8sxlOmkYUwnbaek1bfXR6T0dS6X5Df8wEiRKldIrnGGgmKCMwVftN7QzMiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1MhdMu5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so34962115e9.0;
        Wed, 09 Apr 2025 07:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744209103; x=1744813903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xAx3Sy8VitFS5n0m7xguZIFBZ5naFd5vtkTxSJ/vHOo=;
        b=M1MhdMu5885dAQbwg+5pZbQJGtMKBiROCqASM3V+0QT2t+cmEQpq1wU6QN0bL5HW0G
         JkJ1VB2P0+SOiAAHmvAQNAy5Veb0Sqe+FcmzPEVEO4JR0MlVZZkxTfjyzsSjkjSgUJJC
         HYNLAEvBhYjQQF3u2zJwF1EY9QE6I2g6EbcL31h8Zwx4lW6MkA7a7BlnZDvaeIHqKqB6
         nEElSXBWWraq8URYcpA6BfWyqcZemQglV0dtxZnX6st+aKwRxPo3/xsxfjB99v09JV2q
         a9CzZFjycSSaj9id2dti7bQFGXJ55gp/slL7wh37Fm3L2K8zIMfiNxBpdwyobbn2Y7B9
         EBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744209103; x=1744813903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xAx3Sy8VitFS5n0m7xguZIFBZ5naFd5vtkTxSJ/vHOo=;
        b=PmZL7yMWScVHJZXXwKHU4yBFRIhcSR7ykx13YVboEbEn6Y3mTkIe7Qz35lEg+EMclM
         huDRACxnPzzWPevK5fQ54HSfh6ncpJdozlqvW+MaCGCgiG8Ct9WdlWAw8YlxNzbO7+UY
         IcFZgPjAGCE2dbGCXRUzgYwkRQRs/UlPSd0bpS+9y/8eschdAC3+70NYlKyZS1851vVp
         lnKQ5qzlWpQC8axfzQuD/zjPkwxVGVU/EQacIz1Pa5LKKg2n+ytOU7Oroj26Par1miWL
         wL1Uf+3dhWX7CvVkZladnRxaz6h8AN4IAI9tNmBgH+JTLbW6syQ3IEBYUijqkJFNkiyr
         Y40w==
X-Forwarded-Encrypted: i=1; AJvYcCWyYNh7Y0IggkDpZoqQkqBF+njcAL/zfSey3Qk25w4RX6scwK8739zu3Xq5sZRjkjqTC5BuuoIM1z9VV9ig@vger.kernel.org, AJvYcCXfEuZmrErwb/XvkrET7bOQk9VJ12ayVl0metN5NPrPH7/jlOfJQ1jmVMbZLk7WlVW8fmoU3Gu+Pij9twSl@vger.kernel.org
X-Gm-Message-State: AOJu0YzMS2XsgLE5ZtvX0HydO/Apx4YUR+7dOLu7hscmA9Olm8wCl05Y
	qd6mOWG9X/UDxEwN99wo+0kwir9C8iCciwBUwVdFRPUL/P3m0qI5
X-Gm-Gg: ASbGncsGgtkjfq2IGl8JEn2oEAuPBtCoBD8JTelE87qgHQpztTkIDK7uxNuRdwZcwP4
	N06wz+xvdlxhQgol6JVHHVM2XrzG/7FYILv6l5+q3a1D0FWX+2J6/H/fnsa9r7gnpEIrfV0ONiM
	bBtuk0wUmKcgJUNQQSyoaiMUzwbEz2OVKsNNT7auAeUbS41fa8ta1B1S2F3gE5yKHOM64pE+XQh
	M4chH3LIQx4tF/2pvaejvMc1hU0WmNR8rQWT87k4en9QllMXJyKkbK8MkW1T3WnLT6d95/mY20O
	Mu/MoP12v4zbGD/YwGnXLpqCebSHhJnJl/BQBgY0EA==
X-Google-Smtp-Source: AGHT+IHxJbg8rbvWk3qrs1dFCbH1e7U/BsmqoTWA9z90R/ywpZLV/p8qzON3hSGVMyTQeN+VuaWIeQ==
X-Received: by 2002:a05:600c:1d05:b0:43c:f513:9591 with SMTP id 5b1f17b1804b1-43f1fe16b84mr20419385e9.14.1744209102563;
        Wed, 09 Apr 2025 07:31:42 -0700 (PDT)
Received: from localhost ([194.120.133.58])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43f2338db0dsm18889835e9.7.2025.04.09.07.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:31:42 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] select: do_pollfd: add unlikely branch hint return path
Date: Wed,  9 Apr 2025 15:31:38 +0100
Message-ID: <20250409143138.568173-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Adding an unlikely() hint on the fd < 0 comparison return path improves
run-time performance of the mincore system call. gcov based coverage
analysis shows that this path return path is highly unlikely.

Benchmarking on an Debian based Intel(R) Core(TM) Ultra 9 285K with
a 6.15-rc1 kernel and a poll of 1024 file descriptors with zero timeout
shows an call reduction from 32818 ns down to 32635 ns, which is a ~0.5%
performance improvement.

Results based on running 25 tests with turbo disabled (to reduce clock
freq turbo changes), with 30 second run per test and comparing the number
of poll() calls per second. The % standard deviation of the 25 tests
was 0.08%, so results are reliable.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/select.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/select.c b/fs/select.c
index 7da531b1cf6b..0eaf3522abe9 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -857,7 +857,7 @@ static inline __poll_t do_pollfd(struct pollfd *pollfd, poll_table *pwait,
 	int fd = pollfd->fd;
 	__poll_t mask, filter;
 
-	if (fd < 0)
+	if (unlikely(fd < 0))
 		return 0;
 
 	CLASS(fd, f)(fd);
-- 
2.49.0


