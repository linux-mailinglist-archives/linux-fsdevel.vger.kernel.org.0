Return-Path: <linux-fsdevel+bounces-28749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A18E96DCE8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 17:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B541F21AAB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 15:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509AC1A01D8;
	Thu,  5 Sep 2024 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="iXFhQmWS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03CD1990DB;
	Thu,  5 Sep 2024 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548269; cv=none; b=K1yhso4Br4Szk4y3bn5OIOLONpiySiQyUmFHuqDEZLL+0QKMs3NHg2/X7z3YnSzYHx6F7V8OfIO7t7kRk74uY4iB5s0se/6z9Ao0/HYeJ4LCqpncQ/uDPu0Y5abmvpehSQCqCv+KbJ3713kQCB8uGzi3sU0hUCju/JtgBK+REsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548269; c=relaxed/simple;
	bh=Q9mL5w2RoQs4wSB8ZJ2PbsaEFoNFfd5BJzx5Jald3aw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jmtNUod59imhIq0tMNECx2sxFye+GIxC8kRxlKucsmGtxo14J9VBGi1/TyKBEbX21OPbB566GvLoQbVCFqy0WI52VxxcfRWEh26OE9H4pbv9Zr8FBAYk4gTUZ2NfYDgSK9fF6Ygn+ZlYEXltFoZMKEj+l3iJXugwkTGTzX/bJSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=iXFhQmWS; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4X02XR5KzSz9ssx;
	Thu,  5 Sep 2024 16:57:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725548263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rBcPsrntGA2sR7NYUTm4f/0fqVqw1hf/h/mg1miiCzQ=;
	b=iXFhQmWSJhhLCBAtaSHppLoL1jtjPXzb76oO4iYwEDRZgp1RMVUCPPIqzJB7diXBw+zS+g
	FWLNIPLm9il95GBQSBFd8F48Ea/rL2SE+mweTnctFik1849Z0ZqmfDD6X7k7HN7Bp1nnfs
	4tXt6qY/YUSRr43QcvO77c3nbBlk5k9Tu6NuaTRyY3D92pqtZbYMS7U4IUYMRW3dNlI8SG
	dWemq4pKNcLkYAnJhA7GZ+yJC+g2DJ8ViVB+dv3byDCH7ZeOa6HDmU1wy92vuSRqv18lSK
	i10GepIN/c/H0y4glaA84+q+V2v4yA0e35A4QbixtGoOuC3BrlGaQehgL8PlSw==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Fri, 06 Sep 2024 00:56:36 +1000
Subject: [PATCH RFC v2 04/10] openat2: add CHECK_FIELDS flag to usize
 argument
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-extensible-structs-check_fields-v2-4-0f46d2de9bad@cyphar.com>
References: <20240906-extensible-structs-check_fields-v2-0-0f46d2de9bad@cyphar.com>
In-Reply-To: <20240906-extensible-structs-check_fields-v2-0-0f46d2de9bad@cyphar.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Florian Weimer <fweimer@redhat.com>, 
 Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, 
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=9718; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=Q9mL5w2RoQs4wSB8ZJ2PbsaEFoNFfd5BJzx5Jald3aw=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaTdPLaZl2N798T7HXO4d7QXt8T2Js+I9NR7//3jWpsFt
 7epc1X1dJSyMIhxMciKKbJs8/MM3TR/8ZXkTyvZYOawMoEMYeDiFICJ6LYz/JU//px7N4/m7Tur
 BX+tMZIy3SXurnU86uKVlLPTrjJwnT3HyDCT2W698BTb3Gq/xu2fWo5neLC/ufJuT2aY7J4te12
 cbnAAAA==
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

In order for userspace to be able to know what flags and fields the
kernel supports, it is currently necessary for them to do a bunch of
fairly subtle self-checks where you need to get a syscall to return a
non-EINVAL error or no-op for each flag you wish to use. If you get
-EINVAL you know the flag is unsupported, otherwise you know it is
supported.

This doesn't scale well for programs that need to check many flags, and
not all syscalls can be easily checked (how would you check for new
flags for umount2 or clone3 without side-effects?). To solve this
problem, we can take advantage of the extensible struct API used by
copy_struct_from_user() by providing a special CHECK_FIELDS flag to
extensible struct syscalls (like openat2 and clone3) which will:

 1. Cause the syscall to fill the structure with every valid bit the
    kernel understands. For flag arguments, this is the set of all valid
    flag bits. For pointer and file descriptor arguments, this would be
    all 0xFF bits (to indicate that any bits are valid). Userspace can
    then easily check whether the flag they wanted is supported (by
    doing a simple bitwise AND) or if a field itself is supported (by
    checking if it is non-zero / all 0xFF).

 2. Return a specific no-op error (-EEXTSYS_NOOP) that is not used as an
    error by any other kernel code, so that userspace can be absolutely
    sure that the kernel supports CHECK_FIELDS.

