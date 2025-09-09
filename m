Return-Path: <linux-fsdevel+bounces-60637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68833B4A77C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 11:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35925E09EE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 09:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB4428D839;
	Tue,  9 Sep 2025 09:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVcNZuCH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738562BEC22;
	Tue,  9 Sep 2025 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409267; cv=none; b=lNM1wG/xYhgXPSVdN2R9vjaRvGO/BCDWgMepdQ3U1meBgnbXB6w+9K/N8+nu+5B2Uy9UtM4DhxsHRwvw6wS+BrjMlmGIp2B0HgLE8Vg7beu6Qd3S/ixyBycVOPhYrn9+b1Qwuy2INOvN6nOicHnHDdTwtO9iteq7EQ0ctKLizMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409267; c=relaxed/simple;
	bh=yPAQgvf69HeHuHpAroxlVxtZBxPIMT9A8QM9ZG6Y9j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUu+cgggIAVR7XP2nhA+KnwiU9EZAkMX7skmhL/8eEnxyVUVCPB0c0p/woW+waEt7SE+/t2L9WIsEgLlBAzuJrxyRbiJLgkzh3trvacumVD6Z4c/AN/LfOYTt2OjTPCUCM1lJNk9T7Jdo7/TxBI9PlBFmwc9IIKq8QdWajoh9No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVcNZuCH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45de6490e74so17973055e9.2;
        Tue, 09 Sep 2025 02:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757409264; x=1758014064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPWaEeGmiR1jD0YeutpHA3nvEpV9+sv5w9Xmw28cyr4=;
        b=bVcNZuCHB6tBXVtsG0rnVrBGc0A+M27Wxya0rAYXNuNrVz0k6eUzWH4aKbGhsDWq1k
         Zhs/0KZnCwLu2txjifOB1RYRnHiVKP/MqYSCz1JjKV0F0mXTkAm3Kr2uUo2rTyYrEQsO
         rqW+b1pmRLAfRnsDAA0Tb4B/Q9RNwA4Beq//j6TsMfkWT7T441bSVYVJ8yL5bRdYAsqh
         IRbOWAyIT4ncKj5V22tpvvpxWzX04AknXDIY9nXymYrRZBHMrupz5gHSMNIDFcp1ei3h
         8dCEomCoV/C2aokZV4hOIKcErq5Wbbp7igXn85WQeR8yk/Rng6EDp2K0y7/B24ThJlwV
         tPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409264; x=1758014064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPWaEeGmiR1jD0YeutpHA3nvEpV9+sv5w9Xmw28cyr4=;
        b=QamnyWTkNx20XSzSqYnxMDQIQ0uIbkNXqOMQG9Ztzm6I0ps2XL9vk+nwdW1LxngRQw
         3oX5Gjfs8OjD95BuoCij7GCspTmgchVG6nRLAcjY35aP/fmbsmX6w9ZWcUlt1ejzLOJ6
         t428MsSeOCfU1F9jeTNE7HSCuYCOObK2v00LWuRz0AqmJpMZ108j7xY1Av+5+2KsUG0S
         ibZbddvDpS0HFEJf0PZAPkwmH5h5IuX5u9TmI7teFA6R4xcduxTnNeXhifYI/Y9ZfAGE
         I5LddHoQF7hN6fd6RUyPxif1qus3Xge8ICa50P5jQc0GUwnoGyKHG7ECN3xohE4wJI0c
         gkNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwCDz9aAE+awqYK990ov9dpbR+keWfpItSN3ZMHtgFxGe/72XqnAvV6VyJ6Lu1cASe4xuh21u7XMG6y2Hu@vger.kernel.org, AJvYcCV2okpg+j37Rpn2zMITXHi0IsDeafU69I6JdRTPpBXCgRBSkx1qCpXqKM5CT3ggX0CwiX2b2ZtgY3uh71+BTg==@vger.kernel.org, AJvYcCV9cNm1CBqKsp/aPBus8pTcSiE3b+Zuuh7yVUKgk1Sx5c4TbKkrUJO40waMz9DL4Rj2bCfCm9N4NOiTkw==@vger.kernel.org, AJvYcCW7C0FltQ7I9/Iw4VsDjZtj6IeyLArzbdUk5I27LJwKQzTQSanuEpzFFY2P0l1cNM0kywex/vIEXvMA@vger.kernel.org, AJvYcCWptDkXDi1lJ/jrsVduHhUINTXIrVVaeyECEAVcqAJPV3FahWXfKPfgAN8akxKJROA/cVA3W6oz/mVDdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgcyxPEATtLTw5swuMBdzFsMOGcOl6WDGkQB892EIelV36kcLW
	FE9V8ED+MOp2iwxTEVZ2+w37pOVF16LR5GbjztUkQiCzG5lSuOufGixP
X-Gm-Gg: ASbGncuz9fod2hyM4bvp84n2edf0GBRomeKsRimve4XItHErFmrdLnm+dnhNAmB0ho4
	Np8Hh/WcUOTrYMRROvi+N7s+F7+oJvDDkvcIlnpiajVdgpAoaTDTgOSmSx0PNkFZ+Yuzvym1V8v
	ahthECqq9ZOWuZaAEEsusT9LhuChr0zXEFF/IWO30k/V9W5hOefiV4QdIyy7pRKvXuITe/auWGv
	2MhwwTpoBpercbtJNH7r4dGMLBW1FBpuOpJ+BU7SdDVmbn8vViFDdAVh4pNlYQ7z1qOjqnG0ETw
	ghQ18dpUYh9V15NpreMqT4IsPNzbvKK0qTNv3e6vxgeHdUKc2uO77qSNyZSkqB5tP50A3Jx1cTG
	a2u8omTAasz4d3jrCVOYsagDNKvnRyN21VQzAsMnPYoK/vVA94rg=
