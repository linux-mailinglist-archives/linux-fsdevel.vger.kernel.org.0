Return-Path: <linux-fsdevel+bounces-52678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9B5AE5C09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 07:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395004A058D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 05:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897C5230BCB;
	Tue, 24 Jun 2025 05:50:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491C12CCC1;
	Tue, 24 Jun 2025 05:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750744237; cv=none; b=oHQ40u5loDUcQI2feXhmj7dAHl1lyBCax5N8Cj71vJK0qf8IxF/GjVNe8I5Tg6PYTjFBgWk47CajHsrBaYbn1YUNY08hMqwc44n/bYzDMgOPjFaRsQKFMWRaZjB/nXlUJ3xMb2H396k/PaXAPO2knmlNqk/vABKJfNw4f22gQ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750744237; c=relaxed/simple;
	bh=hEkm/zWiQaR5VV7JFD9yk57XGTTR1Gad9sj9k2nUT0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCC9ggwk/0aPGSCVNdpqYyv+/iG8CUtdmP7fNPQwd3KuX8BP2dRzu+zDUkP6WatxnoShxSSlGgGrWyamT5SICNN9YyseCPGYbMZiSLnDpR6ybLwKEj3inEH18OfdydiVeg8OX5lWsn84x6k37Vi5DLUsY0IbirJeF+H5Bnqj4z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bRDD93jvMz9sRp;
	Tue, 24 Jun 2025 07:34:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EEbxvPxf50Ga; Tue, 24 Jun 2025 07:34:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bRDD92K1Tz9sN6;
	Tue, 24 Jun 2025 07:34:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 47C598B768;
	Tue, 24 Jun 2025 07:34:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id qwbFcTV72ImU; Tue, 24 Jun 2025 07:34:49 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 512018B767;
	Tue, 24 Jun 2025 07:34:48 +0200 (CEST)
Message-ID: <ce2c8557-cda6-4211-9873-9afd993c0580@csgroup.eu>
Date: Tue, 24 Jun 2025 07:34:48 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] uaccess: Add masked_user_{read/write}_access_begin
To: David Laight <david.laight.linux@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Andre Almeida <andrealmeid@igalia.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <cover.1750585239.git.christophe.leroy@csgroup.eu>
 <6fddae0cf0da15a6521bb847b63324b7a2a067b1.1750585239.git.christophe.leroy@csgroup.eu>
 <20250622173554.7f016f96@pumpkin>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250622173554.7f016f96@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 22/06/2025 à 18:35, David Laight a écrit :
> On Sun, 22 Jun 2025 11:52:39 +0200
> Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
> 
>> Allthough masked_user_access_begin() seems to only be used when reading
>> data from user at the moment, introduce masked_user_read_access_begin()
>> and masked_user_write_access_begin() in order to match
>> user_read_access_begin() and user_write_access_begin().
>>
>> Have them default to masked_user_access_begin() when they are
>> not defined.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   fs/select.c             | 2 +-
>>   include/linux/uaccess.h | 8 ++++++++
>>   kernel/futex/futex.h    | 4 ++--
>>   lib/strncpy_from_user.c | 2 +-
>>   lib/strnlen_user.c      | 2 +-
>>   5 files changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/select.c b/fs/select.c
>> index 9fb650d03d52..d8547bedf5eb 100644
>> --- a/fs/select.c
>> +++ b/fs/select.c
>> @@ -777,7 +777,7 @@ static inline int get_sigset_argpack(struct sigset_argpack *to,
>>   	// the path is hot enough for overhead of copy_from_user() to matter
>>   	if (from) {
>>   		if (can_do_masked_user_access())
>> -			from = masked_user_access_begin(from);
>> +			from = masked_user_read_access_begin(from);
>>   		else if (!user_read_access_begin(from, sizeof(*from)))
>>   			return -EFAULT;
>>   		unsafe_get_user(to->p, &from->p, Efault);
>> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
>> index 7c06f4795670..682a0cd2fe51 100644
>> --- a/include/linux/uaccess.h
>> +++ b/include/linux/uaccess.h
>> @@ -41,6 +41,14 @@
> 
>>   #ifdef masked_user_access_begin
>>    #define can_do_masked_user_access() 1
>>   #else
>>    #define can_do_masked_user_access() 0
>>    #define masked_user_access_begin(src) NULL
>>    #define mask_user_address(src) (src)
>>   #endif
>>   
>> +#ifndef masked_user_write_access_begin
>> +#define masked_user_write_access_begin masked_user_access_begin
>> +#endif
>> +#ifndef masked_user_read_access_begin
>> +#define masked_user_read_access_begin masked_user_access_begin
>> +#endif
> 
> I think that needs merging with the bit above.
> Perhaps generating something like:
> 
> #ifdef masked_user_access_begin
> #define masked_user_read_access_begin masked_user_access_begin
> #define masked_user_write_access_begin masked_user_access_begin
> #endif
> 
> #ifdef masked_user_read_access_begin
>    #define can_do_masked_user_access() 1
> #else
>    #define can_do_masked_user_access() 0
>    #define masked_user_read_access_begin(src) NULL
>    #define masked_user_write_access_begin(src) NULL
>    #define mask_user_address(src) (src)
> #endif
> 
> Otherwise you'll have to #define masked_user_access_begin even though
> it is never used.

I'm not sure I understand what you mean.

masked_user_access_begin() is used, for instance in 
arch/x86/include/asm/futex.h so it will remain.

masked_user_access_begin() is the analogy of user_access_begin(), it 
starts a read-write user access and is worth it.

> 
> Two more patches could change x86-64 to define both and then remove
> the 'then unused' first check - but that has to be for later.
> 

Christophe

