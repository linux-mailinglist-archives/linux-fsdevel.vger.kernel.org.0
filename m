Return-Path: <linux-fsdevel+bounces-62987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5900ABA7BE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 03:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7CD93C02FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 01:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE0A2C21D0;
	Mon, 29 Sep 2025 01:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="iA6Gv4Uf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFD12C030E
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 01:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107900; cv=none; b=V0H6wBp6NM0+V/iS9TzbityUEKDudBy+XL8I1HmwOk1SpMNI9UJNuKicYZNQ2dogUmGshuneG9pcTbtkOmi+7aEIfOgy5RdSIQWSJyJc5kA/sE5FoVAXGXWnWxvxVtSLy7vH1sMxQhk820HUAmplYpLKgxJUwlesAk7L3TB1kzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107900; c=relaxed/simple;
	bh=YxndNYekOIE4c7Py3BfYUApvqGWLMZMwxTdov0PwqSk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXX0ejS8CoDVl/cWnUPQMZaTYmdcbqofKdpNiYC4Abyp5c39UJP1NpWUcIVGUWasp/ffJNg643fP+eTUlhID62qB4aJPYUsRmCF67lhK2oGDnfp3/CamqgECmqW1wVRi9AwFNy/MeIW+A8fdvhAXtOad6uqpZgUS3C6sMRoi1Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=iA6Gv4Uf; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4df60ea79d1so14514171cf.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 18:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759107896; x=1759712696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ougWc4G/qIZT3q+j2o8YnJ0ye/FPwzyh3Yh9OeHBEk8=;
        b=iA6Gv4UfCuldLImNHDxeF22VUESqTDA4QxoBJLZQFc485cj2iO0lwRGLwYJLqQTAQj
         tQntflsKcN01xTOwwLu9M/WyAVEh2n2DoJvrsqct0dcZtrzeNAncR3JA6hR1cyWtk5a5
         O5jZUw5bvDLIypoo1sQ7qsE0EBwrDE2Uw/0Q7/nZGXpiIoqAaUBA74S+qvCFH8RkhZTO
         UEZ4hLXlH7a7GDPBvU2aPFEYwpa36jMdm9/trun5+92JSrbDs+eaFuqGOUoy6fnygBbn
         KbI94Sh906CF7GxwDzpzVWrhZOVup5yqNaxWuvLUxs+qlMi12/EjmSNlTdAxlam2jhbG
         kkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107896; x=1759712696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ougWc4G/qIZT3q+j2o8YnJ0ye/FPwzyh3Yh9OeHBEk8=;
        b=qQwWqcwAm406P7MBXcU6n6ROqki0siuw62hUE0fyiRJuBjItB2NLquaohmFkjl4+Z2
         yiz7eofthm9g1xnzoU3tXQKJGfuWmg3hMY0ApXEAmmVAkEYT1aVfOd+jAeuDF0mRLxbs
         CYHiuC5HlWDhQS3VK6TLckTgtADjsqw2hLe1i8QP7VJPt8reyiSr2cM+J5rOuz114Ia8
         zU2xW5KS+Ym4Fpxenzu4arDCXB3T7cvyBWp+BtRw6iFV4TqQJEPI2gDvV8Ulir7LZ2DK
         XkDcD8EdX3DwcPdt86QuiKQ8iD+T8VYFbHZqFNo90nusMDPWzLo0TDkiXqEj/x8UQl6H
         lyLw==
X-Forwarded-Encrypted: i=1; AJvYcCUoQnSHomB1Hdagvp+hnDrMjXmcoTrYFhpXNxaMOmudYTt0UhyFN7B5Rtj82egHOTQDf/6obR4gOikFs5kJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyoO4jf3Nfkho5IiOtjPOa31HVRMCooPZHVSLzmEf8yAWl0MLTS
	FE8KpY5NyYV0TxNLDflXx9LeQqSdArhc04MMrQsrxcVFnkW5xKaC0iXM+rrQNjlWUN0=
