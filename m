Return-Path: <linux-fsdevel+bounces-35439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AD69D4CA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 13:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5991F22462
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 12:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9281D61B9;
	Thu, 21 Nov 2024 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQ9djYCn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B448A1D3628
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 12:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732191330; cv=none; b=a3tLkssbF7a1hjOIxkQKu9umZURD14y/NmQIndXlzG6YBgh7T+SVEwtJOPaXMn5jHmhvBoBMsfJAZxpElzaRvi9Po8syzE8zHbOh/EUtWPMTvaMklQR4vCsGEn/5MPjZNkR2b8UK/nl84INoMnv8nys2F+aZxyfoc3UirFEjQ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732191330; c=relaxed/simple;
	bh=bFtWSnyszr1WL+XBp+VI0x8AlLLXfFSA63R2QL+Z/ZU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FxO+AzVRB/jXbk89dLP4aNPG4kPTv0nfE1hPjkYR4da1beViXhb0+yf47m26PwylW8IDLsvoefeOs07caGlZ7zZOscsEaniRvyVOW+2byRJxNbo36uCWmSkppXhUAsGb6a1P9GGsT0iJgXKvDOki5zpc4xtQ09f4qrKCW0zAC+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bQ9djYCn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732191327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6QJPf/QXzHw/XfmlRsdzm6NkegP6JwGL9mVJti62D7U=;
	b=bQ9djYCnfw01nVBEAbzavIkth8FmyiQ6jVf3i6uKw05zU6KC60H0u6y7cJL0T+8CUKNlO1
	Orb+SPi7e+8d1yy/Aq3kk/qU8OkVskzmG4VzmRi+u8V2GIQJ1Yx1sz+VCUrhw6So58gsq2
	zfDs2YndSv6YkhXMbM6c8reXZEmMacE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-_W9ujg9JO0WB210tLKryLw-1; Thu, 21 Nov 2024 07:15:24 -0500
X-MC-Unique: _W9ujg9JO0WB210tLKryLw-1
X-Mimecast-MFC-AGG-ID: _W9ujg9JO0WB210tLKryLw
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-382428c257eso436612f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 04:15:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732191323; x=1732796123;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6QJPf/QXzHw/XfmlRsdzm6NkegP6JwGL9mVJti62D7U=;
        b=f8YsZjgX4FMJgKqv+NUaYTrDxzAyAGBUsc2dbUo+URJnJm8TFGcm42WksOIJ1ZJKqb
         fUddQcuxXbrokQSeiGL/LDaVxNgF5aszyqBoh79jpnSnUyPWz15yNj0VBd9m/9CSbmmv
         ZjqRPVq9YvMlBx0s/MHUsR9/ddEOWULDG1b3c00P9oDJnqZ/gJGDVvlpaoVRWvKGOi7W
         20Uf/rwicMFEf8CeLOChvPaomc7Udc8i749NGHGE22KWJWt4tGzYNTU3bJNrvuj6qlUd
         1JfmBxk+pcCnIkWcZE/7img5uXRaFD8hds2/jvhGTjB2oCwt7+kTvCMlWgm1siMtfpgY
         PV6w==
X-Gm-Message-State: AOJu0YzyTtUqo7JAg5MSSgTUJrFW7ztghyJ53RQgtD5k3ucxnQvclsdZ
	LJ9fWoStLGU5yhrWlaQn7zHINXIdwgB7FjZwxcARh6XIZ7+HfWDDLsS/xu3O8F6nhjCdk3IwOaq
	/TxTePhbejLvViqRWQHWoWETIChu7Bk8dxpv/b0rd1CWqliliJxTOWnmqNHL8VRw=
X-Gm-Gg: ASbGncvnXzCUFfuVn0It33iYfNo13FhCV4koST2p0LVS8u1jHpkAmJIkDxgZVK0Lbti
	cPsAnN5RBLn9/Ov63rhPr08gPpH9jLwiVN/jpsHFd9/tUUrgHjjgGbuRxCkvMlFkVqF8VtwKKMp
	QXhkwwm/5bXy0KCVNfHSFenYwQc/K7yWUpr2PAVd8CmH2tg2y8H5QWIDjNi0K16wr0e5ofdIOqO
	4JnPnnBZZewJrYJeP3I7aEcUQ3Pn+iNR6Idhtcz2WS39S+PvALjJoM+ce1hrrAL0d3JsHwN+Gvg
	zZwhK6124ofs5tyZnDZ2gmu9MZM0jebuMCZP5hjgxg8UZxUgme9Kgc2irDafWXeC5SEIaZ+wT+I
	=
X-Received: by 2002:a5d:6dae:0:b0:382:5010:c8c0 with SMTP id ffacd0b85a97d-38254b1629fmr4738668f8f.39.1732191323111;
        Thu, 21 Nov 2024 04:15:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGf+JeO8PlWSGqxi8WzLLx0/13BvnWEOSX9j/uGWQ2jCJhjWZQ5v7kj7e8JRuJ55NvMjP3HrQ==
X-Received: by 2002:a5d:6dae:0:b0:382:5010:c8c0 with SMTP id ffacd0b85a97d-38254b1629fmr4738643f8f.39.1732191322698;
        Thu, 21 Nov 2024 04:15:22 -0800 (PST)
