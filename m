Return-Path: <linux-fsdevel+bounces-78861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBLoDme1pGlHpgUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 22:53:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB1B1D1C12
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 22:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 955FE30160D0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2026 21:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BDA2C159E;
	Sun,  1 Mar 2026 21:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZR6TzZVJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E675A237713
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Mar 2026 21:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772401982; cv=none; b=M7dUdAOxx949a/vemwGRmG+pwVjqPvkTKfKvV6UQhJXerixOV+FqDgXOsg6IFHLmVBqG7o3Ty5BW5aKd9N4eg/EQq98kIYjv9sM99cmoU2j1P2h3iqe8ppgjUEV2KCaiwlx/GxTNnLSh4H5Dn7GGtgmsbN7SjJBTpMvOamECBRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772401982; c=relaxed/simple;
	bh=UZuV4vRle4QPExsCoWwOx/8Bt6/Fqaq7WbJVQeadgG4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mJdFu0vRa/XHASwBkoOY6PyfapfQG/TBn7d2TeRtCsHEnmvwR1ipOqlgBXReNoLhbFR4kt4jLq6XERzV9dspl9ERTSu4dIch0F2pzKD2yBvf3UUeUGxv3BP6BvwmzjmacYzL9p/5+m5s+f8y9312UBdF/VZWML5EUduhQDTNX5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZR6TzZVJ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439afc58ac7so895991f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Mar 2026 13:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772401979; x=1773006779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylRWWUwK5o3MfEB7pGrnKLZH79m/zlgSbzMzkIBZ2EE=;
        b=ZR6TzZVJr3DP8uFrAQAqaQLDHdUeHQNdUpwsfIueIbLeUGw8smk1/8T2LpCGzgJ82t
         D8D2zG73T6pUxc8sjxKEOL8aRDgi3L6cp6ZZpopeOjey5McoaxpL+jgKL2rppML3IaFE
         Y4pD+jIoN3seNEsq0etIGExw0i7twrlIVblsmsNVJ9gVTS9dldsWL1DX0uVES4m/7G19
         bblXB7d9T0b8HxN6ZmwjUXU5YUmJOhl2Y4bpYMIJrdNb/N4Hs+nbQVCCaQvsOzYgYozU
         iVISzjeTK9VJkvAn1ylCTASaM7UE0+yhUd/oadVrlgzSOofrE5O5VW/EGxWOv2aSEUow
         XPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772401979; x=1773006779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ylRWWUwK5o3MfEB7pGrnKLZH79m/zlgSbzMzkIBZ2EE=;
        b=K5yNzVSAJlAWP6NzrqXDu868KxNwy3yvWXJ4xuAzPTsbB1S0CRRhVR45/gK29+DUzY
         c5clW1BJ6llqeCBNgmtSRvoz8G/51y1wso+/66U8pCcFJn/HUi6ZbeuNGNUGC2JSLmkQ
         Gj5MtW96QaAJn2VY6LE+8zme5UTxFBFHvY+YQF/Z9FdIAPHbPkQ1sbqbrir1gEb7spLO
         Rk2o6yiLRS6Sr6jznUXS+LWCbzrfO2fYDTYi7rt4P/LrBxuT8Lxi3x7unTfE8BfqRdjN
         IBKnlQNt3c51YGdfLy30QSi8aLS3e3TiKVUJGup11FHC53SlvSpB5x8HJDQNVaTiHTDO
         oY1g==
X-Forwarded-Encrypted: i=1; AJvYcCWSCdjo8JcBNhGi9QP+ZyWeg4P9Y1cJdHvRGjgYk6pwsvywSugVOgczOHMM33sLI5z2ed+06xSYXsb9JH7h@vger.kernel.org
X-Gm-Message-State: AOJu0YzomX+yiRQVqlTa3NnUEFv7p4Y9i/uUBGnSxmksL1wXlYkkLVZc
	cPzTr26DEXVGzqnPKl8VHcjN7Yk5UQtegPse/dGmFwI0LIP1at8mz+By
