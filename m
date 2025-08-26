Return-Path: <linux-fsdevel+bounces-59246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF76B36E34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBD5B1BA8A2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B729D35CEB3;
	Tue, 26 Aug 2025 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="XJ9/DEcN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB22A2FDC5A
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222875; cv=none; b=KWkxc6vg/qUdO+qtEmQtMOAjYLBrrZUyE8prLJfoSbvmg2LXIzwBf/ywBlIauthAXY4RjcZlJRm/eyN5A+wHb3H4KAwcB/8exSRatJg4DeAMsBL1jNMabAJbPWc2a9VGuMygMs36vnOhBp5FAynG8AlDJFfzPqG+MGwLIRP1UU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222875; c=relaxed/simple;
	bh=FA4pnJGDj2WWMNOvHLCse6jtjaoFkVIeDGC7hvLCkWU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIw8c2nZDVxOQKpCT+kZNS1c91DnkMP0NKhFIVKlAe9iYkbydvnMA6XWi9zSGvMhtTc5ctOrJCS5e3umfL3+q4cVsC/ZZipi8uKTsIhxYnCwwH0SDZknHiWDO+tAaTVe2J16I2/v8NmoKq1anh4hruYJhhZgPKqyyioO8xhZGIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=XJ9/DEcN; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d60593000so43515747b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222869; x=1756827669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lLdcB47dkfNQdTeXRI/sI229k/Gfes/tUPt2j0scFsc=;
        b=XJ9/DEcNUEHQwOFIq/SM/WNqWBK1LldbFQf18UvrTfLDRHTqSMHqgM36WJQPU8qJij
         iUXTpLTeSwsLrYIAhL8OokEqeiWQfrHaysZ0gzCJanqZlmmLJJrLaRn3tVo+HSf77pOd
         Xy8PawTbcPp9L0G/T26aimhlIctgT6qQxRsvoDBpiXzHIERLO+JBC9nzskGSa5tMOK+3
         uenri5AcfE1dEdRnn90FJLLVNNiUeVI129Urpu2zKwJYssYG/pX5xJiZARmq8oR/QazE
         BA9zTBzeGakH6L7cOKnqMHvhUa4pTqbDig67KQZmnIMTTVaNW9zEuYA8Gnu5NTfwI2oo
         tGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222869; x=1756827669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLdcB47dkfNQdTeXRI/sI229k/Gfes/tUPt2j0scFsc=;
        b=QzG3cJyc87IqV+pdNnfhehIoyc3wTpKx2PAIrbvov1tlhIXuxMrYW2AfVACQgoWMEJ
         7VCndwY8hOcCNxCJ8MY+TH5akiD7E7ynKo4+m/F3d1BQzx5AEWZ+ma011EYDflMTZrw3
         RR5Lrla2ghamnCzhrSqNjpVqmrPKNBkrXHaCKKgcCVRLmSI1mDYLEPgBYob3vPwiOaCj
         KO1l99iX8hH8/2EBoRPC0TPG3qto9Pw2YLeRNeqhzT+DCBLJAAaOgCYfdS+yxk5OV67K
         9SFT+wgwbdAB5w4Yp33wEo3CcQer7xkLgoV8HUw4aWuKv5OUi8OOuaIDtWmS2JZphjUC
         oeBQ==
X-Gm-Message-State: AOJu0YxEGyzSAD+xBLQHynNxmyuW+MPsdNGcWj2rAg1CaRXTtieOn5cm
	SyGQTHB55uPMulEax/ZsK4/hogP4QZ+4E8VJjG6O1l/ZulAE32yvnEOwuW5j8lrsNtwwBFlRzNP
	6nYC6
X-Gm-Gg: ASbGnctNMCPG3KZmZDgD2YkVsd7ujkUVuI4qZN+gcoJKLU931fhf4ZogzqTgpQBAPbk
	AJvSV9VZs09Kf3hZbdyA80Bpq7mNBoLhsK71YJf6qJcFCNDqJjY+NsCJUnQm+OgmNnfcF7lwHBB
	XKmKfbVZxZtpoAwJwomYHnUzgxLwDGro75PWOm7qvNjKbpt8prYFBg1DjBG5jajJVDjppWOXcAs
	gYOOYIfXqpgNDX1Tq8xoYRjPpWeq6/xSwxnBukBpAoplgsJCeF1XI2LpSFMI7dsF9T47gb6aF3H
	02PeRMghjS7RoGV0jZHN9pHnqYiG2Xv3h3UPdAzL02EVQstgge3P4hIrB8s50JqSUqYjKAEv9SS
	v5++tktfnvDAVBDL/yugjgwkIy8ZBsJU8eL7IpaoSE5Ip6eJOPNDovOvgca4=
