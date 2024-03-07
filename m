Return-Path: <linux-fsdevel+bounces-13844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC992874AAA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 10:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977601F21B16
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 09:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71D783CD8;
	Thu,  7 Mar 2024 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3Lhb9mF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE71823BF;
	Thu,  7 Mar 2024 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803214; cv=none; b=QPy+mFwhIM+rGDWW3Z3YOr2JHChuMzcJiSJTZq+pYeN6d8R3ZlfQgSXs9qJaguhjt+NU63bxqpfUTD6LZFsqLYuJ4od7yzCjJwizBKyIjbMpCSvUqNg4ibvfe3iFKjzBPDonaaZMVdCZ4XoT0H0hms2RDl1tiGFK12Hqc5AU5QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803214; c=relaxed/simple;
	bh=JExp8xfZdKco+i9aU2Nf94UpagHKLlLHb9vJ2ivtHCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pzt3NtnGv6mQZ/Rg1SjNRCVA+xNqOX0K9WIQAs4AJLHWjsMH9tqOE/kd8fAW+we+9ORQw/GB91EQWczfa8iep7EesZcI9gF0xdRmbVeLzEozhD8LpJ2hKfflqjNykQEzApCCWpN04E3f0Coo1QivPzqiiS9Qi8v5f7x+L4Eapy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3Lhb9mF; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33d568fbf62so299889f8f.3;
        Thu, 07 Mar 2024 01:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709803211; x=1710408011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YW0Mqn4ceL/DfI+pL4E21JiugQofGYiHeHUz1OXuJoM=;
        b=E3Lhb9mFfe4ncEejzXKKPhEgcBMgFRVWy+Q3/UVj5hnFxv8P2OPC+/5rt8s6ix4TuW
         B5751oRAKOCnxwOQS/Yr2aYlcg5sEA4wDYU217XzKZ/ku2MWzJ9BXvy2dhA2O5E/2aHp
         lHo9wKeY0vrwrm8No+aI9w/LQg9CwCBZhepNiNWiohdvFSODwtbtcYD43bNgoy/c4Ui7
         AJSQpV/Jfq6UW2y7PJgo+wr6fTiWVlnkh7Ss3PK9mYpvgF9cCAeVAsQlh+EP33i7NNyd
         ayYaSe0LFTxxV4koo8C+ycrYbc/o+ehdveYQ4U1aRU+Xdnk5aop44pRyL5vIlI6P87CK
         PWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709803211; x=1710408011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YW0Mqn4ceL/DfI+pL4E21JiugQofGYiHeHUz1OXuJoM=;
        b=XWVcTyqKnKm7Ax1ApNJ3eX8nk6lmf71P08tp4rvC+4SFgXKSSAObwInAAY5D503dzC
         8UmfwM0P9siiRWc6a0rcOjsg2WxlS3SVcAw7hCz7p7VTaFIvJXHwQU0oSyiDtY9NEtyF
         U4Jrfr7yznYGCHpNtq9IeKrvhUb8S0rKvfQzyYjzwjAkPZR15zxD9sWzK4Y6r6ppuYya
         2creDCFIZw2nFC5QkcmiWlv1bR6/rhUTrleO400s3oxkhskcTWSbYufC6P/zV3mA087C
         6C5q5+qUBGT1+U+0fAoXVAjk/U5JWj55X8LHMtamyIjgaJ39ipx4WKkjQqLHWjvK8eFj
         Q09w==
X-Forwarded-Encrypted: i=1; AJvYcCWQPE3BZVXgoDv0NGpBxZDG5lwUwZyVQ0s7Wl763h0f4j2B//7exvBPu+lmNL83N6HNd7MhXpUc/OTPFiqADmuLqXWO3Ot8ygw1/U5YFfi1oF1jUCTfpUi1IVNKE3x9mUcVpt9ElBsUtbysRA==
X-Gm-Message-State: AOJu0YxJEH7LHenlCMZIptEtO4AVaDfGjAvvvuTQnH2w/GQivtMB4GvR
	ZRXgBQi6zazGg3zIcbsXPQq2dwXx1rGY1l6OmWrnCZjYnj409ujj
X-Google-Smtp-Source: AGHT+IFsxBXURzKqFHcbtOlx9sJQBSH12U2/M37d2BFYrAjIIjZsY3XNHK735iX4oAlq0YZvbc6xew==
X-Received: by 2002:a05:6000:4026:b0:33e:83a:b4f with SMTP id cp38-20020a056000402600b0033e083a0b4fmr17190412wrb.2.1709803210634;
        Thu, 07 Mar 2024 01:20:10 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bk15-20020a0560001d8f00b0033b48190e5esm20290113wrb.67.2024.03.07.01.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 01:20:10 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Wedson Almeida Filho <walmeida@microsoft.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	willy@infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next][V2] hfsplus: remove dev_err messages and fix errno values
Date: Thu,  7 Mar 2024 09:20:09 +0000
Message-Id: <20240307092009.1975845-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

While exercising hfsplus with stress-ng with xattr tests the kernel
log was spammed with many error messages. The need to emit these
messages is not necessary, so remove them. Also fix the errno returns,
for XATTR_CREATE errors these should be -EEXIST, and for XATTR_REPLACE
this should be -ENODATA.

Kudos to Matthew Wilcox for spotting the need for -EEXIST instead of
-EOPNOTSUPP.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---

V2: Also remove "cannot replace xattr" message and fix the errno returns

---
 fs/hfsplus/xattr.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 9c9ff6b8c6f7..f61a9370a233 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -288,8 +288,7 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 
 	if (!strcmp_xattr_finder_info(name)) {
 		if (flags & XATTR_CREATE) {
-			pr_err("xattr exists yet\n");
-			err = -EOPNOTSUPP;
+			err = -EEXIST;
 			goto end_setxattr;
 		}
 		hfs_bnode_read(cat_fd.bnode, &entry, cat_fd.entryoffset,
@@ -335,8 +334,7 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 
 	if (hfsplus_attr_exists(inode, name)) {
 		if (flags & XATTR_CREATE) {
-			pr_err("xattr exists yet\n");
-			err = -EOPNOTSUPP;
+			err = -EEXIST;
 			goto end_setxattr;
 		}
 		err = hfsplus_delete_attr(inode, name);
@@ -347,8 +345,7 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 			goto end_setxattr;
 	} else {
 		if (flags & XATTR_REPLACE) {
-			pr_err("cannot replace xattr\n");
-			err = -EOPNOTSUPP;
+			err = -ENODATA;
 			goto end_setxattr;
 		}
 		err = hfsplus_create_attr(inode, name, value, size);
-- 
2.39.2


