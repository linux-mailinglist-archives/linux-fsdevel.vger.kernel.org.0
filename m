Return-Path: <linux-fsdevel+bounces-26569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B904095A823
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5A81F22C3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 23:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6238417C7C6;
	Wed, 21 Aug 2024 23:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkzbHZxq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620CD170A1A
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 23:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724282717; cv=none; b=jF/bxfsPiEFWX5ppPki8BkFmKNZ9TxG5nJUvHp6J31tbyUrAlkER1KJh7Bz4fjkXtLVvyFqiIiOVThb9OmMkCuP5J6TVnnP0QdfsNYvGEdYUQWdKiEn5uiM+uMGQL8No8/Bu/Qgo5o8wlFwwt7nfgq34CGu8HdcDa9lkLRvW9Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724282717; c=relaxed/simple;
	bh=s2ckAHicpl/to3zXFLNJePIx3hN+gTnQ2xFFhBBYmXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBj7DuzxOpDDktFcf7SfEixCAZITceUyV7/rkvJIfVfDfqiMriaZ8jcZP9dKQLUhsseHZHqHnHOkqkdIQkU1g2tjLLxuSwVtliQFzj5M/Z9Oh3zMFAYxyhdTEsxcK/2jhsbqMQblvqDIGs6duPPycBjFhH0SBe4AOWil+ID/xR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkzbHZxq; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-690ad83d4d7so2526837b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 16:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724282715; x=1724887515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkDoaQxIl0z3f0TI7q06kib98oK++nBTzRFtBSj71EI=;
        b=YkzbHZxqO3dBOKZsZlqXLmpTREr0b1ZSORE6OdwnY8jROoLps46gADBWGdibcutUYF
         CwkM3zJIChnbS7ezf4m5XhuLw8WHO/E30AZMIpw6l1Hr6S3MuKaoRTTZh9LrI55fZAA4
         Ou4mJoZDfIDg4QgKfqzHcoixYB+h3HMs2d2R9r7lV+W5/AsJX+oKDxTEUERqN6nUtSof
         yfZ+O0QdLRLomoXcJY1rMF13vgYnGz2N2XjloNSdqkfZK+SolzGRbi2WvmVw2ZrNADgJ
         r/lxGyyockQbm5yND7qX+6tTTEQ0qzgfzqQEBA2A6VYzQ707XVb1zUVmBy34HIGvo1N1
         w9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724282715; x=1724887515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkDoaQxIl0z3f0TI7q06kib98oK++nBTzRFtBSj71EI=;
        b=Y7G8zW6ERYmc9+T7r3iltEDiM3X+2TWX5wHNUwEsijFABpbcWcbJfdV4zpWnlFgF8F
         X7c9BRgIn6v4OTf4CUIttl7dX81VZ85ga4SluL/gsocjeARqlEl822iNzcgVdpTMcpeD
         wlS4WD1klWzt5ivazVDVej4Mu/O6dPaSgbs9eJwDf9FLmjcnd5vpL/vHoYg7f2n1idmM
         zl41367g5tyepPFVJexI2kq4wnmaprqW3Ho/863cXc5+mX+4Iu5jVk6VlFXehPotXP3c
         qABtZZMjatFR7O9SKM2XKzvjM5m0SwVfhOMe3RbpVikmWinMiyCw6Caepjg69SzAdQ+s
         /Fjw==
X-Forwarded-Encrypted: i=1; AJvYcCXxsn5bkNM8SUvjk5dCxKmIuPcho46xk2Upod93FlamH9M35d6oABklrYEYrMdGMAY92j+FL03ScqsiJcY4@vger.kernel.org
X-Gm-Message-State: AOJu0YwTpVV90c2vF4zglNydi9rLqmiXigRC1XQ8AEsPjwS9N8MDIDv4
	GlfQ8F21iJz2Jhc0jmTxHrLs2oOMpk56BgdHz5dq7PPOyc0REEin
X-Google-Smtp-Source: AGHT+IFzOCRaarVq2sP/i94d4/Oiygq4RGt7eXVHDo5nlwXvtImjoZu8b/eWPOTXqpspsedwwuvXSQ==
X-Received: by 2002:a05:690c:e:b0:643:92a8:ba00 with SMTP id 00721157ae682-6c3cbe8adf0mr1241187b3.0.1724282715301;
        Wed, 21 Aug 2024 16:25:15 -0700 (PDT)
Received: from localhost (fwdproxy-nha-004.fbsv.net. [2a03:2880:25ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c399cb569esm396877b3.14.2024.08.21.16.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 16:25:15 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v2 4/9] fuse: clean up error handling in fuse_writepages()
Date: Wed, 21 Aug 2024 16:22:36 -0700
Message-ID: <20240821232241.3573997-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240821232241.3573997-1-joannelkoong@gmail.com>
References: <20240821232241.3573997-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up the error handling paths in fuse_writepages().
No functional changes added.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1ae58f93884e..8a9b6e8dbd1b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2352,9 +2352,8 @@ static int fuse_writepages(struct address_space *mapping,
 	struct fuse_fill_wb_data data;
 	int err;
 
-	err = -EIO;
 	if (fuse_is_bad(inode))
-		goto out;
+		return -EIO;
 
 	if (wbc->sync_mode == WB_SYNC_NONE &&
 	    fc->num_background >= fc->congestion_threshold)
@@ -2364,12 +2363,11 @@ static int fuse_writepages(struct address_space *mapping,
 	data.wpa = NULL;
 	data.ff = NULL;
 
-	err = -ENOMEM;
 	data.orig_pages = kcalloc(fc->max_pages,
 				  sizeof(struct page *),
 				  GFP_NOFS);
 	if (!data.orig_pages)
-		goto out;
+		return -ENOMEM;
 
 	err = write_cache_pages(mapping, wbc, fuse_writepages_fill, &data);
 	if (data.wpa) {
@@ -2380,7 +2378,6 @@ static int fuse_writepages(struct address_space *mapping,
 		fuse_file_put(data.ff, false);
 
 	kfree(data.orig_pages);
-out:
 	return err;
 }
 
-- 
2.43.5


