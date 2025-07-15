Return-Path: <linux-fsdevel+bounces-54977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C88B0611D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 16:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAFABB40797
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 14:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288381F30CC;
	Tue, 15 Jul 2025 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WxlDdm0C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5923597E
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588932; cv=none; b=mOruoULTH6dY2vNRElljuRr7tDQbJjB7iQPImYr08SNe2vbm4L/T0DEVWRKiRMyB0EailKIM8fgAfyUtUkRnXk54qlKPYc0piJ2veyiltAD80aZ/QvrbxA75UvVhNWzEGeND/7VMVYbkNmf7/B6vaN1fmMm2yG70eZEI4la//Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588932; c=relaxed/simple;
	bh=cYRvBfFBk+zWv7ODYqVflfYipFPbgCULQ+V/P58YDwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tEc9eiUqiIjZIqZQSUttI0aoYyf8akmzNpb+XIOJxfORgbjmWSRW8BHuxB+T99lhc3RKk+Sb//ur0RpAVlFaLs/IFBEAWoxwnjIJ6SLRTMwGVkDi4ptMf+HamRbGm99X67fQkZhgmEZ6etF2UAj/PPvyST/JZqorMDdVAJIU4Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WxlDdm0C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752588927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uHaC3NM9+QwIy3pXqxbGtfDGOu55CkwVkRhyKfVul1g=;
	b=WxlDdm0Ch8oENw8JyxjPImKQo0WzSpXR+O+g60o3ZrmWqJmXvdrr2t74nM0pGiV73D3N5E
	AmuDtyurQaPK1Lci+w3Hfsm2RzgaaZcqixMBpGPCTR6D9Pt4bQPSzBYnmTEQTfLZAvZXbm
	nlD+VKjF7STWTYz2KiHpPblEXNmqnW8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-P1nirAMeOIifut9Qy8T6VQ-1; Tue, 15 Jul 2025 10:15:13 -0400
X-MC-Unique: P1nirAMeOIifut9Qy8T6VQ-1
X-Mimecast-MFC-AGG-ID: P1nirAMeOIifut9Qy8T6VQ_1752588912
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f858bc5eso4229397f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 07:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752588912; x=1753193712;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uHaC3NM9+QwIy3pXqxbGtfDGOu55CkwVkRhyKfVul1g=;
        b=vg3Up4fpa0iJfPR9bYL98AKEmIVKEeXi6l0xlvWjMXRbYw9SqatBseWurynK7hk/je
         VTzZHbre+YhcrPER0fkmv+HCxh8H2xLSxYBGf1GDtGftIjwIDunJRqiTFVqRqq6nz1D4
         ViCgvsHpekmGdkPu5IlXjUvOPCJetVFpEg0UpQxfH7RM4nM2/FQCEwSTNbX5/gWplmWy
         WZpKlLSxhTtfZi0yS95K/kBPZ/rCctnT39lRJCI8S+ALlqdXFGVZHj9sruDMTN3pjz5n
         LNhK7XhMHG495tli9bTDo5+E831nV7sTGF3Ex1Vy+sc6uS7DYc2CFsCKNhVBr5+uNMen
         iPIA==
X-Forwarded-Encrypted: i=1; AJvYcCUYKPPnixkfMjTJ7zI8dJHGmnTpMa1nLWb0rmqUoOQl3NKCAcH8pTEm/cuMHbVBV99iRfWV0htFezkLfJi9@vger.kernel.org
X-Gm-Message-State: AOJu0Yys6X/3ftn5EBkDcoqP4/Gq9/yHI/iIXRYkPVK1wB+1ST3LrHia
	drgPoxXCtgaRDtpFYOECpMHUnMXS5hQLJ8A/3tnl4vUoHCxxS0i+9DO0xUbLTWSfZfS5Iq1k4mS
	n+/Z6+5IDvD1qDftgWhC8pVmqKl7tbUBAJuR6pw+wUZlGYhrI5hhZJZrgzjaAIMQi+Bk=
