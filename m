Return-Path: <linux-fsdevel+bounces-25899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6049519CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 13:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DAD3280CA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 11:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD0A1AED33;
	Wed, 14 Aug 2024 11:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="dfvJ/BYc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF921442F7
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723634664; cv=none; b=nIgdNynsWqDsLX5QF4UOShWRg4LtUpGJV9xYpzePukLsWGsaQ4/OhzQs2Yr42Cf6mASYDJw7GPcNQjun1c9LDKwUBTWBKs9ZixUlVsFAOMqzDu4weVzAfz+lmljGD/105h4SJ9o9tvW5ukpzfsKGERk3TyHKJqPu3GWOt559K90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723634664; c=relaxed/simple;
	bh=kqDpV6GW4s9LS7UCsXnQnFTFNDMtjqH17Enqz0woQgs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WML2rmJBZtXyPIVf+fWvdTRTVG1tfm717yJJAunfRdCp6UtyWbdmHN48O/fT1/udbASfWJGM5IvuGzCsEiuGY1qYUZ6u+0KyhK7fvM2Hg8YsFhJmGfdL0Bkirg0PTNLIWGIxARkf8S/miI/v6pnFzJ+s8qrBxvy0Fa3AtCXn/aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=dfvJ/BYc; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D9E30421F8
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 11:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723634654;
	bh=DGRTrpULtBgL9ziW5qYGERpz+KbgogQRgUFpUA3ONkY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=dfvJ/BYcniG8ZTZ9kzNEpMMJavOyHkX14qW3lJqDLSwRnwnH71jPL/1lGQqgvWJS4
	 EOt3z5ASvInzCNoX2PXcVutdRGF5KJKIUCu8jgCwx9CApOev8rxEf4ElOi1Zg4fiTb
	 eIXznJS88urdS/2KQCIasrktvIY5WkRcuoq7JzJ9PJmAsVCq7umVfHZhwROnIzMear
	 uG+dj2wXYeDNkLkm015GVyWqhNWAbiub2Nz5PNAtCfZcZlFnNJmOZYodI9CFnho6Xn
	 MyigY5MtfaJf+NRua8erVYIswelBa92dWMuz1tS6PC4LLAX5YwyFo5i+Y7Ybg6nMip
	 zf+df4tlRpXSA==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5af95f7d65bso5510909a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 04:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723634654; x=1724239454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DGRTrpULtBgL9ziW5qYGERpz+KbgogQRgUFpUA3ONkY=;
        b=MAn+rMAuE3EhXd1nZ81LuQgaRnQXttijfL7G3xlGCXbC/Ahk6g/eqko12sgCZCzYnM
         Gd9UVjyLmvkpJ61soubIcT25xNqSU9q8nCxWz+59OAyjonzP6F4vwhfpP0u2lSfIOhXa
         daQkQQ/mDmmE6Y4OQfF5UaQnqzK+/5n7mf4P/ub0i8vFNgm6PcXD8BwXT8PNfgJsnI8T
         evuuLYG3c4z2yPlrGU5mAv56BlJnxJtGER8V+bZmNefs4iMGZ1OKAF6/0mBbg76ESzw8
         pSGRymUKOqn0tGkHwHuQO6YiY0wifdfjXZIf2DGtsSSsyt6d/+sD8KjO6A5TG6oBbZ6u
         QsUw==
X-Forwarded-Encrypted: i=1; AJvYcCWN4ohNszvLjP23+MGDDYCnMcC6X/v1J04NVXyT6/Cm7uivqJprvdMEy23ysSQLs4PGHZwXwRO4gJOBqfW9INqsklm4MJtQ09/kT+E2hQ==
X-Gm-Message-State: AOJu0YwARk9jqjVRNUUrbopSnJHA4/L2c9wagz1c6r0SJvDlt70Qo52v
	8CDPI4nw9jey6ZryKiWUu8a9ZFn/bxMdiNV/wdr4XwOJf0Rd/2bTgiW2v5gUxOuxkW280yNThUL
	CVMK5kTJfKhVO0cbBZyZOsbe9DbszeBGS7vsNb6DDkOBqOzO/q1swCoyR+VNWdZAVbQVrpDZVlA
	ZL2IY=
X-Received: by 2002:a17:907:e2d3:b0:a72:750d:ab08 with SMTP id a640c23a62f3a-a8366bfc25bmr166647366b.14.1723634654208;
        Wed, 14 Aug 2024 04:24:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqJ/FYMhm3HKEPcMJXzca42gbyfdyklEBH91iFSJATAmPNeFRFyyNn+G3/we+Qa3Mu8pH8iw==
X-Received: by 2002:a17:907:e2d3:b0:a72:750d:ab08 with SMTP id a640c23a62f3a-a8366bfc25bmr166644666b.14.1723634653684;
        Wed, 14 Aug 2024 04:24:13 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fb2110sm159919966b.78.2024.08.14.04.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 04:24:13 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: miklos@szeredi.hu
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: use GFP_KERNEL_ACCOUNT for allocations in fuse_dev_alloc
Date: Wed, 14 Aug 2024 13:23:56 +0200
Message-Id: <20240814112356.112329-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_dev_alloc() is called from the process context and it makes
sense to properly account allocated memory to the kmemcg as these
allocations are for long living objects.

Link: https://lore.kernel.org/all/20240105152129.196824-3-aleksandr.mikhalitsyn@canonical.com/

Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index ed4c2688047f..6dae007186e1 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1486,11 +1486,11 @@ struct fuse_dev *fuse_dev_alloc(void)
 	struct fuse_dev *fud;
 	struct list_head *pq;
 
-	fud = kzalloc(sizeof(struct fuse_dev), GFP_KERNEL);
+	fud = kzalloc(sizeof(struct fuse_dev), GFP_KERNEL_ACCOUNT);
 	if (!fud)
 		return NULL;
 
-	pq = kcalloc(FUSE_PQ_HASH_SIZE, sizeof(struct list_head), GFP_KERNEL);
+	pq = kcalloc(FUSE_PQ_HASH_SIZE, sizeof(struct list_head), GFP_KERNEL_ACCOUNT);
 	if (!pq) {
 		kfree(fud);
 		return NULL;
-- 
2.34.1


