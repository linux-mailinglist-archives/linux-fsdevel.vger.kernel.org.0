Return-Path: <linux-fsdevel+bounces-77149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJVfG8tHj2kiPAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 16:48:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D711E137AEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 16:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61AAB30457DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 15:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7F5242D7F;
	Fri, 13 Feb 2026 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LawHhhqW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B72246762
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770997698; cv=none; b=n9Xm2s93GerZEPJcdNW7+wiPRFxUQNxVqqn4S2j32ochy2LSMxmen/uzs3A9dkV5Mt25bS1HsT7XYxEB1Cc0Dvg0nM/q9boHYadE6h+ao1nBCp/8bd7d39UK1sBvqmPfYbgFyNmkyUCz/OIXzKXfMmJeUjACVMuJej7HUZwnB7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770997698; c=relaxed/simple;
	bh=nD6qxUP7rcMNUF0ZzQg0ziWciNCGY9o1pQSF1UGf/+I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RYoxGPos+sv7VvfAMRDsdM6KLNjvpeP1C8XNYQ0lCUmCvVYx8AJ7EN+MXGmiUTOVQzgmBWhqLBld9MmVY9OxadkswRc08vHMm3XqDyJ//F/rwukB6qiGTqFbI9mb6cRo0Ddpin5sV0VKUjFsX0dkYFg2jVKbCCW4O6eUS9op1tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LawHhhqW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4836f363ad2so12362025e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 07:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770997696; x=1771602496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NiRUF6/DVl3csez3xjj5jGo6j3rcxqiQupuPFsBgNwY=;
        b=LawHhhqWx5vZchxB/79rjAEZDvIYrVy/v7rRchhR5407NUEHKVyBhI0vYZqOIM8dSG
         Z45eEB8OyzJoGkw8ZCSiG40w5OEAUgJdL7um+iW97rh0sTey7vWqoavF5sglhR4Yp9cv
         s4uJuniUzgcG7Im6jLnAI6nuMhWhmBtcz/ozfHj6dDskP/S7cL1zz0dh8H9cmfvMLzox
         vUn7MRbRXt+eIrb29NZZ3G9DUa20pnGk+QoS+ClPtyVhgMdFoqhVGTPpz87iyJO92weW
         mEcW2P2LgEtP/0LX3+uJowueS6e29fsJ9g39MSPMdqqrZ3c8hFGex5UNa7OqsBskFzQB
         pJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770997696; x=1771602496;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NiRUF6/DVl3csez3xjj5jGo6j3rcxqiQupuPFsBgNwY=;
        b=YrOkOb1h2s4XvLA4WYOrS4NrlynuxmSquqIzVebNApqdmOHd3IbU+AseHkMXkD96/m
         lZFBvTNfIdhG353FPu6TWEzCx/3ZJE15zYKE1+RLUsq/Cvgi0yteKfwy3zDY/P+h0NCw
         FZ+R8J5Rymcu93YsS5noftdcUkz9bPgEFXWwNNepJJ0UQqaIsl90GRmaljn9KI02jrat
         LOu3V/uxALuPJIoL8KgKCkHvWXHUhRrkqGD7+NM/w8vQRMfWaBhDUhjdLkZCuSr4eHab
         mUcqWMnTKoOSofpQ2UlAB67K9eRbroogFnYZtlX/J+zZNflMtK2deg+G2K6Xe6GyL1Lh
         OXrg==
X-Forwarded-Encrypted: i=1; AJvYcCU8FQlMznIDhTCUQxeK/0AVbYESfnrYaJ66ZToKHsG0wWf5o21PzkrSWtLyDzSA6Gc+wU/6RZpq5YySXCDF@vger.kernel.org
X-Gm-Message-State: AOJu0YxfXg7rT2+nXck9WVReGmwD2O3ctNyfsezuZcDp3feY0EIohpwi
	fbKTvHPHXPobYsAMi/sP3085es9fiUw2jw9JfPLbzvUQqnnDfR7SV/tqxse5ErXN
X-Gm-Gg: AZuq6aK3vbTbMEHxHSO3sdXk5Tz076OwgYXDWrXqw1QlKGlVrxDKppBOspCyAqGQJKk
	MFf9mycQxJvmZVZm81ZcYHZDlmghQHyqYxc0rvCTN/16NI69BsUEvWFqeu2vOvZimpnV7QFZgaK
	T4GPwuQGdWtvtTXxH/1ehXN/6wF6T1VL6A9Ry1o3Ffp/DY8uVh4cV4hReTvb/qxuWXn5ko2EIgO
	Ly0TF98RZHZekmw9Gcg9oraAHhCv8FI3r3M466mCdg4z+AvTnjhoyUOlms3Z/DxVrvZ0Y4scqoN
	OPyk+M4gbpsHMWzCYryaLd7eW+6WJm1VB9k7pvt7UffNMqM7IY2IsITtdOxcRH3FJKDC4n1ULpe
	Bd0IiCtwjJ8ulFNzWPZI7rDimFeW+nVHyGRAjkOpUbyhhXVGxLOw4QEjyC+KjgVAilAQ4ndII3T
	fLGolTfRvIlOg2URt9Fg3BZLADpdAnKyeUmzIumcDqWPsk2aGc6dl095SYzB9zI/5LvmgfL3aIv
	q1nf/LGVCoH0wLUCd2gq2EKzWczSmxQxHIoTJQMNen6HqbteLQ5EGHZeA==
