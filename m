Return-Path: <linux-fsdevel+bounces-22292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A93A4915B81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 03:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD72E1C21151
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 01:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F54B14005;
	Tue, 25 Jun 2024 01:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jj2JFXDF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0703C152
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 01:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719277851; cv=none; b=ADAl4N0nw1VNa1+pY+iMJDiDCAQdVgmqFaaglwQwt6xXV8J2PVPA8Znj4hPd4Hd8lWBHVcka1PEwAtBV4q0H/Hdzwey7N67SY9Uga4V0YKWnMvBQYEoDn/9C6/qnrZ5qxso/WB9PpC9lmDDMdq8CAKWWOn7eTdzaMw3CAaIyPzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719277851; c=relaxed/simple;
	bh=/fYbx5c87Kw+R0HL5HIFgxuTB0c3Hz6eMNBQFrAcOZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7sz0aJG88FZv/5OkW845iEwhpLWoUzjElCJq/jtNu5FjRJdXOa6hk9dWA4twRsG3aOH50RBlFbXX2pn46qd2lGUE/ruOmBeUqo46C297iy5ifJtTS5Ov+IFv1iGf3x2RP8m4R4LRR/Xad8e0lZFZ4nxUZr7SgoHLSYyebPP1cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jj2JFXDF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719277848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1y+mfhT1zOllffounRCp6OrS2eaKNKCgyHOP8s75z3E=;
	b=Jj2JFXDFWiyLuhlWF6oGYyvAGX6I9Mg+UDwlAT6h7APnKp6xDwo3k7VxdHgNiFZgNFNSIz
	zp8Kb4NjKcf/lbfKs94FeebV/qqrgsru3Zqcda3TwUmZYFUiiZ3DlMvRPTV6vjuzpUgqli
	xX3aFpWoZrNIqacET6sxA43atj28Xqo=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-XmU0I4fuM-6ye4q_fbq-jQ-1; Mon, 24 Jun 2024 21:10:46 -0400
X-MC-Unique: XmU0I4fuM-6ye4q_fbq-jQ-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-2547e18cb07so8339492fac.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 18:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719277846; x=1719882646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1y+mfhT1zOllffounRCp6OrS2eaKNKCgyHOP8s75z3E=;
        b=h4qSjqTH3hBOboztxv2jvodtvoanTCREH83FwcR8yP4inLAiSu6VI15lWSSKe7Lrd4
         wzs970elrssxrExQXAfVFIXAdqr6LfHpRtMidzKVNrmgZ7yenr10WO1/fMMt2Un6ZPe7
         cHF8pPbOOE2/+6EA/d46y4gd/zmgcut8SyapExyr1IxTtZ5SHJ20r3lxQ5N9uiFY0EDG
         uIRsDzjpQ/65NVtpx0Zig7OOk+D8/bUqqinun+web2Ya1vXZxUo3ewmw4n5RMtuA60f5
         sdOV4pzC3emzk5PxEVUIuExpRmNzdekOtEmeHkD5IzTF6xiUCfme0atZQl3stKB2oZrT
         Ct6w==
X-Forwarded-Encrypted: i=1; AJvYcCUoYcmdCBKLKcAe15lhy4WqHt+nn2vksdrVKLJDYvdVzbVpARsRLY4yBCPab7h4af/jeHH1ui/oalUKt5uLstysELm35yK4U8JkclPwtg==
X-Gm-Message-State: AOJu0YzkzOVMakNnTi2GRB6EM/Nx/rpbfuSZ28Q9ItsZNHWU6/bip3rO
	irCNZWlTjo4dQzUBmmJHsVNJlYU67Ge2ZcoM3tCfgIhuq3go9dOUs99LbknDtuIrg7DhEUAV5sc
	CDnhBqMREwSZ7sjfcTTM93uhMwqr2MtL2TI0JVu1GQ9Rlnk/9CoS9Y3sunH/AlX8=
X-Received: by 2002:a05:6870:b622:b0:251:46d:d32a with SMTP id 586e51a60fabf-25d016733b1mr6417136fac.8.1719277845829;
        Mon, 24 Jun 2024 18:10:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqiYmCXDL4VUWqb2tZ/iirellmnhtOelPOH+85HtiykbTPosUsDRSmNX8v5SNiPPCse1NLFA==
