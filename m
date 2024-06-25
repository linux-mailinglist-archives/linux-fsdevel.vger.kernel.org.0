Return-Path: <linux-fsdevel+bounces-22438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE97D9170D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 21:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D651F231AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 19:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D498D17C7D2;
	Tue, 25 Jun 2024 19:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DsawWFzB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88A217C234
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 19:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342312; cv=none; b=Sgj11mvS+hrRnLpimOwGvd3z7ud6LEiUPVUMUPWEJxrlNGWXvEk+ESUdC6aancYSJQFCSmWFnlZrOELqvYR2WDeKQTGuhWRcDm42hB5bLsXtETdhMu9JVxV9ONt/MWDAL6/rmEHTXQ5dDdeTFmbFJagyruov5zJDCfqgco3yFNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342312; c=relaxed/simple;
	bh=fg2zoGllIIjbAECUKaq4UMiIU+bk0nKphWkDEdUJ2J4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvLnwvAnKH7G0NLP58LB/2K7U/V7WHFAXVB7qlETA2Ughozc3pCKFpnBBrNj1WEZ0GVdZ+fOgIlkNFUa+uAmWG2Msbh0LfkhWhbFGhrzvej6N7SOnRhhyFlGmWSoJowTSPoofZG6YKO1RUX3Fwrzr+wNxGmwi6tPBXUvqM+Z7Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DsawWFzB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719342309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=r9TwRfjhR/DW0oOD+pu4Z2razu3lSRcMly0hukJuRV4=;
	b=DsawWFzBpHyT8D16oqLiaSJoL4UgmIeQkcNNSeXSPsy0URSG/mMfTNC8cUtZtphKk2YmS5
	7O2GLKII2t4XR6b7NbaKUlHgTC32qmyIE/RGDsbVrsihw1ao7o0tejKTqsYnYoQWDDxvOM
	HhO7erqaqPBA2DRzSqL6+/hjMjf2FDg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-goyzsdb6NyKafSEsxAFIOA-1; Tue, 25 Jun 2024 15:05:06 -0400
X-MC-Unique: goyzsdb6NyKafSEsxAFIOA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-362a0c1041dso2490137f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 12:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719342305; x=1719947105;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r9TwRfjhR/DW0oOD+pu4Z2razu3lSRcMly0hukJuRV4=;
        b=NAVfgN80konXuge7RbUKbkD/PP5UZktX5yWcoasWZgn5gkzQPfW1kf/T10qMWvfze3
         yTdwGi+XPKkTDyufTM8lS9Rx33SYvEBMuQhXIT79npyi5vXgGwya5jgWLlm9l0ZxQu3p
         OSdEB9CK3neBpDyFnAkYfMej2+beOS/eKd9KIwAJKJZoq+OjJ6sBsnsZX+rjSvome+pj
         pc3s1LwO9tZamh6YhJNXJm1stJ/1P2lJK26q92GB35oCQuHaT6SzJvQY5wdTgdTprJqu
         CrM+vHyCX7AFtkGZWtth5NgpP5sOKPLhVQ3LjXws1NRJH59+rSn/ye19mU6ta4qGJJZv
         ZX/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXG9kuMmEn8B5vurNtc40FgpYwjcf8KgE+IJupG9Igg0VCu2u4APND5vdRdiNb6MXEvkUSQrefBQorOZiGDT7Jp4Z6LAgBMichrylPKWg==
X-Gm-Message-State: AOJu0Ywvy0DaeT77ZGNodzyzv+0J264sk9dxkjqSfe1wHl4mM2v3bcpf
	7/0IuxAChPalk/sEOBqcKCjy/1cn6fYYCXJqsgCrZIUlyuPCho9GLkFwmRHoGv7rwFfzNzMYZIF
	+1KCCdJm2vSNL5F0xF2wvJGM2SfXBAqzZ3lR2MbJ0fgJdGMcdd379xY0cjRYjYLM=
X-Received: by 2002:a05:6000:1f83:b0:366:f496:c0c2 with SMTP id ffacd0b85a97d-366f496c101mr5062654f8f.6.1719342305094;
        Tue, 25 Jun 2024 12:05:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj78+1ZCxmIXmWK2vLZFgpvuBZks+468mBLbYCeAcG8sI8G169pp6JRcnrlNQo2bKmT4lRKA==
X-Received: by 2002:a05:6000:1f83:b0:366:f496:c0c2 with SMTP id ffacd0b85a97d-366f496c101mr5062633f8f.6.1719342304668;
        Tue, 25 Jun 2024 12:05:04 -0700 (PDT)
Received: from [192.168.1.34] (p548825e3.dip0.t-ipconnect.de. [84.136.37.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8cb6d2sm13657628f8f.111.2024.06.25.12.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 12:05:04 -0700 (PDT)
Message-ID: <f27d4fa3-0b0f-4646-b6c3-45874f005b46@redhat.com>
Date: Tue, 25 Jun 2024 21:05:02 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mm/filemap: Limit page cache size to that supported
 by xarray
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 djwong@kernel.org, willy@infradead.org, hughd@google.com,
 torvalds@linux-foundation.org, zhenyzha@redhat.com, shan.gavin@gmail.com
References: <20240625090646.1194644-1-gshan@redhat.com>
 <20240625113720.a2fa982b5cb220b1068e5177@linux-foundation.org>
 <33d9e4b3-4455-4431-81dc-e621cf383c22@redhat.com>
 <20240625115855.eb7b9369c0ddd74d6d96c51e@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240625115855.eb7b9369c0ddd74d6d96c51e@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.06.24 20:58, Andrew Morton wrote:
> On Tue, 25 Jun 2024 20:51:13 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>>> I could split them and feed 1&2 into 6.10-rcX and 3&4 into 6.11-rc1.  A
>>> problem with this approach is that we're putting a basically untested
>>> combination into -stable: 1&2 might have bugs which were accidentally
>>> fixed in 3&4.  A way to avoid this is to add cc:stable to all four
>>> patches.
>>>
>>> What are your thoughts on this matter?
>>
>> Especially 4 should also be CC stable, so likely we should just do it
>> for all of them.
> 
> Fine.  A Fixes: for 3 & 4 would be good.  Otherwise we're potentially
> asking for those to be backported further than 1 & 2, which seems
> wrong.

4 is shmem fix, which likely dates back a bit longer.

> 
> Then again, by having different Fixes: in the various patches we're
> suggesting that people split the patch series apart as they slot things
> into the indicated places.  In other words, it's not a patch series at
> all - it's a sprinkle of independent fixes.  Are we OK thinking of it
> in that fashion?

The common themes is "pagecache cannot handle > order-11", #1-3 tackle 
"ordinary" file THP, #4 tackles shmem THP.

So I'm not sure we should be splitting it apart. It's just that shmem 
THP arrived before file THP :)

-- 
Cheers,

David / dhildenb


