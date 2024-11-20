Return-Path: <linux-fsdevel+bounces-35314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 987959D3963
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 12:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D186282BAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 11:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084951A304A;
	Wed, 20 Nov 2024 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Etsm7+z8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAC41A2544;
	Wed, 20 Nov 2024 11:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732101656; cv=none; b=T7mYo9TmKQ/hr/Q5U/52G8obW9y30pzxz5X8aM6zIMqqwRWtuxbMQud5eIXZbhOO0KGTXMYYMOTsS+bZKchthPVYWNkO0qjJbABJZZbV3PR5czH6gY6vvSjBzBdkzMqpPub3ch0b0DtTvUe4LB5SnCVKEexuYltw2hXw6HKiKd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732101656; c=relaxed/simple;
	bh=xtTZUjsWZVXj5yW5dnZUqVQ8rBguXuqM28VC+lUH3wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7XUTwFcU4RiYB73EbjgxgQQnpyuN+h8Y24tit6xVU/79F4TX6raQNOpRl2iz2mHwU/aY2vGmz97655VouBzvZPEeMWq639Ksi0m9lAae+42cNALkUoBJH0eYW28m1g0/1oz0e+X+JMZRby6iLthqk6kze7EiJGv4ttCTZmiJ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Etsm7+z8; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9ed7d8d4e0so653844566b.1;
        Wed, 20 Nov 2024 03:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732101652; x=1732706452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMDpr51HGMdjTn/zZt2QmbhLNhc4xxoRwRH832sAaPM=;
        b=Etsm7+z8RhZ+El8Cq8B4d90xuRHGDdAc+mJnKhDmNO78DNBX8Lge1evFtG4yOcNLgx
         2zb2toy8iT5IqGoloiHDKsJhY1gi1R+vxN7hs2/L2fghXqk/8vU/pN9bzu6oa3Rn7a7M
         gub6IBCpNZRd3EjzoQCQITEwmnuBavv/WA7L5j0Sq5+lRPiJrjbzOXYw2cNmhiuriCzA
         Nms8Smlj0RBD6aI/Bo/AV0MD9RjnW94kvO/tAIl05KIv2kVuzO9BA6tz3d+cwVc22hzQ
         ugt+jOtejtlwp3XwaJJWjZvWxQlGxYzusJiY3Zm3AScKeGFRD2PdnCwQcOE6UHA+Rv6c
         utsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732101652; x=1732706452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMDpr51HGMdjTn/zZt2QmbhLNhc4xxoRwRH832sAaPM=;
        b=C/RbiBKfgHmosFg5Y9W90gHzC49KiqNYqCBIrcOJRr4PRcpNyHXltD5Rr21N/RWwLD
         vms2A0d8orj3PTO+6Tf3dmimcFaW69P71YLcjogcfkEKRKQGsUp54bAngDrZH0AIPPOA
         AfgVh/B+pA9a4PDJFS9tnwntRnp3ctpbPDbI75O/WbWIYvSaY5ZYIadciMnDBTEbj72A
         R9fk0tVAJoaormjW2z+jc8ziT7+Ad7AYgfcr94qt3T9bcsIvP7wxijFcq2eintWPwV9R
         h9NDBQ418+xYiiUUejBRzwHz3FpqcI9ajeYTEMMNBlzGBWfEEj3gyD9yVrgKw2jw6zG/
         HwWg==
X-Forwarded-Encrypted: i=1; AJvYcCUol2MvKvULJ7ftE9yB0TxpKsHtgjythBSadv0jOeWPwWQBn6UYkZP2Y2H4vw7lvkIb9x0LqpTmozsBggafuw==@vger.kernel.org, AJvYcCV3AR8JudyKxtJ7yjwsKo8mxwMkIK0MJMXImyufIOPVmaC9DQ3ShjJuJQ1Bf37ZpiPzTP4jfBIKOYWz@vger.kernel.org, AJvYcCVoE/7/J8Cev4ZYiwKm2X/sJlMf/vfkGKRsGM5ooxb3oJ85EQWSTO1/NCrR16kYjqMA8D+I+lA+zLnQg/6F@vger.kernel.org
X-Gm-Message-State: AOJu0YwOtyrl7r/lwgPL2Zlicxsvw9SMnDavCVX5VA42PpLsUIy35DBZ
	Dqv1x9+brW+8M5bwjQNJQJDJl1ghT/pKpIKwJNdd3m9DVBc5LGeB
X-Google-Smtp-Source: AGHT+IGME9zrR7PEmCppueSU0EVvlvlY9LrKb85f85FZGjKra7l7vMMQegldnpEbAzUI5fVhjh2VUg==
X-Received: by 2002:a17:906:c102:b0:aa4:7905:b823 with SMTP id a640c23a62f3a-aa4dd6b0c82mr252771066b.32.1732101651378;
        Wed, 20 Nov 2024 03:20:51 -0800 (PST)
Received: from f.. (cst-prg-93-87.cust.vodafone.cz. [46.135.93.87])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df5690csm758559566b.75.2024.11.20.03.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:20:50 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	hughd@google.com,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	linux-mm@kvack.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 2/3] ext4: use inode_set_cached_link()
Date: Wed, 20 Nov 2024 12:20:35 +0100
Message-ID: <20241120112037.822078-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120112037.822078-1-mjguzik@gmail.com>
References: <20241120112037.822078-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/ext4/inode.c | 3 ++-
 fs/ext4/namei.c | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 89aade6f45f6..7c54ae5fcbd4 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5006,10 +5006,11 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 		if (IS_ENCRYPTED(inode)) {
 			inode->i_op = &ext4_encrypted_symlink_inode_operations;
 		} else if (ext4_inode_is_fast_symlink(inode)) {
-			inode->i_link = (char *)ei->i_data;
 			inode->i_op = &ext4_fast_symlink_inode_operations;
 			nd_terminate_link(ei->i_data, inode->i_size,
 				sizeof(ei->i_data) - 1);
+			inode_set_cached_link(inode, (char *)ei->i_data,
+					      inode->i_size);
 		} else {
 			inode->i_op = &ext4_symlink_inode_operations;
 		}
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index bcf2737078b8..536d56d15072 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3418,7 +3418,6 @@ static int ext4_symlink(struct mnt_idmap *idmap, struct inode *dir,
 			inode->i_op = &ext4_symlink_inode_operations;
 		} else {
 			inode->i_op = &ext4_fast_symlink_inode_operations;
-			inode->i_link = (char *)&EXT4_I(inode)->i_data;
 		}
 	}
 
@@ -3434,6 +3433,9 @@ static int ext4_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		       disk_link.len);
 		inode->i_size = disk_link.len - 1;
 		EXT4_I(inode)->i_disksize = inode->i_size;
+		if (!IS_ENCRYPTED(inode))
+			inode_set_cached_link(inode, (char *)&EXT4_I(inode)->i_data,
+					      inode->i_size);
 	}
 	err = ext4_add_nondir(handle, dentry, &inode);
 	if (handle)
-- 
2.43.0


