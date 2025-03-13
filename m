Return-Path: <linux-fsdevel+bounces-43871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF2BA5EDCB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 09:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F38D189E9CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 08:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECE5260A3B;
	Thu, 13 Mar 2025 08:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvySNITN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217D71EE013
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 08:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741853869; cv=none; b=s//ctEgLy4EwSTN4Ue7VP6dLUSuxQm/yH17VRRN2Vpw/3JP1hHuZwrOHAVIi042wI9aXifSjoApMmw4NGZjkDRqqJnZopToQhjQVr2PIxasDLFSO69quvXRHdpa50VTomieGiNp1O9XfZWbEtrdCFgiu3pHXoLN7CKnqT5U8IWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741853869; c=relaxed/simple;
	bh=2qNu549WgRn5XbZYxwYWcknxNUylrpzLm/IXqAuuqX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VE5kWPP2ain1ZZyr+58A/ZJnow8I1MnUBYSXlxcmJynOLqytfFxXTDP6fw1IrppaR952GFlbokbXRCwpci8xQQT1IOwj6gzpr0iGs184BUxNuTUAkmasnrLvKTlBu43n4q52YaPWt3aEmcxBKPl05TZk6gdXSwQu5BKV2pSubKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OvySNITN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741853866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d25kVXr7HGSUNn9iASDWypye6xCMoC8F2pO7KRGBFvQ=;
	b=OvySNITN7N4k/bRTNuHnOUxWF83sU5eNbwhUjvjtOuJ8DHs3RNW6fjfzCSE9d0PYtEgfL7
	pP9GOWlzDftOUiUTECHIIF78k05Qo9gRQg5bv6O/nL92wDBt0RVD5I9evCWl8ViNRmrMIs
	ZZOw+NbKOWUIjb0dr7zrDaIQNpUYmxE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-Uy5Vz4PbMGytw10ELX4kvA-1; Thu, 13 Mar 2025 04:17:44 -0400
X-MC-Unique: Uy5Vz4PbMGytw10ELX4kvA-1
X-Mimecast-MFC-AGG-ID: Uy5Vz4PbMGytw10ELX4kvA_1741853863
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43bd8fd03a2so2998815e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 01:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741853863; x=1742458663;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d25kVXr7HGSUNn9iASDWypye6xCMoC8F2pO7KRGBFvQ=;
        b=aTojL/cBDIDpjGQdntG/7+feBfBG8fTjgLr/Atp88TTxpUU+yOrEC6QvqU8WsoDE2M
         H7j6X26HFJWKVWZb3VAGSW2Wzbh5TOUSUIYntwQSl9Dyz+VHirwG8FDEePNjx+Mf9pFr
         f0rYEp0Z8/IUMLYusgyyUOEzPp8b2hURaOWCOkJxCPFmkMTY+hsTA5xCajiYY0ExgPql
         j7lb2oXspjR7mtHMfLrSmq2/oyr6ZXIyvjz45t2omOPPX4EJBEwzAwlb1EWKWZEZv7Iq
         EcL6I6/+Q9W6LuPTLcobGaN8q6BO+9wTYIZWkv7yckjLgcpp2nnvz5bg8l5RFlz2Y+UU
         Uprg==
X-Forwarded-Encrypted: i=1; AJvYcCWaPimN8LiNt6t671IjCndTxPf8U5HZChh06f7qowazkDCM7ryFl0JS01dIKzLIVoLNIqJIffswRf02EBWk@vger.kernel.org
X-Gm-Message-State: AOJu0YxcY04kcieMdu9sYkzm5XeQpR/9oJjzHmuN81PC+xGAPFjn9PqB
	LHh3gqF5jrTtzUiBlg6A+JeqORvZIljZrAGPRtwoD7OarXpchefExlhPrejt+sqM69ptHyRp1ed
	4afE7Ybd2DHIEFwWHQTg1BycRGIoDMV/RfZqO9M5X223MXvNzsjCKYHNQsyIb6JY=
