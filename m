Return-Path: <linux-fsdevel+bounces-60138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D559B41AB5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 11:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37153188F7D0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 09:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75FD2D6E58;
	Wed,  3 Sep 2025 09:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcF926pt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E192D595D;
	Wed,  3 Sep 2025 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893162; cv=none; b=rqf0f8xI3zW61pk84toJqd0tF6E8G4VhghgQCD1yB3+fqvI2lEvK5Cah/PDS2w/mCJke7pmvrrJ5xCbdrgC/JFtk7VQpI+cgyvDbpcdhdI++bm3dt6KHr2q4OXUbtCH8Wrdt54ObZ31zNJKnh0i3G6dvO47SAttuUeqh8l+Yz14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893162; c=relaxed/simple;
	bh=DRHRhDYbpmHzpfFsIrEuhLJe2BcDsU7tEMe0VoXil2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDecmhM3/fJ8fnktqOYNImC0URfVYGrGUlNBtaNEMq6VnXQHme/fGcORoByfIxj8Bd6XjhlXo1FzYIqHwDWPmtyy1pvQMwdMYLq5ykN5epyXKu2596LRfNxmYqv5GmoR+jAvoB8an9wlNK8nJ6LjBZixpBjum0SiGGgn2RGZhEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcF926pt; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b8b8d45b3so29414055e9.1;
        Wed, 03 Sep 2025 02:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756893159; x=1757497959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m51P/mqA6vihj9WJ5mZRAm+FhXTOdtX2l73PkgmXgs8=;
        b=kcF926ptivm32cuoXcVj8WKO0wo0TyA4N64qxhIVuHngWWIPTodbiOjehVw2yQS+WA
         z6QwtO30GSCX73wdHI6LvOr9yvhp44yemBlLuangCG8ETrgjsvOO0LSyemIaeIRkxIPf
         DbWwKRA8g3B8oIrDfcDxOA5WBzSc0J6iXIOkgTHSJnH2URt6Iz7tyVUiRL+F4TrtLwNu
         tsQ0QgsWdqbM1auCIoYO1pg1kgz94eIzQMk3aOgUabK3svCPujUGeCGv14C4qDITtF7Q
         b342Q77FZF5DNIL6Xg9zID6o3VzZlAr7LgviTTd26vIzHzHjKKJHyYgSKgxxaAzZKD3w
         LBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756893159; x=1757497959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m51P/mqA6vihj9WJ5mZRAm+FhXTOdtX2l73PkgmXgs8=;
        b=CkO7Rof6jcL0AUmn07Oz36mh07iMm6F9NCOpjyRw/KEM1C4XodWPJd6+nZvYqohh6r
         5+h4vvWgchRj8fKBySICmRca36SuHcqNjF+szE5qXGLm9s+mAZZ4Z9nFfThk8i6fdUE5
         Ic4df72Xo6FKI5ryBPud8adVnKJGuNC7WTNRMegqAAHVMN6MhW9MIa5zoB/5IUyUsWKG
         yfn81j7WEiiAYQcEGgW74ZPqZi/vrsHqWcMeLGl9qb3ZHyw6WC90RGD9sWzGvFBa87+6
         TGPE1J5Q9qAxFpPgC6BXnOBGmuzLkececdWyxlD3WNg6QVea7hHCCvH5K6fUXjY0hYae
         MHqA==
X-Forwarded-Encrypted: i=1; AJvYcCUJKVRIuegyiJabkIuZ03bOoh6ZwvxufgIEOBqHq/m3QEXPILrX7732vRRTRUJwpxhvjhcR2nrc5dIj3a1lgg==@vger.kernel.org, AJvYcCW/PZtghYteSVcb95Gx/eaZw5jfDNbT+mU0xdqzpt/PZhTOjZykR9qIfkCVMQKV4v2wgu27pSpn1YgiwA==@vger.kernel.org, AJvYcCXGDYwaJHTM5j2RY5mDiG4X5o9Ofb6CMrGkaUzWniB2iJ/6aj7S+2l4yTvyUHTeqIjCCKFQ/HUIzMDQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyHnsJOQOpUtmNt7w9QZctRmimousHmTpVmqRGmECPMEzcFszvO
	MqB042287m09u7qVCgLL9BLGinRu183rYNfHL/XbDHx4qdLVv9KLcH3S
