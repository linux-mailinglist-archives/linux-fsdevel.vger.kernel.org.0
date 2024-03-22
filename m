Return-Path: <linux-fsdevel+bounces-15106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9B6886FE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 16:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4BB28485E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 15:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925085674E;
	Fri, 22 Mar 2024 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hkCXWGee"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D1C53395
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122086; cv=none; b=SgD/g4bxIMdtsOgeaj0ysI10VcTXMpGt/Qhp4yqoRwm4dDTHjqnvcxQ2KIjajqulWUP3uLyOvZID/i/iVAp0c3RXCzwazVkx+42aOodLpAiiytOxHOSIx4IeiINN0gXEXtBs0GvuD44uD2IEdMlOIj4Nke44Q3rr3MXzDbmnksg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122086; c=relaxed/simple;
	bh=y13MM1K4OSGBVcRaem6p++srNkOtksqVqY0eJhSarzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XR/sR9qJnGTVwiw49SR4dw6NIIca1CeLufRyjUc7OcwDUSOnIi3VReAcg2bqO3tq+rcfry6wPrnyJE7LRrN/qfQtlz8orsNpxoCuAoyEWmlNpY8UKAitKwqa/Z4oIt3fhWg4x/fREmnz6qZKlxuOqgYbVqdGGc2OCVwi/hLC2Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hkCXWGee; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711122083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lzS+64/Z+z0FZAVLEztU47CybRWXv4MUKpFPGMTiPTs=;
	b=hkCXWGee7Svyt6xx06PCyk0iOJDV01i1KVWvIhcWtysrWwgJxOyQblZm/b7FGtq57P5V9N
	KjIbvs/sofANGxPXOIQ68qgA7GQh1sB3aXhkXvJ3oeAWgzD2dFRDej/+KI+iJrewC5djSz
	Ql8GmLmwAOjo1+qdfpa+TqJAhnncJT4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-wLumF-eaOwSYfIQCrXq0jQ-1; Fri, 22 Mar 2024 11:41:21 -0400
X-MC-Unique: wLumF-eaOwSYfIQCrXq0jQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33ecf15c037so1521869f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 08:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711122079; x=1711726879;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzS+64/Z+z0FZAVLEztU47CybRWXv4MUKpFPGMTiPTs=;
        b=o6wLXXI+vYZ4HAAylr9Yh1uQi9jTPUQTD4YKQlNnRixLNDpvi740/sc/NdS2fNHatH
         7TZ8HkUtxhmAFq3GKNEu6oWpjApTvaTIsj/ICLdyNRvom4CnGqLWIQaI2VpFyQnAyWan
         ZFHGQPVkBPT4ICjKo8DffprHYUSGd3RylBoFt8AD+gT9SjRDG/9LbXQlOqi7uwnsiWnG
         3F/u/r5hUxonrZlsYLFBvMs+S15NtwSeWg0oqA21btm2TATTDupz93Gz2GwmyCw9A+PR
         l8SHpUR51wXiDt+09EcJpu9JrX7AlHyvBM6Yq8slNyMBIwBLgkctFTtplIiZ0LWCpFzW
         IkeQ==
X-Gm-Message-State: AOJu0YywZr9xrnL/xUgOC3JlBalNvymPFTIYziwBe8bN9qImq347jxo+
	Jn3iZIAAiHO0LTYpWZZRdQj+v9iVPZkg93RxHehW3P2upCuk4XHfZ9cAvij63TlX4kZg2bA3O79
	37Oy+5zRdZUHwW0Z5ch9H7Nfjg8XGBm0aAr1Ius8Tx2MvgdlVTBUS3H/uDZaw/7U=
X-Received: by 2002:a05:600c:458e:b0:414:e72:63b1 with SMTP id r14-20020a05600c458e00b004140e7263b1mr2379789wmo.3.1711122079485;
        Fri, 22 Mar 2024 08:41:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXOLZtKDEsBtChWDKIGyOSkyUFxGexBUunkAhaBF4wHd60YlS7SUyfnMOUyNbAZMW6SJYoYg==
