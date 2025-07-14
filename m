Return-Path: <linux-fsdevel+bounces-54893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4D7B049B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 23:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26C0D3B838A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 21:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC4C26A08D;
	Mon, 14 Jul 2025 21:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="jVeHQ1wj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCC3194A60
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 21:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752529665; cv=none; b=HFhpnRz29gHdynpT67dZgEV5C8rqRccwqo4pWMrvIkNRKMGuHmVjIilmOaTxNXZSZ+Ynlw+/pEPEU/J6l8Q7avXIelzzsdSvZ4HaOEtOsca7SCkhf8ZH3pN33gcqRROP7gyT7toSkFVfuO4srLnWUnikWWS/FU7gFs8ACL96gBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752529665; c=relaxed/simple;
	bh=h3SZ8Yp5NeHUkPOaTNmfQg2HRShSkFSZ+BV9YZ86jm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BKdwtjiWdBclwvcwJv86rzERhEyCRhwEYa8QSDRS/ijQvK/TG7tOigBa5xxpWHUZSiocXQ/TTVL/j35PmoxDx+ibyOWneq+l6Ky/e4vUs+Uy1R06ctn7/g58VUhtkXjekGy5wuPf/iSPMgqUOdy3C944eqsqOTxkqwHkxxE3MkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=jVeHQ1wj; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-70a57a8ffc3so45849597b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 14:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1752529660; x=1753134460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LQFXAKg1wXZa5rKcVsa1NQNG+NeBhOy+TGnjxAdiVIM=;
        b=jVeHQ1wjGwt8vpwy2FCz8Nd0TEe26eEKLMfc5pwHsQPjPVDqUib6dATIydZQKcVFBh
         fxrYq59APXZIzv+16FlpALB7d/JfLMLRGX+Y7kBm/hJz8pDBjqHBD9E0Xdh5GE0wlDNE
         71VhBg5ISLZ61pSZgL3E5N4LPZZMarmjbBYQGZUTVbM/5kWocjvepV0Fr2aNjw3HVMBP
         xu2N0cJBIlxxkarrVEBPVvunIh/PU0Mm1cfw1k1UY2SLqLcGoH66e4xwxkBJdsOsIK2A
         L3rCWffnFL7V+mCjo+FLmOOdknuxxt6x5ymPOCk1HxA2QaFBLSFjI8fhw6XSZqA3YMEA
         FeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752529660; x=1753134460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQFXAKg1wXZa5rKcVsa1NQNG+NeBhOy+TGnjxAdiVIM=;
        b=D/XhhnmJr2xZtgUMUnXkmbOWJwzFn8c/DhcCPna74YUZQb7RL++BHEPLZtsb2vaRM2
         u86VUfE4BVi0NF2WhIQgrwKwrXedmSOtnBenvVsYcJjShngVkbrwV1fcn5PHUs9c3ykN
         NQNTdAWMnTL1vOCaG2VSDqkTXCCZflsPssYdt4gPuhmOCYj0EZgzrGdPFZAJcewlWh6y
         gfjUr5EJQ2XgPEMcOOFO0tp1AZ5BFSPdyxUjlqRep/vRbQhKg5KhqOre9KmO4bequnex
         g3/XQg9xJapqq2nnIjEG6L9+p0uHWqqGGEZPdUrz6rvBRYmDU/oQh+6VieTUEVHETAjt
         PNuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE8Ay1a3PEVMN0CfhU1g/RA4GORxeZEnxLzXTjqIYSmaHbVmYLFhD8ahgZ6xuezxmNs60axUgKZ29hnuep@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg054cqNDxImyMql0nvY8SaiirxHgHQOfHJYrIzGuLNLKk6PSQ
	2jCGBKJQz9ww6wbg5DgQQKh/Wp5JJ+/s2MQyZzpCN5seYEecj911IKDsNl4WotIq588=
