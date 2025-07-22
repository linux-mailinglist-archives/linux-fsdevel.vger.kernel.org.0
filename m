Return-Path: <linux-fsdevel+bounces-55742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0F7B0E486
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 22:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91BE1C267C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 20:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BEB28506B;
	Tue, 22 Jul 2025 20:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="JCfjUmsM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA3A27E7F0
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 20:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753214670; cv=none; b=XkLx5qKqytWY5nl0oTaVgSx1xBBqkZJ8vbbaw4Pcpzg6NC5cfNJqzys3VFOzykO1ZJtYB+TmtJe0xonsmofvMJX3yLnPI70R+GOHnabEmxuK+w6yiqd8zTgd6+iNu5LmIzmM1eyjMTmjBWp/3HRDe4/6gR5ofNBoaFFqXyIOpxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753214670; c=relaxed/simple;
	bh=EOl641cgnFObs7ukmnWjQTkecAzUqlQbrKZYf4iQTmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dznAEacI+GOLGZte+GrUAk5O6PB/sCF+puFlNCZv3CvD0z6AA9COFlN3UmTrhQAPjGqpu5IlDEOUDJWqTa3X8XC0wdB1ZhK86j0DZPxGt4U99w3jhgxK1QOFaktdPVqTs71vS0pPgc14jJkWAlPlmPRVvFMPU8//rm61hgenqQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=JCfjUmsM; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71840959355so2800847b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 13:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1753214666; x=1753819466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5u8+hAZPkE7qpquKdDE+pXTkx1YC9MSGBYTMKr15gmo=;
        b=JCfjUmsMUV5lluHEl0pgEolp8M80owBGl9j/EsAdtBGe/n1/m6eKHkxJpD7E3p4nkf
         VKX9KgmrDO4nBCak/cOw5KBRj3kbk28TdRMse16HXWqOilBx3bprut76t9LS2VIvNo7C
         lyuoXsGxcEynFsse9mLJpy8n8Qz+g8yVAW9KiwH/d6jcEHZIAqUKLaVjlF0dStULEq6g
         OSVYCyfkGUvGXmm8vGY/ImlNzMUR9+yBrAztiQyMdUNj3R/Rg99RlsCoMjGqpIpU0wkC
         H3J7sDYR7Avd0zN6D8rOHXCBXe8qONv8BU5NH54BFpz3bm6cC0Wr22IQY8lyzcb1R7Uq
         +7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753214666; x=1753819466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5u8+hAZPkE7qpquKdDE+pXTkx1YC9MSGBYTMKr15gmo=;
        b=gXAlVG1LoecNc6OCvIWM4GOCkQ0aCHy07XHENUjclrWCcnMav4HOGBTqtHP6USHKG5
         99INTymzqLYfc1biIg4N+2YuEZgblcRwNBW99rYwXDytLCTyaDtCiCJupYKceQk1rgkx
         cnrYG1AJEhHEjGGF75ganD5+FLqUb7RGy31PK/sg6KFTPebeTxAZ7c1I7nlaQ1RknqfS
         3rIUkLwiXJ2SL/gSHi4F7Mazl7/oMXEYcmZFNm9aLPdHbvewXwJecRTS8TuHo51kD/PX
         cPxdrA24Y+uvlrPFjI+rpxlBVQ+37KJF3pd5io7wCs0rqxHSeNn4Tcxik6Gy5grrf3KR
         tZ5A==
X-Forwarded-Encrypted: i=1; AJvYcCWK+K+YPzf6diGj/wzau5S3F3YUgD3HT89LJI0WkoTbsb6WmpjRvB9DRPSEjNWLlVDJJWX0zHrWih06pRbJ@vger.kernel.org
X-Gm-Message-State: AOJu0YySjKYOXQCMli9CJG3fcrM1tQplYHsauJb0Qcuh4VXa9HEwcrx/
	DRTV9sLbrHAG7+o0L0ZeRZ6nPtGeOkKhWyP1ufLRrSSwMZdqApaEeuMzdMbuwi/FFoU=
X-Gm-Gg: ASbGncs5N3Iyln8/qYk+tXOUDtq30ntr/VM14eZ0S304FJSWyFnjO0KLh8P3zBYTm+l
	+KTJ610SrB2iED/HpJoM4Ioymhmg3qujT7lFAObOYabS0KSuPlzVYK0SI0Fle3+6o/B3bEx0RYQ
	xCusRYY//Pb8l0y0D5ygQFDmZpwVp1JUDZ7NHng67kVZoBFARj1duSLsk8PiQQupJuulRTA57Rd
	+zHeg8Am1QaxXIFRrZvy8FkmFcCzHENOPieCYABPWOFJ3hPQsd081gZGL6OJ1HWdhgnZQptRwh3
	6STBRpIhWBSx2+JZYneFV4S5NoTGFUWW6sQmfrHHDnNBwMINj7sB7q4yXyihwguaBse11Rfptt6
	WYTrAruITUh2pUV1lW/J/958aOmuiqPV2AzUNTKbZH5l9PReKT7M=
X-Google-Smtp-Source: AGHT+IFtMNX9fpQ4P8pLlP33CvjJIli5f+/IksNs5V3wOd9VUGlnBlntucA5z2TZD2mNEY0IgF/1mQ==
X-Received: by 2002:a05:690c:f8b:b0:713:ff19:d046 with SMTP id 00721157ae682-719a0a45d3cmr67874127b3.6.1753214666138;
        Tue, 22 Jul 2025 13:04:26 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:dc5b:95ce:a23a:f169])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7195310af7esm25635987b3.15.2025.07.22.13.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 13:04:25 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org,
	amarkuze@redhat.com
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [PATCH v2] ceph: cleanup of processing ci->i_ceph_flags bits in caps.c
Date: Tue, 22 Jul 2025 13:04:12 -0700
Message-ID: <20250722200412.1019621-1-slava@dubeyko.com>
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

[1] https://scan5.scan.coverity.com/#/project-view/64304/10063?selectedIssue=1590633

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 fs/ceph/caps.c  | 132 +++++++++++++++++++++++++++++++++++++-----------
 fs/ceph/super.h |  45 +++++++++++------
 2 files changed, 132 insertions(+), 45 deletions(-)

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
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index bb0db0cc8003..7e40dff6ebe7 100644
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
+#define CEPH_I_ASYNC_CHECK_CAPS_BIT	(14) /* check caps immediately after async creating finishes */
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
-- 
2.50.1