X-Received: by 2002:a05:600c:458e:b0:414:e72:63b1 with SMTP id r14-20020a05600c458e00b004140e7263b1mr2379773wmo.3.1711122079081;
        Fri, 22 Mar 2024 08:41:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71b:7e00:9339:4017:7111:82d0? (p200300cbc71b7e0093394017711182d0.dip0.t-ipconnect.de. [2003:cb:c71b:7e00:9339:4017:7111:82d0])
        by smtp.gmail.com with ESMTPSA id c20-20020a05600c0a5400b004147db8a91asm1563396wmq.40.2024.03.22.08.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 08:41:18 -0700 (PDT)
Message-ID: <c58a8dc8-5346-4247-9a0a-8b1be286e779@redhat.com>
Date: Fri, 22 Mar 2024 16:41:17 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: unable to handle kernel paging request in fuse_copy_do
Content-Language: en-US
To: Miklos Szeredi <miklos@szeredi.hu>, xingwei lee <xrivendell7@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 samsun1006219@gmail.com, syzkaller-bugs@googlegroups.com,
 linux-mm <linux-mm@kvack.org>, Mike Rapoport <rppt@kernel.org>
References: <CABOYnLyevJeravW=QrH0JUPYEcDN160aZFb7kwndm-J2rmz0HQ@mail.gmail.com>
 <CAJfpegu8qTARQBftZSaiif0E6dbRcbBvZvW7dQf8sf_ymoogCA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJfpegu8qTARQBftZSaiif0E6dbRcbBvZvW7dQf8sf_ymoogCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.03.24 14:50, Miklos Szeredi wrote:
> [MM list + secretmem author CC-d]
> 
> On Thu, 21 Mar 2024 at 08:52, xingwei lee <xrivendell7@gmail.com> wrote:
>>
>> Hello I found a bug titled "BUG: unable to handle kernel paging
>> request in fuse_copy_do” with modified syzkaller, and maybe it is
>> related to fs/fuse.
>> I also confirmed in the latest upstream.
>>
>> If you fix this issue, please add the following tag to the commit:
>> Reported-by: xingwei lee <xrivendell7@gmail.com>
>> Reported-by: yue sun <samsun1006219@gmail.com>
> 
> Thanks for the report.   This looks like a secretmem vs get_user_pages issue.
> 
> I reduced the syz reproducer to a minimal one that isn't dependent on fuse:
> 
> === repro.c ===
> #define _GNU_SOURCE
> 
> #include <fcntl.h>
> #include <unistd.h>
> #include <sys/mman.h>
> #include <sys/syscall.h>
> #include <sys/socket.h>
> 
> int main(void)
> {
>          int fd1, fd2, fd3;
>          int pip[2];
>          struct iovec iov;
>          void *addr;
> 
>          fd1 = syscall(__NR_memfd_secret, 0);
>          addr = mmap(NULL, 4096, PROT_READ, MAP_SHARED, fd1, 0);
>          ftruncate(fd1, 7);
>          fd2 = socket(AF_INET, SOCK_DGRAM, 0);
>          getsockopt(fd2, 0, 0, NULL, addr);
> 
>          pipe(pip);
>          iov.iov_base = addr;
>          iov.iov_len = 0x50;
>          vmsplice(pip[1], &iov, 1, 0);

pip[1] should be the write end. So it will be used as the source.

I assume we go the ITER_SOURCE path in vmsplice, and call 
vmsplice_to_pipe(). Then we call iter_to_pipe().

I would expect iov_iter_get_pages2() -> get_user_pages_fast() to fail on 
secretmem pages?

But at least the vmsplice() just seems to work. Which is weird, because 
GUP-fast should not apply (page not faulted in?) and check_vma_flags() 
bails out early on vma_is_secretmem(vma).

So something is not quite right.

> 
>          fd3 = open("/tmp/repro-secretmem.test", O_RDWR | O_CREAT, 0x600);
>          splice(pip[0], NULL, fd3, NULL, 0x50, 0);
> 
>          return 0;
> }




-- 
Cheers,

David / dhildenb


