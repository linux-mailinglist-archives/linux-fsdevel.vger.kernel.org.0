Return-Path: <linux-fsdevel+bounces-59952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2621B3F7F4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 10:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8506016FCA9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 08:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D902E8B65;
	Tue,  2 Sep 2025 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPNkV5Rq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3692E62A4
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800735; cv=none; b=pg0PhNgVVUHaL6QGiBh64MFehJp98cByZSR9XZUWWehlbU7YOzhgUSgJeiNYziYDmrdfWJCwqkhDH176mKA9r+GinvItCBgam6ZY7MXWBUCRETKLp3n50JbLl+BIRLMlbSEgytCPPIwuWhJX5D75X20k7fo3ghMiPU69fMwX/kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800735; c=relaxed/simple;
	bh=UdYo5EhZ3PMDCVcRYhDMGGjzEDk9Z7rvDGoYq+BHWe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LismCT6Ejz8GVlo4xqrNHzgDVAOHis+nknU3EBQrAM7SV+mW4S2pZse9mlphCb96R9AC13854bo3CktdjtU7cuXkqeg1+FHJtHuDsEnVfjLmbfBGNd2Rl29sIMrhliSnt7IUcUWrfjUPY59YDPTi65u6Dj4mxaM7D30Nkw17Xv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bPNkV5Rq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756800732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2zb5t8Q6aRCCvAvoxx2JGukWZxS6Bp6/fazEsZZ+kHs=;
	b=bPNkV5RqkaIirt/UgVMhbOYM+YFP+hqkk7FEVD4rS1CBWBdyhrjDFqc4V/hh/2aS+R1Om9
	WHNa1nxDUs2GyJg1bE0Am+018XoL3rFHXHBiy/ModG1xGvKO8W3Xucu/1kL91FJvmwZ35p
	Mdy5VnooQrx8KSBuX5KRiUD/bGmPviI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-aBa_O4tqPTic11wVznNovA-1; Tue, 02 Sep 2025 04:12:10 -0400
X-MC-Unique: aBa_O4tqPTic11wVznNovA-1
X-Mimecast-MFC-AGG-ID: aBa_O4tqPTic11wVznNovA_1756800729
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b467f5173so48387815e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Sep 2025 01:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756800729; x=1757405529;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2zb5t8Q6aRCCvAvoxx2JGukWZxS6Bp6/fazEsZZ+kHs=;
        b=TYnCo+36RTFA2rBZCQJhZv/TYRDWcfkzYrKsUYkzMaYyYOv8sYko71+4hgmt2keEV5
         fdq85h7lp0yFrry5Qts9Zn8dEW5Qhfd6mJZfn/33FbdbKnT0sfew6Fs6566Y6GYNy/Cx
         y+86gHPuMMSwW2RlKKvKH950OFDYK9a/93VxWuAsyilxB8w1htBqVwJbALafqXwNrNNj
         Cod+AisNmiX18H4sSdyI9i/oBYuRTyMUjR9L10t0Rd48qJx6CGKrwbDFrJRmxSQM6o4c
         rGY/QlbAC/RL6je4Sx9AZR4UnK4Lk7nQ7nvWQPg7fDSo72bQbhlIojF6aWyOnO0FvPNY
         abDg==
X-Forwarded-Encrypted: i=1; AJvYcCUu/qc03i66XONND2kjuMJtzf5jQwypojOEhDCRzsNSlHGMl8RJWFEUszF5Gg+0xyHywLfC51mzv76X2a8O@vger.kernel.org
X-Gm-Message-State: AOJu0YyYMJ01USg5EPLOYrqB6cDHC0MdYzC1Ibv1XvxbBKKeYq3+yars
	Ubpw+lxS3NKbS0tuo5WZU3OnJyfAngx6GfLKAhPI9Lo0aeqECdbtAX3speJoIe6nIBKZRNI+ul9
	FTsbqP02Co+4KaK5mTj3N3e7Bi2B4TLGttXOLXnWTG2l109/fFz14qUhZjbQBTwXlWgY=
X-Gm-Gg: ASbGncsZ3Txu+zF1IIAop4wbKfpycHgLI99PCRivVZON5zhhi8QYdKuP4QfrIRicgR0
	8/UEZ2aYVBvFdDL1ev3A3bijanI9238Ocw2unkMCorOPu1QsISND3CQk0Z3Xt6IF+Y8n0Y1anFi
	wa1WffbkyboRF08UP1BBB9PMPgZ1os4Z1AASHAaZNsJ3F1Hal30VOYi+uSNV4QB2ydzsrF8pQS6
	QxZgYloa16OOtlWugNTmUQEwndoJBbMfaSekNWZEwlJDd71E/N/JR3fnQdiv6nDQHWyUIfTB2BZ
	sjgZt7p97p6/R8J8gELrnlN//HqypshBtPVndGMRWqkoJxV5kjIISVdcTd1NltvLEECowt/NI9m
	ZQUZmcHEheDwhrTv5JfYI/LCxqzmt0zQFmCSUrdpGBh629LFFt9C57AsQ5OTTiIE672Y=
X-Received: by 2002:a05:600c:3507:b0:45b:8f5e:529a with SMTP id 5b1f17b1804b1-45b925314admr23500945e9.14.1756800728618;
        Tue, 02 Sep 2025 01:12:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMQKde6tuKuB2m2hPFengMNai3NoA7mhyO6qLDI4gze+ZpXVnDBYgp0JqNm1wzjYGnsylb7A==
X-Received: by 2002:a05:600c:3507:b0:45b:8f5e:529a with SMTP id 5b1f17b1804b1-45b925314admr23500275e9.14.1756800727994;
        Tue, 02 Sep 2025 01:12:07 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0d32a2sm290899325e9.9.2025.09.02.01.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 01:12:07 -0700 (PDT)
Message-ID: <d418e2ba-a3e7-48bf-9576-90fddde706f3@redhat.com>
Date: Tue, 2 Sep 2025 10:12:05 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/12] mm: establish const-correctness for pointer
 parameters
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com,
 willy@infradead.org, hughd@google.com, mhocko@suse.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com,
 linux@armlinux.org.uk, James.Bottomley@hansenpartnership.com, deller@gmx.de,
 agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 davem@davemloft.net, andreas@gaisler.com, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, x86@kernel.org, hpa@zytor.com, chris@zankel.net,
 jcmvbkbc@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, weixugc@google.com, baolin.wang@linux.alibaba.com,
 rientjes@google.com, shakeel.butt@linux.dev, thuth@redhat.com,
 broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com,
 mpe@ellerman.id.au, nysal@linux.ibm.com,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
 <76ec40af-d234-400a-af0f-faeb001c9182@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <76ec40af-d234-400a-af0f-faeb001c9182@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.09.25 08:19, Lorenzo Stoakes wrote:
> On Mon, Sep 01, 2025 at 10:50:09PM +0200, Max Kellermann wrote:
>> For improved const-correctness in the low-level memory-management
>> subsystem, which provides a basis for further const-ification further
>> up the call stack (e.g. filesystems).
> 
> Great, this succinctly expresses what you want!
> 
>>
>> This patch series splitted into smaller patches was initially posted
>> as a single large patch:
>>
>>   https://lore.kernel.org/lkml/20250827192233.447920-1-max.kellermann@ionos.com/
>>
>> I started this work when I tried to constify the Ceph filesystem code,
>> but found that to be impossible because many "mm" functions accept
>> non-const pointer, even though they modify nothing.
> 
> And as Vlasta said, this is great context.

Yes, that's valuable information, and the series is looking lovely now.

-- 
Cheers

David / dhildenb