Received: from ?IPV6:2003:cb:c70c:de00:1200:8636:b63b:f43? (p200300cbc70cde0012008636b63b0f43.dip0.t-ipconnect.de. [2003:cb:c70c:de00:1200:8636:b63b:f43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825493ee59sm4842152f8f.103.2024.11.21.04.15.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 04:15:22 -0800 (PST)
Message-ID: <fbb59ba8-7d8c-4d64-ab46-d4950c073018@redhat.com>
Date: Thu, 21 Nov 2024 13:15:21 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ISSUE] split_folio() and dirty IOMAP folios
From: David Hildenbrand <david@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 kvm@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
References: <4febc035-a4ff-4afe-a9a0-d127826852a9@redhat.com>
 <ZyzmUW7rKrkIbQ0X@casper.infradead.org>
 <ada851da-70c2-424e-b396-6153cecf7179@redhat.com>
 <Zy0g8DdnuZxQly3b@casper.infradead.org>
 <6099e202-ef0a-4d21-958c-2c42db43a5bb@redhat.com>
 <d3600a33-a481-4c4c-bda6-a446f1c965c6@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d3600a33-a481-4c4c-bda6-a446f1c965c6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.11.24 16:19, David Hildenbrand wrote:
> On 08.11.24 10:11, David Hildenbrand wrote:
>> On 07.11.24 21:20, Matthew Wilcox wrote:
>>> On Thu, Nov 07, 2024 at 05:34:40PM +0100, David Hildenbrand wrote:
>>>> On 07.11.24 17:09, Matthew Wilcox wrote:
>>>>> On Thu, Nov 07, 2024 at 04:07:08PM +0100, David Hildenbrand wrote:
>>>>>> I'm debugging an interesting problem: split_folio() will fail on dirty
>>>>>> folios on XFS, and I am not sure who will trigger the writeback in a timely
>>>>>> manner so code relying on the split to work at some point (in sane setups
>>>>>> where page pinning is not applicable) can make progress.
>>>>>
>>>>> You could call something like filemap_write_and_wait_range()?
>>>>
>>>> Thanks, have to look into some details of that.
>>>>
>>>> Looks like the folio_clear_dirty_for_io() is buried in
>>>> folio_prepare_writeback(), so that part is taken care of.
>>>>
>>>> Guess I have to fo from folio to "mapping,lstart,lend" such that
>>>> __filemap_fdatawrite_range() would look up the folio again. Sounds doable.
>>>>
>>>> (I assume I have to drop the folio lock+reference before calling that)
>>>
>>> I was thinking you'd do it higher in the callchain than
>>> gmap_make_secure().  Presumably userspace says "I want to make this
>>> 256MB range secure" and we can start by writing back that entire
>>> 256MB chunk of address space.
>>>
>>> That doesn't prevent anybody from dirtying it in-between, of course,
>>> so you can still get -EBUSY and have to loop round again.
>>
>> I'm afraid that won't really work.
>>
>> On the one hand, we might be allocating these pages (+disk blocks)
>> during the unpack operation -- where we essentially trigger page faults
>> first using gmap_fault() -- so the pages might not even exist before the
>> gmap_make_secure() during unpack. One work around would be to
>> preallocate+writeback from user space, but it doesn't sound quite right.
>>
>> But the bigger problem I see is that the initial "unpack" operation is
>> not the only case where we trigger this conversion to "secure" state.
>> Once the VM is running, we can see calls on arbitrary guest memory even
>> during page faults, when gmap_make_secure() is called via
>> gmap_convert_to_secure().
>>
>>
>> I'm still not sure why we see essentially no progress being made, even
>> though we temporarily drop the PTL, mmap lock, folio lock, folio ref ...
>> maybe related to us triggering a write fault that somehow ends up
>> setting the folio dirty :/ Or because writeback is simply too slow /
>> backs off.
>>
>> I'll play with handling -EBUSY from split_folio() differently: if the
>> folio is under writeback, wait on that. If the folio is dirty, trigger
>> writeback. And I'll look into whether we really need a writable PTE, I
>> suspect not, because we are not actually "modifying" page content.
> 
> The following hack makes it fly:
> 
>           case -E2BIG:
>                   folio_lock(folio);
>                   rc = split_folio(folio);
> +               if (rc == -EBUSY) {
> +                       if (folio_test_dirty(folio) && !folio_test_anon(folio) &&
> +                           folio->mapping) {
> +                               struct address_space *mapping = folio->mapping;
> +                               loff_t lstart = folio_pos(folio);
> +                               loff_t lend = lstart + folio_size(folio);
> +
> +                               folio_unlock(folio);
> +                               /* Mapping can go away ... */
> +                               filemap_write_and_wait_range(mapping, lstart, lend);
> +                       } else {
> +                               folio_unlock(folio);
> +                       }
> +                       folio_wait_writeback(folio);
> +                       folio_lock(folio);
> +                       split_folio(folio);
> +                       folio_unlock(folio);
> +                       folio_put(folio);
> +                       return -EAGAIN;
> +               }
>                   folio_unlock(folio);
>                   folio_put(folio);
> 
> 
> I think the reason why we don't make any progress on s390x is that the writeback will
> mark the folio clean and turn the folio read-only in the page tables as well. So when we
> lookup the folio again in the page table, we see that the PTE is not writable and
> trigger a write fault ...
> 
> ... the write fault will mark the folio dirty again, so the split will never succeed.
> 
> In above diff, we really must try the split_folio() a second time after waiting, otherwise we
> run into the same endless loop.
> 
> 
> I'm still not 100% sure if we need a writable PTE; after all we are not modifying page content.
> But that's just a side effect of not being able to wait for the split_folio() to make progress
> in the writeback case so we can retry the split again.

After discussing this with Darrick and Willy yesterday, I think the 
reason we need a writable PTE is because we *might* modify page content:

"Requests the Ultravisor to make a page accessible to a guest. If it's 
brought in the first time, it will be cleared. If it has been exported 
before, it will be decrypted and integrity checked."

So we'll be effectively modifying the page content we will read when the 
(now secure) page is in the unprotected/exported state.

That makes things more complicated, unfortunately :)

-- 
Cheers,

David / dhildenb


