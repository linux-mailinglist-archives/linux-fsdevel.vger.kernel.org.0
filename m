Return-Path: <linux-fsdevel+bounces-35048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F219D073C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 01:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10CD2B21B45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 00:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6C68836;
	Mon, 18 Nov 2024 00:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hond2bpe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8BB819;
	Mon, 18 Nov 2024 00:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731889236; cv=none; b=uGpaqEgc0yvjS9LvvJhKufS7yRsdbNzAOuYeHhYnBtQhEvDtUlpANjS0rUe1ao589Ooid5ZTAd1nOJ6LE3TGqmyuiHXHFXSovgL3pMf+ayXxt2jJ4xLlU14KNbvkn9HBqdG3cARKB2hN/NNj5NbvcQz2/hNa0ppwcISBde/wGfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731889236; c=relaxed/simple;
	bh=qWcd5D8sd3+UhMvKYdzQ49jgWbEfqcjhjlh2Rt3gUAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ScLxoCRvu8OMWOvW1prHgz9ktHGI8OHYiKVD5+SqN7MRiL0u2fW7Vv2gE4UaOQORocLExI+lVtdvbLgGes7dYh4jKlu64CFbMarbv5k9uaox/izvNFOcCLV5i5uaPK25n/VVVKv5zRfQE6Jn4iG0jgFbx58sdr7/ShN3H6rpA70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hond2bpe; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9ed49edd41so637762666b.0;
        Sun, 17 Nov 2024 16:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731889233; x=1732494033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3uuKKKzXvA1LlQ/Rb2ziaNjZ6F4SAZ97tfXKGSd9YBU=;
        b=hond2bpeqbjLmU3Zed9HqYyRsQZogqyuuAVYXjt7z45k34F5N/BWUJDNiyz/rW6bgy
         OQyvYiu7Y8Yo5ycejgGSTeXVfzQetcpfC5qpH3pBe0pw0vVdr2BMMcMFTky9oR09cm8a
         q/0WKf1BX13l6ICslaW7lgOpm7ZQrIXjfXdjun7JRgwxJQqiip0gyMpYggrsbXmMUeRE
         C2xyWFKP8kVKyL0OISyzJs+9xnYgmzYQ9gmRm1JHCKEEH4u/lUIoQ4HIdmE3SPcmcu6U
         Mc/v7AGS38lUHRHW1GnTsYMDptLbWc1v2WbFEPceYUwdgSFQmJj54TS7+9l0suibVjm/
         Zo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731889233; x=1732494033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3uuKKKzXvA1LlQ/Rb2ziaNjZ6F4SAZ97tfXKGSd9YBU=;
        b=HGsmVIpp4SorQ25xTEFq9GuXcRAf6P9wb+j8s2TORpHMWfiUr2m8kObBwpsR5KR3yS
         0i+6eAYQgeha4exaJOY9oShjxFHnEI6M1Rfx3wbSBc2GbfugbsdxVBO7aEmBamqASOk6
         94lqHvLtm7KkAeiRJqgOQYqoul78UzCPWy2rDBfDoUGceD4uG2pxjWYv7IpGghfnYlda
         Ccg3fPdnThhVh8pbEZXC9LLohX/UmLLk0qUGgJC0T9cqPynrKeTAX2syUm5IBFbMZtXz
         4Kr8NEqgfY1p7TOCSaFtzCqsLHuiC3F9yrNMciid6AMafJXvnNdgR3W1nZ9n3H/4zkXs
         /MMg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ1X3GiOqZeH2vB+48Xecj8WDYjzhEBEWCMPdKtzXLNYvKy+bnxq3XU98ZFVNKGH6q71nIYMVz6s3VhEnx@vger.kernel.org, AJvYcCVh3yu0gCUCP8aL32ABmnz7EujnRLe1AZ3pC3ytKprcUlWXk2v6MBW8XvIWFZqu5vKnUGtbSUsHAOXsKOHE@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy1LUfOCc18OyaT7lI+6/0J/ae4O3dUrS1hj0wTEL3Kt3Z0Jxo
	5dGItMqCHrhOuC3Ry6MQSF/TzpS9oZNtiw0eC9Th3EQ66N9mQJ8HUQfR8w==
X-Google-Smtp-Source: AGHT+IE1n4bVGAu7K0QcRxrjHt1lZHMiWhWUFTOQceUV1qY68Y/pvTgIqS29ZwC0izS+mKfshcnuLw==
X-Received: by 2002:a17:907:c12:b0:a9a:2afc:e4e3 with SMTP id a640c23a62f3a-aa4835523fdmr982278166b.50.1731889232571;
        Sun, 17 Nov 2024 16:20:32 -0800 (PST)
Received: from f.. (cst-prg-69-34.cust.vodafone.cz. [46.135.69.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dfffcd4sm470271466b.98.2024.11.17.16.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 16:20:31 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] vfs: move getattr in inode_operations to a more commonly read area
Date: Mon, 18 Nov 2024 01:20:24 +0100
Message-ID: <20241118002024.451858-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Notabaly occupied by lookup, get_link and permission.

This pushes unlink to another cache line, otherwise the layout is the
same on that front.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

Probably more can be done to rearrange struct. If someone is down to do
it, I'm happy with this patch being dropped.

 include/linux/fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7e29433c5ecc..972147da71f9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2140,6 +2140,8 @@ struct inode_operations {
 	const char * (*get_link) (struct dentry *, struct inode *, struct delayed_call *);
 	int (*permission) (struct mnt_idmap *, struct inode *, int);
 	struct posix_acl * (*get_inode_acl)(struct inode *, int, bool);
+	int (*getattr) (struct mnt_idmap *, const struct path *,
+			struct kstat *, u32, unsigned int);
 
 	int (*readlink) (struct dentry *, char __user *,int);
 
@@ -2157,8 +2159,6 @@ struct inode_operations {
 	int (*rename) (struct mnt_idmap *, struct inode *, struct dentry *,
 			struct inode *, struct dentry *, unsigned int);
 	int (*setattr) (struct mnt_idmap *, struct dentry *, struct iattr *);
-	int (*getattr) (struct mnt_idmap *, const struct path *,
-			struct kstat *, u32, unsigned int);
 	ssize_t (*listxattr) (struct dentry *, char *, size_t);
 	int (*fiemap)(struct inode *, struct fiemap_extent_info *, u64 start,
 		      u64 len);
-- 
2.43.0