X-Received: by 2002:a05:6870:b622:b0:251:46d:d32a with SMTP id 586e51a60fabf-25d016733b1mr6417122fac.8.1719277845504;
        Mon, 24 Jun 2024 18:10:45 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716b479281esm6141262a12.38.2024.06.24.18.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 18:10:44 -0700 (PDT)
Message-ID: <f73a27ca-91d4-4b1c-a2e3-ef07e56bccf3@redhat.com>
Date: Tue, 25 Jun 2024 11:10:38 +1000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Endless calls to xas_split_alloc() due to corrupted xarray entry
To: David Hildenbrand <david@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Zhenyu Zhang <zhenyzha@redhat.com>,
 Linux XFS <linux-xfs@vger.kernel.org>,
 Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Shaoqin Huang <shahuang@redhat.com>, Chandan Babu R
 <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <CAJFLiB+J4mKGDOppp=1moMe2aNqeJhM9F2cD4KPTXoM6nzb5RA@mail.gmail.com>
 <ZRFbIJH47RkQuDid@debian.me> <ZRci1L6qneuZA4mo@casper.infradead.org>
 <91bceeda-7964-2509-a1f1-4a2be49ebc60@redhat.com>
 <6d3687fd-e11b-4d78-9944-536bb1d731de@redhat.com>
 <ZnLrq4vJnfSNZ0wg@casper.infradead.org>
 <CAHk-=who82OKiXyTiCG3rUaiicO_OB9prVvZQBzg6GDGhdp+Ew@mail.gmail.com>
 <75c1936b-bb08-423d-9a17-0da133cbee01@redhat.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <75c1936b-bb08-423d-9a17-0da133cbee01@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/20/24 5:58 AM, David Hildenbrand wrote:
> On 19.06.24 17:48, Linus Torvalds wrote:
>> On Wed, 19 Jun 2024 at 07:31, Matthew Wilcox <willy@infradead.org> wrote:
>>>
>>> Actually, it's 11.  We can't split an order-12 folio because we'd have
>>> to allocate two levels of radix tree, and I decided that was too much
>>> work.  Also, I didn't know that ARM used order-13 PMD size at the time.
>>>
>>> I think this is the best fix (modulo s/12/11/).
>>
>> Can we use some more descriptive thing than the magic constant 11 that
>> is clearly very subtle.
>>
>> Is it "XA_CHUNK_SHIFT * 2 - 1"
> 
> That's my best guess as well :)
> 
>>
>> IOW, something like
>>
>>     #define MAX_XAS_ORDER (XA_CHUNK_SHIFT * 2 - 1)
>>     #define MAX_PAGECACHE_ORDER min(HPAGE_PMD_ORDER,12)
>>
>> except for the non-TRANSPARENT_HUGEPAGE case where it currently does
>>
>>    #define MAX_PAGECACHE_ORDER    8
>>
>> and I assume that "8" is just "random round value, smaller than 11"?
> 
> Yes, that matches my understanding.
> 
> Maybe to be safe for !THP as well, something ike:
> 
> +++ b/include/linux/pagemap.h
> @@ -354,11 +354,18 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
>    * a good order (that's 1MB if you're using 4kB pages)
>    */
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -#define MAX_PAGECACHE_ORDER    HPAGE_PMD_ORDER
> +#define WANTED_MAX_PAGECACHE_ORDER    HPAGE_PMD_ORDER
>   #else
> -#define MAX_PAGECACHE_ORDER    8
> +#define WANTED_MAX_PAGECACHE_ORDER    8
>   #endif
> 
> +/*
> + * xas_split_alloc() does not support arbitrary orders yet. This implies no
> + * 512MB THP on arm64 with 64k.
> + */
> +#define MAX_XAS_ORDER        (XA_CHUNK_SHIFT * 2 - 1)
> +#define MAX_PAGECACHE_ORDER    min(MAX_XAS_ORDER, WANTED_MAX_PAGECACHE_ORDER)
> +
>   /**
>    * mapping_set_large_folios() - Indicate the file supports large folios.
>    * @mapping: The file.

Thanks David. I'm checking if shmem needs the similar limitation and test patches.
I will post them for review once they're ready.

Thanks,
Gavin


