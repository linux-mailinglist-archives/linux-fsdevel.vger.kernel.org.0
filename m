Return-Path: <linux-fsdevel+bounces-22587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 422F5919CDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 03:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7BAC1F2292E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 01:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98866AC0;
	Thu, 27 Jun 2024 01:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pa1dzUNT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF41217E9
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 01:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719450689; cv=none; b=gYfp77GnuzDFQcjYTHziYbK9R7rnniUVwYyDJKuCBO1tU9wures3/dgL+/LVhQboWvMJJJkyOYiGrRg0TEPSJIjeKRqCASEcuqH4yveWkB2U23qsXkcKvLEciu2xIRWfoivnDNBYKZ8P88dmEeva5u8zxJk9y3lJm55yDbSpnEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719450689; c=relaxed/simple;
	bh=TWgMN2QdfZLcalze0F45oSpAF2Wc3qw+jw6jRJEt2qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4Wu/y2rM0xwBycxm40g9F4rHG11ZczIZPOdBW1INcRRYW7blKzM9fJRdE/9t10dWg3b1tI+NBqnvbJ/avkvPCmB0W5pldo1gc/fTJfPGnld65UahTgqAXTb53xl+TJlHyXN+J6/c6CXJC9f5YonchGWX2gVL7eAbNVnnCAti3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pa1dzUNT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719450685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NxecLovoFS9dSSM/Ro4Ch3apms6LCxZ3/3a0agmN44c=;
	b=Pa1dzUNTlG7CZmklFcrYdpUg5nn2TRYMYi56EbQaGB82mLSvsAkyg8gKXTi7O1ZY7Xu2XK
	LBRXfw/I8K/cobfdtmSXUqRX98+vntatsK4DE/xuCMLkTFhFnavAKyM/DQDawXf11JSWt7
	JFOpNQNCLMvew+uAWTihuEMryRp2Rsk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-lts0GIvQOy2NbRVIE2NOOg-1; Wed, 26 Jun 2024 21:11:23 -0400
X-MC-Unique: lts0GIvQOy2NbRVIE2NOOg-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7065df788f7so1063471b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 18:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719450682; x=1720055482;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxecLovoFS9dSSM/Ro4Ch3apms6LCxZ3/3a0agmN44c=;
        b=aQR7bdD3mVNnu/6AXM970tjAZpHWiA7pCNR/LTBzo7iBg2vUvxRfi7M7Q7LCz61TDm
         MpjRtffJ/M+D5NLDoQ969HvdC2WLHQ5E5pGQziPiYgP0Tpt4PVluL7jNRlB3oqC2sl69
         9WSVJqQz/RGi/EoZJEKrZ3eLY2/P/CdHOSskfvoDDd3qjcSCNKPzrOptqWJbU6sR1mR1
         OXrui97D7BPTFRldaoGysgmv+WWfTbN2FSBCjnRInBK66kMVNQG3DRPISq/HYa1jawGK
         ha6QXxJGpl+UNPlMp1DegPr++CEhNXQvgixw8jkMLmUsuF0F6GxFhWr1dNgE7KYOCEeA
         z0Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWKR1Dnc+8DsBJ/qqo/uF9Xe4D3izXVw/hT04xpNGIm+Kg3q6ZDSPhVs1m9QlciQsYYfXPak99eXvi49WvdFIAEIfqk0xF2rv8XK6ke7g==
X-Gm-Message-State: AOJu0Yy2WbdqjMHEOgcX9kYDoZrs1uWF3JA/a4hK9TTzH1k+VUET9xA8
	pnPUcjx4H1rZmpBATg1epXFaRwZS1GCtbPnXNzLaZa0HwrqTR4qVxFd3/ys6BlkOTIp0j9oZTSy
	7Ikjej/WgYmMmCXHARxTm/nyq5hO+xst23tf96lDOkZhaP9h2t+xN6HMj3DIF3xo=
