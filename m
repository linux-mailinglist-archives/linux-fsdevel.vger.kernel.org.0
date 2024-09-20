Return-Path: <linux-fsdevel+bounces-29745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8258997D557
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 14:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B381C20DDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 12:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA42E14E2E8;
	Fri, 20 Sep 2024 12:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bj2OLf5R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EB64D8BC;
	Fri, 20 Sep 2024 12:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726835189; cv=none; b=a0hmTNiqtSlwtECP3U6naHtZDo+UV5xQXw8pxoDhTJogvVc8fWCaMP1yQn8enve4CrlImNwyzq3E2L85m3qMt4XbCXfb5rA2KVSHRaAXdexssEhAs1FiPCgqGEf7fAtf1ouIcdfM6gDjJ/MrCMNQe4YaZdxHeqQ4Tf+QMEAlw60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726835189; c=relaxed/simple;
	bh=mSNpVrGkUzG7bbkjRfuqgS+HiG0Plamfz+z/RqBSPBI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hoLj6KCWmnXgJWwzqFfbs2T0Yr2L4WyR39L9n1svqYwWlC/JjiaM7pzX3YYB4jfxtvPpLFeGt3t0HVMl/4gmi3XpPSdt7Nv8Z3rJu9xzlhUPv7nvgaiCvAQHld45wbghNFpOVAywHN4S8vtarrqU287E/8+QxgfL4VW4bfPbNho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bj2OLf5R; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-208cf673b8dso19856885ad.3;
        Fri, 20 Sep 2024 05:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726835186; x=1727439986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I2xeFOlTV6cuYMDLWWIw/VyeWKk2em0CeD8UdrtQixw=;
        b=bj2OLf5Rd4QY1sCo6ywMCy8tvxetRbvNLXT9bfI8KFgWJO0zh5vGAiEfmWaHAxAIXQ
         HFhvA+A/dByDwrhhO3WvDc15KU7LHA8fZDTUqJAoQmwk9YRL0UT31F80uzLJqUVGRZQT
         OeyDZjGlgCrmWMYmF8Cso4BjFcDAyOkZedje1hW1d2iPzo9L5uoC0CxNzcFn0qYZbUgs
         1owKz3DafXgJ+gDXjYVdv1zcTxJUjxNtsC/sx9IK/E4Tc0zDiazizu6g4mjIyc/Xu2Ho
         AMCdE7kKuCkWNv2t8YzGjWsc3Hag8/s1BpUgWHpLO260NsxDK+LOIdnSqA4fHC4NSWKp
         Se/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726835186; x=1727439986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I2xeFOlTV6cuYMDLWWIw/VyeWKk2em0CeD8UdrtQixw=;
        b=q8Mab+AICEM7sD5mR8iN8l4wHmUaTnjdCVNvc9uyaAaKjXXYuNFq1zaxIednUYSxbf
         BUquBhB2UYvKZcF8NJ+JQ3H1QsMWp2ng4mEhLdLpr0aN2teitksKYuwRVG0Qg5V6d6Gu
         tzxXEOitlS51EfacxNd6PoPROqFWK+dRFwzq/BQ/cyCCDddr0IKYl/LJGfB3Ifyexw0S
         MrxBZ5ESWyosURCx3aktt2nP83gWW7lekolbyKW+j0ejkrZAzfcUaT1xDpzNpWy5v6eo
         Iq6p5/q01ipWYqoGibAWPxyudQH3BK+3McFERJZGmtjYzw3B9D1pMWdCtpxb1PuXK4Qw
         NriQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwZvqXFs1eJQZlAAHLpHp8XGFlsa7nFkusvBCl0UlyPOW7Jb4550Z9S5G3zMyN616iHnMd8QAB@vger.kernel.org, AJvYcCXISOGtE7QEqF3uRYd51S8K7eOcGfVX+92zw4JEVZQlgV+zjPEMZoVJkVqIZF4mOiCCGEUrB5kBLag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcR2YvRLGtpO6MnBunXa+Fofe14zwo4wJ8FCWfwk/l1/kFkJkN
	cXlL7A3TukKcx+krpbIPxnc48rzbTcvh2xBRjB7u64L/LKR5dfJ6X3Ja6Q6Y
X-Google-Smtp-Source: AGHT+IEKdH8ny10oL9DmTVGDeKGZTje+hDEfdAp3cprhWsLt2tSOIhebk4gm/bNLhLZ0D/1stCPS4Q==
X-Received: by 2002:a17:902:ea12:b0:206:b618:1da8 with SMTP id d9443c01a7336-208d97f0cb5mr35823685ad.17.1726835186385;
        Fri, 20 Sep 2024 05:26:26 -0700 (PDT)
Received: from localhost ([38.207.141.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945da880sm94410925ad.9.2024.09.20.05.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 05:26:25 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: chandan.babu@oracle.com,
	djwong@kernel.org,
	stable@vger.kernel.org,
	Julian Sun <sunjunchao2870@gmail.com>,
	syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com,
	Dave Chinner <david@fromorbit.com>
Subject: [PATCH 1/3] xfs: Do not unshare ranges beyond EOF
Date: Fri, 20 Sep 2024 20:26:21 +0800
Message-Id: <20240920122621.215397-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attempting to unshare extents beyond EOF will trigger
the need zeroing case, which in turn triggers a warning.
Therefore, let's skip the unshare process if extents are
beyond EOF.

Reported-and-tested-by: syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=296b1c84b9cbf306e5a0
Fixes: 32a38a499104 ("iomap: use write_begin to read pages to unshare")
Inspired-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 fs/xfs/xfs_reflink.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 6fde6ec8092f..65509ff6aba0 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2016 Oracle.  All Rights Reserved.
  * Author: Darrick J. Wong <darrick.wong@oracle.com>
  */
+#include "linux/fs.h"
 #include "xfs.h"
 #include "xfs_fs.h"
 #include "xfs_shared.h"
@@ -1669,6 +1670,9 @@ xfs_reflink_unshare(
 
 	if (!xfs_is_reflink_inode(ip))
 		return 0;
+	/* don't try to unshare any ranges beyond EOF. */
+	if (offset + len > i_size_read(inode))
+		len = i_size_read(inode) - offset;
 
 	trace_xfs_reflink_unshare(ip, offset, len);
 
-- 
2.39.2