X-Gm-Gg: ASbGncvnx25caK81ZE9Itxv0N7SiFJLod60JhxVu6+MLdDaoosK7y3b6B7+NryHET0j
	aFR+EmTHT7bp1+z7rRasK6hMKkP869uBH3i36sqJPGmduyfy3WuxpqeToom8pSB9o486wXbmweC
	CBAdQI4idUefuLePdKtZFYDcjndd81tFqOlbW5jnevJUL4yWFNHJgKoR8AdM2i23J9Ua7Yy7oDV
	IG1QjTPLxuyDx8rZMz51MGwQmzWrCjJEL4shrIdibqqBION6WlFbzgUSwokUtMuvbtXvUI00Gof
	naKN2/3qJM515ngyadOKyhBP6I6APyJumFTHQAV4bhjiXd5aPFocMJOUc9h0Iww+VNElyrFSs+a
	CtfQRC/LmZzWNfFsNZIeVJ2qxS8fgQBIxPPZKdkxMHikpNT2BkqAaMPLXNEjIhVysVQ==
X-Google-Smtp-Source: AGHT+IGibCHhw4opsq0msOZTNUGtFpdoyj60pXb9z9tNXwCehNkks3wS9+oy1yII1iFWVzY0Fyj8Fg==
X-Received: by 2002:a05:600c:a45:b0:458:bf0a:6061 with SMTP id 5b1f17b1804b1-45b85598614mr140589115e9.24.1756893158409;
        Wed, 03 Sep 2025 02:52:38 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:92eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fb9dbfsm22934776f8f.43.2025.09.03.02.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 02:52:37 -0700 (PDT)
Message-ID: <c4bc7c33-b1e1-47d1-9d22-b189c86c6c7d@gmail.com>
Date: Wed, 3 Sep 2025 10:53:49 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iomap: allow iomap using the per-cpu bio cache
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
 Fengnan Chang <changfengnan@bytedance.com>, brauner@kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20250822082606.66375-1-changfengnan@bytedance.com>
 <20250822150550.GP7942@frogsfrogsfrogs>
 <aKiP966iRv5gEBwm@casper.infradead.org> <877byv9w6z.fsf@gmail.com>
 <aKif_644529sRXhN@casper.infradead.org> <874ityad1d.fsf@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <874ityad1d.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/23/25 05:15, Ritesh Harjani (IBM) wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> 
>> On Fri, Aug 22, 2025 at 09:37:32PM +0530, Ritesh Harjani wrote:
>>> Matthew Wilcox <willy@infradead.org> writes:
>>>> On Fri, Aug 22, 2025 at 08:05:50AM -0700, Darrick J. Wong wrote:
>>>>> Is there a reason /not/ to use the per-cpu bio cache unconditionally?
>>>>
>>>> AIUI it's not safe because completions might happen on a different CPU
>>>> from the submission.
>>>
>>> At max the bio de-queued from cpu X can be returned to cpu Y cache, this
>>> shouldn't be unsafe right? e.g. bio_put_percpu_cache().
>>> Not optimal for performance though.
>>>
>>> Also even for io-uring the IRQ completions (non-polling requests) can
>>> get routed to a different cpu then the submitting cpu, correct?
>>> Then the completions (bio completion processing) are handled via IPIs on
>>> the submtting cpu or based on the cache topology, right?
>>>
>>>> At least, there's nowhere that sets REQ_ALLOC_CACHE unconditionally.
>>>>
>>>> This could do with some better documentation ..
>>>
>>> Agreed. Looking at the history this got added for polling mode first but
>>> later got enabled for even irq driven io-uring rw requests [1]. So it
>>> make sense to understand if this can be added unconditionally for DIO
>>> requests or not.
>>
>> So why does the flag now exist at all?  Why not use the cache
>> unconditionally?
> 
> I am hoping the author of this patch or folks with io-uring expertise
> (which added the per-cpu bio cache in the first place) could answer
> this better. i.e.

CC'ing would help :)

> Now that per-cpu bio cache is being used by io-uring rw requests for
> both polled and non-polled I/O. Does that mean, we can kill
> IOCB_ALLOC_CACHE check from iomap dio path completely and use per-cpu
> bio cache unconditionally by passing REQ_ALLOC_CACHE flag?  That means
> all DIO requests via iomap can now use this per-cpu bio cache and not
> just the one initiated via io-uring path.
> 
> Or are there still restrictions in using this per-cpu bio cache, which
> limits it to be only used via io-uring path? If yes, what are they? And
> can this be documented somewhere?

It should be safe to use for task context allocations (struct
bio_alloc_cache::free_list is [soft]irq unsafe)

IOCB_ALLOC_CACHE shouldn't be needed, but IIRC I played it
conservatively to not impact paths I didn't specifically benchmark.
FWIW, I couldn't measure any negative impact with io_uring at the
time for requests completed on a different CPU (same NUMA), but if
it's a problem, to offset the effect we can probably add a CPU
check => bio_free and/or try batch de-allocate when the cache is
full.

-- 
Pavel Begunkov


