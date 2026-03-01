Return-Path: <linux-fsdevel+bounces-78863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHCZJtG6pGkDqAUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 23:16:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 035301D1D58
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 23:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEDB0300F940
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2026 22:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8863136BCFB;
	Sun,  1 Mar 2026 22:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+zl3912"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E632A36B040
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Mar 2026 22:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772403401; cv=none; b=MLd7H4NWBnQ4w80YMXbiZ5FdOVDeoa3DmCnc4nxFQai9LqwDh9oaaT5c31uuc1Ckl7lyco5lsEeSB8u5cyYEmQi1N3OgFq/xpzT+MxWb90LtKbwamotmkmKHXPIKTAK0zH9DWJLivnNHu0nbNPTserc7hWT0eYa2yp6EHe6mP3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772403401; c=relaxed/simple;
	bh=jN4N1QaNMsASRJ5nI5g5Xxi3W8X39f5t/UYZx/nnQwk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jKL052dJVq1HGu9GBwGr619YRSSP5dREzly8GoOwQmAtvjP2KWwsfNPDkELQzcoM8F4MD4L3Nvw8gLghq2kktJLDddU3WMH7sWRgOYFW+JvqWQa1lD7wvDBbRSsnslETSxODG9RZg5AlTl8FC//QRq0nz9/+WkOYmjNhne/Q9yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+zl3912; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-437711e9195so2899984f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Mar 2026 14:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772403398; x=1773008198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIl/dHV642tMqRZscE3Zjz5R/EkJp5KZJrPHqY8MUl4=;
        b=W+zl3912b0zVCeZU0RDnp9c/Dtefju7bomYh4IPZxIEHwnAfgj4uEM2DvT3+gCKv8z
         eqHEEmkIMC/NtYWMsrm3JOUiYp4Ep7iAh6ZK1HcnUWJsLEX8CL/u3AjKSObBU9TT0n7e
         Q4knzsKstEbkkt8KFiRSzZSkscMW0YY3IW4hQWD7Lrm6rVbGst43AR5HeY6lBvF8qiH3
         2ESUeNC7zSJVc6xUYrtXzNIYK/9zqdLreujMyxsWyJFxzUIe8zsMviDdCM0YG7PFe3TW
         PFgXpJEC4e7VCEktbDFngyXnVY5zZh3IkXitpzHp5f3Mfpa5yBCHs7+t+uKWXntn2bHA
         sDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772403398; x=1773008198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AIl/dHV642tMqRZscE3Zjz5R/EkJp5KZJrPHqY8MUl4=;
        b=hPWKu5T9f8XrNBtBZIOcNUfQAf9NuurcjWP/VqybxDaBP5tCU1M58/qzCGffxKDFE7
         Dxi2ezvwSwn+zaPqjSV/TwPOAE04mH6nHTo3gXq3JWKTUVfFfGpx7Z+JdX3p3LhWSxVn
         WxsmEEqzuOYqpa4eBKWFwT2b2ad45kSpKFudMnnKGJxNN3HlVLM7QLULlH/K42qhIUyu
         pJWdTzMeLJr4iOIlF6Q1jICw1fI76hKqdx04sTyE9rwewWS6s4NLlzDx37on6Crr8Swx
         IWCHva/CkavZckV6Bs8f68QEDPwa98VO+sJHrFBtRtVFCoLWiBx5YxZFovC2ixXBjyFO
         0dPw==
X-Forwarded-Encrypted: i=1; AJvYcCXnNDiUd3QawpYizYenhEkRlMHO6hTcEUU7iBm/J/5Yj66LikocpByO/iZ1nyn7sE2nVoohxEeHDKRQVUV9@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw6upWvfYVnpwwfmtdhD3zeODmPo7Qziea4vf6fimQ71PdaPcx
	c1bvn643++4GcZZ+rkwmoQbFNdnYVwI6hQgUFTgkLaOOb5+EER3f9Rek
