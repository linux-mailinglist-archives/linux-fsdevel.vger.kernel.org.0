Return-Path: <linux-fsdevel+bounces-78862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLl6HOy2pGkepwUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 23:00:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E961D1C66
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 23:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8E653010253
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2026 22:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B388230DEA2;
	Sun,  1 Mar 2026 21:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgIp2NwM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638A32F28FF
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Mar 2026 21:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772402396; cv=none; b=i7Pc9c4vy/OlY2l4XDGweC/GAuXgRXI4Tqklbno7M/WRtwtW3T/uDFkfEzC7hXsXWGgE9xV7yG+2HvfSgLJTYeatrJk0VZncdcn6z0OFza5M7k2O1U0kLlXw53HwskYfXkmTzTznhNYbvVeuRfOAK8PyJBxPfbw70w5zo/nRhkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772402396; c=relaxed/simple;
	bh=kDs9LBWyn9QMil9Ec3Kwi6PapAxHBc3vX406latBklE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AeuX5jE1y660M9rkBkSQ5O0mTSId/dKE6twTC8QKol8L0S5j4B97KvWSrvUW4ZJ8+0j0mPiFGbvLVYjq1irx14RF9zmCpoLPHv7BMhwgdZUDQgflEB+cN3Bzdsxk2Y5R2DRPll2D5FwEho1qDKWVSZvF7l/QqtDTM3JiR+urw28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgIp2NwM; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439b5d78592so393703f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Mar 2026 13:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772402393; x=1773007193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdF90L2tMXaU2D2ZcWRZkQORWHdME4B3q+DTo4zCDx4=;
        b=EgIp2NwMp0tsJEKn5c7aY7HPhL1T06qlBBgAnbSwW+qZ7d0ogKfQR3SuX/aAuUrg0r
         FznTifxM4H/vjzme8eBF79AG2vklaRUQYk6a/5oQXrO5XJOVpp+uvQS7hGBkAuKqLkw9
         lU+AahxaSFbu4ls8RUb0EDxM5V4LFQ7CqXYim9kxHKcRVJoLFT7vXyOoI64OHgvnR9KI
         3SMKykTmvckkDK/GJokYMy9mNCnz3V5ifHjfNAQzQxHLsJbKweCe3xLqCsfVF6zn+SoC
         pNJ820yXu0lMab0ZhTRu44EhauzrUBgHbk9t/QCg6vMgYoQCZPBaKkq1cHOWo+bZaF2s
         R8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772402393; x=1773007193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XdF90L2tMXaU2D2ZcWRZkQORWHdME4B3q+DTo4zCDx4=;
        b=OC+XWajJsJgOVsXaZAJX43bZpKMlP5AXwdKMT0Ucxuwby0PmK4ihXGtK3ODdMVPvGh
         ZttRwCSQnkMCrr2NaB0QT+fm9i4bzBff3I9c/pVDApbRoMwKFUjUX7+D6+upO2Xoi292
         Y6eeaapxft6GzT/8BxTRrWifMttrNSxu3GOnauPHG93uU/bH22OR3e88v1BIqj+qvA19
         NljIqnBszBSYC1maOyGguHL0wxUPkhu/om2A4IiXDxeo1Ei719NPHiY5C6gI0S2egMsk
         IIWpJax8Xb+AWYNHS2HiJWLIZUQ89O2d1Hu2Ki05wEU4Nxky2LQ4t7/IICekL5tK5EdL
         IFGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB6i6+t3Qu6Qfam1ouBAOd1xtBvhVAFQYbPxB5lXPCGIM3thY98MdzlRryXBpZ/daGwZ82CiKZeTSyHW9y@vger.kernel.org
X-Gm-Message-State: AOJu0YwdARbWhkvj+Vp+a2rbGxQFijesYjtHI1Fs/aPHtYEAxDb3iPM1
	QcfgqXJwmle8lj9oCx4ozIzL1bmjNPN/FZrXnNmTxpNs7u6d7MYVr+6C
X-Gm-Gg: ATEYQzxID01O/1oaAzMeGX34EuuXfy85c+VUYviJtOLqqKUwLJG4FBI+x5mVWTAKVYJ
	mFBFGkzcKuhWYxjuxwabCb//fBS95shl7gceUl4kCw2pBVQN7x/72kfLfZt7vSb5k4nmMoqDnuD
	HIefU8d5eDWAr8Kb+suwJioZSQlTMaUZITvQdBDgLSjat3kr4diz2B0oQGzpcQIPCE37Mol/KsU
	DI5ZWltZ6wxLhJtpjWnAFIw2woad4/4ewRj2v+sLy48cgoPDzwVD39oKPQGrIXXjC5Htzw2CktO
	xthkRXk96tBn/Sx46Z+NUiLDTGlmuef2+C+ejwPMFHI7xGWwjSgCWBxQstImXusflY5h+e4DvLQ
	uaHMGAQoBs3/1gwzmBXMY+nfA3j4CEemM0xXjZgTZlI2ijF43HK5W0V26mywH/dKK+CMhkCoCX8
	p9rSmgRxBTuR52bjTK0WQ11UkRXv2WBUyyklheLeRJJp0vGoLheP20lpOcZAYfmkto
