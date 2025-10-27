Return-Path: <linux-fsdevel+bounces-65726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C64ACC0F2C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 17:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AF1C1888F4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 16:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E61F30F930;
	Mon, 27 Oct 2025 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HA/0OXMd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FAC30DD2A
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581201; cv=none; b=pEP3AKKU90qeqCw2C6kMVwiOFdlvkyYmnkxcyus4y7jpoMuE0rgBVnPg+PG60H7Cbg5AayswhqVjMYm7kzwtNeicyCvirWhJgpmufKwAIxUQme5kO70STTrEPzsDQb1POGTbFDAOhvPs1AJVVxmOIy42eAs97HijXDTwLFQrOh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581201; c=relaxed/simple;
	bh=QaWPD/XxXcWJkRndKn0ialPXtuOPWjCwlbSKvLXVWL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CV55LoQ4XEOC+5OucDoOylk3HEL5cn1GLG/RmeUoKpXFUD8PEQOp4rGdSAbtFTz7gPVw8VpM3yvsG4fNCtZmPVc847dM9Vz8+EMEJbGizva7W0/DrH7Iyaf+kRple4rvAgWy4sMeJLbnJd0mwf2+BryHedNpMPdp3j0fSIjfFg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HA/0OXMd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761581198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kpxdS5ygvVp4sssexZhDityvniMqB9yz0acKtxZ1LBk=;
	b=HA/0OXMdlw29QT44TH66HnEKUjp/yuTvp+Kij7dAeYc7jn9RcB7hhHFReoQqgUWwhaTVBd
	6W/G7+9riiSuFR7QN5UorADLDNbTJiZd1fxnZyacutyqexIAovVG0PGf2A1NwMc0H/dSj0
	x9yJDgpm+QHyQ+LsOhQbMlrM4pXt++4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-9jZO8z2TOWK8s-9nFvgkLg-1; Mon, 27 Oct 2025 12:06:37 -0400
X-MC-Unique: 9jZO8z2TOWK8s-9nFvgkLg-1
X-Mimecast-MFC-AGG-ID: 9jZO8z2TOWK8s-9nFvgkLg_1761581196
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-475da25c4c4so11743085e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 09:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761581196; x=1762185996;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kpxdS5ygvVp4sssexZhDityvniMqB9yz0acKtxZ1LBk=;
        b=CvBJy5Yfc3ox7IYsnmPOB3wJNF4IKU+NvTzVgjU2S3QeqQF6vExSl55VNo/+yqsDmZ
         Rw2K4o+UZH51mcyUvU+n8sseJJovyD7ih51YHgABZTSjwDQw+VyCLfWc+xxtU85BW+e/
         cea07T2EeyKemeOcddXra/phT0inAJdcMN0G0rt+CFjOKZKH7I9K+SdcxxCRKQjSsIL3
         +pKXVROkydpjQFSZxf6d219foNvx1I9bTfxHprPrmoiHoS2i2l9Z6v4wu4R+tjwNVKTj
         ITWk84PPnb1BO8jDBHk3xDinAcYC5HkIA0/NbeJEuNsckgfCx9eu3QaTbwyZeZzxhZXh
         26BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAi5w12uXBRjKijGxFz745ENxUoS2FP4240S9fx0HXJkMFZVnIixgO+F5jojuZOn/zZvsLQUGSWaDJaO2i@vger.kernel.org
X-Gm-Message-State: AOJu0YziI3TlI8zOsekHTNW8w67T6F9PFsaAFAXUN6wqfDKrLSqB888n
	sd7BWQ9M86ssFKsMO13Mm6vHrYXlk7u90TKXF/yiw9cK/Mx2qmYm8uZZkdLzDzHmlW0Rvx3RJ83
	G9Iu8AJjbI5NGwqWFdzrsBe2YUrakO2yLutOaHwyUC0AW6ohlWLY4JoVB4+2Sl+Wp77U=
