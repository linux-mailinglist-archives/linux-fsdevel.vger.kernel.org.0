Return-Path: <linux-fsdevel+bounces-61197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8C7B55E24
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 05:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 467EB7B3F83
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 03:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A941E51EE;
	Sat, 13 Sep 2025 03:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFYNYJ/t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC8B1DE4EF
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Sep 2025 03:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757734652; cv=none; b=ifAewbx/UwuSQ0kQqM0lU5QSDdGbri7WN+J5+heXU4CyhtwokFbDmBM7V17jAm5lZEmU53oOGh6sZ6/SHWNJp+nSiqotwsh/MGsJSlp32nF8NbMc8uFxtC7wR/3IyJs/N1Jsf6imzNfD0piGT0ykpsgZYPF2pdGPJ6PEH8ZsmAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757734652; c=relaxed/simple;
	bh=nbmHvENF6wiVd4LFNsW3/Myx/TXvx5lSSh9ejpw6OMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dq09JfbZSE6F5jSyCNhl4buF5K7iLiCgpf0y8yN9Ee5MW+trUQpKTVxUME8gjXTMi8MoYZERXZOwvEg6qUE5+owR+px93QletQFqxAlNRiv43yhS4WjjzgVe3o/JP8FDmnuCpUFVCpJxNMrzkWrEc1XliQdXuHcIAD8A55m/ja4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFYNYJ/t; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7761a8a1dbcso979112b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 20:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757734650; x=1758339450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jP93xN6gwLHr70Ds3prjvKvRcobCNOyB/BNk5HT+4PY=;
        b=RFYNYJ/tuvLylsma9+lf6Nz3v0bne1J3fs6cSSuHfOMuE4Bmjym6fiENFu3AnC5nDI
         qQ7FD97rwLEKV4BsfEbjt3y5kR5cYom8qKFcii2ZHSPiEiIyA2CXnj86TVBmlFhtfA58
         zYzy60+RfPbmNNo4585c6usLQi1YESPXcGFJy4Ow2CRxvJlSa8rhM4CuUB9vrcTv7Zog
         Z+SvPWy+XeKj6lFFlD45eSBPZrQOdWwR9U831mUcW8hrol0JMpUQYH5KVIWMmvo7+HWb
         qnB7Ma12V6sJETFmvWITmKXT83qHetMPxRoKRuugYUu7O0iOJ6gOwKaOFMo2ijOlAfjE
         7l6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757734650; x=1758339450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jP93xN6gwLHr70Ds3prjvKvRcobCNOyB/BNk5HT+4PY=;
        b=BRKT5JGCRvPvBJd+eH0U6YrxtRxwvwNHuY6QGd5FYK4kn9pXZQIWwk7UOpy3bORVJU
         36BXg89zHf4rFoH7EQzw1rCkCgzKE92trDz4Q8/V2P0eraXZm+7OO9ulAAvV01afp7I/
         vmP0GzZeCxVffeVVgeezmpNXMIzKx4qDKuOhgu8eIz+PmVpKDi7d3S9nrYQS0H469Nps
         efoi7rxjaluM4TsU+5OorifOUMx+kGmRaw75aN9LdSwQ8CCF5JeXBBCX+FKhJBs4cr1X
         KEdWEhAv4+aInDalVrfOvo+yMJzWQlq7AvK4lTzEMK1RnfqMAmHiu5mB7/k08qkl/hM8
         wNaA==
X-Forwarded-Encrypted: i=1; AJvYcCWWk+HfpiAUUxx3Mq0+hRX6Zouqlexv/OOh0jd0GTh/EHR+0lT2Tno+bWpd4oKRRzqvdJnHAoeYe2MnDkz1@vger.kernel.org
X-Gm-Message-State: AOJu0YwJJGRUXSVtvAE1s3xA4yAb1EHPeULpzBMMlam0+TB7GhW9enMy
	vxGYkhEu/IqxlluXMBkqH5vq3Q3ZMqmRg/wab3iDwvdzzWhSjkqzK3mXqx72D5+l
X-Gm-Gg: ASbGnctsIBcCS4Quqh0ODrme5LUoJll1TxuNJF4BEOf42w3473kwhV7V92MlRA5k3H0
	pnV3w3BnB8PxBbIkzoaZKwXNZma6+nP/aUAI/Vlv2tF4TtcT0GSaw+nHMnLul6CA9yKypQucsT9
	XzJSL5iZGN8mwvmQkm+6u+Yr//bu8VBilpFz/oEyBKeNZZTuTQvxVK92YNBOTB6I3/UaZmohzVR
	NalN/odUUaTR5oI/wDmQ2S5llOKwGfk7inwhIY5NhcdzBkUBcDEZQrLPLkGXvf64gHhVGdhMQvZ
	jY+RYRLMIKzI4VOrIy4+xq+HrKGLSDBBU2fZ7m1jq6zryYZV6Ihw3tRjhuq28tSoIuHgofd7FmJ
	KrGSkJRHAOVaKM+9R2waoN9uO2Drv3gtLi09/g4UdO/1uOTBeFRQay40=
X-Google-Smtp-Source: AGHT+IFUutBth5XkTwW1pC/OkCDAZih9KHUCMdYgxnZ59EYAd9MvBO/hHD+Z59SU25Og0yzU16T+xQ==
X-Received: by 2002:a05:6a21:6da7:b0:24e:e270:2f55 with SMTP id adf61e73a8af0-2602c14caccmr5977282637.35.1757734649906;
        Fri, 12 Sep 2025 20:37:29 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd98b439asm7150770a91.15.2025.09.12.20.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 20:37:29 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: hch@infradead.org,
	brauner@kernel.org
Cc: djwong@kernel.org,
	yi.zhang@huawei.com,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH 1/4] iomap: make sure iomap_adjust_read_range() are aligned with block_size
Date: Sat, 13 Sep 2025 11:37:15 +0800
Message-ID: <20250913033718.2800561-2-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250913033718.2800561-1-alexjlzheng@tencent.com>
References: <20250913033718.2800561-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

iomap_folio_state marks the uptodate state in units of block_size, so
it is better to check that pos and length are aligned with block_size.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/iomap/buffered-io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index fd827398afd2..0c38333933c6 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -234,6 +234,9 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	unsigned first = poff >> block_bits;
 	unsigned last = (poff + plen - 1) >> block_bits;
 
+	WARN_ON(*pos & (block_size - 1));
+	WARN_ON(length & (block_size - 1));
+
 	/*
 	 * If the block size is smaller than the page size, we need to check the
 	 * per-block uptodate status and adjust the offset and length if needed
-- 
2.49.0


