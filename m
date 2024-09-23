Return-Path: <linux-fsdevel+bounces-29887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 217CF97F014
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 20:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345531C21789
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 18:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293AB19E99B;
	Mon, 23 Sep 2024 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCDU+obU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489391EB36;
	Mon, 23 Sep 2024 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727114556; cv=none; b=Fo9GtETVTivBqCjn7fKnIkx2k8vbCMspM2V0co+12QIJa19Kx/VOe2U/017UYPENWm9lMm+CpNWRoKUVQEnIco0+REx09Zn3Ob+SPpAbm/4oFj96whlUIMGTY2A3MFZdx+ICye2Ss7ORB9NMTOxVGXjqfg9gAIGyqXDAVHmSxeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727114556; c=relaxed/simple;
	bh=i6A1h8ekt9sJf8i1G1ZE1UZpWt2//e1ngJB6vmWW/xM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ltbzuc78AgRSmb/U9ciGK2xTC8/TlJs+PHxroT7jG+6+cylQ1n3Vd/ykQncDS9spp3IOFn3ZJTBVKZH9YRM0evQXT2Rd5+kU9loFQSJ91QWBeCnLb1WBUmOzT1Hz7XNQwwELVccAoUmURBVHJx2BlU73lNI68KIO9j1/B5i75aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCDU+obU; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7d4fbe62bf5so2680227a12.0;
        Mon, 23 Sep 2024 11:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727114554; x=1727719354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+l5G06iAwNEMFjhIddmVaNEYy3o0TliivMNvfjYJnFA=;
        b=eCDU+obUEjZ/IFgj1Fv9TivgI1g3VHD0baO7ZurYKCM6Iebl9nCdY/xMuk2Z9TLFUT
         UKICDhRRtlRPlVqAebRL7YqhRNmY7r55q7Hn8r9BwRgZ3+5g0uKBDwjRozvGfwABW5UH
         8aGl7HvU7HLTGZZGoxebUadXl+tEQxxHigkEYeYsX7bGhTrH15fsEXer6KkE6RBr4XGu
         4dkqghrpqazFiSi2oit7vAiuop3PnupnpoFFvWyqa0xbNPTt76mP1m44ISKLmemHt//I
         /Rqn1pRwhcOiOJovFIHUoHPhHOr+d/yFzo2cLCbaIpkT1Q5bAydWjZ9iKLKY6np+vdyi
         woUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727114554; x=1727719354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+l5G06iAwNEMFjhIddmVaNEYy3o0TliivMNvfjYJnFA=;
        b=ZIiPwDw29oUlyD2TGfzuOS3fSvNT3ds6v43I6dU+AtXHTuppTNd1NwO64+EuR2Fbc2
         /Ok/UbRRGfFY0yfm8mL+AC3uiqzwlOC13RMm5uqSdh6G6YfhkRSd7g+QrsxtfXXF1A9O
         l9nVKK24IPHKAkNKyH3LNSOF0nnEhWD0UTrOpbmJI7BjZd8W0yowFsIfcnDoqHbXjXm1
         pRQV46aT4xQ0V7ZGsYmMEvQJ95xx5HkHCl/bv42B2BxLe/c/YSTsYLcsCKFHCtHMKz4N
         OZaUs3fMrgSmoj8LwIp5VBsZQSWZGglHqipo+SZ7ppZE+3MtpsbMu0ERcJ+Nmk2WzG4Y
         B2AQ==
X-Gm-Message-State: AOJu0YygDScf9q5sHDJa3LNGvY0H5xpOVGkDlBMo2J3lW1bRpqFmEBSO
	zINF0kEFs7PW8ClhV5XZWUqOTyJsP3yXXipDzLTegYIr2chaCa0rsWqUZA==
X-Google-Smtp-Source: AGHT+IEma2umjh1MgFLTRdkW/AXbjpBvdd/FAY5Bo/sTfzcsDa+cnUEQrdfXW1JW5LyjIqLyfhL+BA==
X-Received: by 2002:a05:6a20:6f08:b0:1cf:3a52:6ad6 with SMTP id adf61e73a8af0-1d30a96d7aamr18508977637.24.1727114554215;
        Mon, 23 Sep 2024 11:02:34 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.lan ([2409:40c0:223:9c18:52fc:a4b:7ef5:db4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b975f2sm14604598b3a.149.2024.09.23.11.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 11:02:33 -0700 (PDT)
From: SurajSonawane2415 <surajsonawane0215@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	SurajSonawane2415 <surajsonawane0215@gmail.com>,
	syzbot+18dd03a3fcf0ffe27da0@syzkaller.appspotmail.com
Subject: [PATCH] hfs: Fix uninitialized value issue in hfs_iget
Date: Mon, 23 Sep 2024 23:30:50 +0530
Message-Id: <20240923180050.11158-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix uninitialized value issue in hfs_iget by initializing the hfs_cat_rec 
structure in hfs_lookup.

Reported-by: syzbot+18dd03a3fcf0ffe27da0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=18dd03a3fcf0ffe27da0
Tested-by: syzbot+18dd03a3fcf0ffe27da0@syzkaller.appspotmail.com
Signed-off-by: SurajSonawane2415 <surajsonawane0215@gmail.com>
---
 fs/hfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index b75c26045df4..3b880b3e4b4c 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -20,7 +20,7 @@
 static struct dentry *hfs_lookup(struct inode *dir, struct dentry *dentry,
 				 unsigned int flags)
 {
-	hfs_cat_rec rec;
+	hfs_cat_rec rec = {0};
 	struct hfs_find_data fd;
 	struct inode *inode = NULL;
 	int res;
-- 
2.34.1


