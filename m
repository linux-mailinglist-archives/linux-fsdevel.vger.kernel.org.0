Return-Path: <linux-fsdevel+bounces-15125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64374887459
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 22:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828BE1C21F62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 21:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EC37FBBE;
	Fri, 22 Mar 2024 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JTaoRMX/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8504254789
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711141699; cv=none; b=UFe9YO6THxABMzL5ws+YSS4IiLfWhi1sXV4AO1shp24hN468aRz8dFlOgpWoJwtDMNssIubXnwaPBKD/T5lSq0V5pt7NMoHo5BoZUyn3YEiJJhaKz9tOIPJZSpzb+FzcMJLR2wS6Elbfm1Vuptuq8jIYxLzQF5Lrz3cldnu2KJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711141699; c=relaxed/simple;
	bh=7bbkXmCFQ4OWr7vuwL2hdtfUydIBGnv/JiHHvfBy8j4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iWLmDVQD0OFfr19WXhAaiAvXcnQjzgI/QVLUBhF7yVzoJwadNcGrqe4ZNAK1rb5ySj2Ifs440hthkyuAbCE8snh6itcigPrEKSY8Rm5tJ82TdCsobmKX3kkd7lX7PIfkvYmpjltLmvRZN6QlV4Z9nnICW5XhazgMFAXV+0CcnVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JTaoRMX/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711141696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=W9yBOHIspA4oniBbLxvN2P2AZN3ty6uPfcO/Jmwe2dY=;
	b=JTaoRMX/oCcwnIdzxCBNPGgbMa51+QF4zj76Q6zmPrAqrl2SDvjvQqEQEqonoCNcXnZmOE
	5tDKB3yFUUMJzJY3SULCCDsOow8td1aewrViNLVsEhJdilQtEJEYSIk6P8GHFxPGrPgYOh
	1GZQ62OVPW4N6tnXBWLzWuNp373wEe0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-W2OQH7NhMNO2vQabExOVzA-1; Fri, 22 Mar 2024 17:08:15 -0400
X-MC-Unique: W2OQH7NhMNO2vQabExOVzA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33ed22e92c2so1167701f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 14:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711141694; x=1711746494;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9yBOHIspA4oniBbLxvN2P2AZN3ty6uPfcO/Jmwe2dY=;
        b=NC3gSP9359n1UZztcbpt0z3k457Y4F48ScjmYd61OQ6T7Bnx1W0GTCPcpIDAitlPWo
         k+KFsgoDJHAryTiMUOHkcfLYNf6Vcws4GY/4ZcwY8VSFVDLXrS3bABI4V0nFkB7uJbl+
         Defpk8R5B2d47t/Pm9Pyym3qanPPyNmslw+Pcmqhmu6uSm4mkmagt/gpUdDAhwTwaoGr
         7yAIV+IBB35BLhTJfmWNIoEKfrp6KuMz/g5Mf80eWxuHhzsDm5TJn1sKJSiSERrAFx4U
         0sxpdcryKZG3Jy9HJ75XQzlWFux2gpHYv690m/h+/dwKgfxLLCM1yS7psloqDUIwHSlx
         oiTw==
X-Forwarded-Encrypted: i=1; AJvYcCVZr1i1kJXjIubAB2x3KHaw+sW+ftvLPKH4TQyAOE46VunUKLseJt02Qft99Ojvv7VPsDF1PABh7l049YGiZLgB+5gdxZ4IjKySq9HnMA==
X-Gm-Message-State: AOJu0Yzr5LiUZwZSOkZ7+1ib363J1s74BCuseI3c88nLFn0JD5N4oVFe
	EfSz71xkNXMU9GWQUmA82PBSJW2kg5Gf8EkPUFT9lt6b21epwqK+wHN4M2tFt6LM0NLbTwWlgem
	lvVa6QDK5PljjftTZh/3of6f7UG3Ui2jyVjYMqG/ii0xknzERnNbpeewre1znYzY=
