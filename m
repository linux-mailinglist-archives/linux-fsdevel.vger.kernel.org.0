Return-Path: <linux-fsdevel+bounces-63455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF471BBD1F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 08:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14193B48FE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 06:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A752517AC;
	Mon,  6 Oct 2025 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvf6myar"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC02B247287
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 06:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759731644; cv=none; b=sELAClWxLzW47Y0cpd6NxhogpFrX9Y0OQ7SxGuYLdD1/JoG7b4ce9BS1L0ZDQ/Gvl1mcOQliBzOhiY3kqBpxN8Rasc0L2kH3hs7dE7zRmNFzGrDz0Ls4dw4+9QaKfOCeNWQYGOEK3xkuhM2cq9Elo9GkCWslPxgsBRw0BxVNpyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759731644; c=relaxed/simple;
	bh=g4v2pkEEQ5GxRdAOK1WuY1GJa665YfSdr/vYeDfitpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncY3tI35xAU+0jMrHmVjTEGTwzcYwSCrSPE3ue+MTf9bpF9tg+KXvpLqKN7WWNGWPjMD6XbSoIbQFQiSlnsNGsXqMz05ad0+9yacR/H+dC5TSy6Zvwh7pqDYDCVqEULucFaReIqt81fUCHtnaU9Kl4Rp/5UmoDxGoCqvZe5gEsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvf6myar; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-62fc0b7bf62so6884413a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Oct 2025 23:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759731636; x=1760336436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNquTlh23mP7iB053Dg0R5L3AAPVXFE8/GScyWT83EA=;
        b=fvf6myarn0TzuKC7IP14uzKeEZTXvjbBVPaPw9gQ7UtVVTTVE1097Lck/kFDAe31nT
         CxnmEdK3mhRSaPGKqTWXxIwNG3BAIcZLMKx2aMBQo8cZ7WaNwGhmHcFR1pQiNC6c08XJ
         kF2kr8vBoiQMp4+sB1zvafZnGEqzIj0rUZMTQ2FPAckbWZM1GCU8mVgstTI+H2UINnMo
         iKD2fe8cI/brzvSD5RfHcdu2OybB1G7lUyvyqu6504Oa/fhF8ZICh4Il9cRFT6w/0n/o
         PRtBHDUK5MQEJC0GehXHEkBcWXNAnn0nAiBpCHXp2sAkEjJ4csNe2aXE+pRKzYuCkYHA
         4+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759731636; x=1760336436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNquTlh23mP7iB053Dg0R5L3AAPVXFE8/GScyWT83EA=;
        b=N4PGVzqjvaOYvyFExOd8XhMWtkYprwJQr4gSj45IHWeGm6G/WCinj7VGiV9AYv22EM
         CXGz07a8O9HStrMjhTegLFQIWsLoBIqKl/m81g2GLNCNXXCEKJ5gwwRB/NRh7ogv/MgN
         DMWDMbltuxEdFg63dEQJWsWlJF9ptPHvkdTSIb+zKBLsYsqDTBICpA16hJmVNY3gPte2
         vF/jiwNkEkaqI+YezI2JGi1azz+qdt/wCjLbEOFAOM3B6F2bpXw+720cbCHTejW4LBGE
         4RyevX8sBR/rSDdunZTgsZLQmMnCJyGkAxjVhoGTQ0EJ4tu1V9wCBXzHzBfZJ1w9vEDL
         17tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM5LUhUkr5EmM7N5jQSSAyGMFLINBz+H2+ScVsjVYXTk1hvzhViEtOQPsHywAxW5xbl5JHu7GloSIanG3W@vger.kernel.org
X-Gm-Message-State: AOJu0YwOhjUAwt4tgXa2nPHuidEl4G4/F749u73QTyrhJ1Nj7zenVPZP
	iKpwHDmU6TRmQ4hFljCL/01o3ISkX+oHLLSJJSeyBr+CDaUna0FLVKNi
