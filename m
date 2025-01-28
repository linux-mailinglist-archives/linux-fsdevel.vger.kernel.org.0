Return-Path: <linux-fsdevel+bounces-40247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B3EA211CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 19:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C4616520F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 18:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4EC1DE4FA;
	Tue, 28 Jan 2025 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWsf6Jzk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B19EBA27
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738090041; cv=none; b=M4nkcQQ5V0DhZ68RdSryBTijE6PeYU8sZG/npignlQCvYTQztnjJt5n+QvglUJm3CGSZ8BJuvIEOI93I/n3Q+teIEdpvRW+lAPylny8GD+1GovN8wvboCldTENARk8gW+V8nHo+gfkWB/9cX6RvoyuD7UPar8NNd631WL4+2VMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738090041; c=relaxed/simple;
	bh=1wpVCsyT0rUEiGrOZLdFXP8eLZ7yUSClF3XNaP+Fsl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dkPd3kLKOUuguVb9oEAxWqpH71j1wLMQ7ob3k7pkUuTe86cLTnUag7D4I1SQc+QqOwWrsL1h2Mfsd8u7AARwtDnRS2zeWQObxZCVH7xNTgMUuFoZfW70haJu9SaQzk2I65BzQh8vobnkFL76hcxmUpyeHbzB6d0JGQeJfLaZ9Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eWsf6Jzk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738090038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=veEAr0Ue51KkYPBQCs0ozQsAuYgt34IoScVF9xmztQ0=;
	b=eWsf6JzkFFSAhrro5ot20ZH2QwylSOC4msz6Zd/n2r9Ayfi8d2sheM27zZxb+PdYbg6AsR
	BxUPvnD5JeUmeE/saGd8J5kZBkCvRtJTbpfLqRXszG4Cye2XV4UUx7THXsB2y35mp4azGx
	IIwLIKUUOmNI602ekeUN0mB8JDYDNcg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-e1Z9M15PNC-T5IJTl1o6rg-1; Tue, 28 Jan 2025 13:47:16 -0500
X-MC-Unique: e1Z9M15PNC-T5IJTl1o6rg-1
X-Mimecast-MFC-AGG-ID: e1Z9M15PNC-T5IJTl1o6rg
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3862be3bfc9so3381616f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 10:47:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738090036; x=1738694836;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=veEAr0Ue51KkYPBQCs0ozQsAuYgt34IoScVF9xmztQ0=;
        b=g9V9LIFU+DJY+BOdWaWePwwzcItwiJYEHeH01OaXwXAd7BK7Rlet48BRw5SdkPZt5J
         bkV0+DQUltvjcI2La7cQ915i+ZcADntFY9s5bichBVb7y2jHaNtXZ54bdKbhZ8zNZMLP
         67lyWGwkx9t8hP5KEeOApwSA55d82PCV9f3DTHhFZUXoZ52iJaIeaBSoLKOzf4b4XbFz
         Vs+dtedCOU0cEBRq33eWe7hBrDolKu1jF0iW44wr47+Qi69HVbZD46Pr/TOgh3xLD/o9
         NJMR39ORymXoV6uerkUw2hksNNpjpANkDqtPHzpb3DuJALB+C5Dt21f+ZlXEGoaOiYy2
         t7Pw==
X-Forwarded-Encrypted: i=1; AJvYcCX7XjiPXgObdU3Yp3p1hJQstpEBJnbveoK9+DV7UCwoMUX0Wy1kR4ig4vZ7oz0RiwbQfhsafne4HUhO/BiE@vger.kernel.org
X-Gm-Message-State: AOJu0YzwIBk+AuTP02PBNGUzLQhfU4Nmdclhx1DL+OiRdc5pC5Wc4Vdn
	ILNU4dl5M9HHBN2RgU6IxCWz13PMhRhHPKp0sCIJ2I1lrrfzhUW3Kjg7tp2QIj36NKlEQ+O0Txw
	qFo/s1DWODBIkR6UR8Fqa+Qk9hoEKwd/SkllwvLaW8RP2bWwjpjibrRQiYcUz34k=
