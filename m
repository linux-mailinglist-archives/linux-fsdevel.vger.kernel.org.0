Return-Path: <linux-fsdevel+bounces-58590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1ECB2F4E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 12:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C931C2754E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 10:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B197B2F1FEB;
	Thu, 21 Aug 2025 10:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKsQvKo6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D9D264F99;
	Thu, 21 Aug 2025 10:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755771134; cv=none; b=pkksMoLA3r+enOhLskD8xFZT4LcTcwnCgTODiblyt9eSSyQlXSEABh1Ete/+U1RlF5YVEEXSx5p/CvfqSuEfUD6rjcu1d0+ldrHyrHvsu53g7QTlgbu3w7QBWyvYhJkNB5Cw2FaXMM5XbhPbFB0z96ymjOAQvFCAUl4nlIwXxWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755771134; c=relaxed/simple;
	bh=UqbPJ04Skx3qeuN8AslDJpOBSlWMMOu7RTbaxK6CX1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JZowApDLrQVqzjJwdd3jwTnfZVwzFx8xMZM1ksmW4iz3ZXZX57MnkqmRR30PvRtwzPrsQ2/JNF+E8fCizM409/rCzsMByR48WR0RyYWmCDaWhqPrYAAgU0wFqGr3ErfvDUjgKgACxMfOMJ/AhV146gGmUkSxsAOnP6TIkhEHh24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKsQvKo6; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-323266cdf64so638809a91.0;
        Thu, 21 Aug 2025 03:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755771132; x=1756375932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jOIaU+ivLyUInrFo1z4/NdrgXjFotuRBDXDYangsfLc=;
        b=bKsQvKo6cP8+LOP6Kbj4W2C21rxVPTw1HB+GnuzSDygyx4NvOJtgSQkmxOd4gjMCqb
         ycQbAze9R2xwyMcv2s4LFkSNqnryc3IxnJY3baKcmw2jTXimUXEfffTblk6EDvp5nn9S
         b9lZZ9Y0eDf6SDlsycnx7qX/L+rA8wRb7toOtl1oWw3SmUzqm8LSGmjyvaUjITVqvFdg
         /NLPdyuEz+SbRyYD9YGy9GC0LgGOAiqUFaYwwEpNoHgNgh7Ll6gunDpGhEU+E2xzIcLh
         n0PcOf87/IKFvDpwFZ0WVmcIS1SyrEajXzVYPZTSL8SBmsSmCq/6/cOG3b0jDg0yOkyv
         qZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755771132; x=1756375932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOIaU+ivLyUInrFo1z4/NdrgXjFotuRBDXDYangsfLc=;
        b=jCIKzDmwOxrShlfw2A8d3YncxLKw6qtMTwIgw6zhBhA2n9pJZbuF89dW3ixthUhn38
         yClnt2MEPHDAOgxcpix85qS2loNVc/CG2JKNRXfoDzR+RXP5Oyu9zDJ6ZLPHFesZGBIv
         wWclEBrpWebrdQHSSZLH8I7c3MBfek76m63E2hNYri+Q/nfWt6WG8bXOMMpaH7G7/oLl
         53kdvCsvdG5p5niGyMJz0iZ4Dhgd215gbL0XEuIUG03nbSy/B7EJimsHEuTbPRSaKCSU
         l5na0uOd3MY2UUrYG2sU9VE3wXlPxJUq4snAysRAHSGT0kgjFIUjPfebh6Ke4t16krWX
         Y7GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVDujfSkQGSKXAgm05fJLH3SZ8zgEkG2Xwyyoyy6IMkcu9uxxzaH0+CSkcEhThubAwi9GiUkP6QyULvcZzGw==@vger.kernel.org, AJvYcCVdZH9mGJFzYypX3rtp1Rp2t56O9GuMAIvgSxOh+Or5t72bgZpZa85piwSGq8cDSLktw1ct+/yX4AXGvtvt@vger.kernel.org, AJvYcCVrNOXtnjQGNaXLa2FjJeGiNY/TwZRoNJkyzaQu5mKuAWs8dg9J3Kwx+cyWG6lssN/DFFFJvAxQ@vger.kernel.org, AJvYcCWrkoTXCAw6D6Sc7v0/eoGl0ReUBppcNwniYIZE8BqbwiSxFSLwb8/2zaubA2kVs8/qCeNx/xq/8P6zaw==@vger.kernel.org, AJvYcCX4IiGwFsa+LRM9Qt7WgfWVlXXClKUqBJbaWUXLHaYcLft20H3NhMd0ecmbrcdhRK41YY+adM5sLMVDaZr+Jz2TpUGRWQQu@vger.kernel.org, AJvYcCXktRHU8DJu1TAeFizaw2GkX8uo8PymfLFf6zl3Ik2flAPecbgQPqfdqDj3rkzZS2m7NB66Cl5CbcZkaR1pew+G@vger.kernel.org
