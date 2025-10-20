Return-Path: <linux-fsdevel+bounces-64733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3D2BF313F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 21:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 362834E7235
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 19:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F292C327C;
	Mon, 20 Oct 2025 19:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwlToA3Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F591FF7C8
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 19:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760986857; cv=none; b=j9fsuDfeIqY0KJBuXyz17XnGeFle5174w03i/izTxPE1AWgNaHHiUPfJgwibOI++dbT/ce2dttERQ5cxDk90LEaHD5U/T3De33wqiRlUGd/fzWlI5IUG42G98s5ku42SAJlgIxH5jTDRjsQm8kYFi+JP/u8Mu430/RXARzns70I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760986857; c=relaxed/simple;
	bh=dINDdnyXF6Lg3jKRdMS4yzZeQRu34B+x194gDj4KLgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TOTHAcwbjYruPe6IUS1FzfvnPvHE0SDZxxMKcfrL6U/TC+IAKeTrdij+/xEOG/0VqgS+ObAJCkO5ip0G7T6S45bKpM5lKY4Dr+a2DaZpyA9WBBImD6h1hzU72fU7igVkCXiWgCyRK1WaxV+qDMvJg+RorWKB1+drftQeUbniER0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bwlToA3Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760986855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5wAdwIsaV2mxz61hLX4vusJU8KfwA6OJx8U1ryQWw3U=;
	b=bwlToA3Yk7Y979RP19AeqesavZsO3x6kb6QCVM3I3xI1PZ6eKvzB0X/lthOBNlfXpGPFuD
	NU/j7RbLTELfO2JF7BgVB8F9mhHMj6NPK4Mk3Ze/aGMTj+zYEuQrh2t8F6Xre6M0dLnj1t
	N4SeOnodIeWj7Eeq4zYhMmrBm6uFeFw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-ajXJBhLXNCybuVFPhL6Iew-1; Mon, 20 Oct 2025 15:00:53 -0400
X-MC-Unique: ajXJBhLXNCybuVFPhL6Iew-1
X-Mimecast-MFC-AGG-ID: ajXJBhLXNCybuVFPhL6Iew_1760986852
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47114018621so23774295e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 12:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760986852; x=1761591652;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wAdwIsaV2mxz61hLX4vusJU8KfwA6OJx8U1ryQWw3U=;
        b=nBC4o0nWcpr7C6mPqCJP2pNCYXagf4vtI8nMdgfZb3ZmjVda7nXVWQ80TJcKYYodKU
         tzQnsdaBpZZvQkFRJSsnQsxj/+VO/VVPUw12CMZED/ivhzjhxYpkdGllTY/DYoEkEQkd
         kRKh23/MybeYIZuzqVwK2h3o9PIUwzoQZMfZcpBJ+kIrrNHzRnRwLd0scbo2nuqQ5P3C
         p+EKDBmELpb7fxE8iz9y14JUUj9BHFNT9N6rgyfxg0LC5LTCAj0V7PYKguNSsErmHcFX
         AybnLEjXrMnGlcYOzfflF6ipAis3iBbbCAydbWqCTr1mxW8on4wVO5rfacjX+ZeE1CW4
         lsEw==
X-Forwarded-Encrypted: i=1; AJvYcCWdrbl5fO8s81QE9gqrW8u6TfaCd1pr+aG4NyvQF7KUL/DP9ZLzopukF7Mz+xcDmyfPJC+5HlBCUd36TrFt@vger.kernel.org
X-Gm-Message-State: AOJu0YzdldfQ0snExmPyi9oAZIWOCay8BVH1JqHdlwkL4Stw71G26z1b
	1vrNJyu8abYlDdLP0GK4PYtySDw1ajpyBEvNs4CevK8I78uzxsB4SJnER5qppnLZuYPLkaCnJKs
	PdMFzAdjJIoj6pUzU23EpOXmR97ySdiiz+ZBj/awg/tprBB5tucIdQldShcsruBf+SaM=
X-Gm-Gg: ASbGnctYLVuAt0g0HqlHHvsbCM2mjBkjTnAmH7rOmFtZKlH/mQsFmx/u98Gs1vWmZfj
	B1qUQif8BZEeNIpDgESI7VS6w6hRMbcHI2vbQTTG7EahhuTlu7QuRrhPIFH6Iin+NjIizLnIAtA
	ppnKYpEeDA82uvTrHQS0IwRuXfoh7QufKsIanSvliRyBsWIybMQXdRc9BrTi0XmF+aNF5di+2M/
	ujypVXe1cOXHaDt8pos8k0ZdV199da3XB0HRHISabAxEGvMa8WcFP3HCpVqCfeI5uK9gp+vJbif
	9ktr+yf9cU/0aR5jNZbvok0F5xciskycKuxwdhjYueXnoKqS4HkZyoVu462uZRh+zUKInmA35FD
	4tQpQ5RouGBiYbKoLJL6h8ZA399ZfxMkia8upngPsIidMzAAjCzbtoHw+3ZjWczlaQmqudnj4Uz
	Xvn/Lmb5UFv9y9yHdqu31uSN0DIYU=
