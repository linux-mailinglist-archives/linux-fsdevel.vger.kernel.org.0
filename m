Return-Path: <linux-fsdevel+bounces-15505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE2288F7B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 07:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 452F8299D78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 06:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829DC4E1BC;
	Thu, 28 Mar 2024 06:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="mdrkDm1z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xn52XuWw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6704E1BD;
	Thu, 28 Mar 2024 06:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711606177; cv=none; b=P6dSX6YCZ/6TO6UNtjbB0b+k+KVU9NVJdB9jlGwsIJdbvfxn4T1RFf2Efwpa3fc8tW1uBaE9/fFuQs2W4H3gJp3t0trxDcd0ztYfvZE5MAaCq6GzgYK5ok7rzj9Xw4lbJPxf9zwmmMFxnTeTfKKcjTeyKFbeXXM8m4BkT8Xz88A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711606177; c=relaxed/simple;
	bh=2iNhQ9N/xJxOpVPb0UNcXr3NY5FHq+JlMRa8JuXaRYM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=DgiVS0A8EkMDb4YF/usSkNXSaj0uAfF1EBKeSy2bujP2ix7TvshzeKmGr19Q3LH6B4dLjeu70BDUKUmkOJVxFUbxAYfX/MSg5aT2Xp44EphVi73AQXVWA7LcKUDBR9z0slyAjkk2YMApZjdwHjQeByRcPmTlEUzRKFUmHpdLcEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=mdrkDm1z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xn52XuWw; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7BA841140110;
	Thu, 28 Mar 2024 02:09:34 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 28 Mar 2024 02:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1711606174;
	 x=1711692574; bh=vXVwqe/erX1PcRzBc8LEzG4qm/OR98bBQcZiNr1jHCk=; b=
	mdrkDm1zUf83McKaDZ1OjY/1A7t0N4B38FWURTGfsjptoFkXrwL6zKyWa5pOFOv+
	hvsgrjFfC0myat+zznFPmLNnG9w90xPQAvVzNmzdQJOwNnXdNjVvqfz4mUQbM/e6
	OxbfSY/xIaUYIojq13BakiVnWs0HYNiVZrgAEOIUEI9D6oRTqxlFGcnSI13wQxgz
	6JAkiZNtPo5M29tWnP51n822Mud89ul3NedpvaNtNc6hsvYUhFZItVxgGm1ZpVXf
	cFzCWGJMAlxrh+RE0RM6utM4vHpsc7/S1wNPgSVQaBrRkpPRaeUFm3NSZwjifqkF
	dZIaEYC5A5H6MBBTvF5JxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711606174; x=
	1711692574; bh=vXVwqe/erX1PcRzBc8LEzG4qm/OR98bBQcZiNr1jHCk=; b=x
	n52XuWwQ8Vs8R2QY5crarliOfoNa/Vrc5v4KL1kcsU4vJ0wJ0CwR7u16qV0zEaP4
	FM2SLx4CApXY9r0SdioxbDDYE5lRol8u8QcCraSL8tLU57UFHixy6VPjwoQTcsR9
	26lOJffKFE4XP0en2WR6y/vUZPAJDcCZ4iMYODkZ1wHHKzPYWrfG9sEHPt+MAVZA
	0AkHvfFCGqwdjANgIlXC94Eo6lsGv99e21CK2Ud+BGP4fEv3Q39gTl6qturO1M1H
	KxlFXhn1xte1vOFI9qqU1sjv8i6MHgD2ZYT8hXUpsV8t9oD/zzyKMnsqf5jsHNHk
	v7qulqCRWicFI6WkkEUtQ==
X-ME-Sender: <xms:ngkFZgwl-1tg1AASOQ92_TgiqSYLgFEQtxWmpuLjRGFkqRCWhB_Kug>
    <xme:ngkFZkSqPaS27gfgDdX0OG1XNVy7bLD0VB7y9c9fWosp8Wws7KjBD2YCO2qU2UhGI
    cekxVh2d5yPzvhdyAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddukedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkeeuleegieeghfduudeltdekfeffjeeuleehleefudettddtgfevueef
    feeigeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ngkFZiXvSjvMnoomVzs6OSB_RGmksqIByAGlf37ERrLetKApO9z0hA>
    <xmx:ngkFZuh8wmJbKBSuNg1SQmGtw2l8tWe-MIS-0F4HljsrebP8M6wy4g>
    <xmx:ngkFZiBjK1spfO1A12Khk6XImjTvuYkK6jOYv2Sl2PWe0fhS-5M-Jw>
    <xmx:ngkFZvKQ7m7Ya41lbGnt0Tdolu7WLPa7k6HkghD6C4iYzDnHdTEctw>
    <xmx:ngkFZky1g0jNiTJfq9jF4NbiJaJCNdQ4ta79C5UOKgp5zfsNqRf8dQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D9B44B60092; Thu, 28 Mar 2024 02:09:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <10da3ced-9a79-4ebb-a77d-1aa49cc61952@app.fastmail.com>
