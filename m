Return-Path: <linux-fsdevel+bounces-65097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B335BFBF4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 14:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B95E4FE76E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 12:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FFD3451C4;
	Wed, 22 Oct 2025 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S//Em47h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jNKXbM8s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DC53446BB;
	Wed, 22 Oct 2025 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137369; cv=none; b=NlL49WT+fNNgNRKyJSV3w6B3LAELapaNRCM+HQP461b3vTO7b8mNA8b4wgfjxKYu0ItCAQPQ1xqCYJ+D2W2uGvutS+kg0ZN4j/P0UriHRkfv97AY+tCBidNi0Gy9Fopv6flshZY9yMPy6yG3d6+5sHB1qz9ro18dPkcxwpI2QVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137369; c=relaxed/simple;
	bh=l9G4ctLYOMGwtTX6nk+DNb4ZjojzIG2SkzsIOvkMTJA=;
	h=Message-ID:From:To:Subject:References:MIME-Version:Content-Type:
	 cc:Date; b=Y1AkN17ASg103ZknR0TI5rVi9VxOSCrrLc5dNXFWHQ9Z0vzrFyT/0mjgeXnY8pkQErVDG3gjddJu2OMf0TLZN+q1B7zLyplfB6ShUuAjeSvMcEriQuneU4Ad5tM4PV7cIEWZgii+3lfuS/F5XtnVVXPIT0VDKE1un1HOa3G//00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S//Em47h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jNKXbM8s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022103112.358808928@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=QD4vFggFMuOeGOcQhDOiteuemKWf4EcukV9nF7jSRjE=;
	b=S//Em47hao2SiEu4HhbNJvmg7y21pNf1gaVLrhJjCcmZbZo071nDxTNXRELCYqZoPooIxF
	ySg3zehiSqSGF/Zy/PoAZ0h0eWVHnK7p5NECvAG631LkvrKKpA02NnT8HJhQZpUPjjGdto
	DxLzSxnTExD3XmpQxp/1w9NAA1kCPWdDRNW5/s+Ed7BI6inW+w0EztY5DPaQKDxXkxI25m
	W2VKIMRifCPS/nvbDcv4t+ALLahmQ72ecuN0xD3h7xqOz54s2emMHzywywwyatoR89R+VO
	HWXCuuqWv5QLlnqsJgwt24DUtrnfgD83c17QYqwpHiorT55OZe+4eLnlakdUyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=QD4vFggFMuOeGOcQhDOiteuemKWf4EcukV9nF7jSRjE=;
	b=jNKXbM8s9KXys2skLRaFhNaomPmHf3yWyLJ+u2hte0dUfgf8E6lPCUahh/LtI3X0E3G6xz
	MQOaMMLQpwzewRAw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V4 08/12] uaccess: Provide put/get_user_scoped()
References: <20251022102427.400699796@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
cc: kernel test robot <lkp@intel.com>,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 x86@kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 David Laight <david.laight.linux@gmail.com>,
 Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>,
 Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Date: Wed, 22 Oct 2025 14:49:11 +0200 (CEST)

Provide conveniance wrappers around scoped user access similiar to
put/get_user(), which reduce the usage sites to:

       if (!get_user_scoped(val, ptr))
       		return -EFAULT;

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: Rename to scoped
---
 include/linux/uaccess.h |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -825,6 +825,50 @@ for (bool done = false; !done; done = tr
 #define scoped_user_rw_access(uptr, elbl)				\
 	scoped_user_rw_access_size(uptr, sizeof(*(uptr)), elbl)
 
+/**
+ * get_user_scoped - Read user data with scoped access
+ * @val:	The variable to store the value read from user memory
+ * @usrc:	Pointer to the user space memory to read from
+ *
+ * Return: true if successful, false when faulted
+ */
+#define get_user_scoped(val, usrc)				\
+({								\
+	__label__ efault;					\
+	typeof(usrc) _tmpsrc = usrc;				\
+	bool _ret = true;					\
+								\
+	scoped_user_read_access(_tmpsrc, efault)		\
+		unsafe_get_user(val, _tmpsrc, efault);		\
+	if (0) {						\
+	efault:							\
+		_ret = false;					\
+	}							\
+	_ret;							\
+})
+
+/**
+ * put_user_scoped - Write to user memory with scoped access
+ * @val:	The value to write
+ * @udst:	Pointer to the user space memory to write to
+ *
+ * Return: true if successful, false when faulted
+ */
+#define put_user_scoped(val, udst)				\
+({								\
+	__label__ efault;					\
+	typeof(udst) _tmpdst = udst;				\
+	bool _ret = true;					\
+								\
+	scoped_user_write_access(_tmpdst, efault)		\
+		unsafe_put_user(val, _tmpdst, efault);		\
+	if (0) {						\
+	efault:							\
+		_ret = false;					\
+	}							\
+	_ret;							\
+})
+
 #ifdef CONFIG_HARDENED_USERCOPY
 void __noreturn usercopy_abort(const char *name, const char *detail,
 			       bool to_user, unsigned long offset,


