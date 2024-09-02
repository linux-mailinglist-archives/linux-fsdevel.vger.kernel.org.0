Return-Path: <linux-fsdevel+bounces-28205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF36196800B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 09:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306C51F204C3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 07:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016381865E5;
	Mon,  2 Sep 2024 07:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="MxyAvY64"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8468F185E7A;
	Mon,  2 Sep 2024 07:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260860; cv=none; b=UfKwKdSoOL94ZsEnt6ogsbHaYdZkEYVtg1YtyJNaFwYPWMHcN4ET+BE0Dn5bx2/GFi5T6WEJidbcWHvc6ncRZXMPiEB1MvtxBsv4F+ItBusRs0OzVr7r+CdwKc6rfnJXxTUn9onzoOAfE2gHVK6Jnu497/FGTK1mKcwleLdaTR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260860; c=relaxed/simple;
	bh=Us0lHw+koXy06zRiE3emgfGrV39YlTOcFOhgEkut04Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OmQKElYVZBZVrTrBVxs6y1YpQ4J6B4+7MJy2PGJJb5KxCRxV/ddmABpx20CRY4D2nBltssG/oiZGt5PPbbbhajzEuS78bCKREMdjappeAkKgl1gXQFw0kCMy0qTKsRNaivTFF/habkwChcAf4+B+4japjkySViDJQBPvM6nXNyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=MxyAvY64; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Wy0FL6nrdz9slL;
	Mon,  2 Sep 2024 09:07:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725260855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9sZJKX3GJabT5AIbFGGPbQHzQ/KPsbpsEw4GzSz9bvM=;
	b=MxyAvY64owNw8VqXxeeRsei2xThUZq5LKqz+KiJF5tgtxy3NNAnYX/QVj8xmODH+bX3BO0
	/w43V0AwqlUQJ0aAHlWosERBezv0u/2+WGvHjfFM7lKXwwAkD3p4rgk/igdhBKv4r9BsVo
	LfvOi2Gb+tZqxJaENi7v6+bPXVXVB+/CRwBfOoqNUb6XXv2OzcyZSHiK9k1sQINN1DmT+o
	CxGhB2k9FSsKLN2uW/VUSXZvb0zbap0vwKJs3HVJJ/jGWSrOdjJyHyTeINRFjo0wwkdDrA
	eyGOmfeoY+bubp4eDIkdLHBT1GsBWHR5OcULQzfvBvO+9X/MB3DkUEVfheCsgg==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Mon, 02 Sep 2024 17:06:26 +1000
Subject: [PATCH RFC 4/8] openat2: add CHECK_FIELDS flag to usize argument
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-extensible-structs-check_fields-v1-4-545e93ede2f2@cyphar.com>
References: <20240902-extensible-structs-check_fields-v1-0-545e93ede2f2@cyphar.com>
In-Reply-To: <20240902-extensible-structs-check_fields-v1-0-545e93ede2f2@cyphar.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4839; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=Us0lHw+koXy06zRiE3emgfGrV39YlTOcFOhgEkut04Y=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaRdTWEJyzR8/uaC0cdagcOq+V/eery6smfSGS7pwp7De
 SHOR3YUdpSyMIhxMciKKbJs8/MM3TR/8ZXkTyvZYOawMoEMYeDiFICJ9CcxMjR4LtLftmjfpBt+
 39N/nHQ5FeCklFj5pXFOuQrLjkdM3iGMDLcbXSZwhUSWK1ep5r03emc3J10pbHHjoTtqTduXzOU
 y4QEA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4Wy0FL6nrdz9slL

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
 fs/open.c                        | 15 +++++++++++++++
 include/uapi/asm-generic/errno.h |  3 +++
 include/uapi/linux/openat2.h     |  2 ++
 3 files changed, 20 insertions(+)

diff --git a/fs/open.c b/fs/open.c
index 30bfcddd505d..10bfc8d6555c 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1458,6 +1458,21 @@ SYSCALL_DEFINE4(openat2, int, dfd, const char __user *, filename,
 
 	if (unlikely(usize < OPEN_HOW_SIZE_VER0))
 		return -EINVAL;
+
+	if (unlikely(usize & CHECK_FIELDS)) {
+		usize &= ~CHECK_FIELDS;
+
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
 	if (unlikely(usize > PAGE_SIZE))
 		return -E2BIG;
 
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

-- 
2.46.0


