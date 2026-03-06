Return-Path: <linux-fsdevel+bounces-79549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLywBwoeqmlLLgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 01:21:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9854219BF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 01:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B81E3020D61
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 00:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D7329D287;
	Fri,  6 Mar 2026 00:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AXjAWSob"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E9F35975;
	Fri,  6 Mar 2026 00:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772756483; cv=none; b=gHJKfWLoZKlH2BD0CDfpXL9ZelNEfTFFeu8jPk3Oi8n7QRyFgbzaECYG7yMKgbHiA4WnmZ10RnJ7Bz2GGYA+JcfHbDQWu15vPgbSqh0AgA1l1daSrcWVUZMg5vrUc3pjaCQyYeWDFeeuwtEfqAuN/28u0moEK010kzzAzaDWTZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772756483; c=relaxed/simple;
	bh=f7KYVhw5pEHwSXD7nd7S6wB4i8qZrmY88A+KR+uCr2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OHVW9RUHgYMwyUpXQezLyKUbTHhwBguKR5pOO97wpP+uRzRsOlW7gTgti23UNiHO6rxSE2ReM4/BJoeot1x9fgOHzHmFFQpJJR1vkJ2Bb4Wyb/dy2bdnzv5CTAGG8g+HbV8Es9IX+TnopwXOYGXcHXv+ZflwEqWnSVS5bCF2ePE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=AXjAWSob; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=j5sV4+wUvNOc3xS7CkrG8KEGHYOk7JpcEgiSOK3kguU=; b=AXjAWSobMRol
	20h18D2GlepRE9enrygSuX0r1WN9naeYhUBjpfWPU5RO5akN8qpT3Y0p3+wKjRVrl1d/LISqtEy/O
	7384bWx5AGh0MwexSpiRtM50XRNH8YIPWpT9fkjhgdoQOfN7dsIYhEQZDmve3pGtUZPAdElyr8jd9
	VvtKsRvrSnv/BUZpCvygoIP+huEXXUu9p8eipR+SPHHzl9VrW4fhbLMbyZjcS/5sRiWGHLykE6AkH
	DGPNFpqh2atETX9aFQAW99JVgREHT0nVJWdBM0SN1ABV7ALMqM9+g8yzSEIo5np4qYoDL+bc83ouH
	ngm/AAd0YhrMFb6LXmRJRA==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1vyIuk-006nPE-06;
	Fri, 06 Mar 2026 01:21:05 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 6260L6d0519684
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 6 Mar 2026 00:21:06 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 6260L1JW519683;
	Fri, 6 Mar 2026 00:21:01 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Babu Moger <babu.moger@amd.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Abhinav Saxena <xandfury@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Subject: [PATCH] selftests: do not override CFLAGS set by the build environment
Date: Fri,  6 Mar 2026 00:21:00 +0000
Message-ID: <20260306002100.519673-1-aleksey.oladko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B9854219BF4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-79549-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,intel.com,arm.com,amd.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,gmail.com,linuxfoundation.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksey.oladko@virtuozzo.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fw_fallback.sh:url,virtuozzo.com:dkim,virtuozzo.com:email,virtuozzo.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,run_unprivileged_remount.sh:url]
X-Rspamd-Action: no action

Some kselftests Makefiles assign CFLAGS using 'CFLAGS=...'
which overrides any CFLAGS provided by the build environment.

