Return-Path: <linux-fsdevel+bounces-28746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B88F96DCD8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 16:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27A61F230E2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 14:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E77B19F43D;
	Thu,  5 Sep 2024 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="SofAB/7g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FFF19EEB1;
	Thu,  5 Sep 2024 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548241; cv=none; b=QHW3y1m8ztzSVwI6Dep0szwGvmfPK9qMclJMIu3lGsNt4uWQgBo+KMdVHXf48vkgnbB1iETM/it+M+PEtG74CjVaeItzHzDkTaoz26rbmbFH4NP7PT9sxjOI7TeHxJOdjWUMxdWAPbbr5Oic9PpGBYxTAIhkm8aVuaR7SNlkd4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548241; c=relaxed/simple;
	bh=RHuQH37fa1aCHevS8Rp4DmyNPF3QBfkxOH5ERfeCQRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LbJ9D8lfaTT9WEtVvzdQY+n11paDy175lLCjz+oMG1zob5C+A0kUojUI7tNsEvwqJrqNOGTdlKD3Tw1aOwAvqHNhzXKi6vKEBi/0+klA3tJd0abZHBiDOJT+WVz/zZh/ICXN7w67vPidp6jdfG4Oy3MMvXlhzJlgCCYVkhgqN14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=SofAB/7g; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4X02Wv31gXz9smK;
	Thu,  5 Sep 2024 16:57:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725548235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35gDDvLQFm6Wi82gl7IXq7L8XXDc6npzVovXGFIyqFM=;
	b=SofAB/7gxxU1YrFa4YK+T0B8nA7QFBCSaKHdW1RLXhYluBbY2qGvagTCD6BQ9+k1ngmiZk
	d6/ujWKvQTSZHhovZrBoEaV6p/MrXS6HW36pRke7l06oW55c3zRwIysY08OY/ayzo+M1JW
	gj8SSJEa+v1WfGbGTJo2VaHNokP+PIMimzemBvV9PV20WdWjOnqw04WJH2LZ4gDmGd4wD4
	aKy0RUZsjsBfV5gKLGvIdgKN9/ivkV0pAiA/YaaGF2z/ZHmCs1QyfaAYr1xdi3e5gg6C0R
	oEw6bjHdhJJeLxOcaCR2+JMiZayT+YOuVrUyfrBWQi8eqs66Qdkh+5v5YZ+YGA==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Fri, 06 Sep 2024 00:56:33 +1000
Subject: [PATCH RFC v2 01/10] uaccess: add copy_struct_to_user helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-extensible-structs-check_fields-v2-1-0f46d2de9bad@cyphar.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7231; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=RHuQH37fa1aCHevS8Rp4DmyNPF3QBfkxOH5ERfeCQRY=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaTdPLa5ZbFuyBb7B0+jO6M0aqXjD+deP2fecfLNabdj9
 6ymblyg31HKwiDGxSArpsiyzc8zdNP8xVeSP61kg5nDygQyhIGLUwAmcqiJkeGJ5Mw3Vf/fWc5u
 uuC7j630YHZU+hOLlACWPYs1I2PVlq1n+MXE2SIVr/zrSWri1OtBQisC40TuHloh8FYsVGjezB5
 Jfz4A
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4X02Wv31gXz9smK

This is based on copy_struct_from_user(), but there is one additional
case to consider when creating a syscall that returns an
extensible-struct to userspace -- how should data in the struct that
cannot fit into the userspace struct be handled (ksize > usize)?

There are three possibilies:

 1. The interface is like sched_getattr(2), where new information will
    be silently not provided to userspace. This is probably what most
    interfaces will want to do, as it provides the most possible
    backwards-compatibility.

 2. The interface is like lsm_list_modules(2), where you want to return
    an error like -EMSGSIZE if not providing information could result in
    the userspace program making a serious mistake (such as one that
    could lead to a security problem) or if you want to provide some
    flag to userspace so they know that they are missing some
    information.

 3. The interface is like statx(2), where there some kind of a request
    mask that indicates what data userspace would like. One could
    imagine that statx2(2) (using extensible structs) would want to
    return -EMSGSIZE if the user explicitly requested a field that their
    structure is too small to fit, but not return an error if the field
    was not explicitly requested. This is kind of a mix between (1) and
    (2) based on the requested mask.

The copy_struct_to_user() helper includes a an extra argument that is
used to return a boolean flag indicating whether there was a non-zero
byte in the trailing bytes that were not copied to userspace. This can
be used in the following ways to handle all three cases, respectively:

 1. Just pass NULL, as you don't care about this case.

 2. Return an error (say -EMSGSIZE) if the argument was set to true by
    copy_struct_to_user().

 3. If the argument was set to true by copy_struct_to_user(), check if
    there is a flag that implies a field larger than usize.

    This is the only case where callers of copy_struct_to_user() should
    check usize themselves. This will probably require scanning an array
    that specifies what flags were added for each version of the flags
    struct and returning an error if the request mask matches any of the
    flags that were added in versions of the struct that are larger than
    usize.

