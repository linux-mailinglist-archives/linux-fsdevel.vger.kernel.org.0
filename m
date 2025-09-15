Return-Path: <linux-fsdevel+bounces-61444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A17BB582EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 19:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B510D200D86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 17:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2927299927;
	Mon, 15 Sep 2025 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="hHM4pYd/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E429B1E411C;
	Mon, 15 Sep 2025 17:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956150; cv=pass; b=jRuLz3OhCyXL6HWqADOAX9tQzJHniEFwi5PNsUgK24oFU5tuqqhWMKdMRG6pB30jp8CFkSDSXcTFUQl9a33QXX3tAwQ415AospaGban+wnQrNwoPbiR7AU2VA2wwAQOs0zE8HO+yGb6Ih1RL49xACXJuDG52CSe87dunwFv7v0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956150; c=relaxed/simple;
	bh=QcXwkxkXJJSavuVQocajTsXXfAli+FzNVs3Cosik7T4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txkuqdfyDg9MRwZYU9FPR8wGfn+UDjNro9ILF4p0RbxeTb4RWrpjag8SOuqzOofZ8l74Wr4eHB8eBW/VgWBvYkOTN/YQv1WhWELyuKlUktm6EblD9u6OkfiWjDdoiIgN1Geb5BPGWLEruUAcdOM7Ff9xkVxIG+GbUKfxMPEn06Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=hHM4pYd/; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 39E08702EA9;
	Mon, 15 Sep 2025 16:43:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a263.dreamhost.com (100-107-6-72.trex-nlb.outbound.svc.cluster.local [100.107.6.72])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 9BB55702282;
	Mon, 15 Sep 2025 16:43:54 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1757954637; a=rsa-sha256;
	cv=none;
	b=jcH1teqBLlSbjLGm8wSnPehjkoxnqnKDUpG0VLOzFQvMVhZ2RDdFx48JVTnsWir31ckqMu
	EvHw7ndPjn6x3ejP/grrUuf0A3eh0N2g0queP5YloUWZd31ELnY6AwtaV3MGseURoNdaoS
	zscSVSlE1syzCOnfqWMXHqv2BNZPfKgMjyC2VEzAcakw89VkuKuBaP90ntArsIib7mZKX5
	ZgdyEESnQCqTf94vRuZObuGhTP1RPfIX0PnGy3kQhlP5kUt/Dz9EbRDsiobBB3oTpkdYWy
	k6PF9vasGxEY9B6Kc77KSSvLrFmYIRfBHJgN7n0ZqoQA6jkN51HIOvnq2TpRMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1757954637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=xA0gszu8fOIEF8+fZ/zdihDvOFxt7L1IOq6Jl8u2kgw=;
	b=uf5JurJxL6zPD5ygwIBxiT6IG/NGQSMFBfI/j25Q+JK2yjF3vO/ZeFUzkivSugs95eaoMg
	59qSqcFbNTSjbKJMujtP6awqbU503n4OV/R0ncaq21v7J9x5Rmz4NG64ypHTRA39FK+kIQ
	QcvIWdAN8US3InpTGJ0E/js2x9iRNDG6I4ylgwOyesBRTyLg247F0Kqo1EFdrR+ljEh1Av
	5GQCiDYAEUXavwumWE/vBnelmY4Gbj+BC4uBSlh8dneVcfD4sq5ftE6dv/8SS57HKfdNIL
	CE1mKhd2skglApswBp3iKe06w5MtCJr2cExHZcQU+hkmm5PzcKoApEbN8wR0GA==
ARC-Authentication-Results: i=1;
	rspamd-7d6d7bb5c5-768t4;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Unite-White: 537c80b115ac1c1b_1757954638045_367269675
X-MC-Loop-Signature: 1757954638045:1180864403
X-MC-Ingress-Time: 1757954638045
Received: from pdx1-sub0-mail-a263.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.107.6.72 (trex/7.1.3);
	Mon, 15 Sep 2025 16:43:58 +0000
