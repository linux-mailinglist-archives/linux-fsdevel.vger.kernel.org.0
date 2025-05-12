Return-Path: <linux-fsdevel+bounces-48774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE12AB46EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 23:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F424A2739
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 21:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C6A29A310;
	Mon, 12 May 2025 21:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpWMouRO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E111295DAB
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747087174; cv=none; b=MuPmt1vTcSBloqvuC3Vnhl1c3o6KQ7qCd04NuIeVxH8i5yNuKZnReljeOSRx86YMC5CT2C6xFwmsT98AJWX+gUzpG89X0j/3ZKwMt+G6TY2HOwysfsP0dAk5pTUQKlEdwHu76Dvzo8+jIMsbdD0wVSLQpfCp/5VuIzuuSk2Zr1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747087174; c=relaxed/simple;
	bh=xkYHrqmdQlLIXwChgymo7Naf+IJIZhZ+EQbUpaq9llc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IulfHZLpN0bTQH+zdbNFKZxWZ+noJM8JWl2KSf8KLx+IaIuaMFL9s/dEIepw9gYQgcvaA1FfH1axUKXFu5UxiszlIHwthqdyL5sTIOAqzGz3lOy8PLrMuw9iOIbxJlbmp11s8TY6ka4PkBImjXPwW7mqpyhG1bc6ANy9J7AIiB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OpWMouRO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747087171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WIa9wdCgF8ndkq4uSm4Tu2qsgVXpc321rtvVy6nGMgo=;
	b=OpWMouROf4uHCvcZHcTOjqbcvh0Zzhwe3pc4w2L+VohiKlMtdlG81SrhNJuzGU0nh3mIWm
	leO418/gVRJ8UYYdDBhp/tFqpwJAgkjZrav0hQFYenQWy73HK1v7lApWBAt/7WYv0IR0EM
	e8Suxs6JFnjE6MwlEAj+yQH0JVZ4qMg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-aGHz20TmNeG0_Z3WbrgNBg-1; Mon, 12 May 2025 17:59:29 -0400
X-MC-Unique: aGHz20TmNeG0_Z3WbrgNBg-1
X-Mimecast-MFC-AGG-ID: aGHz20TmNeG0_Z3WbrgNBg_1747087168
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a0b7cd223fso2795176f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 14:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747087168; x=1747691968;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WIa9wdCgF8ndkq4uSm4Tu2qsgVXpc321rtvVy6nGMgo=;
        b=oQvN15Utzs0lXWyQuY1XYjRmB3E1uCEy+9aXEP+SZJQ3ndrs22qRhRBIbzT6GMjAtN
         osAXpstvMAhTmDKeOyCL6GIJk866BckCw7wWx5ZOwcQ24fcAMd2KBHVa8ErJa1ZQzqlr
         NZb5nRRkOJgV5tPHogXoDY7EQSEJBkWRReDMepNwdBtZdoDMmq+/0SteHePvuFzseSF4
         2Qh+ax8peqBWBK48XW6w0i33c/f6qeD8oEqoqkqkOHhp/9PUZbt2ltt83CyPkXTeEfu5
         ZeCwUrdYHXX3qUMv7NO/pPPs+VptRM8gZ1VN3FzUu6AQDh09JQfnXBdm3tOq1NBb+Bhi
         yC2A==
X-Forwarded-Encrypted: i=1; AJvYcCUK+GKhUxhu9AT5po3SEeW1YGl2wN6lv9+maALWpwLNhGZ2VMmyLdVmp6Df4zHsWGCDTgVzGcoOpGuezGJ9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4aIBPTvzSjDmUD/V6Aud7+UCm4pZ3ijZhOfwUasDdA4yz66Ne
	BWfgd9+ELCd/v3pXPxz2itiYnGmwJCQQOiXP54hPTjGFic0+YzpEZGuyca//dnCYwSAw50syrSZ
	k3I3hxiXpdxTXOG08l8ac172rO/85SEnyO03Lx0HhJT7hOc2lt0DQQID8tHA5H7E=
X-Gm-Gg: ASbGncv3BjjxlitRbWGqBxfPNXCkjwjGHAb4inSeOi9soxxS92b5yAWz9BMOIlOId6X
	+nZqb3gwblLrSouKtP2mJrrwy3nhptT5Bu/7x4k25ALRV0Sq8GpP7Kmkfc2cQSmyu8DgBSjclgq
	Xkn930Gmy7Hg7xrt3PHkAtyhBXR44xNFlMynj+iva38P3zMjqWF2fJUmtbirv9Bs0VmZXRt7Sfa
	oGB6htwLNAq1SvPG1nyl9rHjn2jKyFe/wBph1IlDFTyKN5jGLAhuaGjAQJPIqwP/nTgz9qyR/0C
	KFQCgZBLhkHUuf8+Cw5aMhc/okdhFZNWwkaWZEulJWjOJj1XaDl46szq+H8hHxAM6OGh/QMtgAo
	qA3Chpc0Y6/BH91zBJg2FklVOf7rVVkYuBeZRLx8=
