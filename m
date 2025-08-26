Return-Path: <linux-fsdevel+bounces-59243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 498BAB36E33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B558E367848
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BB335AAA9;
	Tue, 26 Aug 2025 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="kZyAqmex"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4092D3209
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222870; cv=none; b=bUmaQCShTlsSJGLLNJQfgzm98ukAOxAK2mrlV6c1fE5idrJc3j6a4MMXqzaTlTKOVzK5OgEebJUAy2E8HqjyS8iEMC6WewEXZEtLFyE7XSjF63N1GzatOHaa5EuS8ik1hNxzUaFuq/a0U1/yK75dcmtNw8oA0SSEX8Qf1msn6Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222870; c=relaxed/simple;
	bh=PneIhJNQkgVThEAsNHxm41aQCPMVns311gwXpZ3Sh8g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGMD3/3c59a3DeAFsOvizNRFR5YfS7KLlyGfHAElL36iREj+AoJvQAq1xZwRD9IQ7wrCVwnkFpFhFzd3SuLwQVNin/2Kd2m3ZyCtJOkl5d2Y1lIpaLv0JOvThxtO4Oy3aygv5Rql5e/GCcX9WNJwenMoBgyA3ORD0mJWTbXUIiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=kZyAqmex; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e96c77b8dc1so1614579276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222863; x=1756827663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HD2qcaH/sr5LIXFLqeTARJ6AgNvAdAMXICDQLGRWnH4=;
        b=kZyAqmex/cesg6aAtrS67EW10x7YCxR5jJlgBDqwL2F0rktufaCU8DGALs8yUl/MI9
         J9lDkatWm13yBDt/sJScvpwuW/HKNpzrTpOXnnDzydajWsT+MZZUnB1XqOOfIAoDFQgt
         MH5nAgyxSmEcEXO29puZMz8zaPURZnUh4Lc7nXcP2n6UFYhRa5fOTx2xNJ/8Zg7i1cmO
         OHfBUbOuYVWJsFHGnU87Izcco6sC5n0qetnC0DuNH+M1d0QXLLlRcrcNpyJlqwBwGcrJ
         VjC/UyA4pjPy6/83KkdVe5Am14/6h7GAhXOudB+8adNl5tmGtv+nl7K34xR8LEZt/+XF
         BrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222863; x=1756827663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HD2qcaH/sr5LIXFLqeTARJ6AgNvAdAMXICDQLGRWnH4=;
        b=aOYcXpgseuBkro5ozAuWRWR8mkGBusBXSZvEqrBYUyNJjzX1dKPWxgpqwex/H5sBl7
         HRzQf1zl1Y/xkcMYkmfklKe7URglOX1i+esI53c2PQV/8fFn8HnrB/47avSuo2B0zrh4
         fTV7bOxoOFSZHK3QgMW01eSlED/3sqALdpyViFLGR4r2pQ6Cn5Tgetx0KEHoDBf0wnYP
         g1V0n2mYuJul3D0QQ9yz+1uJ2h88rCbwTWAqfJxg/tVDTNg6OrKBbUQu40a/ZewJlhBK
         sqDrRJDeR5g5XfaAeoMptQ+I4+QuV+TjKktsFhqJvVaRq3uVNt3YYi7sv3/gYMWYXsKS
         F+vg==
X-Gm-Message-State: AOJu0Yx9k9zfor39Muz6InaHIS4mOx8AfGDcRjoz4JOH6tQ7chE8Eyvq
	KGDQ31AS1BmGSV/w+I4lfSB0PIo14SFeeSYzObi6XutUdYeoDV59Y3ReF1oobaqQ7AdyQyb9isN
	npvtV
