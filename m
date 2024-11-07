Return-Path: <linux-fsdevel+bounces-33984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 464539C12CC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 00:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77CDC1C22745
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 23:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1AE1F6662;
	Thu,  7 Nov 2024 23:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGqXlwi0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3961F4273
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 23:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731023794; cv=none; b=AreVpgO+K4Qe6mA+PVGxmisJpjM1KHVxvWQoD3zIcbVmzQzUXqFYacQxlcnK0ARWWkouIgjKvD8FkCdJzCuqwyrbI4OIZErJmbMFFKFRLJXs/VmlU4CZzijfwYA532gFRHG7esEldHCvBYYlvpxbYwXWjOfOlSJpe3un21pM74k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731023794; c=relaxed/simple;
	bh=Vyk5LdXUPCJ5WnYil+TLoGEb7TvxgkoZNZe/xBB3dWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KiUIhRb6YpSrDFAtmswhBYK+Pygt9uf/4NLiyGnx6sv4IVcMfdIuhnxqODUykE7Zy0DqRApga5CSYEYqupCg0PEBktuzBRjHfvJYAWP8Shhlf0ThOWTrNeiPPvsgrdn3wUBe5srRLSbauhsk86gr3kfmt1ukKtMi3cmBKk/nNU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGqXlwi0; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e5a5a59094so14807757b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2024 15:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731023792; x=1731628592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnCvLTbTmq6xS6wpFSTKmY1gePcY6efLtCHlkRWy6SY=;
        b=JGqXlwi0O4zl/F1DL3QvH0UHmisz/oWFxDOkNRrPTBLuvIhSG9khRzUVnmnd4cKYVL
         g2AlGixFvSpjzpz6F4xG4SCCYam2Wv9lH1yKylOmljNdjvzGTPdrA+3BtnI/0bHg8YZ0
         DFCqgk8Wh+7rFwqZCGtpiGAmQx0DILrIIDDWA7ugpf4I86XJGlqlGW8lAw01Ay/uNfmQ
         JxQed3y2Pq0KflR7d93eZxWxv+oPEevtTYstxxGeXy1Q+tHsqGZEecgk9rgj2ILEUyoZ
         cYpKumDqSQjv2hUX+U+fh1kHnDyJkwLlolw1QJfaad3m23K2nEorNSCahu6/IAuEDjX1
         tyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731023792; x=1731628592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnCvLTbTmq6xS6wpFSTKmY1gePcY6efLtCHlkRWy6SY=;
        b=GbycBNCYc7vgLF8g3FzMSKUH/2hMZ3JOUOJ7/yf/7CWBQ1QiTFMQzduJ8DzZ3M4CZl
         nHVZFRqjg/8HXtbG6uwGzJJEZYrfGFuJxmAW7jLK9wnItfLcXzcDaUPEdd5hKfSWJ9aC
         uMdXzCF3UWZVhTFHMbI9Pbvh/9Xm5zG9q8XMbfKy2lA6Jf+4yNsDjhIHvQE9+PJBAazi
         rsrGl7YlWAoufSjwwOvrwXdSHVSP3Dr/qX+1aMn7OOkTKKtTy+XmLAYDjYCPdDkXeac6
         Xu/RmGdykcrMLAxUrPcAGakFfEJ9FolbYXxcO2SmTa2Yc9wHEEt2ztf78H196vVF39LC
         c7Fw==
X-Forwarded-Encrypted: i=1; AJvYcCU2VXtIfNT6Rg3bUAXYpGenUHJvaFv3fk6Ka/cVPRJgEOJ0gm7LwuGO3bKhsc8inCXya0Wfm/G/AAwbRig1@vger.kernel.org
X-Gm-Message-State: AOJu0YwGn/+J+wxsgkFB1PA+KE0S5c4uuNMraOtF0JeWw0y5v6L71ga9
	a5033aQo8i/JoBXHq/nhoiksmOHOh9qzPVV1IoWrBm8J6dkdojdt
X-Google-Smtp-Source: AGHT+IGJ7XIGDH3gjwhwJwxg42yQL0oNlE1U9fJsXrX1XmblFbwOlYN4FwmU8RXv5pchaNWEiPA4dQ==
X-Received: by 2002:a05:690c:6e03:b0:6e6:248:3496 with SMTP id 00721157ae682-6eaddd91bf5mr13056217b3.11.1731023792342;
        Thu, 07 Nov 2024 15:56:32 -0800 (PST)
Received: from localhost (fwdproxy-nha-011.fbsv.net. [2a03:2880:25ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eace8ee1cbsm4999917b3.29.2024.11.07.15.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 15:56:32 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	linux-mm@kvack.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v4 3/6] fs/writeback: in wait_sb_inodes(), skip wait for AS_WRITEBACK_MAY_BLOCK mappings
Date: Thu,  7 Nov 2024 15:56:11 -0800
Message-ID: <20241107235614.3637221-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107235614.3637221-1-joannelkoong@gmail.com>
References: <20241107235614.3637221-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For filesystems with the AS_WRITEBACK_MAY_BLOCK flag set, writeback
operations may block or take an indeterminate time to complete. For
example, writing data back to disk in FUSE filesystems depends on the
userspace server successfully completing writeback.

In this commit, wait_sb_inodes() skips waiting on writeback if the
inode's mapping has AS_WRITEBACK_MAY_BLOCK set, else sync(2) may take an
indeterminate amount of time to complete.

If the caller wishes to ensure the data for a mapping with the
AS_WRITEBACK_MAY_BLOCK flag set has actually been written back to disk,
they should use fsync(2)/fdatasync(2) instead.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fs-writeback.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index d8bec3c1bb1f..c80c45972162 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2659,6 +2659,9 @@ static void wait_sb_inodes(struct super_block *sb)
 		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
 			continue;
 
+		if (mapping_writeback_may_block(mapping))
+			continue;
+
 		spin_unlock_irq(&sb->s_inode_wblist_lock);
 
 		spin_lock(&inode->i_lock);
-- 
2.43.5


