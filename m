Return-Path: <linux-fsdevel+bounces-72508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B762CF8CDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 15:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 814393021A57
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 14:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BFC313E2A;
	Tue,  6 Jan 2026 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqpBBoRA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6FD313529;
	Tue,  6 Jan 2026 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767710040; cv=none; b=DDJb5WsTW1aaCFGm3So8oUQQnzfhH7gow4OHpM4FQe6v0TqhnB+9O1WFA0u/geHVKxKLQvrL30EQhAJh5asFWcd5/eOwi6Pwl9zzoShrQJ+SxeeN155UWc/khTegV9nMuMRZ8c6UtzLmc5bcBojiTJV5QlAI0iefDh/nkEjUrJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767710040; c=relaxed/simple;
	bh=OD1TgDZeB7mYEnHxc/Q1fkeQ0gYBFCDnhMkeUpbXDxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BRwfKo7cVAavTA09J/3AnYaT3hVsyAk3HtpK7PzAaNCBrJxoajZIEageL3rHhZMZk9YoPRslN6ek3GA08j3t3k/X37GZaydtapdVq2qNG/afYqmy3mq/o67asY268H7uV16cqsos5wKzqyALiB10k9XU7BoeU1Hikl6uW6bbzfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqpBBoRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684BDC16AAE;
	Tue,  6 Jan 2026 14:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767710040;
	bh=OD1TgDZeB7mYEnHxc/Q1fkeQ0gYBFCDnhMkeUpbXDxU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qqpBBoRAPpFtdbygI5te+6DMFR2ULPHp+mdHIgT7EXp5Ap0QmtmsaVE+8wVktWG7+
	 E3EpkARf0310WL7WpvBXnUKYlGaOD50KEK3ESWBcHpHb5blEZu+M32HYLhlg8DcoWL
	 /OJiRimM3kzA87J3x5V6QH1Yx0nWn2el52RYxAOxFegRifD41A/thNtnLEQl+T6xwv
	 uqr4uW0cugJ3igO3b/PuLaScCEl3co3p9oZp/bvOb+vMG03MkXPvwHWdmw8PJeY+t1
	 SHgcb40tthApNsYn4G+c4qT4Wco7grALBDJWgNgb8CbwNIDG99mIBBAYgkLL+Y+MaT
	 ibJnSp0MVoqPQ==
Message-ID: <238ef4ab-7ea3-442a-a344-a683dd64f818@kernel.org>
Date: Tue, 6 Jan 2026 15:33:54 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
 in wait_sb_inodes()
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jan Kara <jack@suse.cz>, Joanne Koong <joannelkoong@gmail.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org,
 athul.krishna.kr@protonmail.com, j.neuschaefer@gmx.net, carnil@debian.org,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
References: <20251215030043.1431306-1-joannelkoong@gmail.com>
 <20251215030043.1431306-2-joannelkoong@gmail.com>
 <ypyumqgv5p7dnxmq34q33keb6kzqnp66r33gtbm4pglgdmhma6@3oleltql2qgp>
 <616c2e51-ff69-4ef9-9637-41f3ff8691dd@kernel.org>
 <CAJfpeguBuHBGUq45bOFvypsyd8XXekLKycRBGO1eeqLxz3L0eA@mail.gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
In-Reply-To: <CAJfpeguBuHBGUq45bOFvypsyd8XXekLKycRBGO1eeqLxz3L0eA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/26 14:13, Miklos Szeredi wrote:
> On Tue, 6 Jan 2026 at 11:05, David Hildenbrand (Red Hat)
> <david@kernel.org> wrote:
> 
>>> So I understand your patch fixes the regression with suspend blocking but I
>>> don't have a high confidence we are not just starting a whack-a-mole game
> 
> Joanne did a thorough analysis, so I still have hope.  Missing a case
> in such a complex thing is not unexpected.
> 
>> Yes, I think so, and I think it is [1] not even only limited to
>> writeback [2].
> 
> You are referring to DoS against compaction?

In previous discussions it was raised that readahead runs into similar 
problems.

I don't recall all the details, but I think that we might end up holding 
the folio lock forever while the fuse user space daemon is supposed to 
fill the page with data; anybody trying to lock the folio would 
similarly deadlock.

Maybe only compaction/migration is affected by that, hard to tell.

> 
> It is a much more benign issue, since compaction will just skip locked
> pages, AFAIU (wasn't always so:
> https://lore.kernel.org/all/1288817005.4235.11393.camel@nimitz/).
> 
> Not saying it shouldn't be fixed, but it should be a separate discussion.

Right. But as I pointed out in [4], there are other call paths where we 
might end up waiting for writeback unless I am missing something.

So it has whack-a-mole smell to it.

> 
>> To handle the bigger picture (I raised another problematic instance in
>> [4]): I don't know how to handle that without properly fixing fuse. Fuse
>> folks should really invest some time to solve this problem for good.
> 
> Fixing it generically in fuse would necessarily involve bringing back
> some sort of temp buffer.  The performance penalty could be minimized,
> but complexity is what really hurts.

I'm not sure about temp buffers. During early discussions there were 
ideas about canceling writeback and instead marking the folio dirty 
again. I assume there is a non-trivial solution space left unexplored 
for now.

> 
> Maybe doing whack-a-mole results in less mess overall :-/
> 

Maybe :) I'm fine with the patch as is as well.

>> As a big temporary kernel hack, we could add a
>> AS_ANY_WAITING_UTTERLY_BROKEN and simply refuse to wait for writeback
>> directly inside folio_wait_writeback() -- not arbitrarily skipping it in
>> callers -- and possibly other places (readahead, not sure). That would
>> restore the old behavior.
> 
> No it wouldn't, since the old code had surrogate methods for waiting
> on outstanding writes, which were called on fsync, etc.

Yeah, I raised some "except" below, I assume there are more. No that I 
would want to go down that path :)

-- 
Cheers

David