X-Gm-Gg: ASbGnctO7+P+Xfkzq17u9pmERvfHZeAIJ+In6xhlvddnNDGy3P3Z5j9P31VCBTVj+Dn
	HYiKwvdWxv/dLN/abI1o1JxqALlWog+2lvH7eMRrpr5wqWd3lG3tLkmjfdb9ZwdjSZNsixt0Jo5
	adYsZpfuc0+wRG+AEupSxKiDwHJ9ba1JPNND9im7c7k0ZrkPaxJE3ghvpWv543BBRXbrR9epeys
	dcwxPh+01JCuOq2bVvZwXShzNGeEIZjYQOzmS647uwQ16+QsB7VO/6ywou9EGTLnc8V6NDkCua/
	g8UlHbORwmvnAI5G5fWUgGfxAlclIHUvVYIeVXkOIF36BmUz9bn/WZOi/YSUDgA85IjlRYIL+qi
	Qjuuhn6SLccqzzwVhjOBhLmuPVLRuVfX9j3AizWl83rk=
X-Received: by 2002:a05:600c:3510:b0:43b:d1ad:9241 with SMTP id 5b1f17b1804b1-43c601d889dmr168277265e9.9.1741853863210;
        Thu, 13 Mar 2025 01:17:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8xDZePqcXZCtF9AAtTy2leCGXfaU4pDNiDVVh8H66qiKRFFrlJmyfFywifFDAuFvXFuDtZA==
X-Received: by 2002:a05:600c:3510:b0:43b:d1ad:9241 with SMTP id 5b1f17b1804b1-43c601d889dmr168277105e9.9.1741853862785;
        Thu, 13 Mar 2025 01:17:42 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1a:7c00:4ac1:c2c4:4167:8a0f? (p200300d82f1a7c004ac1c2c441678a0f.dip0.t-ipconnect.de. [2003:d8:2f1a:7c00:4ac1:c2c4:4167:8a0f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a8d1666sm45451055e9.40.2025.03.13.01.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 01:17:42 -0700 (PDT)
Message-ID: <4e1b5d05-f210-4aaf-a7d2-80458b9f20f9@redhat.com>
Date: Thu, 13 Mar 2025 09:17:40 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/5] meminfo: add a per node counter for balloon drivers
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Nico Pache <npache@redhat.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, cgroups@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 jerrin.shaji-george@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 arnd@arndb.de, gregkh@linuxfoundation.org, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgross@suse.com,
 sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
 akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 nphamcs@gmail.com, yosry.ahmed@linux.dev, kanchana.p.sridhar@intel.com,
 alexander.atanasov@virtuozzo.com
References: <20250312000700.184573-1-npache@redhat.com>
 <20250312000700.184573-2-npache@redhat.com>
 <c4229ea5-d991-4f5e-a0ff-45dce78a242a@redhat.com>
 <20250313032001-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250313032001-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.03.25 08:20, Michael S. Tsirkin wrote:
> On Wed, Mar 12, 2025 at 11:19:06PM +0100, David Hildenbrand wrote:
>> On 12.03.25 01:06, Nico Pache wrote:
>>> Add NR_BALLOON_PAGES counter to track memory used by balloon drivers and
>>> expose it through /proc/meminfo and other memory reporting interfaces.
>>
>> In balloon_page_enqueue_one(), we perform a
>>
>> __count_vm_event(BALLOON_INFLATE)
>>
>> and in balloon_page_list_dequeue
>>
>> __count_vm_event(BALLOON_DEFLATE);
>>
>>
>> Should we maybe simply do the per-node accounting similarly there?
> 
> 
> BTW should virtio mem be tied into this too, in some way? or is it too
> different?

No, we should limit it to actual balloon drivers that e.g., never 
completely remove memory.

-- 
Cheers,

David / dhildenb


