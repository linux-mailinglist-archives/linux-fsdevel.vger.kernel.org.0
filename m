Return-Path: <linux-fsdevel+bounces-40138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B30EA1D1C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 08:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1544162E0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 07:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9261FC7E3;
	Mon, 27 Jan 2025 07:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3lBwNfG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113FF172BD5
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 07:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737964211; cv=none; b=h0ISQuN4Ixu5kROMpzS5FQk87nKSFC1JjAF07a+UhWKkLLu1+hnXIX9yoOhV6krdAkjiIegTPkyoNPySuaw4ubpiwbWJ9bDsPO17yoJD2yq5/ttqazu2m4ADPZ6T4mGTVPeCV7U4r6cW+ptFgkfvKGYnKDbY4HJCLXPGYQSEh+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737964211; c=relaxed/simple;
	bh=kUxhEXxT3nV7h0yFs01smjPXBCJs+W9zbiZfnTdqBlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PyPe9QEzWHCamPDFvuMp8CVsyuawq/c9EtkwTksTp8bxN0KV4gmn+ppxK9EuYMo16gFtM7cVlQkeDBICrlr0Noacf1uFn6m/h8TzrKEF1WixCy88tlOKTXtdIsVi1AaOQcm5JuAfKOjDkYnnprPW2rK93lhJE+BDn1g76dxW4hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N3lBwNfG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737964207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=td2S0RJad1Op9/8Uu4Ud/bRVmyLKaTbLfKYbpacKpgM=;
	b=N3lBwNfG4fxqgPQbW8FR0axK0Fm7KGdfIi3vXRpntOmCgF8f8nsI/twVC+D9Ee6wA5HDAN
	iUL8sq4pseFyrYICb/fS7pxNV5sfl7bKsOy8g5sRiANo/lwTnV5sJ2VgJp6b6XHFfnnldI
	SY1UlncB3DEXT6GWc0PeAmgm7N8OOYo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-lZ-yN-9DMSWZn8leE93Wug-1; Mon, 27 Jan 2025 02:50:06 -0500
X-MC-Unique: lZ-yN-9DMSWZn8leE93Wug-1
X-Mimecast-MFC-AGG-ID: lZ-yN-9DMSWZn8leE93Wug
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43621907030so29812005e9.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jan 2025 23:50:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737964204; x=1738569004;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=td2S0RJad1Op9/8Uu4Ud/bRVmyLKaTbLfKYbpacKpgM=;
        b=e41ElutFqEvT1DO+Jw8UQ7jBzszIfBbaEYReTWkvOc8Erw0NmEiOoAfAg7tvmsV4ts
         ATWqERwMI8mA5+w7Bz4VrSqjax2/E69s9zLRjrhrdHhBEY5lhmKRuuNc3RuFXAhrKQa9
         VHJVvWdIkK2bR/l6hs6CQk+ZBGoxVH7Tc3GmPZBSLxkeFA99K4gWjmketotOmiyTDw93
         UZOr426gkI7qpIqV4D5hLx9sKhaYo6FRi4twt224rpZhDDIduXUrRTjtJ3CbDJAZNiw2
         vF9v5jimdbVL8uvQlgWAX/zms3ScOtYgHCCiCgD7H9hZW+I6uqaVw8q5+3d/GgZJkJ5E
         ys+A==
X-Gm-Message-State: AOJu0Yyjm8QllX1HYGE+nD90NhLw1EkWyIQLDfOZ+j49KsXQdLmFrQNF
	rzz5x+3gLxnw6mf7zAiVStnQGjQrddWis8j6+BY56fOtJlIsNNT6N7ZX0NYkD+Ycw8ivp64JyC+
	pNORzqfqAqHfy+v/NH0Xk74OAXlVIXbAbUXF6HB9ZFp8/c9HDzsYLas5qQLlVL08=
