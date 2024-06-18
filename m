Return-Path: <linux-fsdevel+bounces-21874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 945C590CA77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 13:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A8521F21782
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 11:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB8615251D;
	Tue, 18 Jun 2024 11:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUsSTUQV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9FF14F113;
	Tue, 18 Jun 2024 11:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718710521; cv=none; b=u2nxp5cD7se51nbqDNAxd6ZtFzR28sZNGCliKyikCqM3hUdPxqn08akEtywCZ9TXXit70DmLxrifviTiJEtB8HpkCDwZr4o/dfFZEohKZYFO6Fd3mxwIoT/FnN2mUTW5SqE1Zmtyy3+JSHwTn/bOfTDO+awTvVwd4SNDeVOw4l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718710521; c=relaxed/simple;
	bh=n47kLEmQKieXHan4dWpUnWxQFa+g8WSINLqmwH5d7P8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N9nseXq//5trdJvVJUV+KtQx0R0nOJVwbnvUEK7VTj2SAC8GMNTDgW7yzxS1eUE8vCgzHOz1sckmAUT62f9AotUYL22524hwmdnX5Z9iNWJ+244TmNTmR42xCJM6rcPzDPu7oNWZLgkbqL0Kg9T04nAWBfGYQhhsMlXVxJF7kBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUsSTUQV; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70423e8e6c9so4661205b3a.0;
        Tue, 18 Jun 2024 04:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718710519; x=1719315319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7flslpC78LMU2Bq6YkuOUsByOSqBWx2+Qe6VdxlJ3Y=;
        b=JUsSTUQVe5TRty4P1gPHCMbMGt1tLWOzBxAWkdkXEcZSCDwhow6ICkuSydiSc1hf4r
         VtFWzrKyvcGfiqkZIPRvs9udc5z2Dw5ylGA13Rd3BiTtfE/wB4oFHECDa1qwZSF+2hJI
         szooNibkjaEyaJ4W9OVrAXCb1/F0rQvLnRmw4z/hLAquOaDMp7BPJGYeS/lLUDvtPes4
         LDN3sIan3aspNqT6yFhyb0tf3180sz64lH8+jUp41F1RfCllCr58CWxm4EbTKWy81Nfz
         45JVu8+ixkd9HhmaB+Xsiy9/ruX179XAL6Yz+Lzx2WU8oo4eN+d1brfcC4ya4MlnfZ/f
         tyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718710519; x=1719315319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7flslpC78LMU2Bq6YkuOUsByOSqBWx2+Qe6VdxlJ3Y=;
        b=SqFN164dHHzJvS3WNY2g/k29oHW3np5madcBXuEgs8pi8CNQoZ1GKh7hFRQe7a8CFx
         5VUL2SNSvF/NiOWE7BVvCT8Eo7rS3H4edYkSlt1WKxSX1GOnbHC0WdHvgjzcV33aTLBW
         yUwJcZbv+MnZcYgH6FpphzZ9FmGb0rmf7meLjHdRxhy3kQw5V6H/y0XzgWXiDXzKU30X
         xFXKc2vnQksvgNNL9Wlom/bJjJCzOaezsfqjdW4ECIzhEN3xRLj95J647R7GryXmDZMe
         kjGtON9u20/QtJveuCVkTdHYdhGKRz6dskS9SAU2emdGWrj32PQN17gdpYUQ67A2BHw8
         40Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXdKlr419FMQSv5g90gI13odEq6ikWQgckXd2AYoqnHLNWgrdWBj9G6iw6Mp1qL+qpxB1s27C5AWhTjwE1rpaCBvgQ9jL70trPc
X-Gm-Message-State: AOJu0Yzg7+WCkTZc/AlAtPoBycBvBzZ+uKFvDTNdVOd3lqIO9+/RyiSR
	1kvdw2Wf0NZDYV4kgerfnhL3/koQiDHa83BnjD1Fjqc7cySW5/nZVYBGAH1H
X-Google-Smtp-Source: AGHT+IF7g4VV0x1ZRFkMEt5reEs/zVN0Cj794QAaeGopj7qQO5Kzs6GXfWDzfFOHCHkqR2yd9wP67g==
X-Received: by 2002:a05:6a00:4e51:b0:705:bd25:dcb5 with SMTP id d2e1a72fcca58-705d71cc2f5mr11296934b3a.28.1718710518670;
        Tue, 18 Jun 2024 04:35:18 -0700 (PDT)
Received: from localhost ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fee3013f51sm7862210a12.61.2024.06.18.04.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 04:35:18 -0700 (PDT)
From: Junchao Sun <sunjunchao2870@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	Junchao Sun <sunjunchao2870@gmail.com>
Subject: [PATCH 2/2] vfs: reorder struct file structure elements to remove unneeded padding.
Date: Tue, 18 Jun 2024 19:35:05 +0800
Message-Id: <20240618113505.476072-2-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618113505.476072-1-sunjunchao2870@gmail.com>
References: <20240618113505.476072-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By reordering the elements in the struct file structure, we can
reduce the padding needed on an x86_64 system by 8 bytes.

Signed-off-by: Junchao Sun <sunjunchao2870@gmail.com>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0283cf366c2a..9235b7a960d3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -999,10 +999,10 @@ struct file {
 	 */
 	spinlock_t		f_lock;
 	fmode_t			f_mode;
+	unsigned int		f_flags;
 	atomic_long_t		f_count;
 	struct mutex		f_pos_lock;
 	loff_t			f_pos;
-	unsigned int		f_flags;
 	struct fown_struct	f_owner;
 	const struct cred	*f_cred;
 	struct file_ra_state	f_ra;
-- 
2.39.2


