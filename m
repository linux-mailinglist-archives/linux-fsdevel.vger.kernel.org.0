Return-Path: <linux-fsdevel+bounces-75635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DKDJCH+eGmOuQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 19:04:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F82698C09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 19:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 408B43092AA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 18:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCED324B2D;
	Tue, 27 Jan 2026 18:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdmUOdvz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA802EC0AA
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 18:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536907; cv=none; b=I3+BLfMhm1OBBLISOH0c7id7/epa2PSD/CtmeSOItB4asFR4tz/xAJrTYhi0gzUSE53p6Sx7XWlSUIHikObpfDuYt5oIOvz5ZZGPy6mBiXxQ9pKM458vRcnIzWA3uHdiRmm5QCiCyB6ozc0COCmFZG7cE+Mcznkbc+i17ZEMfFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536907; c=relaxed/simple;
	bh=fGlXttV7nMmxi4UcuYtsCWFX6BEZWzCp9QY5mD62bk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2cUkqsANnn0s/YricUHOP12YlmF/dGhDcHAMGLsX8oIwJrU0qBJiVPkNT9ARqj3ORzTs/Ap9V3Nju5pUzWVCbyUs/ETB/9DU8tVbVsFCXcDqNlFlRld2gGpkJczY8Cj6mB2oktwn/KprMDYVYW6aLbFXCWTmJfI8jzwLbDwExM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdmUOdvz; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-81e8a9d521dso3534523b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 10:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769536905; x=1770141705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmJz7Q237YfPvUh8bIWiB/H6qzUCS1WcnX3PPdkuOR4=;
        b=FdmUOdvziWp418HeEvFVfEzMTpkFxR2S+LIgRIphNYI3rZI8Sd3S2+vgG6kzwnxi36
         I+x4lapqbn7+b8uUZ3jv+RleIdr4eZnQwMVBJPsS3nL3ja05nRRQosQSvooL9b2inxsd
         oRhIlgYQFnjczvsHGOCf9tPjPtz1Ap/cmD+xXgcCLvWnmdaflJj9snsuYUc7iEjp2sZk
         UfekmT8aQvPy+R2yhEjqh9PhFXTPBtVlu9JMoTmOaiO2vkWuUzO+jjkBeEMV4p3LraH2
         cAgQRR20BrZXIRUq6ggZbKx6l3I7h7vxdoCR+kGgCpqYcp90L7Mt8lU6mCKm7v9QFOjq
         qlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769536905; x=1770141705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fmJz7Q237YfPvUh8bIWiB/H6qzUCS1WcnX3PPdkuOR4=;
        b=YMDpP7Hbvxqt6lok/IIvgKap4utk5U2tFdL4IN+rAmmPHr9bHP4QbzR4Qi5VeqTNMw
         PPC25tvNGiCd+L7eEWRzjusjVz6fzugKCA1ULpamDmvctpPUbZIBqy5xm5A+/cHp8gDm
         39aSvGwf3iBzUPREdg8mgxW9Go3ma0Ol/RrTUiIlJZfqusY3K5ipOj0QU4ZlhlZZmuWI
         jYjNsmj/y5IOZ4IFTZqePva4RNjaR/Ug0/mgjbetpPO4VR3RxNgsp3jWpfMUQt/wMGBN
         m+jjaVg36cul+aqWP4DblhcYHW2TuhHzUrB/TxS4uhHkTj4vpjB4nw2Fc/wZzOVfH/Pw
         PfMg==
X-Gm-Message-State: AOJu0Yw0O+XdiIV5UahAIEgi1PTCC8YkHr1/7W6JfSTiKfKsBNgCF5qm
	RuAOR97I0jYuu4fQYcnhy6yQDXDufAmrNbwhiJfIRNzpjt61kRl08/7u/5/H6A==
X-Gm-Gg: AZuq6aJ+x1QQf43az2e8fQ0Fqkx35ccF85WD+4tcoMg3JFaSc0mkrJNKNc7qOkWEfMv
	VR49Pkiez3TAQfKwud7sN/zaws5evIXatSADY6pUXTtdUf1fEqLc57tDFCpS2pxlUvJYHCj1c5t
	rIGEeMfmilKylAvi01LSXldxIjaAs/DRyvLXnaEGjJf64rNm6zRRqsTTv7NVCLjbjE3p7SaaB5R
	ccg/VtFveHoL4oWU/Ivt7f2llAH6QhQxiikO/1yO1XNz63L3qVv7t0ZFITH7dVVSLy8XwsZO5nW
	tu37Q7nQQZ9kBHxP4xT7h/uUaUj9gv71eOgDpdLbYspaM+xPlRNNa2nu8et+9tldOcN/ZoWEegw
	4JasNzHoNg+Ji9gQxVVpjhNwtGCjekv2+fDmcABsNrRKbRZgp4jPk5lspWYGXjzlk8t24zbAltT
	sEmvJ3ac1WUUr50grHIRcpvv4qv9Ov7+jEoZjDt9W1+lk=
X-Received: by 2002:a05:6a00:bc83:b0:81f:4675:c2a5 with SMTP id d2e1a72fcca58-8236928e24dmr2648269b3a.32.1769536904802;
        Tue, 27 Jan 2026 10:01:44 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b1bc68sm216891b3a.2.2026.01.27.10.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:01:44 -0800 (PST)
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
Subject: [PATCH v3 3/4] sparc/fcntl.h: convert O_* flag macros from hex to octal
Date: Tue, 27 Jan 2026 23:58:19 +0600
Message-ID: <20260127180109.66691-4-dorjoychy111@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-75635-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 3F82698C09
X-Rspamd-Action: no action

Following the convention in include/uapi/asm-generic/fcntl.h and other
architecture specific arch/*/include/uapi/asm/fcntl.h files.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 arch/sparc/include/uapi/asm/fcntl.h | 36 ++++++++++++++---------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/include/uapi/asm/fcntl.h
index a93d18d2c23e..3c16f1a66a6a 100644
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
-#define O_REGULAR	0x4000000
+#define O_PATH		0100000000
+#define __O_TMPFILE	0200000000
+#define O_REGULAR	0400000000
 
 #define F_GETOWN	5	/*  for sockets. */
 #define F_SETOWN	6	/*  for sockets. */
-- 
2.52.0


