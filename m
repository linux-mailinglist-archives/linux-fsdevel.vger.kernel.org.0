Return-Path: <linux-fsdevel+bounces-75636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOOFFUb+eGmOuQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 19:04:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C6098C20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 19:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4821B30A4CA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 18:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0943112D5;
	Tue, 27 Jan 2026 18:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/MzFsHH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFBD2F5491
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 18:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536913; cv=none; b=sokuOiBquhN/hnmcvCjrTBLsForyxsIMLYuOrYjd5c+p4l/UK8cMpe4qVvAUzFyuLREsJ+sbSFtX6Z9vIiF1ecDvv6zYo3/8nAySfCf2HS1lZh55IopiyItBifFAamzCAaFj3nRQLd0SR5j/yaK/aVjrowTXb7hgrGwhDLOHdoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536913; c=relaxed/simple;
	bh=eEVLpo0/xWWCNyXB2qN7+LU2JrOD+X8cK85rNuw9cR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofJosJkivniS2vTXDxB33heXnPfwuq0p2smFwvD6HrehHEoNUuHyyvTidoRmLvBdoE2IIQW9xMOrVAr2tndgzgBNCm6K2yhlWr//GirHXlOw9QXIYKHHPFbXABCtjalfdO7N+VUOnycX2GjU1NaWnqtEeGPx/7DSSR71QEciwXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/MzFsHH; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-81dbc0a99d2so3013101b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 10:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769536910; x=1770141710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKA6NqBZUbRPPOHudTEbZyIDBpxMfrFTaNpZfF3CE7Q=;
        b=P/MzFsHHqreK0DAFO//Y9yrBBaff1a1H8bbh+BHLayw9RDEEoylv5ID+uCl7G9AkCn
         WYcHtUZE4tLI6JfxzwvaM7V+Au/rLfKFGTXqviTW2hew83KxOJM2t6aUW9Ev6Ovs+oF3
         Iot9bQDVpDa61AhraTXpoqklFT7+iodH8WIxiyTd4Z8QIVNy88UEsH9GTOXwYu/AmHyM
         8mOkGDLEY+hrvBkJWGV2DtwspEx1vM8SN7MGIO2WDPPyC/2LkEqNFeE1aXutroa1YbzZ
         0w4408c3FlcY7l1KeMYJ726cIFr9aj9wMenuEQRSnvVuYE4C3SYcUm++zmGmjmk5vBZB
         tL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769536910; x=1770141710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xKA6NqBZUbRPPOHudTEbZyIDBpxMfrFTaNpZfF3CE7Q=;
        b=cpqXycyNqvlLvkwprm2fCpqoiuHtK/02hVrV/tsKzImZPKfnqfa0+pWEkqwhGl8oN2
         ot70Oc9/fsos68D2orMV3xLpe2GPHHRYvrZ/cWeUdejbrEa480zUBJ9MczWr+dgAk1vl
         utHQ0f3SigLUWar1JLWo2YBgnqDi+A7oVYK6b0cMTbYkRTZ10VpcM8JQyrn+rtE0X0/s
         y64j0iFU3VXUU6m+fuf87LAtMSfp0dgzvMcr2xEcEUYEU15TLLAi8i2Oi4ulAgyTVzmb
         HXGC+Y1p+xxjQ/xAAcacy+znCkvzh7v1U7Fh/sxr4phLLUSkN68P3AFazf3yL1NRJ2Oj
         Nhuw==
X-Gm-Message-State: AOJu0YzRxj4XXmD4saoKuLsi35imnScN6pY4de0z/RfLLpblaMjxM+10
	188nSEVqFQU2soV/XnxQI+CQGtAXzMVQ6t8ZX8gWwo41QM+hBv8SiDN6xL154w==
