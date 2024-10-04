Return-Path: <linux-fsdevel+bounces-30968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC129902A7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 14:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97BBEB223C5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 12:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C328415B133;
	Fri,  4 Oct 2024 12:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0SU/NGJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF871FAA;
	Fri,  4 Oct 2024 12:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728043654; cv=none; b=J+bYK88dLP3vIJeWwSZiq8uJKXz1P2r9CtIy+Jaj6bqma54qh/KcdbsERWu6YIhG1feYdH3Ydux0U++X+NEJ6sOllvZmE3UKhsUbtWGBTKDyV7li1WCyHZ5MTBhfTTq3UXjV1Au4VvvsYhW2avJLQ00miH5PV91OgguWgacHlkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728043654; c=relaxed/simple;
	bh=/nlhZDMw86a8EL1I6PUDXGIEBWPdc7RMixIl26A0uPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDDdSyFoXRNsLCdez8JOlAEVHBZ49Sddmf4qYuEmKTYlOoaN94rBpV27tG1B6EqbeLWOKqj250JLyH0AWkrGb5cj04FLXYfcUtmGqEzqglujv0KuzjNkGHad+GqkuFBBB565Ve5N8fHj8GMw6hLM9yqrc8kfP7XBbrq+tQuLfTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0SU/NGJ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c5b9d2195eso2756514a12.1;
        Fri, 04 Oct 2024 05:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728043651; x=1728648451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dJVK921w3iFUMPjOsedY5HobXgKXFD8ikd8FUYg1RJY=;
        b=W0SU/NGJwiGrVoeP5fYedNbW9APJU+k4HFZClkqbWfBOiujOfSxS/bOlY/mN8ne3ea
         JIBfHIvewi/rDHb3iq+glxzzpEAKao9AlDONS8JUD5JjNRRhhvK/XHCdTBJxpqeBm7ju
         +X5FJRUHAONVMx20ceX2vqeHIqVI5shrb86NwlPU2jd0RxwPgEYuhR7fnbgecJ/jmRdx
         mklwNF82GyYINxQBw+cHkHHMa28lGzfEtXvHWkK1gBeC8/6JgMznebaY/h9Y4Qvkdurt
         fCXiKrT0e+cweWX9Iq31g8j6U9aYdHcPfhRr0FVAUyfqLmvX0SU1eIQkQSlj00TM5Ctz
         2g8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728043651; x=1728648451;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJVK921w3iFUMPjOsedY5HobXgKXFD8ikd8FUYg1RJY=;
        b=ODDMfUD2x5RiQmGy0y5tn65tRlUsxTdc3ALaX5Ou7inRX3EqW/O0UaeoJdQEEqofDP
         IrYjffM+A/WAbp8y17rJhJ9GJ3/gpJcAafTM/XplBYLRsPS/caE8QGUvkeIYpBgvACC7
         v2KnjTXB/m960pmVQ6bjkP0ud8s4oETiNi1HtoF6bjeug6QxBnnzGPz6KLK8LCQk2vII
         aqOtmHu75e66oxGcQRW719YJ6hTW2KCJSRz8tMKIj84qITEVa/q/P+Uo82/fu3BhEKej
         HGHrC/U9EFKDzPa+InbLsFzS8/zermZxWnaEZpVPFXXeIs23vm4hs4Gb3Lv5RSngnraq
         HVtA==
X-Forwarded-Encrypted: i=1; AJvYcCVyqwChQ6niv1D5r3ItzA/7aMxeKQwb7UkMkxOLER4hN6fnIZQaDWJkTW62oCP18tjYBs0fM6x8zyNaeUpP@vger.kernel.org, AJvYcCXX5ZSfoCAPBbnUi/JC4Iv9CHIPAYmFHnr6owBGGRvm9SECrfnlIthTwmFXVEdqNVM8eGI60/UYoFf+P48W@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb1s8WqUJbfE2tb2lIaJEcDjcxsJNCyV43OyODC9zNuu3Obyek
	U0hsq37mFtCUwXKhYzDjeyZ++9kwsQgSwJkQTpoZTgqSmVvaehWfJMMEdCfA
X-Google-Smtp-Source: AGHT+IGCmBA6NptMvevhseiOieqkBOfft0hRfl6fCcaTQKwAPYzIHgU2oHNiwCMzms/GqgiqijKR0w==
X-Received: by 2002:a05:6402:538a:b0:5c5:b9c2:c5bb with SMTP id 4fb4d7f45d1cf-5c8d2e9f05dmr1729696a12.35.1728043650570;
        Fri, 04 Oct 2024 05:07:30 -0700 (PDT)
Received: from ?IPV6:2a01:e11:5400:7400:cad:e881:e8d:c87? ([2a01:e11:5400:7400:cad:e881:e8d:c87])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8ca4f713asm1766441a12.97.2024.10.04.05.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 05:07:29 -0700 (PDT)
Message-ID: <991c8404-1c1c-47c7-ab27-2117d134b59b@gmail.com>
Date: Fri, 4 Oct 2024 14:07:25 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Fix NULL pointer dereference in read_cache_folio
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, skhan@linuxfoundation.org,
 syzbot+4089e577072948ac5531@syzkaller.appspotmail.com
References: <20240929230548.370027-3-gianf.trad@gmail.com>
 <20240930090225.28517-2-gianf.trad@gmail.com>
 <ZvrqotTfw06vAK9Y@casper.infradead.org>
Content-Language: en-US, it
From: Gianfranco Trad <gianf.trad@gmail.com>
In-Reply-To: <ZvrqotTfw06vAK9Y@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/09/24 20:14, Matthew Wilcox wrote:
> On Mon, Sep 30, 2024 at 11:02:26AM +0200, Gianfranco Trad wrote:
>> @@ -2360,6 +2360,8 @@ static int filemap_read_folio(struct file *file, filler_t filler,
>>   	/* Start the actual read. The read will unlock the page. */
>>   	if (unlikely(workingset))
>>   		psi_memstall_enter(&pflags);
>> +	if (!filler)
>> +		return -EIO;
> 
> This is definitely wrong because you enter memstall, but do not exit it.

Got it, thanks.

> 
> As Andrew says, the underlying problem is that the filesystem does not
> implement ->read_folio.  Which filesystem is this?

Reproducer via procfs accesses a bpf map backed by an anonymous
inode (anon_inode_fs_type), with mapping->a_ops pointing to anon_aops,
hence, read_folio() undefined.

> 
>>   	error = filler(file, folio);
>>   	if (unlikely(workingset))
>>   		psi_memstall_leave(&pflags);
>> -- 
>> 2.43.0
>>

I suppose the next step would be to contact the proper maintainers(?)
If you have any additional suggestions, I'd be more than glad to listen.

Thanks to both of you for your time,

--Gian