X-Gm-Gg: ASbGncvj5xIQUKq17sCEpgeOOzTHNvW8KXBNFmAzxZO4nCpIBPW4YDe2hqNIKqFU7ER
	FlVaFeqcBXu2Kix7na/pZ4yBfM8bOjs+j/RyzMq6t2VBG1foHoXKw786glOaYwPVtNt4PxSJiUB
	HfHVqPVH1VUMBJ09GPp9chIHUT/pGiG/YAMwl3P3FvfYl9xw9UL5E/WBe58gFYc6eKTO1+EuVjB
	b7aRJyhMy78jbXEcj+k23ORgKXSpzVTA7I+78U5nV3xiD1GA81YseJOuutDdIG1n83tZlMoCicT
	EpQcA/RIjtE7ai/kjDmpgSHQVzs3PG5SWgdfT14iHuVLEpUbei6ZbDm7NXzeYRYYt7kdF+sz6/4
	NJkxMBUg0nrOOve11V6QjZwlgFUhpkcbcgqsZAqH2
X-Google-Smtp-Source: AGHT+IGuh6O9oC9UQEQNHHd0gj85nSUNTITBk9q/ljdvHr/ogOTW+FNlfLV1HjDX5CjfeJvZS8YXVg==
X-Received: by 2002:a05:690c:350e:b0:70e:7a67:b4b5 with SMTP id 00721157ae682-717d5dc7ca9mr210629277b3.22.1752529660312;
        Mon, 14 Jul 2025 14:47:40 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:ffc5:c11b:37c7:4909])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c61eb7f3sm21346397b3.98.2025.07.14.14.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 14:47:39 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [PATCH] ceph: fix potentail race condition of operations with CEPH_I_ODIRECT flag
Date: Mon, 14 Jul 2025 14:47:19 -0700
Message-ID: <20250714214719.589469-1-slava@dubeyko.com>
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
race conditions in ceph_block_o_direct(), ceph_start_io_read(),
ceph_block_buffered(), and ceph_start_io_direct() [1 - 4].

The CID 1590942, 1590665, 1589664, 1590377 contain explanation:
"The value of the shared data will be determined by
the interleaving of thread execution. Thread shared data is accessed
without holding an appropriate lock, possibly causing
a race condition (CWE-366)".

This patch reworks the pattern of accessing/modification of
CEPH_I_ODIRECT flag by means of adding smp_mb__before_atomic()
before reading the status of CEPH_I_ODIRECT flag and
smp_mb__after_atomic() after clearing set/clear this flag.
Also, it was reworked the pattern of using of ci->i_ceph_lock
in ceph_block_o_direct(), ceph_start_io_read(),
ceph_block_buffered(), and ceph_start_io_direct() methods.

[1] https://scan5.scan.coverity.com/#/project-view/64304/10063?selectedIssue=1590942
[2] https://scan5.scan.coverity.com/#/project-view/64304/10063?selectedIssue=1590665
[3] https://scan5.scan.coverity.com/#/project-view/64304/10063?selectedIssue=1589664
[4] https://scan5.scan.coverity.com/#/project-view/64304/10063?selectedIssue=1590377

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 fs/ceph/io.c    | 53 +++++++++++++++++++++++++++++++++++++++----------
 fs/ceph/super.h |  3 ++-
 2 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/fs/ceph/io.c b/fs/ceph/io.c
