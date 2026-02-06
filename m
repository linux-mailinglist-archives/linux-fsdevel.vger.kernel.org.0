Return-Path: <linux-fsdevel+bounces-76632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDwbHK47hmnzLAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 20:06:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC561026C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 20:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F101230234CB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 19:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0244A42884E;
	Fri,  6 Feb 2026 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XE7/SLuq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C81F42883D
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 19:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770404772; cv=none; b=jRLO0YnIpyEaTNP5QUUJMzBPp86isjvUeA9dR3GX6IMTSoQHyAurnBRc5k81C1vnwxXxqVwxu4LGKsf9n4axZc3NttaC30SjbklqUmwmpPZGRf/Zli0mfZ3wOyef4uisYR+b/O5mAE8dUSdAQI2KbCqveXVIpO6isSUmXyWb74g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770404772; c=relaxed/simple;
	bh=Q9dm8LTnk+DFIEJAAB7tpFWixf8EizWYmak8EK7I1tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YzPExHB8Swq9GOkqLID6hCCYPfwRKPuNRE9D1/OWKRGX0UqW4g4Uqr3in4cbdo9bRylLuNzDbb3y3av78EOGwe4qTTBmmjLeKWDTwTmlO75tbCRULeyisWBtAS8cO7KSbjIHZU1RwRasEKHms0/NUvBNiVDmbfZHisuhDxZ6j3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XE7/SLuq; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82318b640beso1389898b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Feb 2026 11:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770404772; x=1771009572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4HfR25bhfBsIe8RbNyIL8PstGgybd8nsB9r91rb4k4=;
        b=XE7/SLuq8Z9OERS/Wo5Jgg2cOEndOZCIoJ+sj4JrT0fU118PKSPas7Jt68pvhd9AVr
         lcd4QwsGhdyjwRUrFuJ8IvJ8o75vsp6PI2CrcCN87fgmB7c9BdTWwrkJBcYfP1tR5kwi
         5Gw/fdDH4n5whN690UkPgqBwVVigku+J43d0UKVtROtcWo1RHVa8n/tE+EfTlc+NdQBn
         OeHAL9rjmMrexTwLeMlOs7v69S7AZeGw/zCoOVJa+X7p2+GUpImhIQMiBrJMCAU7rSWA
         Js+wqcS1+kHqe5UvIrnfJ9v/GKxp1i73mVrP8dEwILphpw/EMb9ISYY3X5Y+N7LIIGYs
         icig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770404772; x=1771009572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q4HfR25bhfBsIe8RbNyIL8PstGgybd8nsB9r91rb4k4=;
        b=S3GMtCVLLGOb800hQSYrYctezBo4W8juvWNAh69Anm0ZQbVzGVBvHwp5nlCFiGbXxO
         qlnmqPKDRKGF2plJb6lQpOhWy0s8VuRApNifUyxs42qYaD6cMHJi7pIF46PzpIoIWNgS
         pdEpGV+yvScVpHkgLffmNqllr1t5RqeBGyHt2Bdz7IOI2Ld0j/LEk12zK+KVJqAgYzrF
         RjPkyvEpwdk4qDB+ieYvmg8JaoqgDofUy5B1xadyg5Aa94Xvdbm3gob0RPf+PIgfIRhG
         b5FYlv9J1giiDaR2U9KNQHNjstKHPgyZg7cHdsXrcU96zu4CBljCHHfxcYUcdg9I4FG1
         nbYA==
X-Gm-Message-State: AOJu0YxyEuAB846S5PB0IMEuTDppA6zUFMr/AfcJb43UPf8mCZfhh6Y4
	wVFcwG/UqAuMBcL9RNPPlD2P0ECmaExT3lhCul/eezODz7xohl3HkIzMHtQSOQ==
X-Gm-Gg: AZuq6aJPZivUOniAsWho0oYqajCJ1doDVQ4+d9o+odeuEexZdh+uB2ua2DUQdrqhD5E
	i9mqOv7jg2xoGHFG5Er0KBeOd/m5Svlw0YA2R3eZq8MtWE0k1wBGbMove4Ua9i9h4//M/UfVG2y
	T0bFzBiY3MsllrjZqYr0X42UvZ9t1I1OQr6eIX2jJEni2yHEhMEh501G/rXcGslwkEtVoXb6evZ
	VXGvN8Y0Ngi0WWN+9Y0QawSw1vlO0t5MUV6NVPDjHpbzcr94+KLz8/2cHOOqAQzRUEYi5gO3PhC
	xj405r/hWxHmCYelwHgb5pHp0zHYpzLLVDhDxZks1kHdQDm4rxwOzP5T5Dde8N9Xa4WXk+Lx1Sy
	YzgaFQB1ZIAzOs9WcgtOqFcrymon5es2fOSQ/Hl59iMPMmOyaPDM/2cj6WMxXdXrR75GgPxoJr3
	tmZUpJW/GTureWy4QFrbRbm2y2LZtqyU+I3ThsQnwKqQI=
