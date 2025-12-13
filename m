Return-Path: <linux-fsdevel+bounces-71227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0663DCBA283
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 02:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C192130B8150
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 01:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665A71DE4EF;
	Sat, 13 Dec 2025 01:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNpl1/aS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA151DE4E1
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Dec 2025 01:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765589358; cv=none; b=hpcQzco7lfrnR5LG6P1iUIlhxtdMGCMmLViBiwL6Y3Uabzg7vkBmdFbSGb4SSbldTCL5c/I+kZqP+/Ds/Cq+9rG6N6uHQOTNDmvfu+NiUiQ/rEsMmQ+OB6rAVirjjn6V/CLe6BEInCDEY4Ri1dOKQ+YcotFJtTHgYH8oR/7dYGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765589358; c=relaxed/simple;
	bh=Q/BnWKrddUCa21vqQ0fyH/iLAaKmHYd+0zEE+INzCdw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AHe0/OLQyMywPKZ+Z8FmxKYk2ia9wmSg3PxfdY3fBmWPoA22o9YKGtaqfY7cWqDLHm3bUnt1vmOqIutcZUDUSdZr8cf1jLnDLRvSfwbsE2BzGsqpoUYtfYzDy0Arj7ersYjnD+lewOb2j2/6QqSLqM37jq/5pPhCNgeHi5lYqE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNpl1/aS; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34ab4ac9a34so215697a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 17:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765589357; x=1766194157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cln0tpkwGaPX83TGznuKujQwit6sD5kTkWZGVuQGa7E=;
        b=QNpl1/aSjjIszVUEeeu/E0BXJJDs5CqtTKVNskrDbdaqhFT5h02pZddplzz9uOXGhJ
         VHPwsJ45twAIaqaCLyoNyuNh/FWxW0azobrWJoz7246c9zv1P1ODIWTuW8tUxwue0Pzz
         cvTXvgcgbwBBIUBI3zH6coSfnk8WYk7bwURh1G+euFxIBTD+99DjcVUAQot4JRZciJC3
         tsIdxPlTJc9ZeSRwfL2sbBKPxMdZmTtNjQ8Y38keciKdu/WPL/TDUgGSOum5XfisY4h+
         cPvzyP3ZcG9bUsuXQOrf1X1Iox12+WKzyxzt3jTUiw7czS/eK1hz5gYQ2s3DoQxoKHk0
         jsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765589357; x=1766194157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cln0tpkwGaPX83TGznuKujQwit6sD5kTkWZGVuQGa7E=;
        b=VOgLK1zOTF2+mPuUBU/AgM9MyL7KaWCfYwutPbd4GXGWsHV//oEpb3NUYo7w9/PEPf
         kesMDkNrExxFlvnHszbNsc2ILhwO5uQ0RvrSI3veWJz7t2BtQdi8dd8pLdYTLE5wIqzz
         gGsCnFHFQhh9y6rDXYjyTymVZm6LkitP4ATRxqfZr3DVZVwHsD3PMWUljaUIxHdCk8g0
         p+hk4TZAmYQ/ObOmoO0Lm1N6XyR1ybxStGglluzExhqQAUm6cjeer3jQnxbhS5Zn2WPf
         6WlYw1m43B8kHeNwyQbor37aMCcgxZzgSQ+/3pWKc63Mr81OCAnLkpQLchmbB4f/41lx
         SCww==
X-Forwarded-Encrypted: i=1; AJvYcCXWLete2Q5XmDASEyhtmKR+55vEiLkb7PwVKsYqPvEs2kML77pQ6TiBwxFx57m/DTr35PJxY26EDYJ0uYgD@vger.kernel.org
X-Gm-Message-State: AOJu0YzI0US7ZZMQO7lpNUwPDdSy0gw3z40GILCf6lK2MlIg+eSIFvne
	UFVW7oJdKMHzwLaDO7a5OypW70XVwimnu8+xo1RtxQdtfjU8mgT3wv4A
X-Gm-Gg: AY/fxX7GagdeusQh51yAacgm20op3bwArCx4c8xnLYrVDT/kw/+L07IEMGFnZV/mf/7
	XuOELzLKg20GZl8GXk4f5I39qy9tFNJB1jsUO4RXFmxobi35fqumO0gmUf+NclSlELF3gN6bVHf
	IKl3TQ2jynghluAStoxf8gUM/GUi6egZXKV0ANt3mTjaRQpOt5J6dKUxwHf3Rows3dBxLzVRvbh
	qxud6rBBUTPCnzsVbmcXN+DKp1VVeHlrRyHxs4b6iPV/qb4IlKHBxzqTt1zg/i2DJGstUnpZpyW
	X6aw1w5hgmo7SWa8lbLGI8+x7iXR7HTHiZYtt5ZsY8bpmOq3M2s4mwTcSYSDx4INcLFSd8od6AA
	w/sqT75cnrqtTElx+t2tRS4i8ijkZe/CtTUHVcZdzt4kipfBWqgYv9+6+rqaCLXQ0m6b2eoIjGF
	PnFrzW7R+n8bc/GhmZT0bvtdpkEXwdaM+fzux/z58Zp40WeXWpUGJ0gDeXNhxc7ptWcgHNRWc8
X-Google-Smtp-Source: AGHT+IE2FNluVs7vDa7N2km+hccJ4M70DEuxxCelM+kxINda5gMkw26py8jFfb68ATt4fxnqeEdPGQ==
X-Received: by 2002:a17:90b:2692:b0:340:b501:3ae2 with SMTP id 98e67ed59e1d1-34abd5c1d75mr2654608a91.0.1765589356670;
        Fri, 12 Dec 2025 17:29:16 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ad5663dsm6370008a12.17.2025.12.12.17.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 17:29:16 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhitong Liu <liuzhitong1993@gmail.com>,
	Qianchang Zhao <pioooooooooip@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] virtiofs: fix NULL dereference in virtio_fs_add_queues_sysfs()
Date: Sat, 13 Dec 2025 10:28:29 +0900
Message-Id: <20251213012829.685605-1-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_fs_add_queues_sysfs() creates per-queue sysfs kobjects via
kobject_create_and_add(). The current code checks the wrong variable
after the allocation:

- kobject_create_and_add() may return NULL on failure.
- The code incorrectly checks fs->mqs_kobj (the parent kobject), which is
  expected to be non-NULL at this point.
- If kobject_create_and_add() fails, fsvq->kobj is NULL but the code can
  still call sysfs_create_group(fsvq->kobj, ...), leading to a NULL pointer
  dereference and kernel panic (DoS).

Fix by validating fsvq->kobj immediately after kobject_create_and_add()
and aborting on failure, so sysfs_create_group() is never called with a
NULL kobject.

Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
Reported-by: Zhitong Liu <liuzhitong1993@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 fs/fuse/virtio_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 6bc7c97b0..b2f6486fe 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -373,7 +373,7 @@ static int virtio_fs_add_queues_sysfs(struct virtio_fs *fs)
 
 		sprintf(buff, "%d", i);
 		fsvq->kobj = kobject_create_and_add(buff, fs->mqs_kobj);
-		if (!fs->mqs_kobj) {
+		if (!fsvq->kobj) {
 			ret = -ENOMEM;
 			goto out_del;
 		}
-- 
2.34.1


