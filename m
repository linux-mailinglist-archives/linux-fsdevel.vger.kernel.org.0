Return-Path: <linux-fsdevel+bounces-78371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDhDEU7ynmnoXwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 13:59:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0ED5197BAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 13:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96F2D30A5EB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 12:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738103ACEF9;
	Wed, 25 Feb 2026 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgYqMpxe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOZ5ETNM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1173AE6FB
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772024358; cv=none; b=SXnmr79Y0o8dkPrA9h0mMM47cYFqBDmtQ0HcLr3PbVetlGG2+uwxfU7Iyw2FOamNzhhtXu8ru528j304XM3b9agDwdrNbQqcMSLdNr7AItuqIx9Inag1lBCEvWQuO0O/XT7LF3gDJ5oSeAzMwmHrdBPQEQzss//Uej4zxFcaDTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772024358; c=relaxed/simple;
	bh=TNbFd2qyNk9Pt0ydHglMYbusemEGazuAFqUDQyoUgeA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hrXKbPA81xXqLtMh/HsSudqylRGYqgTJ4LQw7wmbzhx14mNGbrN3ljSqyjkUgwnrZq4d4RAhgZuAl+EWUQg1dQlF+zU6ZFbIXhnRyuguvfzvJzPrNPmupDiCKbgf+Q1EyN6hIKGFgBT8cphJ7Ly+7FsJCRZ7uxnjayz0L1FU27A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HgYqMpxe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BOZ5ETNM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772024355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fimZdB21rJ1E1Fgh+/XpYitrzlTwFolfvXrZOvlZ89s=;
	b=HgYqMpxeWS3qkp1I2jhfrSiNbnWLREgfQ8d1jHhG/H5ic1G+omD1AN+MJfSuPnU/6aemsy
	XY2+e4MaUAlYeIUlRhOClVPkAUB+8ngpZ/E59MGvdX1KkNCRQgw9etfWXG89oP5Hq2+RK6
	M0IOQKXP6lToIrxSZ3e2AG1wVunZV28=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-Rl419iKZPMCDWcO-oG7wTA-1; Wed, 25 Feb 2026 07:59:14 -0500
X-MC-Unique: Rl419iKZPMCDWcO-oG7wTA-1
X-Mimecast-MFC-AGG-ID: Rl419iKZPMCDWcO-oG7wTA_1772024354
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb52a9c0eeso1723372785a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 04:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772024354; x=1772629154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fimZdB21rJ1E1Fgh+/XpYitrzlTwFolfvXrZOvlZ89s=;
        b=BOZ5ETNMTkAztJXWAqYftcWjTJjevSqB2XGr9JgsODT9g29ZUMH10mlF+AHla/Ymn7
         ffwsi1wbiR0NTE7AVNOKUZD0WWTrGrMTxsGtBEdDDExWFoBSGNY58fnEUN9eBuja4m4t
         40mKWqXwH82GFsOB0bYhcW/p4I6cm0Yo8ems9d6/ivtEnElURjZ9G6BW35QP+F/oCuld
         A7oI76OiE7kj56ffe7LhnAunKwnu8cDbTIEXl0bUNQp9e9J7Vb6wx4LnQky+K2/q0IuF
         Y02LBO3gKFJ30j2VQotlHv55o3TFg3uljlQCa6zFMJB+f4J9FRQ4dnOnmjtccjoLVcL2
         V4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772024354; x=1772629154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fimZdB21rJ1E1Fgh+/XpYitrzlTwFolfvXrZOvlZ89s=;
        b=YBELn0jUokHgoOHWP7eq7sFFmNAjiSmA478xrwQrNo+RJ0F03U6KjM8RRaaEmo4oec
         aj3JILLY+71R+J0SYc1gY2E7Z3hTo9tundxeGfZmFqQflHuVQKtjKU66KQ55S7xRxQPM
         HqrCaBELBDVj7N0okIl5T3M/l01yOd5Uk3Zk7SVgmwyZfMGANkn7WWCIcIl3jHs+ydy3
         n6liy0hSl8iH+3PiwzZ8R79SkRirbEEtOGmGkHKJLO4ZjbK60DGh9LfgNyXENfelFwGD
         Q3dgPXJ/mate+foEI31vvEHlF5aUUefUCmbPjFtLbvWdJmNxSUNi9YchzcD0U+Tf0dPd
         i7+g==
X-Forwarded-Encrypted: i=1; AJvYcCXNtitiArCdETjd8P+p2HbLsWjLQ7H82yf8+Rtx71AIw3zBZikabqHvaBwBJ2jP9pTo9IvVFRBYZF3HSUDe@vger.kernel.org
X-Gm-Message-State: AOJu0YwdtZHhnWzSubTS2Krpl3z3n+9zX6jwWdiKHScpwPSyKHXnc3Z0
	OKSImqz09ONckTFO5/Mg/iBfJ7t74pAEYgQWyz3QgsvAOQ087cF5VUwcYV2QcaajLZ+r6lAac1h
	+ma/x1aAixk58e6raBH/nap+gxWALu2LsFRYlDfnc186nW5kYzX3T44UlWtSnCFjh9KY=