X-Google-Smtp-Source: AGHT+IFJdhaaMaOuMypuGEFJh2pVDDxn5sp6WwusH/tMuWzKs+ug4owdxuI3aGQKmhUZs1+gw1gFJQ==
X-Received: by 2002:a05:6000:4027:b0:3e7:42e5:63dd with SMTP id ffacd0b85a97d-3e742e56a53mr8650428f8f.56.1757409263541;
        Tue, 09 Sep 2025 02:14:23 -0700 (PDT)
Received: from f.. (cst-prg-84-152.cust.vodafone.cz. [46.135.84.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521bff6esm1810784f8f.13.2025.09.09.02.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:14:23 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 08/10] ocfs2: retire ocfs2_drop_inode() and I_WILL_FREE usage
Date: Tue,  9 Sep 2025 11:13:42 +0200
Message-ID: <20250909091344.1299099-9-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909091344.1299099-1-mjguzik@gmail.com>
References: <20250909091344.1299099-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This postpones the writeout to ocfs2_evict_inode(), which I'm told is
fine (tm).

This is in preparation for I_WILL_FREE flag removal.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/ocfs2/inode.c       | 23 ++---------------------
 fs/ocfs2/inode.h       |  1 -
 fs/ocfs2/ocfs2_trace.h |  2 --
 fs/ocfs2/super.c       |  2 +-
 4 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 02312d4fbd7b..671c2303019b 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1287,6 +1287,8 @@ static void ocfs2_clear_inode(struct inode *inode)
 
 void ocfs2_evict_inode(struct inode *inode)
 {
+	write_inode_now(inode, 1);
+
 	if (!inode->i_nlink ||
 	    (OCFS2_I(inode)->ip_flags & OCFS2_INODE_MAYBE_ORPHANED)) {
 		ocfs2_delete_inode(inode);
@@ -1296,27 +1298,6 @@ void ocfs2_evict_inode(struct inode *inode)
 	ocfs2_clear_inode(inode);
 }
 
-/* Called under inode_lock, with no more references on the
- * struct inode, so it's safe here to check the flags field
- * and to manipulate i_nlink without any other locks. */
-int ocfs2_drop_inode(struct inode *inode)
-{
-	struct ocfs2_inode_info *oi = OCFS2_I(inode);
-
-	trace_ocfs2_drop_inode((unsigned long long)oi->ip_blkno,
-				inode->i_nlink, oi->ip_flags);
-
-	assert_spin_locked(&inode->i_lock);
-	inode_state_add(inode, I_WILL_FREE);
-	spin_unlock(&inode->i_lock);
-	write_inode_now(inode, 1);
-	spin_lock(&inode->i_lock);
-	WARN_ON(inode_state_read(inode) & I_NEW);
-	inode_state_del(inode, I_WILL_FREE);
-
-	return 1;
-}
-
 /*
  * This is called from our getattr.
  */
diff --git a/fs/ocfs2/inode.h b/fs/ocfs2/inode.h
index accf03d4765e..07bd838e7843 100644
--- a/fs/ocfs2/inode.h
+++ b/fs/ocfs2/inode.h
@@ -116,7 +116,6 @@ static inline struct ocfs2_caching_info *INODE_CACHE(struct inode *inode)
 }
 
 void ocfs2_evict_inode(struct inode *inode);
-int ocfs2_drop_inode(struct inode *inode);
 
 /* Flags for ocfs2_iget() */
 #define OCFS2_FI_FLAG_SYSFILE		0x1
diff --git a/fs/ocfs2/ocfs2_trace.h b/fs/ocfs2/ocfs2_trace.h
index 54ed1495de9a..4b32fb5658ad 100644
--- a/fs/ocfs2/ocfs2_trace.h
+++ b/fs/ocfs2/ocfs2_trace.h
@@ -1569,8 +1569,6 @@ DEFINE_OCFS2_ULL_ULL_UINT_EVENT(ocfs2_delete_inode);
 
 DEFINE_OCFS2_ULL_UINT_EVENT(ocfs2_clear_inode);
 
-DEFINE_OCFS2_ULL_UINT_UINT_EVENT(ocfs2_drop_inode);
-
 TRACE_EVENT(ocfs2_inode_revalidate,
 	TP_PROTO(void *inode, unsigned long long ino,
 		 unsigned int flags),
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 53daa4482406..e4b0d25f4869 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -129,7 +129,7 @@ static const struct super_operations ocfs2_sops = {
 	.statfs		= ocfs2_statfs,
 	.alloc_inode	= ocfs2_alloc_inode,
 	.free_inode	= ocfs2_free_inode,
-	.drop_inode	= ocfs2_drop_inode,
+	.drop_inode	= generic_delete_inode,
 	.evict_inode	= ocfs2_evict_inode,
 	.sync_fs	= ocfs2_sync_fs,
 	.put_super	= ocfs2_put_super,
-- 
2.43.0