X-Received: by 2002:a05:6a00:1b50:b0:705:ade3:2e79 with SMTP id d2e1a72fcca58-706b52985efmr300466b3a.13.1719450682123;
        Wed, 26 Jun 2024 18:11:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQkClMyLp5/6Bm9qfQK8Nz7kXaEYeP4ncXTUgoLit1kdRydjCMS6aqXV92RSHHzRyJ8/p6jg==
X-Received: by 2002:a05:6a00:1b50:b0:705:ade3:2e79 with SMTP id d2e1a72fcca58-706b52985efmr300444b3a.13.1719450681717;
        Wed, 26 Jun 2024 18:11:21 -0700 (PDT)
Received: from ?IPV6:2403:580f:7fe0:0:ae49:39b9:2ee8:2187? (2403-580f-7fe0-0-ae49-39b9-2ee8-2187.ip6.aussiebb.net. [2403:580f:7fe0:0:ae49:39b9:2ee8:2187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b48cabb2sm128346b3a.16.2024.06.26.18.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 18:11:21 -0700 (PDT)
Message-ID: <50512ec3-da6d-4140-9659-58e0514a4970@redhat.com>
Date: Thu, 27 Jun 2024 09:11:14 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 1/1] fs/namespace: remove RCU sync for MNT_DETACH umount
To: Matthew Wilcox <willy@infradead.org>,
 Lucas Karpinski <lkarpins@redhat.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 raven@themaw.net, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Larsson <alexl@redhat.com>,
 Eric Chanudet <echanude@redhat.com>
References: <20240626201129.272750-2-lkarpins@redhat.com>
 <20240626201129.272750-3-lkarpins@redhat.com>
 <Znx-WGU5Wx6RaJyD@casper.infradead.org>
Content-Language: en-US
From: Ian Kent <ikent@redhat.com>
Autocrypt: addr=ikent@redhat.com; keydata=
 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
In-Reply-To: <Znx-WGU5Wx6RaJyD@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/6/24 04:47, Matthew Wilcox wrote:
> On Wed, Jun 26, 2024 at 04:07:49PM -0400, Lucas Karpinski wrote:
>> +++ b/fs/namespace.c
>> @@ -78,6 +78,7 @@ static struct kmem_cache *mnt_cache __ro_after_init;
>>   static DECLARE_RWSEM(namespace_sem);
>>   static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
>>   static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
>> +static bool lazy_unlock = false; /* protected by namespace_sem */
> That's a pretty ugly way of doing it.  How about this?

Ha!

That was my original thought but I also didn't much like changing all 
the callers.

I don't really like the proliferation of these small helper functions 
either but if everyone

is happy to do this I think it's a great idea.


Ian

>
> +++ b/fs/namespace.c
> @@ -1553,7 +1553,7 @@ int may_umount(struct vfsmount *mnt)
>   
>   EXPORT_SYMBOL(may_umount);
>   
> -static void namespace_unlock(void)
> +static void __namespace_unlock(bool lazy)
>   {
>          struct hlist_head head;
>          struct hlist_node *p;
> @@ -1570,7 +1570,8 @@ static void namespace_unlock(void)
>          if (likely(hlist_empty(&head)))
>                  return;
>   
> -       synchronize_rcu_expedited();
> +       if (!lazy)
> +               synchronize_rcu_expedited();
>   
>          hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
>                  hlist_del(&m->mnt_umount);
> @@ -1578,6 +1579,11 @@ static void namespace_unlock(void)
>          }
>   }
>   
> +static inline void namespace_unlock(void)
> +{
> +       __namespace_unlock(false);
> +}
> +
>   static inline void namespace_lock(void)
>   {
>          down_write(&namespace_sem);
> @@ -1798,7 +1804,7 @@ static int do_umount(struct mount *mnt, int flags)
>          }
>   out:
>          unlock_mount_hash();
> -       namespace_unlock();
> +       __namespace_unlock(flags & MNT_DETACH);
>          return retval;
>   }
>   
>
> (other variants on this theme might be to pass the flags to
> __namespace_unlock() and check MNT_DETACH there)
>


