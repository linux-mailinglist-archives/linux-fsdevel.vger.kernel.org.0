Return-Path: <linux-fsdevel+bounces-61202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B633BB55EAD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 07:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DAE3A44D4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 05:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C206A2E370C;
	Sat, 13 Sep 2025 05:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jlbk0Qit"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3111526980B;
	Sat, 13 Sep 2025 05:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757742591; cv=none; b=EuHtPQAbHyoZbL5VP4NFRRG0fZahekQo7RMBz7FjolFts2zjq4WLYGRgpCU+Yra6LVs5NXfUtLPBvuXGkVGi6ZVyL4J7p4kPgWDYiyF2zVDLBT8A/vKiPU5AQgO7Ho80bxZX5LJIISKl7PQrWQys5Hg+y14crLPRLB2ccGSozSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757742591; c=relaxed/simple;
	bh=bvzib782/q+pYPXnbG9t6dpHoBHU9ny8U4YkFIWbMYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uul8H1aFiQ2ewsDHObRHzjuVgk18kvuN2F6XHW/i2W3WVn/MO+Z4NZq8Sb480UhYhV6w2grYAqUKkU5cRsNN0kb0wZmdU4MdrDqSGaE2EyYKcR0uqccvdEHj6ou6YdU1JVd2vLC2ZJv3/Lw/2ipOHXPn0qoi7wbgCLxAYUKAtvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jlbk0Qit; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C3A3940E0174;
	Sat, 13 Sep 2025 05:49:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ojZM34cNAwPe; Sat, 13 Sep 2025 05:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1757742581; bh=msWjE/k4XDYFNkRqUljSzhRmzL+P+KgKrTjqUiQu4aI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jlbk0QitQVlp4rvpHe4vCXkRS2hvjoafx60Hi3+Hnx26MFN20WwiEWDlh3HCMXF/Y
	 B7stY6Fyr3vILBwsJcBAqlOW5BxLtsbMmB1EXIFUnlm4GzKlbw7UGM+DEcOseX75hg
	 FPGD/5ZdIiie/I55kLSBsHbTf5YW4dXDvezwU3bEqbq+FV7hIpAAHI6N3sgA2AvmXD
	 3vQ0WadXH8uby4Ww6hVk8ohOCEr7dq/AnKiN+L5+0Qzw4HOeJ3KVUC98nYqPW67/YW
	 aWpHSco3t3XyDwybSqnHdHsxJKU+VPv8otpwQRhG6Y850pLGVP+5QN03U8HBcvg3qJ
	 YYfb20vCSvE4Ai0U8A9cSf9IR1mIJgy5iyavsFYWrU9iyZHBF0AYZx+WI/zWF0+N3j
	 yYr/9bod0cW556Z6BwicNX0j4oLecbtI6kPTnTbfq9PIQRnjY49acw04OtWrRYjsbI
	 DQkmlnaai3jYlBnsa1AnTSuTPIrVsWOuuni4+sHz/DQnxpwepInt7QWlTbdwLusW58
	 k1GUpFnyMOR6rD+nZ2jz9MpyEHSQd/x6SVjlXFFhbnW6MajvATDtW+vN0PIKR+kSvH
	 J/wpw42BbFvcsBnYbs2215b0y4rQlOHZTMFHZvjKHk3GMUIDXA+gFVW3s7E2BwGo8u
	 197mO9Gq+6sAN+bvVMZHrolI=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 8EFB740E0140;
	Sat, 13 Sep 2025 05:48:45 +0000 (UTC)
Date: Sat, 13 Sep 2025 07:48:37 +0200
From: Borislav Petkov <bp@alien8.de>
To: Askar Safin <safinaskar@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>, Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org, initramfs@vger.kernel.org,
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>, linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>, devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>, patches@lists.linux.dev
Subject: Re: [PATCH RESEND 28/62] init: alpha, arc, arm, arm64, csky, m68k,
 microblaze, mips, nios2, openrisc, parisc, powerpc, s390, sh, sparc, um,
 x86, xtensa: rename initrd_{start,end} to
 virt_external_initramfs_{start,end}
Message-ID: <20250913054837.GAaMUFtd4YlaPqL2Ov@fat_crate.local>
References: <20250913003842.41944-1-safinaskar@gmail.com>
 <20250913003842.41944-29-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250913003842.41944-29-safinaskar@gmail.com>

On Sat, Sep 13, 2025 at 12:38:07AM +0000, Askar Safin wrote:
> Rename initrd_start to virt_external_initramfs_start and
> initrd_end to virt_external_initramfs_end.

"virt" as in "virtualization"?

That's not confusing at all... :-\

And "external" means what?

> They refer to initramfs, not to initrd

Why not simply initramfs_{start,end} if they belong to it?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