X-Gm-Message-State: AOJu0YzPfziuyNdT6yq5UqyXfInSpGsTtp/kIS2LS+9h+VPn+SNQzQpm
	v2SYwUPY2g6tSjNP9skBCuA+XRG+DgX9+OWm2X+bJ4R+qJunVgYQDLuw
X-Gm-Gg: ASbGncsQRM2iLR6bBWp248oBK+YhIUzJ/1kfANVL4GKkv8Fy4iGsu8doUEJFCwNFkC5
	ch7y+mgc1Q7Mz73KrX5l2BGK0JB6uThNaGrgPgk/urXFyz3W0jftUdY0auoUmrywQlwBeJngygA
	DPMqlFxEaLq4m+f3D7+IH0tnjbONNXt7iWz1K7VxWGfqTXFX7QG0O1BcyqzU/xipxcrIUHYfuxs
	W+F9VSQySyfzojYH16WIcWSldPw4GiXuJTD4xNoTwTwplJigPzpm0zoFD88xaC6y5XcfuPiTRvj
	1uaCslzYEjOZjaAJ5q49e+axGF7xz3iZXAUN1MsOY6f2UsUlmMJzvY8uCG1ksr5Mftpcd4znQh0
	7+iFMCkDoCdDqjKEJNvFFmybaf2YN5wiytw==
X-Google-Smtp-Source: AGHT+IGyEK2exr+k/V0w8XXUmSIzv3Ytbu6vvsSe7eRwRcTsYn2OH5a5icQQPi/utnU7cQhUneD/0w==
X-Received: by 2002:a17:90b:224e:b0:323:7e80:8819 with SMTP id 98e67ed59e1d1-324ed15d2c5mr2462627a91.36.1755771131489;
        Thu, 21 Aug 2025 03:12:11 -0700 (PDT)