X-Gm-Gg: ASbGncu/gJCEUB/8Up6syV5XGe8/xHsjS5nDtbEIoxsn1lr3Vn8KhIuB2BKbc0sLbwT
	T/3ii3TPXbxg+mzIaeEiXizD/JbdHL4QEWe5pJ104m/KZxfQZ0+nWwbei6dYveN0xRcWT0SrolF
	xzxObQeoNNQJrbYEpf0zCNAgkodMHpwIJDEjWSrvi4ibYlSTWLN2bRcDVTlEsB/nyz7H+Hhni7T
	rDBOJR0sb1tMkD0I344EeCa40bqicDWAnaM+ktxx77StzaDyBF5fuauncSyNET3gQKgJw1WO+HH
	rNUjnxHz/TJz5doNpoml3M4V80IGX4ECq/xn29yv1eOxF4msuvVZg8DElR2WOLg4uNjNSrvDQ29
	qaZyxvO0chhz0ZXJc2rDlwHRzCC7qOU0tNaZPkMQQbILG+cs6sBGbRcsUB9w=
X-Google-Smtp-Source: AGHT+IFOwyxSw1QzDSHocgttZXA5ZJZK9OYg63GGlqCgEipVYEviCk6vMqE7SYxZSIRJlAFL4ZG7+Q==
X-Received: by 2002:a05:6902:100d:b0:e95:2c21:2b23 with SMTP id 3f1490d57ef6-e952c212e8dmr13585755276.19.1756222863102;
        Tue, 26 Aug 2025 08:41:03 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96e5530a72sm368624276.2.2025.08.26.08.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:02 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 10/54] fs: hold an i_obj_count reference while on the LRU list
Date: Tue, 26 Aug 2025 11:39:10 -0400
Message-ID: <f4cf75a75d4100f0a7a9d9a411fd28869dd41595.1756222465.git.josef@toxicpanda.com>
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

While on the LRU list we need to make sure the object itself does not
disappear, so hold an i_obj_count reference.

This is a little wonky currently as we're dropping the reference before
we call evict(), because currently we drop the last reference right
before we free the inode.  This will be fixed in a future patch when the
freeing of the inode is moved under the control of the i_obj_count
reference.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 0c063227d355..0ca0a1725b3c 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -542,10 +542,12 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 	if (!mapping_shrinkable(&inode->i_data))
 		return;
 
-	if (list_lru_add_obj(&inode->i_sb->s_inode_lru, &inode->i_lru))
+	if (list_lru_add_obj(&inode->i_sb->s_inode_lru, &inode->i_lru)) {
+		iobj_get(inode);
 		this_cpu_inc(nr_unused);
-	else if (rotate)
+	} else if (rotate) {
 		inode->i_state |= I_REFERENCED;
+	}
 }
 
 struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
@@ -571,8 +573,10 @@ void inode_add_lru(struct inode *inode)
 
 static void inode_lru_list_del(struct inode *inode)
 {
-	if (list_lru_del_obj(&inode->i_sb->s_inode_lru, &inode->i_lru))
+	if (list_lru_del_obj(&inode->i_sb->s_inode_lru, &inode->i_lru)) {
+		iobj_put(inode);
 		this_cpu_dec(nr_unused);
+	}
 }
 
 static void inode_pin_lru_isolating(struct inode *inode)
@@ -861,6 +865,15 @@ static void dispose_list(struct list_head *head)
 		inode = list_first_entry(head, struct inode, i_lru);
 		list_del_init(&inode->i_lru);
 
+		/*
+		 * This is going right here for now only because we are
+		 * currently not using the i_obj_count reference for anything,
+		 * and it needs to hit 0 when we call evict().
+		 *
+		 * This will be moved when we change the lifetime rules in a
+		 * future patch.
+		 */
+		iobj_put(inode);
 		evict(inode);
 		cond_resched();
 	}
@@ -897,6 +910,7 @@ void evict_inodes(struct super_block *sb)
 		}
 
 		inode->i_state |= I_FREEING;
+		iobj_get(inode);
 		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 		list_add(&inode->i_lru, &dispose);
-- 
2.49.0