X-Received: by 2002:a5d:5341:0:b0:33e:7b3d:8efa with SMTP id t1-20020a5d5341000000b0033e7b3d8efamr347795wrv.49.1711141693813;
        Fri, 22 Mar 2024 14:08:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiD5qamEUC57/BSOEaLBJW7EjJCXge1k9tkIrMxrQz1rzb44+Qc20msJjGOI8fx0esDjZOTQ==
X-Received: by 2002:a5d:5341:0:b0:33e:7b3d:8efa with SMTP id t1-20020a5d5341000000b0033e7b3d8efamr347786wrv.49.1711141693391;
        Fri, 22 Mar 2024 14:08:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71b:7e00:9339:4017:7111:82d0? (p200300cbc71b7e0093394017711182d0.dip0.t-ipconnect.de. [2003:cb:c71b:7e00:9339:4017:7111:82d0])
        by smtp.gmail.com with ESMTPSA id s17-20020adfa291000000b00341b7388dafsm2152359wra.77.2024.03.22.14.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 14:08:13 -0700 (PDT)
Message-ID: <620f68b0-4fe0-4e3e-856a-dedb4bcdf3a7@redhat.com>
Date: Fri, 22 Mar 2024 22:08:11 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: unable to handle kernel paging request in fuse_copy_do
Content-Language: en-US
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: xingwei lee <xrivendell7@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, samsun1006219@gmail.com,
 syzkaller-bugs@googlegroups.com, linux-mm <linux-mm@kvack.org>,
 Mike Rapoport <rppt@kernel.org>
References: <CABOYnLyevJeravW=QrH0JUPYEcDN160aZFb7kwndm-J2rmz0HQ@mail.gmail.com>
 <CAJfpegu8qTARQBftZSaiif0E6dbRcbBvZvW7dQf8sf_ymoogCA@mail.gmail.com>
 <c58a8dc8-5346-4247-9a0a-8b1be286e779@redhat.com>
 <CAJfpegt3UCsMmxd0taOY11Uaw5U=eS1fE5dn0wZX3HF0oy8-oQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJfpegt3UCsMmxd0taOY11Uaw5U=eS1fE5dn0wZX3HF0oy8-oQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.03.24 20:46, Miklos Szeredi wrote:
> On Fri, 22 Mar 2024 at 16:41, David Hildenbrand <david@redhat.com> wrote:
> 
>> But at least the vmsplice() just seems to work. Which is weird, because
>> GUP-fast should not apply (page not faulted in?)
> 
> But it is faulted in, and that indeed seems to be the root cause.

secretmem mmap() won't populate the page tables. So it's not faulted in yet.

When we GUP via vmsplice, GUP-fast should not find it in the page tables 
and fallback to slow GUP.

There, we seem to pass check_vma_flags(), trigger faultin_page() to 
fault it in, and then find it via follow_page_mask().

... and I wonder how we manage to skip check_vma_flags(), or otherwise 
managed to GUP it.

vmsplice() should, in theory, never succeed here.

Weird :/

> Improved repro:
> 
> #define _GNU_SOURCE
> 
> #include <fcntl.h>
> #include <unistd.h>
> #include <stdio.h>
> #include <errno.h>
> #include <sys/mman.h>
> #include <sys/syscall.h>
> 
> int main(void)
> {
>          int fd1, fd2;
>          int pip[2];
>          struct iovec iov;
>          char *addr;
>          int ret;
> 
>          fd1 = syscall(__NR_memfd_secret, 0);
>          addr = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd1, 0);
>          ftruncate(fd1, 7);
>          addr[0] = 1; /* fault in page */
>          pipe(pip);
>          iov.iov_base = addr;
>          iov.iov_len = 0x50;
>          ret = vmsplice(pip[1], &iov, 1, 0);
>          if (ret == -1 && errno == EFAULT) {
>                  printf("Success\n");
>                  return 0;
>          }
> 
>          fd2 = open("/tmp/repro-secretmem.test", O_RDWR | O_CREAT, 0x600);
>          splice(pip[0], NULL, fd2, NULL, 0x50, 0);
> 
>          return 0;
> }
> 

-- 
Cheers,

David / dhildenb


