Return-Path: <linux-fsdevel+bounces-22848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 146B791D99C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 10:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7892BB2312A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 08:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360A281AC3;
	Mon,  1 Jul 2024 08:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JtJK2Ie5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0E47D095
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jul 2024 08:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719821033; cv=none; b=T4IkLOpxvjyOg21hpHVTjkqHJAuHlUquUh+BURxeZz9ycgbGHd7u12eKrjNihUPAQqZhiBblRWMDbjMfAHJVPX7un5tMy/2+3XP5GJOHHAYls6+xxTKWYZ0gC0Ua6xyptCA8hdgsUTLFlYjsiqOtez+vKggR1dSrJlYhkcU4Fws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719821033; c=relaxed/simple;
	bh=JxJ1zQf814o+SVDgj4eGoXFliTcMdrfjopYwUHZsANc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+xQtmlPEvJhEi81M/bfFV5FET//13p6gz0e0SnzXIWW5nPo5Pt3ICr9VUDJdztTjC++8pEdbDDxISB2rLGtQ+ciqMe2bW3T2AeqYJ5KzRfH6BkoGtMQT/erWt6OKmbJt+kYdiyChm8ABussS+Wqy01tKbV5F2IC9z9wOPINArg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JtJK2Ie5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719821030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zfO6c3CygsoyumKunvYygQ4i6coJEpJ84SAdNiJqg9o=;
	b=JtJK2Ie5XVfwE21dl8u50fxVJXDzqJRhTHdXbYjUZ4JDsq9x63rFQwBeudoS/5Zd1WPBGk
	RFgRX77+sdubN7ZyFsr1j5YQmAzB0ELUmaCkunXzgwAhnUg+HVLkWWmiJ81QsCB1IFHdVp
	02ABvHAFvtu0Jpb0VUmf8fvhvDEVu08=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-uHTJAtRwPAuKd1-4r2T5Xg-1; Mon, 01 Jul 2024 04:03:49 -0400
X-MC-Unique: uHTJAtRwPAuKd1-4r2T5Xg-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3d6331dd356so3016809b6e.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jul 2024 01:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719821029; x=1720425829;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfO6c3CygsoyumKunvYygQ4i6coJEpJ84SAdNiJqg9o=;
        b=HYhiPj5PC23089BqP02VrQF10rNWfrAgF8L3gvv/Va7vEzCjfbbnSkmcw0+0kPk6rD
         MstOzcmNfMiZfyvhvRqgDU2jvg2T7F5DPLVz9AXy/CVINRZOQkTDVqG43aVNJL1jLhLJ
         0GcBd393awFGIwS190eCLqNjRTsFZrPcrrpcUyq3l7jWUtEfHN+y1qMKgMTSpe7zguHO
         8i11AtymzAmgJXR+TExyYF4bTbLmbw8Tl3P0osdV1ng1050QXsz+GF/RSIof3mzbOrc9
         6zqKuvYggFQWtwIJdUgnKq+sGs/aCBETOy5FK2nLLt3MeWuQtmjJymbHzd0G0zJGs9oc
         ESfg==
X-Forwarded-Encrypted: i=1; AJvYcCXTExyXB1B3TztupS9DnI2asyAn/sdLYSIAUqvZV/jvTUvldK8sD4QX1jq1v4qbjs3v4+o63FyJSRSVzkgoZl/ZdRj+rSJxxOYsCvJZwg==
X-Gm-Message-State: AOJu0YzPpNkVm3bCGWdA2t94yluC/eIYJkMLovH6PvZH8RGb/og7Ie7Q
	PdoO7hNIP38K/C8hgeB2bDwaKcyqgUkSe2fVBELgIugn6XgcVPMg1wp8WgjMwFejieuj0L4kM+e
	dT7m7VdQLCjbQS0Q9fL1CT5QoYr4PQsD9bp7HD6TK/iBrodomDdUUNeRkrRLBhtE=
X-Received: by 2002:a05:6808:130c:b0:3d6:3149:62ca with SMTP id 5614622812f47-3d6b4727133mr7066743b6e.37.1719821028925;
        Mon, 01 Jul 2024 01:03:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgHOl6bw8bKGTftUey9S5M5axlYjj/+8udPygCVz7O8ajt5fK0pEirYbWVsrICSd+NARE69A==
X-Received: by 2002:a05:6808:130c:b0:3d6:3149:62ca with SMTP id 5614622812f47-3d6b4727133mr7066731b6e.37.1719821028561;
        Mon, 01 Jul 2024 01:03:48 -0700 (PDT)
