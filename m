Return-Path: <linux-fsdevel+bounces-22722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A688891B55C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 05:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63321C20E5A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 03:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A27F1CA8A;
	Fri, 28 Jun 2024 03:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhj6w4tq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B2914A85
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 03:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544675; cv=none; b=gDr5tMcb7RMK77B6c2grAdntj1/BxL2qUGuVRThkicoueZHQd5l08rEBhPYdzdsCzXi6MzZFcWpVhlvkSWNtrs2sdePYKVrJuHIZkgSuiTCnCjeUcdQvJiSlUCxgWOCpeXIiCDAsz6bGDM1CXnZV98V1rrPpefW9Yzr68XLSFiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544675; c=relaxed/simple;
	bh=fdCjEuFjhYeeY9vzbpQuPVm4W9bNTsY5MKRpYPvF7YM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LCHAQHo/LjkEu9eMsuQW7zJa+K+Jp94PN1NonRn9VsRFIz1xkSp3Dghr8iAPIfE2Wzgy9+1MMhsk/OThcwnntwAmJxdhsGkSnOvhnyRktPJ76t4DvQ18XOiqHYSh2KmYfRCOAKJE2/P6U1LfbONIKEPyNMD9zb46BxdOfRiX5Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fhj6w4tq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719544672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WS8VRRBGVPt+4KeY3/sBO8pTWhEejzFxWJJwTlTI53E=;
	b=fhj6w4tqi90wvNWZqWxgeTeOZ6YshBsQylDH6mSJvrofD+N+hBnhxNrzbglD3QjJ9Ixt3p
	KP+73VVJdEgV39RtPp/33KgyE6C2FGhfrDOsCCkj0FB1+eqeN8HvAEeCZlr9peMN6eEQHI
	b17HfJ5zvMPwOD69ON/UItgsEDc/0vI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-ZuHO6Pp8NPK3JToYrCi6ow-1; Thu, 27 Jun 2024 23:17:51 -0400
X-MC-Unique: ZuHO6Pp8NPK3JToYrCi6ow-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c873306d21so236127a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 20:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719544670; x=1720149470;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WS8VRRBGVPt+4KeY3/sBO8pTWhEejzFxWJJwTlTI53E=;
        b=u4ZIReB/IkPofAK4KqrV6OEUBCSx3LPh8nlz8NAUgG8XAVnRGhn09AKbvAaMbcxEfx
         UcSxe92XPl3LKDE/xQx7XQbP+YpAGCGyG++Uj4OLAei4k+EgUqXJVm7uSZxZriyFutwz
         gq4AZjf6scw4sogtno9wkLuRvFqczIzAFFuHDCfT7ROllvafKCRTPB1jQsx5O4ntPwEJ
         vuDvrvhA8vdl+bRf57w+iJCItMKC3Rt3BZkxgVDgcOQHkpMWNYF5l2/eIic9Qm+4kNbn
         HYU8YEGugvzkXY6UYuQzB+rBLD6gSAA9aPtcquew/dTIWcO8Y0GpQW96BV60zXq5GDhp
         SqlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqsaBwDT0cAsQbgIy2Zx5D1ErNo+ZcMengwN7NAFZ8kAop9A6jXYS58IWyo18tYYAqjHbhBdQPRYbTdFdCxR9vDVHobPIeSJoLjAzKlQ==
X-Gm-Message-State: AOJu0YzYCqKQPZzXr6RAHbGVql8kjQBniO9JjOTYDpTonUPTyPOLKTQ4
	vxUDA5TrM3DKCL0idIXhqXLsx2pJyr7vldT/oPYSGVL5KTDplSalYG5JMh2ZaqtNKhw5n4OJf1s
	3zR7k1T6H+uY/iLANau+ASJ8sa00xz4BjbKTm9NH6KDYrDU2O/z7uy21t5ms2fco=
X-Received: by 2002:a17:90b:1644:b0:2c7:d414:a93d with SMTP id 98e67ed59e1d1-2c8612689cfmr14164937a91.24.1719544669883;
        Thu, 27 Jun 2024 20:17:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECesyWJa75m/ilpX2WXnRmR8zZe5yxJszHIy5IEJpEIC6jmzf018yU/YV85XyeNW9lapYOag==
X-Received: by 2002:a17:90b:1644:b0:2c7:d414:a93d with SMTP id 98e67ed59e1d1-2c8612689cfmr14164921a91.24.1719544669510;
        Thu, 27 Jun 2024 20:17:49 -0700 (PDT)
