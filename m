Return-Path: <linux-fsdevel+bounces-18534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE938BA34C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 00:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BECF81C21D69
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 22:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475704F898;
	Thu,  2 May 2024 22:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VRsGi7MK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61D91CD00
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 May 2024 22:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714689230; cv=none; b=HfFsUbjHOzyLQ4JOz5LYWHMQ4WBofsOKyvolLy5GwAk4b26WqDY/hPCAiFjXa8Xc5NZrpTbhGanFXoug/K7XdQly+HyAvgkUMCJYU6vALrIKlc4cAf80Go/9WcnH4ux+PRpraT3e3rggV8luADETXcMbifC8q+4n90PgYCgpmBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714689230; c=relaxed/simple;
	bh=nA88bPD2WL8ZV8ljbWg9pw64tzn8llNidezlYm5uvKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bw1DmvtkcGlAUofHZLC8K24zL+qZtqSRetpn5pFdhDpZNXFa40+jV+6S14KQ0czs5vDW1p7v9MtJWrkdWtkHq+lxsyKMVaWyzBEXA9mnQyYPKcaGtNOtFbyjnu/tsm3B7cQvwwk5e3kiWxxzVBfZvSbqBDJMa9koXouKUS346Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VRsGi7MK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ecec796323so8222384b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2024 15:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714689227; x=1715294027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lF5MThykxvPk9uyVBf2VyyviHzvbPbdlmOnhbtR5xIY=;
        b=VRsGi7MKFnfWx7+9ybWPL3MNqyICi0UZXT9EMZX7WcMsisCRB3ej2A1gbPwoLky2Jp
         EZHZWtSlKG6SXBsZWwEOVbfnzDWMquLGfkVpasCIgSZFhXX8xlx2HW+lOFCBt6KUTHx3
         t4GNvonZdrqwrjzWlevzaA9bIOJr4Hzmlj5n4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714689227; x=1715294027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lF5MThykxvPk9uyVBf2VyyviHzvbPbdlmOnhbtR5xIY=;
        b=KXLbiMKQ5ygg1gvkGRX3J78+gJxdTN6jzJ3qFQSaCwzek+Lw83KzNKzVQGe1SvrrqO
         GMuY56+rv99K+J46Bsfo1l6T6d6bE75gxGLqHD0j93tbqTaV9hX3wgTCNd/6DFrVdHpc
         4LCFVlLkcImIOHQpQbxKeBrBKSEJ8p2TwPGJwtrxDccQOkaa1fkaSmt/dwzxFyrQseXZ
         C3nAL3NCBQS/0ype+eErLiCvJqaFL/vIEj1XUbr/JuhDZpNUVSCzpctTwKYKuAeSDltA
         7Tj+yGg+XPQA9RJTfDFEWrVEk/sH8qBkMQAQiZ6fwMsIq+OqbaqCD9dfrWFlmU3ZWdn2
         wjNw==
X-Forwarded-Encrypted: i=1; AJvYcCU7GtU+972RxsNucXxViA69EJd+owcQ0UimdyBDot0u4vm2r9HEHkMl75Go6E3TZ4k9t5PSjnBirdXjbXBD7IUMgxmTlQtsZ8noiZkelA==
X-Gm-Message-State: AOJu0Yyra1SAT1v0v9729UHUGrVmxrBjoEUbjSqpV5xC40Kwi38qDFSP
	sPfiiXMv1sVWjXZ/x4TcKAktSxFwkob/PDKlCwmLOSCCyhrSHbiNtWViMX3RBA==
X-Google-Smtp-Source: AGHT+IHtiShlIqDNUhw3v6g852b7qDSgAQXi3kqCqyOfYkujNeIEUghf0HtbZSg1PqKylxw220jafA==
X-Received: by 2002:a05:6a20:4daa:b0:1a9:7f1b:e3f7 with SMTP id gj42-20020a056a204daa00b001a97f1be3f7mr1097122pzb.50.1714689227324;
        Thu, 02 May 2024 15:33:47 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y21-20020a056a00191500b006ece7bb5636sm1777178pfi.134.2024.05.02.15.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 15:33:42 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Matt Atwood <matthew.s.atwood@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 4/5] refcount: Introduce refcount_long_t and APIs