index c456509b31c3..91b73052d708 100644
--- a/fs/ceph/io.c
+++ b/fs/ceph/io.c
@@ -21,14 +21,23 @@
 /* Call with exclusively locked inode->i_rwsem */
 static void ceph_block_o_direct(struct ceph_inode_info *ci, struct inode *inode)
 {
+	bool is_odirect;
+
 	lockdep_assert_held_write(&inode->i_rwsem);
 
-	if (READ_ONCE(ci->i_ceph_flags) & CEPH_I_ODIRECT) {
-		spin_lock(&ci->i_ceph_lock);
-		ci->i_ceph_flags &= ~CEPH_I_ODIRECT;
-		spin_unlock(&ci->i_ceph_lock);
-		inode_dio_wait(inode);
+	spin_lock(&ci->i_ceph_lock);
+	/* ensure that bit state is consistent */
+	smp_mb__before_atomic();
+	is_odirect = READ_ONCE(ci->i_ceph_flags) & CEPH_I_ODIRECT;
+	if (is_odirect) {
+		clear_bit(CEPH_I_ODIRECT_BIT, &ci->i_ceph_flags);
+		/* ensure modified bit is visible */
+		smp_mb__after_atomic();
 	}
+	spin_unlock(&ci->i_ceph_lock);
+
+	if (is_odirect)
+		inode_dio_wait(inode);
 }
 
 /**
@@ -51,10 +60,16 @@ void
 ceph_start_io_read(struct inode *inode)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	bool is_odirect;
 
 	/* Be an optimist! */
 	down_read(&inode->i_rwsem);
-	if (!(READ_ONCE(ci->i_ceph_flags) & CEPH_I_ODIRECT))
+	spin_lock(&ci->i_ceph_lock);
+	/* ensure that bit state is consistent */
+	smp_mb__before_atomic();
+	is_odirect = READ_ONCE(ci->i_ceph_flags) & CEPH_I_ODIRECT;
+	spin_unlock(&ci->i_ceph_lock);
+	if (!is_odirect)
 		return;
 	up_read(&inode->i_rwsem);
 	/* Slow path.... */
@@ -106,12 +121,22 @@ ceph_end_io_write(struct inode *inode)
 /* Call with exclusively locked inode->i_rwsem */
 static void ceph_block_buffered(struct ceph_inode_info *ci, struct inode *inode)
 {
+	bool is_odirect;
+
 	lockdep_assert_held_write(&inode->i_rwsem);
 
-	if (!(READ_ONCE(ci->i_ceph_flags) & CEPH_I_ODIRECT)) {
-		spin_lock(&ci->i_ceph_lock);
-		ci->i_ceph_flags |= CEPH_I_ODIRECT;
-		spin_unlock(&ci->i_ceph_lock);
+	spin_lock(&ci->i_ceph_lock);
+	/* ensure that bit state is consistent */
+	smp_mb__before_atomic();
+	is_odirect = READ_ONCE(ci->i_ceph_flags) & CEPH_I_ODIRECT;
+	if (!is_odirect) {
+		set_bit(CEPH_I_ODIRECT_BIT, &ci->i_ceph_flags);
+		/* ensure modified bit is visible */
+		smp_mb__after_atomic();
+	}
+	spin_unlock(&ci->i_ceph_lock);
+
+	if (!is_odirect) {
 		/* FIXME: unmap_mapping_range? */
 		filemap_write_and_wait(inode->i_mapping);
 	}
@@ -137,10 +162,16 @@ void
 ceph_start_io_direct(struct inode *inode)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	bool is_odirect;
 
 	/* Be an optimist! */
 	down_read(&inode->i_rwsem);
-	if (READ_ONCE(ci->i_ceph_flags) & CEPH_I_ODIRECT)
+	spin_lock(&ci->i_ceph_lock);
+	/* ensure that bit state is consistent */
+	smp_mb__before_atomic();
+	is_odirect = READ_ONCE(ci->i_ceph_flags) & CEPH_I_ODIRECT;
+	spin_unlock(&ci->i_ceph_lock);
+	if (is_odirect)
 		return;
 	up_read(&inode->i_rwsem);
 	/* Slow path.... */
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index bb0db0cc8003..969212637c5b 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -638,7 +638,8 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
 #define CEPH_I_FLUSH_SNAPS	(1 << 8)  /* need flush snapss */
 #define CEPH_I_ERROR_WRITE	(1 << 9) /* have seen write errors */
 #define CEPH_I_ERROR_FILELOCK	(1 << 10) /* have seen file lock errors */
-#define CEPH_I_ODIRECT		(1 << 11) /* inode in direct I/O mode */
+#define CEPH_I_ODIRECT_BIT	(11) /* inode in direct I/O mode */
+#define CEPH_I_ODIRECT		(1 << CEPH_I_ODIRECT_BIT)
 #define CEPH_ASYNC_CREATE_BIT	(12)	  /* async create in flight for this */
 #define CEPH_I_ASYNC_CREATE	(1 << CEPH_ASYNC_CREATE_BIT)
 #define CEPH_I_SHUTDOWN		(1 << 13) /* inode is no longer usable */
-- 
2.49.0


