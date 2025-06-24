Return-Path: <linux-fsdevel+bounces-52684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4463AAE5CB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1C44A4F6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 06:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65445231CB0;
	Tue, 24 Jun 2025 06:20:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEAC372;
	Tue, 24 Jun 2025 06:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750746038; cv=none; b=sWfi22qT/UmIOmCLpSqdvQieOEEl8fJel5ITJJS77mPAO0y4pEGHitHuvHO4E52yuURniD+6jRjwkmYy0v3N9pew9zeE1B7rXkeMGjBGvpBI6fFSK7rTCSQ93Qe60LuFnoDWjPnLBhAlxGbIKpD9BcdLmO4vHmWCdxl/ZaJ/9FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750746038; c=relaxed/simple;
	bh=Ui2BRgbbxwzitXkGIwEC7/37BmFXmXcg0l9JSzvladc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVxb56S7sCrSUYY4P6r6Ff6/c4uLwH3GtMzuMjHcrGJLbbZlRjbmziudYEJcAgh0vfqrEHRjw66uFWekmLOBVWFbqZODv8dODzTiDt5ASpf0Bat/ohu1NIDi09sxHYSQTlAgeSjjwNQ+wDl2g2unDHA5/bqTKTct8THYblms8Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bRDXc6lZ6z9sSD;
	Tue, 24 Jun 2025 07:49:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6SIPJQNC9zCD; Tue, 24 Jun 2025 07:49:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bRDXc5TpXz9sYQ;
	Tue, 24 Jun 2025 07:49:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5C7138B768;
	Tue, 24 Jun 2025 07:49:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 7ZgexA602m3K; Tue, 24 Jun 2025 07:49:04 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 79C188B767;
	Tue, 24 Jun 2025 07:49:03 +0200 (CEST)
Message-ID: <2f569008-dd66-4bb6-bf5e-f2317bb95e10@csgroup.eu>
Date: Tue, 24 Jun 2025 07:49:03 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] uaccess: Add speculation barrier to
 copy_from_user_iter()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Andre Almeida <andrealmeid@igalia.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Laight <david.laight.linux@gmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
References: <cover.1750585239.git.christophe.leroy@csgroup.eu>
 <f4b2a32853b5daba7aeac9e9b96ec1ab88981589.1750585239.git.christophe.leroy@csgroup.eu>
 <CAHk-=wj4P6p1kBVW7aJbWAOGJZkB7fXFmwaXLieBRhjmvnWgvQ@mail.gmail.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <CAHk-=wj4P6p1kBVW7aJbWAOGJZkB7fXFmwaXLieBRhjmvnWgvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 22/06/2025 à 18:57, Linus Torvalds a écrit :
> On Sun, 22 Jun 2025 at 02:52, Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>>
>> The results of "access_ok()" can be mis-speculated.
> 
> Hmm. This code is critical. I think it should be converted to use that
> masked address thing if we have to add it here.

Ok, I'll add it.

> 
> And at some point this access_ok() didn't even exist, because we check
> the addresses at iter creation time. So this one might be a "belt and
> suspenders" check, rather than something critical.
> 
> (Although I also suspect that when we added ITER_UBUF we might have
> created cases where those user addresses aren't checked at iter
> creation time any more).
> 

Let's take the follow path as an exemple:

snd_pcm_ioctl(SNDRV_PCM_IOCTL_WRITEI_FRAMES)
   snd_pcm_common_ioctl()
     snd_pcm_xferi_frames_ioctl()
       snd_pcm_lib_write()
         __snd_pcm_lib_xfer()
           default_write_copy()
             copy_from_iter()
               _copy_from_iter()
                 __copy_from_iter()
                   iterate_and_advance()
                     iterate_and_advance2()
                       iterate_iovec()
                         copy_from_user_iter()

As far as I can see, none of those functions check the accessibility of 
the iovec. Am I missing something ?

Christophe

