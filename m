Return-Path: <linux-fsdevel+bounces-57421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897A6B2149D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 20:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5342C3E41DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 18:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7121A2E3B1D;
	Mon, 11 Aug 2025 18:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="SX/N3S/9";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="OhisA6DN";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="nBi17JTF";
	dkim=neutral (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="I/faDtGY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tnxip.de (mail.tnxip.de [49.12.77.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718A42E2859;
	Mon, 11 Aug 2025 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.77.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754937678; cv=none; b=h2ymD7Fi2S8eXwaCWTSR4Jz+F5EN4kJhjM28WdLfdtVBsivE9y+CQPRcjO3EpIihLiSTqXqNOhJ8EuBSgiKmbdni1fpoIM0nvMqgZHxehBao5W7OaZ/O4tfO8QJMuj5qIAD6TVlYvOdkxha0hP/OT5oIPtxxMWTLUqmLKM9WxEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754937678; c=relaxed/simple;
	bh=H2Zu/oVnTRxJcvLU0WTB1AXWL7ufPkTJOrsH3DjY4VQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ODMRqLS7O3p8efPdcwnXLjkAfwoivfnjw5JZRXXH/i6xRaCFT7Hg48VoEO381WrCuvuUlqszq6iQpNLPxAzbFzfeyiRFZ/JTYeYku8SfcCS0wy0Rq0M8wp/5+vr5UBTRV0dJxslDFf9tX9QSxbnQfx25EDMnCAdkSO7dW/0oYGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de; spf=pass smtp.mailfrom=tnxip.de; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=SX/N3S/9; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=OhisA6DN; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=nBi17JTF; dkim=neutral (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=I/faDtGY; arc=none smtp.client-ip=49.12.77.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnxip.de
Received: from gw.tnxip.de (unknown [IPv6:fdc7:1cc3:ec03:1:50ae:ade0:7d29:fff2])
	by mail.tnxip.de (Postfix) with ESMTPS id 123DA1F59D;
	Mon, 11 Aug 2025 20:41:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-vps;
	t=1754937663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TD+IuNqJe0oKKdsqKJDKKW118jZ+WkZgDGk9TFAgU14=;
	b=SX/N3S/9C7HLGFl8+y3H0aeN5oEGaflVAJ23NXUFMsDg65KJrLvxjPQMPOYWUOSuUYjQZz
	SUCMA7/nV2tZDRU+DAhc6TbFFJu7LD5jvM4eQJYk0ZXVcxLw7XmHnCwJE+QzMFZNF9EdJE
	s1A9X/YptACUpV1RJszB+kY1qqXuyXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-vps-ed; t=1754937663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TD+IuNqJe0oKKdsqKJDKKW118jZ+WkZgDGk9TFAgU14=;
	b=OhisA6DNrTrRkr7kOqnINsMH+WNbBGbYHHmpHUyzMCHrU56NKkPc39fW6FVuQAVCiumFKT
	aVAlPY2AwWAMJmDg==
Received: from [IPV6:2a04:4540:8c0c:3700:8bf2:48fa:c061:20a] (unknown [IPv6:2a04:4540:8c0c:3700:8bf2:48fa:c061:20a])
	by gw.tnxip.de (Postfix) with ESMTPSA id 96E7310000000003E2F9D;
	Mon, 11 Aug 2025 20:40:53 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-gw-ed; t=1754937662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TD+IuNqJe0oKKdsqKJDKKW118jZ+WkZgDGk9TFAgU14=;
	b=nBi17JTFxetF9nGOMpNNQxT4oKp9faDV3Oz2G69+KTiJCR1fRARnnEYxdBDPXg0ov2RKs+
	eu7OJMQmI3F+qvCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-gw;
	t=1754937662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TD+IuNqJe0oKKdsqKJDKKW118jZ+WkZgDGk9TFAgU14=;
	b=I/faDtGY4Vi3+PQs4puPjB8rBKb88yLEhGM1G+qvW/c8HLE5XL0cHNI6CFYQnzRPBP7R8C
	h+rTz61chjO18xUMV00jcqMysHERRJeOBJeP07wFeyqbTHrJ9AWgoGzYuPRMnH4sFqRREC
	tI16sG4/QOxAJ1OTnI93IH0QRrRGQdQ=
Message-ID: <28dbd3e0-8d5b-4dfe-a7e7-3a73347480f6@tnxip.de>
Date: Mon, 11 Aug 2025 20:40:53 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [GIT PULL] bcachefs changes for 6.17
To: "Carl E. Thompson" <list-bcachefs@carlthompson.net>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Konstantin Shelekhin <k.shelekhin@ftml.net>
Cc: admin@aquinas.su, linux-bcachefs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org
References: <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <55e623db-ff03-4d33-98d1-1042106e83c6@ftml.net>
 <iktaz2phgjvhixpb5a226ebar7hq6elw6l4evcrkeu3wwm2vs7@fsdav6kbz4og>
 <514556110.413.1754936038265@mail.carlthompson.net>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>
In-Reply-To: <514556110.413.1754936038265@mail.carlthompson.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11.08.25 20:13, Carl E. Thompson wrote:
> I seriously hope none of the kernel developers are foolish enough to be fooled (yet again) by this I'm-a-reasonable-guy-we-can-talk-this-out act. You've been there and done that.
>
> Kent's perplexing behavior almost makes me want to put on a tinfoil hat. Is it simply mental illness or is it something more? Is he being egged on by backers who *want* to destabilize the leadership of Linux for whatever reason? It's hard to see how any individual could be this far out there without help.
>
> And I'll point out what's obvious to people who have followed this closely but may not be to people who read an occasional email thread like this one: A very large portion of what Kent says including in this email is just factually wrong. Either he is an unashamed and extremely prolific liar or he is very sick.
>
> Carl

Frankly for me as a user who does probably not know the hole picture you
seem to just be spewing paranoid hate into these threads which I do not
quite understand. Yes, Kent can be off-putting, but really, that is
something I often observe from other people as well, the tone on LKML
tends to be pretty harsh.

My involvement in bcachefs is that of an early adopter and hence, a
tester. I find working with him productive. I give him bug reports,
observations and data and he fixes those. If I did something stupid, he
will point that out, and very directly so.

So what you call a "I'm-a-reasonable-guy-we-can-talk-this-out act" is
actually how he can and does behave, at least when interacting on IRC
with his users, testers and co-developers.

So maybe if we can dial the personal attacks down a few notches
(including against btrfs, though I have my reasons why I jumped from
it to bcachefs like two years ago) and have a calm discussion it might
be possible to build new bridges?


/Malte

>
>> On 2025-08-11 7:26 AM PDT Kent Overstreet <kent.overstreet@linux.dev> wrote:
>>
>>  
>> On Mon, Aug 11, 2025 at 12:51:11PM +0300, Konstantin Shelekhin wrote:
>>>>  Yes, this is accurate. I've been getting entirely too many emails from Linus about
>>>> how pissed off everyone is, completely absent of details - or anything engineering
>>>> related, for that matter.
>>> That's because this is not an engineering problem, it's a communication problem. You just piss
>>> people off for no good reason. Then people get tired of dealing with you and now we're here,
>>> with Linus thinking about `git rm -rf fs/bcachesfs`. Will your users be happy? Probably not.
>>> Will your sponsors be happy? Probably not either. Then why are you keep doing this?
>>>
>>> If you really want to change the way things work go see a therapist. A competent enough doctor
>>> probably can fix all that in a couple of months.
>> Konstantin, please tell me what you're basing this on.
>>
>> The claims I've been hearing have simply lacked any kind of specifics;
>> if there's people I'd pissed off for no reason, I would've been happy to
>> apologize, but I'm not aware of the incidences you're claiming - not
>> within a year or more; I have made real efforts to tone things down.
>>
>> On the other hand, for the only incidences I can remotely refer to in
>> the past year and a half, there has been:
>>
>> - the mm developer who started outright swearing at me on IRC in a
>>   discussion about assertions
>> - the block layer developer who went on a four email rant where he,
>>   charitably, misread the spec or the patchset or both; all this over a
>>   patch to simply bring a warning in line with the actual NVME and SCSI
>>   specs.
>> - and reference to an incident at LSF, but the only noteworthy event
>>   that I can recall at the last LSF (a year and a half ago) was where a
>>   filesystem developer chased a Rust developer out of the community.
>>
>> So: what am I supposed to make of all this?
>>
>> To an outsider, I don't think any of this looks like a reasonable or
>> measured response, or professional behaviour. The problems with toxic
>> behaviour have been around long before I was prominent, and they're
>> still in evidence.
>>
>> It is not reasonable or professional to jump from professional criticism
>> of code and work to personal attacks: it is our job to be critical of
>> our own and each other's code, and while that may bring up strong
>> feelings when we feel our work is attacked, that does not mean that it
>> is appropriate to lash out.
>>
>> We have to separate the professional criticism from the personal.
>>
>> It's also not reasonable or professional to always escelate tensions,
>> always look for the upper hand, and never de-escalate.
>>
>> As a reminder, this all stems from a single patch, purely internal to
>> fs/bcachefs/, that was a critical, data integrity hotfix.
>>
>> There has been a real pattern of hyper reactive, dramatic responses to
>> bugfixes in the bcachefs pull requests, all the way up to full blown
>> repeated threats of removing it from the kernel, and it's been toxic.
>>
>> And it's happening again, complete with full blown rants right off the
>> bat in the private maintainer thread about not trusting my work (and I
>> have provided data and comparisons with btrfs specifically to rebut
>> that), all the way to "everyone hates you and you need therapy". That is
>> not reasonable or constructive.
>>
>> This specific thread was in response to Linus saying that bcachefs was
>> imminently going to be git rm -rf'd, "or else", again with zero details
>> on that or else or anything that would make it actionable.
>>
>> Look, I'm always happy to sit down, have a beer, talk things out, and
>> listen.
>>
>> If there's people I have legitimately pissed off (and I do not include
>> anyone who starts swearing at me in a technical discussion) - let me
>> know, I'll listen. I'm not unapproachable, I'm not going to bite your
>> head off.
>>
>> I've mended fences with people in the past; there were people I thought
>> I'd be odds with forever, but all it really takes is just talking. Say
>> what it is that you feel has affected, be willing to listen and turn,
>> and it gets better.