X-Received: by 2002:a5d:588a:0:b0:3a0:b2ff:fb00 with SMTP id ffacd0b85a97d-3a1f64b4557mr10225487f8f.44.1747087167682;
        Mon, 12 May 2025 14:59:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXZLVEy2AMg6+TJB/yJT5QNmiZbsx9yvU/SgKIjl83sV/WZpbpykp3nPL4GY/l6Cs/+499AA==
X-Received: by 2002:a5d:588a:0:b0:3a0:b2ff:fb00 with SMTP id ffacd0b85a97d-3a1f64b4557mr10225466f8f.44.1747087167294;
        Mon, 12 May 2025 14:59:27 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4a:5800:f1ae:8e20:d7f4:51b0? (p200300d82f4a5800f1ae8e20d7f451b0.dip0.t-ipconnect.de. [2003:d8:2f4a:5800:f1ae:8e20:d7f4:51b0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c5a4sm13747072f8f.81.2025.05.12.14.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 14:59:26 -0700 (PDT)
Message-ID: <bb31c07a-0b70-4bca-9c59-42f6233791cd@redhat.com>
Date: Mon, 12 May 2025 23:59:24 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AF_UNIX/zerocopy/pipe/vmsplice/splice vs FOLL_PIN
To: David Howells <dhowells@redhat.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 John Hubbard <jhubbard@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 willy@infradead.org, Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <mszeredi@redhat.com>,
 torvalds@linux-foundation.org, netdev@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1069540.1746202908@warthog.procyon.org.uk>
 <165f5d5b-34f2-40de-b0ec-8c1ca36babe8@lunn.ch>
 <0aa1b4a2-47b2-40a4-ae14-ce2dd457a1f7@lunn.ch>
 <1015189.1746187621@warthog.procyon.org.uk>
 <1021352.1746193306@warthog.procyon.org.uk>
 <2135907.1747061490@warthog.procyon.org.uk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2135907.1747061490@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.05.25 16:51, David Howells wrote:
> I'm looking at how to make sendmsg() handle page pinning - and also working
> towards supporting the page refcount eventually being removed and only being
> available with certain memory types.
> 
> One of the outstanding issues is in sendmsg().  Analogously with DIO writes,
> sendmsg() should be pinning memory (FOLL_PIN/GUP) rather than simply getting
> refs on it before it attaches it to an sk_buff.  Without this, if memory is
> spliced into an AF_UNIX socket and then the process forks, that memory gets
> attached to the child process, and the child can alter the data

That should not be possible. Neither the child nor the parent can modify 
the page. Any write attempt will result in Copy-on-Write.

The issue is that if the parent writes to some unrelated part of the 
page after fork() but before DIO completed, the parent will trigger 
Copy-on-Write and the DIO will essentially be lost from the parent's POV 
(goes to the wrong page).


> probably by
> accident, if the memory is on the stack or in the heap.
> 
> Further, kernel services can use MSG_SPLICE_PAGES to attach memory directly to
> an AF_UNIX pipe (though I'm not sure if anyone actually does this).
> 
> (For writing to TCP/UDP with MSG_ZEROCOPY, MSG_SPLICE_PAGES or vmsplice, I
> think we're probably fine - assuming the loopback driver doesn't give the
> receiver the transmitter's buffers to use directly...  This may be a big
> 'if'.)
> 
> Now, this probably wouldn't be a problem, but for the fact that one can also
> splice this stuff back *out* of the socket.
> 
> The same issues exist for pipes too.
> 
> The question is what should happen here to a memory span for which the network
> layer or pipe driver is not allowed to take reference, but rather must call a
> destructor?  Particularly if, say, it's just a small part of a larger span.
> 
> It seems reasonable that we should allow pinned memory spans to be queued in a
> socket or a pipe - that way, we only have to copy the data once in the event
> that the data is extracted with read(), recvmsg() or similar.  But if it's
> spliced out we then have all the fun of managing the lifetime - especially if
> it's a big transfer that gets split into bits.  In such a case, I wonder if we
> can just duplicate the memory at splice-out rather than trying to keep all the
> tracking intact.
> 
> If the memory was copied in, then moving the pages should be fine - though the
> memory may not be of a ref'able type (which would be fun if bits of such a
> page get spliced to different places).
> 
> I'm sure there is some app somewhere (fuse maybe?) where this would be a
> performance problem, though.
> 
> And then there's vmsplice().  The same goes for vmsplice() to AF_UNIX or to a
> pipe.  That should also pin memory.  It may also be possible to vmsplice a
> pinned page into the target process's VM or a page from a memory span with
> some other type of destruction.

IIRC, vmsplice() never does that optimization for that direction (map 
pinned page into the target process). It would be a mess.

But yes, vmsplice() should be using FOLL_PIN|FOLL_LONGTERM. Deprecation 
is unlikely to happen, I'm afraid :(

-- 
Cheers,

David / dhildenb


