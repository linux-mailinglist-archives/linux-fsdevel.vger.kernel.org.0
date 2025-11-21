Return-Path: <linux-fsdevel+bounces-69365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 568D9C77E64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 09:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id F25A72D016
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 08:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5BC2D543A;
	Fri, 21 Nov 2025 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="av1gtC5H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433371A9F88;
	Fri, 21 Nov 2025 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713668; cv=none; b=LfGICy/bAxYHlQlhua+l+WGP0rVGygieU+JHOfUm+JIGPcRm76fXwY3wOKDo6Qs42PDkfTiLT04PwyO1FcmNSGsSWdQaKQaouK761i4bcawKl3jF9j67K1sbb5XdzsOmaF18Ex8ZkLmuJk7MMxqZtjA6RQPvMHAcRhTlTJa7Y0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713668; c=relaxed/simple;
	bh=q3avj8C0x+5TrGoMHRvsJCSM84EjvZAloW/aJ1VY3gI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=piNetoXsDkh334OZV84E+CeRbdvl/U1oApTsOXYf/U7qmIFJRI3a2FBWaQuDCAZSiJDp6NSxpiw2klodqvWab+qTj/aF/mdMV9ZqTwJFJAKMgzIuaPKFCovNbcP25W+yxfAGU9V+E8aIoB7QF2SZdZzMMh7ZaDOY72WnVsOyZ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=av1gtC5H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE7DC4CEF1;
	Fri, 21 Nov 2025 08:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763713667;
	bh=q3avj8C0x+5TrGoMHRvsJCSM84EjvZAloW/aJ1VY3gI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=av1gtC5HoA0gXaHSqb5Sg01Zfc8XdsemjJTwT2tB3cz1I7ITELrT8f9BP9V/W/g16
	 y5O7TOmgOzywI21SnV2x60/GhIec6u2uFTXvNYLZ7Nr6HAvwZPJs8GddjQ8cR70cE8
	 hYogf8PXLMfptGRMZieTKuK1mUVXGHFcRpBWmimjFjFtYscDRA2anwBDgY9ITQAz8P
	 AfpjmyftRXerV6smR8lbDNaVxj+VjSqihrYbQIRRyLd+F7nIGQ93g7VD+A3Y2rnAoN
	 0aQ4rObuKsprBk0F4k6qGX1VavfTGGhDl2mtF/+w6ni39n+dAZGAL8lGDjfGvI3KR+
	 78zxm7PuxB0ZA==
Message-ID: <528997fd-5dcb-4332-845b-18828931417d@kernel.org>
Date: Fri, 21 Nov 2025 09:27:42 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 39/44] mm: use min() instead of min_t()
To: Eric Biggers <ebiggers@kernel.org>,
 David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Christoph Lameter
 <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Mike Rapoport <rppt@kernel.org>, Tejun Heo <tj@kernel.org>,
 Yuanchu Xie <yuanchu@google.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
 <20251119224140.8616-40-david.laight.linux@gmail.com>
 <7430fd6f-ead2-4ff8-8329-0c0875a39611@kernel.org>
 <20251120095946.2da34be9@pumpkin> <20251120234522.GB3532564@google.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251120234522.GB3532564@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/25 00:45, Eric Biggers wrote:
> On Thu, Nov 20, 2025 at 09:59:46AM +0000, David Laight wrote:
>> On Thu, 20 Nov 2025 10:20:41 +0100
>> "David Hildenbrand (Red Hat)" <david@kernel.org> wrote:
>>
>>> On 11/19/25 23:41, david.laight.linux@gmail.com wrote:
>>>> From: David Laight <david.laight.linux@gmail.com>
>>>>
>>>> min_t(unsigned int, a, b) casts an 'unsigned long' to 'unsigned int'.
>>>> Use min(a, b) instead as it promotes any 'unsigned int' to 'unsigned long'
>>>> and so cannot discard significant bits.
>>>
>>> I thought using min() was frowned upon and we were supposed to use
>>> min_t() instead to make it clear which type we want to use.
>>
>> I'm not sure that was ever true.
>> min_t() is just an accident waiting to happen.
>> (and I found a few of them, the worst are in sched/fair.c)
>>
>> Most of the min_t() are there because of the rather overzealous type
>> check that used to be in min().
>> But even then it would really be better to explicitly cast one of the
>> parameters to min(), so min_t(T, a, b) => min(a, (T)b).
>> Then it becomes rather more obvious that min_t(u8, x->m_u8, expr)
>> is going mask off the high bits of 'expr'.
>>
>>> Do I misremember or have things changed?
>>>
>>> Wasn't there a checkpatch warning that states exactly that?
>>
>> There is one that suggests min_t() - it ought to be nuked.
>> The real fix is to backtrack the types so there isn't an error.
>> min_t() ought to be a 'last resort' and a single cast is better.
>>
>> With the relaxed checks in min() most of the min_t() can just
>> be replaced by min(), even this is ok:
>> 	int len = fun();
>> 	if (len < 0)
>> 		return;
>> 	count = min(len, sizeof(T));
>>
>> I did look at the history of min() and min_t().
>> IIRC some of the networking code had a real function min() with
>> 'unsigned int' arguments.
>> This was moved to a common header, changed to a #define and had
>> a type added - so min(T, a, b).
>> Pretty much immediately that was renamed min_t() and min() added
>> that accepted any type - but checked the types of 'a' and 'b'
>> exactly matched.
>> Code was then changed (over the years) to use min(), but in many
>> cases the types didn't quite match - so min_t() was used a lot.
>>
>> I keep spotting new commits that pass too small a type to min_t().
>> So this is the start of a '5 year' campaign to nuke min_t() (et al).
> 
> Yes, checkpatch suggests min_t() or max_t() if you cast an argument to
> min() or max().  Grep for "typecasts on min/max could be min_t/max_t" in
> scripts/checkpatch.pl.

Right, that's the one I recalled.

> 
> And historically you could not pass different types to min() and max(),
> which is why people use min_t() and max_t().  It looks like you fixed
> that a couple years ago in
> https://lore.kernel.org/all/b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com/,
> which is great!  It just takes some time for the whole community to get
> the message.  Also, it seems that checkpatch is in need of an update.

Exactly.

And whenever it comes to such things, I wonder if we want to clearly 
spell them out somewhere (codying-style): especially, when to use 
min/max and when to use min_t/max_t.

coding-style currently mentions:

"There are also min() and max() macros that do strict type checking ..." 
is that also outdated or am I just confused at this point?

> 
> Doing these conversions looks good to me, but unfortunately this is
> probably the type of thing that shouldn't be a single kernel-wide patch
> series.  They should be sent out per-subsystem.

Agreed!

In particular as there is no need to rush and individual subsystems can 
just pick it up separately.

> 
> I suggest also putting a sentence in the commit message that mentions
> that min() and max() have been updated to accept arguments with
> different types.  (Seeing as historically that wasn't true.)  I suggest
> also being extra clear about when each change is a cleanup vs a fix.

+1

-- 
Cheers

David

