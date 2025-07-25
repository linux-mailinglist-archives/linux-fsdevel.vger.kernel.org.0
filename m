Return-Path: <linux-fsdevel+bounces-56053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E83B123DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 20:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B3C3ABCEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 18:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C594125332E;
	Fri, 25 Jul 2025 18:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="jxA6NTNv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CBC248F70
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Jul 2025 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468297; cv=none; b=gq7A8w94x61JnMZLTFZyRHYj2xm1cM3vD5vvhMwZoRKqv1Tj3yT1/YCLvJBy/TwAhobcOwUTpUEJL9uoE0MVPoj/Lxu0DOWV0t0Y3dUS11nWT2POzm2+66S6gJh1LVT7rOVe2er9lkUPZLop18ZXQQ6RiJn+KPu2ZfEOd5Z++a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468297; c=relaxed/simple;
	bh=kr0vvlhMAkYsWxQIkbuF+XGAICsg2zY0aj329vgM9F4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cPOXU5UEWC53s936+DSqbmp3gcLkg+mOTF38jfpKcU/fh7o6mOwTCgJuktErgIKmpgU2t3XxkEVFrfcJfbk+HpMpLRk0zuej7gnCD+F2ygSNtEGFQfYuhSdIrOJCTbslzEzdiPKsPVCFu9puVJ+OcNftIRetHho+cus5VezFk4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=jxA6NTNv; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-719728a1811so27958807b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Jul 2025 11:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1753468292; x=1754073092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tPjWyvmOCbr/GaN1VbdF3ZE+npyqsuBmqabfqv3MdRA=;
        b=jxA6NTNvLGWD47ZhNwrD2ZKy2qvv0B1CU2zEbkP43s3/aTQOXIe/EmxUFMu1KA9vcy
         eJ+6mLKyp99W5l+maeYbb8WF9U22XZtI6DoDbR2LAuoDYFhjmyFTK7eSay9aAMCwDZ0I
         EDVmbz3IYQJTKSzW3Q6Hkxig7tGnmLzz20kaPtD5fgp/E3n0fspNdJh8hs4KpKFeFLyH
         mqHAfneVPlsElcwXCiaZOt/hd+c0uNYt/LS7gncjY0rnCEQYm9M34a0FsCpNNz+1SNwj
         fOQgT6tiOgmejceLW1Dvdz8ffjyABtN+9woGHN8Ji3pRS3a64e3cbCPLdSW8tnIhXic+
         4XqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753468292; x=1754073092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tPjWyvmOCbr/GaN1VbdF3ZE+npyqsuBmqabfqv3MdRA=;
        b=fx+qJLKMIryOmngRDdUkAX7BTqHuUIXiSVZY6CH3OrizkTjSBz7PsG8pDoCY069P5m
         q1e9zPzDhVMYOJ4Pxj+N0tjdncINItlIGrqWHrS6suVrdAf1kcoNH3BaEzZxCBs2FvfT
         H+2R54Tn7xMr3BGfT2uEmKka7MLxP8zu0oYxfybjdIOjjiGwC6nzElOSXxzJCMoXLRmg
         G2CFZan/3tCGojxPuJK/JmMAlRRYuvOy35d1gzRbOZc9dNTsY6pU1QHFnq6GtKEuQaEU
         REThgITKk7UKtTr0oWFLZXuf43Hp74TKwo5YJroZMWEyoAbF4BZC9WyM57hdmNWoNp0Z
         d2Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUZG66qMq2sRl7JzBPI6PrQrO1ifc65WvbkbdExUBCfIvKS4n6bRA5W60h5/nJ9r8IIFoyjF5yn2kc8BkOw@vger.kernel.org
X-Gm-Message-State: AOJu0YzIRM0bwv8dK31rx4Krp/AAPN6Elk6kDjdyCirjkoqdsNhD6VKZ
	PlQmV2pfJkvLPjS2GHTS+g4r/PVe6r0QK1dV57AkORwCkBUWHMQY8vktiMLjC4guglc=
X-Gm-Gg: ASbGnctfWJZggzN90hOstu2/AXM5taE3EeXjwk2gUJWdAOX24l5WTfsJsOyab8TXxsj
	i6C+XMyguD9FIm85T1cqFE8HYc6YjfFPqxLof+YE8KWYpJO6WuMAaPENgysTZ/pRim3temJF3FW
	jjUW9IsICUTZewxgITF5GMaQ4tINWywdP1rit3U2opGf8gRazMK9KvdNpQQCFqZUbWsTOpg8JJ5
	UtEMm8HGPT+4MdvXJKhqAunED0ZyOYdi9DdQXSKNBMqkYcSPGo6wV2FgPCYJHz+wxPoavQKlm3B
	zdi+URNfMw3HW4Z2xwToYh+yf0ffWV/BSttbPgioUXFQtJ97sfk7oBv6zOp2k54g3/eKX08Qc0r
	oF+ymjckcr0g9bAZ3PjM/TxOiWz8Mobx4HB5F2wMM