X-Gm-Gg: ASbGncvM2xrFpF1Sc6V1FS/7dMntAhM6YTS28TNbSlCeX+ms5YI2VwGnktKt3zPC7KM
	hO2l0YHziL7yZPhn8RTiHaP3QpJYbyklKjQGUDaz8r3axG9V4DGxyfKlz70FEpezHQgaabFSwVV
	TIQYMg7vabh0gWw0SA5kgmT8/sJ6ikCPICvic70BAiaT/Kmc10nbZgnDJxqJmUcCRUGGFMVmDb2
	cHWpaOMbbuQ6hKDE61yKcKyWu8dTy7Zm9muTSRDvo4hz5hglIraSfB3n7qOkgLdiswTFFCNJQX+
	nevaw/RqK1iuzFmaMlf8HTM23rAjBYs7/Y+bK6KsrJ4osYRIozfD2vBRso0BI4hKEcN2I8ViKWF
	+odOxRz4UvtRmvAWg7mddPbrNm5H2wa4SoPzNUGk/QcFEVybaf/BR4g==
X-Google-Smtp-Source: AGHT+IGd3d1JuyR21TpPk9MiZBONB78IR1Ui0MCDuhOuJlJOi/6hOLi13ihVT2uEw4eqZCl9wOO81g==
X-Received: by 2002:a17:907:7fa5:b0:b04:25e6:2dbe with SMTP id a640c23a62f3a-b49c52746d1mr1340676066b.63.1759731635370;
        Sun, 05 Oct 2025 23:20:35 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6378811236csm9486395a12.42.2025.10.05.23.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Oct 2025 23:20:34 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: rob@landley.net
Cc: akpm@linux-foundation.org,
	andy.shevchenko@gmail.com,
	axboe@kernel.dk,
	brauner@kernel.org,
	cyphar@cyphar.com,
	devicetree@vger.kernel.org,
	email2tema@gmail.com,
	graf@amazon.com,
	gregkh@linuxfoundation.org,
	hca@linux.ibm.com,
	hch@lst.de,
	hsiangkao@linux.alibaba.com,
	initramfs@vger.kernel.org,
	jack@suse.cz,
	julian.stecklina@cyberus-technology.de,
	kees@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	mcgrof@kernel.org,
	mingo@redhat.com,
	monstr@monstr.eu,
	mzxreary@0pointer.de,
	patches@lists.linux.dev,
	sparclinux@vger.kernel.org,
	thomas.weissschuh@linutronix.de,
	thorsten.blum@linux.dev,
	torvalds@linux-foundation.org,
	tytso@mit.edu,
	viro@zeniv.linux.org.uk,
	x86@kernel.org
Subject: Re: [PATCH 00/62] initrd: remove classic initrd support
Date: Mon,  6 Oct 2025 09:19:56 +0300
Message-ID: <20251006062026.1118184-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <0342fbda-9901-4293-afa7-ba6085eb1688@landley.net>
References: <0342fbda-9901-4293-afa7-ba6085eb1688@landley.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rob Landley <rob@landley.net>:
> Still useful for embedded systems that can memory map flash, but it's

They can use workaround suggested in cover letter.

> While you're at it, could you fix static/builtin initramfs so PID 1 has 
> a valid stdin/stdout/stderr?

This is in my low-priority TODO list. I want to help you. I will possibly do this
after a month or two or three...

> I posted various patches to make CONFIG_DEVTMPFS_MOUNT work for initmpfs

My solution will be different: I will create static /dev/console and /dev/null
after unpacking of builtin and external initramfs. (/dev/null because of
that bionic problem you somewhere wrote.)

> Oh hey, somebody using mkroot. Cool. :)

Yeah, thank you for mkroot.

> Now that lkml.iu.edu is back up (yay!) all the links in 
> ramfs-rootfs-initramfs.txt can theoretically be fixed just by switching 
> the domain name.

Yes, I plan to replace them with lore.kernel.org ones. This is in my low-priority
TODO list, too.

> > For example, I renamed the following global variables:
> > 
> > __initramfs_start
> > __initramfs_size
> 
> That already said initramfs, and you renamed it.

Yes, to distinguish builtin and external initramfs.

> > phys_initrd_start
> > phys_initrd_size
> > initrd_start
> > initrd_end
> 
> Which is data delivered through grub's "initrd" command. Here's how I've 

