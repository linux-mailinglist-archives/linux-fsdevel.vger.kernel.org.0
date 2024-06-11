Return-Path: <linux-fsdevel+bounces-21435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84035903B84
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 14:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB81F28617C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 12:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781A117D35A;
	Tue, 11 Jun 2024 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAZl7gn1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5570417C9F8;
	Tue, 11 Jun 2024 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107608; cv=none; b=WRMdljvzbw+L5hp326Y9BczRG0iZ7Ig3HGGZVN7lFz45uLYw+E61gYT1TJSuGP9xIvIVqdsr8qg3YGHMc5hBVRTJOteeGjYqMyUzOtNjbmfVjVc1uh1ZdxaSZPgz1R443wMzs6FvMHew3d4vW8lEPFP88JvM6DK/BRKm9lH5xjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107608; c=relaxed/simple;
	bh=LC/PPNBe913MP1/Zapm7HIw6oeoAmG+QwTk0uG/mMuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/Qasu8z9ZnRFof7syrdxnMR4UOQzLBDKLcegRFPX0ZhtB9Hugpq/c0oWfmAjSuvXDzMI5YB0wOkxHZ5yvmw6YiZ02euLQ0uzVQ54lAFJuKZeoG0X/JECsEp6MZrnXGdxB6fhtoC91ZgA2D5w5nbK6lFEzTiD0iaVgDz2rJIs4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAZl7gn1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-422757c0e72so631565e9.1;
        Tue, 11 Jun 2024 05:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718107606; x=1718712406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxDSFc22TbE5QEL+aATYVz7Hu5KVvQhfb2QlhPoHBBM=;
        b=OAZl7gn1uJ436v+S38Tl4XgX1CHh5S4j6SvyryoopBZOLQMb5icbbQPVpdE9Z1YTT9
         cG/kyweuO/FkvdGg7i06PrOVzwt+a4BSpMInS4yNHuqVVhVVCp6zCUvQQREq849YtI8c
         8nJYRfb8Uf3WHNWM41cfCRMC4iXdq2qrjUq3fqidJFGsXVs7nqGuI6IJYS7wptw3+X20
         XFeTNQU4uaYo4anAuv0v1+fKD3ksNUbfR8tDPPcBdSaLKk13fxH/LJmUUoKSd/OWO0+H
         nnoaPGxmTmmfbfJzAWr720sn0+wO3690S5KBhL/+y+Dcy5CV6RuXG/lzYhMKe5vNpVQH
         mK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718107606; x=1718712406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxDSFc22TbE5QEL+aATYVz7Hu5KVvQhfb2QlhPoHBBM=;
        b=Nxl40J0QgnNkxIr/1LDHFD+hwW+gax5F7D6v4Cgcs4v3QRDiKPLNuWJkWrfVkw8cun
         YBOFuxFSUNamqSXS1044qv6J4RLc3UKFnpC0Vi1cyH7wqAzIc3VzICGc4K/brFGU5LAt
         Onvq3vTEPHua0ZJpitbB/EMnvyih98EZc9wfmjgPU2mqYOgQ19lIpcgUlERPQlkrWrGq
         7YpvaKuvYwXg7LTMcFFZRL3QzYm0zCoWKFyyaDKFocroTncRWoRW/FAprBHj9IKB3baj
         TAMomm3KAWGKJD6JAyoLctdX0Iamlxn//4h0QfZXaEBZvOSo5Tq+FLaPsQe5rhLx/tkk
         qigQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMXS0zp29XeppCI3X6bCbPwfMMSE9YRi2A9ibuyoHcdP2h9cJdAk6OMafSsfXVmVCgqjuM+KnUDXSJyvOe3FVLzPG0KIJjTpCa1SYxxknnjsm8+2g1G7W+BpycFqyDY7lM+3eUN6jSPLd+ien5X208ACjWZwVtDqDYYQwz6tN7aN7Mwk0UCQz7oVfnBQPO0a2vwW0zWotT/5rHbZf/DpoAw3tw4tOG
X-Gm-Message-State: AOJu0YwR/FWrAD69B9g5EvidbHfPCOHuPJNcICnFLBeLkY/giufBUfYw
	KAw4WwgrJMeQMN6qrqGs4eiHVn7X6+vjFgQSsou6/RGzgSgnSNrg
X-Google-Smtp-Source: AGHT+IHRHj2G4q3Op7dp5LdtPyVP+RyHt5ovPjaHnuV7yKmTMKcujV/2Jqsv/1lgmwqOBvBmLUIU5Q==
X-Received: by 2002:a05:600c:45c9:b0:421:8e64:5f72 with SMTP id 5b1f17b1804b1-4218e646ea5mr52211735e9.18.1718107605845;
        Tue, 11 Jun 2024 05:06:45 -0700 (PDT)
Received: from f.. (cst-prg-65-249.cust.vodafone.cz. [46.135.65.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215814f141sm209315785e9.42.2024.06.11.05.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 05:06:45 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	kent.overstreet@linux.dev,
	linux-xfs@vger.kernel.org,
	david@fromorbit.com,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 4/4] bcachefs: remove now spurious i_state initialization
Date: Tue, 11 Jun 2024 14:06:26 +0200
Message-ID: <20240611120626.513952-5-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611120626.513952-1-mjguzik@gmail.com>
References: <20240611120626.513952-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

inode_init_always started setting the field to 0.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/bcachefs/fs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 514bf83ebe29..f9044da417ac 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -230,7 +230,6 @@ static struct bch_inode_info *__bch2_new_inode(struct bch_fs *c)
 	two_state_lock_init(&inode->ei_pagecache_lock);
 	INIT_LIST_HEAD(&inode->ei_vfs_inode_list);
 	mutex_init(&inode->ei_quota_lock);
-	inode->v.i_state = 0;
 
 	if (unlikely(inode_init_always(c->vfs_sb, &inode->v))) {
 		kmem_cache_free(bch2_inode_cache, inode);
-- 
2.43.0


