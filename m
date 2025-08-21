Return-Path: <linux-fsdevel+bounces-58683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A0BB30702
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44CEA1CE34C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC89392A7F;
	Thu, 21 Aug 2025 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="2LkyuwDj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C407392A58
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807689; cv=none; b=bnhHbdXA5eL+p2aTxVqzutKAmp742Oagwg2Yc3dUlvFWYRe9f5Wu+czXbmq7QvmKhLjxLn4I+GR9QZ/q6Y6oldxY4SyFgB+QTAZfmXM1BzQt0cYj4O4ZlFN/5LZmt7nsjZrebOSNmJnpZYBwZ/6/19fw/pSJ6TOoXX1NiDTaClU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807689; c=relaxed/simple;
	bh=ZDkmQqqTtILegdo4a7r5dPzYK+FcCJ1CuDcRGI/hRYE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vpy6JS3s4C84o8dNnn83wgp3bU+Kvj6RIZOo0KVLc4+CpHqV+SjWRhh6QgX2SF7lizUcdtnxwrFkjBgEXhItKxA9D2ZGr8gLBQ6afVWiEmpDmK6DJVTWt3U0Kf5gBwUis0uansT3MwrSymIQ1PkI+eZvRl4i3EUyxVXD6qosLgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=2LkyuwDj; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e94eb6b811aso1246731276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807687; x=1756412487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LAVNfbZBXNGmJhXluKKzkAHm0/FFGEYffxKzPSk2PVs=;
        b=2LkyuwDjNZXw8oN3FtOS9QPmY72tNqC6BTK774BpO0qZFePbXfR2nVpfwf9DOB3FJU
         CcaasgndkfuEJdQpdbuH86aGC/O383m+vUToZe60bdUAWfa3uxD+aLuDZQOx2oCbH9AG
         xj5DlUerNBGdqCuUPZeop1aWvkpocjqa3DEwb1EAqdk/q8NbXU5RdYHq/7ZvHwPo0wqy
         5XjQ+P8JRnisNhfqrNQL1AhRNUWVbfz/XMT+URiauXtocTio/T3WG4lGtHzL0zGLNAp+
         k777+iMeHRmtfWVT7NuPVdqAGgCVpD3xTsjRmtzQWOtRnH+BIK9NXLpIPE2Gsst7M48X
         U/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807687; x=1756412487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAVNfbZBXNGmJhXluKKzkAHm0/FFGEYffxKzPSk2PVs=;
        b=PxU9TBCEdtRxDQWdTsW9j9fr3/emhUlm6EWn8IhhOt+HDaBKl3kzZQMLq4ElR5+DM0
         2/eXKRVwdAXb788+5Tv5/1Z0fxBtqclrfioxNgSpdKYlqauUAddNxxri5qq0Nnc+VOLQ
         utBa/eT+mdwpr/eHZnOLi+R5e7St0jYuR9dMWmrOWroogsqJCrktwFMD7KsNXauTZrwX
         ljABm7ufWW2m9gPvgRTkeU5vIl1f1E/kyFtxZUM4fvIVLUe49nzKGIomYIlDyLRxLnjE
         JwVLVk+FXzcbiWcQq2WwoayaPstJjgyKJvdvFN3jcguST7ggFT53Knjz/Mh3sTYiLEVm
         X+GQ==
X-Gm-Message-State: AOJu0YyewR0lYoIwr6E/iepDpL6tzL6W2PYbipPH/8xVdJdgdmVr2Rgv
	Le/fujfCKRIT0E0UOjCPRuPRL4jyulhkyZWE8OHchROUMPCcxRZQlbrE6N3n9/aYzwwOlFztEeu
	Vq9qfz7rtpg==
