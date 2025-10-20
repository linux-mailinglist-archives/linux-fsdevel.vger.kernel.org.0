Return-Path: <linux-fsdevel+bounces-64776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E89BF3CE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 00:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08DBB18A55B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 22:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68BB2F12C1;
	Mon, 20 Oct 2025 22:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVxw38Ss"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362CA20966B;
	Mon, 20 Oct 2025 22:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760997679; cv=none; b=mu/SWYuimaMzUh/1keCRJ9edZ0c0SWNqVauSfkf+ohQ1mNav2kHudYedcscpHN72GNLa4NeRSNnJKFqQX7FgIoKADQfEmF28UFjmEccg6yRD+ddI2sBA+eTepeZ861ksa6yeypXPjSnINJWrCNX9VcSarAnOZCv65wsIQJAtbHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760997679; c=relaxed/simple;
	bh=/jk04nuQCuJInz/KNpaoxJIfVcgkemJOGj6M7ncv4Qs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZQfJ+dUIjxZzDJQ0jV5M/4oOSqZRVOnTUet7hWQGk9JUKKGxab883UNVo/xw29KF0LEpowrt0LS3SWHtLbLyxtlvOwrQWILvrHcWKcxwNGb9m2G7tXDjAUcWkug3MI4UQZLGSDm0sFDxBT5r7siajb6OFKkytvdc79QSdiUSKKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVxw38Ss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B51C113D0;
	Mon, 20 Oct 2025 22:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760997678;
	bh=/jk04nuQCuJInz/KNpaoxJIfVcgkemJOGj6M7ncv4Qs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dVxw38SsaEBpGnRxtU9fHqd60UIUWUzTHw2ty+G4BbTMWORiV4MyiTJpF4KvhA6HZ
	 rK9O1qOcWPaMXfeuHLiq0Bg8hKfdQXw9y8RkDHhh1iGeRwrutb187DsBvlrr90Q0Yq
	 UBCTl/Nhx7ZnlWdgXKJei3iaZ4IrEpPJnszNExWSnU6rT64deH90moN6HekTC4upNz
	 ZE93XY/NHce1wV/p7KSNacI805banw6BNKIzg6mRncZBrnhhXoeEl7uIHg5hp7y7ZY
	 ddd3VWurUVb14fYcAjR71HOJH+00gBMsy5hJa9Zq6tBdO0P9XtEZQLSKlyuP9lrhdq
	 GrNIDqrpXG13g==
From: Kees Cook <kees@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Marco Elver <elver@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Johannes Weiner <hannes@cmpxchg.org>,
	llvm@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Tamir Duberstein <tamird@gmail.com>,
	Michael Kelley <mhklinux@outlook.com>,
	kernel test robot <lkp@intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Yafang Shao <laoar.shao@gmail.com>,
	Marc Herbert <Marc.Herbert@linux.intel.com>,
	Christopher Ferris <cferris@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	Brian Gerst <brgerst@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/3] compiler_types: Introduce __counted_by_ptr()
Date: Mon, 20 Oct 2025 15:01:15 -0700
Message-Id: <20251020220118.1226740-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020220005.work.095-kees@kernel.org>
References: <20251020220005.work.095-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5213; i=kees@kernel.org; h=from:subject; bh=/jk04nuQCuJInz/KNpaoxJIfVcgkemJOGj6M7ncv4Qs=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnfNuq8mHjJ6c3aRUtcjppaq+Zv9Uh+dn63Am9N/aT/H Bkcr3e/6ShlYRDjYpAVU2QJsnOPc/F42x7uPlcRZg4rE8gQBi5OAZiI+1lGhruzI19PnOUiJKb2 9kFKjBXH8+zPFi2rGKLSSzfFTHrxPpKR4ckJ1sSFxw6u68oRYcwszNzRt6CJ5b1t9ZuKQ3PZu+c eZQMA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Introduce __counted_by_ptr(), which works like __counted_by(), but for
pointer struct members:

struct foo {
	int a, b, c;
	char *buffer __counted_by_ptr(bytes);
	short nr_bars;
	struct bar *bars __counted_by_ptr(nr_bars);
	size_t bytes;
};

Since "counted_by" can only be applied to pointer members in very recent
compiler versions, its application ends up needing to be distinct from
flexible array "counted_by" annotations, hence a separate macro.

Unfortunately, this annotation cannot be used for "void *" members
(since such a member is considered a pointer to an incomplete type,
and neither Clang nor GCC developers could be convinced otherwise[1],
even in the face of the GNU extension that "void *" has size "1 byte"
for pointer arithmetic). For "void *" members, we must use the coming
"sized_by" attribute.

