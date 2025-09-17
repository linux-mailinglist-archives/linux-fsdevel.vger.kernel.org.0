Return-Path: <linux-fsdevel+bounces-61926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F352B7EA80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8F42A10CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 12:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E193233FF;
	Wed, 17 Sep 2025 12:50:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FA42F7ABF;
	Wed, 17 Sep 2025 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113438; cv=none; b=ZkRRI8MiowFcEpO5ijKOWYYuEyDmlotjtUrrcVMrwfk7LtqNar/06WaJMBgfA36TIEw7m/jV9TsXBnTZTZ6w4TLdIEVF5pwRmO4YTjKYyQ5dCPdVJHI0bL/kyd6IHCTIiY6WZsSgigxjo6dpDYQdESJXqap8StLHm1rEafPkTfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113438; c=relaxed/simple;
	bh=b49q9IBEZTvi0/7BhRUf9xYDSnZFZjimws3ifu5xzpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KdVFW4RBEZRqv90XoCYjB3R1as8TGclsZnMxvJthKQomwJPf4HGbs0H3RE4Ue1n9uYvhtsl8mtl69Tg6YqvgCojn+IJPCfY7RBLjCT300hRVoHVKyvuT3DfQwPLe3H+7r141b2KXrAv/ASr+eXAAioPRv5rj/arIU1pto4yNLtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cRdXQ3MrBz9sSX;
	Wed, 17 Sep 2025 14:35:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2hByasP5zA5U; Wed, 17 Sep 2025 14:35:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cRdXN460gz9sSW;
	Wed, 17 Sep 2025 14:35:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5A9278B768;
	Wed, 17 Sep 2025 14:35:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id sCBsXy1_jEJK; Wed, 17 Sep 2025 14:35:32 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 977AD8B763;
	Wed, 17 Sep 2025 14:35:31 +0200 (CEST)
Message-ID: <179737a1-8847-46e0-b8d2-aba89968d481@csgroup.eu>
Date: Wed, 17 Sep 2025 14:35:31 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 1/6] ARM: uaccess: Implement missing
 __get_user_asm_dword()
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, kernel test robot <lkp@intel.com>,
 linux-arm-kernel@lists.infradead.org, Nathan Chancellor <nathan@kernel.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, x86@kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
References: <aMnV-hAwRnLJflC7@shell.armlinux.org.uk> <875xdhaaun.ffs@tglx>
 <aMqCPVmOArg8dIqR@shell.armlinux.org.uk>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <aMqCPVmOArg8dIqR@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 17/09/2025 à 11:41, Russell King (Oracle) a écrit :
> You may think this is easy to solve, just change the last cast to:
> 
>          (x) = (__typeof__(*(ptr)))(__typeof__(x))__gu_val;
> 
> but that doesn't work either (because in the test case __typeof__(x) is
> still a pointer type. You can't cast this down to a 32-bit quantity
> because that will knock off the upper 32 bits for the case you're trying
> to add.
> 
> You may think, why not  move this cast into each switch statement...
> there will still be warnings because the cast is still reachable at the
> point the compiler evaluates the code for warnings, even though the
> optimiser gets rid of it later.
> 
> Feel free to try to solve this, but I can assure you that you certainly
> are not the first. Several people have already tried.
> 

No such problem on powerpc/32, maybe because we have defined and use 
macro __long_type(x), see below:

#define __get_user_size_allowed(x, ptr, size, retval)		\
do {								\
	retval = 0;						\
	BUILD_BUG_ON(size > sizeof(x));				\
	switch (size) {						\
	case 1: __get_user_asm(x, (u8 __user *)ptr, retval, "lbz"); break;	\
	case 2: __get_user_asm(x, (u16 __user *)ptr, retval, "lhz"); break;	\
	case 4: __get_user_asm(x, (u32 __user *)ptr, retval, "lwz"); break;	\
	case 8: __get_user_asm2(x, (u64 __user *)ptr, retval);  break;	\
	default: x = 0; BUILD_BUG();				\
	}							\
} while (0)

/*
  * This is a type: either unsigned long, if the argument fits into
  * that type, or otherwise unsigned long long.
  */
#define __long_type(x) \
	__typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))

#define __get_user(x, ptr)					\
({								\
	long __gu_err;						\
	__long_type(*(ptr)) __gu_val;				\
	__typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
	__typeof__(sizeof(*(ptr))) __gu_size = sizeof(*(ptr));	\
								\
	might_fault();					\
	allow_read_from_user(__gu_addr, __gu_size);		\
	__get_user_size_allowed(__gu_val, __gu_addr, __gu_size, __gu_err);	\
	prevent_read_from_user(__gu_addr, __gu_size);		\
	(x) = (__typeof__(*(ptr)))__gu_val;			\
								\
	__gu_err;						\
})