Date: Thu,  2 May 2024 15:33:39 -0700
Message-Id: <20240502223341.1835070-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502222252.work.690-kees@kernel.org>
References: <20240502222252.work.690-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=30349; i=keescook@chromium.org;
 h=from:subject; bh=nA88bPD2WL8ZV8ljbWg9pw64tzn8llNidezlYm5uvKM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmNBTDcl6TtH0GVE9GWJhPEYcrNfUnHW4Y0kjRd
 xoCLSGozA+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZjQUwwAKCRCJcvTf3G3A
 JmuCEACNdtzqcUYqDarKRX44A6dJJMhRBRisjH2wnxt4JqEeFbHKKpU9QD0me7kV2TikLgtqzdP
 e6C0c0hkvH9YX+0X6BidFQyurXXIpRdwmyCVYWX/oAZ4IjaAf1HxVDXcqb9C3YT3niQh2s7TDRU
 TAAci1qDRpdfNlG7Xw95SBog0U6x+7Ph+/xJS4d7UNOKeglYTC3H/xnHNlZRHH92B3bEPRxXoDG
 vB+cNXLiw0VFe1ZNxMte7anqzC4GUyUGsw1IvFQ3VK8wl2anlwb0D3sp85loKkcbN24e1PFwbMU
 1BhPrs8ZbP/mHt9TYi8MQKYtjeiq60W54qJG4/JMMLWUdFWziA0/a4Oin8M/FzbtoDqznzXScWq
 vk+mkxRX07K4KzEbbpokrZH1udptZArIV7/afi3qRawEOU/Rxt+S4Ck0/Q92CgEG5AUQ5xhAaN4
 V3O2sAxrxQTdasz1zm1ozzIsXmQp8S5lRNBuK9yMcHbP4uZHdLd6NHif6eQ797zgL1NVzfa9q3d
 4eudvSgIzr5W29diGSYiLIthiGc1ij5pCximj86dQwMFbS3sbIXwHdn2VXTQ0xw1YwqHqOEkPkZ
 j5xtEMtONaf8NOgF4hm6L8VZSm4dF8ttytzold77hjPbiZnVVEhPlRtfNactJML3zur2Xq/6j/1 +RmN8ZDstIWEdQg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Duplicate the refcount_t types and APIs gain refcount_long_t. This is
needed for larger counters that while currently very unlikely to overflow,
still want to detect and mitigate underflow.

Generate refcount-long.h via direct string replacements. Doing macros
like compat_binfmt_elf doesn't appear to work well.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-kbuild@vger.kernel.org
---
 MAINTAINERS                    |   2 +-
 Makefile                       |  11 +-
 include/linux/refcount-impl.h  | 344 +++++++++++++++++++++++++++++++++
 include/linux/refcount.h       | 341 +-------------------------------
 include/linux/refcount_types.h |  12 ++
 lib/refcount.c                 |  17 +-
 6 files changed, 385 insertions(+), 342 deletions(-)
 create mode 100644 include/linux/refcount-impl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c121493f43d..2e6c8eaab194 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3360,7 +3360,7 @@ S:	Maintained
 F:	Documentation/atomic_*.txt
 F:	arch/*/include/asm/atomic*.h
 F:	include/*/atomic*.h
-F:	include/linux/refcount.h
+F:	include/linux/refcount*.h
 F:	scripts/atomic/
 
 ATTO EXPRESSSAS SAS/SATA RAID SCSI DRIVER
diff --git a/Makefile b/Makefile
index 4bef6323c47d..a4bdcd34f323 100644
--- a/Makefile
+++ b/Makefile
@@ -1190,7 +1190,9 @@ PHONY += prepare archprepare
 
 archprepare: outputmakefile archheaders archscripts scripts include/config/kernel.release \
 	asm-generic $(version_h) include/generated/utsrelease.h \
-	include/generated/compile.h include/generated/autoconf.h remove-stale-files
+	include/generated/compile.h include/generated/autoconf.h \
+	include/generated/refcount-long.h \
+	remove-stale-files
 
 prepare0: archprepare
 	$(Q)$(MAKE) $(build)=scripts/mod
@@ -1262,6 +1264,13 @@ filechk_compile.h = $(srctree)/scripts/mkcompile_h \
 include/generated/compile.h: FORCE
 	$(call filechk,compile.h)
 
+include/generated/refcount-long.h: $(srctree)/include/linux/refcount-impl.h
+	$(Q)$(PERL) -pe 's/\b(atomic|(__)?refcount)_/\1_long_/g;	\
+			 s/ATOMIC_/ATOMIC_LONG_/g;			\
+			 s/(REFCOUNT)_(IMPL|INIT|MAX|SAT)/\1_LONG_\2/g;	\
+			 s/\b(U?)INT_/\1LONG_/g;			\
+			 s/\bint\b/long/g;' $< >$@
+
 PHONY += headerdep
 headerdep:
 	$(Q)find $(srctree)/include/ -name '*.h' | xargs --max-args 1 \
