Return-Path: <linux-fsdevel+bounces-76633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wA3LEVs8hmnzLAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 20:09:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2953102729
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 20:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1664308734C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 19:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC4C428849;
	Fri,  6 Feb 2026 19:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwCwEiPQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421B22ECE9B
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 19:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770404779; cv=none; b=KaZ6HMXOgukjJt5v/Et5vG0GC4S9hmFwhn//Rd1BAJ0fQEr2BtXYO7ySffLchOQh51YyeeqLgc2WvOJmJuO5w8q+W0PHW7OPtWxWFXaEbE3kev6hzCUzoaZkFiMNxIC66HdDpWUsf/YwT/wfaafMszJKk+Ar3PjsJ2p5tsQmMdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770404779; c=relaxed/simple;
	bh=EKC+gjybz5QCo3/A2SoLkAdJ9dHzP8glwvLLU31BmCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmmZnKw6+2ZKRLzuOdxkBTjov5Po/9lVO96LCHJhj5RkVMauKudtP3WgzVvCIUukRUrjx8x1CfXl37Ftrh8rUF8RmgGgG9vZfulO1rdVrSm8FxSgtaGaxB/GEd1ug9HOg2y5Tn/v8GYhsf42CUCKLwNS4tTw8Q03LUl0Dv1lwDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwCwEiPQ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-81df6a302b1so1201004b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Feb 2026 11:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770404778; x=1771009578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cE+gTqS6Acm3OjdFoCwcpAog50aFpqNiNU85af164dY=;
        b=bwCwEiPQ3D6Yd9OJ3BnC7yVyITJ51Toftb4FF5jyAPxGc/9jBp9fI0w4Sltb0/iHzD
         EwJpwyIpMMG83vGF8WDK+ABBZ4Mi1QWyf9gF0apnQCWms8ZMlNYmYj737T/gdBBUfp1P
         QDP5ckl/AuqsfRREYDO3Ss7n5j+jXyubT1yV5DQWenessukDzbh41SIKdoOtx2PLR/le
         GUbadvNDeV//L9riDv4fJhBTL92jIh08Ub5r/MxqrlEFl43uzykxZSLu9StONfTeKbfr
         nVybhU1ZgnZonAe8VlW2xzRzxPiYzNzl/n5QCq+yiAWNiG46mTDUyZCPm5g4XX3h6aR3
         ySUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770404778; x=1771009578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cE+gTqS6Acm3OjdFoCwcpAog50aFpqNiNU85af164dY=;
        b=cUM7nJJoF42ustf9zmZ8xToBWCqkTDW0iFL6lsRNSM2GVKfEfBaPNlV8p+TPgeJuS6
         duTw9ay7XqI1S0Fu1icNb8X17DgQ6k9Jr14ybEUVwAvzUa6AqgMk4Zo+RUF6GWDmzkYn
         pK0uz/2sS7LULw6vfcXHBmJn1XwYxynANUtN+PuEA/TTn+ZGoZZifBfxyVkc4OU8vPUl
         fM5ufgIKoH0XSXvuu1ZJPI0jpp97PUjvHAuOLoMiObiFk157jP7aXpXxVJ+pWLmTuv+6
         TN1cxuOV8zhpVVSeZRiQiRoM553XtuCzJG7TsWLzulb1GIpzC/0KwQgIk/XQRlQ/+IBd
         iJew==
X-Gm-Message-State: AOJu0YxMKq7G/46Uo1ZPfyMUNuXJ7lzYOsdJgWdeHv1a4HISR/PjmeB4
	JUcGDIadm/1UmtVIGLLqIw/iKp99wgy9r/ezpUimADqbVlgMppSF/tO8KTaQcw==
X-Gm-Gg: AZuq6aJq4vdQo5pfG1AjL1pWMfJtkBAwc1JYE//xyVbDkBubYhQduBDW53m7QBtdxa8
	29oLxbd0aDnXBBn5l8lN+pzh70fyasj7ybZiAHM3mTPu9ceHpNk+jHCLDhRPXCjIEoCGRGjr4fq
	SrnIl3yFECn8LVHhNWxK4x0WZzXhzGCI04J1B3Vzn+59TPYWO0kM9EnOZpSnQo74Mxl+ndmMqvG
	9UAFDWnEqhtb8fqMWMxjx5PdHeqg+YGxOuMfRO+jSATcW3zgVfojfCgi11rAfNKLcA2QRJY79Qv
	zVW6ebwoTbrELoNOuHFE8QheKjay9jQ/ptNLv7ZztneFb3z1nH9wiTGOkZ4JzoS5yQMh2hsYwrw
	pjJ4dhQZdA04EapkK2hv5Ys8LiF9OwR6nUiT8axVA9Il2us7I9GRgHwnArfWdHmdw7fqC04GeyJ
	9qY8335TRqEAIB162aZV2w35WoKtv37hiesCqOW8ZS1go=
X-Received: by 2002:a05:6a00:17a7:b0:81f:4963:4967 with SMTP id d2e1a72fcca58-82441773190mr3407511b3a.57.1770404778398;
        Fri, 06 Feb 2026 11:06:18 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418a70fesm2910894b3a.45.2026.02.06.11.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 11:06:17 -0800 (PST)
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
Subject: [PATCH v4 4/4] mips/fcntl.h: convert O_* flag macros from hex to octal
Date: Sat,  7 Feb 2026 01:03:39 +0600
Message-ID: <20260206190536.57289-5-dorjoychy111@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76633-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2953102729
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
2.53.0


