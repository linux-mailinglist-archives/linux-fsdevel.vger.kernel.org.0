Return-Path: <linux-fsdevel+bounces-49446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B68ABC70B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 20:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EBA11B60E8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 18:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACC0288C36;
	Mon, 19 May 2025 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDyUE/b/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCC11EF0BE;
	Mon, 19 May 2025 18:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747678819; cv=none; b=Dwf0ahzEAig/0kJKvIf4/h409WsYTcAOWHghgR55MR/EkXGXMijU1CQ7CaA/4jTd9zMHE/vaIeJayAAaZmg4rBt2GQpJ5ciKWdhC4fUoj8nMQqt+iEaUoNUiKsUxZSLBz6y7MXRWz93bGeESStoTGQiu63wBkAS+XshMiXHELRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747678819; c=relaxed/simple;
	bh=ASxWt6o5R8aozdHueyAGurBK9v8hewbiDQleC75dZ98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otkYbP6zIeayuAlZ0cXtkKKICTwSMD7EnYkft84ZwT8uREtD0ZhMqjvj0bBNysda89dTmDOVfFAfgz2upA+ZBG9OZ3YWQ8/yDOEZXavpw4OHhEo5lFe7ss7+kp4tFWkJKfOcAuKBUBHuxnqq2In9UHwxxjAHSQhWVkqGHmzurQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDyUE/b/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22c33677183so40755315ad.2;
        Mon, 19 May 2025 11:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747678816; x=1748283616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KHmEnoUoiRzxxQJAbYkUBZg/eGkzEmLyA7/3r0V+4g=;
        b=JDyUE/b/04PZxXamt1SqaVUQxAq98tfCncG/z8mgNHnn59DSoE9w4tafizBfN9sKMY
         Oa0q3oDGhIahDXrzsZNPfN45Z0+0LwzsLLbWp/rM1rpmFa7HaY6B01adRrTSyofmVOT4
         ZBg7BM3UM3XZLJvMfhElL5LRV/CtKpJD4dNJ+r6kL1kexX8nDBpWfNOPYbt1zQhWnp7W
         J7DTlkjVPjZfkpzeJLmEqp+gBlhICs9k46EU2DK4btesQdYkTUdoBkxbxx8QdBJZ1MYw
         /2ME41tDmXn6TqzDR2efNxynCw9yBt26Y6WwQa7V0WVsCHbV6FDfr6tSTeGBqRC09fXm
         BGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747678816; x=1748283616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KHmEnoUoiRzxxQJAbYkUBZg/eGkzEmLyA7/3r0V+4g=;
        b=AIonLBjGfOGKbbVTv+hffRsNHX/K1FetdN0q3V9gLlqi7ORZmttiTX/la0DoRuVuAc
         wrw90mcjyfbovZN6h5GFg1sZ6j+8JMgu3haUUTI6lfaSpB3cp5O47l9LWeXyfpV+jEh+
         lGduwhOxvgo3B9vZWVZleNR6ueh9j3qIhUHvM3jkxR76toAZ/+iRsN35r5dN9ep/TE4L
         AvAJvwZxvCnereWjY0xrJUY2kNU3ycqzOQuJptiN8cSTvGiYJu2mqqt4coSYhKVPztUW
         PTmDP00fW1P9l+LOFabffzbKdob2RZ6mMoB5rcQFRdJTJj8/7FBvaZsilvqek0XSk47d
         5V0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWU/lOOk7dcvh0xMJ/P5fNfxq6C4+F3VI3uf2wHXVgPhnkY9def12FE6ejTS6O4y0AyL+I+J1powwvsOLqr@vger.kernel.org
X-Gm-Message-State: AOJu0YwfW7esE5KjTDuVMmmXQ/krwJt1UaDEnQRQjc7lnPX8EfZsQymJ
	Ad95HrhxZ3EW2Q4zNXiJPIjE4H/T4eLKQ0N6lU2srSSQVTN0QsmY+EzK+63VFQ==
X-Gm-Gg: ASbGncv1LeWL+aNfjdwkYFfZAg4n4tjkVwJGfwwKXZ5UwH5mdafA2KdJXciheSPcYxW
	Z1+4Uk0B+x47r05/dfFiVdwN2Ctk7C/rLnUZSnkmwLRDfucyTl5ihWClRr86oacuypmz0HgKOI3
	y8j12yMI49uqZC6wbStIfPCfOfsIbDW/q1a+ck8ubBtUGtG329pwWbM+TbMmlDAgMUyrTnb1POW
	7cK0xbNTe4/ip41FxIF7coFKV09BLN+RYYpbcuz2EB1ZOwOV0tzMp1MLhn27jJBrRfHxTm18X3x
	kZ0eIbWP1R+/CblrUs0dClCkwu8riCIP/u2BYtlIlQfR9+nRYNhNXaf/
X-Google-Smtp-Source: AGHT+IGz8P04ZL4beARByFBIdEGoQrU9LfFNq+1c0Fd1ddPVj2ylhWZBloXAjpRmCHTe0/hA9O82oQ==
X-Received: by 2002:a17:902:e808:b0:22f:c19c:810c with SMTP id d9443c01a7336-231de3bad0dmr155435815ad.51.1747678815944;
        Mon, 19 May 2025 11:20:15 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.82.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed4ec3sm63156245ad.233.2025.05.19.11.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 11:20:15 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v1 4/5] ext4: Simplify flags in ext4_map_query_blocks()
Date: Mon, 19 May 2025 23:49:29 +0530
Message-ID: <4ae735e83e6f43341e53e2d289e59156a8360134.1747677758.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747677758.git.ritesh.list@gmail.com>
References: <cover.1747677758.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have EXT4_EX_QUERY_FILTER mask, let's use that to simplify
the filtering of flags for passing to ext4_ext_map_blocks() in
ext4_map_query_blocks() function. This allows us to kill the query_flags
local variable which is not needed anymore.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/ext4.h  | 3 ++-
 fs/ext4/inode.c | 4 +---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index c0489220d3c4..18373de980f2 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -762,7 +762,8 @@ enum {
  * pass while lookup/querying of on disk extent tree.
  */
 #define EXT4_EX_QUERY_FILTER	(EXT4_EX_NOCACHE | EXT4_EX_FORCE_CACHE |\
-				 EXT4_EX_NOFAIL)
+				 EXT4_EX_NOFAIL |\
+				 EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF)
 
 /*
  * Flags used by ext4_free_blocks
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d662ff486a82..5ddb65d6f8fb 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -544,12 +544,10 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
 	unsigned int status;
 	int retval;
 	unsigned int orig_mlen = map->m_len;
-	unsigned int query_flags = flags & EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF;
 
 	flags &= EXT4_EX_QUERY_FILTER;
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-		retval = ext4_ext_map_blocks(handle, inode, map,
-					     flags | query_flags);
+		retval = ext4_ext_map_blocks(handle, inode, map, flags);
 	else
 		retval = ext4_ind_map_blocks(handle, inode, map, flags);
 
-- 
2.49.0


