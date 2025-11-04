Return-Path: <linux-fsdevel+bounces-66883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310D1C2F804
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 07:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 078B4420DBA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 06:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDC32E2EF9;
	Tue,  4 Nov 2025 06:50:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74C42C11EC;
	Tue,  4 Nov 2025 06:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762239019; cv=none; b=MQnJ7wM8qYLc+91FfHk0Gt2ZXbqmb0YnYuj3CQPmoYoLpjnE59KAwnto1YK0UDT4DhltUcuXne47LMHpqRlsPocQb62C7fRvINNUB5kZSLTHOsjh36Njoo3maKu2XDqvf4g0UUpa6jmK7hEqtLOFVHYpXiGyx4gmx/Vqa20BrB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762239019; c=relaxed/simple;
	bh=3590HN+g5RX4oDq7ek2ZvmoAVN56lGJ+5FZuZi6407o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kW2XswtUPrcQN2Y1Sel8Plu9u62JxfvCHgRcVNCB50mJCy1isGYdOjhdHqVN5f7MIrHzc9/vOTjkKv4XdG8S5nejIjv+j2TjFCvj0s4edQCyAdQ7FdrV6Ykf+z66p0CJ4SdqJbfH79YOo7KorwUbMp9hmaWW164haV5HqDbeQDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d0zMS3Cgtz9sSm;
	Tue,  4 Nov 2025 07:39:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JVa3bC_JehNO; Tue,  4 Nov 2025 07:39:32 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d0zMS2Q1Zz9sSj;
	Tue,  4 Nov 2025 07:39:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 409D08B76C;
	Tue,  4 Nov 2025 07:39:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id CzfwR0aRXjyU; Tue,  4 Nov 2025 07:39:32 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id AD5B78B763;
	Tue,  4 Nov 2025 07:39:30 +0100 (CET)
Message-ID: <01d89f24-8fca-4fc3-9f48-79e28b9663db@csgroup.eu>
Date: Tue, 4 Nov 2025 07:39:30 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/10] uaccess: Add
 masked_user_{read/write}_access_begin
To: Thomas Gleixner <tglx@linutronix.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Andre Almeida <andrealmeid@igalia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
 <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <cover.1760529207.git.christophe.leroy@csgroup.eu>
 <a4ef0a8e1659805c60fafc8d3b073ecd08117241.1760529207.git.christophe.leroy@csgroup.eu>
 <87bjlyyiii.ffs@tglx>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <87bjlyyiii.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 22/10/2025 à 19:05, Thomas Gleixner a écrit :
> On Fri, Oct 17 2025 at 12:20, Christophe Leroy wrote:
>> Allthough masked_user_access_begin() is to only be used when reading
>> data from user at the moment, introduce masked_user_read_access_begin()
>> and masked_user_write_access_begin() in order to match
>> user_read_access_begin() and user_write_access_begin().
>>
>> That means masked_user_read_access_begin() is used when user memory is
>> exclusively read during the window, masked_user_write_access_begin()
>> is used when user memory is exclusively writen during the window,
>> masked_user_access_begin() remains and is used when both reads and
>> writes are performed during the open window. Each of them is expected
>> to be terminated by the matching user_read_access_end(),
>> user_write_access_end() and user_access_end().
>>
>> Have them default to masked_user_access_begin() when they are
>> not defined.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> Can we please coordinate on that vs. the scoped_access() work as this
> nicely collides all over the place?

Sure, I will rebase on top of your series.

Once it is rebased, could you take the non powerpc patches in your tree ?

Thanks
Christophe