X-Gm-Gg: ASbGncvoTVQjEExlonWVZ1Drv+8p10zqN7MRKkoCEV+IBiQo7SOCKwnPafkQ1sIfwwf
	vP111mGtGzDHaeQnF7e0TsyaxHLpIIk05+p50iM0SqOFrHTiX6qSnGv8be6nzsZKG2E4/Vr7IL1
	vM6OGx3TJlVOE/1JsfdVO0/tU795rKOrdlAKfl6FITS+P19Z6e0/yGVv2okb+aQ6i9ysOK0l2oF
	VewtrLSac0W0ePqxR9JO+qK+pKejoANdfLNRDCxt4hKrQC7xtydshShixNYgDZ7sfZOPaMNqk9N
	ZXH4kw9p1zRs6mFTUYmH+b9wC3dme7t/CmCmhIX3lVjqByS9VlglmsMKSDkGkzrqFij5tne//S/
	BUg1Mwi1EDn/CNYz5w2z2iE7d6h6dfN9GxOYA4WH5On4OppsdOvon2JUd7jrLly6mvPljwgF/v8
	sumRsVdRg=
X-Google-Smtp-Source: AGHT+IFYNaFG7Jc9+8mczCUfL2NG5AxHH54S3++B2bClP4OT/C9rMlU+s2JYq6QncxNId85tdheqhw==
X-Received: by 2002:ac8:7d43:0:b0:4b7:90c0:3156 with SMTP id d75a77b69052e-4da4735376emr195893531cf.9.1759107896425;
        Sun, 28 Sep 2025 18:04:56 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0c0fbe63sm64561521cf.23.2025.09.28.18.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 18:04:55 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org,
	steven.sistare@oracle.com
Subject: [PATCH v4 30/30] selftests/liveupdate: Add tests for per-session state and cancel cycles
Date: Mon, 29 Sep 2025 01:03:21 +0000
Message-ID: <20250929010321.3462457-31-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
In-Reply-To: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce two new, non-kexec selftests to validate the state transition
logic for individual LUO sessions, with a focus on the PREPARE, FREEZE,
and CANCEL events. While other tests cover the full kexec lifecycle, it
is critical to also test the internal per-session state machine's logic
and rollback capabilities in isolation. These tests provide this focused
coverage, ensuring the core session management ioctls behave as
expected.

The new test cases are:
1. session_prepare_cancel_cycle:
  - Verifies the fundamental NORMAL -> PREPARED -> NORMAL state
    transition path.
  - It creates a session, preserves a file, sends a per-session PREPARE
    event, asserts the state is PREPARED, then sends a CANCEL event and
    asserts the state has correctly returned to NORMAL.

2. session_freeze_cancel_cycle:
  - Extends the first test by validating the more critical ... ->
    FROZEN -> NORMAL rollback path.
  - It follows the same steps but adds a FREEZE event after PREPARE,
    asserting the session enters the FROZEN state.
  - It then sends a CANCEL event, verifying that a session can be rolled
    back even from this final pre-kexec state. This is essential for
    robustly handling aborts.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 tools/testing/selftests/liveupdate/Makefile   |  9 ++-
 .../testing/selftests/liveupdate/liveupdate.c | 56 +++++++++++++++++++
 2 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/liveupdate/Makefile b/tools/testing/selftests/liveupdate/Makefile
index ffce73233149..25a6dec790bb 100644
--- a/tools/testing/selftests/liveupdate/Makefile
+++ b/tools/testing/selftests/liveupdate/Makefile
@@ -16,11 +16,18 @@ LUO_MANUAL_TESTS += luo_unreclaimed
 
 TEST_FILES += do_kexec.sh
 
-TEST_GEN_PROGS += liveupdate
+LUO_MAIN_TESTS += liveupdate
 
 # --- Automatic Rule Generation (Do not edit below) ---
 
 TEST_GEN_PROGS_EXTENDED += $(LUO_MANUAL_TESTS)
