Return-Path: <linux-fsdevel+bounces-35902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4BD9D976C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 13:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69042285B4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 12:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2B61CDFBE;
	Tue, 26 Nov 2024 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b20KNGKv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9EE36C;
	Tue, 26 Nov 2024 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625356; cv=none; b=RXc5BbjSIcVxka9D54dbTOP/NdTr68dqqWiF4NmelXYbACIG3X0D+mxhkcjNre9lyO3ooY7NW5+7MArlLff0+m76nVZDyeLQb/Gm08JRoc66CGEcBMVA5jWBktUCKttC7hyh2Nvwn2ZE8csD8UgpTHHM5XJm8xtLiKOQvIRWx44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625356; c=relaxed/simple;
	bh=VUoMqXVLY+GmVKqlO0TpKf0FJrvF6KvhdzOUouz0N/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MBtBeQL1E3WnOzIaJKgraXwLmG8rDsLFSgyTJFMflsOFet/6FiaWmxmIMeg7Q+JXF1lOP9Q1wbgepZbgl4CHFvyx3ywDBVMuVZn13SE5u40HG/70yHdd5K/NkRCU2vMZhJqsY3joxPkix2XeKrH6wmhee8K6DT/0YH0UUzZwHtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b20KNGKv; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53ddd4705f8so2734321e87.0;
        Tue, 26 Nov 2024 04:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732625353; x=1733230153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=arVq5sYPtBHjzPOt7CSX/eUWHNFhe4Yu0pMFs73XXFc=;
        b=b20KNGKvaT0M0cznNB5nOBRBUQXvLMT20fOPWbmihLSHqVLqBDCjh4PmEeTNGcweqd
         kGES+YRYm5zYBVNad0j2T4qiaV8+RI/nr7OKlNe2ADerbVJeu/4gj/UjCocBJAjpDFW9
         itzhhvnYaXuy/QVncyIM4Uuys2N1Cj4ugt+8sWjx7NQDgljOVZm1BUKohulHzRhe9caF
         HAqLRWL6ZOJn6Fh3PQQl5uztZPCACCTOvd6MVG5p4aFl5RH+BLRZ7EnsMnZlLLu+kykX
         bMkoaEf/N1njLdf9IN/pjw31EMFCsXkjxjO4nvNTPUKGY86ZHV4Wp2OwepR/qC9kOiqq
         ZthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732625353; x=1733230153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=arVq5sYPtBHjzPOt7CSX/eUWHNFhe4Yu0pMFs73XXFc=;
        b=Gjxc0pbf7QWOWkJntiXMtuSES+kUbxJCW3D2mqr9M99bPa5Vm+sLMHQT8eY6x2CTfo
         CQoL+Fxt4KcHCGLTPxAEl0XabtNevOlmd1dpvYCNcGq+Jt4xXi0pl83B6gC1210dLksD
         z2kL4u5PagiCPLVrT69DizzQVgrHUX1osB1UlQvq5Xbrv4zmIcatMl4os6FfFe2nzs16
         S2nJjG/AsZLEbAoXsZCz+hsgDP18pmkOMaq7ifAHyNLuS9ZwcPFgmlAzEaBtsIhG0yh+
         8eqXVt/DbuO3upKHBgdzqJUC7kogZVcRvnOX7bOk7X2E5OA/RtSsh6AGSWReMky3tZU0
         n3nw==
X-Forwarded-Encrypted: i=1; AJvYcCU6A0s9NKQ8jxdbhSAOKgT/trffxDyzmL1Igp61R+7c5Y2dkJZtNqOwmBIWuMRcQuiIvpmtQwg0SkcgW/E1@vger.kernel.org, AJvYcCWlsZ1FYZDoXHiECtQs6/NVdnuoyv+yYJ1MTcUX30+kQAwAIoAHpQltDNZInXoUOt3fn+BKzKXLvVsKCdDy@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv44NCwrGkgiPFbhIyC1OVnygqsooA1EeFYBsEg05aEm2tjOjs
	5Xlk3cyCLlcrntTztfDiEgHaWOG+/G7HVOtsw7i62PWsDkVQ6aOKB01i7EbO
X-Gm-Gg: ASbGncstkfTc28YFUhuz68o4C8xkX61cIzWTubcIUBrJqP+2U5HVo+suTdZjyrM9qan
	G9HdNFdZ8Jr+80rpu9PTk8X8F2t57UUYm6lDgWS5NlsixSSXk3h8I6BMcZ3Htm6lgZcAvoa3TyN
	zZZc0q/9Xyq1MARou54IUfyHK5gFqlHuhyk8ElIIgS+sVLBEYg9+F8enfga65U2pY8WHDrxIl+0
	pX5gEc0XCQHXwZq55NKO0T55Dd3A8ijEUw7fDXKsuHZzD5hYveDSQz/p01fdGEIzn08PLQhL4HU
	vx9+mwpq