At the moment we don't have any users of (3), so this patch doesn't
include any helpers to make the necessary scanning easier, but it should
be fairly easy to add some if necessary.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 include/linux/uaccess.h | 98 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index d8e4105a2f21..5d0a590ef65d 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -387,6 +387,104 @@ copy_struct_from_user(void *dst, size_t ksize, const void __user *src,
 	return 0;
 }
 
+/**
+ * copy_struct_to_user: copy a struct to userspace
+ * @dst:   Destination address, in userspace. This buffer must be @ksize
+ *         bytes long.
+ * @usize: (Alleged) size of @dst struct.
+ * @src:   Source address, in kernel space.
+ * @ksize: Size of @src struct.
+ * @ignored_trailing: Set to %true if there was a non-zero byte in @src that
+ * userspace cannot see because they are using an smaller struct.
+ *
+ * Copies a struct from kernel space to userspace, in a way that guarantees
+ * backwards-compatibility for struct syscall arguments (as long as future
+ * struct extensions are made such that all new fields are *appended* to the
+ * old struct, and zeroed-out new fields have the same meaning as the old
+ * struct).
+ *
+ * Some syscalls may wish to make sure that userspace knows about everything in
+ * the struct, and if there is a non-zero value that userspce doesn't know
+ * about, they want to return an error (such as -EMSGSIZE) or have some other
+ * fallback (such as adding a "you're missing some information" flag). If
+ * @ignored_trailing is non-%NULL, it will be set to %true if there was a
+ * non-zero byte that could not be copied to userspace (ie. was past @usize).
+ *
+ * While unconditionally returning an error in this case is the simplest
+ * solution, for maximum backward compatibility you should try to only return
+ * -EMSGSIZE if the user explicitly requested the data that couldn't be copied.
+ * Note that structure sizes can change due to header changes and simple
+ * recompilations without code changes(!), so if you care about
+ * @ignored_trailing you probably want to make sure that any new field data is
+ * associated with a flag. Otherwise you might assume that a program knows
+ * about data it does not.
+ *
+ * @ksize is just sizeof(*src), and @usize should've been passed by userspace.
+ * The recommended usage is something like the following:
+ *
+ *   SYSCALL_DEFINE2(foobar, struct foo __user *, uarg, size_t, usize)
+ *   {
+ *      int err;
+ *      bool ignored_trailing;
+ *      struct foo karg = {};
+ *
+ *      if (usize > PAGE_SIZE)
+ *		return -E2BIG;
+ *      if (usize < FOO_SIZE_VER0)
+ *		return -EINVAL;
+ *
+ *      // ... modify karg somehow ...
+ *
+ *      err = copy_struct_to_user(uarg, usize, &karg, sizeof(karg),
+ *				  &ignored_trailing);
+ *      if (err)
+ *		return err;
+ *      if (ignored_trailing)
+ *		return -EMSGSIZE:
+ *
+ *      // ...
+ *   }
+ *
+ * There are three cases to consider:
+ *  * If @usize == @ksize, then it's copied verbatim.
+ *  * If @usize < @ksize, then the kernel is trying to pass userspace a newer
+ *    struct than it supports. Thus we only copy the interoperable portions
+ *    (@usize) and ignore the rest (but @ignored_trailing is set to %true if
+ *    any of the trailing (@ksize - @usize) bytes are non-zero).
+ *  * If @usize > @ksize, then the kernel is trying to pass userspace an older
+ *    struct than userspace supports. In order to make sure the
+ *    unknown-to-the-kernel fields don't contain garbage values, we zero the
+ *    trailing (@usize - @ksize) bytes.
+ *
+ * Returns (in all cases, some data may have been copied):
+ *  * -EFAULT: access to userspace failed.
+ */
+static __always_inline __must_check int
+copy_struct_to_user(void __user *dst, size_t usize, const void *src,
+		    size_t ksize, bool *ignored_trailing)
+{
+	size_t size = min(ksize, usize);
+	size_t rest = max(ksize, usize) - size;
+
+	/* Double check if ksize is larger than a known object size. */
+	if (WARN_ON_ONCE(ksize > __builtin_object_size(src, 1)))
+		return -E2BIG;
+
+	/* Deal with trailing bytes. */
+	if (usize > ksize) {
+		int ret = clear_user(dst + size, rest);
+		if (ret)
+			return ret;
+	}
+	if (ignored_trailing)
+		*ignored_trailing = ksize < usize &&
+			memchr_inv(src + size, 0, rest) != NULL;
+	/* Copy the interoperable parts of the struct. */
+	if (copy_to_user(dst, src, size))
+		return -EFAULT;
+	return 0;
+}
+
 bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size);
 
 long copy_from_kernel_nofault(void *dst, const void *src, size_t size);

-- 
2.46.0


