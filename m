Return-Path: <linux-fsdevel+bounces-58686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6E5B3067C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A36B34E671C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D173932DF;
	Thu, 21 Aug 2025 20:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="fT0/XoWU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2FC3932BE
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807694; cv=none; b=aF6RPD3EiWt8sMIZEt2DcS0AFIFFhQf7q7zikkAFJLXGRaUIbFhMsDISgg6eUoJx6r2zI+5kdNnJvtR1j7FOGtvt+EPLxWVBSrp7fjJcmY74aOTwXrE3TN6fhjjB5R3a1A6Kz0t8Q+Um2VBd5idsHuuk2ycA+Rhr1lUaVs+KdBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807694; c=relaxed/simple;
	bh=e9T8yBoPjhlzRhqS6ctn957mp2rVUc9PnrF4aSii4bE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XPmgiBqmF9MvGV0c7jSvC9F+PTobdtGVTrJbJjoUbRt8NJPJcJ/Ldk+i5gcwWYO5Fz+HWPjKqZIbYT1VT8WycGmNIjktUZpseM+1hLuKEv/FZ5rOhvZGWuNrrGQRQVS6Ivwav7kWco09fSczJTZdcV+t3iHu5bxU6eQYGa8HoA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=fT0/XoWU; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d603b60cbso12949517b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807691; x=1756412491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxZjKYM4mYTysigbg1aS2myV2n2WnBdcHH0F6QQDJT8=;
        b=fT0/XoWUSPdsKxgNS374N3gp1gEkPcw0i3qDdB4DL3TP2MtQiqw1fVTQZQs+eZ0fhm
         lcgQtrkLU4uMe3eFrmybTscL0t/YWVP4V6sHx/Y80Y88sQ99/exykKXHPsuWOIvOso69
         U863K3OYl4wpPXEz1D3AGWSGOyKdoeFW++JZdQaLzuZ5eMIZRpjBpMA4O73WahigVPA+
         /yfdzfaRIBCVGwIIP9X9eeSdCajQXhvGFyphBSz71CxooMCjrO/dyFKnRpwdwfnERSft
         eJHKTQIEGrZhBfH2sj/AJ/8uNepcUgnYER5DIQ298xN4cNdU583z2EeJwyyy6GNRzml0
         bCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807691; x=1756412491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TxZjKYM4mYTysigbg1aS2myV2n2WnBdcHH0F6QQDJT8=;
        b=PesIpOmhtAZXjkLryTgdQ9eH5ibnVcHtGH+z6Bet5fC5t3s9NVGjrp4pJszDj+dSyD
         nUvyVf4m+8b6V6H6+60s0GmrsbR088jM2MVlBnqCB2hSHCYA1hV55QSR8mq7YX4Kgot5
         JHKbW7NzwWu7Sj7VvOPlEMxTSUtxuSNXPTUV4pIfhf0waRv2fumC41SkVZYwUK6ZaYvf
         OC+HNzVlOIfIHQRB+PRO4S/LScO9E0tfZgpV9PADXwGkdkPtHKT5h8FtO1lCe8bc8JDv
         EKJRXQKXyjUSyR1fyh4NxUGD45Muja331d0AMHogwcUFXWFeUnVfHSeF/k0snuxTId9C
         1WVA==
X-Gm-Message-State: AOJu0Yy49145spS//pJVqyTrqYoGGN2GHDbSykJ2MqjULqoKtBYOTVFm
	yJxHsBsaazbk5xRaoL96or1/3CxU7DkITR3hqGMGbkrjFgdcg1emgRglIkyshKw9BXDkdyb3rNv
	Cfai/JwISkw==
X-Gm-Gg: ASbGncusF57nepp34txxpmP2qON0PHKYz0YthSl2LCbqFFJ2nAVK+yUq1LM2GSCeTy7
	6/uTD9dWgx6MA14eqW+HcXMh76RazJcsCtpLBOaTZkAcJhGlxX6bBBs0UFt11dv57CYQ77NfBKu
	8nIcaZ4De+3OsuG3bYWFcOu8txZMjrrFgGd4sEfeJUL8Cvs/nhMvfM9R9mhpVR73NeY5xFdLtea
	qdu5o19c2bY9Rz05+esDJLfOFEmKDykyv5MR+Cf7Iyzfm6km4adjWi6xFGNvm8fMOEw1h1RUioF
	EwSRVmCrFwmhQ+FCVz3Y1+5reDNxemg0cl4tIRbXX6+UsGaaYSVAUuQOSIo29qo64jvVIwEM76t
	602jkF63KIcwA3J6Gmq42I/h+m21c3InmpbSnFplyARcFQstJnn+U7KK19AphOeJDtDXxMQ==
X-Google-Smtp-Source: AGHT+IFvyHuxtSnd7r1nEiz/vSvjjmwAQJJDkbB73SA0uCWayscP4+Sdw6gTzlJUKBzKUSVNecJRmQ==
X-Received: by 2002:a05:690c:6c0d:b0:71f:c6c5:c55c with SMTP id 00721157ae682-71fdc3d1834mr6262747b3.26.1755807691086;
        Thu, 21 Aug 2025 13:21:31 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e84367526sm34115357b3.61.2025.08.21.13.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:30 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 49/50] fs: remove I_FREEING|I_WILL_FREE
Date: Thu, 21 Aug 2025 16:19:00 -0400
Message-ID: <986e757c6b725231500556c68967588b23081e79.1755806649.git.josef@toxicpanda.com>
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

