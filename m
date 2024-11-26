Return-Path: <linux-fsdevel+bounces-35918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFB39D9A6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 16:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9EC165AF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 15:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CC21D63C5;
	Tue, 26 Nov 2024 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIDPG36Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7391D45E5;
	Tue, 26 Nov 2024 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732634889; cv=none; b=CSCXxstL9HULe9169w+Y6LunHbUOdW6cabFsuiqPJcgN5Ud+fZG2DhLjh620mwxNSxtxm6NXFfVhvYVxHN4nnIX1vFBbacXtMbX+kNMQmKGLF7GExCaJ2gfEElJ2Kc/t5ZjfbRQBgqKEowzDzLs+5hSR1uCKx0AZy0MiXq8U6f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732634889; c=relaxed/simple;
	bh=HOpoppkXfOx5jjRlXowirkrqsPFmSBTHZJ4g/BkEY10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=etDJHZrYYC73UVq5qnuZprQbtEOD1DbD17grjfGKQgPhbOsSAH62kUxiUSkbiEELeaW6K6WU/MmyuvQZoXB1MOYZ+v9bWJsmbJNl3RFGq5j/IW4CKO3QpCr7znBtI//m+DeQHhp3J0Vr7x+24pUEgOAWmFGMP4Wp/0xEl0p6b6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIDPG36Y; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ffc81cee68so19707461fa.0;
        Tue, 26 Nov 2024 07:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732634886; x=1733239686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hL92joE2utUXDrWBWHIFKxahnMA5d997Re4iaT4oJkY=;
        b=IIDPG36Y/jlZFqchNL3UVIw44ysZsPXtUYPyjRddN9hv21i9DpXwTV0duDN2nAPlip
         /sjlq1RN/L19+GHMX/18Qv/8/a+wVf2peZs3qCBryPySILpvH3rfcfzMSzu20t709onq
         X6u8jwnytUyaOem5bhtLxuh7cdE5dggWcH9VXHSvnbDVW0czPFUBpYVhNdekBpt3dxpZ
         86SD8+V+qKAkjUXSvFVtT82ac93y/etYB50TjwP3SStio5ZDCySisZbJ0+7H4nhsWgFK
         vQ3aOpvpJ41YuqnU23FekbK+oBZDUAihoyxJnfAcFfEGsCNMbGAXaExexglwfFhmMVwH
         p/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732634886; x=1733239686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hL92joE2utUXDrWBWHIFKxahnMA5d997Re4iaT4oJkY=;
        b=XCRphnRCmfkwpCKiOsHMtSXbwBo5T1XhEVLSoXVeUDlMIRtmL3shS/OkyfbENCuWct
         aCvx38fdzFF1FOUfhlMF5vXu/BiLgR9cLJBAZ+KHRoRebcA56Ctcjhw33ePCfC+4owRA
         y4hiSD0DLDihaMMIgWDe59SPuVhZQggMPbYPSMAzQpBtNBmxpDe4GpLppDQlthaXcLpf
         mOGkFyuspwL+EDpkt7RfhP1jqfS3vgSsQOBVTaZt775kKruE2cjegJnBTzMHSChefz0i
         FVaKeRTKZTjyxLRGnLJC59J89X2MzZ0NgJ7otOH3ptP5DO0xhO0BxrizQ2i1sVNSWkS4
         rY3g==
X-Forwarded-Encrypted: i=1; AJvYcCVmG2+zGTLeIpsiXF1/k8ppW8MyQDYd4DDrMuqzh56TOkN2AXDsvoHvJgKFO1IJjf9xfUGeaTB8wR5qHaY5@vger.kernel.org, AJvYcCXsCTdCzeuEqbdDyKUO1//MnBAxKGcyCbAoY6JjbOAhp34wpYNcVSI+mWNVofMw08/qLzTc1q0KFBpBe9zu@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl4TxFdBwtH5YzEiWSX1vNkHworxU3qD9c82LL3ad6mDhkgF29
	3G4+ikq785PmP8FXwgWly1k+rHwSI62npTXGCp0QpBeITEVJ9Zbq
X-Gm-Gg: ASbGncvC/yQ/fCxItfowP4udUyC9OAnGbw+ZOq7uj6xnkY/re1mEp2vRecOsCLmmDMI
	iBN3IdP9UX4mutQ8MneYSYgq4aTivKjCG5EBKhdhveChQDPe6QagYqGdQWoADxQfPzefxdjZIFc
	d4Hjv2KcVGpGkh/PSEOjMKVKO7awqm0Qd8DJeuaataEoVZT1DUHZRI7peko2RrBV7e6KKWCSUqf
	Ou4cAQBhNPFOz64LTOhzm63fuYicjerx4+u3BbASLZDdhTQOK2HxLaVzLonnokPiKw8U7aW2YKz
	x0O+giXu
X-Google-Smtp-Source: AGHT+IF3odjqvL+3f50N+hGfNnykpAnmeU9HNEIgrF/jthnjL150g9fKJV14VNDDx4LXOZ5E9j/TEg==
X-Received: by 2002:a05:651c:199f:b0:2ff:d15d:649 with SMTP id 38308e7fff4ca-2ffd15d06ddmr12400911fa.31.1732634886074;
        Tue, 26 Nov 2024 07:28:06 -0800 (PST)
