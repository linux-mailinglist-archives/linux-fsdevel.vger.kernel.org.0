Return-Path: <linux-fsdevel+bounces-45389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B72A76FC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 22:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6781166FC7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 20:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2094721B9F3;
	Mon, 31 Mar 2025 20:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SukpuOmQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A30214A7B
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 20:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743454640; cv=none; b=eep0kJdfg9aycblt5z0Z+ybyA4OfBhQJ/w3YtnT6ebZhIoeodDxtr3mY0g/SYgxIX1HtUsvOOdaJc+SolDWhHVuhD6BYqs4NA1iRvV1Jz1tAfZuVCGJVA16VDfxxdUxEjz4KBv5KoQSpT3BGG9/rtoaMa2PBd218vGT8p9xeoE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743454640; c=relaxed/simple;
	bh=qWrf9zRS0/EMqUqFYRfvIO2LhVQO7NAeW11erTSrFYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d4jAkMttRnJc8xbIRZ5rvjM0sQ/+/BPGOn1jRF8+dP9P6fpL6MfvqGgKy4hWG1f4orKlV2h9Vb7DnmYFuBc2CXj8+LZgPJjaognwZo+6lZ6folJyZJwghwL+GTgg+zJHAE+2eXwXqNtofr10N8ssBCFurlJXQjatsyGOcbSHR6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SukpuOmQ; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ff2adbba3fso39697187b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 13:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743454635; x=1744059435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g7A4B8TLU/qrg7f5QlnB2Oi9yZ+9yi1Dl5eB8/UU7sg=;
        b=SukpuOmQuNI/t4joN5S4NPl6zgxEGBp7aHZZl2SH3T0CPY+aH79VDLt2g8eGSA8fNJ
         uexvV8OKb7fNJkJnemyzMxtsQDSkmOtT5yHEcnVupzdPtTVmOAlFIfExMgVLqIyGkVMo
         ED6Addaga+7iEYCfCp7iMKEDZLDLp6mcyg9koAWOhWYZTW//0FPfc7af9BjjqOD0c2Da
         pd5sNwjk7tXk8bP4JXS6eBHQG3+rui8vbpdZJ9+35d0/nIXuhWX3OeE3eqiHrq81sxZF
         BdXSNQOQG+cXdS31QhRXMHchVuWU56aiS0yL6+gZVWTNpWLNrTtjvc96pYnEF7fH1UEX
         J0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743454635; x=1744059435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7A4B8TLU/qrg7f5QlnB2Oi9yZ+9yi1Dl5eB8/UU7sg=;
        b=VXmYP4TuyD20kkXTCHeyEJ8zur6bfNBeJDd5565C6sT2xh2Vrkpw7KVw45UqY/krKI
         K6XEgepVSBKYp/zQJM0dwmZ+pqDIjO10EOQQXXNxflW4PARxkXdE7gVmnuvwE8/y8ecI
         GunoetoEkjpuxJjyXFyY7D7zMXDvnlMfXUtYCVi4scMvtu9u6GLRtoMkVDoaqi9UMaI/
         Zrv+UJjXuqltTYO0X/AchKabs3FaeNwKe732a0XBn7jHxLRdBGlgkB4aY8V0As0YC00i
         TuPl8n55P35sg3MciXbqrwDGz2yT6/4dJUnvf7B6gm1vurj1AXX5iB5WWiwbzcM2gtet
         /3WQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9z5JWSc3oCLJBKS0G+3qCMEdxMGQDW7+sw053ALud3NnRQ0uvbqC1bfe8oyF1zdz9PobY/V0Y8I5mxuTl@vger.kernel.org
X-Gm-Message-State: AOJu0YysrzfQRnNiqr1ZoK6rYbMyxWEMOXhXxe39dGILoTHWRpjrGHG0
	WOtEcmtMxnQfSKqfJs19u8HGlwKYxRZ2Jdpiv6uhrLyK0rvNL+1/vOO+hw==
X-Gm-Gg: ASbGncugAzaE+F2pxW03cWd1J+ewf9kvpnu9cU+44CREpgtDRiskvJRDfE3e9axLG3n
	ynJsOUsU4Bo3geRQhFS//TC5AbjDFlxZODwTJ9cOpCJgcFtokO8tQg1d9RDfkU3OTGUC4zh+BkJ
	kOmrbiVbZcOORFDTbr+nPazZMLDBH+Rf5aL8E9TFy2Q+77vlajlzo0jg5uoLpj5ulRB42jGvOUo
	zIofEPJW7T2Uoo4YRbQwJYCBmJ8p6pUv1MDAQ5hDXKKi9/d+q48sWQZkQSZEHEEjC1fiDjZBuNG
	QxdqZ0Aj2ME33+bZSeSzvI9CZN138RrNhyfz9T/SBw==
X-Google-Smtp-Source: AGHT+IHhvDzgEYzp79iggNIEzuCPGXJegWlqgn/r2kHXB3dikq/XnaMpvxxEPPi613QZ4lfapYq5Cg==
X-Received: by 2002:a05:690c:600c:b0:6fb:1c5a:80ea with SMTP id 00721157ae682-7025730238amr146448397b3.32.1743454634828;
        Mon, 31 Mar 2025 13:57:14 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7023a37a25csm23449977b3.26.2025.03.31.13.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 13:57:14 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v1] fuse: add numa affinity for uring queues
Date: Mon, 31 Mar 2025 13:57:09 -0700
Message-ID: <20250331205709.1148069-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a 1:1 mapping between cpus and queues. Allocate the queue on
the numa node associated with the cpu to help reduce memory access
latencies.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index accdce2977c5..0762d6229ac6 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -256,7 +256,7 @@ static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
 	struct fuse_ring_queue *queue;
 	struct list_head *pq;
 
-	queue = kzalloc(sizeof(*queue), GFP_KERNEL_ACCOUNT);
+	queue = kzalloc_node(sizeof(*queue), GFP_KERNEL_ACCOUNT, cpu_to_node(qid));
 	if (!queue)
 		return NULL;
 	pq = kcalloc(FUSE_PQ_HASH_SIZE, sizeof(struct list_head), GFP_KERNEL);
-- 
2.47.1