X-Received: by 2002:a05:600c:524f:b0:46e:4c67:ff17 with SMTP id 5b1f17b1804b1-471178a6fa9mr95682415e9.14.1760986852334;
        Mon, 20 Oct 2025 12:00:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeBVtTe54kGHudQUvmPQThqNcAHiithbRT8ALDQPVgYD+ACEn42WaNaOAZe32RO2rz4EUwSQ==
X-Received: by 2002:a05:600c:524f:b0:46e:4c67:ff17 with SMTP id 5b1f17b1804b1-471178a6fa9mr95682195e9.14.1760986851909;
        Mon, 20 Oct 2025 12:00:51 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144d17cdsm241227075e9.18.2025.10.20.12.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:00:51 -0700 (PDT)
Message-ID: <5bd1d360-bee0-4fa2-80c8-476519e98b00@redhat.com>
Date: Mon, 20 Oct 2025 21:00:50 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: O_DIRECT vs BLK_FEAT_STABLE_WRITES, was Re: [PATCH] btrfs: never
 trust the bio from direct IO
To: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, martin.petersen@oracle.com, jack@suse.com
References: <1ee861df6fbd8bf45ab42154f429a31819294352.1760951886.git.wqu@suse.com>
 <aPYIS5rDfXhNNDHP@infradead.org>
 <56o3re2wspflt32t6mrfg66dec4hneuixheroax2lmo2ilcgay@zehhm5yaupav>
 <aPYgm3ey4eiFB4_o@infradead.org>
 <mciqzktudhier5d2wvjmh4odwqdszvbtcixbthiuuwrufrw3cj@5s2ffnffu4gc>
 <aPZOO3dFv61blHBz@casper.infradead.org>
 <xc2orfhavfqaxrmxtsbf4kepglfujjodvhfzhzfawwaxlyrhlb@gammchkzoh2m>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <xc2orfhavfqaxrmxtsbf4kepglfujjodvhfzhzfawwaxlyrhlb@gammchkzoh2m>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.10.25 17:58, Jan Kara wrote:
> On Mon 20-10-25 15:59:07, Matthew Wilcox wrote:
>> On Mon, Oct 20, 2025 at 03:59:33PM +0200, Jan Kara wrote:
>>> The idea was to bounce buffer the page we are writing back in case we spot
>>> a long-term pin we cannot just wait for - hence bouncing should be rare.
>>> But in this more general setting it is challenging to not bounce buffer for
>>> every IO (in which case you'd be basically at performance of RWF_DONTCACHE
>>> IO or perhaps worse so why bother?). Essentially if you hand out the real
>>> page underlying the buffer for the IO, all other attemps to do IO to that
>>> page have to block - bouncing is no longer an option because even with
>>> bouncing the second IO we could still corrupt data of the first IO once we
>>> copy to the final buffer. And if we'd block waiting for the first IO to
>>> complete, userspace could construct deadlock cycles - like racing IO to
>>> pages A, B with IO to pages B, A. So far I'm not sure about a sane way out
>>> of this...
>>
>> There isn't one.  We might have DMA-mapped this page earlier, and so a
>> device could write to it at any time.  Even if we remove PTE write
>> permissions ...
> 
> True but writes through DMA to the page are guarded by holding a page pin
> these days so we could in theory block getting another page pin or mapping
> the page writeably until the pin is released... if we can figure out a
> convincing story for dealing with long-term pins from RDMA and dealing with
> possible deadlocks created by this.

Just FYI, because it might be interesting in this context.

For anonymous memory we have this working by only writing the folio out 
if it is completely unmapped and there are no unexpected folio 
references/pins (see pageout()), and only allowing to write to such a 
folio ("reuse") if SWP_STABLE_WRITES is not set (see do_swap_page()).

So once we start writeback the folio has no writable page table mappings 
(unmapped) and no GUP pins. Consequently, when trying to write to it we 
can just fallback to creating a page copy without causing trouble with 
GUP pins.

-- 
Cheers

David / dhildenb


