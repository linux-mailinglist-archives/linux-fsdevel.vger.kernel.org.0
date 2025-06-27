Return-Path: <linux-fsdevel+bounces-53213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CB4AEBF98
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 21:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47E461C47B65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 19:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C329E202C48;
	Fri, 27 Jun 2025 19:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLDFnzJ+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9DC19D8A8;
	Fri, 27 Jun 2025 19:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751051772; cv=none; b=bpuibZwV+DSDqe4lZTkk36G2uOMpZLERfSNWvYik2BXjbPBy3rRKTBXbJV2Xas3z2ufpUPmJ661BGS2WuY5XSV8OhTva0lXkevAycYruN32RRhptonbMhd3Pln6vK7RKUD2vRahFWHGpsOaoPRyE+/W3XPpX00slyv4xghchBXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751051772; c=relaxed/simple;
	bh=dutVWxABHdKOTL+kXEyaD/WsyC1WgC3gkxbZufJPzb8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Thrpv+nyAV1hpRrlZSg7Y29r6NUs4LzDGMRWMZUqvuUZBP+mYnAWeTYP4coLhurJ0ZaW3XJ3TGbpWVMrHuJaZ0zwn7McyF8Y41sb3uF91NS4NgFOPi7ZIbju6eR80u8mlGNWP5Hf44NnkqlP9+b9nO6zqgOfhhd6Wnp97uVJKdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLDFnzJ+; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748e1816d4cso195070b3a.2;
        Fri, 27 Jun 2025 12:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751051770; x=1751656570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tS0gPt0Ngw3XgWlRV3zh4CMlac6wfNf6E8w0knAheoE=;
        b=fLDFnzJ+V4UILan0JZJbgj+4Wf0ZlhMNDGh0ydGLoUzaTgX3SK1CfELBgfbEBMYWdq
         LutvTTfWDzN+JzxWzV4inqfnzHh4rL9DEquCXcRr++jQ9rApRyA5yYyJWqxGvsrzeybv
         HXLpRXZ05Cs68gZbPybEYrDn2O0Vfnv4nFSR0fhNxtzz2sRb1EgE+0a4aCFgxOmrwT/w
         xii+yBAkRghDJoRMYd03xQLsg7HZWDczITISNU28YXh8Q8yIWybcGqdHymmzC3RLRu30
         QRhBnrYDKTvZ/4xeH+GmSLkI9hENXIm31hlBNnwSQTOVJ7JUJipZtxzoGbH8shiptOh2
         wxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751051770; x=1751656570;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tS0gPt0Ngw3XgWlRV3zh4CMlac6wfNf6E8w0knAheoE=;
        b=jid8158dUiBzPqKflUxxe309diNRcJIjNehTubpTiT+j4PQoInGg4ishq/yv5DsI1m
         zFGvprMhqGuzPWiZB8YYrIU81C4QR9P/cMb/NZEEVp+e3R2EepoT0NOQppDzttF3lbqt
         MO/TooXLCA+lrnzX1KgzZb18z8zDP25iweeqKlcCETZ0GzusGJhZMRxSjZCtOqt6rdhV
         YXJhIpJbA9D3jcNBypBqOmb5fWZDelcNo1zw2bJunKIIsIrAJUHPtaHujmHGgIrrWw+b
         G5D0f68/12o6c0qjcl07H88cku0cdaP07TBmZijaYJM2/1eG+ycPZRvc4jzqrfGDFoKk
         aNsg==
X-Forwarded-Encrypted: i=1; AJvYcCU+iabngTKwoB8Mbt0bXBdPZsu7IW+LJAiF6ytPZiS0xNFYRh3GnD6gv2kUmbEK7AKpm32amjfi58V2U5Pq@vger.kernel.org
X-Gm-Message-State: AOJu0YyOQ1QFY49claNhVOxGONlJOZyA+YY3lpCFt3hx8ZY/edv+Fp57
	2uT9RCyPEsIOWtUdkXpRHwLEyT2hoFjqZpswuWYpYu+YMar06KJt1NhVOY5+jshU
X-Gm-Gg: ASbGnctOnPFZu1gYo30vhdxDAJqtvv5SeMtvugxLSGgBvINK7zJpuDkirMUBNediJcp
	OGS/Z8WwCQwFHQ9YcwcstUQzNxye+aX9mD6GSAVitxRrP914IqaJWCvnegvbcuNPKC28EOwrHyJ
	0rzqMAK4v9lxNT2XCstlxgQhSEKcLWRX/jyOZGxIdX68zqmA8sA5pRxrW4z3biwfJ2d9sVhdrht
	j+tC0mSvIthEtSWBkk87ncJh5HCmVD8Cc3+ONoaTWbux6suNyR9qm6g5P1ecK/+vYrwo1y3VEsl
	G+0e+0kn4eQ0G1rdDLUlGDUkN1nebhM9Mo9UmpYw8HKBMn1757wWcXJts5tFQG6SrcPrO2lsAmE
	w+dThiDdahwOvvxamnIG7CmkXpuBOJDsnc2IJ