Rather than passing CHECK_FIELDS using the standard flags arguments for
the syscall, CHECK_FIELDS is instead the highest bit in the provided
struct size. The high bits of the size are never going to be non-zero
(we currently only allow size to be up to PAGE_SIZE, and it seems very
unlikely we will ever allow several exabyte structure arguments).

By passing the flag in the structure size, we can be sure that old
kernels will return a consistent error code (-EFAULT in openat2's case)
and that seccomp can properly filter this syscall mode (which is
guaranteed to be a no-op on all kernels -- it could even force
-EEXTSYS_NOOP to make the userspace program think the kernel doesn't
support any syscall features).

The intended way of using this interface to get feature information
looks something like the following (imagine that openat2 has gained a
new field and a new flag in the future):

  static bool openat2_no_automount_supported;
  static bool openat2_cwd_fd_supported;

  int check_openat2_support(void)
  {
      int err;
      struct open_how how = {};

      err = openat2(AT_FDCWD, ".", &how, CHECK_FIELDS | sizeof(how));
      assert(err < 0);
      switch (errno) {
      case EFAULT: case E2BIG:
          /* Old kernel... */
          check_support_the_old_way();
          break;
      case EEXTSYS_NOOP:
          openat2_no_automount_supported = (how.flags & RESOLVE_NO_AUTOMOUNT);
          openat2_cwd_fd_supported = (how.cwd_fd != 0);
          break;
      }
  }

Link: https://youtu.be/ggD-eb3yPVs
Link: https://lwn.net/Articles/830666/
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 arch/alpha/include/uapi/asm/errno.h        |  3 +++
 arch/mips/include/uapi/asm/errno.h         |  3 +++
 arch/parisc/include/uapi/asm/errno.h       |  3 +++
 arch/sparc/include/uapi/asm/errno.h        |  3 +++
 fs/open.c                                  | 16 ++++++++++++++++
 include/uapi/asm-generic/errno.h           |  3 +++
 include/uapi/linux/openat2.h               |  2 ++
 tools/arch/alpha/include/uapi/asm/errno.h  |  3 +++
 tools/arch/mips/include/uapi/asm/errno.h   |  3 +++
 tools/arch/parisc/include/uapi/asm/errno.h |  3 +++
 tools/arch/sparc/include/uapi/asm/errno.h  |  3 +++
 tools/include/uapi/asm-generic/errno.h     |  3 +++
 12 files changed, 48 insertions(+)

diff --git a/arch/alpha/include/uapi/asm/errno.h b/arch/alpha/include/uapi/asm/errno.h
index 3d265f6babaf..41157139fdad 100644
--- a/arch/alpha/include/uapi/asm/errno.h
+++ b/arch/alpha/include/uapi/asm/errno.h
@@ -125,4 +125,7 @@
 
 #define EHWPOISON	139	/* Memory page has hardware error */
 
+/* For extensible syscalls. */
+#define EEXTSYS_NOOP	140	/* Extensible syscall performed no operation */
+
 #endif
diff --git a/arch/mips/include/uapi/asm/errno.h b/arch/mips/include/uapi/asm/errno.h
index 2fb714e2d6d8..dd1e0ba61105 100644
--- a/arch/mips/include/uapi/asm/errno.h
+++ b/arch/mips/include/uapi/asm/errno.h
@@ -124,6 +124,9 @@
 
 #define EHWPOISON	168	/* Memory page has hardware error */
 
+/* For extensible syscalls. */
+#define EEXTSYS_NOOP	169	/* Extensible syscall performed no operation */
+
 #define EDQUOT		1133	/* Quota exceeded */
 
 
diff --git a/arch/parisc/include/uapi/asm/errno.h b/arch/parisc/include/uapi/asm/errno.h
index 8d94739d75c6..e2f6998ad61c 100644
--- a/arch/parisc/include/uapi/asm/errno.h
+++ b/arch/parisc/include/uapi/asm/errno.h
@@ -122,4 +122,7 @@
 
 #define EHWPOISON	257	/* Memory page has hardware error */
 
+/* For extensible syscalls. */
+#define EEXTSYS_NOOP	258	/* Extensible syscall performed no operation */
+
 #endif
diff --git a/arch/sparc/include/uapi/asm/errno.h b/arch/sparc/include/uapi/asm/errno.h
index 81a732b902ee..1b11e4651093 100644
--- a/arch/sparc/include/uapi/asm/errno.h
+++ b/arch/sparc/include/uapi/asm/errno.h
@@ -115,4 +115,7 @@
 
 #define EHWPOISON	135	/* Memory page has hardware error */
 
+/* For extensible syscalls. */
+#define EEXTSYS_NOOP	136	/* Extensible syscall performed no operation */
+
 #endif
diff --git a/fs/open.c b/fs/open.c
index 30bfcddd505d..3fbb0c82fece 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1451,16 +1451,32 @@ SYSCALL_DEFINE4(openat2, int, dfd, const char __user *, filename,
 		struct open_how __user *, how, size_t, usize)
 {
 	int err;
+	bool check_fields;
 	struct open_how tmp;
 
 	BUILD_BUG_ON(sizeof(struct open_how) < OPEN_HOW_SIZE_VER0);
 	BUILD_BUG_ON(sizeof(struct open_how) != OPEN_HOW_SIZE_LATEST);
 
+	check_fields = usize & CHECK_FIELDS;
+	usize &= ~CHECK_FIELDS;
+
 	if (unlikely(usize < OPEN_HOW_SIZE_VER0))
 		return -EINVAL;
 	if (unlikely(usize > PAGE_SIZE))
 		return -E2BIG;
 
+	if (unlikely(check_fields)) {
+		memset(&tmp, 0, sizeof(tmp));
+		tmp = (struct open_how) {
+			.flags = VALID_OPEN_FLAGS,
+			.mode = S_IALLUGO,
+			.resolve = VALID_RESOLVE_FLAGS,
+		};
+
+		err = copy_struct_to_user(how, usize, &tmp, sizeof(tmp), NULL);
+		return err ?: -EEXTSYS_NOOP;
+	}
+
 	err = copy_struct_from_user(&tmp, sizeof(tmp), how, usize);
 	if (err)
 		return err;
diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
index cf9c51ac49f9..f5bfe081e73a 100644
--- a/include/uapi/asm-generic/errno.h
+++ b/include/uapi/asm-generic/errno.h
@@ -120,4 +120,7 @@
 
 #define EHWPOISON	133	/* Memory page has hardware error */
 
+/* For extensible syscalls. */
+#define EEXTSYS_NOOP	134	/* Extensible syscall performed no operation */
+
 #endif
diff --git a/include/uapi/linux/openat2.h b/include/uapi/linux/openat2.h
index a5feb7604948..6052a504cfa4 100644
--- a/include/uapi/linux/openat2.h
+++ b/include/uapi/linux/openat2.h
@@ -4,6 +4,8 @@
 
 #include <linux/types.h>
 
+#define CHECK_FIELDS (1ULL << 63)
+
 /*
  * Arguments for how openat2(2) should open the target path. If only @flags and
  * @mode are non-zero, then openat2(2) operates very similarly to openat(2).
diff --git a/tools/arch/alpha/include/uapi/asm/errno.h b/tools/arch/alpha/include/uapi/asm/errno.h
index 3d265f6babaf..41157139fdad 100644
--- a/tools/arch/alpha/include/uapi/asm/errno.h
+++ b/tools/arch/alpha/include/uapi/asm/errno.h
@@ -125,4 +125,7 @@
 
 #define EHWPOISON	139	/* Memory page has hardware error */
 
+/* For extensible syscalls. */
+#define EEXTSYS_NOOP	140	/* Extensible syscall performed no operation */
+
 #endif
diff --git a/tools/arch/mips/include/uapi/asm/errno.h b/tools/arch/mips/include/uapi/asm/errno.h
index 2fb714e2d6d8..dd1e0ba61105 100644
--- a/tools/arch/mips/include/uapi/asm/errno.h
+++ b/tools/arch/mips/include/uapi/asm/errno.h
@@ -124,6 +124,9 @@
 
 #define EHWPOISON	168	/* Memory page has hardware error */
 
+/* For extensible syscalls. */
+#define EEXTSYS_NOOP	169	/* Extensible syscall performed no operation */
+
 #define EDQUOT		1133	/* Quota exceeded */
 
 
diff --git a/tools/arch/parisc/include/uapi/asm/errno.h b/tools/arch/parisc/include/uapi/asm/errno.h
index 8d94739d75c6..e2f6998ad61c 100644
--- a/tools/arch/parisc/include/uapi/asm/errno.h
+++ b/tools/arch/parisc/include/uapi/asm/errno.h
@@ -122,4 +122,7 @@
 
 #define EHWPOISON	257	/* Memory page has hardware error */
 
+/* For extensible syscalls. */
+#define EEXTSYS_NOOP	258	/* Extensible syscall performed no operation */
+
 #endif
diff --git a/tools/arch/sparc/include/uapi/asm/errno.h b/tools/arch/sparc/include/uapi/asm/errno.h
index 81a732b902ee..1b11e4651093 100644
--- a/tools/arch/sparc/include/uapi/asm/errno.h
+++ b/tools/arch/sparc/include/uapi/asm/errno.h
@@ -115,4 +115,7 @@
 
 #define EHWPOISON	135	/* Memory page has hardware error */
 
+/* For extensible syscalls. */
+#define EEXTSYS_NOOP	136	/* Extensible syscall performed no operation */
+
 #endif
diff --git a/tools/include/uapi/asm-generic/errno.h b/tools/include/uapi/asm-generic/errno.h
index cf9c51ac49f9..f5bfe081e73a 100644
--- a/tools/include/uapi/asm-generic/errno.h
+++ b/tools/include/uapi/asm-generic/errno.h
@@ -120,4 +120,7 @@
 
 #define EHWPOISON	133	/* Memory page has hardware error */
 
+/* For extensible syscalls. */
+#define EEXTSYS_NOOP	134	/* Extensible syscall performed no operation */
+
 #endif

-- 
2.46.0