X-Gm-Gg: ATEYQzxMo3H3AyP0j38CDjnZ54DomdeXoUDNRaed7bPtDpzrGw1PKnR3NqopHvjq8jm
	l2shuXJAgh2RBVCZ/8SOKyvh8aiosxSGZVXgtei7aThhkjgBdOrvWK+Yld84mOPNslQJRnkGm/d
	+H6gsgdCRbo0fdGaJRvRf+1X2TFaWkAXk/1GHn4rMc8nbN6Qd6D6K62HKjh9MpJX74cSAR4g/Xc
	nXkTHl5k4FC7UiVeCCxCKVLKu6ryJ1uq8Nx2hqnbCBsiNPcSL7YzjuRyeX02FhlkwhuRjtuT3Jl
	+IoYHprUWzWdR6LjpA4nOSXTVfS3YyKw4ORTwLgXH0XHEi1dGNp6hckD4jl2wc9mvcyFcXitN+8
	O9XaGzSfQFIG5J2FdGvA2hRBvr4jp+GhOhYCmbpkLvKVFKyoiS98vTMg=
X-Received: by 2002:a05:620a:4110:b0:8cb:72b2:2a15 with SMTP id af79cd13be357-8cbbcf811a0mr42606485a.33.1772024353875;
        Wed, 25 Feb 2026 04:59:13 -0800 (PST)
X-Received: by 2002:a05:620a:4110:b0:8cb:72b2:2a15 with SMTP id af79cd13be357-8cbbcf811a0mr42604385a.33.1772024353421;
        Wed, 25 Feb 2026 04:59:13 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d046055sm1514219685a.8.2026.02.25.04.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 04:59:13 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [RFC PATCH v1 1/4] ceph: convert inode flags to named bit positions
Date: Wed, 25 Feb 2026 12:59:04 +0000
Message-Id: <20260225125907.53851-2-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225125907.53851-1-amarkuze@redhat.com>
References: <20260225125907.53851-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78371-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,redhat.com];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[amarkuze@redhat.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E0ED5197BAD
X-Rspamd-Action: no action

Define all CEPH_I_* flags as named bit positions with derived
bitmask values, making them usable with test_bit/set_bit/clear_bit.
Previously only CEPH_I_ODIRECT_BIT and CEPH_ASYNC_CREATE_BIT had
named bit positions; the rest were bare bitmask constants.

Convert CEPH_I_ERROR_WRITE and CEPH_I_ERROR_FILELOCK usage sites
to use atomic bit operations (test_bit, set_bit, clear_bit) via
the new _BIT constants.

This is preparation for the client reset feature which needs
test_bit() on CEPH_I_ERROR_FILELOCK_BIT in reconnect paths.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/locks.c      |  8 +++----
 fs/ceph/mds_client.c |  3 ++-
 fs/ceph/super.h      | 54 +++++++++++++++++++++++++++-----------------
 3 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index dd764f9c64b9..2f21574dfb99 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -58,7 +58,7 @@ static void ceph_fl_release_lock(struct file_lock *fl)
 	if (atomic_dec_and_test(&ci->i_filelock_ref)) {
 		/* clear error when all locks are released */
 		spin_lock(&ci->i_ceph_lock);
-		ci->i_ceph_flags &= ~CEPH_I_ERROR_FILELOCK;
+		clear_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags);
 		spin_unlock(&ci->i_ceph_lock);
 	}
 	fl->fl_u.ceph.inode = NULL;
@@ -272,9 +272,8 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 		wait = 1;
 
 	spin_lock(&ci->i_ceph_lock);
-	if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
+	if (test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags))
 		err = -EIO;
-	}
 	spin_unlock(&ci->i_ceph_lock);
 	if (err < 0) {
 		if (op == CEPH_MDS_OP_SETFILELOCK && lock_is_unlock(fl))
@@ -332,9 +331,8 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 	doutc(cl, "fl_file: %p\n", fl->c.flc_file);
 
 	spin_lock(&ci->i_ceph_lock);
-	if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
+	if (test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags))
 		err = -EIO;
-	}
 	spin_unlock(&ci->i_ceph_lock);
 	if (err < 0) {
 		if (lock_is_unlock(fl))
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 23b6d00643c9..28bb27b09b40 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3610,7 +3610,8 @@ static void __do_request(struct ceph_mds_client *mdsc,
 
 		spin_lock(&ci->i_ceph_lock);
 		cap = ci->i_auth_cap;
-		if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE && mds != cap->mds) {
+		if (test_bit(CEPH_ASYNC_CREATE_BIT, &ci->i_ceph_flags) &&
+		    mds != cap->mds) {
 			doutc(cl, "session changed for auth cap %d -> %d\n",
 			      cap->session->s_mds, session->s_mds);
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 29a980e22dc2..69a71848240f 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -655,23 +655,35 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
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
-#define CEPH_I_ODIRECT_BIT	(11) /* inode in direct I/O mode */
-#define CEPH_I_ODIRECT		(1 << CEPH_I_ODIRECT_BIT)
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
@@ -691,18 +703,18 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
  */
 static inline void ceph_set_error_write(struct ceph_inode_info *ci)
 {
-	if (!(READ_ONCE(ci->i_ceph_flags) & CEPH_I_ERROR_WRITE)) {
+	if (!test_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags)) {
 		spin_lock(&ci->i_ceph_lock);
-		ci->i_ceph_flags |= CEPH_I_ERROR_WRITE;
+		set_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags);
 		spin_unlock(&ci->i_ceph_lock);
 	}
 }
 
 static inline void ceph_clear_error_write(struct ceph_inode_info *ci)
 {
-	if (READ_ONCE(ci->i_ceph_flags) & CEPH_I_ERROR_WRITE) {
+	if (test_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags)) {
 		spin_lock(&ci->i_ceph_lock);
-		ci->i_ceph_flags &= ~CEPH_I_ERROR_WRITE;
+		clear_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags);
 		spin_unlock(&ci->i_ceph_lock);
 	}
 }
-- 
2.34.1