X-Received: by 2002:a05:600c:458a:b0:483:6f37:1b33 with SMTP id 5b1f17b1804b1-48373a58babmr32970345e9.30.1770997695870;
        Fri, 13 Feb 2026 07:48:15 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:c974])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abd259sm6257808f8f.24.2026.02.13.07.48.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 07:48:15 -0800 (PST)
Message-ID: <a7d9d3ca-16b1-4299-a7fe-2fc19ca894cb@gmail.com>
Date: Fri, 13 Feb 2026 15:48:11 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/11] io_uring/kbuf: add support for kernel-managed
 buffer rings
From: Pavel Begunkov <asml.silence@gmail.com>
To: Christoph Hellwig <hch@infradead.org>,
 Joanne Koong <joannelkoong@gmail.com>
Cc: axboe@kernel.dk, io-uring@vger.kernel.org, csander@purestorage.com,
 krisman@suse.de, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
References: <20260210002852.1394504-1-joannelkoong@gmail.com>
 <20260210002852.1394504-4-joannelkoong@gmail.com>
 <89c75fc1-2def-4681-a790-78b12b45478a@gmail.com>
 <CAJnrk1ZZyYmwtzcHAnv2x8rt=ZVsz7CXCVV6jtgMMDZytyxp3A@mail.gmail.com>
 <1c657f67-0862-4e13-9c71-7217aeecef61@gmail.com>
 <CAJnrk1YXmxqUnT561-J7seaicxFRJTyJ=F3_MX1rmtAROC6Ybg@mail.gmail.com>
 <aY2mdLkqPM0KfPMC@infradead.org>
 <809cd04b-007b-46c6-9418-161e757e0e80@gmail.com>
 <CAJnrk1Y6YSw6Rkdh==RfL==n4qEYrrTcdbbS32sBn12jaCoeXg@mail.gmail.com>
 <aY7ScyJOp4zqKJO7@infradead.org>
 <7c241b57-95d4-4d58-8cd3-369751f17df1@gmail.com>
Content-Language: en-US
In-Reply-To: <7c241b57-95d4-4d58-8cd3-369751f17df1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77149-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[infradead.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D711E137AEF
X-Rspamd-Action: no action

On 2/13/26 15:31, Pavel Begunkov wrote:
> On 2/13/26 07:27, Christoph Hellwig wrote:
>> On Thu, Feb 12, 2026 at 09:29:31AM -0800, Joanne Koong wrote:
>>>>> I'm arguing exactly against this.  For my use case I need a setup
>>>>> where the kernel controls the allocation fully and guarantees user
>>>>> processes can only read the memory but never write to it.  I'd love
>>>
>>> By "control the allocation fully" do you mean for your use case, the
>>> allocation/setup isn't triggered by userspace but is initiated by the
>>> kernel (eg user never explicitly registers any kbuf ring, the kernel
>>> just uses the kbuf ring data structure internally and users can read
>>> the buffer contents)? If userspace initiates the setup of the kbuf
>>> ring, going through IORING_REGISTER_MEM_REGION would be semantically
>>> the same, except the buffer allocation by the kernel now happens
>>> before the ring is created and then later populated into the ring.
>>> userspace would still need to make an mmap call to the region and the
>>> kernel could enforce that as read-only. But if userspace doesn't
>>> initiate the setup, then going through IORING_REGISTER_MEM_REGION gets
>>> uglier.
>>
>> The idea is that the application tells the kernel that it wants to use
>> a fixed buffer pool for reads.  Right now the application does this
>> using io_uring_register_buffers().  The problem with that is that
>> io_uring_register_buffers ends up just doing a pin of the memory,
>> but the application or, in case of shared memory, someone else could
>> still modify the memory.  If the underlying file system or storage
>> device needs verify checksums, or worse rebuild data from parity
>> (or uncompress), it needs to ensure that the memory it is operating
>> on can't be modified by someone else.
>>
>> So I've been thinking of a version of io_uring_register_buffers where
>> the buffers are not provided by the application, but instead by the
>> kernel and mapped into the application address space read-only for
>> a while, and I thought I could implement this on top of your series,
>> but I have to admit I haven't really looked into the details all
>> that much.
> 
> There is nothing about registered buffers in this series. And even
> if you try to reuse buffer allocation out of it, it'll come with
> a circular buffer you'll have no need for. And I'm pretty much
> arguing about separating those for io_uring.

FWIW, the easiest solution is to internally reuse regions for
allocations and mmap()'ing and wrap it into a registered buffer.
It just need to make vmap'ing optional as it won't be needed.

-- 
Pavel Begunkov


