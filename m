Return-Path: <linux-fsdevel+bounces-48544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 167EEAB0CBA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 10:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13433B5549
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 08:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FA7275873;
	Fri,  9 May 2025 08:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="g3KKrjEa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A910A275853;
	Fri,  9 May 2025 08:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746778077; cv=none; b=dwdhjBns061JM3dLj+6lsp6J97bswPJOs80Na7LpPBfS6dEM8K96lueMGwayv4LjJRfiRIPwJEqrAvpA/T8k7Gu5kyeRSIzhFI93O6a7V/+ZCLhmG9eP593jz62rMKjza6kzP03a34/qKanFtG/1KR/w6MRbQMJ4kz31E7g2peA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746778077; c=relaxed/simple;
	bh=/2DCihUuFwmoZxrKdC+JRy/5V4gBkiA6adC0eClbuGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Omf416xSrDayOZljCTtzZHz5vvROAo1S4pnPu8upSDAfxWcSipICMhWo00p94x5Ui0XvdAoY2NDWs/IyutPS+HiBUBS5JHykMNptzvKVzDnqv401aL1V9goXOpDlwg2Ohp4ls2tp1n1HfRW0LFruCu8eAAr2H195V1omOpmp1y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=g3KKrjEa; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=oNNfDvOs6y0PJfnxopMS9GjByoEElwkj5MIKaShj7rY=; b=g3KKrjEaG3HrFaGhY3iWdklu6Y
	0o9Qm7jiEgPi/9xs+4zkMM51vsI3BIhTeRVnsPkpSfSE9Dy9Hm1e5Y7A1oFFenPwSRUcg472Xa7nD
	R1WFQ97age8m/rX68VZuqVXTZPTkntpXu9unOkOeOOJJeUw4a2YUnRwFYYNbtRycn6PU7LZ+Vk5Fz
	py0LemTfXamjF4/dqSHv/TnI2ZrC6gEQQSHs1OLiLWY99AAlMuorqvxtxJ6ti28/EFJtnHWHi2npv
	BQ4aa0s+Utz17ACf5lmsjl4aIsi1sUItwBQE8Vaqxonyfo1aMhmY/op6Lh32GRWNN1YsAVkC8J4DM
	9RyWWxNw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uDIlf-0003GA-2d;
	Fri, 09 May 2025 10:07:40 +0200
Received: from [85.195.247.12] (helo=[192.168.1.114])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1uDIlf-000Odb-0n;
	Fri, 09 May 2025 10:07:39 +0200
Message-ID: <ac9c25f0-9979-44ee-bcd7-74539aa8f1b5@iogearbox.net>
Date: Fri, 9 May 2025 10:07:37 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/11] net: reserve prefix
To: Christian Brauner <brauner@kernel.org>,
 Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alexander@mihalicyn.com, bluca@debian.org, daan.j.demeyer@gmail.com,
 davem@davemloft.net, david@readahead.eu, edumazet@google.com,
 horms@kernel.org, jack@suse.cz, jannh@google.com, kuba@kernel.org,
 lennart@poettering.net, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, me@yhndnzj.com, netdev@vger.kernel.org,
 oleg@redhat.com, pabeni@redhat.com, viro@zeniv.linux.org.uk,
 zbyszek@in.waw.pl