If the environment set flags, overriding CFLAGS may result in
inconsistent compiler and linker options and cause build failures,
for example when building PIE binaries:

  # export CFLAGS="-fPIE"
  # export LDFLAGS="-pie"
  # make -C tools/testing/selftests/ TARGETS=mount_setattr
  make: Entering directory '/build/kernel/tools/testing/selftests'
  make[1]: Entering directory '/build/kernel/tools/testing/selftests/mount_setattr'
    CC       mount_setattr_test
  /usr/bin/ld: warning: -z pack-relative-relocs ignored
  /usr/bin/ld: /tmp/ccikConN.o: relocation R_X86_64_32 against `.rodata.str1.8' can not be used when making a PIE object; recompile with -fPIE
  collect2: error: ld returned 1 exit status
  make[1]: *** [../lib.mk:222: /build/kernel/tools/testing/selftests/mount_setattr/mount_setattr_test] Error 1

Fix this by appending to CFLAGS using 'CFLAGS+=' instead of
overriding them.

The fix is not applied to the Makefiles in x86, riscv, mm, arm64
and powerpc as they fully define their flags.

Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
---
 tools/testing/selftests/efivarfs/Makefile             | 2 +-
 tools/testing/selftests/exec/Makefile                 | 2 +-
 tools/testing/selftests/firmware/Makefile             | 4 ++--
 tools/testing/selftests/ipc/Makefile                  | 4 ++--
 tools/testing/selftests/mount/Makefile                | 4 ++--
 tools/testing/selftests/mount_setattr/Makefile        | 2 +-
 tools/testing/selftests/move_mount_set_group/Makefile | 2 +-
 tools/testing/selftests/resctrl/Makefile              | 2 +-
 tools/testing/selftests/safesetid/Makefile            | 2 +-
 tools/testing/selftests/signal/Makefile               | 2 +-
 tools/testing/selftests/timens/Makefile               | 2 +-
 tools/testing/selftests/tty/Makefile                  | 2 +-
 tools/testing/selftests/vDSO/Makefile                 | 2 +-
 13 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/efivarfs/Makefile b/tools/testing/selftests/efivarfs/Makefile
index e3181338ba5e..f6c412059af3 100644
--- a/tools/testing/selftests/efivarfs/Makefile
+++ b/tools/testing/selftests/efivarfs/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-CFLAGS = -Wall
+CFLAGS += -Wall
 
 TEST_GEN_FILES := open-unlink create-read
 TEST_PROGS := efivarfs.sh
diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index 45a3cfc435cf..54cdefb9ccb0 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS = -Wall
+CFLAGS += -Wall
 CFLAGS += -Wno-nonnull
 CFLAGS += $(KHDR_INCLUDES)
 
diff --git a/tools/testing/selftests/firmware/Makefile b/tools/testing/selftests/firmware/Makefile
index 7992969deaa2..dd9acf972cf5 100644
--- a/tools/testing/selftests/firmware/Makefile
+++ b/tools/testing/selftests/firmware/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 # Makefile for firmware loading selftests
-CFLAGS = -Wall \
-         -O2
+CFLAGS += -Wall \
+          -O2
 
 TEST_PROGS := fw_run_tests.sh
 TEST_FILES := fw_fallback.sh fw_filesystem.sh fw_upload.sh fw_lib.sh
diff --git a/tools/testing/selftests/ipc/Makefile b/tools/testing/selftests/ipc/Makefile
index 50e9c299fc4a..5a5577767a35 100644
--- a/tools/testing/selftests/ipc/Makefile
+++ b/tools/testing/selftests/ipc/Makefile
@@ -3,11 +3,11 @@ uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/i386/)
 ifeq ($(ARCH),i386)
         ARCH := x86
-	CFLAGS := -DCONFIG_X86_32 -D__i386__
+	CFLAGS += -DCONFIG_X86_32 -D__i386__
 endif
 ifeq ($(ARCH),x86_64)
 	ARCH := x86
-	CFLAGS := -DCONFIG_X86_64 -D__x86_64__
+	CFLAGS += -DCONFIG_X86_64 -D__x86_64__
 endif
 
 CFLAGS += $(KHDR_INCLUDES)
diff --git a/tools/testing/selftests/mount/Makefile b/tools/testing/selftests/mount/Makefile
index 2d9454841644..38361a896363 100644
--- a/tools/testing/selftests/mount/Makefile
+++ b/tools/testing/selftests/mount/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for mount selftests.
-CFLAGS = -Wall \
-         -O2
+CFLAGS += -Wall \
+          -O2
 
 TEST_PROGS := run_unprivileged_remount.sh run_nosymfollow.sh
 TEST_GEN_FILES := unprivileged-remount-test nosymfollow-test
diff --git a/tools/testing/selftests/mount_setattr/Makefile b/tools/testing/selftests/mount_setattr/Makefile
index 4d4f810cdf2c..fbdb8f69b548 100644
--- a/tools/testing/selftests/mount_setattr/Makefile
+++ b/tools/testing/selftests/mount_setattr/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for mount selftests.
-CFLAGS = -g $(KHDR_INCLUDES) -Wall -O2 -pthread
+CFLAGS += -g $(KHDR_INCLUDES) -Wall -O2 -pthread
 
 LOCAL_HDRS += ../filesystems/wrappers.h
 
diff --git a/tools/testing/selftests/move_mount_set_group/Makefile b/tools/testing/selftests/move_mount_set_group/Makefile
index 94235846b6f9..8771a5491ea3 100644
--- a/tools/testing/selftests/move_mount_set_group/Makefile
+++ b/tools/testing/selftests/move_mount_set_group/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for mount selftests.
-CFLAGS = -g $(KHDR_INCLUDES) -Wall -O2
+CFLAGS += -g $(KHDR_INCLUDES) -Wall -O2
 
 TEST_GEN_FILES += move_mount_set_group_test
 
diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index 984534cfbf1b..1d566a91faa7 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
+CFLAGS += -g -Wall -O2 -D_FORTIFY_SOURCE=2
 CFLAGS += $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS := resctrl_tests
diff --git a/tools/testing/selftests/safesetid/Makefile b/tools/testing/selftests/safesetid/Makefile
index e815bbf2d0f4..d3811515d8e3 100644
--- a/tools/testing/selftests/safesetid/Makefile
+++ b/tools/testing/selftests/safesetid/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for SafeSetID selftest.
-CFLAGS = -Wall -O2
+CFLAGS += -Wall -O2
 LDLIBS = -lcap
 
 TEST_PROGS := safesetid-test.sh
diff --git a/tools/testing/selftests/signal/Makefile b/tools/testing/selftests/signal/Makefile
index e0bf7058d19c..6c437f95132d 100644
--- a/tools/testing/selftests/signal/Makefile
+++ b/tools/testing/selftests/signal/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-CFLAGS = -Wall
+CFLAGS += -Wall
 TEST_GEN_PROGS = mangle_uc_sigmask
 TEST_GEN_PROGS += sas
 
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index f0d51d4d2c87..357077792395 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,7 +1,7 @@
 TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs exec futex vfork_exec
 TEST_GEN_PROGS_EXTENDED := gettime_perf
 
-CFLAGS := -Wall -Werror -pthread
+CFLAGS += -Wall -Werror -pthread
 LDLIBS := -lrt -ldl
 
 include ../lib.mk
diff --git a/tools/testing/selftests/tty/Makefile b/tools/testing/selftests/tty/Makefile
index 7f6fbe5a0cd5..e9c22dafe5e1 100644
--- a/tools/testing/selftests/tty/Makefile
+++ b/tools/testing/selftests/tty/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS = -O2 -Wall
+CFLAGS += -O2 -Wall
 TEST_GEN_PROGS := tty_tstamp_update tty_tiocsti_test
 LDLIBS += -lcap
 
diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index e361aca22a74..1f4628ceb975 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -11,7 +11,7 @@ TEST_GEN_PROGS += vdso_test_correctness
 TEST_GEN_PROGS += vdso_test_getrandom
 TEST_GEN_PROGS += vdso_test_chacha
 
-CFLAGS := -std=gnu99 -O2 -Wall -Wstrict-prototypes
+CFLAGS += -std=gnu99 -O2 -Wall -Wstrict-prototypes
 
 ifeq ($(CONFIG_X86_32),y)
 LDLIBS += -lgcc_s
-- 
2.43.0