X-Google-Smtp-Source: AGHT+IE+7oPXZV3uj52Y+EVOYYT9XrqwDsU4Rpg26mzniFWkSqsCy8IF654J0Pivlejpd99Ad476NA==
X-Received: by 2002:a05:690c:48c3:b0:718:38be:b3e1 with SMTP id 00721157ae682-719e3484543mr35848377b3.41.1753468292057;
        Fri, 25 Jul 2025 11:31:32 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:a481:59b9:a579:cd65])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719f23df167sm892437b3.75.2025.07.25.11.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 11:31:31 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org,
	amarkuze@redhat.com
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [PATCH v3] ceph: cleanup of processing ci->i_ceph_flags bits
Date: Fri, 25 Jul 2025 11:31:20 -0700
Message-ID: <20250725183120.1060739-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

The Coverity Scan service has detected potential
race condition in ceph_check_delayed_caps() [1].

The CID 1590633 contains explanation: "Accessing
ci->i_ceph_flags without holding lock
ceph_inode_info.i_ceph_lock. The value of the shared data
will be determined by the interleaving of thread execution.
Thread shared data is accessed without holding an appropriate
lock, possibly causing a race condition (CWE-366)".

The patch reworks the logic of accessing ci->i_ceph_flags.
At first, it removes ci item from a mdsc->cap_delay_list.
Then it unlocks mdsc->cap_delay_lock and it locks
ci->i_ceph_lock. Then, it calls smp_mb__before_atomic()
to be sure that ci->i_ceph_flags has consistent state of
the bits. The is_metadata_under_flush variable stores
the state of CEPH_I_FLUSH_BIT. Finally, it unlocks
the ci->i_ceph_lock and it locks the mdsc->cap_delay_lock.
The is_metadata_under_flush is used to check the condition
that ci needs to be removed from mdsc->cap_delay_list.
If it is not the case, then ci will be added into the head of
mdsc->cap_delay_list.

This patch reworks the logic of checking the CEPH_I_FLUSH_BIT,
CEPH_I_FLUSH_SNAPS_BIT, CEPH_I_KICK_FLUSH_BIT,
CEPH_ASYNC_CREATE_BIT, CEPH_I_ERROR_FILELOCK_BIT by test_bit()
method and calling smp_mb__before_atomic() to ensure that
bit state is consistent. It switches on calling the set_bit(),
clear_bit() for these bits, and calling smp_mb__after_atomic()
after these methods to ensure that modified bit is visible.

Additionally, __must_hold() has been added for
__cap_delay_requeue(), __cap_delay_requeue_front(), and
__prep_cap() to help the sparse with lock checking and
it was commented that caller of __cap_delay_requeue_front()
and __prep_cap() must lock the ci->i_ceph_lock.

v.2
Alex Markuze suggested to rework all Ceph inode's flags.
Now, every declaration has CEPH_I_<*> and CEPH_I_<*>_BIT pair.

v.3
The logic of operating by ci->i_ceph_flags bits on using
test_bit(), clear_bit(), set_bit() and smp_mb__before_atomic(),
smp_mb__after_atomic() has been reworked in addr.c, inode.c,
locks.c, mds_client.c, snap.c, super.h, xattr.c additionally
to caps.c.

[1] https://scan5.scan.coverity.com/#/project-view/64304/10063?selectedIssue=1590633

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 fs/ceph/addr.c       |   8 ++-
 fs/ceph/caps.c       | 132 +++++++++++++++++++++++++++++++++----------
 fs/ceph/inode.c      |  11 +++-
 fs/ceph/locks.c      |  14 +++--
 fs/ceph/mds_client.c |  10 +++-
 fs/ceph/snap.c       |   6 +-
 fs/ceph/super.h      |  75 ++++++++++++++++--------
 fs/ceph/xattr.c      |  11 +++-
 8 files changed, 198 insertions(+), 69 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 60a621b00c65..c1caac06b059 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2546,6 +2546,8 @@ int ceph_pool_perm_check(struct inode *inode, int need)
 		return 0;
 
 	spin_lock(&ci->i_ceph_lock);
+	/* ensure that bit state is consistent */
+	smp_mb__before_atomic();
 	flags = ci->i_ceph_flags;
 	pool = ci->i_layout.pool_id;
 	spin_unlock(&ci->i_ceph_lock);
