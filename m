Return-Path: <linux-fsdevel+bounces-64445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D11BE7FEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 12:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52352428BBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 10:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50B431DDBA;
	Fri, 17 Oct 2025 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JcAYfksQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DnX8ZWmy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3202331AF15;
	Fri, 17 Oct 2025 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695755; cv=none; b=WAWRMxmaE+mmJTe0PT+kQ7Rti3ETv0k8oe2UpFV76A6yiPlf4+SmpVhR2cbBhkjpZdHEgi+s6nCqZB2utGSzfBKlMzy0UOxF+Mjz6LFz3qNp4VhTSBHODbO6UX/iC7+jgycQl1QByd7/Au9Lz9MKw11CO+o3TMEZid7etlpxuDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695755; c=relaxed/simple;
	bh=na43TUgjqW9GtM5apYEfH5YukE3UrvIAE4IgfYLHTJ0=;
	h=Message-ID:From:To:Subject:References:MIME-Version:Content-Type:
	 cc:Date; b=MJTjm0xNkS0YyS/wiDctUGqj/fPA89MHHg7b/hWFoHrom1vGD3siAc6lxNVhgRlKf6f1zwBJt89mWBPQ8542zFDbgF+iAAOSVYEpMhXFgy2TG2XZE1ZajP9xUaKq93ay4MIwRdzkDdvPa4Z/Ag4nInaNdQNE0sW2lHaXPwL6a9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JcAYfksQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DnX8ZWmy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251017093030.315578108@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760695751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=vd38qmen6NqGKwpBNmxeBxrmUMKgHzuu9w3FhQnzP9o=;
	b=JcAYfksQjgseU6JQSYgkc8FtMvPTo+BADwor0oMs+Wk9DC39l2Coe+sbE7+SDOueo3i1gw
	JGzB712onYnG/ENdPxx83uMwA8j+HjvyScQpX1fYKd5Q17dKeeWxIiTfCL3yaPBBgYtJnH
	uxT5lmG/p6AnqJZto66uFkr03ODvm2yhfKyWqXt4x/QbgkX5jLrhxBYu7qGphXY5iJzhff
	zoDMEx2yQkwcNlf4yDJTV9VYxcYYVa3jqYOXQiu4upVIB8qxSdV6X4By3AdGKSX5BQaMpF
	xroG39Z+EO5YYcDq2HlRO5gltDwITYHsE485kHCPtUjH9mUI9sjTeWv64gY1Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760695751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=vd38qmen6NqGKwpBNmxeBxrmUMKgHzuu9w3FhQnzP9o=;
	b=DnX8ZWmywsPakWjMIvDYYLxa0MyU0uYz7SqZaZDlR9T/Fn9DUAXcsl7O4z6oJS67E42bZ8
	CqhlmgxJxTHEi3Cg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V3 08/12] uaccess: Provide put/get_user_masked()
References: <20251017085938.150569636@linutronix.de>
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
Date: Fri, 17 Oct 2025 12:09:10 +0200 (CEST)

Provide conveniance wrappers around scoped masked user access similiar to
put/get_user(), which reduce the usage sites to:

       if (!get_user_masked(val, ptr))
       		return -EFAULT;

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/uaccess.h |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -830,6 +830,50 @@ for (bool ____stop = false; !____stop; _
 #define scoped_masked_user_rw_access(_uptr, _elbl)				\
 	scoped_masked_user_rw_access_size((_uptr), sizeof(*(_uptr)), _elbl)
 
+/**
+ * get_user_masked - Read user data with masked access
+ * @_val:	The variable to store the value read from user memory
+ * @_usrc:	Pointer to the user space memory to read from
+ *
+ * Return: true if successful, false when faulted
+ */
+#define get_user_masked(_val, _usrc)				\
+({								\
+	__label__ efault;					\
+	typeof((_usrc)) _tmpsrc	= (_usrc);			\
+	bool ____ret = true;					\
+								\
+	scoped_masked_user_read_access(_tmpsrc, efault)		\
+		unsafe_get_user(_val, _tmpsrc, efault);		\
+	if (0) {						\
+	efault:							\
+		____ret = false;				\
+	}							\
+	____ret;						\
+})
+
+/**
+ * put_user_masked - Write to user memory with masked access
+ * @_val:	The value to write
+ * @_udst:	Pointer to the user space memory to write to
+ *
+ * Return: true if successful, false when faulted
+ */
+#define put_user_masked(_val, _udst)				\
+({								\
+	__label__ efault;					\
+	typeof((_udst)) _tmpdst	= (_udst);			\
+	bool ____ret = true;					\
+								\
+	scoped_masked_user_write_access(_tmpdst, efault)	\
+		unsafe_put_user(_val, _tmpdst, efault);		\
+	if (0) {						\
+	efault:							\
+		____ret = false;				\
+	}							\
+	____ret;						\
+})
+
 #ifdef CONFIG_HARDENED_USERCOPY
 void __noreturn usercopy_abort(const char *name, const char *detail,
 			       bool to_user, unsigned long offset,