X-Gm-Gg: AZuq6aIOSoYS1m6t3x7HJ/g4xzdz8YnGRv8+Lr68LZ8/fnZAt/EctzbEOTdqfV+WtXa
	Z+AHxycIvQg+FxRpCZqXws4j2QhUfMRbLgt0axGpRTk3X+6et498usJTsNe2ahASwJXHTVd6iq1
	02Jdj5h+qoaYQN2TPigXyxRW3tPa7a62gKkE1gp1bopmbHBH/2M4/ud3zIb7UW82wpjJhhVzYKy
	s97yH5kwiQ4ZyZuFhMdYow822if/gAyCiyDuGw2Pqu8b7T2itHe+gJQFtZQTdq+VuP68nJkaAdC
	SLeowAM6X80X4GR5Zxhuu17vt23s52eRkXXS8A52znGepyudqgxnPYXnuVp4vyS0spEeGNVqHIy
	KjZ5DTSF0U4izJub9E/HEqvo8qfMxENivMzPOJV1FgNlDRTug+vGSSt2akv8U2hxE5PAmu4G67b
	J+bcdVzOf/WE/GiQBq70+S73dCAoYce/6ta3go5v3L4Ko=
X-Received: by 2002:a05:6a00:800d:b0:81f:3d13:e07b with SMTP id d2e1a72fcca58-823692a0fe5mr2211061b3a.43.1769536909590;
        Tue, 27 Jan 2026 10:01:49 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b1bc68sm216891b3a.2.2026.01.27.10.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:01:49 -0800 (PST)
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
	adilger@dilger.ca
Subject: [PATCH v3 4/4] mips/fcntl.h: convert O_* flag macros from hex to octal
Date: Tue, 27 Jan 2026 23:58:20 +0600
Message-ID: <20260127180109.66691-5-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127180109.66691-1-dorjoychy111@gmail.com>
References: <20260127180109.66691-1-dorjoychy111@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75636-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A5C6098C20
X-Rspamd-Action: no action

Following the convention in include/uapi/asm-generic/fcntl.h and other
architecture specific arch/*/include/uapi/asm/fcntl.h files.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 arch/mips/include/uapi/asm/fcntl.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/mips/include/uapi/asm/fcntl.h b/arch/mips/include/uapi/asm/fcntl.h
index 0369a38e3d4f..6aa3f49df17e 100644
--- a/arch/mips/include/uapi/asm/fcntl.h
+++ b/arch/mips/include/uapi/asm/fcntl.h
@@ -11,15 +11,15 @@
 
 #include <asm/sgidefs.h>
 
-#define O_APPEND	0x0008
-#define O_DSYNC		0x0010	/* used to be O_SYNC, see below */
-#define O_NONBLOCK	0x0080
-#define O_CREAT		0x0100	/* not fcntl */
-#define O_TRUNC		0x0200	/* not fcntl */
-#define O_EXCL		0x0400	/* not fcntl */
-#define O_NOCTTY	0x0800	/* not fcntl */
-#define FASYNC		0x1000	/* fcntl, for BSD compatibility */
-#define O_LARGEFILE	0x2000	/* allow large file opens */
+#define O_APPEND	0000010
+#define O_DSYNC		0000020	/* used to be O_SYNC, see below */
+#define O_NONBLOCK	0000200
+#define O_CREAT		0000400	/* not fcntl */
+#define O_TRUNC		0001000	/* not fcntl */
+#define O_EXCL		0002000	/* not fcntl */
+#define O_NOCTTY	0004000	/* not fcntl */
+#define FASYNC		0010000	/* fcntl, for BSD compatibility */
+#define O_LARGEFILE	0020000	/* allow large file opens */
 /*
  * Before Linux 2.6.33 only O_DSYNC semantics were implemented, but using
  * the O_SYNC flag.  We continue to use the existing numerical value
@@ -33,9 +33,9 @@
  *
  * Note: __O_SYNC must never be used directly.
  */
-#define __O_SYNC	0x4000
+#define __O_SYNC	0040000
 #define O_SYNC		(__O_SYNC|O_DSYNC)
-#define O_DIRECT	0x8000	/* direct disk access hint */
+#define O_DIRECT	0100000	/* direct disk access hint */
 
 #define F_GETLK		14
 #define F_SETLK		6
-- 
2.52.0