X-Received: by 2002:a05:6a00:1941:b0:823:edf:9811 with SMTP id d2e1a72fcca58-82441631058mr3456881b3a.18.1770404771634;
        Fri, 06 Feb 2026 11:06:11 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418a70fesm2910894b3a.45.2026.02.06.11.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 11:06:11 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de,
	adilger@dilger.ca,
	mjguzik@gmail.com,
	smfrench@gmail.com
Subject: [PATCH v4 3/4] sparc/fcntl.h: convert O_* flag macros from hex to octal
Date: Sat,  7 Feb 2026 01:03:38 +0600
Message-ID: <20260206190536.57289-4-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206190536.57289-1-dorjoychy111@gmail.com>
References: <20260206190536.57289-1-dorjoychy111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76632-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DBC561026C2
X-Rspamd-Action: no action

Following the convention in include/uapi/asm-generic/fcntl.h and other
architecture specific arch/*/include/uapi/asm/fcntl.h files.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 arch/sparc/include/uapi/asm/fcntl.h | 36 ++++++++++++++---------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/include/uapi/asm/fcntl.h
index bb6e9fa94bc9..33ce58ec57f6 100644
--- a/arch/sparc/include/uapi/asm/fcntl.h
+++ b/arch/sparc/include/uapi/asm/fcntl.h
@@ -2,23 +2,23 @@
 #ifndef _SPARC_FCNTL_H
 #define _SPARC_FCNTL_H
 
-#define O_APPEND	0x0008
-#define FASYNC		0x0040	/* fcntl, for BSD compatibility */
-#define O_CREAT		0x0200	/* not fcntl */
-#define O_TRUNC		0x0400	/* not fcntl */
-#define O_EXCL		0x0800	/* not fcntl */
-#define O_DSYNC		0x2000	/* used to be O_SYNC, see below */
-#define O_NONBLOCK	0x4000
+#define O_APPEND	0000000010
+#define FASYNC		0000000100	/* fcntl, for BSD compatibility */
+#define O_CREAT		0000001000	/* not fcntl */
+#define O_TRUNC		0000002000	/* not fcntl */
+#define O_EXCL		0000004000	/* not fcntl */
+#define O_DSYNC		0000020000	/* used to be O_SYNC, see below */
+#define O_NONBLOCK	0000040000
 #if defined(__sparc__) && defined(__arch64__)
-#define O_NDELAY	0x0004
+#define O_NDELAY	0000000004
 #else
-#define O_NDELAY	(0x0004 | O_NONBLOCK)
+#define O_NDELAY	(0000000004 | O_NONBLOCK)
 #endif
-#define O_NOCTTY	0x8000	/* not fcntl */
-#define O_LARGEFILE	0x40000
-#define O_DIRECT        0x100000 /* direct disk access hint */
-#define O_NOATIME	0x200000
-#define O_CLOEXEC	0x400000
+#define O_NOCTTY	0000100000	/* not fcntl */
+#define O_LARGEFILE	0001000000
+#define O_DIRECT        0004000000 /* direct disk access hint */
+#define O_NOATIME	0010000000
+#define O_CLOEXEC	0020000000
 /*
  * Before Linux 2.6.33 only O_DSYNC semantics were implemented, but using
  * the O_SYNC flag.  We continue to use the existing numerical value
@@ -32,12 +32,12 @@
  *
  * Note: __O_SYNC must never be used directly.
  */
-#define __O_SYNC	0x800000
+#define __O_SYNC	0040000000
 #define O_SYNC		(__O_SYNC|O_DSYNC)
 
-#define O_PATH		0x1000000
-#define __O_TMPFILE	0x2000000
-#define OPENAT2_REGULAR	0x4000000
+#define O_PATH		0100000000
+#define __O_TMPFILE	0200000000
+#define OPENAT2_REGULAR	0400000000
 
 #define F_GETOWN	5	/*  for sockets. */
 #define F_SETOWN	6	/*  for sockets. */
-- 
2.53.0


