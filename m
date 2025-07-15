Return-Path: <linux-fsdevel+bounces-54933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0763B05721
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 11:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 609497B92DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 09:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095D22D63FD;
	Tue, 15 Jul 2025 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQh1ePD5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB892D4B75
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 09:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573182; cv=none; b=QPVVzd3we2u3yZeVpzJp+M6nWoibC85MrzdbGcZGwhDsM+u+6fFBfPA68gNvpIMtZ7tBKsHP+kjpVdHBhTQzn1cUQ8e1AMjcfCyqDifm0s+4B7ErBDNp5GUiCP2VZKM7jXYSbjMOG7hyqKfzbpLUttLLXB0tdoRXCvThsq1Ljs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573182; c=relaxed/simple;
	bh=+KJr0OyWVP8B+NDdFmOx+5xmXQLpkB4zdx4Drud4lIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WiH3zSfc7ELlotSpX+A+rVIQKqr4kjYKL/6QaY56yCdexE2dqxomUXRv8qJ1NaLwbFc5gylWwZAm62laFsz2GnQM6F9HgTZNz/wImN5TV+YvzNkRPC1qMVLtUIKsqjs3kF43LdOURM9JpDbloeQwAI7aiM27awXPR+k8hu3+smE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQh1ePD5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752573179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SuWFbwcKFwkO4YE39Jv4l+w+Ru3JZyDbp4UzjIFZ0bE=;
	b=eQh1ePD5hPLJCcTkW5iR43dHsvDKgpcNuMqpSAeiDfoVQtDPfgEfG5+HTIRL/B5M6QMwdT
	qbWSHiUObU1eESiqmPvmZ/3P3ME3kns8lz03MNxuVidmreuLOqM9XBS+wMtKLQ1/S/La9S
	4yvHbh5HJ2DCX3BPwJwKW+wm9u72+FY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-8e8ghvqFNzqEMxUESHS2_g-1; Tue, 15 Jul 2025 05:52:57 -0400
X-MC-Unique: 8e8ghvqFNzqEMxUESHS2_g-1
X-Mimecast-MFC-AGG-ID: 8e8ghvqFNzqEMxUESHS2_g_1752573177
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f858bc5eso4008258f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 02:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573176; x=1753177976;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SuWFbwcKFwkO4YE39Jv4l+w+Ru3JZyDbp4UzjIFZ0bE=;
        b=LK53SfpwY0awMPFViJ1HBHSpdEvPE6FlR5kgl9ySEU4PSengO47d9I2Yb01HaiepKX
         NytCPqSnS6ymzLsYrYL29vS2x8pwCBuM24tLtlKaCqgRYNbogIcf5chhs0AkHSA+d4HN
         ov/95uadLyhwbWBcuOfp+sLGnrIxy+kxpJP+DfcdNulswPAHk8oKZG6Pm22v9WBKLKfz
         gPa0J2AAJMvfk3oFTXa10v43GySqzDGYcvq6+eKCmfBibMN9eEbSOn0algp2/wm4+Y0m
         O3eio3tmXAtiq+hMBrFQv/T67ZBN5VcWbRYzc0AfDwNLH5pAUCMJDRFJnDvjfFV/9qHe
         md9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzsx2SrDQGQa+p55A39e6SU9yY0WJ1vF9o1FXhrPo1hwn8KosDE+HSufMlGtkf+JXpKlvxTJwF1PWX6Xcz@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb0BwqQvin7kFCKwiu9Vc9q5YasvT4+8bNt/Q0h5EnJCYdjWzr
	VUlCn6VQlM5RtFyfp4GUERquIqqr9a61wxqkdANIgJOkWKH3aUDBYeOmFBRttoq2I3qdTnESla2
	5CZYMGuCICVoDkuwF0td7jzZulMRiqxMF82ylYeMjESsswFDyCIbWdBKoVlxxQdg+Vgc=
X-Gm-Gg: ASbGncu922JMR7Ehzd8YDDuFzVUfdJZeiqWQaR5/0vYOMiPSnkB6eC5Fa8YVhAq7BMV
	1+G4Bmk06Pa0hGGuXe2A3fMmE58w+Pc+CbqicNsEgQPwQOBOJyfNaSnP4+97JGOsyr0QlSmyT4T
	xbfGQ3SMxl8Vhu57fL5pf28STvlGLA8uZakP17HFKcqE2EbXsZNNnqD3dABOFKJYMOdTKikKB9W
	JYUseyljNfGpuJ2fg4rk7BrvGzc8ebA3Wlv5xTdDzt1/h28kH/w2OnwhBQ2z3Lui1y5HqOBKTYz
	qqLf+ThkHqyyu88bVSNyYDjNl7epKtKmK73iT8SkmYUeaeRYA6FQgMdQHWOkvgblIWo7tGxfv0H
	YZSnvwLrbASpBP5cQ6l7X14ACMlNV17kMPrhiYpHaAQuI1pMlTAkEn6n6edxbp0J3Ls8=