X-Gm-Gg: ASbGncvx6k+SCYHrpkJCry5NdxZZhLxQmTVq8aidpsBdM3AEqY3E1mA07U2/SjYoRuh
	DDsBFdtjmMQK3VQa4PvZprKbWxUPCBXj59++ZosOIGvzK/wCIogmiDD/gulZpqd51OF18t1i8BE
	RPPw7+v8nBh/3WHbldCo48W7Ol62LQtjd4wax3r1bNNUOtudNGvY2unUDxohgAfVe8tBdgdSnsn
	X8E7vzzgq84mStIDWzHXy7cqIhnph7TJeHKKvLJgEZhQQfqOVwUl9xjvW1z7J0ZX8ri9xXqlCAt
	8zj9xyl4vMWSRYj6dKOEox6F27qqzwvCiQfE1xHluzHmOHMkf7o4fX8UGzdwSs7gKAnn16MrsK0
	FY273XkMldwq83kJecF0q1vVFJ1BO1ZJMbngMfo9lxNcXKkQWuPtTO5yeDOH6H4MifqYGPblSOE
	DeAfWnHGpGj7+2OZPu2Nse72Ow0EE=
X-Received: by 2002:a05:600c:4fc4:b0:46f:b327:ecfb with SMTP id 5b1f17b1804b1-47717e03722mr1896875e9.9.1761581196177;
        Mon, 27 Oct 2025 09:06:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv5M9b4q9OVKGnW+HmaEJg2ucSNwvJY0LUs9zHR8mcSnR+YxmFwPGnp36vYB+8STF/MebLhQ==
X-Received: by 2002:a05:600c:4fc4:b0:46f:b327:ecfb with SMTP id 5b1f17b1804b1-47717e03722mr1896525e9.9.1761581195766;
        Mon, 27 Oct 2025 09:06:35 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4cc596sm147684725e9.15.2025.10.27.09.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 09:06:35 -0700 (PDT)
Message-ID: <7bfd0822-5687-4ddc-9637-0cedd404c34e@redhat.com>
Date: Mon, 27 Oct 2025 17:06:34 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Yang Shi <shy828301@gmail.com>, Dave Chinner <david@fromorbit.com>,
 Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251017141536.577466-1-kirill@shutemov.name>
 <dcdfb58c-5ba7-4015-9446-09d98449f022@redhat.com>
 <hb54gc3iezwzpe2j6ssgqtwcnba4pnnffzlh3eb46preujhnoa@272dqbjakaiy>
 <CAHbLzkpx7iv40Tt+CDpbSsOupkGXKcix0wfiF6cVGrLFe0dvRQ@mail.gmail.com>
 <b8e56515-3903-068c-e4bd-fc0ca5c30d94@google.com>
 <CAHk-=wiWmTpQwz5FZ_=At_Tw+Nm_5Fcy-9is_jXCMo9T0mshZQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAHk-=wiWmTpQwz5FZ_=At_Tw+Nm_5Fcy-9is_jXCMo9T0mshZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.10.25 16:50, Linus Torvalds wrote:
> On Mon, 27 Oct 2025 at 03:49, Hugh Dickins <hughd@google.com> wrote:
>>
>> This makes a fundamental change to speculative page cache assumptions.
> 
> Yes, but I'm a bit surprised by people who find that scary.
> 
> The page cache does *much* more scary things elsewhere, particularly
> the whole folio_try_get() dance (in filemap_get_entry() and other
> places).
> 
> I suspect you ignore that just because it's been that way forever, so
> you're comfortable with it.
> 
> I'd argue that that is much *much* more subtle because it means that
> somebody may be incrementing the page count of a page that has already
> been re-allocated by somebody else.
> 
> Talk about cognitive load: that code makes you think that "hey, the
> tryget means that if it has been released, we don't get a ref to it",
> because that's how many of our *other* speculative RCU accesses do in
> fact work.
> 
> But that's not how the page cache works, exactly because freeing isn't
> actually RCU-delayed.
> 
> So while the code visually follows the exact same pattern as some
> other "look up speculatively under RCU, skip if it's not there any
> more", it actually does exactly the same thing as the "copy data under
> RCU, then check later if it was ok". Except it does "increment
> refcount under RCU, then check later if it was actually valid".
> 
> That said, I wonder if we might not consider making page cache freeing
> be RCU-delayed. This has come up before (exactly *because* of that
> "folio_try_get()").
> 
> Because while I am pretty sure that filemap_get_entry() is fine (and a
> number of other core users), I'm not convinced that some of the other
> users of folio_try_get() are necessarily aware of just how subtle that
> thing is.
> 
> Anyway, I'm certainly not going to push that patch very hard.

I will sleep better at night if we can guarantee that we are reading 
from a folio that has not been reused in the meantime -- or reading 
random other memory as I raised in my other mail.

So I really wish that we can defer optimizing this to freeing folios 
under RCU instead.

-- 
Cheers

David / dhildenb


