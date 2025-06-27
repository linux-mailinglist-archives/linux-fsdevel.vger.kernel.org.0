Return-Path: <linux-fsdevel+bounces-53210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E946BAEBF6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 21:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09591C463E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 19:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC3A2BAF9;
	Fri, 27 Jun 2025 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhQAFDRg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EA11F4C99;
	Fri, 27 Jun 2025 19:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751051278; cv=none; b=UPvOCQDoUaQAdDr5oliziQch0Z+5tTKggHdRa143E2yc6zfLPzy8kXbxuE+tzD0y8Tbk7NrTp6uTTW5c1mL0lJM3dYTryYUdNpq+YDtlGyvtBSm3EmOYd96/1P9dDgDt2XXjpk/Nm1tZ76ZffpdW0SPzT9+JgaEi7VzArutbd1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751051278; c=relaxed/simple;
	bh=IyHDbujpS6+IluSxFwNEoxNVl+Psl5A8QBrLOTPis/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wos63x0qc1ISw9vfP4fmrx8ZkasxzBSKFuro2qz1dAjcA6gvAreMAvXYEpy7yoRj49oS2UXJ9U7dQvasmpVZXb3jTC4BJE6CspLGHOElGMKjgw9yhbKxRGeP7nrcVr8BDJXaDGE/0zJ7NI6mVhI9B+ieYUcryaQp5UA1TJ9c+lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhQAFDRg; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b31c9d96bcbso399743a12.3;
        Fri, 27 Jun 2025 12:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751051276; x=1751656076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mttJn5IA9KGimYpZWpvAoFfxgLilFuUc6pHk2VwQrE8=;
        b=fhQAFDRgPNS9PtASF4hvwoAXWdGabkUxEXYNeMVykncz0Mo9xRuO9dL5aTRaBNyzC9
         WHxYd7rnzcZVRTPeYh4P+uBtLjlOCIW5/hirXd7k0GC3qDosWOKIhbN76bvE1WNjK+jl
         GAOrTKMUTPhZ0jC8/8bVbN+x1/rCEKamgb1Xsp97x3s3jbP3h6KVms4EEhKBkBiTPUqs
         g0zw+AGn4nZffwuxAURCgIN7JuKj9bE4hAiXgZzplcEnYH8+VRuDPcG59+JId72gLqg2
         cESrdpcN4l+UOTOD62hP6M9nbOyJTEVoBIoDZhFJDFxgc4sJzPZSQE9Ln0moeFaxp8sL
         jk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751051276; x=1751656076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mttJn5IA9KGimYpZWpvAoFfxgLilFuUc6pHk2VwQrE8=;
        b=u7FVXaoEBDLlBj73see3wZ3c2djIljfAaOATJATBJYtu29s38abU6XQj555/EEZkdU
         gguEQXmncuyY542JlxGk9Sjd1JnQFS+Y1EM1/jLgDCi7WVdEBzSpj0Gl85Q7PI738CjW
         AO8FQK3YfxAsYbJ5AYcdCt+dxvP7LUOtxG499kYqfusnYr8K/3LliLF7vc7ObV7wim4M
         L5pSFBaUjIymrRbqxkk61Wz7sQLckhodnVZIXxSJ3TGu94ZjFJL/k36gQjqAONNneq9e
         q8iDYMY+oZkdoj+crVZGSyVUtgt6Ba8mnrcaSdtqfZBJf1oGIdl/XseDFYfWZbnfc359
         6s+w==
X-Forwarded-Encrypted: i=1; AJvYcCUHfh4jCFXMLHJrmaJd07Mn0jP8sev/9f+1ezYGw+4/G3hQJ/EGeBspWISyZPm5tPopwJf+VPcaPKizPRrU@vger.kernel.org, AJvYcCUPbP2oXiwFsEE7RXV+U371pOobLuN0cYL8najZnuBznI4OJLRzUbexL3OzeyK4XJKEj2JSImyKQq7hX9p8@vger.kernel.org
X-Gm-Message-State: AOJu0YysragRygAxY56tI0YTCYvJEoBJU21jHaJMkq5S0WpZ0nMPwamE
	OhSaB1Gj2zMh9wcY3tCQ6AaDZkYFuXj+tKGBb4bQ5dPlolDAW/eyZdY0
X-Gm-Gg: ASbGncsfkRrW5WaNc3tSETaDZYLM1rDG6+n2J9/1M1ZI+yGUsrD6asuhc2ceV/XKGYR
	Jfe31qDDOqEQeciin5aEfyDy6N0PAYgZJGLu9iDqTxb5nwt561/Jd5u4WIhXH9aBsEoE/mLcx53
	DDzzFIHcDVpZEAg2cFgR4mzsx6TEt+IWLHA1Hro3+ZF3lEaifVWEao+ORqKPRMnpc9gmp9704kL
	SKeHL61Xw9+y9xFyg4AtH+FmRY8C9TQ5yyLnZnxi4AtsQ02XFMZsjEnZqkQM2dL4kgMja9CCrLH
	UPGhf6uWcfoIdICTKKtFeqmYw/tcIKDBJ1F7txLDdM7Lx3w4kbeEvmu2+mlW/uTPPX6gG3azRuB
	TqVn9+6ZtHokRtp7zEIhhqlAbe1FvgU3kPaqh