diff --git a/include/linux/refcount-impl.h b/include/linux/refcount-impl.h
new file mode 100644
index 000000000000..f5c73a0f46a4
--- /dev/null
+++ b/include/linux/refcount-impl.h
@@ -0,0 +1,344 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Variant of atomic_t specialized for reference counts.
+ *
+ * The interface matches the atomic_t interface (to aid in porting) but only
+ * provides the few functions one should use for reference counting.
+ *
+ * Saturation semantics
+ * ====================
+ *
+ * refcount_t differs from atomic_t in that the counter saturates at
+ * REFCOUNT_SATURATED and will not move once there. This avoids wrapping the
+ * counter and causing 'spurious' use-after-free issues. In order to avoid the
+ * cost associated with introducing cmpxchg() loops into all of the saturating
+ * operations, we temporarily allow the counter to take on an unchecked value
+ * and then explicitly set it to REFCOUNT_SATURATED on detecting that underflow
+ * or overflow has occurred. Although this is racy when multiple threads
+ * access the refcount concurrently, by placing REFCOUNT_SATURATED roughly
+ * equidistant from 0 and INT_MAX we minimise the scope for error:
+ *
+ *	                           INT_MAX     REFCOUNT_SATURATED   UINT_MAX
+ *   0                          (0x7fff_ffff)    (0xc000_0000)    (0xffff_ffff)
+ *   +--------------------------------+----------------+----------------+
+ *                                     <---------- bad value! ---------->
+ *
+ * (in a signed view of the world, the "bad value" range corresponds to
+ * a negative counter value).
+ *
+ * As an example, consider a refcount_inc() operation that causes the counter
+ * to overflow:
+ *
+ *	int old = atomic_fetch_add_relaxed(r);
+ *	// old is INT_MAX, refcount now INT_MIN (0x8000_0000)
+ *	if (old < 0)
+ *		atomic_set(r, REFCOUNT_SATURATED);
+ *
+ * If another thread also performs a refcount_inc() operation between the two
+ * atomic operations, then the count will continue to edge closer to 0. If it
+ * reaches a value of 1 before /any/ of the threads reset it to the saturated
+ * value, then a concurrent refcount_dec_and_test() may erroneously free the
+ * underlying object.
+ * Linux limits the maximum number of tasks to PID_MAX_LIMIT, which is currently
+ * 0x400000 (and can't easily be raised in the future beyond FUTEX_TID_MASK).
+ * With the current PID limit, if no batched refcounting operations are used and
+ * the attacker can't repeatedly trigger kernel oopses in the middle of refcount
+ * operations, this makes it impossible for a saturated refcount to leave the
+ * saturation range, even if it is possible for multiple uses of the same
+ * refcount to nest in the context of a single task:
+ *
+ *     (UINT_MAX+1-REFCOUNT_SATURATED) / PID_MAX_LIMIT =
+ *     0x40000000 / 0x400000 = 0x100 = 256
+ *
+ * If hundreds of references are added/removed with a single refcounting
+ * operation, it may potentially be possible to leave the saturation range; but
+ * given the precise timing details involved with the round-robin scheduling of
+ * each thread manipulating the refcount and the need to hit the race multiple
+ * times in succession, there doesn't appear to be a practical avenue of attack
+ * even if using refcount_add() operations with larger increments.
+ *
+ * Memory ordering
+ * ===============
+ *
+ * Memory ordering rules are slightly relaxed wrt regular atomic_t functions
+ * and provide only what is strictly required for refcounts.
+ *
+ * The increments are fully relaxed; these will not provide ordering. The
+ * rationale is that whatever is used to obtain the object we're increasing the
+ * reference count on will provide the ordering. For locked data structures,
+ * its the lock acquire, for RCU/lockless data structures its the dependent
+ * load.
+ *
+ * Do note that inc_not_zero() provides a control dependency which will order
+ * future stores against the inc, this ensures we'll never modify the object
+ * if we did not in fact acquire a reference.
+ *
+ * The decrements will provide release order, such that all the prior loads and
+ * stores will be issued before, it also provides a control dependency, which
+ * will order us against the subsequent free().
+ *
+ * The control dependency is against the load of the cmpxchg (ll/sc) that
+ * succeeded. This means the stores aren't fully ordered, but this is fine
+ * because the 1->0 transition indicates no concurrency.
+ *
+ * Note that the allocator is responsible for ordering things between free()
+ * and alloc().
+ *
+ * The decrements dec_and_test() and sub_and_test() also provide acquire
+ * ordering on success.
+ *
+ */
+#ifndef _LINUX_REFCOUNT_IMPL_H
+#define _LINUX_REFCOUNT_IMPL_H
+
+#define REFCOUNT_INIT(n)	{ .refs = ATOMIC_INIT(n), }
+#define REFCOUNT_MAX		INT_MAX
+#define REFCOUNT_SATURATED	(INT_MIN / 2)
+
+void refcount_warn_saturate(refcount_t *r, enum refcount_saturation_type t);
+
+/**
+ * refcount_set - set a refcount's value
+ * @r: the refcount
+ * @n: value to which the refcount will be set
+ */
+static inline void refcount_set(refcount_t *r, int n)
+{
+	atomic_set(&r->refs, n);
+}
+
+/**
+ * refcount_read - get a refcount's value
+ * @r: the refcount
+ *
+ * Return: the refcount's value
+ */
+static inline unsigned int refcount_read(const refcount_t *r)
+{
+	return atomic_read(&r->refs);
+}
+
+static inline __must_check __signed_wrap
+bool __refcount_add_not_zero(int i, refcount_t *r, int *oldp)
+{
+	int old = refcount_read(r);
+
+	do {
+		if (!old)
+			break;
+	} while (!atomic_try_cmpxchg_relaxed(&r->refs, &old, old + i));
+
+	if (oldp)
+		*oldp = old;
+
+	if (unlikely(old < 0 || old + i < 0))
+		refcount_warn_saturate(r, REFCOUNT_ADD_NOT_ZERO_OVF);
+
+	return old;
+}
+
+/**
+ * refcount_add_not_zero - add a value to a refcount unless it is 0
+ * @i: the value to add to the refcount
+ * @r: the refcount
+ *
+ * Will saturate at REFCOUNT_SATURATED and WARN.
+ *
+ * Provides no memory ordering, it is assumed the caller has guaranteed the
+ * object memory to be stable (RCU, etc.). It does provide a control dependency
+ * and thereby orders future stores. See the comment on top.
+ *
+ * Use of this function is not recommended for the normal reference counting
+ * use case in which references are taken and released one at a time.  In these
+ * cases, refcount_inc(), or one of its variants, should instead be used to
+ * increment a reference count.
+ *
+ * Return: false if the passed refcount is 0, true otherwise
+ */
+static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
+{
+	return __refcount_add_not_zero(i, r, NULL);
+}
+
+static inline __signed_wrap
+void __refcount_add(int i, refcount_t *r, int *oldp)
+{
+	int old = atomic_fetch_add_relaxed(i, &r->refs);
+
+	if (oldp)
+		*oldp = old;
+
+	if (unlikely(!old))
+		refcount_warn_saturate(r, REFCOUNT_ADD_UAF);
+	else if (unlikely(old < 0 || old + i < 0))
+		refcount_warn_saturate(r, REFCOUNT_ADD_OVF);
+}
+
+/**
+ * refcount_add - add a value to a refcount
+ * @i: the value to add to the refcount
+ * @r: the refcount
+ *
+ * Similar to atomic_add(), but will saturate at REFCOUNT_SATURATED and WARN.
+ *
+ * Provides no memory ordering, it is assumed the caller has guaranteed the
+ * object memory to be stable (RCU, etc.). It does provide a control dependency
+ * and thereby orders future stores. See the comment on top.
+ *
+ * Use of this function is not recommended for the normal reference counting
+ * use case in which references are taken and released one at a time.  In these
+ * cases, refcount_inc(), or one of its variants, should instead be used to
+ * increment a reference count.
+ */
+static inline void refcount_add(int i, refcount_t *r)
+{
+	__refcount_add(i, r, NULL);
+}
+
+static inline __must_check bool __refcount_inc_not_zero(refcount_t *r, int *oldp)
+{
+	return __refcount_add_not_zero(1, r, oldp);
+}
+
+/**
+ * refcount_inc_not_zero - increment a refcount unless it is 0
+ * @r: the refcount to increment
+ *
+ * Similar to atomic_inc_not_zero(), but will saturate at REFCOUNT_SATURATED
+ * and WARN.
+ *
+ * Provides no memory ordering, it is assumed the caller has guaranteed the
+ * object memory to be stable (RCU, etc.). It does provide a control dependency
+ * and thereby orders future stores. See the comment on top.
+ *
+ * Return: true if the increment was successful, false otherwise
+ */
+static inline __must_check bool refcount_inc_not_zero(refcount_t *r)
+{
+	return __refcount_inc_not_zero(r, NULL);
+}
+
+static inline void __refcount_inc(refcount_t *r, int *oldp)
+{
+	__refcount_add(1, r, oldp);
+}
+
+/**
+ * refcount_inc - increment a refcount
+ * @r: the refcount to increment
+ *
+ * Similar to atomic_inc(), but will saturate at REFCOUNT_SATURATED and WARN.
+ *
+ * Provides no memory ordering, it is assumed the caller already has a
+ * reference on the object.
+ *
+ * Will WARN if the refcount is 0, as this represents a possible use-after-free
+ * condition.
+ */
+static inline void refcount_inc(refcount_t *r)
+{
+	__refcount_inc(r, NULL);
+}
+
+static inline __must_check __signed_wrap
+bool __refcount_sub_and_test(int i, refcount_t *r, int *oldp)
+{
+	int old = atomic_fetch_sub_release(i, &r->refs);
+
+	if (oldp)
+		*oldp = old;
+
+	if (old == i) {
+		smp_acquire__after_ctrl_dep();
+		return true;
+	}
+
+	if (unlikely(old < 0 || old - i < 0))
+		refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
+
+	return false;
+}
+
+/**
+ * refcount_sub_and_test - subtract from a refcount and test if it is 0
+ * @i: amount to subtract from the refcount
+ * @r: the refcount
+ *
+ * Similar to atomic_dec_and_test(), but it will WARN, return false and
+ * ultimately leak on underflow and will fail to decrement when saturated
+ * at REFCOUNT_SATURATED.
+ *
+ * Provides release memory ordering, such that prior loads and stores are done
+ * before, and provides an acquire ordering on success such that free()
+ * must come after.
+ *
+ * Use of this function is not recommended for the normal reference counting
+ * use case in which references are taken and released one at a time.  In these
+ * cases, refcount_dec(), or one of its variants, should instead be used to
+ * decrement a reference count.
+ *
+ * Return: true if the resulting refcount is 0, false otherwise
+ */
+static inline __must_check bool refcount_sub_and_test(int i, refcount_t *r)
+{
+	return __refcount_sub_and_test(i, r, NULL);
+}
+
+static inline __must_check bool __refcount_dec_and_test(refcount_t *r, int *oldp)
+{
+	return __refcount_sub_and_test(1, r, oldp);
+}
+
+/**
+ * refcount_dec_and_test - decrement a refcount and test if it is 0
+ * @r: the refcount
+ *
+ * Similar to atomic_dec_and_test(), it will WARN on underflow and fail to
+ * decrement when saturated at REFCOUNT_SATURATED.
+ *
+ * Provides release memory ordering, such that prior loads and stores are done
+ * before, and provides an acquire ordering on success such that free()
+ * must come after.
+ *
+ * Return: true if the resulting refcount is 0, false otherwise
+ */
+static inline __must_check bool refcount_dec_and_test(refcount_t *r)
+{
+	return __refcount_dec_and_test(r, NULL);
+}
+
+static inline void __refcount_dec(refcount_t *r, int *oldp)
+{
+	int old = atomic_fetch_sub_release(1, &r->refs);
+
+	if (oldp)
+		*oldp = old;
+
+	if (unlikely(old <= 1))
+		refcount_warn_saturate(r, REFCOUNT_DEC_LEAK);
+}
+
+/**
+ * refcount_dec - decrement a refcount
+ * @r: the refcount
+ *
+ * Similar to atomic_dec(), it will WARN on underflow and fail to decrement
+ * when saturated at REFCOUNT_SATURATED.
+ *
+ * Provides release memory ordering, such that prior loads and stores are done
+ * before.
+ */
+static inline void refcount_dec(refcount_t *r)
+{
+	__refcount_dec(r, NULL);
+}
+
+extern __must_check bool refcount_dec_if_one(refcount_t *r);
+extern __must_check bool refcount_dec_not_one(refcount_t *r);
+extern __must_check bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock) __cond_acquires(lock);
+extern __must_check bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock) __cond_acquires(lock);
+extern __must_check bool refcount_dec_and_lock_irqsave(refcount_t *r,
+						       spinlock_t *lock,
+						       unsigned long *flags) __cond_acquires(lock);
+
+#endif /* _LINUX_REFCOUNT_IMPL_H */
diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 59b3b752394d..a744f814374f 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -1,94 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Variant of atomic_t specialized for reference counts.
- *
- * The interface matches the atomic_t interface (to aid in porting) but only
- * provides the few functions one should use for reference counting.
- *
- * Saturation semantics
- * ====================
- *
- * refcount_t differs from atomic_t in that the counter saturates at
- * REFCOUNT_SATURATED and will not move once there. This avoids wrapping the
- * counter and causing 'spurious' use-after-free issues. In order to avoid the
- * cost associated with introducing cmpxchg() loops into all of the saturating
- * operations, we temporarily allow the counter to take on an unchecked value
- * and then explicitly set it to REFCOUNT_SATURATED on detecting that underflow
- * or overflow has occurred. Although this is racy when multiple threads
- * access the refcount concurrently, by placing REFCOUNT_SATURATED roughly
- * equidistant from 0 and INT_MAX we minimise the scope for error:
- *
- * 	                           INT_MAX     REFCOUNT_SATURATED   UINT_MAX
- *   0                          (0x7fff_ffff)    (0xc000_0000)    (0xffff_ffff)
- *   +--------------------------------+----------------+----------------+
- *                                     <---------- bad value! ---------->
- *
- * (in a signed view of the world, the "bad value" range corresponds to
- * a negative counter value).
- *
- * As an example, consider a refcount_inc() operation that causes the counter
- * to overflow:
- *
- * 	int old = atomic_fetch_add_relaxed(r);
- *	// old is INT_MAX, refcount now INT_MIN (0x8000_0000)
- *	if (old < 0)
- *		atomic_set(r, REFCOUNT_SATURATED);
- *
- * If another thread also performs a refcount_inc() operation between the two
- * atomic operations, then the count will continue to edge closer to 0. If it
- * reaches a value of 1 before /any/ of the threads reset it to the saturated
- * value, then a concurrent refcount_dec_and_test() may erroneously free the
- * underlying object.
- * Linux limits the maximum number of tasks to PID_MAX_LIMIT, which is currently
- * 0x400000 (and can't easily be raised in the future beyond FUTEX_TID_MASK).
- * With the current PID limit, if no batched refcounting operations are used and
- * the attacker can't repeatedly trigger kernel oopses in the middle of refcount
- * operations, this makes it impossible for a saturated refcount to leave the
- * saturation range, even if it is possible for multiple uses of the same
- * refcount to nest in the context of a single task:
- *
- *     (UINT_MAX+1-REFCOUNT_SATURATED) / PID_MAX_LIMIT =
- *     0x40000000 / 0x400000 = 0x100 = 256
- *
- * If hundreds of references are added/removed with a single refcounting
- * operation, it may potentially be possible to leave the saturation range; but
- * given the precise timing details involved with the round-robin scheduling of
- * each thread manipulating the refcount and the need to hit the race multiple
- * times in succession, there doesn't appear to be a practical avenue of attack
- * even if using refcount_add() operations with larger increments.
- *
- * Memory ordering
- * ===============
- *
- * Memory ordering rules are slightly relaxed wrt regular atomic_t functions
- * and provide only what is strictly required for refcounts.
- *
- * The increments are fully relaxed; these will not provide ordering. The
- * rationale is that whatever is used to obtain the object we're increasing the
- * reference count on will provide the ordering. For locked data structures,
- * its the lock acquire, for RCU/lockless data structures its the dependent
- * load.
- *
- * Do note that inc_not_zero() provides a control dependency which will order
- * future stores against the inc, this ensures we'll never modify the object
- * if we did not in fact acquire a reference.
- *
- * The decrements will provide release order, such that all the prior loads and
- * stores will be issued before, it also provides a control dependency, which
- * will order us against the subsequent free().
- *
- * The control dependency is against the load of the cmpxchg (ll/sc) that
- * succeeded. This means the stores aren't fully ordered, but this is fine
- * because the 1->0 transition indicates no concurrency.
- *
- * Note that the allocator is responsible for ordering things between free()
- * and alloc().
- *
- * The decrements dec_and_test() and sub_and_test() also provide acquire
- * ordering on success.
- *
- */
-
 #ifndef _LINUX_REFCOUNT_H
 #define _LINUX_REFCOUNT_H
 
@@ -101,10 +11,6 @@
 
 struct mutex;
 
-#define REFCOUNT_INIT(n)	{ .refs = ATOMIC_INIT(n), }
-#define REFCOUNT_MAX		INT_MAX
-#define REFCOUNT_SATURATED	(INT_MIN / 2)
-
 enum refcount_saturation_type {
 	REFCOUNT_ADD_NOT_ZERO_OVF,
 	REFCOUNT_ADD_OVF,
@@ -113,249 +19,10 @@ enum refcount_saturation_type {
 	REFCOUNT_DEC_LEAK,
 };
 
-void refcount_warn_saturate(refcount_t *r, enum refcount_saturation_type t);
-
-/**
- * refcount_set - set a refcount's value
- * @r: the refcount
- * @n: value to which the refcount will be set
- */
-static inline void refcount_set(refcount_t *r, int n)
-{
-	atomic_set(&r->refs, n);
-}
-
-/**
- * refcount_read - get a refcount's value
- * @r: the refcount
- *
- * Return: the refcount's value
- */
-static inline unsigned int refcount_read(const refcount_t *r)
-{
-	return atomic_read(&r->refs);
-}
-
-static inline __must_check __signed_wrap
-bool __refcount_add_not_zero(int i, refcount_t *r, int *oldp)
-{
-	int old = refcount_read(r);
-
-	do {
-		if (!old)
-			break;
-	} while (!atomic_try_cmpxchg_relaxed(&r->refs, &old, old + i));
-
-	if (oldp)
-		*oldp = old;
-
-	if (unlikely(old < 0 || old + i < 0))
-		refcount_warn_saturate(r, REFCOUNT_ADD_NOT_ZERO_OVF);
-
-	return old;
-}
-
-/**
- * refcount_add_not_zero - add a value to a refcount unless it is 0
- * @i: the value to add to the refcount
- * @r: the refcount
- *
- * Will saturate at REFCOUNT_SATURATED and WARN.
- *
- * Provides no memory ordering, it is assumed the caller has guaranteed the
- * object memory to be stable (RCU, etc.). It does provide a control dependency
- * and thereby orders future stores. See the comment on top.
- *
- * Use of this function is not recommended for the normal reference counting
- * use case in which references are taken and released one at a time.  In these
- * cases, refcount_inc(), or one of its variants, should instead be used to
- * increment a reference count.
- *
- * Return: false if the passed refcount is 0, true otherwise
- */
-static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
-{
-	return __refcount_add_not_zero(i, r, NULL);
-}
-
-static inline __signed_wrap
-void __refcount_add(int i, refcount_t *r, int *oldp)
-{
-	int old = atomic_fetch_add_relaxed(i, &r->refs);
-
-	if (oldp)
-		*oldp = old;
-
-	if (unlikely(!old))
-		refcount_warn_saturate(r, REFCOUNT_ADD_UAF);
-	else if (unlikely(old < 0 || old + i < 0))
-		refcount_warn_saturate(r, REFCOUNT_ADD_OVF);
-}
-
-/**
- * refcount_add - add a value to a refcount
- * @i: the value to add to the refcount
- * @r: the refcount
- *
- * Similar to atomic_add(), but will saturate at REFCOUNT_SATURATED and WARN.
- *
- * Provides no memory ordering, it is assumed the caller has guaranteed the
- * object memory to be stable (RCU, etc.). It does provide a control dependency
- * and thereby orders future stores. See the comment on top.
- *
- * Use of this function is not recommended for the normal reference counting
- * use case in which references are taken and released one at a time.  In these
- * cases, refcount_inc(), or one of its variants, should instead be used to
- * increment a reference count.
- */
-static inline void refcount_add(int i, refcount_t *r)
-{
-	__refcount_add(i, r, NULL);
-}
-
-static inline __must_check bool __refcount_inc_not_zero(refcount_t *r, int *oldp)
-{
-	return __refcount_add_not_zero(1, r, oldp);
-}
-
-/**
- * refcount_inc_not_zero - increment a refcount unless it is 0
- * @r: the refcount to increment
- *
- * Similar to atomic_inc_not_zero(), but will saturate at REFCOUNT_SATURATED
- * and WARN.
- *
- * Provides no memory ordering, it is assumed the caller has guaranteed the
- * object memory to be stable (RCU, etc.). It does provide a control dependency
- * and thereby orders future stores. See the comment on top.
- *
- * Return: true if the increment was successful, false otherwise
- */
-static inline __must_check bool refcount_inc_not_zero(refcount_t *r)
-{
-	return __refcount_inc_not_zero(r, NULL);
-}
-
-static inline void __refcount_inc(refcount_t *r, int *oldp)
-{
-	__refcount_add(1, r, oldp);
-}
-
-/**
- * refcount_inc - increment a refcount
- * @r: the refcount to increment
- *
- * Similar to atomic_inc(), but will saturate at REFCOUNT_SATURATED and WARN.
- *
- * Provides no memory ordering, it is assumed the caller already has a
- * reference on the object.
- *
- * Will WARN if the refcount is 0, as this represents a possible use-after-free
- * condition.
- */
-static inline void refcount_inc(refcount_t *r)
-{
-	__refcount_inc(r, NULL);
-}
-
-static inline __must_check __signed_wrap
-bool __refcount_sub_and_test(int i, refcount_t *r, int *oldp)
-{
-	int old = atomic_fetch_sub_release(i, &r->refs);
-
-	if (oldp)
-		*oldp = old;
-
-	if (old == i) {
-		smp_acquire__after_ctrl_dep();
-		return true;
-	}
-
-	if (unlikely(old < 0 || old - i < 0))
-		refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
-
-	return false;
-}
-
-/**
- * refcount_sub_and_test - subtract from a refcount and test if it is 0
- * @i: amount to subtract from the refcount
- * @r: the refcount
- *
- * Similar to atomic_dec_and_test(), but it will WARN, return false and
- * ultimately leak on underflow and will fail to decrement when saturated
- * at REFCOUNT_SATURATED.
- *
- * Provides release memory ordering, such that prior loads and stores are done
- * before, and provides an acquire ordering on success such that free()
- * must come after.
- *
- * Use of this function is not recommended for the normal reference counting
- * use case in which references are taken and released one at a time.  In these
- * cases, refcount_dec(), or one of its variants, should instead be used to
- * decrement a reference count.
- *
- * Return: true if the resulting refcount is 0, false otherwise
- */
-static inline __must_check bool refcount_sub_and_test(int i, refcount_t *r)
-{
-	return __refcount_sub_and_test(i, r, NULL);
-}
-
-static inline __must_check bool __refcount_dec_and_test(refcount_t *r, int *oldp)
-{
-	return __refcount_sub_and_test(1, r, oldp);
-}
-
-/**
- * refcount_dec_and_test - decrement a refcount and test if it is 0
- * @r: the refcount
- *
- * Similar to atomic_dec_and_test(), it will WARN on underflow and fail to
- * decrement when saturated at REFCOUNT_SATURATED.
- *
- * Provides release memory ordering, such that prior loads and stores are done
- * before, and provides an acquire ordering on success such that free()
- * must come after.
- *
- * Return: true if the resulting refcount is 0, false otherwise
- */
-static inline __must_check bool refcount_dec_and_test(refcount_t *r)
-{
-	return __refcount_dec_and_test(r, NULL);
-}
-
-static inline void __refcount_dec(refcount_t *r, int *oldp)
-{
-	int old = atomic_fetch_sub_release(1, &r->refs);
-
-	if (oldp)
-		*oldp = old;
-
-	if (unlikely(old <= 1))
-		refcount_warn_saturate(r, REFCOUNT_DEC_LEAK);
-}
+/* Make the generation of refcount_long_t easier. */
+#define refcount_long_saturation_type refcount_saturation_type
 
-/**
- * refcount_dec - decrement a refcount
- * @r: the refcount
- *
- * Similar to atomic_dec(), it will WARN on underflow and fail to decrement
- * when saturated at REFCOUNT_SATURATED.
- *
- * Provides release memory ordering, such that prior loads and stores are done
- * before.
- */
-static inline void refcount_dec(refcount_t *r)
-{
-	__refcount_dec(r, NULL);
-}
+#include <linux/refcount-impl.h>
+#include <generated/refcount-long.h>
 
-extern __must_check bool refcount_dec_if_one(refcount_t *r);
-extern __must_check bool refcount_dec_not_one(refcount_t *r);
-extern __must_check bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock) __cond_acquires(lock);
-extern __must_check bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock) __cond_acquires(lock);
-extern __must_check bool refcount_dec_and_lock_irqsave(refcount_t *r,
-						       spinlock_t *lock,
-						       unsigned long *flags) __cond_acquires(lock);
 #endif /* _LINUX_REFCOUNT_H */