@@ -2578,8 +2580,12 @@ int ceph_pool_perm_check(struct inode *inode, int need)
 	if (pool == ci->i_layout.pool_id &&
 	    pool_ns == rcu_dereference_raw(ci->i_layout.pool_ns)) {
 		ci->i_ceph_flags |= flags;
-        } else {
+		/* ensure modified bit is visible */
+		smp_mb__after_atomic();
+	} else {
 		pool = ci->i_layout.pool_id;
+		/* ensure that bit state is consistent */
+		smp_mb__before_atomic();
 		flags = ci->i_ceph_flags;
 	}
 	spin_unlock(&ci->i_ceph_lock);
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index a8d8b56cf9d2..9c82cda33ee5 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -516,6 +516,7 @@ static void __cap_set_timeouts(struct ceph_mds_client *mdsc,
  */
 static void __cap_delay_requeue(struct ceph_mds_client *mdsc,
 				struct ceph_inode_info *ci)
+		__must_hold(ci->i_ceph_lock)
 {
 	struct inode *inode = &ci->netfs.inode;
 
@@ -525,7 +526,9 @@ static void __cap_delay_requeue(struct ceph_mds_client *mdsc,
 	if (!mdsc->stopping) {
 		spin_lock(&mdsc->cap_delay_lock);
 		if (!list_empty(&ci->i_cap_delay_list)) {
-			if (ci->i_ceph_flags & CEPH_I_FLUSH)
+			/* ensure that bit state is consistent */
+			smp_mb__before_atomic();
+			if (test_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags))
 				goto no_change;
 			list_del_init(&ci->i_cap_delay_list);
 		}
@@ -540,15 +543,20 @@ static void __cap_delay_requeue(struct ceph_mds_client *mdsc,
  * Queue an inode for immediate writeback.  Mark inode with I_FLUSH,
  * indicating we should send a cap message to flush dirty metadata
  * asap, and move to the front of the delayed cap list.
+ *
+ * Caller must hold i_ceph_lock.
  */
 static void __cap_delay_requeue_front(struct ceph_mds_client *mdsc,
 				      struct ceph_inode_info *ci)
+		__must_hold(ci->i_ceph_lock)
 {
 	struct inode *inode = &ci->netfs.inode;
 
 	doutc(mdsc->fsc->client, "%p %llx.%llx\n", inode, ceph_vinop(inode));
 	spin_lock(&mdsc->cap_delay_lock);
-	ci->i_ceph_flags |= CEPH_I_FLUSH;
+	set_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags);
+	/* ensure modified bit is visible */
+	smp_mb__after_atomic();
 	if (!list_empty(&ci->i_cap_delay_list))
 		list_del_init(&ci->i_cap_delay_list);
 	list_add(&ci->i_cap_delay_list, &mdsc->cap_delay_list);
@@ -1386,10 +1394,13 @@ void __ceph_remove_caps(struct ceph_inode_info *ci)
  *
  * Make note of max_size reported/requested from mds, revoked caps
  * that have now been implemented.
+ *
+ * Caller must hold i_ceph_lock.
  */
 static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
 		       int op, int flags, int used, int want, int retain,
 		       int flushing, u64 flush_tid, u64 oldest_flush_tid)
+		__must_hold(ci->i_ceph_lock)
 {
 	struct ceph_inode_info *ci = cap->ci;
 	struct inode *inode = &ci->netfs.inode;
@@ -1408,7 +1419,9 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
 	      ceph_cap_string(revoking));
 	BUG_ON((retain & CEPH_CAP_PIN) == 0);
 
-	ci->i_ceph_flags &= ~CEPH_I_FLUSH;
+	clear_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags);
+	/* ensure modified bit is visible */
+	smp_mb__after_atomic();
 
 	cap->issued &= retain;  /* drop bits we don't want */
 	/*
@@ -1665,7 +1678,9 @@ static void __ceph_flush_snaps(struct ceph_inode_info *ci,
 		last_tid = capsnap->cap_flush.tid;
 	}
 
-	ci->i_ceph_flags &= ~CEPH_I_FLUSH_SNAPS;
+	clear_bit(CEPH_I_FLUSH_SNAPS_BIT, &ci->i_ceph_flags);
+	/* ensure modified bit is visible */
+	smp_mb__after_atomic();
 
 	while (first_tid <= last_tid) {
 		struct ceph_cap *cap = ci->i_auth_cap;
@@ -1728,7 +1743,9 @@ void ceph_flush_snaps(struct ceph_inode_info *ci,
 		session = *psession;
 retry:
 	spin_lock(&ci->i_ceph_lock);
-	if (!(ci->i_ceph_flags & CEPH_I_FLUSH_SNAPS)) {
+	/* ensure that bit state is consistent */
+	smp_mb__before_atomic();
+	if (!test_bit(CEPH_I_FLUSH_SNAPS_BIT, &ci->i_ceph_flags)) {
 		doutc(cl, " no capsnap needs flush, doing nothing\n");
 		goto out;
 	}
@@ -1752,7 +1769,9 @@ void ceph_flush_snaps(struct ceph_inode_info *ci,
 	}
 
 	// make sure flushsnap messages are sent in proper order.
-	if (ci->i_ceph_flags & CEPH_I_KICK_FLUSH)
+	/* ensure that bit state is consistent */
+	smp_mb__before_atomic();
+	if (test_bit(CEPH_I_KICK_FLUSH_BIT, &ci->i_ceph_flags))
 		__kick_flushing_caps(mdsc, session, ci, 0);
 
 	__ceph_flush_snaps(ci, session);
@@ -2024,15 +2043,21 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 	struct ceph_mds_session *session = NULL;
 
 	spin_lock(&ci->i_ceph_lock);
-	if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE) {
-		ci->i_ceph_flags |= CEPH_I_ASYNC_CHECK_CAPS;
+	/* ensure that bit state is consistent */
+	smp_mb__before_atomic();
+	if (test_bit(CEPH_ASYNC_CREATE_BIT, &ci->i_ceph_flags)) {
+		set_bit(CEPH_I_ASYNC_CHECK_CAPS_BIT, &ci->i_ceph_flags);
+		/* ensure modified bit is visible */
+		smp_mb__after_atomic();
 
 		/* Don't send messages until we get async create reply */
 		spin_unlock(&ci->i_ceph_lock);
 		return;
 	}
 
-	if (ci->i_ceph_flags & CEPH_I_FLUSH)
+	/* ensure that bit state is consistent */
+	smp_mb__before_atomic();
+	if (test_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags))
 		flags |= CHECK_CAPS_FLUSH;
 retry:
 	/* Caps wanted by virtue of active open files. */
@@ -2196,7 +2221,10 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 				doutc(cl, "flushing dirty caps\n");
 				goto ack;
 			}
-			if (ci->i_ceph_flags & CEPH_I_FLUSH_SNAPS) {
+
+			/* ensure that bit state is consistent */
+			smp_mb__before_atomic();
+			if (test_bit(CEPH_I_FLUSH_SNAPS_BIT, &ci->i_ceph_flags)) {
 				doutc(cl, "flushing snap caps\n");
 				goto ack;
 			}
@@ -2220,12 +2248,14 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 
 		/* kick flushing and flush snaps before sending normal
 		 * cap message */
+		/* ensure that bit state is consistent */
+		smp_mb__before_atomic();
 		if (cap == ci->i_auth_cap &&
 		    (ci->i_ceph_flags &
 		     (CEPH_I_KICK_FLUSH | CEPH_I_FLUSH_SNAPS))) {
-			if (ci->i_ceph_flags & CEPH_I_KICK_FLUSH)
+			if (test_bit(CEPH_I_KICK_FLUSH_BIT, &ci->i_ceph_flags))
 				__kick_flushing_caps(mdsc, session, ci, 0);
-			if (ci->i_ceph_flags & CEPH_I_FLUSH_SNAPS)
+			if (test_bit(CEPH_I_FLUSH_SNAPS_BIT, &ci->i_ceph_flags))
 				__ceph_flush_snaps(ci, session);
 
 			goto retry;
@@ -2297,11 +2327,17 @@ static int try_flush_caps(struct inode *inode, u64 *ptid)
 			goto out;
 		}
 
+		/* ensure that bit state is consistent */
+		smp_mb__before_atomic();
 		if (ci->i_ceph_flags &
 		    (CEPH_I_KICK_FLUSH | CEPH_I_FLUSH_SNAPS)) {
-			if (ci->i_ceph_flags & CEPH_I_KICK_FLUSH)
+			/* ensure that bit state is consistent */
+			smp_mb__before_atomic();
+			if (test_bit(CEPH_I_KICK_FLUSH_BIT, &ci->i_ceph_flags))
 				__kick_flushing_caps(mdsc, session, ci, 0);
-			if (ci->i_ceph_flags & CEPH_I_FLUSH_SNAPS)
+			/* ensure that bit state is consistent */
+			smp_mb__before_atomic();
+			if (test_bit(CEPH_I_FLUSH_SNAPS_BIT, &ci->i_ceph_flags))
 				__ceph_flush_snaps(ci, session);
 			goto retry_locked;
 		}
@@ -2573,10 +2609,14 @@ static void __kick_flushing_caps(struct ceph_mds_client *mdsc,
 	u64 last_snap_flush = 0;
 
 	/* Don't do anything until create reply comes in */
-	if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE)
+	/* ensure that bit state is consistent */
+	smp_mb__before_atomic();
+	if (test_bit(CEPH_ASYNC_CREATE_BIT, &ci->i_ceph_flags))
 		return;
 
-	ci->i_ceph_flags &= ~CEPH_I_KICK_FLUSH;
+	clear_bit(CEPH_I_KICK_FLUSH_BIT, &ci->i_ceph_flags);
+	/* ensure modified bit is visible */
+	smp_mb__after_atomic();
 
 	list_for_each_entry_reverse(cf, &ci->i_cap_flush_list, i_list) {
 		if (cf->is_capsnap) {
@@ -2685,7 +2725,9 @@ void ceph_early_kick_flushing_caps(struct ceph_mds_client *mdsc,
 			__kick_flushing_caps(mdsc, session, ci,
 					     oldest_flush_tid);
 		} else {
-			ci->i_ceph_flags |= CEPH_I_KICK_FLUSH;
+			set_bit(CEPH_I_KICK_FLUSH_BIT, &ci->i_ceph_flags);
+			/* ensure modified bit is visible */
+			smp_mb__after_atomic();
 		}
 
 		spin_unlock(&ci->i_ceph_lock);
@@ -2720,7 +2762,10 @@ void ceph_kick_flushing_caps(struct ceph_mds_client *mdsc,
 			spin_unlock(&ci->i_ceph_lock);
 			continue;
 		}
-		if (ci->i_ceph_flags & CEPH_I_KICK_FLUSH) {
+
+		/* ensure that bit state is consistent */
+		smp_mb__before_atomic();
+		if (test_bit(CEPH_I_KICK_FLUSH_BIT, &ci->i_ceph_flags)) {
 			__kick_flushing_caps(mdsc, session, ci,
 					     oldest_flush_tid);
 		}
@@ -2827,8 +2872,10 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 again:
 	spin_lock(&ci->i_ceph_lock);
 
+	/* ensure that bit state is consistent */
+	smp_mb__before_atomic();
 	if ((flags & CHECK_FILELOCK) &&
-	    (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK)) {
+	    test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags)) {
 		doutc(cl, "%p %llx.%llx error filelock\n", inode,
 		      ceph_vinop(inode));
 		ret = -EIO;
@@ -3205,8 +3252,11 @@ static int ceph_try_drop_cap_snap(struct ceph_inode_info *ci,
 		doutc(cl, "%p follows %llu\n", capsnap, capsnap->follows);
 		BUG_ON(capsnap->cap_flush.tid > 0);
 		ceph_put_snap_context(capsnap->context);
-		if (!list_is_last(&capsnap->ci_item, &ci->i_cap_snaps))
-			ci->i_ceph_flags |= CEPH_I_FLUSH_SNAPS;
+		if (!list_is_last(&capsnap->ci_item, &ci->i_cap_snaps)) {
+			set_bit(CEPH_I_FLUSH_SNAPS_BIT, &ci->i_ceph_flags);
+			/* ensure modified bit is visible */
+			smp_mb__after_atomic();
+		}
 
 		list_del(&capsnap->ci_item);
 		ceph_put_cap_snap(capsnap);
@@ -3395,7 +3445,10 @@ void ceph_put_wrbuffer_cap_refs(struct ceph_inode_info *ci, int nr,
 				if (ceph_try_drop_cap_snap(ci, capsnap)) {
 					put++;
 				} else {
-					ci->i_ceph_flags |= CEPH_I_FLUSH_SNAPS;
+					set_bit(CEPH_I_FLUSH_SNAPS_BIT,
+						&ci->i_ceph_flags);
+					/* ensure modified bit is visible */
+					smp_mb__after_atomic();
 					flush_snaps = true;
 				}
 			}
@@ -3646,8 +3699,11 @@ static void handle_cap_grant(struct inode *inode,
 		rcu_assign_pointer(ci->i_layout.pool_ns, extra_info->pool_ns);
 
 		if (ci->i_layout.pool_id != old_pool ||
-		    extra_info->pool_ns != old_ns)
-			ci->i_ceph_flags &= ~CEPH_I_POOL_PERM;
+		    extra_info->pool_ns != old_ns) {
+			clear_bit(CEPH_I_POOL_PERM_BIT, &ci->i_ceph_flags);
+			/* ensure modified bit is visible */
+			smp_mb__after_atomic();
+		}
 
 		extra_info->pool_ns = old_ns;
 
@@ -4613,6 +4669,7 @@ unsigned long ceph_check_delayed_caps(struct ceph_mds_client *mdsc)
 	unsigned long delay_max = opt->caps_wanted_delay_max * HZ;
 	unsigned long loop_start = jiffies;
 	unsigned long delay = 0;
+	bool is_metadata_under_flush;
 
 	doutc(cl, "begin\n");
 	spin_lock(&mdsc->cap_delay_lock);
@@ -4625,11 +4682,24 @@ unsigned long ceph_check_delayed_caps(struct ceph_mds_client *mdsc)
 			delay = ci->i_hold_caps_max;
 			break;
 		}
-		if ((ci->i_ceph_flags & CEPH_I_FLUSH) == 0 &&
-		    time_before(jiffies, ci->i_hold_caps_max))
-			break;
+
 		list_del_init(&ci->i_cap_delay_list);
 
+		spin_unlock(&mdsc->cap_delay_lock);
+		spin_lock(&ci->i_ceph_lock);
+		/* ensure that bit state is consistent */
+		smp_mb__before_atomic();
+		is_metadata_under_flush =
+			test_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags);
+		spin_unlock(&ci->i_ceph_lock);
+		spin_lock(&mdsc->cap_delay_lock);
+
+		if (!is_metadata_under_flush &&
+		    time_before(jiffies, ci->i_hold_caps_max)) {
+			list_add(&ci->i_cap_delay_list, &mdsc->cap_delay_list);
+			break;
+		}
+
 		inode = igrab(&ci->netfs.inode);
 		if (inode) {
 			spin_unlock(&mdsc->cap_delay_lock);
@@ -4811,7 +4881,9 @@ int ceph_drop_caps_for_unlink(struct inode *inode)
 			doutc(mdsc->fsc->client, "%p %llx.%llx\n", inode,
 			      ceph_vinop(inode));
 			spin_lock(&mdsc->cap_delay_lock);
-			ci->i_ceph_flags |= CEPH_I_FLUSH;
+			set_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags);
+			/* ensure modified bit is visible */
+			smp_mb__after_atomic();
 			if (!list_empty(&ci->i_cap_delay_list))
 				list_del_init(&ci->i_cap_delay_list);
 			list_add_tail(&ci->i_cap_delay_list,
@@ -5080,7 +5152,9 @@ int ceph_purge_inode_cap(struct inode *inode, struct ceph_cap *cap, bool *invali
 
 		if (atomic_read(&ci->i_filelock_ref) > 0) {
 			/* make further file lock syscall return -EIO */
-			ci->i_ceph_flags |= CEPH_I_ERROR_FILELOCK;
+			set_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags);
+			/* ensure modified bit is visible */
+			smp_mb__after_atomic();
 			pr_warn_ratelimited_client(cl,
 				" dropping file locks for %p %llx.%llx\n",
 				inode, ceph_vinop(inode));
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 06cd2963e41e..109d5746a6ac 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1105,8 +1105,11 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 					lockdep_is_held(&ci->i_ceph_lock));
 		rcu_assign_pointer(ci->i_layout.pool_ns, pool_ns);
 
-		if (ci->i_layout.pool_id != old_pool || pool_ns != old_ns)
-			ci->i_ceph_flags &= ~CEPH_I_POOL_PERM;
+		if (ci->i_layout.pool_id != old_pool || pool_ns != old_ns) {
+			clear_bit(CEPH_I_POOL_PERM_BIT, &ci->i_ceph_flags);
+			/* ensure modified bit is visible */
+			smp_mb__after_atomic();
+		}
 
 		pool_ns = old_ns;
 
@@ -3149,7 +3152,9 @@ void ceph_inode_shutdown(struct inode *inode)
 	bool invalidate = false;
 
 	spin_lock(&ci->i_ceph_lock);
-	ci->i_ceph_flags |= CEPH_I_SHUTDOWN;
+	set_bit(CEPH_I_SHUTDOWN_BIT, &ci->i_ceph_flags);
+	/* ensure modified bit is visible */
+	smp_mb__after_atomic();
 	p = rb_first(&ci->i_caps);
 	while (p) {
 		struct ceph_cap *cap = rb_entry(p, struct ceph_cap, ci_node);
diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index ebf4ac0055dd..2475f2dbec1b 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -58,7 +58,9 @@ static void ceph_fl_release_lock(struct file_lock *fl)
 	if (atomic_dec_and_test(&ci->i_filelock_ref)) {
 		/* clear error when all locks are released */
 		spin_lock(&ci->i_ceph_lock);
-		ci->i_ceph_flags &= ~CEPH_I_ERROR_FILELOCK;
+		clear_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags);
+		/* ensure modified bit is visible */
+		smp_mb__after_atomic();
 		spin_unlock(&ci->i_ceph_lock);
 	}
 	fl->fl_u.ceph.inode = NULL;
@@ -269,9 +271,10 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 		wait = 1;
 
 	spin_lock(&ci->i_ceph_lock);
-	if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
+	/* ensure that bit state is consistent */
+	smp_mb__before_atomic();
+	if (test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags))
 		err = -EIO;
-	}
 	spin_unlock(&ci->i_ceph_lock);
 	if (err < 0) {
 		if (op == CEPH_MDS_OP_SETFILELOCK && lock_is_unlock(fl))
@@ -329,9 +332,10 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 	doutc(cl, "fl_file: %p\n", fl->c.flc_file);
 
 	spin_lock(&ci->i_ceph_lock);
-	if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
+	/* ensure that bit state is consistent */
+	smp_mb__before_atomic();
+	if (test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags))
 		err = -EIO;
-	}
 	spin_unlock(&ci->i_ceph_lock);
 	if (err < 0) {
 		if (lock_is_unlock(fl))
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 230e0c3f341f..19368c4eaf20 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3549,7 +3549,10 @@ static void __do_request(struct ceph_mds_client *mdsc,
 
 		spin_lock(&ci->i_ceph_lock);
 		cap = ci->i_auth_cap;
-		if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE && mds != cap->mds) {
+		/* ensure that bit state is consistent */
+		smp_mb__before_atomic();
+		if (test_bit(CEPH_ASYNC_CREATE_BIT, &ci->i_ceph_flags) &&
+		    mds != cap->mds) {
 			doutc(cl, "session changed for auth cap %d -> %d\n",
 			      cap->session->s_mds, session->s_mds);
 
@@ -4630,8 +4633,11 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 		rec.v2.issued = cpu_to_le32(cap->issued);
 		rec.v2.snaprealm = cpu_to_le64(ci->i_snap_realm->ino);
 		rec.v2.pathbase = cpu_to_le64(pathbase);
+		/* ensure that bit state is consistent */
+		smp_mb__before_atomic();
 		rec.v2.flock_len = (__force __le32)
-			((ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) ? 0 : 1);
+			(test_bit(CEPH_I_ERROR_FILELOCK_BIT,
+						&ci->i_ceph_flags) ? 0 : 1);
 	} else {
 		struct timespec64 ts;
 
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index c65f2b202b2b..6b9da14a942e 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -661,6 +661,7 @@ static void ceph_queue_cap_snap(struct ceph_inode_info *ci,
  */
 int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
 			    struct ceph_cap_snap *capsnap)
+		__must_hold(ci->i_ceph_lock)
 {
 	struct inode *inode = &ci->netfs.inode;
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
@@ -700,7 +701,10 @@ int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
 		return 0;
 	}
 
-	ci->i_ceph_flags |= CEPH_I_FLUSH_SNAPS;
+	set_bit(CEPH_I_FLUSH_SNAPS_BIT, &ci->i_ceph_flags);
+	/* ensure modified bit is visible */
+	smp_mb__after_atomic();
+
 	doutc(cl, "%p %llx.%llx cap_snap %p snapc %p %llu %s s=%llu\n",
 	      inode, ceph_vinop(inode), capsnap, capsnap->context,
 	      capsnap->context->seq, ceph_cap_string(capsnap->dirty),
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index bb0db0cc8003..d55f91ce1a97 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -628,22 +628,35 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
 /*
  * Ceph inode.
  */
-#define CEPH_I_DIR_ORDERED	(1 << 0)  /* dentries in dir are ordered */
-#define CEPH_I_FLUSH		(1 << 2)  /* do not delay flush of dirty metadata */
-#define CEPH_I_POOL_PERM	(1 << 3)  /* pool rd/wr bits are valid */
-#define CEPH_I_POOL_RD		(1 << 4)  /* can read from pool */
-#define CEPH_I_POOL_WR		(1 << 5)  /* can write to pool */
-#define CEPH_I_SEC_INITED	(1 << 6)  /* security initialized */
-#define CEPH_I_KICK_FLUSH	(1 << 7)  /* kick flushing caps */
-#define CEPH_I_FLUSH_SNAPS	(1 << 8)  /* need flush snapss */
-#define CEPH_I_ERROR_WRITE	(1 << 9) /* have seen write errors */
-#define CEPH_I_ERROR_FILELOCK	(1 << 10) /* have seen file lock errors */
-#define CEPH_I_ODIRECT		(1 << 11) /* inode in direct I/O mode */
-#define CEPH_ASYNC_CREATE_BIT	(12)	  /* async create in flight for this */
-#define CEPH_I_ASYNC_CREATE	(1 << CEPH_ASYNC_CREATE_BIT)
-#define CEPH_I_SHUTDOWN		(1 << 13) /* inode is no longer usable */
-#define CEPH_I_ASYNC_CHECK_CAPS	(1 << 14) /* check caps immediately after async
-					     creating finishes */
+#define CEPH_I_DIR_ORDERED_BIT		(0)  /* dentries in dir are ordered */
+#define CEPH_I_FLUSH_BIT		(2)  /* do not delay flush of dirty metadata */
+#define CEPH_I_POOL_PERM_BIT		(3)  /* pool rd/wr bits are valid */
+#define CEPH_I_POOL_RD_BIT		(4)  /* can read from pool */
+#define CEPH_I_POOL_WR_BIT		(5)  /* can write to pool */
+#define CEPH_I_SEC_INITED_BIT		(6)  /* security initialized */
+#define CEPH_I_KICK_FLUSH_BIT		(7)  /* kick flushing caps */
+#define CEPH_I_FLUSH_SNAPS_BIT		(8)  /* need flush snapss */
+#define CEPH_I_ERROR_WRITE_BIT		(9)  /* have seen write errors */
+#define CEPH_I_ERROR_FILELOCK_BIT	(10) /* have seen file lock errors */
+#define CEPH_I_ODIRECT_BIT		(11) /* inode in direct I/O mode */
+#define CEPH_ASYNC_CREATE_BIT		(12) /* async create in flight for this */
+#define CEPH_I_SHUTDOWN_BIT		(13) /* inode is no longer usable */
+#define CEPH_I_ASYNC_CHECK_CAPS_BIT	(14) /* check caps after async creating finishes */
+
+#define CEPH_I_DIR_ORDERED		(1 << CEPH_I_DIR_ORDERED_BIT)
+#define CEPH_I_FLUSH			(1 << CEPH_I_FLUSH_BIT)
+#define CEPH_I_POOL_PERM		(1 << CEPH_I_POOL_PERM_BIT)
+#define CEPH_I_POOL_RD			(1 << CEPH_I_POOL_RD_BIT)
+#define CEPH_I_POOL_WR			(1 << CEPH_I_POOL_WR_BIT)
+#define CEPH_I_SEC_INITED		(1 << CEPH_I_SEC_INITED_BIT)
+#define CEPH_I_KICK_FLUSH		(1 << CEPH_I_KICK_FLUSH_BIT)
+#define CEPH_I_FLUSH_SNAPS		(1 << CEPH_I_FLUSH_SNAPS_BIT)
+#define CEPH_I_ERROR_WRITE		(1 << CEPH_I_ERROR_WRITE_BIT)
+#define CEPH_I_ERROR_FILELOCK		(1 << CEPH_I_ERROR_FILELOCK_BIT)
+#define CEPH_I_ODIRECT			(1 << CEPH_I_ODIRECT_BIT)
+#define CEPH_I_ASYNC_CREATE		(1 << CEPH_ASYNC_CREATE_BIT)
+#define CEPH_I_SHUTDOWN			(1 << CEPH_I_SHUTDOWN_BIT)
+#define CEPH_I_ASYNC_CHECK_CAPS		(1 << CEPH_I_ASYNC_CHECK_CAPS_BIT)
 
 /*
  * Masks of ceph inode work.
@@ -663,20 +676,28 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
  */
 static inline void ceph_set_error_write(struct ceph_inode_info *ci)
 {
-	if (!(READ_ONCE(ci->i_ceph_flags) & CEPH_I_ERROR_WRITE)) {
-		spin_lock(&ci->i_ceph_lock);
-		ci->i_ceph_flags |= CEPH_I_ERROR_WRITE;
-		spin_unlock(&ci->i_ceph_lock);
+	spin_lock(&ci->i_ceph_lock);
+	/* ensure that bit state is consistent */
+	smp_mb__before_atomic();
+	if (!test_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags)) {
+		set_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags);
+		/* ensure modified bit is visible */
+		smp_mb__after_atomic();
 	}
+	spin_unlock(&ci->i_ceph_lock);
 }
 
 static inline void ceph_clear_error_write(struct ceph_inode_info *ci)
 {
-	if (READ_ONCE(ci->i_ceph_flags) & CEPH_I_ERROR_WRITE) {
-		spin_lock(&ci->i_ceph_lock);
-		ci->i_ceph_flags &= ~CEPH_I_ERROR_WRITE;
-		spin_unlock(&ci->i_ceph_lock);
+	spin_lock(&ci->i_ceph_lock);
+	/* ensure that bit state is consistent */
+	smp_mb__before_atomic();
+	if (!test_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags)) {
+		clear_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags);
+		/* ensure modified bit is visible */
+		smp_mb__after_atomic();
 	}
+	spin_unlock(&ci->i_ceph_lock);
 }
 
 static inline void __ceph_dir_set_complete(struct ceph_inode_info *ci,
@@ -1110,10 +1131,14 @@ void ceph_inode_shutdown(struct inode *inode);
 
 static inline bool ceph_inode_is_shutdown(struct inode *inode)
 {
-	unsigned long flags = READ_ONCE(ceph_inode(inode)->i_ceph_flags);
+	unsigned long flags;
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	int state = READ_ONCE(fsc->mount_state);
 
+	/* ensure that bit state is consistent */
+	smp_mb__before_atomic();
+	flags = READ_ONCE(ceph_inode(inode)->i_ceph_flags);
+
 	return (flags & CEPH_I_SHUTDOWN) || state >= CEPH_MOUNT_SHUTDOWN;
 }
 
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 537165db4519..487bd18513b1 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1055,8 +1055,11 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
 
 	if (current->journal_info &&
 	    !strncmp(name, XATTR_SECURITY_PREFIX, XATTR_SECURITY_PREFIX_LEN) &&
-	    security_ismaclabel(name + XATTR_SECURITY_PREFIX_LEN))
-		ci->i_ceph_flags |= CEPH_I_SEC_INITED;
+	    security_ismaclabel(name + XATTR_SECURITY_PREFIX_LEN)) {
+		set_bit(CEPH_I_SEC_INITED_BIT, &ci->i_ceph_flags);
+		/* ensure modified bit is visible */
+		smp_mb__after_atomic();
+	}
 out:
 	spin_unlock(&ci->i_ceph_lock);
 	return err;
@@ -1366,7 +1369,9 @@ bool ceph_security_xattr_deadlock(struct inode *in)
 		return false;
 	ci = ceph_inode(in);
 	spin_lock(&ci->i_ceph_lock);
-	ret = !(ci->i_ceph_flags & CEPH_I_SEC_INITED) &&
+	/* ensure that bit state is consistent */
+	smp_mb__before_atomic();
+	ret = !test_bit(CEPH_I_SEC_INITED_BIT, &ci->i_ceph_flags) &&
 	      !(ci->i_xattrs.version > 0 &&
 		__ceph_caps_issued_mask(ci, CEPH_CAP_XATTR_SHARED, 0));
 	spin_unlock(&ci->i_ceph_lock);
-- 
2.50.1


