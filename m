Return-Path: <linux-fsdevel+bounces-57751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D65DB24EB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 18:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330D61890152
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7940280CE5;
	Wed, 13 Aug 2025 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CFyQNZ/l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BSSA30cF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5540927C17E;
	Wed, 13 Aug 2025 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100627; cv=none; b=KCfMke3tXJeCaiQBnbFOuhEJj1yb23I6Q1Y3V29pznbxPzvSQTu/rhGYrGs6T5xtuMG0ECGWK71iaK7PU7IH246HKh7iffTo7Cu8/Or8sS5/5nbvK8l92iuLP1gJVyUh6U9TaT+DY7JnLqzCuMOZxGbZAzzb6SURh+bwyDT6hwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100627; c=relaxed/simple;
	bh=jA+0sMP4SewpmsVXPH8GQk8pquwKEOh/slij1DIPY9M=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=MWDL52Bv8ocG0xReORFLy1I1SoidAyJZy4K9G5AODTKYjGD/WgjTRVFY8lAIr77nlYadihNub+J/EcYpsqPYQepJhxzI4bmHQl85BADKSehO29XrRCRWmmCZzprWa4mdNIH92fe57OAz9vhT3Asvc4izl8tStJzOSv4sOKbHSRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CFyQNZ/l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BSSA30cF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250813151939.601040635@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755100623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=BfY+v7vpNkuWhXADypqmoATuytn1XJTFj6r0vQIQack=;
	b=CFyQNZ/lJBbgWdUSzLIQ/0jl4R344aHDpanILBMHGO4ipRVk0/tvgqSf592FYxekbHOudF
	1MqkqsZXOb5+j+GGwHl/Pw3ZnhJPajSpchGu1vcLvqjqUDxnB0sc1rTTBUfzrs7YDDX/+x
	AFqlk94060Db4hZjBmIH7eZTYpfiSWvdDry7iWOe9iPedPS/oHkQU6ootJMuZfoL79zhBl
	InoBB+nCMXUL+WJBI70X2CDGCitL6zeUcEIjjnG8DS4W07mJw+V838BUk/1B/Sv0eKge5d
	jZ085OSGilkq2n+cBZobDZ1KRTyTdTd7+xEfVbhYjeo0FDIQxms4OPP8YrPaog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755100623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=BfY+v7vpNkuWhXADypqmoATuytn1XJTFj6r0vQIQack=;
	b=BSSA30cFdHGPYQtrC+ni4uZV0WOmDnNd5JhLOgoEzxoQJ/QIav+Aq6ej4Wal8VL9Bw8RVf
	rn/3NK44qS2vnYBg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 x86@kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: [patch 1/4] uaccess: Provide common helpers for masked user access
References: <20250813150610.521355442@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 17:57:02 +0200 (CEST)

commit 2865baf54077 ("x86: support user address masking instead of
non-speculative conditional") provided an optimization for
unsafe_get/put_user(), which optimizes the Spectre-V1 mitigation in an
architecture specific way. Currently only x86_64 supports that.

The required code pattern is:

	if (can_do_masked_user_access())
		dst = masked_user_access_begin(dst);
	else if (!user_write_access_begin(dst, sizeof(*dst)))
		return -EFAULT;
	unsafe_put_user(val, dst, Efault);
	user_read_access_end();
	return 0;
Efault:
	user_read_access_end();
	return -EFAULT;

The futex code already grew an instance of that and there are other areas,
which can be optimized, when the calling code actually verified before,
that the user pointer is both aligned and actually in user space.

Use the futex example and provide generic helper inlines for that to avoid
having tons of copies all over the tree.

This provides get/put_user_masked_uNN() where $NN is the variable size in
bits, i.e. 8, 16, 32, 64.

The second set of helpers is to encapsulate the prologue for larger access
patterns, e.g. multiple consecutive unsafe_put/get_user() scenarioes:

	if (can_do_masked_user_access())
		dst = masked_user_access_begin(dst);
	else if (!user_write_access_begin(dst, sizeof(*dst)))
		return -EFAULT;
	unsafe_put_user(a, &dst->a, Efault);
	unsafe_put_user(b, &dst->b, Efault);
	user_write_access_end();
	return 0;
Efault:
	user_write_access_end();
	return -EFAULT;

which allows to shorten this to:

	if (!user_write_masked_begin(dst))
		return -EFAULT;
	unsafe_put_user(a, &dst->a, Efault);
	...

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/uaccess.h |   78 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -569,6 +569,84 @@ static inline void user_access_restore(u
 #define user_read_access_end user_access_end
 #endif
 
+/*
+ * Conveniance macros to avoid spreading this pattern all over the place
+ */
+#define user_read_masked_begin(src) ({					\
+	bool __ret = true;						\
+									\
+	if (can_do_masked_user_access())				\
+		src = masked_user_access_begin(src);			\
+	else if (!user_read_access_begin(src, sizeof(*src)))		\
+		__ret = false;						\
+	__ret;								\
+})
+
+#define user_write_masked_begin(dst) ({					\
+	bool __ret = true;						\
+									\
+	if (can_do_masked_user_access())				\
+		dst = masked_user_access_begin(dst);			\
+	else if (!user_write_access_begin(dst, sizeof(*dst)))		\
+		__ret = false;						\
+	__ret;								\
+})
+
+/*
+ * get_user_masked_uNN() and put_user_masked_uNN() where NN is the size of
+ * the variable in bits. Supported values are 8, 16, 32 and 64.
+ *
+ * These functions can be used to optimize __get_user() and __put_user()
+ * scenarios, if the architecture supports masked user access. This avoids
+ * the more costly speculation barriers. If the architecture does not
+ * support it, it falls back to user_*_access_begin().
+ *
+ * As with __get/put_user() the user pointer has to be verified by the
+ * caller to be actually in user space.
+ */
+#define GEN_GET_USER_MASKED(type)					\
+	static __always_inline						\
+	int get_user_masked_##type (type *dst, type __user *src)	\
+	{								\
+		type val;						\
+									\
+		if (!user_read_masked_begin(src))			\
+			return -EFAULT;					\
+		unsafe_get_user(val, src, Efault);			\
+		user_read_access_end();					\
+		*dst = val;						\
+		return 0;						\
+	Efault:								\
+		user_read_access_end();					\
+		return -EFAULT;						\
+	}
+
+GEN_GET_USER_MASKED(u8)
+GEN_GET_USER_MASKED(u16)
+GEN_GET_USER_MASKED(u32)
+GEN_GET_USER_MASKED(u64)
+#undef GEN_GET_USER_MASKED
+
+#define GEN_PUT_USER_MASKED(type)					\
+	static __always_inline						\
+	int put_user_masked_##type (type val, type __user *dst)		\
+	{								\
+		if (!user_write_masked_begin(dst))			\
+			return -EFAULT;					\
+		unsafe_put_user(val, dst, Efault);			\
+		user_write_access_end();				\
+		return 0;						\
+	Efault:								\
+		user_write_access_end();				\
+		return -EFAULT;						\
+	}
+
+GEN_PUT_USER_MASKED(u8)
+GEN_PUT_USER_MASKED(u16)
+GEN_PUT_USER_MASKED(u32)
+GEN_PUT_USER_MASKED(u64)
+#undef GEN_PUT_USER_MASKED
+
 #ifdef CONFIG_HARDENED_USERCOPY
 void __noreturn usercopy_abort(const char *name, const char *detail,
 			       bool to_user, unsigned long offset,