X-Gm-Gg: ATEYQzyNOJMIC7tAOcZxuMbOemPko8YgNlugBWINHVBKztxSpQYJhWwTFztBASr2d6t
	fgGei7jKBRpHRJBKhPuyeEj5T1ymXLvAIE1DStENPhTjh3uO6K0qnWS67lc7OIqMKVPOowQ0W5C
	zxvWeboX0x+NQxAauaTYG/nSM/5lGRkj9K8uQ7JUeyimaa7nGWC8ruyJ0exnx7A7ReDMfmNF8IA
	0EKmlEH1BckP/BqoJ0lgT4XkpJK2xTCiUFmpEbrsCZ8YTkbkqMqG0MPcFZsVOs/7Kjl5jxGEH3Z
	uF9+ECZoISAZoipSs5BSoPJKlUSJdEId2xjACoa8IWTWeNEgRZMtSRup19fZ5p7CaNFqgsTP3xe
	Hd1qGWQsWOURD3NDW2ESrRT8dTkmT/BNSTaDsbFlrcF0tZ1RpvOilY/lGiVRhEjGt6xQUoBMTYj
	N+9Wl40Um8P+Wn/CI+09zhVZoosXIvxs2NS+8muwEMMOrVgIfyf8n0urBlXHEVAtVR
X-Received: by 2002:a05:600c:4444:b0:475:de12:d3b5 with SMTP id 5b1f17b1804b1-483c9c323d8mr157846385e9.34.1772403398069;
        Sun, 01 Mar 2026 14:16:38 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b3cc2e65sm6649234f8f.2.2026.03.01.14.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 14:16:37 -0800 (PST)
Date: Sun, 1 Mar 2026 22:16:36 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>, kernel test robot <lkp@intel.com>, Russell
 King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Heiko
 Carstens <hca@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>, Nicolas
 Palix <nicolas.palix@imag.fr>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Andre Almeida <andrealmeid@igalia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] uaccess: Fix build of scoped user access with const
 pointer
Message-ID: <20260301221636.0efa722c@pumpkin>
In-Reply-To: <CAHk-=wixyP1mzyVcpZqQZd_xbabZQ873KVph3L-EkrNZGv3Ygw@mail.gmail.com>
References: <4e994e13b48420ef36be686458ce3512657ddb41.1772393211.git.chleroy@kernel.org>
	<CAHk-=wixyP1mzyVcpZqQZd_xbabZQ873KVph3L-EkrNZGv3Ygw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78863-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linutronix.de,vger.kernel.org,csgroup.eu,efficios.com,citrix.com,intel.com,armlinux.org.uk,lists.infradead.org,linux.ibm.com,ellerman.id.au,gmail.com,lists.ozlabs.org,dabbelt.com,inria.fr,imag.fr,infradead.org,stgolabs.net,igalia.com,zeniv.linux.org.uk,suse.cz];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 035301D1D58
X-Rspamd-Action: no action

On Sun, 1 Mar 2026 12:01:08 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

I also added to compiler.h :

+/*
+ * Sometimes a #define needs to declare a variable that is scoped
+ * to the statement that follows without having mismatched {}.
+ *	with (int x = expression) {
+ *		statements
+ *	}
+ * is the same as:
+ *	{
+ *		int x = expression;
+ *		statements
+ *	}
+ * but lets it all be hidden from the call site, eg:
+ *	frobnicate(args) {
+ *		statements
+ *	} 
+ * Only a single variable can be defined, and_with() allows extra ones
+ * without adding an additional outer loop.
+ *
+ * The controlled scope can be terminated using break, continue or goto.
+ */
+#define with(declaration) \
+	for (bool _with_done = false; !_with_done; _with_done = true)	\
+		and_with (declaration)
+#define and_with(declaration) \
+	for (declaration; !_with_done; _with_done = true)
+

So that you get:
#define __scoped_user_access(mode, uptr, size, elbl)					\
	with (auto _tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl)) \
		and_with (CLASS(user_##mode##_access, scope)(_tmpptr))			\
		/* Force modified pointer usage within the scope */			\
		and_with (const auto uptr = _tmpptr)

The next patch did:
-		and_with (const typeof(uptr) uptr = _tmpptr)
+		__diag_push() __diag_ignore_all("-Wshadow", "uptr is readonly copy")	\
+		and_with (const typeof(uptr) uptr = _tmpptr)				\
+		__diag_pop()

I'll update (to use auto as above) and resend.

	David