Received: from [130.235.83.196] (nieman.control.lth.se. [130.235.83.196])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffa4d171absm18923671fa.15.2024.11.26.07.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 07:28:04 -0800 (PST)
Message-ID: <fba6bc0c-2ea8-467c-b7ea-8810c9e13b84@gmail.com>
Date: Tue, 26 Nov 2024 16:28:04 +0100
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
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.de>
References: <49648605-d800-4859-be49-624bbe60519d@gmail.com>
 <3b1d4265b384424688711a9259f98dec44c77848.camel@fifi.org>
 <4bb8bfe1-5de6-4b5d-af90-ab24848c772b@gmail.com>
 <20241126103719.bvd2umwarh26pmb3@quack3>
 <20241126150613.a4b57y2qmolapsuc@quack3>
Content-Language: en-US
From: Anders Blomdell <anders.blomdell@gmail.com>
In-Reply-To: <20241126150613.a4b57y2qmolapsuc@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024-11-26 16:06, Jan Kara wrote:
> On Tue 26-11-24 11:37:19, Jan Kara wrote:
>> On Tue 26-11-24 09:01:35, Anders Blomdell wrote:
>>> On 2024-11-26 02:48, Philippe Troin wrote:
>>>> On Sat, 2024-11-23 at 23:32 +0100, Anders Blomdell wrote:
>>>>> When we (re)started one of our servers with 6.11.3-200.fc40.x86_64,
>>>>> we got terrible performance (lots of nfs: server x.x.x.x not
>>>>> responding).
>>>>> What triggered this problem was virtual machines with NFS-mounted
>>>>> qcow2 disks
>>>>> that often triggered large readaheads that generates long streaks of
>>>>> disk I/O
>>>>> of 150-600 MB/s (4 ordinary HDD's) that filled up the buffer/cache
>>>>> area of the
>>>>> machine.
>>>>>
>>>>> A git bisect gave the following suspect:
>>>>>
>>>>> git bisect start
>>>>
>>>> 8< snip >8
>>>>
>>>>> # first bad commit: [7c877586da3178974a8a94577b6045a48377ff25]
>>>>> readahead: properly shorten readahead when falling back to
>>>>> do_page_cache_ra()
>>>>
>>>> Thank you for taking the time to bisect, this issue has been bugging
>>>> me, but it's been non-deterministic, and hence hard to bisect.
>>>>
>>>> I'm seeing the same problem on 6.11.10 (and earlier 6.11.x kernels) in
>>>> slightly different setups:
>>>>
>>>> (1) On machines mounting NFSv3 shared drives. The symptom here is a
>>>> "nfs server XXX not responding, still trying" that never recovers
>>>> (while the server remains pingable and other NFSv3 volumes from the
>>>> hanging server can be mounted).
>>>>
>>>> (2) On VMs running over qemu-kvm, I see very long stalls (can be up to
>>>> several minutes) on random I/O. These stalls eventually recover.
>>>>
>>>> I've built a 6.11.10 kernel with
>>>> 7c877586da3178974a8a94577b6045a48377ff25 reverted and I'm back to
>>>> normal (no more NFS hangs, no more VM stalls).
>>>>
>>> Some printk debugging, seems to indicate that the problem
>>> is that the entity 'ra->size - (index - start)' goes
>>> negative, which then gets cast to a very large unsigned
>>> 'nr_to_read' when calling 'do_page_cache_ra'. Where the true
>>> bug is still eludes me, though.
>>
>> Thanks for the report, bisection and debugging! I think I see what's going
>> on. read_pages() can go and reduce ra->size when ->readahead() callback
>> failed to read all folios prepared for reading and apparently that's what
>> happens with NFS and what can lead to negative argument to
>> do_page_cache_ra(). Now at this point I'm of the opinion that updating
>> ra->size / ra->async_size does more harm than good (because those values
>> show *desired* readahead to happen, not exact number of pages read),
>> furthermore it is problematic because ra can be shared by multiple
>> processes and so updates are inherently racy. If we indeed need to store
>> number of read pages, we could do it through ractl which is call-site local
>> and used for communication between readahead generic functions and callers.
>> But I have to do some more history digging and code reading to understand
>> what is using this logic in read_pages().
> 
> Hum, checking the history the update of ra->size has been added by Neil two
> years ago in 9fd472af84ab ("mm: improve cleanup when ->readpages doesn't
> process all pages"). Neil, the changelog seems as there was some real
> motivation behind updating of ra->size in read_pages(). What was it? Now I
> somewhat disagree with reducing ra->size in read_pages() because it seems
> like a wrong place to do that and if we do need something like that,
> readahead window sizing logic should rather be changed to take that into
> account? But it all depends on what was the real rationale behind reducing
> ra->size in read_pages()...
> 
> 								Honza
My (rather limited) understanding of the patch is that it was intended to read those pages
that didn't get read because the allocation of a bigger folio failed, while not redoing what
readpages already did; how it was actually going to accomplish that is still unclear to me,
but I even don't even quite understand the comment...

	/*
	 * If there were already pages in the page cache, then we may have
	 * left some gaps.  Let the regular readahead code take care of this
	 * situation.
	 */

the reason for an unchanged async_size is also beyond my understanding.

/Anders

