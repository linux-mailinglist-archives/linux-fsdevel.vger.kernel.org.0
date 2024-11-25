Return-Path: <linux-fsdevel+bounces-35751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E589D7B55
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 06:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E682281B71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 05:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2071113C809;
	Mon, 25 Nov 2024 05:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ld1yPjdh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E21D63C;
	Mon, 25 Nov 2024 05:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732513684; cv=none; b=D3J3h45ljCxCkNeo+uBZ2pGwCfjyCf9RRFAG1elk1l0Uo6zDQnU9tCnhTN9qLIM92apjeqmSsnaqy2uKgZtLIiizXhne/RPJrQcOwJK3zOe9IU2ePXwsqZLUUjp97pmFp5MDPC5qkccTQVjzFK1+9Jvs4En8KY+F/+gGz42WpqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732513684; c=relaxed/simple;
	bh=ZLB6oQxjBX+ftMMtPYjrYd1jqxWoMrLP+sORz5LiJIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=drm2aGzVMaZfv1CUkWqt8ccrXlrKQWy6mZgE2qrNTDpbukR4dQNXctpyxqI0An0XhpobmPjzkS1KNkz4TLLqd7YdW1KEj5olryQcR0CpDJcyO8gvVbiq2DYoWRJjACk/sZYGFRL3Vb7vZRAtGXa0gK6jE5LQ/N4z3v0CJYduIrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ld1yPjdh; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-212a3067b11so28144335ad.3;
        Sun, 24 Nov 2024 21:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732513682; x=1733118482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2hpmeGBAUt0zomKzAmhTv39uSg4YIIpviHlEZ0X8kVs=;
        b=ld1yPjdhQcXEmIO3flbJNWvHsOJZHcrgYxrdKRy7e9k4HKgNQ2m0ApuKE2l/zw9hJi
         k/BrDDZ/TCyKjp5snGWJKLTOZgdcReIEgsE71qgfCc9fkK+hfgXCmfscZgSl3yEbGKwZ
         Ayke+FTK1qr8kuGzIFVan35Mp/XTUnmBe5LFH6bqduYPBiic+1FXPfdmIyicgqG7GCRp
         tEF+s8c3Xj+y5cnZeoZFMQVzAI+ohmsPcmCWAXlgCqYbM9PhMw8qzhlvUcGGt2Htx6f/
         whQ220R0oNdtIK/R5nzM4XGNGjqC3rpbZm6oBjLe1XKUKvIlCkTkzfwJq4U/Ysojw/xq
         ssFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732513682; x=1733118482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2hpmeGBAUt0zomKzAmhTv39uSg4YIIpviHlEZ0X8kVs=;
        b=wQdkjSIlh7F2Z5iIeOg7q2cAG+4ZEqmyBwSwIBBUHmFtUaOWZovdhdeSZVIIvsPUKP
         +NoH7H7pmElLUVxCeRrAsXrtGXv6vW421k3YdPhw/qvfZn53cR04ISmzG/BVxtYvKs2e
         LGI3R2fxPIefuBdk/2g89Odx81xQPAIqPSSVitpLAoM9uuGdTaXtj3F/0yQ4u+1smwnU
         I2aM2XTCXRZPxCRpl3ITn6yisqZUjvXuPcsQwQGAgX1lVk3KyPcveKR35u6KDPBJHtVS
         J5OKlyPEu9ineYgqEpzVPGo2eA1K31jkon1vt665zHYhvk/u5WJxdPEYL51X6bjxkZ9e
         477A==
X-Forwarded-Encrypted: i=1; AJvYcCW/AaUXfE9mwQgHMJndXAsSFx/RfnYY8AJmrSW3GhLG/yz+mSzqWhQBcuySBirI2mZflYiNG0Ait7c1zLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlSsZ1zWhLPuxjl+e0dqZNbxmeo/iXWIEvFs0Jtiy/qhGyX7sB
	YI7cRQ8XJM2x2sD1ESNu+6MmHHhSK1DpSMHE/zua+FN0aIpVQeHE
X-Gm-Gg: ASbGncsaJSDX/a84Lh0uCYcDk85/6Qc/Rt6z5po0SGd4R9Al+CP59s/w1ghJYMb5igu
	tTJVwF/MRpsB3A1/aX7u/VkrztSvQCXa2XYE7nv4Wv6uiyHXvwbKn2ZWlVmVWfr1FKFiC8VCjjm
	Cn444NLrJNHN2HUNDmTf79n8+Lep3Ry32QKC53wCaAbFz600PlsBYsug6xrk1+K+balxFq69pad
	w2URaGr5NFF6a4Nq82auN6hePvdU0FM8rpFOqNVIUtDKn10nY5rc12aOCkZQF0X
X-Google-Smtp-Source: AGHT+IE9PgSlZ0M4vrzB6tTYDG1gLqn/yHCfo9mnzjztHeSLoR+SRmDg5tCcBjGEKdpTEvERjBP8Yw==
X-Received: by 2002:a17:902:ec91:b0:206:9a3f:15e5 with SMTP id d9443c01a7336-2129f6ffbc6mr169167695ad.32.1732513682370;
        Sun, 24 Nov 2024 21:48:02 -0800 (PST)
Received: from [192.168.0.203] ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc2450csm56278715ad.260.2024.11.24.21.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 21:48:02 -0800 (PST)
Message-ID: <3dd6cd63-6893-4b11-a622-81d2afe2737d@gmail.com>
Date: Mon, 25 Nov 2024 11:17:56 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [fs?] WARNING in minix_unlink
To: Al Viro <viro@zeniv.linux.org.uk>,
 syzbot <syzbot+320c57a47bdabc1f294b@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <CAHiZj8jbd9SQwKj6mvDQ3Kgi2z8rrCCwsqgjOgFtCzsk5MVPzQ@mail.gmail.com>
 <6743814d.050a0220.1cc393.0049.GAE@google.com>
 <20241124194701.GY3387508@ZenIV> <20241124201009.GZ3387508@ZenIV>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <20241124201009.GZ3387508@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/24 01:40, Al Viro wrote:
> On Sun, Nov 24, 2024 at 07:47:01PM +0000, Al Viro wrote:
>> On Sun, Nov 24, 2024 at 11:41:01AM -0800, syzbot wrote:
>>> Hello,
>>>
>>> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
>>> WARNING in minix_unlink
>>
>> Predictably, since the warning has nothing to do with marking an unchanged
>> buffer dirty...
>>
>> What happens there is that on a badly corrupt image we have an on-disk
>> inode with link count below the actual number of links.  And after
>> unlinks remove enough of those to drive the link count to 0, inode
>> is freed.  After that point, all remaining links are pointing to a freed
>> on-disk inode, which is discovered when they need to decrement of link
>> count that is already 0.  Which does deserve a warning, probably without
>> a stack trace.
>>
>> There's nothing the kernel can do about that, short of scanning the entire
>> filesystem at mount time and verifying that link counts are accurate...
> 
> Theoretically we could check if there's an associated dentry at the time of
> decrement-to-0 and refuse to do that decrement in such case, marking the
> in-core inode so that no extra dentries would be associated with it
> from that point on.  Not sure if that'd make for a good mitigation strategy,
> though - and it wouldn't help in case of extra links we hadn't seen by
> that point; they would become dangling pointers and reuse of on-disk inode
> would still be possible...

Thank you for the detailed explanation. I understand that the warning 
stems from corrupted filesystem metadata rather than the proposed patch. 
Thank you again for your guidance!

