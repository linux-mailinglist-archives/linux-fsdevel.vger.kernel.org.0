Return-Path: <linux-fsdevel+bounces-76631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KOEOSI8hmnzLAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 20:08:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4AC102711
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 20:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B6BC306C51E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 19:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8AC42883F;
	Fri,  6 Feb 2026 19:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHlcjyPe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699B9428846
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 19:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770404767; cv=none; b=qc0m6xowz3qayd8hT5l61rU3+lOxP82WpRdPUFkAekBnuZ/8sF7pkpHxZDuRwMU5DD1I2OBg1ock1yUahDtSpXc0B0RMkAvOVmK24M79PU6LTkCxwa40U5N9iD+n/iYtEDwmWjvuU8nJCntfvc1ANSnRf6u13/91iUKgHwNs6rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770404767; c=relaxed/simple;
	bh=olEcfw2R3PxQccxo/a4AA9XQpy1FIiPSq7EJrYSF/Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ch+bzx5vHZ+uzZgohldQ7CDFAK31Ae5v8Me6Rq2WSwcUcsnAeCCqA2dBWIbQwh8lr4/h3EvXXAsMhNnMwiTRyrNXOQnsDnN0nVSS4/GYYlkqAlKWrjLaAe7aNyFPE5sApcT8zgHaCxYdPaE1e/Yx7cH4WpU869S3dHIC5TcHDwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHlcjyPe; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8230c33f477so1166985b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Feb 2026 11:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770404766; x=1771009566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pb1U2+tXHG+cJ3VofgscQiI19w8OaU5clhJ5ujKhCs=;
        b=QHlcjyPeGqTGIhWhi0y+xrcQPm680CMaEJmHRflti4O9zE4R+6x3b8uDLX2o/3laa0
         4lIhFn0cIcHw5SJBOVZa5pWuL2JCTq59sI/AYgh0LtnkfQYWsog1bKhdSs7AurpZiy4N
         an4gCTDfkfsLnblV/RLptIliEOPgLa7uRmdyWhsBJpqSsxLNtbCLQSivHTpaTzpk5oMb
         ssv5oOhI+2ycUxB0hqLBewcEcimFqcrHT96HFN4gsuT+yom0+OML2q2ovqX4Y0C0t1z5
         KHWjmsH+8scN1Z/VvmKr43QhAO4Njj0uBmmNrHE6wCrOeI6YsmpLwI1RA/xW+DO0LCuy
         eM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770404766; x=1771009566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/pb1U2+tXHG+cJ3VofgscQiI19w8OaU5clhJ5ujKhCs=;
        b=GZxA0QWxHxCH0nP1Sh6b7Sd0FZqBGvHt9rD4T/L3s+pXb59BtliL+cChZFdCFVUysb
         yjb6Agl/AaKlbYUjOFAG6wn+DvBQdhhEbkOmw+jn3LD8PZLc6dlCyMKI2eSEdqLvd2B5
         XvHZwafjLl1jNnfH7SuTKZP8neANp5MXUP3MoxzYzt0O/Tlc6JtQtMofKj14aLnnU8Gt
         tyqaHi9Q9OJP0ROo1EodO2W7EAQfiDPtf0tjOT7l3uJ+y1tJouZBNvCKaDP0qLhIWMDq
         tsRIOOR3b7aJrAUy+yb6grF8af4kalJI2c0ke0NB7BF1Pxqp8FLXyU1A/gDtfhY1A2WO
         uiDA==
X-Gm-Message-State: AOJu0YwBF3cymt/fkd3/W0i+Hw2Q4+TM5wKm8flwRmwOxbJWFBS1dmDu
	HDXXc7vSO8AA4v/eRI5JzVCS9gBf/cSn9Xbu43zJbUMUidljbDAcwUfrhbxh/Q==