Now that we're using the i_count reference count as the ultimate arbiter
of whether or not an inode is life we can remove the I_FREEING and
I_WILL_FREE flags.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c                       |  8 ++------
 include/linux/fs.h               | 32 +++++++++++---------------------
 include/trace/events/writeback.h |  2 --
 3 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index f715504778d2..1bb528405b3d 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -878,7 +878,7 @@ void clear_inode(struct inode *inode)
 	BUG_ON(inode->i_state & I_CLEAR);
 	BUG_ON(!list_empty(&inode->i_wb_list));
 	/* don't need i_lock here, no concurrent mods to i_state */
-	inode->i_state = I_FREEING | I_CLEAR;
+	inode->i_state = I_CLEAR;
 }
 EXPORT_SYMBOL(clear_inode);
 
@@ -942,7 +942,7 @@ static void evict(struct inode *inode)
 	 * This also means we don't need any fences for the call below.
 	 */
 	inode_wake_up_bit(inode, __I_NEW);
-	BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
+	BUG_ON(inode->i_state != I_CLEAR);
 }
 
 static void iput_evict(struct inode *inode);
@@ -1975,7 +1975,6 @@ static void iput_final(struct inode *inode, bool drop)
 
 	state = inode->i_state;
 	if (!drop) {
-		WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
 		spin_unlock(&inode->i_lock);
 
 		write_inode_now(inode, 1);
@@ -1983,10 +1982,7 @@ static void iput_final(struct inode *inode, bool drop)
 		spin_lock(&inode->i_lock);
 		state = inode->i_state;
 		WARN_ON(state & I_NEW);
-		state &= ~I_WILL_FREE;
 	}
-
-	WRITE_ONCE(inode->i_state, state | I_FREEING);
 	spin_unlock(&inode->i_lock);
 
 	evict(inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9d9acbea6433..0599faef0d6a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -672,8 +672,8 @@ is_uncached_acl(struct posix_acl *acl)
  * I_DIRTY_DATASYNC, I_DIRTY_PAGES, and I_DIRTY_TIME.
  *
  * Four bits define the lifetime of an inode.  Initially, inodes are I_NEW,
- * until that flag is cleared.  I_WILL_FREE, I_FREEING and I_CLEAR are set at
- * various stages of removing an inode.
+ * until that flag is cleared.  I_CLEAR is set when the inode is clean and ready
+ * to be freed.
  *
  * Two bits are used for locking and completion notification, I_NEW and I_SYNC.
  *
@@ -697,24 +697,18 @@ is_uncached_acl(struct posix_acl *acl)
  *			New inodes set I_NEW.  If two processes both create
  *			the same inode, one of them will release its inode and
  *			wait for I_NEW to be released before returning.
- *			Inodes in I_WILL_FREE, I_FREEING or I_CLEAR state can
- *			also cause waiting on I_NEW, without I_NEW actually
- *			being set.  find_inode() uses this to prevent returning
+ *			Inodes with an i_count == 0 or I_CLEAR state can also
+ *			cause waiting on I_NEW, without I_NEW actually being
+ *			set.  find_inode() uses this to prevent returning
  *			nearly-dead inodes.
- * I_WILL_FREE		Must be set when calling write_inode_now() if i_count
- *			is zero.  I_FREEING must be set when I_WILL_FREE is
- *			cleared.
- * I_FREEING		Set when inode is about to be freed but still has dirty
- *			pages or buffers attached or the inode itself is still
- *			dirty.
  * I_CLEAR		Added by clear_inode().  In this state the inode is
- *			clean and can be destroyed.  Inode keeps I_FREEING.
+ *			clean and can be destroyed.
  *
- *			Inodes that are I_WILL_FREE, I_FREEING or I_CLEAR are
- *			prohibited for many purposes.  iget() must wait for
- *			the inode to be completely released, then create it
- *			anew.  Other functions will just ignore such inodes,
- *			if appropriate.  I_NEW is used for waiting.
+ *			Inodes that have i_count == 0 or I_CLEAR are prohibited
+ *			for many purposes.  iget() must wait for the inode to be
+ *			completely released, then create it anew.  Other
+ *			functions will just ignore such inodes, if appropriate.
+ *			I_NEW is used for waiting.
  *
  * I_SYNC		Writeback of inode is running. The bit is set during
  *			data writeback, and cleared with a wakeup on the bit
@@ -752,8 +746,6 @@ is_uncached_acl(struct posix_acl *acl)
  * I_CACHED_LRU		Inode is cached because it is dirty or isn't shrinkable,
  *			and thus is on the s_cached_inode_lru list.
  *
- * Q: What is the difference between I_WILL_FREE and I_FREEING?
- *
  * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
  * upon. There's one free address left.
  */
@@ -776,8 +768,6 @@ enum inode_state_bits {
 	INODE_BIT(I_DIRTY_SYNC),
 	INODE_BIT(I_DIRTY_DATASYNC),
 	INODE_BIT(I_DIRTY_PAGES),
-	INODE_BIT(I_WILL_FREE),
-	INODE_BIT(I_FREEING),
 	INODE_BIT(I_CLEAR),
 	INODE_BIT(I_REFERENCED),
 	INODE_BIT(I_LINKABLE),
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 6949329c744a..58ee61f3d91d 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -15,8 +15,6 @@
 		{I_DIRTY_DATASYNC,	"I_DIRTY_DATASYNC"},	\
 		{I_DIRTY_PAGES,		"I_DIRTY_PAGES"},	\
 		{I_NEW,			"I_NEW"},		\
-		{I_WILL_FREE,		"I_WILL_FREE"},		\
-		{I_FREEING,		"I_FREEING"},		\
 		{I_CLEAR,		"I_CLEAR"},		\
 		{I_SYNC,		"I_SYNC"},		\
 		{I_DIRTY_TIME,		"I_DIRTY_TIME"},	\
-- 
2.49.0