References: <20250508-vorboten-herein-4ee71336e6f7@brauner>
 <20250508214850.62973-1-kuniyu@amazon.com>
 <20250509-leinwand-leiht-f1031edf9c71@brauner>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 xsFNBGNAkI0BEADiPFmKwpD3+vG5nsOznvJgrxUPJhFE46hARXWYbCxLxpbf2nehmtgnYpAN
 2HY+OJmdspBntWzGX8lnXF6eFUYLOoQpugoJHbehn9c0Dcictj8tc28MGMzxh4aK02H99KA8
 VaRBIDhmR7NJxLWAg9PgneTFzl2lRnycv8vSzj35L+W6XT7wDKoV4KtMr3Szu3g68OBbp1TV
 HbJH8qe2rl2QKOkysTFRXgpu/haWGs1BPpzKH/ua59+lVQt3ZupePpmzBEkevJK3iwR95TYF
 06Ltpw9ArW/g3KF0kFUQkGXYXe/icyzHrH1Yxqar/hsJhYImqoGRSKs1VLA5WkRI6KebfpJ+
 RK7Jxrt02AxZkivjAdIifFvarPPu0ydxxDAmgCq5mYJ5I/+BY0DdCAaZezKQvKw+RUEvXmbL
 94IfAwTFA1RAAuZw3Rz5SNVz7p4FzD54G4pWr3mUv7l6dV7W5DnnuohG1x6qCp+/3O619R26
 1a7Zh2HlrcNZfUmUUcpaRPP7sPkBBLhJfqjUzc2oHRNpK/1mQ/+mD9CjVFNz9OAGD0xFzNUo
 yOFu/N8EQfYD9lwntxM0dl+QPjYsH81H6zw6ofq+jVKcEMI/JAgFMU0EnxrtQKH7WXxhO4hx
 3DFM7Ui90hbExlFrXELyl/ahlll8gfrXY2cevtQsoJDvQLbv7QARAQABzSZEYW5pZWwgQm9y
 a21hbm4gPGRhbmllbEBpb2dlYXJib3gubmV0PsLBkQQTAQoAOxYhBCrUdtCTcZyapV2h+93z
 cY/jfzlXBQJjQJCNAhsDBQkHhM4ACAsJCAcNDAsKBRUKCQgLAh4BAheAAAoJEN3zcY/jfzlX
 dkUQAIFayRgjML1jnwKs7kvfbRxf11VI57EAG8a0IvxDlNKDcz74mH66HMyhMhPqCPBqphB5
 ZUjN4N5I7iMYB/oWUeohbuudH4+v6ebzzmgx/EO+jWksP3gBPmBeeaPv7xOvN/pPDSe/0Ywp
 dHpl3Np2dS6uVOMnyIsvmUGyclqWpJgPoVaXrVGgyuer5RpE/a3HJWlCBvFUnk19pwDMMZ8t
 0fk9O47HmGh9Ts3O8pGibfdREcPYeGGqRKRbaXvcRO1g5n5x8cmTm0sQYr2xhB01RJqWrgcj
 ve1TxcBG/eVMmBJefgCCkSs1suriihfjjLmJDCp9XI/FpXGiVoDS54TTQiKQinqtzP0jv+TH
 1Ku+6x7EjLoLH24ISGyHRmtXJrR/1Ou22t0qhCbtcT1gKmDbTj5TcqbnNMGWhRRTxgOCYvG0
 0P2U6+wNj3HFZ7DePRNQ08bM38t8MUpQw4Z2SkM+jdqrPC4f/5S8JzodCu4x80YHfcYSt+Jj
 ipu1Ve5/ftGlrSECvy80ZTKinwxj6lC3tei1bkI8RgWZClRnr06pirlvimJ4R0IghnvifGQb
 M1HwVbht8oyUEkOtUR0i0DMjk3M2NoZ0A3tTWAlAH8Y3y2H8yzRrKOsIuiyKye9pWZQbCDu4
 ZDKELR2+8LUh+ja1RVLMvtFxfh07w9Ha46LmRhpCzsFNBGNAkI0BEADJh65bNBGNPLM7cFVS
 nYG8tqT+hIxtR4Z8HQEGseAbqNDjCpKA8wsxQIp0dpaLyvrx4TAb/vWIlLCxNu8Wv4W1JOST
 wI+PIUCbO/UFxRy3hTNlb3zzmeKpd0detH49bP/Ag6F7iHTwQQRwEOECKKaOH52tiJeNvvyJ
 pPKSKRhmUuFKMhyRVK57ryUDgowlG/SPgxK9/Jto1SHS1VfQYKhzMn4pWFu0ILEQ5x8a0RoX
 k9p9XkwmXRYcENhC1P3nW4q1xHHlCkiqvrjmWSbSVFYRHHkbeUbh6GYuCuhqLe6SEJtqJW2l
 EVhf5AOp7eguba23h82M8PC4cYFl5moLAaNcPHsdBaQZznZ6NndTtmUENPiQc2EHjHrrZI5l
 kRx9hvDcV3Xnk7ie0eAZDmDEbMLvI13AvjqoabONZxra5YcPqxV2Biv0OYp+OiqavBwmk48Z
 P63kTxLddd7qSWbAArBoOd0wxZGZ6mV8Ci/ob8tV4rLSR/UOUi+9QnkxnJor14OfYkJKxot5
 hWdJ3MYXjmcHjImBWplOyRiB81JbVf567MQlanforHd1r0ITzMHYONmRghrQvzlaMQrs0V0H
 5/sIufaiDh7rLeZSimeVyoFvwvQPx5sXhjViaHa+zHZExP9jhS/WWfFE881fNK9qqV8pi+li
 2uov8g5yD6hh+EPH6wARAQABwsF8BBgBCgAmFiEEKtR20JNxnJqlXaH73fNxj+N/OVcFAmNA
 kI0CGwwFCQeEzgAACgkQ3fNxj+N/OVfFMhAA2zXBUzMLWgTm6iHKAPfz3xEmjtwCF2Qv/TT3
 KqNUfU3/0VN2HjMABNZR+q3apm+jq76y0iWroTun8Lxo7g89/VDPLSCT0Nb7+VSuVR/nXfk8
 R+OoXQgXFRimYMqtP+LmyYM5V0VsuSsJTSnLbJTyCJVu8lvk3T9B0BywVmSFddumv3/pLZGn
 17EoKEWg4lraXjPXnV/zaaLdV5c3Olmnj8vh+14HnU5Cnw/dLS8/e8DHozkhcEftOf+puCIl
 Awo8txxtLq3H7KtA0c9kbSDpS+z/oT2S+WtRfucI+WN9XhvKmHkDV6+zNSH1FrZbP9FbLtoE
 T8qBdyk//d0GrGnOrPA3Yyka8epd/bXA0js9EuNknyNsHwaFrW4jpGAaIl62iYgb0jCtmoK/
 rCsv2dqS6Hi8w0s23IGjz51cdhdHzkFwuc8/WxI1ewacNNtfGnorXMh6N0g7E/r21pPeMDFs
 rUD9YI1Je/WifL/HbIubHCCdK8/N7rblgUrZJMG3W+7vAvZsOh/6VTZeP4wCe7Gs/cJhE2gI
 DmGcR+7rQvbFQC4zQxEjo8fNaTwjpzLM9NIp4vG9SDIqAm20MXzLBAeVkofixCsosUWUODxP
 owLbpg7pFRJGL9YyEHpS7MGPb3jSLzucMAFXgoI8rVqoq6si2sxr2l0VsNH5o3NgoAgJNIg=