diff --git a/include/linux/refcount_types.h b/include/linux/refcount_types.h
index 162004f06edf..6ea02d6a9623 100644
--- a/include/linux/refcount_types.h
+++ b/include/linux/refcount_types.h
@@ -16,4 +16,16 @@ typedef struct refcount_struct {
 	atomic_t refs;
 } refcount_t;
 
+/**
+ * typedef refcount_long_t - variant of atomic64_t specialized for reference counts
+ * @refs: atomic_long_t counter field
+ *
+ * The counter saturates at REFCOUNT_LONG_SATURATED and will not move once
+ * there. This avoids wrapping the counter and causing 'spurious'
+ * use-after-free bugs.
+ */
+typedef struct refcount_long_struct {
+	atomic_long_t refs;
+} refcount_long_t;
+
 #endif /* _LINUX_REFCOUNT_TYPES_H */
diff --git a/lib/refcount.c b/lib/refcount.c
index a207a8f22b3c..201304b7d7a5 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -10,10 +10,8 @@
 
 #define REFCOUNT_WARN(str)	WARN_ONCE(1, "refcount_t: " str ".\n")
 
-void refcount_warn_saturate(refcount_t *r, enum refcount_saturation_type t)
+static void refcount_report_saturation(enum refcount_saturation_type t)
 {
-	refcount_set(r, REFCOUNT_SATURATED);
-
 	switch (t) {
 	case REFCOUNT_ADD_NOT_ZERO_OVF:
 		REFCOUNT_WARN("saturated; leaking memory");
@@ -34,8 +32,21 @@ void refcount_warn_saturate(refcount_t *r, enum refcount_saturation_type t)
 		REFCOUNT_WARN("unknown saturation event!?");
 	}
 }
+
+void refcount_warn_saturate(refcount_t *r, enum refcount_saturation_type t)
+{
+	refcount_set(r, REFCOUNT_SATURATED);
+	refcount_report_saturation(t);
+}
 EXPORT_SYMBOL(refcount_warn_saturate);
 
+void refcount_long_warn_saturate(refcount_long_t *r, enum refcount_saturation_type t)
+{
+	refcount_long_set(r, REFCOUNT_LONG_SATURATED);
+	refcount_report_saturation(t);
+}
+EXPORT_SYMBOL(refcount_long_warn_saturate);
+
 /**
  * refcount_dec_if_one - decrement a refcount if it is 1
  * @r: the refcount
-- 
2.34.1