In-Reply-To: <3360dba8-0fac-4126-b72b-abc036957d6a@kernel.org>
References: <20240327130538.680256-1-david@redhat.com> <ZgQ5hNltQ2DHQXps@x1n>
 <3922460a-4d01-4ecb-b8c5-7c57fd46f3fd@redhat.com>
 <dc1433ea-4e59-4ab7-83fb-23b393020980@app.fastmail.com>
 <3360dba8-0fac-4126-b72b-abc036957d6a@kernel.org>
Date: Thu, 28 Mar 2024 07:09:13 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Vineet Gupta" <vgupta@kernel.org>,
 "David Hildenbrand" <david@redhat.com>, peterx <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@linux-foundation.org>,
 "Mike Rapoport" <rppt@kernel.org>, "Jason Gunthorpe" <jgg@nvidia.com>,
 "John Hubbard" <jhubbard@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-mm@kvack.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 x86@kernel.org, "Ryan Roberts" <ryan.roberts@arm.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Matt Turner" <mattst88@gmail.com>, "Alexey Brodkin" <abrodkin@synopsys.com>
Subject: Re: [PATCH RFC 0/3] mm/gup: consistently call it GUP-fast
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024, at 06:51, Vineet Gupta wrote:
> On 3/27/24 09:22, Arnd Bergmann wrote:
>> On Wed, Mar 27, 2024, at 16:39, David Hildenbrand wrote:
>>> On 27.03.24 16:21, Peter Xu wrote:
>>>> On Wed, Mar 27, 2024 at 02:05:35PM +0100, David Hildenbrand wrote:
>>>>
>>>> I'm not sure what config you tried there; as I am doing some build =
tests
>>>> recently, I found turning off CONFIG_SAMPLES + CONFIG_GCC_PLUGINS c=
ould
>>>> avoid a lot of issues, I think it's due to libc missing.  But maybe=
 not the
>>>> case there.
>>> CCin Arnd; I use some of his compiler chains, others from Fedora dir=
ectly. For
>>> example for alpha and arc, the Fedora gcc is "13.2.1".
>>> But there is other stuff like (arc):
>>>
>>> ./arch/arc/include/asm/mmu-arcv2.h: In function 'mmu_setup_asid':
>>> ./arch/arc/include/asm/mmu-arcv2.h:82:9: error: implicit declaration=
 of=20
>>> function 'write_aux_reg' [-Werro
>>> r=3Dimplicit-function-declaration]
>>>     82 |         write_aux_reg(ARC_REG_PID, asid | MMU_ENABLE);
>>>        |         ^~~~~~~~~~~~~
>> Seems to be missing an #include of soc/arc/aux.h, but I can't
>> tell when this first broke without bisecting.
>
> Weird I don't see this one but I only have gcc 12 handy ATM.
>
> =C2=A0=C2=A0=C2=A0 gcc version 12.2.1 20230306 (ARC HS GNU/Linux glibc=
 toolchain -
> build 1360)
>
> I even tried W=3D1 (which according to scripts/Makefile.extrawarn) sho=
uld
> include -Werror=3Dimplicit-function-declaration but don't see this sti=
ll.
>
> Tomorrow I'll try building a gcc 13.2.1 for ARC.

David reported them with the toolchains I built at
https://mirrors.edge.kernel.org/pub/tools/crosstool/
I'm fairly sure the problem is specific to the .config
and tree, not the toolchain though.

>>> or (alpha)
>>>
>>> WARNING: modpost: "saved_config" [vmlinux] is COMMON symbol
>>> ERROR: modpost: "memcpy" [fs/reiserfs/reiserfs.ko] undefined!
>>> ERROR: modpost: "memcpy" [fs/nfs/nfs.ko] undefined!
>>> ERROR: modpost: "memcpy" [fs/nfs/nfsv3.ko] undefined!
>>> ERROR: modpost: "memcpy" [fs/nfsd/nfsd.ko] undefined!
>>> ERROR: modpost: "memcpy" [fs/lockd/lockd.ko] undefined!
>>> ERROR: modpost: "memcpy" [crypto/crypto.ko] undefined!
>>> ERROR: modpost: "memcpy" [crypto/crypto_algapi.ko] undefined!
>>> ERROR: modpost: "memcpy" [crypto/aead.ko] undefined!
>>> ERROR: modpost: "memcpy" [crypto/crypto_skcipher.ko] undefined!
>>> ERROR: modpost: "memcpy" [crypto/seqiv.ko] undefined!
>
> Are these from ARC build or otherwise ?

This was arch/alpha.

      Arnd