X-Gm-Gg: ASbGncsUpQ54L/r/wkPf4WxpYa4A/MphPfsEDe8uRcOsZNsuRPDqi0+FMwQo4m2zJaL
	mWz1tff7Fiqe3StYxT90r2a6WLNwwylZkSeO85MTu/ZZBA8HI84ZqNxH5b4l2ftr7xhG1uKEu4Y
	vdshbf2r3aKyrDC7pkfK9s7I1dz/Zht+MzuqbUa9TSyn3PWkSa8ps7z9fNboFm7mQ711qmkgdxc
	ngmOTda7ffiotw0moKV6UK8KOl23EogPk5jWQSEeLilY6N8K7KTrMv8DiHttHufzbmwYhtG1PiF
	Dhy1rVpOxGjVK0DxK4jj4LFUBHMpNjZ6rPk0G9WT9HpoeBoanNG1bsxzaGY3qT1wHqZU9n4Cfz/
	8fqb1Y26rPSibon6DHLylLz9aHuh5H9Vi
X-Received: by 2002:a05:6000:4008:b0:38b:5e14:23e7 with SMTP id ffacd0b85a97d-38bf5669760mr40752994f8f.23.1737964204597;
        Sun, 26 Jan 2025 23:50:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF84I8c9EWSeQEj85TZmyBpF86Tf+zlS87dFMH16NmQWpegiGqztFcJfctkWKGGaEZDIWexrA==
X-Received: by 2002:a05:6000:4008:b0:38b:5e14:23e7 with SMTP id ffacd0b85a97d-38bf5669760mr40752974f8f.23.1737964204253;
        Sun, 26 Jan 2025 23:50:04 -0800 (PST)
Received: from ?IPV6:2003:cb:c736:ca00:b4c3:24bd:c2f5:863c? (p200300cbc736ca00b4c324bdc2f5863c.dip0.t-ipconnect.de. [2003:cb:c736:ca00:b4c3:24bd:c2f5:863c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1bb0c9sm10353714f8f.78.2025.01.26.23.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2025 23:50:02 -0800 (PST)
Message-ID: <6c179456-22ba-4708-ba8f-3c1023837bd5@redhat.com>
Date: Mon, 27 Jan 2025 08:50:01 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [fs?] WARNING in stable_page_flags
To: Matthew Wilcox <willy@infradead.org>,
 syzbot <syzbot+069bb8b6fd64a600ab7b@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <67944daf.050a0220.3ab881.000d.GAE@google.com>
 <Z5TzIj7A_DzT5688@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z5TzIj7A_DzT5688@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.01.25 15:20, Matthew Wilcox wrote:
> On Fri, Jan 24, 2025 at 06:34:23PM -0800, syzbot wrote:
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 6789 at ./include/linux/mm.h:1228 folio_large_mapcount include/linux/mm.h:1228 [inline]
>> WARNING: CPU: 0 PID: 6789 at ./include/linux/mm.h:1228 folio_mapcount include/linux/mm.h:1262 [inline]
>> WARNING: CPU: 0 PID: 6789 at ./include/linux/mm.h:1228 folio_mapped include/linux/mm.h:1273 [inline]
>> WARNING: CPU: 0 PID: 6789 at ./include/linux/mm.h:1228 page_mapped include/linux/mm.h:1283 [inline]
>> WARNING: CPU: 0 PID: 6789 at ./include/linux/mm.h:1228 stable_page_flags+0xab5/0xbc0 fs/proc/page.c:132
> 
> I'm shocked we haven't seen this before.
> 
> kpageflags_read() iterates over every PFN in a range, calling
> pfn_to_page() and then page_folio() on each of them.  Since it makes
> no attempt to establish a refcount on the folio (nor should it), the
> page/folio can be freed under it.  And that's what's happened; when it
> first looked, this page was part of a slab, and now it's free.
> 
> What we need to do is memcpy() the page, just like we do in dump_page().
> I'll get to it next week.
> 

We should also use that approach in

https://lore.kernel.org/all/67812fbd.050a0220.d0267.0030.GAE@google.com/

Grabbing a temporary page/folio reference also works, but I do not like 
it where it can be avoided.

Can you take care of that one as well?

-- 
Cheers,

David / dhildenb


