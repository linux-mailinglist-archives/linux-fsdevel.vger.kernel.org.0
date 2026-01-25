Return-Path: <linux-fsdevel+bounces-75382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNxHMaUldmn0MQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 15:16:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3D480F14
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 15:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA2953005AC7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 14:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0BF31A7F7;
	Sun, 25 Jan 2026 14:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAJEVnZM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACC53164B8
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jan 2026 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769350554; cv=none; b=JNy345Zvf4dIVElE4MRak/dojGaq0p4jGVY4uBmr2GhtNbNVzzX8wObcmKywTVEYZV49/opcHJK3rs0A3dA2WllCZJFchzy9L9qTp7DdsVmm3y5P/5zBvZ9kgBoOgJmj0sv4Xqb+M5UIZOi3j4bYm62ouRxBNDtkzqocy7MZplw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769350554; c=relaxed/simple;
	bh=zbm88tZ5EKGHb6dIIBgtcubs1/j7WvW74bC5PmEIF3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkSzatNXFfp5xd+j6S/hiyPlK9Gnkx5ZS+3lkb9OpE6KsvliGeDuVBRHA8dYWbYeTFpS/Btse0jRLkViPOlTMM5v8vJwx0WY8RZnFTPVDWAJmy5P8r6mQofCdKXFA0xzpHZYIJAE+VnoAHl7dzVMrqQpxsSYG4v4Y1cwqTe/f2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAJEVnZM; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35334ea1f98so1686571a91.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jan 2026 06:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769350552; x=1769955352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HDHyt8o7AOVvqViroBB2au4kbVsQeTCVMosjUYhWB4=;
        b=eAJEVnZM/1j38E7TMKeCr5cZAGaSeREO/bJH5uXtrRwVir/1kdH16yvWY79MWFLQEf
         ZuqbLIOdmTGB7MHHDOoLqZUq5q/yRdmtAFV2xJ54JvWljw6RFvzC0w0mwS2GdcBqDUAf
         xurDjc4Bl6jTPYip4Re93qUAUVDgTlVOtSjYEptLJm1TtjiIpn9R3Ajb+4mKj+5coPH7
         Y0hTss7A4XOqMAE11IyJSKpnvzsYPmMxiIjJsFsEEtc4gXoqK47Cp30nKgmQUP/MSTfw
         leMJNDpJoEQHOzpijFotJCHEJ8ScyoMQVaoWfpE62HA483MtrVqk7pCOCxmDe/bE5xn8
         Ko+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769350552; x=1769955352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0HDHyt8o7AOVvqViroBB2au4kbVsQeTCVMosjUYhWB4=;
        b=Q05VTjxyrlS2ruBlzNNXpjE0NP44xDsbv4cByLT6mrgWCFmZp57oqUm0SfCOUqbnAK
         HC7NQqbDwWXLY6jswqbcSu7SbOY83NTNsMiM1mRduq7jTThuJsXNfCEojQ/WXAbOexJ3
         I1L0wxWO9+WDetRvY/LCkb5VS3tYput6qz3zbHqqmY8EiRs2cbBZ3VJvyojZ41VqsT1C
         r+FUrKFnPsdW8CCMHgDnzSK5WmP4GCDkwobzTxE7rcjksG/4E1/i7iuDJ3lqDChOnfTW
         ZhsSys+5BKZJ9r7IOuBgUKtr+PoKXPTj4JaGQYTyWpda7sx22GAHZvQCYDYJYcE5RQ0O
         45Hw==
X-Gm-Message-State: AOJu0YwquA/o8PH6UFehvztdhiqe3pDzyrAv0ObJQvW+TdyO6zOJvCQ+
	7jlpsHDWeo//MOA4BWUscdX7ft09nqH2K08f/1pyxKAUfZSP9zM9g7yAWviGuQ==
X-Gm-Gg: AZuq6aIV8n5Q1eNab2VSGR7k9aEceeVSdwLnB0TeDnTI6h3quWHbuWA8VtpvBX+UxUe
	uIjBJLi1L4t1DV+sXkuguHXpcpDvOZTEbDidEQTacxSRe0HBM15qLpHWvIit3/v/FpO1efrQggu
	KeXwQoQzGH9AQsIeXNRt7dRir4SIMPHkgWXRB/YG5pNecVy8bMwX/udsLsp5NN8FQqSCXK2N6iG
	WTVVqrTTUmX4ir1+/mK89f4YKNcttMCtm8LDm1MJ933LnjSnXYWjJu9fXfVdm91SMddN39/5Atv
	aVKfVhFZWfcdFvBB9ISPVoYHdDIdtZ3DLkZMsDTo+K+n2a3LMYpcmJ0I37Bh+vMjDzAtXNIsEnE
	cPw/f2qBIsI5mqIdVs6fw1hxk1dhKMwyqBCDh3I1FBRmKF7T1qq+HC1LM3aOc5G2WXNSGiXIwP4
	p/eNQpmVxFW6w1hQ4i93ESx0RthEKCegXN0pwiz9Oli+U=
X-Received: by 2002:a17:90b:388e:b0:340:bb64:c5e with SMTP id 98e67ed59e1d1-353c40e25a1mr1406748a91.14.1769350552220;
        Sun, 25 Jan 2026 06:15:52 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a4135e6sm6334225a12.25.2026.01.25.06.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 06:15:51 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de
Subject: [PATCH 2/2] kselftest/openat2: test for O_REGULAR flag
Date: Sun, 25 Jan 2026 20:14:06 +0600
Message-ID: <20260125141518.59493-3-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260125141518.59493-1-dorjoychy111@gmail.com>
References: <20260125141518.59493-1-dorjoychy111@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75382-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5A3D480F14
X-Rspamd-Action: no action

Just a happy path test.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 .../testing/selftests/openat2/openat2_test.c  | 37 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 0e161ef9e9e4..c2f8771e2dae 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -320,8 +320,42 @@ void test_openat2_flags(void)
 	}
 }
 
+#ifndef O_REGULAR
+#define O_REGULAR 040000000
+#endif
+
+#ifndef ENOTREGULAR
+#define ENOTREGULAR 35
+#endif
+
+void test_openat2_o_regular_flag(void)
+{
+	if (!openat2_supported) {
+		ksft_test_result_skip("Skipping %s as openat2 is not supported\n", __func__);
+		return;
+	}
+
+	struct open_how how = {
+		.flags = O_REGULAR | O_RDONLY
+	};
+
+	int fd = sys_openat2(AT_FDCWD, "/dev/null", &how);
+
+	if (fd == ENOENT) {
+		ksft_test_result_skip("Skipping %s as there is no /dev/null\n", __func__);
+		return;
+	}
+
+	if (fd != -ENOTREGULAR) {
+		ksft_test_result_fail("openat2 should return ENOTREGULAR\n");
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
@@ -330,6 +364,7 @@ int main(int argc, char **argv)
 
 	test_openat2_struct();
 	test_openat2_flags();
+	test_openat2_o_regular_flag();
 
 	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
 		ksft_exit_fail();
-- 
2.52.0