X-Google-Smtp-Source: AGHT+IG9OcHFIKCdjWujh8NVXOMf1bRJPsH84NPSyERfKHmj5foBjVUuUhTVih3GhDsuUsE6pQTtPA==
X-Received: by 2002:a17:90b:2e4d:b0:314:29ff:6845 with SMTP id 98e67ed59e1d1-318ec41cdcemr330199a91.4.1751051275751;
        Fri, 27 Jun 2025 12:07:55 -0700 (PDT)
Received: from [172.30.157.194] (S0106a85e45f3df00.vc.shawcable.net. [174.7.235.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c15233d0sm2935786a91.46.2025.06.27.12.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 12:07:55 -0700 (PDT)
Message-ID: <065f98ab-885d-4f5e-97e3-beef095b93f0@gmail.com>
Date: Fri, 27 Jun 2025 12:07:55 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kerenl@vger.kernel.org, Kent Overstreet <kent.overstreet@linux.dev>
References: <ahdf2izzsmggnhlqlojsnqaedlfbhomrxrtwd2accir365aqtt@6q52cm56jmuf>
 <CAHk-=wi+k8E4kWR8c-nREP0+EA4D+=rz5j0Hdk3N6cWgfE03-Q@mail.gmail.com>
Content-Language: en-CA
From: Kyle Sanderson <kyle.leet@gmail.com>
In-Reply-To: <CAHk-=wi+k8E4kWR8c-nREP0+EA4D+=rz5j0Hdk3N6cWgfE03-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/26/2025 8:21 PM, Linus Torvalds wrote:
> On Thu, 26 Jun 2025 at 19:23, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>>
>> per the maintainer thread discussion and precedent in xfs and btrfs
>> for repair code in RCs, journal_rewind is again included
> 
> I have pulled this, but also as per that discussion, I think we'll be
> parting ways in the 6.17 merge window.
> 
> You made it very clear that I can't even question any bug-fixes and I
> should just pull anything and everything.
> 
> Honestly, at that point, I don't really feel comfortable being
> involved at all, and the only thing we both seemed to really
> fundamentally agree on in that discussion was "we're done".
> 
>                Linus

Linus,

The pushback on rewind makes sense, it wasn’t fully integrated and was 
fsck code written to fix the problems with the retail 6.15 release - 
this looks like it slipped through Kents CI and there were indeed 
multiple people hit by it (myself included).

Quoting someone back to themselves is not cool, however I believe it 
highlights what has gone on here which is why I am breaking my own rule:

"One of the things I liked about the Rust side of the kernel was that 
there was one maintainer who was clearly much younger than most of the 
maintainers and that was the Rust maintainer.

We can clearly see that certain areas in the kernel bring in more young 
people.

At the Maintainer Summit, we had this clear division between the 
filesystem people, who were very careful and very staid, and cared 
deeply about their code being 100% correct - because if you have a bug 
in a filesystem, the data on your disk may be gone - so these people 
take themselves and their code very seriously.

And then you have the driver people who are a bit more 'okay', 
especially the GPU folks, 'where anything goes'.
You notice that on the driver side it’s much easier to find young 
people, and that is traditionally how we’ve grown a lot of maintainers.
" (1)

Kent is moving like the older days of rapid development - fast and 
driven - and this style clashes with the mature stable filesystem 
culture that demands extreme caution today. Almost every single patch 
has been in response to reported issues, the primary issue here is 
that’s on IRC where his younger users are (not so young, anymore - it is 
not tiktok), and not on lkml. The pace of development has kept up, and 
the "new feature" part of it like changing out the entire hash table in 
rc6 seems to have stopped. This is still experimental, and he's moving 
that way now with care and continuing to improve his testing coverage 
with each bug.

Kent has deep technical experience here, much earlier in the 
interview(1) regarding the 6.7 merge window this filesystem has been in 
the works for a decade. Maintainership means adapting to kernel process 
as much as code quality, that may be closer to the issue here.

If direct pulls aren’t working, maybe a co-maintainer or routing changes 
through a senior fs maintainer can help. If you're open to it, maybe 
that is even you.

Dropping bcachefs now would be a monumental step backward from the 
filesystems we have today. Enterprises simply do not use them for true 
storage at scale which is why vendors have largely taken over this 
space. The question is how to balance rigor with supporting new 
maintainers in the ecosystem. Everything Kent has written around 
supporting users is true, and publicly visible, if only to the 260 users 
on irc, and however many more are on matrix. There are plenty more that 
are offline, and while this is experimental there are a number of public 
sector agencies testing this now (I have seen reference to a number of 
emergency service providers, which isn’t great, but for whatever reason 
they are doing that).

(1) https://youtu.be/OvuEYtkOH88?t=1044

Kyle.

