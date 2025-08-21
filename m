Return-Path: <linux-fsdevel+bounces-58652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD2DB3065F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C751A1CE26DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CA138C600;
	Thu, 21 Aug 2025 20:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="1jhjCkcN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2E32E88B3
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807640; cv=none; b=GRAPIC3tzxliCMzY+sK7oEKCutdz/hWwf5zWmeNSu4D1m4cHGN4gSHJUs5imjuAo0dVdQ4n0eXUJLBfs5hiXSzuW5tkNLGVXiui8KgySaoCYZrmfU5/UueWOw4fuXH23cFNrRjO1qeYQMOdxVTt83WYdHI7ukpFUYTfda28iU5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807640; c=relaxed/simple;
	bh=9m81VleAoJYIsplclL8wgSUlUDqD+fV0ieyF3eIa3Io=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8Tfq7apdYeNZjleVrxRs40LkDTexM5v4JxLgxSiZirTruAPlx0F8FyhOY0cE/NyJ+CDagxqCtIRiV8n0zxZgK4WqKrXmDJHflAem7KxjWCa54VwyYPaVq1/khITZZAq6xmS3+NLRq0iG5Q9ilb0BW0BRZylmmI22upsb9jNyeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=1jhjCkcN; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71e6eb6494eso13043327b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807638; x=1756412438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oBxRTWup/TVL/uRRt8pc1fJ6+8UUSSl4M2C9tH87x7c=;
        b=1jhjCkcNyZd+lXH3WLOJrBYw3vZP47SLSevdEHGLYQjIdFGV4Qi0qRI9Y/WYLD11oa
         JgZxX/mY3kv4EYpk60j0RVgQOe4zJqcf0rfRGtnszDuN2RZhWFqetPwDdarrBazTSd7U
         UeN8/gxDB1HrhqWdjvhEB6Ly3WtdYL6fyUAWnFHbtGsfrsrrrTQhEX6VIHGhXwPfHeKc
         +zFRjLDkosNJHMCS2RYxZRITFGh+ytIKvY1g/XNwormPv3cdRExzP1Nq1nth8afLeQlN
         VmbkbaC/JqitXA63ANO2wMvXKMjuoYMfI07iJ7b5JP5OUSpBm4lTkpN+O5QK28JFhlM7
         ZgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807638; x=1756412438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBxRTWup/TVL/uRRt8pc1fJ6+8UUSSl4M2C9tH87x7c=;
        b=UsA2oeIEDcU3d5lf7g2v0PG03dSRdYL42KbTIk28GqKu+G8uMmg4FtYXix/5XryElk
         YTpmVNyULZyKeCkE4SPFFRuKnk/UVqXGG1dQEh4pzIqU8rdwGWXVKFxPrlsj3XpF+vQj
         8uzZZ6s8/sD/mSAQz0TB7m76utKN5LfPLuQBN7A/DqXH6G+YQTSox7gnqmsjN8QxO5vf
         qFEWp4bCCWxbr88wylETFJAwAW0r40le/BjCfb8mdQ/v5zjdHa12D5a5ybmPilW+24IW
         NDvSrkRAuEOKJlMSXJ48HiDtP29gmgkw8MjcWkV+VIAPsUCfBXRdxpmk9eI9oUoLslsH
         UsBg==
X-Gm-Message-State: AOJu0Yx1KzDI4ZuRCH+OCxpI9HR06cRVjBwl4jiYeEr58a0ntsVZsM+z
	AdjFumA3F2RcvYXjF4XBhvDXk/Pv6G4TLgMvH4EeT3a1v4PpNaDnhfQabbYlN8uxnujA8i2tq2I
	vnwOiGq5wTA==
X-Gm-Gg: ASbGncsWeCefhLZq8npbtobyPDA4h6h5UId2b6+EEVXjt1hOyQGYq8CkJfV0LdaP31y
	yLWjf5H+I8pIksuNL0iI5C/RgYEPaLkiFTDt+UW6At6nIIVEWOvhNqPWlNh1EE3e7RKU3tenb/V
	5A2HwOES6cNlJQok3hrMRawnEq3B2eiYgEIN4IMaZKxCDwFUec40rhkj47h4RbNbuyVNatgN0c0
	q5kjZk9G5f/u30vG8hVEL6O2e5RiVphyIwvmCQgocSLxvn64z1Iw3UTT3IMz+C8rJDGT9QCsVkW
	thPZXZDvon0sBf6XSy/solWIZWC64G5H7yLWHuzmaxxvEq9hSA3tS0uopPMxH5wkEfejnmneFjU
	MD6KNGv+HQXC4rwZ372+jqdvGjxUgPL8vec7unk4JW6dbe7LSHj6DiiAHyDs=
X-Google-Smtp-Source: AGHT+IFkaz2mWgCXtAS+KU0cGwdZosmAbjYXZp1O5qAihGpaj2tJsyf3eBiuyNcl5KJcSQ+mnbVRNA==
X-Received: by 2002:a05:690c:6e93:b0:71c:1de5:5da8 with SMTP id 00721157ae682-71fdc40d339mr6942157b3.36.1755807637738;
        Thu, 21 Aug 2025 13:20:37 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fc39b7081sm10222007b3.48.2025.08.21.13.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:36 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 15/50] fs: delete the inode from the LRU list on lookup
Date: Thu, 21 Aug 2025 16:18:26 -0400
Message-ID: <d595f459d9574e980628eb43f617cbf4fd1a9137.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we move to holding a full reference on the inode when it is on an
LRU list we need to have a mechanism to re-run the LRU add logic. The
use case for this is btrfs's snapshot delete, we will lookup all the
inodes and try to drop them, but if they're on the LRU we will not call
->drop_inode() because their refcount will be elevated, so we won't know
that we need to drop the inode.

Fix this by simply removing the inode from it's respective LRU list when
we grab a reference to it in a way that we have active users.  This will
ensure that the logic to add the inode to the LRU or drop the inode will
be run on the final iput from the user.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index adcba0a4d776..72981b890ec6 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1146,6 +1146,7 @@ static struct inode *find_inode(struct super_block *sb,
 			return ERR_PTR(-ESTALE);
 		}
 		__iget(inode);
+		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
 		return inode;
@@ -1187,6 +1188,7 @@ static struct inode *find_inode_fast(struct super_block *sb,
 			return ERR_PTR(-ESTALE);
 		}
 		__iget(inode);
+		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
 		return inode;
@@ -1653,6 +1655,7 @@ struct inode *igrab(struct inode *inode)
 	spin_lock(&inode->i_lock);
 	if (!(inode->i_state & (I_FREEING|I_WILL_FREE))) {
 		__iget(inode);
+		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 	} else {
 		spin_unlock(&inode->i_lock);
-- 
2.49.0