X-Received: by 2002:a05:6000:2189:b0:3b6:2f9:42b1 with SMTP id ffacd0b85a97d-3b602f944aamr4069425f8f.13.1752573176506;
        Tue, 15 Jul 2025 02:52:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+P4YnnefvGaKOACywNWvVTxwP1BSs56yJ4dRdeHF7Q116DlCh8GXFKl0VPzCL7ntocy4BVg==
X-Received: by 2002:a05:6000:2189:b0:3b6:2f9:42b1 with SMTP id ffacd0b85a97d-3b602f944aamr4069396f8f.13.1752573176078;
        Tue, 15 Jul 2025 02:52:56 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d76fsm15000882f8f.64.2025.07.15.02.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 02:52:55 -0700 (PDT)
Message-ID: <0b8617c1-a150-426f-8fa6-9ab3b5bcfa1e@redhat.com>
Date: Tue, 15 Jul 2025 11:52:49 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under per-vma
 lock
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org,
 peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org,
 paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com,
 brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com,
 linux@weissschuh.net, willy@infradead.org, osalvador@suse.de,
 andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
 tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <CAJuCfpGegZkgmnGd_kAsR8Wh5SRv_gtDxKbfHdjpG491u5U5fA@mail.gmail.com>
 <f60a932f-71c0-448f-9434-547caa630b72@suse.cz>
 <CAJuCfpE2H9-kRz6xSC43Ja0dmW+drcJa29hwQwQ53HRsuqRnwg@mail.gmail.com>
 <3b3521f6-30c8-419e-9615-9228f539251e@suse.cz>
 <CAJuCfpEgwdbEXKoMyMFiTHJMV15_g77-7N-m6ykReHLjD9rFLQ@mail.gmail.com>
 <bulkje7nsdfikukca4g6lqnwda6ll7eu2pcdn5bdhkqeyl7auh@yzzc6xkqqllm>
 <CAJuCfpFKNm6CEcfkuy+0o-Qu8xXppCFbOcYVXUFLeg10ztMFPw@mail.gmail.com>
 <CAJuCfpG_dRLVDv1DWveJWS5cQS0ADEVAeBxJ=5MaPQFNEvQ1+g@mail.gmail.com>
 <CAJuCfpH0HzM97exh92mpkuimxaen2Qh+tj_tZ=QBHQfi-3ejLQ@mail.gmail.com>
 <5ec10376-6a5f-4a94-9880-e59f1b6d425f@suse.cz>
 <19d46c33-bd5e-41d1-88ad-3db071fa1bed@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <19d46c33-bd5e-41d1-88ad-3db071fa1bed@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.07.25 11:40, Lorenzo Stoakes wrote:
> On Tue, Jul 15, 2025 at 10:16:41AM +0200, Vlastimil Babka wrote:
>>> Andrew, could you please remove this patchset from mm-unstable for now
>>> until I fix the issue and re-post the new version?
>>
>> Andrew can you do that please? We keep getting new syzbot reports.
> 
> I also pinged up top :P just to be extra specially clear...
> 
>>
>>> The error I got after these fixes is:
>>
>> I suspect the root cause is the ioctls are not serialized against each other
>> (probably not even against read()) and yet we treat m->private as safe to
>> work on. Now we have various fields that are dangerous to race on - for
>> example locked_vma and iter races would explain a lot of this.
>>
>> I suspect as long as we used purely seq_file workflow, it did the right
>> thing for us wrt serialization, but the ioctl addition violates that. We
>> should rather recheck even the code before this series, if dangerous ioctl
>> vs read() races are possible. And the ioctl implementation should be
>> refactored to use an own per-ioctl-call private context, not the seq_file's
>> per-file-open context.
> 
> Entirely agree with this analysis. I had a look at most recent report, see:
> 
> https://lore.kernel.org/linux-mm/f13cda37-06a0-4281-87d1-042678a38a6b@lucifer.local/
> 
> AFAICT we either have to lock around the ioctl or find a new way of storing
> per-ioctl state.
> 
> We'd probably need to separate out the procmap query stuff to do that
> though. Probably.

When I skimmed that series the first time, I was wondering "why are we 
even caring about PROCMAP_QUERY that in the context of this patch series".

Maybe that helps :)

-- 
Cheers,

David / dhildenb


