Return-Path: <linux-fsdevel+bounces-62666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E6BB9BB35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 21:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0B54C0ECD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 19:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0D03191AF;
	Wed, 24 Sep 2025 19:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="qP7ktGKp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from eastern.birch.relay.mailchannels.net (eastern.birch.relay.mailchannels.net [23.83.209.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C3A1C8603;
	Wed, 24 Sep 2025 19:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758741976; cv=pass; b=QqwhKov7zOBNob91ZIKleb+x94NIUDCPaN7BZF9uLkBt4kE5xramulnCLAdSdiW0cyVJnFkfObRmVW+2NaPKT+aaJFXgTmWdiNSNwH4hOtb3uGsMVl8mDk1BpbbJvDdvvabhxDwk1NimvAx+JyJdqdQVC0c7wjU8JPNz/YyGJ6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758741976; c=relaxed/simple;
	bh=BHsTkzdWZajDNDK+ioNil3t9QVIX4IumG9TxYgK95/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EkBWl7S0eZencH7xz9rP5NLYMH3a5x6ctyim2l14bTBbgE/n98yRgcXErmafAn+2jL6RCklgG7CtUkdaWspVo86kuwH0b/6PF+vk44y7fFgu6xQD8K1CGTzLHKUHHPcFcwC6B6nwx4gqzzmoyiOG4U4cGPQxxGZydr1sO2adL+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=qP7ktGKp; arc=pass smtp.client-ip=23.83.209.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D68F56C2CDF;
	Wed, 24 Sep 2025 19:20:52 +0000 (UTC)
Received: from pdx1-sub0-mail-a233.dreamhost.com (trex-blue-5.trex.outbound.svc.cluster.local [100.108.153.55])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4D82F6C092A;
	Wed, 24 Sep 2025 19:20:51 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1758741652; a=rsa-sha256;
	cv=none;
	b=FIelBRpKbw4XRCXREIY6GrcomZxyh5mPLsvXc2d6FGp/peq6EwuUT5C41+2LA0F+ggX9yV
	8sDI+KYqBxmckQrPVNV7rWra63fWqq+o5yLlx5MZRnuTdHQZEQgAmgblFxuGyjaNVrHFDk
	wPn+M2/WQfSpmZ0IkQEEN3MHnMtbF5yhytJwedRo1ogyg8SQR/ZRrsw9DI3lHGj/2mLKAm
	dj8jGFwnS4OjNKQjH2R6mDLZ7tlU8MommvaAha7o+UWIylY5K2nv2k5iepHunaoM660neK
	8apwlyJbofcRsA4DvFw4pkrtRAv7P9DWllpqqR+qR+EGkoSllD3i7IkmAH8Mog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1758741652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2+5k4o1pMixQXt5VsjL/MYZwcVCEyggOqRD9o8b/qSc=;
	b=ChRw8wSjyogd2do/v/H6TxZGH/WsiQerw/hid5S8KViit0lwA1gMH0+6UMTmJNQMMIezrz
	gsCOkeBMJedUyPmRdN0+x/Ibzn4kOtJ+sG57y0ioHbgMKfWThGzPdrmcr4dMMVSyyUw2rk
	dVBBOmfhJTtYNtYRTDWhwp+mpqmWhEqvL9C8FrlKqiY59ItiMJEd3l6YkcBc//9Lzk6+Fh
	mvjXUWAyzYxp+VnxExIXavdSHQcTxa/FAQIzz9fgRHT07mtFGrsyWRfq7ZmdI4pGoAxOfN
	0MoQjrfyn0a4j6aLMBwkDQq4B0YTsphgd54S7yxIuOYwH85l63FNfS25ErSZgQ==
ARC-Authentication-Results: i=1;
	rspamd-55b8bfbc7f-nnn52;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Callous-Spill: 350181bf214e86d3_1758741652308_3044232165
X-MC-Loop-Signature: 1758741652308:255498347
X-MC-Ingress-Time: 1758741652308
Received: from pdx1-sub0-mail-a233.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.108.153.55 (trex/7.1.3);
	Wed, 24 Sep 2025 19:20:52 +0000