X-Gm-Gg: ASbGnctyAj6LBT/WWKSNkwON6QKCweBv5htGKDMQEhKlotcolFl6XKuk6c4OARRA4aT
	0uDrNloQVQEkzbZ+HD/d225Hxx00IWsMcgdod8y7CLTFIenqdtDiHaKix5HtfkcRR9Q9DxKA4JV
	ljaGIX7a4KoKBSZf+jXuQW0f4SHOUDUNzDGK8XSIA6hAX1k/ukmuFX3StGhBi+/FBrO01j8AU6j
	UaW1dqrFkP9ENeMAxteI4h5Y7xna3E/gaTw0gpTEzyxMaaU4Uw/ei8sKuL3+bpfYKiN61hfcMI+
	E7kg/DomnTiZjMsy5UykLTWhltCxlptWViwQrzEMlBbGE9jn7o5V8OqJcb8OQ/PSzDCFA8mb+U9
	c6BDdUHgRw66QL+fjFpiy3z3rCGr+cNm+bocltylFOSdLgoRt7mxMi/0NmEs=
X-Google-Smtp-Source: AGHT+IGQEPownOA6JH9C8sQArMr18TVqYf+uhqNTig78Jp/eVQJCU4B5or1rBXRT9EcKioF9BGZmPg==
X-Received: by 2002:a05:690c:f92:b0:71b:f6b4:da91 with SMTP id 00721157ae682-71fdc316611mr7629387b3.24.1755807686475;
        Thu, 21 Aug 2025 13:21:26 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fdaea0a78sm1774887b3.2.2025.08.21.13.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:25 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 46/50] fs: remove some spurious I_FREEING references in inode.c
Date: Thu, 21 Aug 2025 16:18:57 -0400
Message-ID: <de518c3d59fcbb619c78a6a33da5a8a872118813.1755806649.git.josef@toxicpanda.com>
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

Now that we have the i_count reference count rules set so that we only
go into these evict paths with a 0 count, update the sanity checks to
check that instead of I_FREEING.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 4e1eeb0c3889..f715504778d2 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -874,7 +874,7 @@ void clear_inode(struct inode *inode)
 	 */
 	xa_unlock_irq(&inode->i_data.i_pages);
 	BUG_ON(!list_empty(&inode->i_data.i_private_list));
-	BUG_ON(!(inode->i_state & I_FREEING));
+	BUG_ON(refcount_read(&inode->i_count) != 0);
 	BUG_ON(inode->i_state & I_CLEAR);
 	BUG_ON(!list_empty(&inode->i_wb_list));
 	/* don't need i_lock here, no concurrent mods to i_state */
@@ -887,19 +887,19 @@ EXPORT_SYMBOL(clear_inode);
  * to. We remove any pages still attached to the inode and wait for any IO that
  * is still in progress before finally destroying the inode.
  *
- * An inode must already be marked I_FREEING so that we avoid the inode being
+ * An inode must already have an i_count of 0 so that we avoid the inode being
  * moved back onto lists if we race with other code that manipulates the lists
  * (e.g. writeback_single_inode). The caller is responsible for setting this.
  *
  * An inode must already be removed from the LRU list before being evicted from
- * the cache. This should occur atomically with setting the I_FREEING state
- * flag, so no inodes here should ever be on the LRU when being evicted.
+ * the cache. This should always be the case as the LRU list holds an i_count
+ * reference on the inode, and we only evict inodes with an i_count of 0.
  */
 static void evict(struct inode *inode)
 {
 	const struct super_operations *op = inode->i_sb->s_op;
 
-	BUG_ON(!(inode->i_state & I_FREEING));
+	BUG_ON(refcount_read(&inode->i_count) != 0);
 	BUG_ON(!list_empty(&inode->i_lru));
 
 	if (!list_empty(&inode->i_io_list))
@@ -913,8 +913,8 @@ static void evict(struct inode *inode)
 	/*
 	 * Wait for flusher thread to be done with the inode so that filesystem
 	 * does not start destroying it while writeback is still running. Since
-	 * the inode has I_FREEING set, flusher thread won't start new work on
-	 * the inode.  We just have to wait for running writeback to finish.
+	 * the inode has a 0 i_count, flusher thread won't start new work on the
+	 * inode.  We just have to wait for running writeback to finish.
 	 */
 	inode_wait_for_writeback(inode);
 	spin_unlock(&inode->i_lock);
-- 
2.49.0