X-Gm-Gg: ASbGncuU7GtZEMG9BVTms+c2SlgsBQR5GYrD6TH8kxFFPGMQRAGqkbX8Tq0wL0DI5ib
	zeCqI8PWNAtt/dKva+02WqoD7tInYbLbzw/HsttLqangJhCmif2EKQbnlMuI0J2GhXCmNpO9zj7
	NM+KTIkPhmmVFXrOW2nDnUaCzkmiiRbDq68SOJjM49l+PIH+yUbGOy49kd1wAb09mxdCcj2PLBB
	2f4WHmrq9znGV7T5U5aot+X8XUGDA8UgtiwkZTYYuoL+1fR3T50JtyvhWGPOmBhhrfLtj1QEUj1
	+X9wVFvvG2N5gxBUmYs7kcn+DPOsQymmXAD6m0gGK75tTUkXJboCcxl0G76bWMetqQzKNTnq14d
	B459iaWOXfJkoGSjnirBSq3+dre3qZKkL/crtZHAZkI+MXWTcieX2sxFym/vARIZbw2s=
X-Received: by 2002:a5d:5d0c:0:b0:3a4:e629:6504 with SMTP id ffacd0b85a97d-3b5f2e448d9mr10913828f8f.49.1752588912200;
        Tue, 15 Jul 2025 07:15:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpyohQnpn/KxIdJ2KMc18WnTagGh3ivybzKaAC/ozw+/YD8D8CtWgwEjyEVReYxDXso7vSlw==
X-Received: by 2002:a5d:5d0c:0:b0:3a4:e629:6504 with SMTP id ffacd0b85a97d-3b5f2e448d9mr10913779f8f.49.1752588911647;
        Tue, 15 Jul 2025 07:15:11 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1833sm14841701f8f.8.2025.07.15.07.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 07:15:11 -0700 (PDT)
Message-ID: <9c9b78fd-4698-4982-919c-34e679bbac84@redhat.com>
Date: Tue, 15 Jul 2025 16:15:09 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] add static PMD zero page support
To: Andrew Morton <akpm@linux-foundation.org>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Thomas Gleixner <tglx@linutronix.de>,
 Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>,
 linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 x86@kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <20250707153844.d868f7cfe16830cce66f3929@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <20250707153844.d868f7cfe16830cce66f3929@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.07.25 00:38, Andrew Morton wrote:
> On Mon,  7 Jul 2025 16:23:14 +0200 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com> wrote:
> 
>> There are many places in the kernel where we need to zeroout larger
>> chunks but the maximum segment we can zeroout at a time by ZERO_PAGE
>> is limited by PAGE_SIZE.
>>
>> This concern was raised during the review of adding Large Block Size support
>> to XFS[1][2].
>>
>> This is especially annoying in block devices and filesystems where we
>> attach multiple ZERO_PAGEs to the bio in different bvecs. With multipage
>> bvec support in block layer, it is much more efficient to send out
>> larger zero pages as a part of a single bvec.
>>
>> Some examples of places in the kernel where this could be useful:
>> - blkdev_issue_zero_pages()
>> - iomap_dio_zero()
>> - vmalloc.c:zero_iter()
>> - rxperf_process_call()
>> - fscrypt_zeroout_range_inline_crypt()
>> - bch2_checksum_update()
>> ...
>>
>> We already have huge_zero_folio that is allocated on demand, and it will be
>> deallocated by the shrinker if there are no users of it left.
>>
>> At moment, huge_zero_folio infrastructure refcount is tied to the process
>> lifetime that created it. This might not work for bio layer as the completions
>> can be async and the process that created the huge_zero_folio might no
>> longer be alive.
> 
> Can we change that?  Alter the refcounting model so that dropping the
> final reference at interrupt time works as expected?

I would hope that we can drop that whole shrinking+freeing mechanism at 
some point, and simply always keep it around once allocated.

Any unprivileged process can keep the huge zero folio mapped and, 
therefore, around, until that process is killed ...

But I assume some people might still have an opinion on the shrinker, so 
for the time being having a second static model might be less controversial.

(I don't think we should be refcounting the huge zerofolio in the long term)

-- 
Cheers,

David / dhildenb


