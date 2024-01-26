Return-Path: <linux-fsdevel+bounces-9068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D8283DD53
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 16:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9958B28104
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 15:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDC21CFB2;
	Fri, 26 Jan 2024 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDq+sjwZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDE21CF8B
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282488; cv=none; b=eaMenNl7nURF68ZbtfGHg3bBDrN9RS09D75CkfZ1c7oQPRrKEHSBJFovwPe3nU5xCOPO5+yrC4vVTwsqC5sxqXdG7y0z4pTn29zFx5bZRh8p33/GiydHB5YzynUWzSQChjlzBiXZKH5kgUTLsSncJ7hmF5sHtnVr2tsyhxWO5G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282488; c=relaxed/simple;
	bh=877USZF4PMd0IOhJrDaZsnrIKVXu1e8CCZK6tnJyPwM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bI51mHRP9xA5sPu/I+M0aWhAziOYrXiKosHLtgjA5jn6vIPZuTMjI6FT5FkJQG+N8dE+xe3yJyHzBeHQegcvKQXXKGah+eP+HmQfMR0t/y77WdHnyIhCvxP9EXhOJV/LzTyyaXOscyqz/F8aT8TtmVaqRZbky+FVsdDL+0F0rDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDq+sjwZ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-339261a6ec2so666998f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 07:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706282485; x=1706887285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16eli4Gr5+RVrN0Bt6oXCpcu2SLQlenkjMhWhSmDTJ0=;
        b=nDq+sjwZqMO6EC4JCrac3eDpO85BszTFUlMjwunXC3EOdVEvTjy0K8qFnRD3lvLcNu
         bnKfHvBWr79eLi6w9iQxt1jq+T8sNIqsDAo7lOveN5Pw75ET33Sm3g2ole7NYLQF8ER2
         6wkYTCGZQWIPKz6VlDNoejyRwAm1YFk6Np7NJPYx32rhnO+gNoaZO2hE3PoKE1nUtDy3
         7zB44CDK1wUwxaMUruAdHuZTQ9EhU6qIGMgzXupKcgJvcHnTfSkCPpgZquVSLj9KzYOS
         JUDR+2gMR+9GMmlGk3DcItN8EalroaH2LHxN2VDYzTOS8HPqH+oVQgTcx479e2M2k/Xl
         l+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706282485; x=1706887285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16eli4Gr5+RVrN0Bt6oXCpcu2SLQlenkjMhWhSmDTJ0=;
        b=SAOP4GNKMiDY2KPTCkZw/5A/COwZFnE+u63kReiZ5f1HeCUQwUVU2GeOLkGZEe5xDx
         Gfqbs5wIm1Jh6ho6/cvq3U4teaLpIomobgKFpa2DV2fEhCgNnZldViIMQFX+e4lTPz9g
         2/KfvCNdt05Rr/5ZizDizXYyZ81B2phNe4cmMmHSFAAdyHgskYvhb+WelF1heDfYVV7i
         dePL/Y5oFcgqZoZT0i+8N/2ld63oXpzFlmpUDWQuy2FnBJS4tpl+PWwGA8f82Y3JUxqV
         KkXN+IAzeSSzj9md6FVeQnPmebIHPsfinIRud1sZI7yux/yu/APBf9L507Fc+BHsstwv
         t9Ug==
X-Gm-Message-State: AOJu0Yy6CungTES3zcu29yq0cNmXQe92hjHmBVTx8sAL9HubxCMg8T98
	DVSycJZN3Vagty7dYyb0JbbmxX1BfY79i4eROz0E+AMczI97OHAx
X-Google-Smtp-Source: AGHT+IEoLary187nDguVtEHaA0H1sgy17G5roP7/gWfNsOyLTDlNMTQiSqyZ3kc72dLkGfWV7DS+OQ==
X-Received: by 2002:adf:da4f:0:b0:337:bc93:a7a2 with SMTP id r15-20020adfda4f000000b00337bc93a7a2mr1026402wrl.80.1706282484542;
        Fri, 26 Jan 2024 07:21:24 -0800 (PST)
Received: from localhost.localdomain ([147.235.201.119])
        by smtp.gmail.com with ESMTPSA id bn7-20020a056000060700b0033946c0f9e7sm1493914wrb.17.2024.01.26.07.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:21:24 -0800 (PST)
From: Tony Solomonik <tony.solomonik@gmail.com>
To: 
Cc: willy@infradead.org,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Tony Solomonik <tony.solomonik@gmail.com>
Subject: [PATCH v6 0/2] io_uring: add support for ftruncate
Date: Fri, 26 Jan 2024 17:21:16 +0200
Message-Id: <20240126152118.14201-1-tony.solomonik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124083301.8661-1-tony.solomonik@gmail.com>
References: <20240124083301.8661-1-tony.solomonik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for doing truncate through io_uring, eliminating
the need for applications to roll their own thread pool or offload
mechanism to be able to do non-blocking truncates.

Tony Solomonik (2):
  Add do_ftruncate that truncates a struct file
  io_uring: add support for ftruncate

 fs/internal.h                 |  1 +
 fs/open.c                     | 57 ++++++++++++++++++-----------------
 include/uapi/linux/io_uring.h |  1 +
 io_uring/Makefile             |  2 +-
 io_uring/opdef.c              | 10 ++++++
 io_uring/truncate.c           | 48 +++++++++++++++++++++++++++++
 io_uring/truncate.h           |  4 +++
 7 files changed, 95 insertions(+), 28 deletions(-)
 create mode 100644 io_uring/truncate.c
 create mode 100644 io_uring/truncate.h


base-commit: d3fa86b1a7b4cdc4367acacea16b72e0a200b3d7
-- 
2.34.1


