Return-Path: <linux-fsdevel+bounces-19869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383D78CA7D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 08:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58233282A17
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 06:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D538B433AB;
	Tue, 21 May 2024 06:13:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8707F
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 06:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716271993; cv=none; b=HtPz9B8UAJoqQ86GfzWG0OoKLNslHN1W1n3wF+PLCUh1RTloeO2k+jsrdM/iMgGAj3Dxl/REldCYXwp8S2FJRdttE7nkhdADB7Kfmn0dJ0o+Gk0YMskKVIu+8eMwnjfBdju1n6m5o4SRaYhyTxj9/qx6OkbpPhW+L2gcMiIwXFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716271993; c=relaxed/simple;
	bh=AZFHbuTdGaCSZ6k/McNf8KlRXK5KRnfmkteF+aB3EXg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=scctYw5bC/hxBCNrxiAJDfGhJULSk8KzYZTPEK7qWp/WktdMAwmBwYjHtnhkgcnqRi8KD2cEvrLPL/no9b45WOU9XU/jGpkc9dlxx9110vtRRLOlCLrRnzRfH+5aiE3MryeT1b1FObTdYvxyxyUUGmbhAbVKlp3HHddcOZdM/xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a620a28e95cso103124866b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 23:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716271990; x=1716876790;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wg0lac5uINi1B571A6fUMZG3mduELkacrwqBmHYZJpo=;
        b=w0hrA98JdDtGQ1XEBSwjmHBIcx4ZZSrfWIkOfaINH5v+6utQxeTqe4FbldcjEMd52f
         8PHnduzFn0E3TJLhywAcVroEGcVCmi+LdKXwIZ8LnvC8krH3h//iGTrNFhljD3GQrOoE
         YxeHGFV1x/a98egaSRiQUCLzb34qGDNnQorLwMWFtGxw3+y9LPOrHmciRkVJRBcH1X58
         39arRItW3QDwQUzRd29EbUu+EGi5rebsbNcCYmMTUVhN2sHw0x7mOHbrlI7pqQX1E81b
         dkiMY+CsQXOqPAHsDfexxpk6ygVQ3wK0YMKQfvZLGOPnBPrcFoZIDtydZFGfU3ezHcXL
         6o/w==
X-Forwarded-Encrypted: i=1; AJvYcCVCVi56yXE+rAGFtNi2ask3aBXPtK81nOuyhethrn/xYVzsOgZIwQXEpvpQkoc0rTxWBRwGmlP+8PSi4F2Mj08Dy4OY7MZMPvZpP99HKA==
X-Gm-Message-State: AOJu0Yx4ntrqDAUHNmTPR4xwJr1yBxmNKso2y75ojUL3EjV4Z9akAvKW
	k9weDZHLzUmNz8UGKMkbxdy+urIzLVtysZxPwveWYOJJ5WyqVggK
X-Google-Smtp-Source: AGHT+IFadwYXJsVbSGuqJyR02ZBctNIijgA9dnIwnowBbBRsEY5gznCZ9+Xg+sVLAdHhBSUrnvsLjA==
X-Received: by 2002:a17:906:6a0e:b0:a5a:7cfe:30e9 with SMTP id a640c23a62f3a-a5a7cfe31b2mr1686140566b.49.1716271989983;
        Mon, 20 May 2024 23:13:09 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d48dsm1556578766b.5.2024.05.20.23.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 23:13:09 -0700 (PDT)
Message-ID: <0bbf8e1d-0590-4e42-91b2-7a35614319d3@kernel.org>
Date: Tue, 21 May 2024 08:13:08 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
From: Jiri Slaby <jirislaby@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Seth Forshee
 <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <210098f9-1e71-48c9-be08-7e8074ec33c1@kernel.org>
 <20240515-anklopfen-ausgleichen-0d7c220b16f4@brauner>
 <a15b1050-4b52-4740-a122-a4d055c17f11@kernel.org>
 <a65b573a-8573-4a17-a918-b5cf358c17d6@kernel.org>
 <84bc442d-c4dd-418e-8020-e1ff987cad13@kernel.org>
 <CAHk-=whMVsvYD4-OZx20ZR6zkOPoeMckxETxtqeJP2AAhd=Lcg@mail.gmail.com>
 <d2805915-5cf0-412e-a8e3-04ff1b18b315@kernel.org>
 <CAHk-=wh68QbOZi_rYaKiydsRDnYHEaCsvK6FD83-vfE6SXg5UA@mail.gmail.com>
 <CAHk-=whgMGb0qM638KfBaa2AA9TR95D3oHJTu6=5YtRoBVWa3g@mail.gmail.com>
 <e983a37b-9eb3-4b53-8f02-d671281f82f9@kernel.org>