X-Gm-Gg: AZuq6aI0tdcV9pCvSEmBmq8t0RvH+b/qwrSdX2UA111JBrerIFU/C/LR+LgYBadjetO
	j9w7yZ2Umo2YzOHsQmb//atDTD1Pzlfap6zb0wcuUFWK7CGYJSrodNoW04zzaINaBU6hP/J6I7g
	Islaf6plQHFJLRdD0TjWEzkUIX/3IXO087cra+0Zr9utIy1GHqDdwVMF1Z66qT24SKqVXFRDIzd
	F01ocK3Y/r+vz61E0Injv/6M/DAHb+PCdLy6+mubDyRfh+gYemK3g8YR6Xbfcasxo7YUReHrNxb
	kuIVSRQHzRMFAiPqgvNy3IFiWU/pe1EZ9kj+ywfMBYz0/l+XsCpd4gHjD9d0cqq2wHPuH06b5/8
	T3xxaHH/3i2f2K/i5Z2OuaOEcFJ/LAZ8rUF1DoZnJqBeojW9YXjdjvxO1X/a7XvRL0LIjxN2Bcv
	ILmgIq5d6vCh4DdmYaL4Yy4zNs7V7F2jG7nIkZeE79+NE=
X-Received: by 2002:a05:6300:220d:b0:38d:fbb8:55a6 with SMTP id adf61e73a8af0-393af12003fmr3154475637.54.1770404766357;
        Fri, 06 Feb 2026 11:06:06 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418a70fesm2910894b3a.45.2026.02.06.11.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 11:06:05 -0800 (PST)
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
Subject: [PATCH v4 2/4] kselftest/openat2: test for OPENAT2_REGULAR flag
Date: Sat,  7 Feb 2026 01:03:37 +0600
Message-ID: <20260206190536.57289-3-dorjoychy111@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-76631-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 8A4AC102711
X-Rspamd-Action: no action

Just a happy path test.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 .../testing/selftests/openat2/openat2_test.c  | 46 ++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 0e161ef9e9e4..238de9cff291 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -320,8 +320,51 @@ void test_openat2_flags(void)
 	}
 }
 
+#ifndef OPENAT2_REGULAR
+#define OPENAT2_REGULAR 040000000
+#endif
+
+#ifndef EFTYPE
+#define EFTYPE 134
+#endif
+
+void test_openat2_regular_flag(void)
+{
+	if (!openat2_supported) {
+		ksft_test_result_skip("Skipping %s as openat2 is not supported\n", __func__);
+		return;
+	}
+
+	struct open_how how = {
+		.flags = OPENAT2_REGULAR | O_RDONLY
+	};
+
+	int fd = sys_openat2(AT_FDCWD, "/dev/null", &how);
+
+	if (fd == -ENOENT) {
+		ksft_test_result_skip("Skipping %s as there is no /dev/null\n", __func__);
+		return;
+	}
+
+	if (fd != -EFTYPE) {
+		ksft_test_result_fail("openat2 should return EFTYPE\n");
+		return;
+	}
+
+	how.flags = OPENAT2_REGULAR | O_DIRECTORY | O_RDONLY;
+
+	fd = sys_openat2(AT_FDCWD, "/dev", &how);
+
+	if (fd < 0) {
+		ksft_test_result_fail("openat2 should open directory with both O_DIRECTORY and OPENAT2_REGULAR\n");
+		return;
+	}
+
+	ksft_test_result_pass("%s succeeded\n", __func__);
+}
+
 #define NUM_TESTS (NUM_OPENAT2_STRUCT_VARIATIONS * NUM_OPENAT2_STRUCT_TESTS + \
-		   NUM_OPENAT2_FLAG_TESTS)
+		   NUM_OPENAT2_FLAG_TESTS + 1)
 
 int main(int argc, char **argv)
 {
@@ -330,6 +373,7 @@ int main(int argc, char **argv)
 
 	test_openat2_struct();
 	test_openat2_flags();
+	test_openat2_regular_flag();
 
 	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
 		ksft_exit_fail();
-- 
2.53.0


