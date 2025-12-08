Return-Path: <linux-fsdevel+bounces-70986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E1CCAE6F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 00:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 516F7305F7F1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Dec 2025 23:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C82E2FDC26;
	Mon,  8 Dec 2025 23:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="eVoFGxxt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779762BE630;
	Mon,  8 Dec 2025 23:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765238266; cv=none; b=JFLwiHOfXhpuZflsWxcVJ4/JmIY6H5wxriXTeQGcDP4hNlbvawlpECqUg8uLkZ0VHXTVxeFms8r2ya4mBKgJJ3JPo+Pr+opJ+983FhwhURV0qFLJEhtFTSLrqinSeqtkTGidzsWAA96DlE1tLflMdEnzzuglbquBuoTnNfKy0Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765238266; c=relaxed/simple;
	bh=OFQ+9EV2ql4+pkj57eoeYj9wkaqN/DTHclo1t1ZGbnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gzMQkKMhks3rdvzZbO6zXqmH6S+0kxq1U3Hh14Iwu6lGOsUDx2PHgSj78J41n9VswTWFeCj/Q4MiNiY7Z+80tYdrAmVb8U7FDQJxfFPMfXTVGFtl0EB6MeJHvsIbc+0RIp1PLzfKpFBnXa4cu8AO7h3Dr80ttemebdXjHBxOvnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=eVoFGxxt; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from mail.zytor.com ([IPv6:2601:646:8081:9483:a28:93fb:4548:76d8])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5B8NtZrE2659554
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 8 Dec 2025 15:55:37 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5B8NtZrE2659554
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025112201; t=1765238145;
	bh=soXAh6Cdh1wIq0+vJmWz4UEmWfkfaPYCK7y4yalc2G8=;
	h=From:To:Cc:Subject:Date:From;
	b=eVoFGxxtRvPjz95ahbrb9nKbVpTti/Ji83vr1n9R2TuHzqa3HQgAmkWHQCKLXiNA8
	 eI+cCokme1uBN+uq06I8lOhx59vvSr1pC2WDL21T2DkuAC4tU+2uasOxEtP9ysD14x
	 XdtDQdV/UigHxRtOgF0m5MA+4YLmUuN6YGTI5AOvmVPQOuTE8JaR2QzZqrbEP9cpca
	 TeInFjghMA02bRmiwjqm805q4bpJ5GDJgk/A90IXb9Yg75OwkJ1UbLeh0Bo0JfCS7X
	 3DTbnfXhQ1d2Fd82ixUNNodBylR+5s4x2aq42ESqzrWbD5IGV5Z3kxhya8PF+Cai41
	 s51WMfur8upXA==
From: "H. Peter Anvin" <hpa@zytor.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H . Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Alexei Starovoitov <ast@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrii Nakryiko <andrii@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        David Lechner <dlechner@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Gatlin Newhouse <gatlin.newhouse@gmail.com>,
        Hao Luo <haoluo@google.com>, Ingo Molnar <mingo@redhat.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Kees Cook <kees@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Marc Herbert <Marc.Herbert@linux.intel.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>,
        Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        NeilBrown <neil@brown.name>, Peter Zijlstra <peterz@infradead.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>,
        Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Blum <thorsten.blum@linux.dev>,
        Uros Bizjak <ubizjak@gmail.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Yafang Shao <laoar.shao@gmail.com>, Ye Bin <yebin10@huawei.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Yufeng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-sparse@vger.kernel.org,
        virtualization@lists.linux.dev, x86@kernel.org