X-Gm-Gg: ATEYQzxCF/RAo9qkr4cWB0NLuMsXQgkaqS72/+Xi0I7AZ6m/NXMWR6a4WV4d1bjiygd
	Ss9H13Q4rr1IReTmC5Vuuow81kC5I6BFkQxSz+lVxM8GJ6lTEYqji/nhLJ8rbcgE9KTE7D6PxXd
	WZCKCQNoBlxELzOOBVlWVDpi4DYbfrN9pmWzJTTPmtJUPEN5mPVbttYoEMSnz3FTK6XwgMmxe0r
	LcYtN9ojmsd3+LkJjvuOi1s/iIP4cb1aaouRbcwKzAUpdCYcCjuCEahOAJhQawn3ncc2JkRj7Tn
	rVa4UDXNwPd0sSt9OXPSvenxnXm2FIKpfZ1oOPm8U4J3aVUpdvNsK0iCtHieYCzcso0DKwZH88w
	1I5zNxegWAV5qsEn4lgKwKVpk6B/Iigh2ihNH5qi2PWyrazLdjsPqPfVuorM55mYvZ+odmsq9BW
	Z6wTF04Gxc5m1qZ0oLrEiZjlKipRtptyq1Iv1JQ2VB0xBkcIlEnt7aoeQaxOXdX1DZnz7oXdJQn
	pU=
X-Received: by 2002:a5d:588f:0:b0:439:afd8:6235 with SMTP id ffacd0b85a97d-439afd86565mr5809623f8f.18.1772401979049;
        Sun, 01 Mar 2026 13:52:59 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ba2a58dasm61132f8f.27.2026.03.01.13.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 13:52:58 -0800 (PST)
Date: Sun, 1 Mar 2026 21:52:57 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML
 <linux-kernel@vger.kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, kernel test robot <lkp@intel.com>, Russell
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
Message-ID: <20260301215257.7bdad5f1@pumpkin>
In-Reply-To: <4e994e13b48420ef36be686458ce3512657ddb41.1772393211.git.chleroy@kernel.org>
References: <4e994e13b48420ef36be686458ce3512657ddb41.1772393211.git.chleroy@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78861-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linutronix.de,vger.kernel.org,csgroup.eu,efficios.com,citrix.com,linux-foundation.org,intel.com,armlinux.org.uk,lists.infradead.org,kernel.org,linux.ibm.com,ellerman.id.au,gmail.com,lists.ozlabs.org,dabbelt.com,inria.fr,imag.fr,infradead.org,stgolabs.net,igalia.com,zeniv.linux.org.uk,suse.cz];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9FB1B1D1C12
X-Rspamd-Action: no action

On Sun,  1 Mar 2026 20:33:58 +0100
"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:

> After converting powerpc checksum wrappers to scoped user access,
> following build failure happens:
> 
> 	  CC      arch/powerpc/lib/checksum_wrappers.o
> 	In file included from arch/powerpc/lib/checksum_wrappers.c:12:
> 	arch/powerpc/lib/checksum_wrappers.c: In function 'csum_and_copy_from_user':
> 	./include/linux/uaccess.h:691:1: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
> 	  691 | ({                                                                      \
> 	      | ^
> 	./include/linux/uaccess.h:755:37: note: in expansion of macro '__scoped_user_access_begin'
> 	  755 |         for (void __user *_tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl); \
> 	      |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 	./include/linux/uaccess.h:770:9: note: in expansion of macro '__scoped_user_access'
> 	  770 |         __scoped_user_access(read, usrc, size, elbl)
> 	      |         ^~~~~~~~~~~~~~~~~~~~
> 	arch/powerpc/lib/checksum_wrappers.c:17:9: note: in expansion of macro 'scoped_user_read_access_size'
> 	   17 |         scoped_user_read_access_size(src, len, efault)
> 	      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Cast __scoped_user_access_begin() to (void __user *) to fix it.

I posted a patch to fix this in december, I'll find it and resend it.

	David

> 
> Fixes: e497310b4ffb ("uaccess: Provide scoped user access regions")
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> ---
> Thomas, I encountered this problem while preparing some patches to start using
> scope user access widely on powerpc in order to benefit more from masked user
> access. Can you make this patch go into 7.0 as a fix in order avoid dependency
> on this change when we start using scoped user access ?
> 
>  include/linux/uaccess.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 1f3804245c06..5d9f6d45d301 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -752,7 +752,8 @@ USER_ACCESS_GUARD(rw)
>   */
>  #define __scoped_user_access(mode, uptr, size, elbl)					\
>  for (bool done = false; !done; done = true)						\
> -	for (void __user *_tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl); \
> +	for (void __user *_tmpptr = (void __user *)					\
> +				    __scoped_user_access_begin(mode, uptr, size, elbl); \
>  	     !done; done = true)							\
>  		for (CLASS(user_##mode##_access, scope)(_tmpptr); !done; done = true)	\
>  			/* Force modified pointer usage within the scope */		\