X-Received: by 2002:a05:6000:18a6:b0:439:b886:20cd with SMTP id ffacd0b85a97d-439b886219amr989086f8f.16.1772402392592;
        Sun, 01 Mar 2026 13:59:52 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c75a523sm22434797f8f.19.2026.03.01.13.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 13:59:52 -0800 (PST)
Date: Sun, 1 Mar 2026 21:59:50 +0000
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
Message-ID: <20260301215950.2fef5722@pumpkin>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78862-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:email]
X-Rspamd-Queue-Id: 25E961D1C66
X-Rspamd-Action: no action

On Sun, 1 Mar 2026 12:01:08 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, 1 Mar 2026 at 11:34, Christophe Leroy (CS GROUP)
> <chleroy@kernel.org> wrote:
> >
> > -       for (void __user *_tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl); \
> > +       for (void __user *_tmpptr = (void __user *)                                     \
> > +                                   __scoped_user_access_begin(mode, uptr, size, elbl); \  
> 
> Why are you casting this return value? Wouldn't it be a lot better to
> just make the types be the CORRECT ones?
> 
> I didn't test this, so maybe I'm missing something, but why isn't that
> just doing
> 
>         for (auto _tmpptr = __scoped_user_access_begin(mode, uptr,
> size, elbl);         \
> 
> instead? No cast, just a "use the right type automatically".
> 
> That macro actually does something similar just a few lines later, in
> that the innermost loop uses
> 
>          for (const typeof(uptr) uptr = _tmpptr; !done; done = true)
> 
> which picks up the type automatically from the argument (and then it
> uses the argument both for the type and name, which is horrendously
> confusing, but that's a separate thing).
> 
> Does that simple "auto" approach break something else?

This is what I needed to do:
(Note that is pre-dates 'auto', but it should work.)
Send at 21:56 on dec 20.

If a 'const struct foo __user *ptr' is used for the address passed
to scoped_user_read_access() then you get a warning/error
uaccess.h:691:1: error: initialization discards 'const' qualifier
    from pointer target type [-Werror=discarded-qualifiers]
for the
    void __user *_tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl)
assignment.

Fix by using typeof(uptr) in that assignment and changing the 'read' functions
to use 'const void __user *ptr' rather than 'void __user *ptr'.

Fixes: e497310b4ffb "(uaccess: Provide scoped user access regions)"
Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/uaccess.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 1f3804245c06..c5d5f2d395bc 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -650,32 +650,32 @@ static inline void user_access_restore(unsigned long flags) { }
 #define user_rw_access_end()		user_access_end()
 
 /* Scoped user access */
-#define USER_ACCESS_GUARD(_mode)				\
-static __always_inline void __user *				\
-class_user_##_mode##_begin(void __user *ptr)			\
+#define USER_ACCESS_GUARD(_mode, type)				\
+static __always_inline type __user *				\
+class_user_##_mode##_begin(type __user *ptr)			\
 {								\
 	return ptr;						\
 }								\
 								\
 static __always_inline void					\
-class_user_##_mode##_end(void __user *ptr)			\
+class_user_##_mode##_end(type __user *ptr)			\
 {								\
 	user_##_mode##_access_end();				\
 }								\
 								\
-DEFINE_CLASS(user_ ##_mode## _access, void __user *,		\
+DEFINE_CLASS(user_ ##_mode## _access, type __user *,		\
 	     class_user_##_mode##_end(_T),			\
-	     class_user_##_mode##_begin(ptr), void __user *ptr)	\
+	     class_user_##_mode##_begin(ptr), type __user *ptr)	\
 								\
 static __always_inline class_user_##_mode##_access_t		\
-class_user_##_mode##_access_ptr(void __user *scope)		\
+class_user_##_mode##_access_ptr(type __user *scope)		\
 {								\
 	return scope;						\
 }
 
-USER_ACCESS_GUARD(read)
-USER_ACCESS_GUARD(write)
-USER_ACCESS_GUARD(rw)
+USER_ACCESS_GUARD(read, const void)
+USER_ACCESS_GUARD(write, void)
+USER_ACCESS_GUARD(rw, void)
 #undef USER_ACCESS_GUARD
 
 /**
@@ -752,7 +752,7 @@ USER_ACCESS_GUARD(rw)
  */
 #define __scoped_user_access(mode, uptr, size, elbl)					\
 for (bool done = false; !done; done = true)						\
-	for (void __user *_tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl); \
+	for (typeof(uptr) _tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl); \
 	     !done; done = true)							\
 		for (CLASS(user_##mode##_access, scope)(_tmpptr); !done; done = true)	\
 			/* Force modified pointer usage within the scope */		\
-- 
2.39.5

	David

> 
>                    Linus


