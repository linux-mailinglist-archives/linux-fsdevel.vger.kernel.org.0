Return-Path: <linux-fsdevel+bounces-75634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Cb7Ov/9eGmOuQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 19:03:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD1798BF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 19:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 543CD308299D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 18:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90ED324B2D;
	Tue, 27 Jan 2026 18:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTn+fq/F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2852B3112D5
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 18:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536902; cv=none; b=YXe3gAQgF5ZqA14O6qM6o5jCFjUvvT8MoVakOCrTw/9F6raA3zVS/7SONQIswV3SKGyoyaqG7G1bqG0EkzEg9bSbxfuRexgLqh0k/2XHF6v+ThvZ4NFXpd16HVZ3KeSgSUuy/mqbkQU5s3Jx46nBD0pcRBkZPiUfrBk7COt+pOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536902; c=relaxed/simple;
	bh=tqewIhbRqq1adswiVbpduoDW8JX3z3VKvL2i1Kqr57I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjy31vjhzrgycx1+CfTo0e06nZEtO25rQ9Sf20zknkKs3WFPT4LhmQMUZL8sj1c8FTmFxnZJF/cS3g+MZ3AKRWPGF8+GGvIp0hsxLy6EcHUlcRL55/uCH6XoTV55HBkoCHGUEJ3YVJpehb9j5A4BzfDkz8k7z213Qu87CnRTJQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTn+fq/F; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-81e8a9d521dso3534482b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 10:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769536900; x=1770141700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFHTE7+4vut1ZBbXi2BaQWFLCQQCwb8j1cvQskcZkjo=;
        b=aTn+fq/FqyTDZaAEDHf07XjggDCP2frppyiTKRswruXN3rDTOoiYbfOIWrN6FmB77r
         ymX7yfMGFdwxelUU/kWB1LlOsb23wF+S84fb3X3XDSwLpHlgZ0XEzjOdJj2kV1qzehD7
         12/B15D/TYWpzjL3lrKEojiyhDxBRF/Wlr3RV/NJYClZY7UyH/ZH0n48ahygJfqbT7O3
         mSZZ25Aeom+XyYNiPBhaKSu15yeRectAzcbOyJR2XMq9+T0StSNAPcw/5ZivZ7ycb540
         NfzJtvgucySpiRx2Y+CUPokk66VCytgNMiBC8P651EbsXO+iKr+9jb7ZB0gkf/Las8p6
         5nSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769536900; x=1770141700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EFHTE7+4vut1ZBbXi2BaQWFLCQQCwb8j1cvQskcZkjo=;
        b=cu8JZ/olcQRboed3Wa5S2BMKprCijiKHdmg/A4upJRKt6elpPOL9/SUw7TxuMImEQ9
         9axbQdx3yNJyWzJraARO31gc1oUmyWr39+wuoTJd7H4UUlu3GRNN0tA3m/C5zGMwU5TJ
         euMP+Vd02tIGKv2PmNfzhTzVUY87LJ6OGPbPxd/9I4XwWbzV/u/8CP1WBjreNHFWyuyT
         7t4+E3hfXfANMYxrWZqvure+qu8yE8IBFYDtqVsVrNPzHKTA+CpHhBEMzoguQz/vxsss
         3fxink+0Z+XTxB/nz38qf01RXs3hS6U4/aY4ReXZxuQ+9cVlhTQcMqaDXZY0+mCeBDSN
         xBqA==
X-Gm-Message-State: AOJu0Yzw2iu6Cv+T1AnyPstCQY871SYonC2W46c0JGMYm0y3r/WkwsHg
	/2K1/cOtRaceyiji8OfFTYFqiIFXaSGLkY6VOObQhXRaMu0CBHykrRpRg7ZENQ==
X-Gm-Gg: AZuq6aJzw8OCCIeaBV1mOTms3jhhg7vuzJf1uV1Kriw1LNSFjiDCnVWytBzlzr5Jxna
	mDbt0c09+htvO3jPaA3RB1tHqBuoGXUA3EwLx4ZdvnYmpLW+14SI7bSJzLuN8rP6y4DyvfLsZEe
	NEIoPBJRWZJc9zL4jknkh0FHwEMsE3Ls17356Qv711s9siCMJ/vUsITHNFdIx0NPVXFYeMMooaG
	Z8DJ+xlw1A9s0E773NpuEQROCTqRXo9rTiiD9qk1P4k2i8xPb9Mn1JhzKO4mhyUGxAHJNfTXHez
	eREZBEzll9+Yfv5afOsgXojyOkD/MYOPrqdkknIhk/KkLAL7Dan+HlFhPehoMOwPLmvi6RWu+mf
	Fl6SjJXoQPRd8ByyJ9Mt8SRtwVYAqqxgBkO+UaFDv6TrHRSO+ClIJuD/U2uX+tUnLgb19/jzP/q
	4BdbEXUfliPsagSruHnGxh3enSTrMoiE78V9AMqAzaJ5/MDFDYUnIZuA==
X-Received: by 2002:a05:6a00:3e18:b0:823:d58:c48f with SMTP id d2e1a72fcca58-823692f0703mr2287212b3a.69.1769536900305;
        Tue, 27 Jan 2026 10:01:40 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b1bc68sm216891b3a.2.2026.01.27.10.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:01:39 -0800 (PST)
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
Subject: [PATCH v3 2/4] kselftest/openat2: test for O_REGULAR flag
Date: Tue, 27 Jan 2026 23:58:18 +0600
Message-ID: <20260127180109.66691-3-dorjoychy111@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75634-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6FD1798BF2
X-Rspamd-Action: no action

Just a happy path test.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 .../testing/selftests/openat2/openat2_test.c  | 37 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 0e161ef9e9e4..011ebc9af4e5 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -320,8 +320,42 @@ void test_openat2_flags(void)
 	}
 }
 
+#ifndef O_REGULAR
+#define O_REGULAR 040000000
+#endif
+
+#ifndef ENOTREG
+#define ENOTREG 134
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
+	if (fd != -ENOTREG) {
+		ksft_test_result_fail("openat2 should return ENOTREG\n");
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


