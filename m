Return-Path: <linux-fsdevel+bounces-58896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 174EBB3321C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Aug 2025 20:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC40916AF28
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Aug 2025 18:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935AC225A3B;
	Sun, 24 Aug 2025 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0qwQM/7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E02219319;
	Sun, 24 Aug 2025 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756061599; cv=none; b=DjNwDVlPm6XMeCarWRYEP3WyzAfiYCNOvYRlt41M8lpomcYdL3z7D7w55UkRkGr7pC3CgSi8HxsFG1MqB1CJ4rnrKw/o8M9/Six9JNLXuHkmV0tbe46S8U/owLahYhysc+9Gpg96NdBvutGxMozxSsUCdDb8RXlRSQPxRqyw8G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756061599; c=relaxed/simple;
	bh=4EJq4wNWPMLYuFBqxFssXNNnlLgyF/sxKCWpm0zI2fM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lcq+JACCfv1f1ilN6On5/dim1P9ePxFzbFK3HTo2QO4/LT8Y6BDWycvcsECW2HvJ1K8ZO5AoFq7VZBt0sKhbo2ZLB1VqIzMk/g+uPvyB02D8fydTV30Cd0jR2ZC5c42N5Ds8EPDnhtvW7x8ZaQSBZHabT8M8lMlOH0pdXgdq34I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0qwQM/7; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-770305d333aso1997403b3a.0;
        Sun, 24 Aug 2025 11:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756061596; x=1756666396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GE24zAUqbweTViuU5OdT4m2X5cUCSUg+r8C+5GVDKWs=;
        b=K0qwQM/7G6Hc8A2KAzMoXJAHohwMSS7lRNli2RbWF59+sGy1G8t0cvBoKC66FVlVf+
         xqwZ0BZItIbxPIG/YXaxIvuP8qt08xpiNxGuQkPiWh+Ux7BreAqJ/dL3esq+fqPF8x3T
         XQTgS5xQVoxrCHCY0cwUzPftvKmmzkPNbp9zGX8JcW926HIEHOmW3RUrDQYixMT04Mc/
         rO9KpYDWowWmWbNUO8U/UHDncfv/49+26zQ7A/AdB++UjvBpqG3tvysYPwbDjvvaxS6N
         VAt4t5DOpOH//8gyb20wgTQ4BKNpiLL7kYaT8r/Y4pmducjy7jSF4Zpa4c5Xnj6i6/em
         AHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756061596; x=1756666396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GE24zAUqbweTViuU5OdT4m2X5cUCSUg+r8C+5GVDKWs=;
        b=pOwXnTb3CML5BkIG2O/3G6rVMbrJuIk79bxXYKYydHL7faXBLhviGsgI/d+dw21m82
         YgHo/VXF7on0JyNjyOUvsneVFKZ4zAf0E7N2wAJWzEw/yjNs834jIq16AzWWc4R//WcM
         iW9MWA2EgZD7XdnItTw1oLlX6GE4vNjk+zLNu2Z6sUqsY3uRFrfkMngzvttkD46sR1hv
         cqAxyZ9XDQo1xfYfs4/zY5zzh+voHFjE/fiUl/vL5w/QyFdPLQLMgJkZmpTf8T4PZmVq
         g7iWnq1WSPQXqfmJTr38qsFxFgqJuWj7ZW9W0oxAyOdo08oyxCZH8IwWOC2KdAjKR04x
         q2tg==
X-Gm-Message-State: AOJu0Yzps60o09ypt1FFlGuuuKleSgKKxij3mMXj8rrmLc19va/1p8j+
	zm/tHNQwL8ldrriL1rsg7aTGQha891RsqBXkv/TZNuHsC/ezebOfzPAzfo1ixmFy
X-Gm-Gg: ASbGncslzzktEDGFUAAuNkDp2ibVVGfHFi8fE3C0ifb9GGgEk8LW5UlsUqvpH+ZK/xq
	xTq5e+r3lsNyFIZrXfFd9ZscNBmDGJv7/KPX+/m6qIexmnaBuiPnXXaCDSxrMHSvkvqliPT/UFY
	xxs7eC1K22+Mp6Uukx67Y0DdIBMhW88z978GXofkB3JAXSI+DLUggQHRiDG9snikS05IcCOVz+r
	5obeoQ5xPEj2bKJgTt8RniACoi5oA+KV5ostBv4mWqidQ+hQN3N4tP24VmeC+KhAWsrz4lz1eau
	0yAfGHly3EP/sdrtf5z1W4Um08pyd2xJLiLcYzLNL0liaLChSKoaxX/4dNgWD/MY1DO7sUjH407
	D5kvCKXF1rd/YI07Qh7ErzK7erpIENtUuxx4S3FXDLe69bTEPp5wXLrvOXfka5W/Gq6cdMPpa4h
	4=
X-Google-Smtp-Source: AGHT+IFdxNjzzdR/+kzNWRlC87/GvjfTcFPfTOZA3kV3TZ7DiIUOZKdHwTRVsN18Ex3i5JQ0MhWnCQ==
X-Received: by 2002:a05:6a00:2e96:b0:770:58c6:d055 with SMTP id d2e1a72fcca58-77058c6dac2mr2136535b3a.5.1756061596471;
        Sun, 24 Aug 2025 11:53:16 -0700 (PDT)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([2409:40c0:1050:9e36:b286:7f1c:1cdb:ecf7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770529149bdsm2927622b3a.98.2025.08.24.11.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 11:53:16 -0700 (PDT)
From: ssranevjti@gmail.com
X-Google-Original-From: ssrane_b23@ee.vjti.ac.in
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	syzbot+0cee785b798102696a4b@syzkaller.appspotmail.com,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Subject: [PATCH] fs/namei: fix WARNING in do_mknodat due to invalid inode unlock
Date: Mon, 25 Aug 2025 00:23:03 +0530
Message-Id: <20250824185303.18519-1-ssrane_b23@ee.vjti.ac.in>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

The done_path_create() function unconditionally calls inode_unlock() on
path->dentry->d_inode without verifying that the path and inode are valid.
Under certain error conditions or race scenarios, this can lead to attempting
to unlock an inode that was never locked or has been corrupted, resulting in
a WARNING from the rwsem debugging code.

Add defensive checks to ensure both path->dentry and path->dentry->d_inode
are valid before attempting to unlock. This prevents the rwsem warning while
maintaining existing behavior for normal cases.

Reported-by: syzbot+0cee785b798102696a4b@syzkaller.appspotmail.com

Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
 fs/namei.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index cd43ff89fbaa..75ef579c38b7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4174,7 +4174,8 @@ void done_path_create(struct path *path, struct dentry *dentry)
 {
 	if (!IS_ERR(dentry))
 		dput(dentry);
-	inode_unlock(path->dentry->d_inode);
+	if (path->dentry && path->dentry->d_inode)
+		inode_unlock(path->dentry->d_inode);
 	mnt_drop_write(path->mnt);
 	path_put(path);
 }
-- 
2.34.1


