Return-Path: <linux-fsdevel+bounces-59268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F99B36E9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF8B46179F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C8636C060;
	Tue, 26 Aug 2025 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="xpekYlcu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09621369961
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222901; cv=none; b=NLrV2IsdgT/aelBCXKhbbsPbU7RhWX9m68Yqf56YFQVwXUFCJikBPxW+ThskokE34yiceMtW4hh2WL0tGFwVu9SzIEjDWtaREYZbu2bhHQ78tW+9scigChaQKdU5pVLnty19HpK+41/AKkcyme04b9O9T6+YJScEM64Vhu0dcA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222901; c=relaxed/simple;
	bh=sLtWG4tBwYzFayC8el4qA8KAx3MpBYf6WBWbOygRAvQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYpcZio8662jA/FD4zMZsP1BloZY30qiwvf8vT7R/OSML69sVBgXKq3uISZqIZ+Hz65ASmWPrsm7Oxj7+TLAaTnunleN8FfVBNQenGY9fDfCGilPLyseXBsEGOujHxUj5oeTjTpbHTcK0domlP6LcD96nzRIq4EOGS/3zNGanZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=xpekYlcu; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d60110772so49946647b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222898; x=1756827698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1kMEWwVY5zqmZ8rO1Ng8kME7oWtjO/CBjlFvprNCTeU=;
        b=xpekYlcupzksEPwfTAr3kLtByk1OmAAg2qRR+9hPoBCjq48w6teVYU1+bGy1ngIHtQ
         pS3JCgiGYSNooy4fC38/ecutCCbMOjpqwKwNThPu7bWur6lunTlXmpiEyt/uumFPVL1M
         DM7+VOFKcPnwWDbL+JULui3OtXjDt3U/N+cOT2wfto4W0H1URPi4Ep67HkSNMBZgq+32
         Uq1rcHzlnQm7PIXxj46rtjEJK+E6+YqyHvDLNb5siK1Vw4WEtR4N+2uhwmTV8eE7/RHm
         IZDKT4xAG+9PCuWHQtwChrxqbS5QI4hNoGd5E37ZyaHgnG6VBsRZiQQhJc1wxlLg2k5b
         BLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222898; x=1756827698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kMEWwVY5zqmZ8rO1Ng8kME7oWtjO/CBjlFvprNCTeU=;
        b=UB1V7Z6izZ7bO+9Q2a122KafQKPRr+HeMNZxUltg1+MP8vMQz3daEBEou5+pAd1vTD
         v2WI/sXFQYKAvjihyA2IraDmvXeqPCmXMMqbWMIk5jIggsJp8bIYpNq8qYhZt07/TDva
         yNFc2O/J4hj0ycedY/jCKMV91qJBdWEc7HzSHmiBcn29o6Mk105dvGLwLn/UxoEArffr
         10baovLAXxzDhkK34EEzICQ7/STQHiKKPqMvZ1rviwMPXt8ncA1LJ8Aj9r9AxMRhuK5h
         qXT9wfeziGOFJ8MLIkaiohmj7BgdD/O1ZkbdXkcV5+kCC+/WvMHlKbiF8mhSCK8/0z0s
         w3TA==
X-Gm-Message-State: AOJu0Yw8h46NtMecBH/E3Ie0giku0uZoNI3w1+wPIcU79Jk6zNfxnAkU
	xUau/t2pPXRPnkSwxBMZ2TjMcs/mN/sVGnI/XCD/+ZxYxu6Z40usDiTO+oHOeTUlrMTfDGpESxr
	C5PH6
X-Gm-Gg: ASbGncthu0WymT8svZhmGH47K3cvPDxSg0ML9igj0t9DkSALSUCqAwm9rQeGeyrFZar
	Mj1SplNUgvBXEpkpZZ4MAxpxFdrSZrqU93KFPCrii0SQhMfaK1uENDM/e7CWW+rjD3fWh7TMvIe
	GMwlb/4G0KSlY9bEVCRJp3TEYHxuMvYGdmpf+XRe3xagEqen/drp9tL3j5ewNObf/0/jfWi4yXf
	kNkHQlSjQOXwWT7gpiMSJZMPUCzsCi+9IFbcKtmiAFZS7xYduBssNWz8PeYuqyQTu43e9zz8LCO
	xN7XrtL4BCFw0H6izsWhO5sLMkNRk+t6zMrM3YKe/yYJdu5qqgx8SC7YTOE82h3Z8WtOmXUSqxK
	L/I2tyQ1iJgpEaJTkJs5eBZB0Q1gxQRe1mhJiAcIPZ8bQhsKUCEQTIQ9FTzjLJJ/SohX7Au3V0D
	9gyTtW
X-Google-Smtp-Source: AGHT+IEh6w4J98zHKB0KJJey1JZ+RYFPa+jSq6TTzIF+srA6iK+yY8jmdv8EqkOy5QUDc4KAmX6MNA==
X-Received: by 2002:a05:690c:968b:b0:71b:f56a:d116 with SMTP id 00721157ae682-71fdc2d2454mr170681447b3.2.1756222898334;
        Tue, 26 Aug 2025 08:41:38 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18821e5sm25327457b3.44.2025.08.26.08.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:37 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 34/54] fs: use igrab in drop_pagecache_sb
Date: Tue, 26 Aug 2025 11:39:34 -0400
Message-ID: <b46f72a94ae09aa801b3bc2a80d331ffe0648534.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just use igrab to see if the inode is valid instead of checking
I_FREEING|I_WILL_FREE.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/drop_caches.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 019a8b4eaaf9..852ccf8e84cb 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -23,18 +23,15 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-		/*
-		 * We must skip inodes in unusual state. We may also skip
-		 * inodes without pages but we deliberately won't in case
-		 * we need to reschedule to avoid softlockups.
-		 */
-		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
+		if ((inode->i_state & I_NEW) ||
 		    (mapping_empty(inode->i_mapping) && !need_resched())) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode))
+			continue;
 		spin_unlock(&sb->s_inode_list_lock);
 
 		invalidate_mapping_pages(inode->i_mapping, 0, -1);
-- 
2.49.0


