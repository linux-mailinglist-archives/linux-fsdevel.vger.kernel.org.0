Return-Path: <linux-fsdevel+bounces-34096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8455C9C25DD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 20:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9F7284079
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 19:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2885D1C1F30;
	Fri,  8 Nov 2024 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EHT8H23V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C90366
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 19:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731095402; cv=none; b=gPlj7URV3gFndn9hknTpNyXvVwGwkW+O5rh5Re0wWfBs59Jg3VWMIFdeTBah/gT6DMB+FxdutZ4b2PC+R45B0or+uvimexora2OSTG9A2YIKur0IReNj0GIWBJxLLOp2Dwa+1NboU5F7o0/QKbMOupc67j/3pEd+QMWOYPO4BXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731095402; c=relaxed/simple;
	bh=r1OWKhI+875hOXCySuxwA5TLJR9P4JO4X+mzkpOcjDg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=medoxGPo0mN1scN0vXo+IKIF2TLYjO8G4AKbeOI0NFAJlnpH/MnKunq3bKe7bosW2YCn7OXMN31t6V1xyRWKV3FtiVhhFDonwCm1LL4uo8pbNnEFoXgg1kLlvl1yOHvlbgVf8OWtleNM4anDpmdaTe5Q2jlNLDax5sA93rzu4Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=EHT8H23V; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e4c2e36daso2300960b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 11:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731095400; x=1731700200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JzN6QznSC5tjEMn3nyfoxiO1pM3DGtlvzOusZhTDEN4=;
        b=EHT8H23VME0lfFgxPhD5EwIjvCAZpiSQx3vlfCpGwb9qEH2jn176fCV5SCdZKrkXGN
         Jrdd4lECiB9MO6uSOUAGMPNP9dNS5OZug/hswmTXTxvFJti1dE9Ayr9xloESNleaY/4M
         yNo6Lp5tT6Ijh09iKTZMy5Jo848/D7bHqIDisONMLpSwS42zYxgUIYKiqtwZh6+qZ2C1
         hmq6+ekpdpLC91tobJUHyFSwvLEd3UVfN97BHuul1627dDRImnPk0njzeUDgAOawQMZH
         48AQ4B3Ko4nozg1pLNRX8TYHOCl2L1PBuCkpUHIjVmnXvmU82IP2bde3Vq09kBd/N0Zi
         WSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731095400; x=1731700200;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JzN6QznSC5tjEMn3nyfoxiO1pM3DGtlvzOusZhTDEN4=;
        b=DoJNWzgnYDvo2gB6czEibHECmiiIlTU8BnFKdP3RDI+6VwXkXD+0DJD/GIwOOH1fEK
         OL5tmP3pt87lUsHadCNrNwxNg9W4G/l1yv+2rHU02DV2VMLgn0m+5nuIqS8+dE2Ri9ce
         LzIHGLQGxCO+2HPsTzHLYX31upE7OlF4fCHLx7vdG3mYf6lUSNDI3pAQO3LMpBAWtMjm
         uuBmP2zbpzcdfbioS0tTW3vS8IyYEi+VgAa6bGvHICE+jO/e+jLPsjptRzWJG/btfA89
         Zijmsg5yNmQuWk2VbwruOCC1ia7stpqaUZ3x+/3Q6zmqoBEbYiOBUYtVT47S4dZgoONj
         01BA==
X-Forwarded-Encrypted: i=1; AJvYcCXDk6qBYfQXMvvtfEs+RnlUotxnlIu+fXOezssswEhgFlpMA5f+koV30qBWVNYzrZf2QY1LInQTbV4OMUDV@vger.kernel.org
X-Gm-Message-State: AOJu0YyQqa+Wdkmxm//iz7chgAFQLalBnUYTpUd074YiRM5r5vG4/5Td
	qdYIH4jzDcqGgpIF3STqg9wYy01xZ0pRuo6l5XbSX7K0wS0geP0eT50VFCFlLCo=
X-Google-Smtp-Source: AGHT+IFv4bj6W+XkBI824Sbw/3QyvrD3xc41IYnjTjX09nvgLIZA50qCFpVFQcp91Viwtq+ys917Sg==
X-Received: by 2002:a05:6a20:3944:b0:1d9:19bc:9085 with SMTP id adf61e73a8af0-1dc234afb33mr6480715637.14.1731095399786;
        Fri, 08 Nov 2024 11:49:59 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a1af26sm4156958b3a.162.2024.11.08.11.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 11:49:59 -0800 (PST)
Message-ID: <30f5066a-0d3a-425f-a336-16a2af330473@kernel.dk>
Date: Fri, 8 Nov 2024 12:49:58 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] iomap: make buffered writes work with RWF_UNCACHED
From: Jens Axboe <axboe@kernel.dk>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org
References: <20241108174505.1214230-1-axboe@kernel.dk>
 <20241108174505.1214230-12-axboe@kernel.dk>
 <Zy5cmQyCE8AgjPbQ@casper.infradead.org>
 <45ac1a3c-7198-4f5b-b6e3-c980c425f944@kernel.dk>
Content-Language: en-US
In-Reply-To: <45ac1a3c-7198-4f5b-b6e3-c980c425f944@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/24 12:26 PM, Jens Axboe wrote:
> On 11/8/24 11:46 AM, Matthew Wilcox wrote:
>> On Fri, Nov 08, 2024 at 10:43:34AM -0700, Jens Axboe wrote:
>>> +++ b/fs/iomap/buffered-io.c
>>> @@ -959,6 +959,8 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>>>  		}
>>>  		if (iter->iomap.flags & IOMAP_F_STALE)
>>>  			break;
>>> +		if (iter->flags & IOMAP_UNCACHED)
>>> +			folio_set_uncached(folio);
>>
>> This seems like it'd convert an existing page cache folio into being
>> uncached?  Is this just leftover from a previous version or is that a
>> design decision you made?
> 
> I'll see if we can improve that. Currently both the read and write side
> do drop whatever it touches. We could feasibly just have it drop
> newly instantiated pages - iow, uncached just won't create new persistent
> folios, but it'll happily use the ones that are there already.

Well that was nonsense on the read side, it deliberately only prunes
entries that has uncached set. For the write side, this is a bit
trickier. We'd essentially need to know if the folio populated by
write_begin was found in the page cache, or create from new. Any way we
can do that? One way is to change ->write_begin() so it takes a kiocb
rather than a file, but that's an amount of churn I'd rather avoid!
Maybe there's a way I'm just not seeing?

-- 
Jens Axboe