X-Google-Smtp-Source: AGHT+IFVpS4FmtsdmagtZddlo7pfwq3eSDGmyAJK0KYwfojtIIFI/sDvVOq140czgbRRX3zvdTroeA==
X-Received: by 2002:a05:6512:3b06:b0:53d:d06c:cdf8 with SMTP id 2adb3069b0e04-53de8800269mr1074256e87.1.1732625352549;
        Tue, 26 Nov 2024 04:49:12 -0800 (PST)
Received: from [130.235.83.196] (nieman.control.lth.se. [130.235.83.196])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2497e60sm2004772e87.256.2024.11.26.04.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 04:49:11 -0800 (PST)
Message-ID: <6777d050-99a2-4f3c-b398-4b4271c427d5@gmail.com>
Date: Tue, 26 Nov 2024 13:49:09 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression in NFS probably due to very large amounts of readahead
To: Jan Kara <jack@suse.cz>
Cc: Philippe Troin <phil@fifi.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <49648605-d800-4859-be49-624bbe60519d@gmail.com>
 <3b1d4265b384424688711a9259f98dec44c77848.camel@fifi.org>
 <4bb8bfe1-5de6-4b5d-af90-ab24848c772b@gmail.com>
 <20241126103719.bvd2umwarh26pmb3@quack3>
Content-Language: en-US
From: Anders Blomdell <anders.blomdell@gmail.com>
In-Reply-To: <20241126103719.bvd2umwarh26pmb3@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024-11-26 11:37, Jan Kara wrote:
> On Tue 26-11-24 09:01:35, Anders Blomdell wrote:
>> On 2024-11-26 02:48, Philippe Troin wrote:
>>> On Sat, 2024-11-23 at 23:32 +0100, Anders Blomdell wrote:
>>>> When we (re)started one of our servers with 6.11.3-200.fc40.x86_64,
>>>> we got terrible performance (lots of nfs: server x.x.x.x not
>>>> responding).
>>>> What triggered this problem was virtual machines with NFS-mounted
>>>> qcow2 disks
>>>> that often triggered large readaheads that generates long streaks of
>>>> disk I/O
>>>> of 150-600 MB/s (4 ordinary HDD's) that filled up the buffer/cache
>>>> area of the
>>>> machine.
>>>>
>>>> A git bisect gave the following suspect:
>>>>
>>>> git bisect start
>>>
>>> 8< snip >8
>>>
>>>> # first bad commit: [7c877586da3178974a8a94577b6045a48377ff25]
>>>> readahead: properly shorten readahead when falling back to
>>>> do_page_cache_ra()
>>>
>>> Thank you for taking the time to bisect, this issue has been bugging
>>> me, but it's been non-deterministic, and hence hard to bisect.
>>>
>>> I'm seeing the same problem on 6.11.10 (and earlier 6.11.x kernels) in
>>> slightly different setups:
>>>
>>> (1) On machines mounting NFSv3 shared drives. The symptom here is a
>>> "nfs server XXX not responding, still trying" that never recovers
>>> (while the server remains pingable and other NFSv3 volumes from the
>>> hanging server can be mounted).
>>>
>>> (2) On VMs running over qemu-kvm, I see very long stalls (can be up to
>>> several minutes) on random I/O. These stalls eventually recover.
>>>
>>> I've built a 6.11.10 kernel with
>>> 7c877586da3178974a8a94577b6045a48377ff25 reverted and I'm back to
>>> normal (no more NFS hangs, no more VM stalls).
>>>
>> Some printk debugging, seems to indicate that the problem
>> is that the entity 'ra->size - (index - start)' goes
>> negative, which then gets cast to a very large unsigned
>> 'nr_to_read' when calling 'do_page_cache_ra'. Where the true
>> bug is still eludes me, though.
> 
> Thanks for the report, bisection and debugging! I think I see what's going
> on. read_pages() can go and reduce ra->size when ->readahead() callback
> failed to read all folios prepared for reading and apparently that's what
> happens with NFS and what can lead to negative argument to
> do_page_cache_ra(). Now at this point I'm of the opinion that updating
> ra->size / ra->async_size does more harm than good (because those values
> show *desired* readahead to happen, not exact number of pages read),
> furthermore it is problematic because ra can be shared by multiple
> processes and so updates are inherently racy. If we indeed need to store
> number of read pages, we could do it through ractl which is call-site local
> and used for communication between readahead generic functions and callers.
> But I have to do some more history digging and code reading to understand
> what is using this logic in read_pages().
> 
> 								Honza
Good, look forward to a quick revert, and don't forget to CC GKH, so I get kernels recent  that work ASAP.

Regards

/Anders