Received: from server.. ([103.250.145.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7ccfa8d1sm7835815b3a.0.2025.08.21.03.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 03:12:10 -0700 (PDT)
From: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org
Cc: mic@digikod.net,
	gnoack@google.com,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ming.lei@redhat.com,
	skhan@linuxfoundation.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	reddybalavignesh9979@gmail.com
Subject: [PATCH] selftests: centralise maybe-unused definition in kselftest.h
Date: Thu, 21 Aug 2025 15:41:59 +0530
Message-ID: <20250821101159.2238-1-reddybalavignesh9979@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several selftests subdirectories duplicated the define __maybe_unused,
leading to redundant code. Moved to kselftest.h header and removed
other definition.

This addresses the duplication noted in the proc-pid-vm warning fix

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Link:https://lore.kernel.org/lkml/20250820143954.33d95635e504e94df01930d0@linux-foundation.org/

Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
---
 tools/testing/selftests/kselftest.h                    | 4 ++++
 tools/testing/selftests/landlock/audit.h               | 6 ++----
 tools/testing/selftests/landlock/common.h              | 4 ----
 tools/testing/selftests/mm/pkey-helpers.h              | 3 ---
 tools/testing/selftests/net/psock_lib.h                | 4 ----
 tools/testing/selftests/perf_events/watermark_signal.c | 2 --
 tools/testing/selftests/proc/proc-pid-vm.c             | 4 ----
 tools/testing/selftests/ublk/utils.h                   | 2 --
 8 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index c3b6d2604b1e..661d31c4b558 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -92,6 +92,10 @@
 #endif
 #define __printf(a, b)   __attribute__((format(printf, a, b)))
 
+#ifndef __maybe_unused
+#define __maybe_unused __attribute__((__unused__))
+#endif
+
 /* counters */
 struct ksft_count {
 	unsigned int ksft_pass;
diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index b16986aa6442..02fd1393947a 100644
--- a/tools/testing/selftests/landlock/audit.h
+++ b/tools/testing/selftests/landlock/audit.h
@@ -20,14 +20,12 @@
 #include <sys/time.h>
 #include <unistd.h>
 
+#include "../kselftest.h"
+
 #ifndef ARRAY_SIZE
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 #endif
 
-#ifndef __maybe_unused
-#define __maybe_unused __attribute__((__unused__))
-#endif
-
 #define REGEX_LANDLOCK_PREFIX "^audit([0-9.:]\\+): domain=\\([0-9a-f]\\+\\)"
 
 struct audit_filter {
diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 88a3c78f5d98..9acecae36f51 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -22,10 +22,6 @@
 
 #define TMP_DIR "tmp"
 
-#ifndef __maybe_unused
-#define __maybe_unused __attribute__((__unused__))
-#endif
-
 /* TEST_F_FORK() should not be used for new tests. */
 #define TEST_F_FORK(fixture_name, test_name) TEST_F(fixture_name, test_name)
 
diff --git a/tools/testing/selftests/mm/pkey-helpers.h b/tools/testing/selftests/mm/pkey-helpers.h
index ea404f80e6cb..fa15f006fa68 100644
--- a/tools/testing/selftests/mm/pkey-helpers.h
+++ b/tools/testing/selftests/mm/pkey-helpers.h
@@ -84,9 +84,6 @@ extern void abort_hooks(void);
 #ifndef noinline
 # define noinline __attribute__((noinline))
 #endif
-#ifndef __maybe_unused
-# define __maybe_unused __attribute__((__unused__))
-#endif
 
 int sys_pkey_alloc(unsigned long flags, unsigned long init_val);
 int sys_pkey_free(unsigned long pkey);
diff --git a/tools/testing/selftests/net/psock_lib.h b/tools/testing/selftests/net/psock_lib.h
index 6e4fef560873..067265b0a554 100644
--- a/tools/testing/selftests/net/psock_lib.h
+++ b/tools/testing/selftests/net/psock_lib.h
@@ -22,10 +22,6 @@
 
 #define PORT_BASE			8000
 
-#ifndef __maybe_unused
-# define __maybe_unused		__attribute__ ((__unused__))
-#endif
-
 static __maybe_unused void pair_udp_setfilter(int fd)
 {
 	/* the filter below checks for all of the following conditions that
diff --git a/tools/testing/selftests/perf_events/watermark_signal.c b/tools/testing/selftests/perf_events/watermark_signal.c
index e03fe1b9bba2..b3a72f0ac522 100644
--- a/tools/testing/selftests/perf_events/watermark_signal.c
+++ b/tools/testing/selftests/perf_events/watermark_signal.c
@@ -17,8 +17,6 @@
 
 #include "../kselftest_harness.h"
 
-#define __maybe_unused __attribute__((__unused__))
-
 static int sigio_count;
 
 static void handle_sigio(int signum __maybe_unused,
diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
index 978cbcb3eb11..2a72d37ad008 100644
--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -47,10 +47,6 @@
 #include <sys/resource.h>
 #include <linux/fs.h>
 
-#ifndef __maybe_unused
-#define __maybe_unused __attribute__((__unused__))
-#endif
-
 #include "../kselftest.h"
 
 static inline long sys_execveat(int dirfd, const char *pathname, char **argv, char **envp, int flags)
diff --git a/tools/testing/selftests/ublk/utils.h b/tools/testing/selftests/ublk/utils.h
index 36545d1567f1..a852e0b7153e 100644
--- a/tools/testing/selftests/ublk/utils.h
+++ b/tools/testing/selftests/ublk/utils.h
@@ -2,8 +2,6 @@
 #ifndef KUBLK_UTILS_H
 #define KUBLK_UTILS_H
 
-#define __maybe_unused __attribute__((unused))
-
 #ifndef min
 #define min(a, b) ((a) < (b) ? (a) : (b))
 #endif
-- 
2.43.0


