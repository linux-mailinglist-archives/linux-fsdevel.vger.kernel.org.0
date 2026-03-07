Return-Path: <linux-fsdevel+bounces-79697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJOyLsQxrGn2mgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 15:10:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C2522C18D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 15:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE74A30523EE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2026 14:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827AE223DD4;
	Sat,  7 Mar 2026 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j//Nqssx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FA92DC791
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Mar 2026 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772892507; cv=none; b=GTSeJMScioQ4P2nAyCAWjEV3USEaW4SGRDSFo+1HR1OAg1pKESpo3YebGvj4mvJHuhUeTpE66z2Brx59Ck19ESUCnSnJfXsqHI2l/iqkFo2U7BNZsmbnPurzXjdMdBKdb2ekjIXzx44uT4hCXaWX0ZOCUyMbskI8Gi4slaM020k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772892507; c=relaxed/simple;
	bh=QvKBTacd5z2P43CbYauz1u/x08KHhA7f2Nkz0BaL8og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auNqHAs5jAq8E0Y4gCPGrVi2xW9IxUNn9AHUjeb/FMVzamErd0DomL9DJQr7GIgrYlaFdiF+6h9NaQhX3jr71Nvm97+lLkdjgN1q9ug+m8sMSaZ+oHGEKRAXP08cN10IDLtBJs7eappDXy3iI4TZ5Abd6J2eCSfqDwLTYUbpFHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j//Nqssx; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-829afe24fb5so607150b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Mar 2026 06:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772892505; x=1773497305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Vj99fOR8e2nvanig9cWTi+niKOe1ygt4TyyqPTa8nU=;
        b=j//NqssxmhWBwW0YhQ6oRJKXQKgH7Mm5iRu1CkmB9uAJThjy7Ri+Hm5kgYVax8wgxU
         +UiSCPbRDYmh9msupkwRVd+MrCY3KmKJ878jDQZpUKiuXCsPJeRY7PuCigR1DNraTI5p
         z/WHvvdCakWKH7pHOzGnWAWuDlban3rOoSWXObOlZXonYOBQOka2Nh2H7H/LUaGJvDR0
         9Bnm9J9A8yJGqN5yUcPhNskNZFnMQCuDaYUoXhhovrbijKW/LfR0WS40gyVoFsFoZihQ
         68emMB2bbpGFUnPqT/U76/ZLZZdPJhB81OYDfiYC55dxiZ5FysUZjZVK7t2DEiQDjAsa
         4DNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772892505; x=1773497305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Vj99fOR8e2nvanig9cWTi+niKOe1ygt4TyyqPTa8nU=;
        b=DqZmaSE1NOmBTdp40hPc5NKX74XFj3o/1A2Xyckz0hG5JNuXuG1d9T/cpEGw6u2Urt
         7dpBW90DT9fDRA/88yFCCeXoSYTQfAUardIMimdh23lRb+ESwj4IpL59x4NfkGQO00cg
         eOUOoujdsbRI1Bm/AHnFk8c3sCoDEhEQNWlN3HFzMfQtyLiGSWlNpLEiKMNncWYpbhjT
         vx8ZgBZmDk4xBWfDfRkYD3a8xJVTr5iDvM3e3HquNbUNtbVvbsfttu6tU6y+6ezJgqUE
         OhqgFbTXeVlvxncWd1dOad4I/KqJ50xuB89Ohb7qW8zT6YV6/BxKg000qpUMTuJ8+jEa
         gIJg==
X-Gm-Message-State: AOJu0YzKzpxfUFDG4YzjeGRjKOdoOIK6TedzLKul03Ij3+M3u8Fn5tPi
	hDgF27MqI1ly1RjaPX0wR52IFPA/3D7prh+FvCw9EJEfliO5CbM8JGqcIhrxLi6F
X-Gm-Gg: ATEYQzzhxoXFcaXF/NvTP+teAgrDbXDSpRJz0IXRg6XdmZ62ZsdBgTwn0+Ehwuf22aU
	FSQbtFdbRvc+xS8XEvbP6Fi7Yx2lBKOpiB+bK/ZeZcsLHtDZW3ge1TLlruKaEI6xy8MXDeGUY+T
	Ufoy59oEiAgqPuFubinZEqIxTa+/0z9dG3GqiyqZJxx0tStCJb0lflJQM4YcsFs6yTEoNaaefKm
	dNrkfZgB1Ny9XSpUWYPZ8H9uTtNxSz3kih+nZKrkaEUphagHYxZtROS9cPjI0QbLLUgE2sSYtLl
	VICb2sn5ku+vUtLMSITtWcPbJLGPoRpv6bHrMdnvRCh2pB9S6fnRRQNJgoef3Mni7R82EfM8pNJ
	ChrZ4jBGbR9r6AXRgd0UTUAvMP8SbwiyAFt6IPViqgn/uzRkMdMssfh/N09I3E78B3l2ObPHG0o
	u5+M79rPWQt6nG1uZ10iAPUPtCz2+SnxKtFXYTn3yKqTPebYkUcwnDPyM=
X-Received: by 2002:a05:6a00:1c87:b0:81e:d7c3:2f3a with SMTP id d2e1a72fcca58-829a2f5a754mr4767475b3a.46.1772892505338;
        Sat, 07 Mar 2026 06:08:25 -0800 (PST)
Received: from toolbx ([103.103.35.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48ddd18sm4747313b3a.56.2026.03.07.06.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 06:08:25 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de,
	adilger@dilger.ca,
	mjguzik@gmail.com,
	smfrench@gmail.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	agruenba@redhat.com,
	trondmy@kernel.org,
	anna@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	shuah@kernel.org,
	miklos@szeredi.hu,
	hansg@kernel.org
Subject: [PATCH v5 2/4] kselftest/openat2: test for OPENAT2_REGULAR flag
Date: Sat,  7 Mar 2026 20:06:44 +0600
Message-ID: <20260307140726.70219-3-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307140726.70219-1-dorjoychy111@gmail.com>
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 26C2522C18D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,HansenPartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79697-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.992];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Just a happy path test.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 .../testing/selftests/openat2/openat2_test.c  | 37 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 0e161ef9e9e4..e8847f7d416c 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -320,8 +320,42 @@ void test_openat2_flags(void)
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
+	test_openat2_regular_flag();
 
 	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
 		ksft_exit_fail();
-- 
2.53.0