+TEST_GEN_PROGS := $(LUO_MAIN_TESTS)
+
+liveupdate_SOURCES := liveupdate.c $(LUO_SHARED_SRCS)
+
+$(OUTPUT)/liveupdate: $(liveupdate_SOURCES) $(LUO_SHARED_HDRS)
+	$(call msg,LINK,,$@)
+	$(Q)$(LINK.c) $^ $(LDLIBS) -o $@
 
 # Define the full list of sources for each manual test.
 $(foreach test,$(LUO_MANUAL_TESTS), \
diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index 7c0ceaac0283..804aa25ce5ae 100644
--- a/tools/testing/selftests/liveupdate/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -17,6 +17,7 @@
 #include <sys/mman.h>
 
 #include <linux/liveupdate.h>
+#include "luo_test_utils.h"
 
 #include "../kselftest.h"
 #include "../kselftest_harness.h"
@@ -52,6 +53,16 @@ const char *const luo_state_str[] = {
 	[LIVEUPDATE_STATE_UPDATED]  = "updated",
 };
 
+static int get_session_state(int session_fd)
+{
+	struct liveupdate_session_get_state arg = { .size = sizeof(arg) };
+
+	if (ioctl(session_fd, LIVEUPDATE_SESSION_GET_STATE, &arg) < 0)
+		return -errno;
+
+	return arg.state;
+}
+
 static int run_luo_selftest_cmd(int fd_dbg, __u64 cmd_code,
 				struct luo_arg_subsystem *subsys_arg)
 {
@@ -345,4 +356,49 @@ TEST_F(subsystem, prepare_fail)
 		ASSERT_EQ(0, unregister_subsystem(self->fd_dbg, &self->si[i]));
 }
 
+TEST_F(state, session_freeze_cancel_cycle)
+{
+	int session_fd;
+	const char *session_name = "freeze_cancel_session";
+	const int memfd_token = 5678;
+
+	session_fd = luo_create_session(self->fd, session_name);
+	ASSERT_GE(session_fd, 0);
+
+	ASSERT_EQ(0, create_and_preserve_memfd(session_fd, memfd_token,
+					       "freeze test data"));
+
+	ASSERT_EQ(0, luo_set_session_event(session_fd, LIVEUPDATE_PREPARE));
+	ASSERT_EQ(get_session_state(session_fd), LIVEUPDATE_STATE_PREPARED);
+
+	ASSERT_EQ(0, luo_set_session_event(session_fd, LIVEUPDATE_FREEZE));
+	ASSERT_EQ(get_session_state(session_fd), LIVEUPDATE_STATE_FROZEN);
+
+	ASSERT_EQ(0, luo_set_session_event(session_fd, LIVEUPDATE_CANCEL));
+	ASSERT_EQ(get_session_state(session_fd), LIVEUPDATE_STATE_NORMAL);
+
+	close(session_fd);
+}
+
+TEST_F(state, session_prepare_cancel_cycle)
+{
+	const char *session_name = "prepare_cancel_session";
+	const int memfd_token = 1234;
+	int session_fd;
+
+	session_fd = luo_create_session(self->fd, session_name);
+	ASSERT_GE(session_fd, 0);
+
+	ASSERT_EQ(0, create_and_preserve_memfd(session_fd, memfd_token,
+					       "prepare test data"));
+
+	ASSERT_EQ(0, luo_set_session_event(session_fd, LIVEUPDATE_PREPARE));
+	ASSERT_EQ(get_session_state(session_fd), LIVEUPDATE_STATE_PREPARED);
+
+	ASSERT_EQ(0, luo_set_session_event(session_fd, LIVEUPDATE_CANCEL));
+	ASSERT_EQ(get_session_state(session_fd), LIVEUPDATE_STATE_NORMAL);
+
+	close(session_fd);
+}
+
 TEST_HARNESS_MAIN
-- 
2.51.0.536.g15c5d4f767-goog


