Return-Path: <linux-fsdevel+bounces-59276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E47B36EBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D058046488F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C38135082E;
	Tue, 26 Aug 2025 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="G5TsgGo6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A2B37058C
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222912; cv=none; b=sAs2r1i0mU42IuUOqpKpqcpagAwCLEtCQ8SbM5GzDFzE1gYW6nFYb6I+iypejO5OmBip44N3GUwmlYvVV+ggqV3wQ9SOfZqn7G44KVmx6z2Io1a2vbgOOA/WG4luzWEJ2t7dxZoFUReXmZGfBa328bbqItg43o3SooKGt/7r0CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222912; c=relaxed/simple;
	bh=pnLjXbUfoHcXn2jpRxuylRj/MRBDvUFW2eVaWnK6gz8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbOA0m4K6beENpNsRZFViKF6CoCtqsHrlgl/xUU+00xisJTYyrwWQAFTfZ+1Ycpn/NFsVplKo7EisMKZZJ9F3NjzyHqyW3SBgBIEcpOBt6okNXCU7hC55xgufrSoJEZTjtfQWaEc3k0XadIA94hhjhZgHjGgFicm+6iZpkkgrRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=G5TsgGo6; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e931cddb0e2so4256110276.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222910; x=1756827710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDdJEhTVcL0Kwh3vTWaXkqiJl0I0MAIx+6FUQgVhMXE=;
        b=G5TsgGo6pUZBOHWfrbWWdQgArtIBymxnTtqbMZBetT8TRDQ1+17pQm35doXSPuEFHm
         UmTjUwYiGwia83VQC4a8hq86C8GHfgTRWqYSR9f+6FQvyyAU5QSidqqo8EnCB9wqOMpH
         gXb+FePWa2+G8x5qvPR2/HaMil+FeA9afKJFS0C6rsl3J22fAZJ8AWNacGI0uBEyx+dQ
         Qve4Dd8JnEQisVdbzkV9oPV1Kw0/s1setJd6kLwTZc8kEgLy0sQRkn2INGolW7K6rRlB
         Y+IeYBiNEN/+7YI/YEdS9ZvGrRsH/L1HlYIXWjSOfuNCY4/euiY8UrsHB5xtv1T/Z+cI
         fT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222910; x=1756827710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDdJEhTVcL0Kwh3vTWaXkqiJl0I0MAIx+6FUQgVhMXE=;
        b=r8LNPkOwTTNswqk/fXuBHNTDBTSgLpcx+7RGVU3vF6MGyUlb+FeHglDGUgnVLmiDg9
         TkvNy90qp4XJLKNXDUTVhq0qCLUvQGvF6qcbZ6mb9MmNvOBd12IfzGhkVe6IOl1pTfiI
         bifJcaP9iDcMkKXwmmqi6O5JlGHhL9l4IrU0NmHxFF13R4c5XD+6vH6+tTHWKmXrM3bO
         8SQhWH+gnrnvIcE7T0+LkNRgKd6rqfUcuV2So/0eBxOU6i4TcGi5N1npNTMqx0pACqaZ
         v1a8MvlpYdggv5Y35L3eA/Sc0KUUH26y9T28OYm3uQ8QatWGu0hb5LK1ZhFX7/r3PecU
         /7qA==
X-Gm-Message-State: AOJu0YwHcmmCrOn7Vtl4O36XoZhTzc6QPj2Eww0+SHXv5N9+LQ7gxMRV
	M2cdFuM+zXur/OK36J39J6PPsfVVQNQ3EeXYuqpuiGiNOyZ0XxcrbvUIlLUJ8H4ppAHM8+Abe9j
	Yuale
X-Gm-Gg: ASbGncvzH+dSCm0tCzdWRLUk0JMYeL9yZ/P7u+0y+vQbJ1YqSc3ohUwK9rXlKOgxEmE
	MgYdhbxvYWddzQvyYXhHq+BhGpF0hkwj9zsiHWQOVQ0aeTVrZap70sbzZCuBJkmkDEj4A3fp/2V
	aDizTRBjqhZ3ygy7rDBIrS6+wRVcjv/ri5J9G2rM23V5r0SZ39PY30wLhs/RqtSyoZV/jEEeOhK
	I9KakEzjOKKuyxCzokT1pNOd5EHouEww/wq3tGx+pz7llEYb6UWLJlivywlYhlQ9TKAD8iRGCm/
	nRFaM7Usy9EQZ1E3DzUaSZ/hos7pCtwyuHWY7vRkStlW+h505FPcrpLXa9GPhUnRr9vnk+SbK08
	gJhIP0TANCzVAzCFaoYbhG3YVXWFqBLwGn1fmdNmgPTyhaZiYW5hCKubXFP3j9f2wHpNlZg==
X-Google-Smtp-Source: AGHT+IEbtyzB0KkEDrw8Xs/L8Hc6W7XjqAvgA/hveL8BAb3PYuONcNj0ZepACSrEkBrgiNlNwynZ1A==
X-Received: by 2002:a05:6902:20c1:b0:e96:c754:b4e0 with SMTP id 3f1490d57ef6-e96c754b758mr7398145276.27.1756222910291;
        Tue, 26 Aug 2025 08:41:50 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e952c3674f3sm3320374276.29.2025.08.26.08.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:49 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 42/54] landlock: remove I_FREEING|I_WILL_FREE check
Date: Tue, 26 Aug 2025 11:39:42 -0400
Message-ID: <1bb97474d9b4b081371019c29708b9e4e3b3f601.1756222465.git.josef@toxicpanda.com>
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

We have the reference count that we can use to see if the inode is
alive.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/landlock/fs.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 0bade2c5aa1d..fc7e577b56e1 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1280,23 +1280,8 @@ static void hook_sb_delete(struct super_block *const sb)
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		struct landlock_object *object;
 
-		/* Only handles referenced inodes. */
-		if (!icount_read(inode))
-			continue;
-
-		/*
-		 * Protects against concurrent modification of inode (e.g.
-		 * from get_inode_object()).
-		 */
 		spin_lock(&inode->i_lock);
-		/*
-		 * Checks I_FREEING and I_WILL_FREE  to protect against a race
-		 * condition when release_inode() just called iput(), which
-		 * could lead to a NULL dereference of inode->security or a
-		 * second call to iput() for the same Landlock object.  Also
-		 * checks I_NEW because such inode cannot be tied to an object.
-		 */
-		if (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) {
+		if (inode->i_state & I_NEW) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
@@ -1308,10 +1293,11 @@ static void hook_sb_delete(struct super_block *const sb)
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		/* Keeps a reference to this inode until the next loop walk. */
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
 
+		if (!igrab(inode))
+			continue;
+
 		/*
 		 * If there is no concurrent release_inode() ongoing, then we
 		 * are in charge of calling iput() on this inode, otherwise we
-- 
2.49.0


