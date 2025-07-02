Return-Path: <linux-fsdevel+bounces-53667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9DEAF5B72
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 16:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB5B1C42F01
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 14:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D91C3093BE;
	Wed,  2 Jul 2025 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+g3meNU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11419307AE8
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751467450; cv=none; b=maI99Fxpu3NfwOQyqSmsusfj36rEgvwMvK+t7kaDAzXI0AB6bSo8jf03qRX/4bLi/qmiTVKEtx+SXJWuEv6/GmvtZgNwf8hRetsXKLfp3tRHBoa1OYs1KHSn4NymGdhkqqoegCzeI8Q5zOWIDOtulzrztlADOcCS5BLbZ9DlBE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751467450; c=relaxed/simple;
	bh=6Wb49X0BJHbqwWrkROi+YR+7r3jK71+OW26GsASEmwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZ8yS2rqYJpDtHzrIylMUO6rOEIrxL7jnrNHFH0t0uCYimTuhMhPnVvbYlxGch74JdtMiQEFvL2XMkgtL/n7HUCQi5P1mU9XGe35E9nJG5/M0fiWCDT7Tvi0+OHi9k20kkXBWdDhrccfvndHhhHHzhfnh9uJcBg7PshGcGvaeDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G+g3meNU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751467448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v5kZ8LByR5tDk+2RARWaEVx7RJMhvOELDCL82WVT4Mo=;
	b=G+g3meNUA5vhD0acKdIe5dNInSfREG03Td0jbUFe3aMVsmuOfMlsOEXcy5Aw2wOpq5lsKZ
	OgarRzaOHzkhgck7REMnxHnnSoP8J4pAYMnEIIvBGlZptwBuxqVc4C7ge8J5sWOcGsUFX5
	jRHfWOHt+64PeDVZP9MsAx9UQuxgRoY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-AgyFkrFUNYiz9Bd_7CkikA-1; Wed, 02 Jul 2025 10:44:05 -0400
X-MC-Unique: AgyFkrFUNYiz9Bd_7CkikA-1
X-Mimecast-MFC-AGG-ID: AgyFkrFUNYiz9Bd_7CkikA_1751467444
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a6d90929d6so1804801f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 07:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751467444; x=1752072244;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v5kZ8LByR5tDk+2RARWaEVx7RJMhvOELDCL82WVT4Mo=;
        b=oNfoSD/dt+LUvScjqSUUgfAvvppWtqldc5ltGgsz5l1VPkgkqyQfc0VokNqUDoHXY5
         33Pmqhs4shIqz2UHfwRWf4ZRTgAXeHwLJF6709C9SHhOtCEE10qyEpvKC1oUA2im9jzn
         8EX8x8qZ4qzPIFyw2Er2Yqpv4TqNCAY7oZfXLGnNBT6IkzDOqGk/yVSxjQnn5zAYCeIQ
         lyHK5ZJcDI5cpBc0xIbpfKyM4Z9CN+SpTK0lg03vlIsfhnaDNexBn2aksdXwLlQsBm38
         Q4ftECpibZxfuucDwDmZfDeTyjTrWHXL4U6KKSpbD0rc8HG0RHd2QWa7bPUoW9uepadq
         yTnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHa//Q5nAQQt+gKdS7I50YJRMELHoqIkZXkB5bC9hHRrIDIAV6ICscNeGtX2BBXKzbCFC+50/M71IRlndh@vger.kernel.org
X-Gm-Message-State: AOJu0YzKL9ADLPiariZcO/qdhP4LkkWXn+ajILC1F6bnCRNuR+5WCmf8
	yB6Xo20s4RA8JT6hy39cqimtVMXeRrZoEPIjovptlSiMuh6uVXpj1O5DMYq82/I43UI7K6jIHnG
	mRZX9FNM+ze1kaeQ83Y0xrliIIA2pt9IUt8szZ1LsY0M09WLdxW1wwDHO4WuzmTJB5I4=
X-Gm-Gg: ASbGncvFh0myf+NZJUrFo1BQLNMogDvEcAeIob9lpVS2rsM5suxsdvl+HiI4Nly5HcO
	6uDhIcfDluYE1jTnZUbCjmKdY7x41J0QHWRaNyMAEGqSAcLvzn8c5EC/psvabZID6X2CTWKkZkF
	T7DzCK5zMkmyV2bAn2DyUAyKvs53tMH0ex/W2WagFUyKcnyoKPVLiabPFlb0UX4SIS3B2zY335h
	9qgtWR+eMj9idGu1JsX/7OUtYPc0k1/PGKfm9gSEofHSyRkxHxlUV3N8f/MNc8f+HgUjyHjGE2W
	LXgRNpC8FK/SkkJx4wjNRj5ZigWbJ4E4/aDzv+nALqyVUUDYawbPuXc=
X-Received: by 2002:adf:9b84:0:b0:3a4:f744:e00c with SMTP id ffacd0b85a97d-3b20095ce61mr1968567f8f.29.1751467443771;
        Wed, 02 Jul 2025 07:44:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp7NbPcO7rJZWXvSnrni21vm6TsH+e1Wf8nuopye15pGumcNSxUt3JtyGqe+Gm1zDhsN9hOA==
X-Received: by 2002:adf:9b84:0:b0:3a4:f744:e00c with SMTP id ffacd0b85a97d-3b20095ce61mr1968544f8f.29.1751467443279;
        Wed, 02 Jul 2025 07:44:03 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e52a26sm16417581f8f.51.2025.07.02.07.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 07:44:02 -0700 (PDT)
Message-ID: <693725d9-a293-414f-a706-f77446e335b1@redhat.com>
Date: Wed, 2 Jul 2025 16:44:01 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] mm/maps: move kmalloc() call location in
 do_procmap_query() out of RCU critical section
To: Jeongjun Park <aha310510@gmail.com>, akpm@linux-foundation.org
Cc: andrii@kernel.org, osalvador@suse.de, Liam.Howlett@Oracle.com,
 surenb@google.com, christophe.leroy@csgroup.eu,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 syzbot+6246a83e7bd9f8a3e239@syzkaller.appspotmail.com
References: <20250702135332.291866-1-aha310510@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250702135332.291866-1-aha310510@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.07.25 15:53, Jeongjun Park wrote:
> In do_procmap_query(), we are allocating name_buf as much as name_buf_sz
> with kmalloc().
> 
> However, due to the previous commit eff061546ca5
> ("mm/maps: execute PROCMAP_QUERY ioctl under per-vma locks"),
> the location of kmalloc() is located inside the RCU critical section.
> 
> This causes might_sleep_if() to be called inside the RCU critical section,
> so we need to move the call location of kmalloc() outside the RCU critical
> section to prevent this.
> 
> Reported-by: syzbot+6246a83e7bd9f8a3e239@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=6246a83e7bd9f8a3e239
> Fixes: eff061546ca5 ("mm/maps: execute PROCMAP_QUERY ioctl under per-vma locks")

That commit is not upstream yet (and the commit id is not stable), so it 
should be squashed into the problematic commit.

As a side note: the patch subject of this and the original patch should 
start with "fs/proc/task_mmu", not "mm/maps".

-- 
Cheers,

David / dhildenb