Received: from ?IPV6:2403:580f:7fe0:0:ae49:39b9:2ee8:2187? (2403-580f-7fe0-0-ae49-39b9-2ee8-2187.ip6.aussiebb.net. [2403:580f:7fe0:0:ae49:39b9:2ee8:2187])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce76935sm539044a91.34.2024.06.27.20.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 20:17:48 -0700 (PDT)
Message-ID: <d1b449cb-7ff8-4953-84b9-04dd56ddb187@redhat.com>
Date: Fri, 28 Jun 2024 11:17:43 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 1/1] fs/namespace: remove RCU sync for MNT_DETACH umount
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>,
 Lucas Karpinski <lkarpins@redhat.com>, viro@zeniv.linux.org.uk,
 raven@themaw.net, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Larsson <alexl@redhat.com>,
 Eric Chanudet <echanude@redhat.com>
References: <20240626201129.272750-2-lkarpins@redhat.com>
 <20240626201129.272750-3-lkarpins@redhat.com>
 <Znx-WGU5Wx6RaJyD@casper.infradead.org>
 <50512ec3-da6d-4140-9659-58e0514a4970@redhat.com>
 <20240627115418.lcnpctgailhlaffc@quack3>
 <20240627-abkassieren-grinsen-6ce528fe5526@brauner>
Content-Language: en-US
From: Ian Kent <ikent@redhat.com>
Autocrypt: addr=ikent@redhat.com; keydata=
 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
In-Reply-To: <20240627-abkassieren-grinsen-6ce528fe5526@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 27/6/24 23:16, Christian Brauner wrote:
> On Thu, Jun 27, 2024 at 01:54:18PM GMT, Jan Kara wrote:
>> On Thu 27-06-24 09:11:14, Ian Kent wrote:
>>> On 27/6/24 04:47, Matthew Wilcox wrote:
>>>> On Wed, Jun 26, 2024 at 04:07:49PM -0400, Lucas Karpinski wrote:
>>>>> +++ b/fs/namespace.c
>>>>> @@ -78,6 +78,7 @@ static struct kmem_cache *mnt_cache __ro_after_init;
>>>>>    static DECLARE_RWSEM(namespace_sem);
>>>>>    static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
>>>>>    static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
>>>>> +static bool lazy_unlock = false; /* protected by namespace_sem */
>>>> That's a pretty ugly way of doing it.  How about this?
>>> Ha!
>>>
>>> That was my original thought but I also didn't much like changing all the
>>> callers.
>>>
>>> I don't really like the proliferation of these small helper functions either
>>> but if everyone
>>>
>>> is happy to do this I think it's a great idea.
>> So I know you've suggested removing synchronize_rcu_expedited() call in
>> your comment to v2. But I wonder why is it safe? I *thought*
>> synchronize_rcu_expedited() is there to synchronize the dropping of the
>> last mnt reference (and maybe something else) - see the comment at the
>> beginning of mntput_no_expire() - and this change would break that?
> Yes. During umount mnt->mnt_ns will be set to NULL with namespace_sem
> and the mount seqlock held. mntput() doesn't acquire namespace_sem as
> that would get rather problematic during path lookup. It also elides
> lock_mount_hash() by looking at mnt->mnt_ns because that's set to NULL
> when a mount is actually unmounted.
>
> So iirc synchronize_rcu_expedited() will ensure that it is actually the
> system call that shuts down all the mounts it put on the umounted list
> and not some other task that also called mntput() as that would cause
> pretty blatant EBUSY issues.
>
> So callers that come before mnt->mnt_ns = NULL simply return of course
> but callers that come after mnt->mnt_ns = NULL will acquire
> lock_mount_hash() _under_ rcu_read_lock(). These callers see an elevated
> reference count and thus simply return while namespace_lock()'s
> synchronize_rcu_expedited() prevents the system call from making
> progress.
>
> But I also don't see it working without risk even with MNT_DETACH. It
> still has potential to cause issues in userspace. Any program that
> always passes MNT_DETACH simply to ensure that even in the very rare
> case that a mount might still be busy is unmounted might now end up
> seeing increased EBUSY failures for mounts that didn't actually need to
> be unmounted with MNT_DETACH. In other words, this is only inocuous if
> userspace only uses MNT_DETACH for stuff they actually know is busy when
> they're trying to unmount. And I don't think that's the case.
>
I'm sorry but how does an MNT_DETACH umount system call return EBUSY, I 
can't

see how that can happen?


I have used lazy umount a lot over the years and I haven't had problems 
with it.

There is a tendency to think there might be problems using it but I've 
never been

able to spot them.


Ian