Received: from [192.168.88.7] (unknown [209.81.127.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a263.dreamhost.com (Postfix) with ESMTPSA id 4cQW7q36Pxz87;
	Mon, 15 Sep 2025 09:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1757954634;
	bh=xA0gszu8fOIEF8+fZ/zdihDvOFxt7L1IOq6Jl8u2kgw=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=hHM4pYd/5trdTXN8EQrQ00lNAioPSBHN1EqLeHX8tyv2t598Ei1gLYc67SRexxr0o
	 V0b5BOT6HHaq8Ssq9in/lkr4tC1sG2QaTTQae3Lbu/rnfHom969Ad4mHyQ7NqbQYcw
	 gP53fXuyiZlBDvddyeoS0qzObAO9y3gkmXtrQOaXHNUfK5TwQ+L96ToYgoS+Gu35CI
	 V1YXP+0R1LGjVdii8SPZYWnlquLSvuDhcO4PELQxHEyOVux+Xbp+BpIruEIgRvA5Qu
	 KHe36UtOS8E3jxHb8nrG1IU4Gx6FlURDKqDa9h0q4ahxoeXsq8J5/itWfZ6J5I+Smp
	 owTGtnU7EFjUg==
Message-ID: <0342fbda-9901-4293-afa7-ba6085eb1688@landley.net>
Date: Mon, 15 Sep 2025 11:43:50 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/62] initrd: remove classic initrd support
To: Askar Safin <safinaskar@zohomail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
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
References: <20250912223937.3735076-1-safinaskar@zohomail.com>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <20250912223937.3735076-1-safinaskar@zohomail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/25 17:38, Askar Safin wrote:
> Intro
> ====
> This patchset removes classic initrd (initial RAM disk) support,
> which was deprecated in 2020.

Still useful for embedded systems that can memory map flash, but it's 
getting harder to find embedded developers who consider new kernels an 
improvement over older ones...

> Initramfs still stays, and RAM disk itself (brd) still stays, too.

While you're at it, could you fix static/builtin initramfs so PID 1 has 
a valid stdin/stdout/stderr?

A static initramfs won't create /dev/console if the embedded initramfs 
image doesn't contain it, which a non-root build can't mknod, so the 
kernel plumbing won't see it dev in the directory we point it at unless 
we build with root access. This means the open("/dev/console") fails, so 
init starts with no error reporting and we have to get far enough to 
mount our own devtmpfs or similar and open our own stdout/stderr before 
we can see any error output from init, which is kinda brittle.

I posted various patches to make CONFIG_DEVTMPFS_MOUNT work for initmpfs 
repeatedly since 2017, which also addressed it, but the kernel 
community's been hermetically sealed against outside intrusion for a 
while now...

https://lkml.iu.edu/hypermail/linux/kernel/2005.1/09399.html

https://lkml.iu.edu/2302.2/05597.html

> init/do_mounts* and init/*initramfs* are listed in VFS entry in
> MAINTAINERS, so I think this patchset should go through VFS tree.
> This patchset touchs every subdirectory in arch/, so I tested it
> on 8 (!!!) archs in Qemu (see details below).

Oh hey, somebody using mkroot. Cool. :)

My current "passes basic automated smoketests" list for 6.16 is:

aarch64 armv4l armv5l armv7l i486 i686 m68k mips64 mipsel mips powerpc 
powerpc64le powerpc64 riscv32 riscv64 s390x sh4 x86_64

I'm assuming that's your 8: arm, x86, m68k, mips, ppc, riscv, s390x, 
superh. (The variants are mostly 32/64 bit and bit/little endian, couple 
architecture generations in there. The old ones go out of patent first, 
you can always tell patents are about to expire and get generic clones 
when corporate shills start insisting that support for something REALLY 
NEEDS TO GO AWAY RIGHT NOW...)

The or1k, microblaze, and sh4eb targets mostly work: sh4eb has broken 
eithernet (never tracked down whether it's kernel or qemu that's wrong I 
just know they disagree), or1k doesn't know how to exit ala 
https://lists.gnu.org/archive/html/qemu-devel/2024-11/msg04522.html and 
microblaze never wired up -hda to their hard drive emulation 
https://lists.nongnu.org/archive/html/qemu-devel/2025-01/msg01149.html
but I haven't had the spoons to argue with IBM Hat developers about 
procedure compliance auditing.

I need to track down a decent qemu emulation for armv7m, last time I 
tried with vanilla was https://landley.net/notes-2023.html#23-02-2023 
which was not promising, I downloaded a pic32 qemu fork last week, but 
haven't had the spoons to follow up on that either. Or to ship a new 
toybox/mkroot release: I've had 6.16 kernel patches since the week it 
came out, unbreaking powerpc and adding fdpic support to sh4-mmu, but 
hobbyist friendly this community ain't. Sigh, I should get back on the 
(beating a dead) horse...

I had hexagon userspace working for a while ("qemu-hexagon ls -l") but 
no kernel for it: Taylor Simpson said he was going to post a 
qemu-system-hexagon patchset with a comet board emulation, but that 
architecture has no gcc support (there was a gcc fork on code aurora but 
they abandoned it when the FSF went gplv3) so it needs an llvm-only 
toolchain build with a non-vanilla musl libc fork... Honestly the 
problem is compiler-rt sucks rocks: I should cycle back around to 
https://landley.net/notes-2021.html#28-07-2021 but just haven't.

(Although part of the "Just haven't" is that I posted a patch to lkml 
making generic $CROSS_COMPILE prefixes automatically work whether your 
toolchain was gcc or llvm, and the response was literally "we decided to 
manually specify LLVM= on the command line so you must always do that 
and we're refusing your two line fix to NOT need to do that". No really: 
https://lkml.iu.edu/2302.2/08170.html

> Warning: this patchset renames CONFIG_BLK_DEV_INITRD (!!!) to CONFIG_INITRAMFS
> and CONFIG_RD_* to CONFIG_INITRAMFS_DECOMPRESS_* (for example,
> CONFIG_RD_GZIP to CONFIG_INITRAMFS_DECOMPRESS_GZIP).
> If you still use initrd, see below for workaround.

Which will break existing configs for what benefit?

I'm not convinced the churn improves matters. Presumably the kernel 
command line paremeter is still rdinit= and grub still uses the "initrd" 
command to load an external cpio.gz.

But I bisect to find breakage like that every release so I assume the 
other embedded linux developers... are mostly shipping 10+ year old 
kernels that use half the memory of today's.

> Details
> ====
> I not only removed initrd, I also removed a lot of code, which
> became dead, including a lot of code in arch/.
> 
> Still I think the only two architectures I touched in non-trivial
> way are sh and 32-bit arm.
> 
> Also I renamed some files, functions and variables (which became misnomers) to proper names,
> moved some code around, removed a lot of mentions of initrd
> in code and comments. Also I cleaned up some docs.

Now that lkml.iu.edu is back up (yay!) all the links in 
ramfs-rootfs-initramfs.txt can theoretically be fixed just by switching 
the domain name.

> For example, I renamed the following global variables:
> 
> __initramfs_start
> __initramfs_size

That already said initramfs, and you renamed it.

> phys_initrd_start
> phys_initrd_size
> initrd_start
> initrd_end

Which is data delivered through grub's "initrd" command. Here's how I've 
been explaining it to people for years:

1) initrd is the external blob from the bootloader's initrd= option.

2) initramfs is the extractor plumbing, _init code that gets discarded.

3) rootfs is (for some reason) the name of the mounted filesystem in 
/proc/mounts (because letting it say "ramfs" or "tmpfs" like normal in 
/proc/mounts would be consistent and immediately understandable, so they 
couldn't have that).

(No I don't know why it's called rootfs. Having things like df not show 
overmounted filesystems isn't special case logic, why...? The argument 
to special case this because you can't unmount it is like saying PID 1 
shouldn't have a number because it can't exit. I would happily call the 
whole thing initramfs... but it's already not.)

> to:
> 
> __builtin_initramfs_start
> __builtin_initramfs_size
> phys_external_initramfs_start
> phys_external_initramfs_size
> virt_external_initramfs_start
> virt_external_initramfs_end

Do you believe people will understand what the slightly longer names are 
without looking them up?

I'm all for removing obsolete code, but a partial cleanup that still 
leaves various sharp edges around isn't necessarily a net improvement. 
Did you remove the NFS mount code from init/do_mounts.c? Part of the 
initramfs justification back in 2005 was "you can have a tiny initramfs 
set up our root filesystem so most of the init special casing can go"... 
and then they added CONFIG_DEVTMPFS_MOUNT but made it ONLY apply to the 
fallback root after the system has decided NOT to stay on rootfs, and 
ignored my patches to at least make it consistent.

The one config symbol that really seems to bite people in this area is 
BLK_DEV_INITRD because a common thing people running from initramfs want 
to do is yank the block layer entirely (CONFIG_BLOCK=n) and use 
initramfs instead, and needing to enable CONFIG_BLK_DEV_INITRD while

And the INSANE part is they generally want a static initrd to do it so 
they're not using the external loader, but Kconfig has INITRAMFS_SOURCE 
under CONFIG_BLK_DEV_INITRD and it's a mess. Renaming THAT symbol would 
be good.

But then, CONFIG_BLOCK is hidden under CONFIG_EXPERT which selects 
DEBUG_KERNEL (INCREASING KERNEL SIZE!!!) and thus everybody who does 
this patches the kconfig plumbing to be less stupid anyway. So the 
problem isn't JUST renaming the symbol...

(Oh CONFIG_EXPERT is SO STUPID. It's got a menu under it, but 
CONFIG_BLOCK isn't in that menu, it's at the top of menuconfig between 
loadable module support and executable file formats, just invisible 
unless you go down into a menu and switch on a setting and then back out 
to go find it. WHY WOULD YOU DO THAT?)

> New names precisely capture meaning of these variables.

To you. I'm not entirely sure what virt_external means. (Yes I could go 
read the code. No I don't want to. I EXPECT to need context and 
refreshing stuff, but having it change out from under me since the LAST 
time I did that is annoying when it's "same thing, new name, because".)

It makes more sense to YOU because you changed it to smell like you. 
Meanwhile 35 years of installed base expertise in other people's heads 
has been discarded and developed version skew for anyone maintaining an 
existing system. (That's not a "never do this", that's a "be aware 
humans consistently have the wrong weightings in our heads for this".)

Personally I usually have to look it up either way. And am spending more 
and more of my time poking at older kernels rather because newer stuff 
has either removed support for things I need or grown dependencies. (And 
because there's 20 years of installed base still in various stages of 
use, I'm personally likely to spend more time looking at the old names 
than the new ones.)

> This will break all configs out there (update your configs!).
> Still I think this is okay,

Because you don't have to clean up after it.

> because config names never were part of stable API.

I can forward everyone who asks me questions to you, or just agree when 
they tell me it's yet another reason not to upgrade.

> Other user-visible changes:
> 
> - Removed kernel command line parameters "load_ramdisk" and
> "prompt_ramdisk", which did nothing and were deprecated

Sure.

> - Removed kernel command line parameter "ramdisk_start",
> which was used for initrd only (not for initramfs)

Some bootloaders appended that to the kernel command line to specify 
where in memory they've loaded the initrd image, which could be a 
cpio.gz once upon a time. No idea what regressions happened since though.

(Last new bootloader I was involved with that had to make it work used 
some horrible hack editing a dtb at a fixed offset, like the old "rdev" 
trick but more brittle. Because "device tree better" than human readable 
textual mechanism. Fixing ramdisk_start to work right sounded like a 
more sane approach to me, but...)

> I tested my patchset on many architectures in Qemu using my Rust
> program, heavily based on mkroot [1].

You rewrote a 400 line bash script in rust.

Yeah, that's a rust developer. (And it smells like you now...)

> I used the following cross-compilers:
> 
> aarch64-linux-musleabi
> armv4l-linux-musleabihf
> armv5l-linux-musleabihf
> armv7l-linux-musleabihf
> i486-linux-musl
> i686-linux-musl
> mips-linux-musl
> mips64-linux-musl
> mipsel-linux-musl
> powerpc-linux-musl
> powerpc64-linux-musl
> powerpc64le-linux-musl
> riscv32-linux-musl
> riscv64-linux-musl
> s390x-linux-musl
> sh4-linux-musl
> sh4eb-linux-musl
> x86_64-linux-musl

or1k and microblaze work, they just don't pass the full smoketest for 
reasons that shouldn't affect initramfs testing.

I'm still waiting for Rich to ship the next musl release to do new 
toolchains...

https://www.openwall.com/lists/musl/2025/08/04/1

> Workaround
> ====
> If "retain_initrd" is passed to kernel, then initramfs/initrd,
> passed by bootloader, is retained and becomes available after boot
> as read-only magic file /sys/firmware/initrd [3].

Common use case for eg romfs is memory mapped flash or rom, so the 
address range in question isn't actually ram anyway. Mostly on mmu 
systems you just don't want the mapping to go away, so the kernel can 
still reach out and read it.

> This is even better than classic initrd, because:
> - You can use fs not supported by classic initrd, for example erofs

Network block device was the most recent one I saw used, but it had a 
tiny initramfs to set up and switch_root into it...

(Network block device != network filesystem. I have a todo item to 
integrate nbd-server into mkroot/testroot.sh but "-hda works" is one of 
the things it's testing...)

> - One copy is involved (from /sys/firmware/initrd to some file in /)
> as opposed to two when using classic initrd

Embedded developers have always been reaching out and using mappable 
flash directly. Vitaly Wool's ELC talk in 2015 (about running Linux in 
256k of sram, yes one quarter of one megabyte) described the process:

https://elinux.org/images/9/90/Linux_for_Microcontrollers-_From_Marginal_to_Mainstream.pdf

Rob