Content-Language: en-US
Autocrypt: addr=jirislaby@kernel.org; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSFKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAa2VybmVsLm9yZz7CwXcEEwEIACEFAlW3RUwCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AACgkQvSWxBAa0cEnVTg//TQpdIAr8Tn0VAeUjdVIH9XCFw+cPSU+zMSCH
 eCZoA/N6gitEcnvHoFVVM7b3hK2HgoFUNbmYC0RdcSc80pOF5gCnACSP9XWHGWzeKCARRcQR
 4s5YD8I4VV5hqXcKo2DFAtIOVbHDW+0okOzcecdasCakUTr7s2fXz97uuoc2gIBB7bmHUGAH
 XQXHvdnCLjDjR+eJN+zrtbqZKYSfj89s/ZHn5Slug6w8qOPT1sVNGG+eWPlc5s7XYhT9z66E
 l5C0rG35JE4PhC+tl7BaE5IwjJlBMHf/cMJxNHAYoQ1hWQCKOfMDQ6bsEr++kGUCbHkrEFwD
 UVA72iLnnnlZCMevwE4hc0zVhseWhPc/KMYObU1sDGqaCesRLkE3tiE7X2cikmj/qH0CoMWe
 gjnwnQ2qVJcaPSzJ4QITvchEQ+tbuVAyvn9H+9MkdT7b7b2OaqYsUP8rn/2k1Td5zknUz7iF
 oJ0Z9wPTl6tDfF8phaMIPISYrhceVOIoL+rWfaikhBulZTIT5ihieY9nQOw6vhOfWkYvv0Dl
 o4GRnb2ybPQpfEs7WtetOsUgiUbfljTgILFw3CsPW8JESOGQc0Pv8ieznIighqPPFz9g+zSu
 Ss/rpcsqag5n9rQp/H3WW5zKUpeYcKGaPDp/vSUovMcjp8USIhzBBrmI7UWAtuedG9prjqfO
 wU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02XFTI
 t4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P+nJW
 YIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYVnZAK
 DiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNeLuS8
 f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+BavGQ
 8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUFBqgk
 3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpotgK4
 /57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPDGHo7
 39Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBKHQxz
 1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkFAk6S
 54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH/1ld
 wRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+Kzdr
 90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj9YLx
 jhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbcezWI
 wZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+dyTKL
 wLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330mkR4g
 W6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/tJ98
 f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCujlYQ
 DFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmffaK/
 S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
In-Reply-To: <e983a37b-9eb3-4b53-8f02-d671281f82f9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21. 05. 24, 8:07, Jiri Slaby wrote:
> On 20. 05. 24, 21:15, Linus Torvalds wrote:
>> On Mon, 20 May 2024 at 12:01, Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>> So how about just a patch like this?  It doesn't do anything
>>> *internally* to the inodes, but it fixes up what we expose to user
>>> level to make it look like lsof expects.
>>
>> Note that the historical dname for those pidfs files was
>> "anon_inode:[pidfd]", and that patch still kept the inode number in
>> there, so now it's "anon_inode:[pidfd-XYZ]", but I think lsof is still
>> happy with that.
> 
> Now the last column of lsof still differs from 6.8:
> -[pidfd:1234]
> +[pidfd-4321]
> 
> And lsof tests still fail, as "lsof -F pfn" is checked against:
>      if ! fgrep -q "p${pid} f${fd} n[pidfd:$pid]" <<<"$line"; then
> 
> Where $line is:
> p1015 f3 n[pidfd-1315]
> 
> Wait, even if I change that minus to a colon, the inner pid (1315) 
> differs from the outer (1015), but it should not (according to the test).

This fixes the test (meaning literally "it shuts up the test", but I 
have no idea if it is correct thing to do at all):
-       return dynamic_dname(buffer, buflen, "anon_inode:[pidfd-%llu]", 
pid->ino);
+       return dynamic_dname(buffer, buflen, "anon_inode:[pidfd:%d]", 
pid_nr(pid));

Maybe pid_vnr() would be more appropriate, I have no idea either.

> regards,-- 
-- 
js
suse labs