Subject: [GIT PULL] __auto_type conversion for v6.19-rc1
Date: Mon,  8 Dec 2025 15:55:26 -0800
Message-ID: <20251208235528.3670800-1-hpa@zytor.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit c2f2b01b74be8b40a2173372bcd770723f87e7b2:

  Merge tag 'i3c/for-6.19' of git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux (2025-12-08 11:25:14 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-auto.git

for you to fetch changes up to branch auto-type-for-6.19
(4ecc26fa585216f98d71411ce182f9e823d94c8c):

  tools/virtio: replace "__auto_type" with "auto" (2025-12-08 15:32:15 -0800)

----------------------------------------------------------------
H. Peter Anvin (7):
      compiler_types.h: add "auto" as a macro for "__auto_type"
      include/linux: change "__auto_type" to "auto"
      fs/proc: replace "__auto_type" with "const auto"
      arch/nios2: replace "__auto_type" and adjacent equivalent with "auto"
      arch/x86: replace "__auto_type" with "auto"
      selftests/bpf: replace "__auto_type" with "auto"
      tools/virtio: replace "__auto_type" with "auto"

 arch/nios2/include/asm/uaccess.h                      |  8 ++++----
 arch/x86/include/asm/bug.h                            |  2 +-
 arch/x86/include/asm/string_64.h                      |  6 +++---
 arch/x86/include/asm/uaccess_64.h                     |  2 +-
 fs/proc/inode.c                                       | 19 +++++++++----------
 include/linux/cleanup.h                               |  6 +++---
 include/linux/compiler.h                              |  2 +-
 include/linux/compiler_types.h                        | 13 +++++++++++++
 include/linux/minmax.h                                |  6 +++---
 .../testing/selftests/bpf/prog_tests/socket_helpers.h |  9 +++++++--
 tools/virtio/linux/compiler.h                         |  2 +-
 11 files changed, 46 insertions(+), 29 deletions(-)

diff --git a/arch/nios2/include/asm/uaccess.h b/arch/nios2/include/asm/uaccess.h
index b8299082adbe..6ccc9a232c23 100644
--- a/arch/nios2/include/asm/uaccess.h
+++ b/arch/nios2/include/asm/uaccess.h
@@ -172,15 +172,15 @@ do {									\
 
 #define __put_user(x, ptr)						\
 ({									\
-	__auto_type __pu_ptr = (ptr);					\
-	typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);		\
+	auto __pu_ptr = (ptr);						\
+	auto __pu_val = (typeof(*__pu_ptr))(x);				\
 	__put_user_common(__pu_val, __pu_ptr);				\
 })
 
 #define put_user(x, ptr)						\
 ({									\
-	__auto_type __pu_ptr = (ptr);					\
-	typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);		\
+	auto __pu_ptr = (ptr);						\
+	auto __pu_val = (typeof(*__pu_ptr))(x);				\
 	access_ok(__pu_ptr, sizeof(*__pu_ptr)) ?			\
 		__put_user_common(__pu_val, __pu_ptr) :			\
 		-EFAULT;						\
diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index ee23b98353d7..d561a8443c13 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -129,7 +129,7 @@ do {								\
 
 #define __WARN_FLAGS(cond_str, flags)					\
 do {									\
-	__auto_type __flags = BUGFLAG_WARNING|(flags);			\
+	auto __flags = BUGFLAG_WARNING|(flags);				\
 	instrumentation_begin();					\
 	_BUG_FLAGS(cond_str, ASM_UD2, __flags, ARCH_WARN_REACHABLE);	\
 	instrumentation_end();						\
diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 79e9695dc13e..4635616863f5 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -31,7 +31,7 @@ KCFI_REFERENCE(__memset);
 #define __HAVE_ARCH_MEMSET16
 static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
 {
-	const __auto_type s0 = s;
+	const auto s0 = s;
 	asm volatile (
 		"rep stosw"
 		: "+D" (s), "+c" (n)
@@ -44,7 +44,7 @@ static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
 #define __HAVE_ARCH_MEMSET32
 static inline void *memset32(uint32_t *s, uint32_t v, size_t n)
 {
-	const __auto_type s0 = s;
+	const auto s0 = s;
 	asm volatile (
 		"rep stosl"
 		: "+D" (s), "+c" (n)
@@ -57,7 +57,7 @@ static inline void *memset32(uint32_t *s, uint32_t v, size_t n)
 #define __HAVE_ARCH_MEMSET64
 static inline void *memset64(uint64_t *s, uint64_t v, size_t n)
 {
-	const __auto_type s0 = s;
+	const auto s0 = s;
 	asm volatile (
 		"rep stosq"
 		: "+D" (s), "+c" (n)
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index 641f45c22f9d..915124011c27 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -72,7 +72,7 @@ static inline void __user *mask_user_address(const void __user *ptr)
 	return ret;
 }
 #define masked_user_access_begin(x) ({				\
-	__auto_type __masked_ptr = (x);				\
+	auto __masked_ptr = (x);				\
 	__masked_ptr = mask_user_address(__masked_ptr);		\
 	__uaccess_begin(); __masked_ptr; })
 
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 2d3425cfa94b..b7634f975d98 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -303,7 +303,7 @@ static ssize_t proc_reg_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 static ssize_t pde_read(struct proc_dir_entry *pde, struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
-	__auto_type read = pde->proc_ops->proc_read;
+	const auto read = pde->proc_ops->proc_read;
 	if (read)
 		return read(file, buf, count, ppos);
 	return -EIO;
@@ -325,7 +325,7 @@ static ssize_t proc_reg_read(struct file *file, char __user *buf, size_t count,
 
 static ssize_t pde_write(struct proc_dir_entry *pde, struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 {
-	__auto_type write = pde->proc_ops->proc_write;
+	const auto write = pde->proc_ops->proc_write;
 	if (write)
 		return write(file, buf, count, ppos);
 	return -EIO;
@@ -347,7 +347,7 @@ static ssize_t proc_reg_write(struct file *file, const char __user *buf, size_t
 
 static __poll_t pde_poll(struct proc_dir_entry *pde, struct file *file, struct poll_table_struct *pts)
 {
-	__auto_type poll = pde->proc_ops->proc_poll;
+	const auto poll = pde->proc_ops->proc_poll;
 	if (poll)
 		return poll(file, pts);
 	return DEFAULT_POLLMASK;
@@ -369,7 +369,7 @@ static __poll_t proc_reg_poll(struct file *file, struct poll_table_struct *pts)
 
 static long pde_ioctl(struct proc_dir_entry *pde, struct file *file, unsigned int cmd, unsigned long arg)
 {
-	__auto_type ioctl = pde->proc_ops->proc_ioctl;
+	const auto ioctl = pde->proc_ops->proc_ioctl;
 	if (ioctl)
 		return ioctl(file, cmd, arg);
 	return -ENOTTY;
@@ -392,7 +392,7 @@ static long proc_reg_unlocked_ioctl(struct file *file, unsigned int cmd, unsigne
 #ifdef CONFIG_COMPAT
 static long pde_compat_ioctl(struct proc_dir_entry *pde, struct file *file, unsigned int cmd, unsigned long arg)
 {
-	__auto_type compat_ioctl = pde->proc_ops->proc_compat_ioctl;
+	const auto compat_ioctl = pde->proc_ops->proc_compat_ioctl;
 	if (compat_ioctl)
 		return compat_ioctl(file, cmd, arg);
 	return -ENOTTY;
@@ -414,7 +414,7 @@ static long proc_reg_compat_ioctl(struct file *file, unsigned int cmd, unsigned
 
 static int pde_mmap(struct proc_dir_entry *pde, struct file *file, struct vm_area_struct *vma)
 {
-	__auto_type mmap = pde->proc_ops->proc_mmap;
+	const auto mmap = pde->proc_ops->proc_mmap;
 	if (mmap)
 		return mmap(file, vma);
 	return -EIO;
@@ -497,7 +497,7 @@ static int proc_reg_open(struct inode *inode, struct file *file)
 	if (!use_pde(pde))
 		return -ENOENT;
 
-	__auto_type release = pde->proc_ops->proc_release;
+	const auto release = pde->proc_ops->proc_release;
 	if (release) {
 		pdeo = kmem_cache_alloc(pde_opener_cache, GFP_KERNEL);
 		if (!pdeo) {
@@ -534,10 +534,9 @@ static int proc_reg_release(struct inode *inode, struct file *file)
 	struct pde_opener *pdeo;
 
 	if (pde_is_permanent(pde)) {
-		__auto_type release = pde->proc_ops->proc_release;
-		if (release) {
+		const auto release = pde->proc_ops->proc_release;
+		if (release)
 			return release(inode, file);
-		}
 		return 0;
 	}
 
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 0b55a8f6c59e..8d41b917c77d 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -212,10 +212,10 @@
 
 #define __free(_name)	__cleanup(__free_##_name)
 
-#define __get_and_null(p, nullvalue)   \
+#define __get_and_null(p, nullvalue)	    \
 	({                                  \
-		__auto_type __ptr = &(p);   \
-		__auto_type __val = *__ptr; \
+		auto __ptr = &(p);	    \
+		auto __val = *__ptr;	    \
 		*__ptr = nullvalue;         \
 		__val;                      \
 	})
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index ff71bebe56f5..04487c9bd751 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -190,7 +190,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #define data_race(expr)							\
 ({									\
 	__kcsan_disable_current();					\
-	__auto_type __v = (expr);					\
+	auto __v = (expr);						\
 	__kcsan_enable_current();					\
 	__v;								\
 })
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 3eac51d68426..41172a28ce76 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -13,6 +13,19 @@
 
 #ifndef __ASSEMBLY__
 
+/*
+ * C23 introduces "auto" as a standard way to define type-inferred
+ * variables, but "auto" has been a (useless) keyword even since K&R C,
+ * so it has always been "namespace reserved."
+ *
+ * Until at some future time we require C23 support, we need the gcc
+ * extension __auto_type, but there is no reason to put that elsewhere
+ * in the source code.
+ */
+#if __STDC_VERSION__ < 202311L
+# define auto __auto_type
+#endif
+
 /*
  * Skipped when running bindgen due to a libclang issue;
  * see https://github.com/rust-lang/rust-bindgen/issues/2244.
diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index eaaf5c008e4d..a0158db54a04 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -89,7 +89,7 @@
 	__cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
 
 #define __careful_cmp_once(op, x, y, ux, uy) ({		\
-	__auto_type ux = (x); __auto_type uy = (y);	\
+	auto ux = (x); auto uy = (y);			\
 	BUILD_BUG_ON_MSG(!__types_ok(ux, uy),		\
 		#op"("#x", "#y") signedness error");	\
 	__cmp(op, ux, uy); })
@@ -129,7 +129,7 @@
 	__careful_cmp(max, (x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull)
 
 #define __careful_op3(op, x, y, z, ux, uy, uz) ({			\
-	__auto_type ux = (x); __auto_type uy = (y);__auto_type uz = (z);\
+	auto ux = (x); auto uy = (y); auto uz = (z);			\
 	BUILD_BUG_ON_MSG(!__types_ok3(ux, uy, uz),			\
 		#op"3("#x", "#y", "#z") signedness error");		\
 	__cmp(op, ux, __cmp(op, uy, uz)); })
@@ -203,7 +203,7 @@
  * This macro checks @val/@lo/@hi to make sure they have compatible
  * signedness.
  */
-#define clamp(val, lo, hi) __careful_clamp(__auto_type, val, lo, hi)
+#define clamp(val, lo, hi) __careful_clamp(auto, val, lo, hi)
 
 /**
  * clamp_t - return a value clamped to a given range using a given type
diff --git a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
index e02cabcc814e..0d59503a0c73 100644
--- a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
@@ -17,11 +17,16 @@
 #define VMADDR_CID_LOCAL 1
 #endif
 
+/* include/linux/compiler_types.h */
+#if __STDC_VERSION__ < 202311L && !defined(auto)
+# define auto __auto_type
+#endif
+
 /* include/linux/cleanup.h */
 #define __get_and_null(p, nullvalue)                                           \
 	({                                                                     \
-		__auto_type __ptr = &(p);                                      \
-		__auto_type __val = *__ptr;                                    \
+		auto __ptr = &(p);					       \
+		auto __val = *__ptr;                                           \
 		*__ptr = nullvalue;                                            \
 		__val;                                                         \
 	})
diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
index 204ef0e9f542..725b93bfeee1 100644
--- a/tools/virtio/linux/compiler.h
+++ b/tools/virtio/linux/compiler.h
@@ -31,7 +31,7 @@
  */
 #define data_race(expr)							\
 ({									\
-	__auto_type __v = (expr);					\
+	auto __v = (expr);						\
 	__v;								\
 })
 