In-Reply-To: <20250509-leinwand-leiht-f1031edf9c71@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27631/Thu May  8 10:35:15 2025)

On 5/9/25 7:54 AM, Christian Brauner wrote:
> On Thu, May 08, 2025 at 02:47:45PM -0700, Kuniyuki Iwashima wrote:
>> From: Christian Brauner <brauner@kernel.org>
>> Date: Thu, 8 May 2025 08:16:29 +0200
>>> On Wed, May 07, 2025 at 03:45:52PM -0700, Kuniyuki Iwashima wrote:
>>>> From: Christian Brauner <brauner@kernel.org>
>>>> Date: Wed, 07 May 2025 18:13:37 +0200
>>>>> Add the reserved "linuxafsk/" prefix for AF_UNIX sockets and require
>>>>> CAP_NET_ADMIN in the owning user namespace of the network namespace to
>>>>> bind it. This will be used in next patches to support the coredump
>>>>> socket but is a generally useful concept.
>>>>
>>>> I really think we shouldn't reserve address and it should be
>>>> configurable by users via core_pattern as with the other
>>>> coredump types.
>>>>
>>>> AF_UNIX doesn't support SO_REUSEPORT, so once the socket is
>>>> dying, user can't start the new coredump listener until it's
>>>> fully cleaned up, which adds unnecessary drawback.
>>>
>>> This really doesn't matter.
>>>
>>>> The semantic should be same with other types, and the todo
>>>> for the coredump service is prepare file (file, process, socket)
>>>> that can receive data and set its name to core_pattern.
>>>
>>> We need to perform a capability check during bind() for the host's
>>> coredump socket. Otherwise if the coredump server crashes an
>>> unprivileged attacker can simply bind the address and receive all
>>> coredumps from suid binaries.
>>
>> As I mentioned in the previous thread, this can be better
>> handled by BPF LSM with more fine-grained rule.
>>
>> 1. register a socket with its name to BPF map
>> 2. check if the destination socket is registered at connect
>>
>> Even when LSM is not availalbe, the cgroup BPF prog can make
>> connect() fail if the destination name is not registered
>> in the map.
>>
>>> This is also a problem for legitimate coredump server updates. To change
>>> the coredump address the coredump server must first setup a new socket
>>> and then update core_pattern and then shutdown the old coredump socket.
>>
>> So, for completeness, the server should set up a cgroup BPF
>> prog to route the request for the old name to the new one.
>>
>> Here, the bpf map above can be reused to check if the socket
>> name is registered in the map or route to another socket in
>> the map.
>>
>> Then, the unprivileged issue below and the non-dumpable issue
>> mentioned in the cover letter can also be resolved.
>>
>> The server is expected to have CAP_SYS_ADMIN, so BPF should
>> play a role.
> 
> This has been explained by multiple people over the course of this
> thread already. It is simply not acceptable for basic kernel
> functionality to be unsafe without the use of additional separate
> subsystems. It is not ok to require bpf for a core kernel api to be
> safely usable. It's irrelevant whether that's for security or cgroup
> hooks. None of which we can require.

As much as I like BPF, but I agree with Christian here that we should
not rely on other subsystems in addition, which might even be compiled
out in some cases where coredumps are needed (e.g. embedded).