My plan is to change "official" names for these things.
"initramfs" will refer both to .cpio archive itself and to loading
mechanism. Name of GRUB's "initrd" command will become "wrong, kept for
compatibility".

But I plan to do all these renamings after I fully remove initrd support,
which will happen in September 2026, as I explained in another email.

> 3) rootfs is (for some reason) the name of the mounted filesystem in 
> /proc/mounts (because letting it say "ramfs" or "tmpfs" like normal in 
> /proc/mounts would be consistent and immediately understandable, so they 
> couldn't have that).

I totally agree. I want to change it to ramfs/tmpfs. But this change
may break something, so I think we need some strong motivation to
do this. So I will wait for removal of nommu support. Arnd Bergmann said
"NOMMU removal maybe 2027" ( https://lwn.net/Articles/1035727/ ,
https://static.sched.com/hosted_files/osseu2025/75/32-bit%20Linux%20in%202025%20%28OSS%20Europe%29.pdf ,
slide 20). (Also he said 32-bit support will be removed, too.)
After that I will remove ramfs (yeah, I love to remove things),
and, while we are here, I will rename "rootfs" to "tmpfs" in
/proc/mounts (hopefully I will get away with this).

> > __builtin_initramfs_start
> > __builtin_initramfs_size
> > phys_external_initramfs_start
> > phys_external_initramfs_size
> > virt_external_initramfs_start
> > virt_external_initramfs_end
> 
> Do you believe people will understand what the slightly longer names are 
> without looking them up?

No. But I still hope new names are better. As I said above, all these
will be named "initramfs" under my new plan. But again, all these
will happen after full initrd removal, which will happen in Sep 2026.

> I'm all for removing obsolete code, but a partial cleanup that still 
> leaves various sharp edges around isn't necessarily a net improvement. 
> Did you remove the NFS mount code from init/do_mounts.c? Part of the 

Okay, I put this to my low-priority TODO list.

> The one config symbol that really seems to bite people in this area is 
> BLK_DEV_INITRD because a common thing people running from initramfs want 
> to do is yank the block layer entirely (CONFIG_BLOCK=n) and use 
> initramfs instead, and needing to enable CONFIG_BLK_DEV_INITRD while
> 
> And the INSANE part is they generally want a static initrd to do it so 
> they're not using the external loader, but Kconfig has INITRAMFS_SOURCE 
> under CONFIG_BLK_DEV_INITRD and it's a mess. Renaming THAT symbol would 
> be good.

You mean renaming CONFIG_BLK_DEV_INITRD will be good?
I do exactly that.
And while we are here, I also rename CONFIG_RD_*,
because configs will be broken anyway.

Also, recently we got keyword "transitional" to help with such
renamings: https://www.phoronix.com/news/Linux-6.18-Transitional .
I will use it.

> To you. I'm not entirely sure what virt_external means. (Yes I could go 

It means "virtual address of external initramfs". But, yes, Borislav Petkov
said me in another email that kernel devs usually use "va" for virtual
address and "pa" for physical, so I will use these terms (in Sep 2026).

> Meanwhile 35 years of installed base expertise in other people's heads 
> has been discarded and developed version skew for anyone maintaining an 

I'm still not convinced. Ideally I want to remove word "initrd" from Linux
sources completely.

Decision to merge my patches or not is on maintainers anyway. They
will decide whether these renamings are good idea.

> > - Removed kernel command line parameter "ramdisk_start",
> > which was used for initrd only (not for initramfs)
> 
> Some bootloaders appended that to the kernel command line to specify 
> where in memory they've loaded the initrd image, which could be a 
> cpio.gz once upon a time. No idea what regressions happened since though.

I double-checked: ramdisk_start is used for initrd code path only
in modern kernels, not for initramfs code path.

"initrd=" is used in both code paths, and I keep it.

==

While we are here, let me answer other your emails, too.

Here is answer to https://lore.kernel.org/all/94023988-8498-4070-bdb7-6758dbe4b91d@landley.net/ .

> There used to be a way to feed a the kernel config a text file listing 
> what to make in the cpio file instead of just pointing it at a 
> directory, and my old Aboriginal Linux build used that mechanism 
...
> But kernel commit 469e87e89fd6 broke that mechanism because somebody 
> dunning-krugered it away ("I don't understand why we need this therefore 

I will consider fixing this, too. Put to my low-priority TODO list.

But it is possible that I will instead remove gen-init-cpio completely.
(I will do some experiments before deciding.)
If it was broken, and nobody except for you cared, then this means that
nobody except for you use it.

Of course, I will do that after sending patch for unconditional creating of
/dev/console and /dev/null, so you are safe.

> And again: you ONLY need this for static initramfs. Dynamic initramfs 
> has code create /dev/console (at boot time, not build time):
>
> https://github.com/torvalds/linux/blob/v6.16/init/noinitramfs.c#L27

Your explanation is wrong here. As you can see in Makefile, noinitramfs.c
is not built if there is BLK_DEV_INITRD.

If you don't have BLK_DEV_INITRD, then noinitramfs.c
is built, and it creates /dev/console.

If there is BLK_DEV_INITRD and there is no INITRAMFS_SOURCE, then
default built-in initramfs is used, which is specified here:
https://elixir.bootlin.com/linux/v6.17/source/usr/default_cpio_list
(and it happens to be equivalent to specified in noinitramfs.c).

If there are both BLK_DEV_INITRD and INITRAMFS_SOURCE, then
INITRAMFS_SOURCE is used instead of default built-in initramfs,
so there is no /dev/console.

I am totally sure that my explanation is correct.

> I could emit cpio contents with xxd -r from a HERE document hexdump or

There is no need for "xxd -r". cpio encoding of /dev/console is ASCII
(except for some null bytes). See:

$ echo /dev/console | cpio --create --format=newc --quiet | xxd
00000000: 3037 3037 3031 3030 3030 3030 3043 3030  0707010000000C00
00000010: 3030 3231 3830 3030 3030 3030 3030 3030  0021800000000000
00000020: 3030 3030 3030 3030 3030 3030 3031 3638  0000000000000168
00000030: 4438 4337 4241 3030 3030 3030 3030 3030  D8C7BA0000000000
00000040: 3030 3030 3030 3030 3030 3030 3036 3030  0000000000000600
00000050: 3030 3030 3035 3030 3030 3030 3031 3030  0000050000000100
00000060: 3030 3030 3044 3030 3030 3030 3030 2f64  00000D00000000/d
00000070: 6576 2f63 6f6e 736f 6c65 0000 3037 3037  ev/console..0707
00000080: 3031 3030 3030 3030 3030 3030 3030 3030  0100000000000000
00000090: 3030 3030 3030 3030 3030 3030 3030 3030  0000000000000000
000000a0: 3030 3030 3030 3030 3031 3030 3030 3030  0000000001000000
000000b0: 3030 3030 3030 3030 3030 3030 3030 3030  0000000000000000
000000c0: 3030 3030 3030 3030 3030 3030 3030 3030  0000000000000000
000000d0: 3030 3030 3030 3030 3030 3030 3030 3030  0000000000000000
000000e0: 3042 3030 3030 3030 3030 5452 4149 4c45  0B00000000TRAILE
000000f0: 5221 2121 0000 0000 0000 0000 0000 0000  R!!!............
00000100: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000110: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000120: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000130: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000140: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000150: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000160: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000170: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000180: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000190: 0000 0000 0000 0000 0000 0000 0000 0000  ................
000001a0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
000001b0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
000001c0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
000001d0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
000001e0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
000001f0: 0000 0000 0000 0000 0000 0000 0000 0000  ................

So, I think the following will go (not tested):

==
printf '%s' '0707010000000C0000218000000000000000000000000168D8C7BA00000000000000000000000600000005000000010000000D00000000/dev/console' > out.cpio
printf '\0\0' >> out.cpio
==

Maybe even last '\0\0' is not needed.

Also, this your email ( https://lore.kernel.org/all/94023988-8498-4070-bdb7-6758dbe4b91d@landley.net/ )
for some reasons didn't end up on https://lore.kernel.org/lkml .

As you can see here https://lore.kernel.org/lkml/94023988-8498-4070-bdb7-6758dbe4b91d@landley.net/ ,
the full list of lore mailing lists, which got it, is linux-snps-arc, linux-riscv and linux-sh .

I wrote about this to public-inbox:
http://public-inbox.org/meta/CAPnZJGB7ugY5rytS+hO-QzvPQBNjCh1jzs4WVkuakafBM9c_=w@mail.gmail.com/T/#u .
But it is possible that the problem is on your side.

Maybe this is why people ignore your emails? Maybe they simply don't get them?

Consider applying for linux.dev email ( https://linux.dev ). They are free for linux devs.

==

Now let me answer to https://lore.kernel.org/lkml/8f595eec-e85e-4c1f-acb0-5069a01c1012@landley.net/T/#u .

> I find the community an elaborate bureaucracy unresponsive to hobbyists. 
> Documentation/process/submitting-patches.rst being a 934 line document 
> with a bibliography, plus a 24 step checklist not counting the a) b) c) 
> subsections are just symptoms. The real problem is following those is 
> not sufficient to navigate said bureaucracy.

I totally agree.

Still I somehow was able to manage this.

Again: I totally agree. I just want to share some practical advice, that helped me
to get my patches merged.

As you can see, I was able to get my patches merged:
https://lore.kernel.org/all/?q=f:%22Askar%20Safin%22 .

And this is despite nobody paid me for this. I do this in my own free time.

As well as I understand, you are doing embedded Linux development as your job,
so you are in better position.

My patches are merged despite my productivity is low. I am very slow person.

You don't need to remember all of submitting-patches.rst . Just do this:

- Run checkpatch.pl . It accepts git ranges, e. g. "checkpatch.pl origin/HEAD..HEAD"
- After posting patches respond to comments, apply their edits, send new version, then again and again

When sending patches and responding to comments don't write too long letters.
Nobody will carefully read long letters and respond to them.
I respond to such letters, because I'm autistic, and I feel responsibility to carefully
read and respond to each letter. But other people don't do this.

In particular, when sending patches and responding to comments don't write long
paragraphs about good things you did in the past and about how you are disappointed
in the entire world, such as these:

> Let's see, I wrote the initramfs documentation in 2005:
>
> https://lwn.net/Articles/157676/
>
> Was already correcting kernel developers on how it actually worked 
> (rather than theoretically worked) in 2006:
>
> https://lkml.iu.edu/hypermail//linux/kernel/0603.2/2760.html
>
> I added tmpfs support to it in 2013 (because nobody else had bothered 
> for EIGHT YEARS):
>
> https://lkml.iu.edu/hypermail/linux/kernel/1306.3/04204.html
>
> I've maintained my own cpio implementation in toybox for over a decade:
>
> https://github.com/landley/toybox/commit/a2d558151a63
>
> The successor to aboriginal (above) is a 400 line bash script that 
> builds a dozen archtectures that each boot to a shell prompt in qemu:
>
> https://github.com/landley/toybox/blob/master/mkroot/mkroot.sh
> https://landley.net/bin/mkroot/latest/
>
> With automated regression test infrastructure to boot them all under 
> qemu and confirm that it runs, the clocks are set right, the network 
> works, and it can read from -hda:
>
> https://github.com/landley/toybox/blob/master/mkroot/testroot.sh
>
> So yes I _can_ create my own bespoke C program to modify the file in 
> arbitrary ways, I have my reasons not to do that, and have thought about 
> them for a while now.

Again: I'm not trying to insult you. I'm just trying to give advice how
to get your patches merged.

When my patches are ready, I send them using something like this:

==
UPSTREAM=origin/HEAD
MERGE_BASE="$(git merge-base "$UPSTREAM" HEAD)"

mkdir /tmp/patches

# For --signoff
export GIT_COMMITTER_EMAIL=me@example.com

# Prepare patches
# --base for "base-commit:" footer
git format-patch --cover-letter --find-renames --base="$MERGE_BASE" --signoff -o /tmp/patches \
  --subject-prefix='PATCH v2' "$MERGE_BASE"

editor /tmp/patches/0000-cover-letter.patch

# Send
# "--batch-size=1 --relogin-delay=20" to insert delays between patches. Hopefully
# this will help me to cope with my mailserver limits
# "--confirm=" to give myself chance to cancel
git send-email --batch-size=1 --relogin-delay=20 --confirm=always --to=a@example.com --cc=b@example.com \
  /tmp/patches
==

This script will automatically generate nice diffstat in cover letter.

This script is not tested. Actually I use my own 182-line Rust program, which does
same thing.

This is checklist I plan to do when sending v2 version of this initrd patchset:
- Read all answers to prev. version, respond and apply edits
- checkpatch.pl
- Check that my patchset doesn't conflict with linux-next
- Check that every commit compiles for x86_64 with "W=1"
- Test everything using mkroot.sh rewritten in Rust

> Why keep the section when you removed the old mechanism?

This section still contains useful info, so I kept it.
But okay, I agree, I will rewrite it to not mention initrd.
I will do this after full removal of initrd, i. e. in Sep 2026.

If you want me to send some patch to this document _now_,
then just ask me, I will try to do this.

> Those two lines you just touched contradict each other

Will fix in Sep 2026, too.

> The init/noinitramfs.c file does init/mkdir("/dev") and 
> init_mknod("/dev/console") because calling the syscall_blah() functions 
> directly was considered icky so they created gratuitous wrappers to do

You cannot directly call syscall from kernel code if your syscall
works with strings. Reasons are here: https://lwn.net/Articles/832121/ .

mkdir syscall expects string, located in user memory. So you
cannot call it from kernel and pass kernel string to it.
Thus you need separate init_mkdir.

> Anyway, that's why the 130+ byte archive was there. It wasn't actually 
> empty, even when initramfs was disabled.

I just double-checked. If BLK_DEV_INITRD is disabled, then
there is no any builtin initramfs at all. If BLK_DEV_INITRD is
disabled, then initramfs_data.S is not built, as we can see here:

https://elixir.bootlin.com/linux/v6.17/source/usr/Makefile#L15

And initramfs_data.S contains symbol __initramfs_size, so, yes,
initramfs_data.S is actual builtin initramfs.

In fact, that "obj-$(CONFIG_BLK_DEV_INITRD) :=" trick
is not needed, because whole usr/ dir is compiled out,
if there is no BLK_DEV_INITRD:
https://elixir.bootlin.com/linux/v6.17/source/init/Kconfig#L1455

Again: I acknoledge that bug with missing /dev/console. In fact,
I was able to reproduce it. I plan to fix it in a month or two.

> > +If the kernel has CONFIG_BLK_DEV_INITRD enabled, an external cpio.gz archive can also
>
> You renamed that symbol, then even you use the old name here.

I rename it in later commit.

> > -This has the memory efficiency advantages of initramfs (no ramdisk block
> > -device) but the separate packaging of initrd (which is nice if you have
> > +This is nice if you have
> >   non-GPL code you'd like to run from initramfs, without conflating it with
> > -the GPL licensed Linux kernel binary).
> > +the GPL licensed Linux kernel binary.
>
> IANAL: Whether or not this qualifies as "mere aggregation" had yet to go 
> to court last I heard.

This is possible that court will use this file as an argument.
So let's keep this paragraph here. :)

There is an example, where FAQ on FSF site was actually
used as argument in court: https://www.sonarsource.com/blog/will-the-new-judicial-ruling-in-the-vizio-lawsuit-strengthen-the-gpl/ .

I mean this quote:

> Vizio “did not dispute” the first two questions, focusing instead on the “expectations” of the contracting parties.
> Relying on the Free Software Foundation’s (FSF) GPL FAQs, it argued that the FSF never intended for third parties to enforce the contract,
> and therefore the parties to the contract could not have intended it.


> >     echo init | cpio -o -H newc | gzip > test.cpio.gz
> > -  # Testing external initramfs using the initrd loading mechanism.
> > +  # Testing external initramfs.
>
> Does grub not still call it "initrd"?

Yes, grub still calls it "initrd".
As I said, in Sep 2026 I will rename bootloader loading mechanism to "initramfs",
and name of grub command "initrd" will simply become "wrong".

> A) they added -hda so you don't have to give it a dummy /dev/zero anymore.

Ok, I will fix.

> B) there's no longer a "qemu" defaulting to the current architecture,

Ok, I will fix.

-- 
Askar Safin