X-Google-Smtp-Source: AGHT+IGpmDwMN1YUPNEHK2ONYM5CH3fvYhtrvNkCB9HVntdGgFj2nm3VDW7TQ351DL+yIe6QvKArwQ==
X-Received: by 2002:a05:6a00:340d:b0:732:18b2:948 with SMTP id d2e1a72fcca58-74b0a4ed5f8mr236636b3a.1.1751051769616;
        Fri, 27 Jun 2025 12:16:09 -0700 (PDT)
Received: from [172.30.157.194] (S0106a85e45f3df00.vc.shawcable.net. [174.7.235.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af541e7f0sm2841738b3a.64.2025.06.27.12.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 12:16:09 -0700 (PDT)
Message-ID: <774936dd-32b8-46f1-a849-2f8ea76a24ac@gmail.com>
Date: Fri, 27 Jun 2025 12:16:09 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc4
From: Kyle Sanderson <kyle.leet@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <ahdf2izzsmggnhlqlojsnqaedlfbhomrxrtwd2accir365aqtt@6q52cm56jmuf>
 <CAHk-=wi+k8E4kWR8c-nREP0+EA4D+=rz5j0Hdk3N6cWgfE03-Q@mail.gmail.com>
 <065f98ab-885d-4f5e-97e3-beef095b93f0@gmail.com>
Content-Language: en-CA
In-Reply-To: <065f98ab-885d-4f5e-97e3-beef095b93f0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/27/2025 12:07 PM, Kyle Sanderson wrote:
> On 6/26/2025 8:21 PM, Linus Torvalds wrote:
>> On Thu, 26 Jun 2025 at 19:23, Kent Overstreet 
>> <kent.overstreet@linux.dev> wrote:
>>>
>>> per the maintainer thread discussion and precedent in xfs and btrfs
>>> for repair code in RCs, journal_rewind is again included
>>
>> I have pulled this, but also as per that discussion, I think we'll be
>> parting ways in the 6.17 merge window.
>>
>> You made it very clear that I can't even question any bug-fixes and I
>> should just pull anything and everything.
>>
>> Honestly, at that point, I don't really feel comfortable being
>> involved at all, and the only thing we both seemed to really
>> fundamentally agree on in that discussion was "we're done".
>>
>>                Linus
> 
> Linus,
> 
> The pushback on rewind makes sense, it wasn’t fully integrated and was 
> fsck code written to fix the problems with the retail 6.15 release - 
> this looks like it slipped through Kents CI and there were indeed 
> multiple people hit by it (myself included).
> 
> Quoting someone back to themselves is not cool, however I believe it 
> highlights what has gone on here which is why I am breaking my own rule:
> 
> "One of the things I liked about the Rust side of the kernel was that 
> there was one maintainer who was clearly much younger than most of the 
> maintainers and that was the Rust maintainer.
> 
> We can clearly see that certain areas in the kernel bring in more young 
> people.
> 
> At the Maintainer Summit, we had this clear division between the 
> filesystem people, who were very careful and very staid, and cared 
> deeply about their code being 100% correct - because if you have a bug 
> in a filesystem, the data on your disk may be gone - so these people 
> take themselves and their code very seriously.
> 
> And then you have the driver people who are a bit more 'okay', 
> especially the GPU folks, 'where anything goes'.
> You notice that on the driver side it’s much easier to find young 
> people, and that is traditionally how we’ve grown a lot of maintainers.
> " (1)
> 
> Kent is moving like the older days of rapid development - fast and 
> driven - and this style clashes with the mature stable filesystem 
> culture that demands extreme caution today. Almost every single patch 
> has been in response to reported issues, the primary issue here is 
> that’s on IRC where his younger users are (not so young, anymore - it is 
> not tiktok), and not on lkml. The pace of development has kept up, and 
> the "new feature" part of it like changing out the entire hash table in 
> rc6 seems to have stopped. This is still experimental, and he's moving 
> that way now with care and continuing to improve his testing coverage 
> with each bug.
> 
> Kent has deep technical experience here, much earlier in the 
> interview(1) regarding the 6.7 merge window this filesystem has been in 
> the works for a decade. Maintainership means adapting to kernel process 
> as much as code quality, that may be closer to the issue here.
> 
> If direct pulls aren’t working, maybe a co-maintainer or routing changes 
> through a senior fs maintainer can help. If you're open to it, maybe 
> that is even you.
> 
> Dropping bcachefs now would be a monumental step backward from the 
> filesystems we have today. Enterprises simply do not use them for true 
> storage at scale which is why vendors have largely taken over this 
> space. The question is how to balance rigor with supporting new 
> maintainers in the ecosystem. Everything Kent has written around 
> supporting users is true, and publicly visible, if only to the 260 users 
> on irc, and however many more are on matrix. There are plenty more that 
> are offline, and while this is experimental there are a number of public 
> sector agencies testing this now (I have seen reference to a number of 
> emergency service providers, which isn’t great, but for whatever reason 
> they are doing that).
> 
> (1) https://youtu.be/OvuEYtkOH88?t=1044
> 
> Kyle.

Re-sending as this thread seems to have typo'd lkml (removing the bad 
entry).

Kyle.