X-Gm-Gg: ASbGncs19G7QHGXUTESuhdBDLT463ANRi+yyuDYPZeibf+bLD+ZTZrXlDvXzRrOd1hy
	hOzdRNjkIFhW2Tngabm9aIDBD7HDtsiBOy8cmEt1VQ6G9ZfDxJcQ3QfPUC5a+NCsylmwckq/qY9
	JmOjDjcvCo6iseFgLKH2m1BR5RtnzzQDflBiM5T//TcXN6Vxhxf+wF3WPKB+NA1tRfZ6qiKx9od
	sdGxkvnfiZsAz1Z5dL1ie7q6O6IZqxUEix8krQE26ZWs+AjcsCqUjmpIvht4nPakCgFFUpZ4RXc
	gBVsMq4PVlnmYulH8XVl6xtYq6ea/st7Vg==
X-Received: by 2002:a05:6000:bd0:b0:385:f64e:f163 with SMTP id ffacd0b85a97d-38c51967e87mr100423f8f.32.1738090035752;
        Tue, 28 Jan 2025 10:47:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWQejFOYglVuJX3Mchmr/RYpG4gy2wVkio0EH2BLNsNtOlrKsn8rM3O/iDZxFLihJHk4cE/A==
X-Received: by 2002:a05:6000:bd0:b0:385:f64e:f163 with SMTP id ffacd0b85a97d-38c51967e87mr100408f8f.32.1738090035426;
        Tue, 28 Jan 2025 10:47:15 -0800 (PST)
Received: from [192.168.3.141] (p5b0c6662.dip0.t-ipconnect.de. [91.12.102.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1764d3sm15076555f8f.19.2025.01.28.10.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 10:47:14 -0800 (PST)
Message-ID: <5a038a23-1523-4b3b-b1f0-73ed05b9fc07@redhat.com>
Date: Tue, 28 Jan 2025 19:47:12 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Removing writeback temp pages in FUSE
To: Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org, Shakeel Butt <shakeel.butt@linux.dev>,
 Bernd Schubert <bernd.schubert@fastmail.fm>, Zi Yan <ziy@nvidia.com>,
 Jingbo Xu <jefflexu@linux.alibaba.com>, Jeff Layton <jlayton@kernel.org>,
 linux-fsdevel@vger.kernel.org, kernel-team@meta.com
References: <CAJnrk1ZCgff6ZWmqKzBXFq5uAEbms46OexA1axWS5v-PCZFqJg@mail.gmail.com>
 <CAJfpegsDkQL3-zP9dhMEYGmaQQ7STBgpLtkB3S=V2=PqDe9k-w@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJfpegsDkQL3-zP9dhMEYGmaQQ7STBgpLtkB3S=V2=PqDe9k-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28.01.25 12:10, Miklos Szeredi wrote:
> On Mon, 27 Jan 2025 at 22:44, Joanne Koong <joannelkoong@gmail.com> wrote:
>>
>> Hi all,

Hi,

>>
>> Recently, there was a long discussion upstream [1] on a patchset that
>> removes temp pages when handling writeback in FUSE. Temp pages are the
>> main bottleneck for write performance in FUSE and local benchmarks
>> showed approximately a 20% and 45% improvement in throughput for 4K
>> and 1M block size writes respectively when temp pages were removed.
>> More information on how FUSE uses temp pages can be found here [2].

I'm obviously interested in this discussion :) Hoping I'll be able to 
attend in person this year again (I assume so).

>>
>> In the discussion, there were concerns from mm regarding the
>> possibility of untrusted malicious or buggy fuse servers never
>> completing writeback, which would impede migration for those pages.
>>
>> It would be great to continue this discussion at LSF/MM and align on a
>> solution that removes FUSE temp pages altogether while satisfying mm’s
>> expectations for page migration. These are the most promising options
>> so far:
> 
> This is more than just temp pages.  The same issue exists for
> ->readahead().  This needs to be approached from both directions.

Agreed.

-- 
Cheers,

David / dhildenb