Received: from [192.168.88.7] (unknown [209.81.127.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a233.dreamhost.com (Postfix) with ESMTPSA id 4cX6Bm0dnXzJl;
	Wed, 24 Sep 2025 12:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1758741651;
	bh=2+5k4o1pMixQXt5VsjL/MYZwcVCEyggOqRD9o8b/qSc=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=qP7ktGKps9suFLn+SvwXNJfmXIq5m7DqxjIn++FPW06rQGLdyFrasnCUUBtJnzZ2L
	 032Pr1ux0M59Obr3XwUHOtHtLFaEBxNmmkXxqPxYnCt1Q6ZqoWdAD9Q0W04+4gmjQl
	 ds3vnt+/qY5ti8rpHJ46bodAbnhitDUyLxlQ0tRxKsiwmL7TThWSclVniorsogf6MJ
	 gohNW1AXGJyGgriupkN0gkhVYK+ork7/6bPtZBHhvaB43HB07jP863XLDHcc31YH0+
	 wfQhtcquMUPSEA+sEb7jFLcwMpbQdjW0Rd1EFegx855pG/OiLXxmVQR1JAWLIYES88
	 kVFfZokS8hZqg==
Message-ID: <de56cabd-05a9-4528-8150-9ad97209640e@landley.net>
Date: Wed, 24 Sep 2025 14:20:47 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
To: Alexander Patrakov <patrakov@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Askar Safin <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Aleksa Sarai <cyphar@cyphar.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Julian Stecklina <julian.stecklina@cyberus-technology.de>,
 Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Eric Curtin <ecurtin@redhat.com>,
 Alexander Graf <graf@amazon.com>, Lennart Poettering <mzxreary@0pointer.de>,
 linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, x86@kernel.org, Ingo Molnar
 <mingo@redhat.com>, linux-block@vger.kernel.org, initramfs@vger.kernel.org,
 linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org,
 "Theodore Y . Ts'o" <tytso@mit.edu>, linux-acpi@vger.kernel.org,
 Michal Simek <monstr@monstr.eu>, devicetree@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
 Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>,
 patches@lists.linux.dev
References: <20250913003842.41944-1-safinaskar@gmail.com>
 <ffbf1a04-047d-4787-ac1e-f5362e1ca600@csgroup.eu>
 <CAN_LGv3Opj9RW0atfXODy-Epn++5mt_DLEi-ewxR9Me5x46Bkg@mail.gmail.com>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <CAN_LGv3Opj9RW0atfXODy-Epn++5mt_DLEi-ewxR9Me5x46Bkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/25 11:17, Alexander Patrakov wrote:
>> Therefore is it really initrd you are removing or just some corner case
>> ? If it is really initrd, then how does QEMU still work with that
>> -initrd parameter ?
> 
> The QEMU -initrd parameter is a misnomer. It can be used to pass an
> initrd or an initramfs, and the kernel automatically figures out what
> it is.

It's not a misnomer, initrams has always been able to make use of the 
existing initrd loading mechanism to read images externally supplied by 
the bootloader. It's what grub calls it too. I documented it in the 
"External initramfs images" section of 
https://kernel.org/doc/Documentation/filesystems/ramfs-rootfs-initramfs.txt 
back in 2005. The mechanism itself is 30 years old 
(Documentation/initrd.txt was written by Werner Almsberger in linux 
1.3.73 from March 7, 1996, ala 
https://github.com/mpe/linux-fullhistory/commit/afc106342783 ).

Since initrd contents could always be in a bunch of different 
autodetected formats (and optionally compressed just like the kernel), 
initramfs just hooked in to the staircase and said "if the format is 
cpio, call this function to handle it". The patch series proposes 
removing all the other formats, but not otherwise changing the existing 
external image loader mechanism. (Personally I think removing the 
architecture-specific hacks but leaving the generic support under init/ 
would probably have made more sense as a first step.)

The bootloader hands off an initrd image, initramfs is the boot-time 
cpio extraction plumbing that's _init tagged and gets freed, and rootfs 
is the persistent mounted instance of ramfs or tmpfs that's always there 
and is analogous to the init task (PID 1) except for the mount tree. 
(And is often overmounted so it's not visible, but it's still there. And 
is NOT SPECIAL: overmounts aren't a new concept, nor is hiding them in 
things like "df".)

There's a REASON my documentation file was called 
ramfs-rootfs-initramfs.txt: the naming's always been a bit... layered. 
(And yes, I have always spelled initmpfs with only one t.)

Rob