X-Google-Smtp-Source: AGHT+IG7MZng2S3yfXz9RiSpcnEbolik5Fao0RvRUykpH7SsGkbQuT3EZKEQ9Q+IU3F6hJQRrb8W9g==
X-Received: by 2002:a05:690c:64c8:b0:720:c20:dc2e with SMTP id 00721157ae682-7200c20e228mr88571567b3.31.1756222868952;
        Tue, 26 Aug 2025 08:41:08 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff188b0f1sm25302847b3.42.2025.08.26.08.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:08 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 14/54] fs: add an I_LRU flag to the inode
Date: Tue, 26 Aug 2025 11:39:14 -0400
Message-ID: <be838041953ae727e4ae9629dc1fa55c3dd09f2a.1756222465.git.josef@toxicpanda.com>
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

We will be adding another list for the inode to keep track of inodes
that are being cached for other reasons. This is necessary to make sure
we know which list the inode is on, and to differentiate it from the
private dispose lists.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c                       | 7 +++++++
 include/linux/fs.h               | 8 +++++++-
 include/trace/events/writeback.h | 3 ++-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index ddaf282f7c25..15ff3a0ff7ee 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -545,6 +545,7 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 
 	if (list_lru_add_obj(&inode->i_sb->s_inode_lru, &inode->i_lru)) {
 		iobj_get(inode);
+		inode->i_state |= I_LRU;
 		this_cpu_inc(nr_unused);
 	} else if (rotate) {
 		inode->i_state |= I_REFERENCED;
@@ -574,7 +575,11 @@ void inode_add_lru(struct inode *inode)
 
 static void inode_lru_list_del(struct inode *inode)
 {
+	if (!(inode->i_state & I_LRU))
+		return;
+
 	if (list_lru_del_obj(&inode->i_sb->s_inode_lru, &inode->i_lru)) {
+		inode->i_state &= ~I_LRU;
 		iobj_put(inode);
 		this_cpu_dec(nr_unused);
 	}
@@ -955,6 +960,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 	    (inode->i_state & ~I_REFERENCED) ||
 	    !mapping_shrinkable(&inode->i_data)) {
 		list_lru_isolate(lru, &inode->i_lru);
+		inode->i_state &= ~I_LRU;
 		spin_unlock(&inode->i_lock);
 		this_cpu_dec(nr_unused);
 		return LRU_REMOVED;
@@ -991,6 +997,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 
 	WARN_ON(inode->i_state & I_NEW);
 	inode->i_state |= I_FREEING;
+	inode->i_state &= ~I_LRU;
 	list_lru_isolate_move(lru, &inode->i_lru, freeable);
 	spin_unlock(&inode->i_lock);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 023ad47685be..e12c09b9fcaf 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -744,6 +744,11 @@ is_uncached_acl(struct posix_acl *acl)
  * I_LRU_ISOLATING	Inode is pinned being isolated from LRU without holding
  *			i_count.
  *
+ * I_LRU		Inode is on the LRU list and has an associated LRU
+ *			reference count. Used to distinguish inodes where
+ *			->i_lru is on the LRU and those that are using ->i_lru
+ *			for some other means.
+ *
  * Q: What is the difference between I_WILL_FREE and I_FREEING?
  *
  * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
@@ -774,7 +779,8 @@ enum inode_state_flags_t {
 	I_CREATING		= (1U << 14),
 	I_DONTCACHE		= (1U << 15),
 	I_SYNC_QUEUED		= (1U << 16),
-	I_PINNING_NETFS_WB	= (1U << 17)
+	I_PINNING_NETFS_WB	= (1U << 17),
+	I_LRU			= (1U << 18)
 };
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 1e23919c0da9..486f85aca84d 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -28,7 +28,8 @@
 		{I_DONTCACHE,		"I_DONTCACHE"},		\
 		{I_SYNC_QUEUED,		"I_SYNC_QUEUED"},	\
 		{I_PINNING_NETFS_WB,	"I_PINNING_NETFS_WB"},	\
-		{I_LRU_ISOLATING,	"I_LRU_ISOLATING"}	\
+		{I_LRU_ISOLATING,	"I_LRU_ISOLATING"},	\
+		{I_LRU,			"I_LRU"}		\
 	)
 
 /* enums need to be exported to user space */
-- 
2.49.0


