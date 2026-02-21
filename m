Return-Path: <linux-fsdevel+bounces-77851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Pd+JZbImWnOWgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 16:00:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AAC16D166
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 16:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A420D301AF6E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 15:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF81417C21C;
	Sat, 21 Feb 2026 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeNXLvmH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922C91C4A24
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Feb 2026 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771686015; cv=none; b=CLXZmlBI6/NQNXI23t2QLHmTgOOXqPp3xlTcyAYWqDreIExVYWBD6u2BJuQT4F4sVstqXpLVBxOZmP5ZNvWVURozKRdHGCNujeLfQik2iBrBarG0Wcye9cb68UjChciBu3pywLLQYf70sBjA8XXnd0o8ivq69xrZwls/dl3GkpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771686015; c=relaxed/simple;
	bh=QvKBTacd5z2P43CbYauz1u/x08KHhA7f2Nkz0BaL8og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prhgsRp/Gw5Gbvifi+1v2JRoH7CEzV964xAKQvEF/tKcDAxW/g8a3y2xcA3eO4vt+8BnKr1eO0RcwCtDpJ9h5ylD8Yhvv+i+rjbeSkY5/kiaFlNfL3N4ctu48uxoujMjaTi2B+UbV/pihgHoJVHEu9akiiYifUvCcP1EqWxbWv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeNXLvmH; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2aaf5d53eaaso19376945ad.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Feb 2026 07:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771686013; x=1772290813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Vj99fOR8e2nvanig9cWTi+niKOe1ygt4TyyqPTa8nU=;
        b=FeNXLvmHrHIpmt8JXR2o2hvWvgxiyIex4tVLvrjE3FRE4sl++ff9yZ/qZmqpwsOYIW
         g1n8gI/uv8OvdjIUtWywKvA/oh+AXVq/yft5jaJ4CpuCc5TUOGGrfiaCzxjgll2zJAAq
         MpD5M+uoHRsVHvZpjPpbSq9WeaiQCKm4vwri+5n8T7GUiWkjmGrNWj0ji8Wgc/2YC46f
         5wwIoqLv3P120IVhu0diTpsk1zRQvx5qIai+uDUWI6nippTPpsjO3h5VpY2pU2u+uthj
         fy3IldQtY3hhl5V0lGwpTL5MNaiBoS43OzXeaLxnXRVe177jq+SlzwhKs8BC+YMstGss
         NrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771686013; x=1772290813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Vj99fOR8e2nvanig9cWTi+niKOe1ygt4TyyqPTa8nU=;
        b=ibj0IhWSKVJGgnmbnAv7/QGScICYULxE4clZQA7S5U/j34mzs+964iycJ00NSgkGCP
         zrQ4eR5/R9Y4Gt0+BdFHwQVP0/m9Z2C2bsvmBRdoJRZXCxUNYjpJGEijVUUFoucEwOcK
         478enN+yr91svyRXpB7jG/FuCRb5gHgYdgz3oXqX/U5ySpS+bTT7mO6repetZ4fMpz2l
         1EbD96WAwEw/cG+PGshipfwl9LYjxjwTcv2EN0qCtbCCgFy8RTl1GPpcrPj1aW1WgVZD
         iKrvBCWHaDD+AMYNFUssNMlpmFnjBlysXvIDiMctxBd2mzKyA2nEIJF6a3GeuzU1KaGr
         6B9Q==
X-Gm-Message-State: AOJu0YyMBAo8Hb4/KsM93apm9rBEUgEZp7EVtzeuUbnGd08BnnbxezYV
	TJIxUvEoUjj9yJqydk83VIAcrSVg8S/Cs7SvFWLhfocKURY2alS3Wpv4clBs4w==
X-Gm-Gg: AZuq6aIYit8lPh0r05yaWSzRtFhaXmVcdc2qd5GmX0tcC8Tm2ZmdKbf7zfsfUGHN8Yb
	b92w/WsTEBUvfpDo1/w7Yz3j9ygV677wqmjH3SkzezEKmSi9puV1Ik7m8mtEPypAdv7E0ks9JrW
	ZoQFYLzYEh1riPn54pbuJhsvBCyM9KfBQnbPYf93EMgjOhYQR4KYpGK/1iD53+SbaUaWgSn2sLo
	ZL7HStlVgYJI0OZ3opl05pEMdB8CB0hRrs01W/mkGKi4AVVs8+Uwe2g/AskGABRXj5Peg5UShib
	cnbP/bRMMccvGeazgVFQjEcCo3EdbFhlEZ5PwFPz6cVS0mQSR41nUszm8/DKzPiMPajKm6VbYhM
	/m8JxjlPF9FnPsCph7A7rlVIaUtSzT5ZgObXvDpDI7cN5QI5gUHJ5UhkUz8JG/Jl3p4d4Z+6tj9
	JVs3NBevV+Etuw2hRRwXMfGn/2YEC2mMquCUkbw/gEzmwMUTfmQQdV/9E=
X-Received: by 2002:a17:902:cf07:b0:2a9:322e:2473 with SMTP id d9443c01a7336-2ad7457e58dmr34715235ad.48.1771686012796;
        Sat, 21 Feb 2026 07:00:12 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7503f4a4sm23730205ad.79.2026.02.21.06.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 07:00:11 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
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
Subject: [PATCH v4 2/4] kselftest/openat2: test for OPENAT2_REGULAR flag
Date: Sat, 21 Feb 2026 20:45:44 +0600
Message-ID: <20260221145915.81749-3-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260221145915.81749-1-dorjoychy111@gmail.com>
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
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
	RCPT_COUNT_TWELVE(0.00)[41];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,HansenPartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77851-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05AAC16D166
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