Received: from ?IPV6:2403:580f:7fe0:0:ae49:39b9:2ee8:2187? (2403-580f-7fe0-0-ae49-39b9-2ee8-2187.ip6.aussiebb.net. [2403:580f:7fe0:0:ae49:39b9:2ee8:2187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080256c9dcsm5835235b3a.74.2024.07.01.01.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 01:03:48 -0700 (PDT)
Message-ID: <91b851d5-4ca0-43b2-990a-bf147371828e@redhat.com>
Date: Mon, 1 Jul 2024 16:03:41 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 1/1] fs/namespace: remove RCU sync for MNT_DETACH umount
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Larsson <alexl@redhat.com>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, Lucas Karpinski <lkarpins@redhat.com>,
 viro@zeniv.linux.org.uk, raven@themaw.net, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Eric Chanudet <echanude@redhat.com>
References: <20240626201129.272750-2-lkarpins@redhat.com>
 <20240626201129.272750-3-lkarpins@redhat.com>
 <Znx-WGU5Wx6RaJyD@casper.infradead.org>
 <50512ec3-da6d-4140-9659-58e0514a4970@redhat.com>
 <20240627115418.lcnpctgailhlaffc@quack3>
 <20240627-abkassieren-grinsen-6ce528fe5526@brauner>
 <d1b449cb-7ff8-4953-84b9-04dd56ddb187@redhat.com>
 <20240628-gelingen-erben-0f6e14049e68@brauner>
 <CAL7ro1HtzvcuQbRpdtYAG1eK+0tekKYaTh-L_8FqHv_JrSFcZg@mail.gmail.com>
 <97cf3ef4-d2b4-4cb0-9e72-82ca42361b13@redhat.com>
 <20240701-zauber-holst-1ad7cadb02f9@brauner>
Content-Language: en-US
From: Ian Kent <ikent@redhat.com>
Autocrypt: addr=ikent@redhat.com; keydata=
 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
In-Reply-To: <20240701-zauber-holst-1ad7cadb02f9@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/7/24 13:50, Christian Brauner wrote:
>> I always thought the rcu delay was to ensure concurrent path walks "see" the
>>
>> umount not to ensure correct operation of the following mntput()(s).
>>
>>
>> Isn't the sequence of operations roughly, resolve path, lock, deatch,
>> release
>>
>> lock, rcu wait, mntput() subordinate mounts, put path.
> The crucial bit is really that synchronize_rcu_expedited() ensures that
> the final mntput() won't happen until path walk leaves RCU mode.
>
> This allows caller's like legitimize_mnt() which are called with only
> the RCU read-lock during lazy path walk to simple check for
> MNT_SYNC_UMOUNT and see that the mnt is about to be killed. If they see
> that this mount is MNT_SYNC_UMOUNT then they know that the mount won't
> be freed until an RCU grace period is up and so they know that they can
> simply put the reference count they took _without having to actually
> call mntput()_.
>
> Because if they did have to call mntput() they might end up shutting the
> filesystem down instead of umount() and that will cause said EBUSY
> errors I mentioned in my earlier mails.

Yes, I get that, the problem with this was always whether lockless path 
walks

would correctly see the mount had become invalid when being checked for

legitimacy.


>
>>
>> So the mount gets detached in the critical section, then we wait followed by
>>
>> the mntput()(s). The catch is that not waiting might increase the likelyhood
>>
>> that concurrent path walks don't see the umount (so that possibly the umount
>>
>> goes away before the walks see the umount) but I'm not certain. What looks
>> to
>>
>> be as much of a problem is mntput() racing with a concurrent mount beacase
>> while
>>
>> the detach is done in the critical section the super block instance list
>> deletion
>>
>> is not and the wait will make the race possibility more likely. What's more
> Concurrent mounters of the same filesystem will wait for each other via
> grab_super(). That has it's own logic based on sb->s_active which goes
> to zero when all mounts are gone.

Yep, missed that, I'm too hasty, thanks for your patience.


>
>> mntput() delegates the mount cleanup (which deletes the list instance) to a
>>
>> workqueue job so this can also occur serially in a following mount command.
> No, that only happens when it's a kthread. Regular umount() call goes
> via task work which finishes before the caller returns to userspace
> (same as closing files work).

Umm, misread that, oops!


Ian

>
>>
>> In fact I might have seen exactly this behavior in a recent xfs-tests run
>> where I
>>
>> was puzzled to see occasional EBUSY return on mounting of mounts that should
>> not
>>
>> have been in use following their umount.
> That's usually very much other bugs. See commit 2ae4db5647d8 ("fs: don't
> misleadingly warn during thaw operations") in vfs.fixes for example.
>
>>
>> So I think there are problems here but I don't think the removal of the wait
>> for
>>
>> lazy umount is the worst of it.
>>
>>
>> The question then becomes, to start with, how do we resolve this unjustified
>> EBUSY
>>
>> return. Perhaps a completion (used between the umount and mount system
>> calls) would
>>
>> work well here?
> Again, this already exists deeper down the stack...
>