Link: https://gcc.gnu.org/pipermail/gcc-patches/2025-May/683136.html [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Marco Elver <elver@google.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: <llvm@lists.linux.dev>
---
 init/Kconfig                   | 11 +++++++++++
 Makefile                       |  4 ++++
 include/linux/compiler_types.h | 21 ++++++++++++++++++++-
 include/uapi/linux/stddef.h    |  4 ++++
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index cab3ad28ca49..54691b086bc6 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -139,6 +139,17 @@ config CC_HAS_COUNTED_BY
 	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
 	default y if CC_IS_GCC && GCC_VERSION >= 150100
 
+config CC_HAS_COUNTED_BY_PTR_BARE
+	def_bool $(success,echo 'struct foo { int *ptr __attribute__((__counted_by__(count))); int count; };' | $(CC) $(CLANG_FLAGS) -x c - -c -o /dev/null -Werror)
+
+config CC_HAS_COUNTED_BY_PTR_EXP
+	def_bool $(success,echo 'struct foo { int *ptr __attribute__((__counted_by__(count))); int count; };' | $(CC) $(CLANG_FLAGS) -fexperimental-late-parse-attributes -x c - -c -o /dev/null -Werror)
+	depends on !CC_HAS_COUNTED_BY_PTR_BARE
+
+config CC_HAS_COUNTED_BY_PTR
+	def_bool y
+	depends on CC_HAS_COUNTED_BY_PTR_BARE || CC_HAS_COUNTED_BY_PTR_EXP
+
 config CC_HAS_MULTIDIMENSIONAL_NONSTRING
 	def_bool $(success,echo 'char tag[][4] __attribute__((__nonstring__)) = { };' | $(CC) $(CLANG_FLAGS) -x c - -c -o /dev/null -Werror)
 
diff --git a/Makefile b/Makefile
index d14824792227..1b297dcbb0df 100644
--- a/Makefile
+++ b/Makefile
@@ -933,6 +933,10 @@ KBUILD_CFLAGS	+= $(CC_AUTO_VAR_INIT_ZERO_ENABLER)
 endif
 endif
 
+ifdef CONFIG_CC_HAS_COUNTED_BY_PTR_EXP
+KBUILD_CFLAGS	+= -fexperimental-late-parse-attributes
+endif
+
 # Explicitly clear padding bits during variable initialization
 KBUILD_CFLAGS += $(call cc-option,-fzero-init-padding-bits=all)
 
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 59288a2c1ad2..f197ea03b593 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -353,11 +353,14 @@ struct ftrace_likely_data {
 #endif
 
 /*
+ * Runtime track number of flexible array member elements for use by
+ * CONFIG_FORTIFY_SOURCE and CONFIG_UBSAN_BOUNDS.
+ *
  * Optional: only supported since gcc >= 15
  * Optional: only supported since clang >= 18
  *
  *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
- * clang: https://github.com/llvm/llvm-project/pull/76348
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#counted-by-counted-by-or-null-sized-by-sized-by-or-null
  *
  * __bdos on clang < 19.1.2 can erroneously return 0:
  * https://github.com/llvm/llvm-project/pull/110497
@@ -371,6 +374,22 @@ struct ftrace_likely_data {
 # define __counted_by(member)
 #endif
 
+/*
+ * Runtime track number of objects pointed to by a pointer member for
+ * use by CONFIG_FORTIFY_SOURCE and CONFIG_UBSAN_BOUNDS.
+ *
+ * Optional: only supported since gcc >= 16
+ * Optional: only supported since clang >= 20
+ *
+ *   gcc: https://gcc.gnu.org/pipermail/gcc-patches/2025-April/681727.html
+ * clang: ...
+ */
+#ifdef CONFIG_CC_HAS_COUNTED_BY_PTR
+# define __counted_by_ptr(member)	__attribute__((__counted_by__(member)))
+#else
+# define __counted_by_ptr(member)
+#endif
+
 /*
  * Optional: only supported since gcc >= 15
  * Optional: not supported by Clang
diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
index 9a28f7d9a334..111b097ec00b 100644
--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -72,6 +72,10 @@
 #define __counted_by_be(m)
 #endif
 
+#ifndef __counted_by_ptr
+#define __counted_by_ptr(m)
+#endif
+
 #ifdef __KERNEL__
 #define __kernel_nonstring	__nonstring
 #else
-- 
2.34.1


