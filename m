Return-Path: <linux-fsdevel+bounces-61204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EAFB55ED3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 08:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FCFB1CC1C36
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 06:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD312E7646;
	Sat, 13 Sep 2025 06:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="M+CzmzEW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C61327511F;
	Sat, 13 Sep 2025 06:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757743255; cv=none; b=LiJMQO3OHsBFC913OoE4llKU2EjdStKZFZK7ACHZVuZx87VawJeseN1SZwJcVd3v0jzkqdf6NY2YY/9sIztAUyOiePJnqXv0DebvpNfJdqz4SjBbom64IdUfPWeu+W3TOLC1NcTOD5uQL5EoNCildrFb0NkSpPq11ik0zh9Ojac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757743255; c=relaxed/simple;
	bh=h28c5TxWJadqL6YGponxQMPWMGVBYvFV1IomrQJZdOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAvVHH2gm8X8uywSxlAH/jssMtHJDEUOuQ6O3dySejcjv2QwnWQhgJ17dZk43G1O4etfq2CDYmg6u5m9PEiZ4zMP/YNtpwTGnVXGBZ4gy4S0BCmOVcPSDH/97PcdseDgW1PuOB1nYaf4rl6YpYrZHbp/nboQAkCGssOSjlHymj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=M+CzmzEW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A0B8040E016D;
	Sat, 13 Sep 2025 06:00:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5iEw13_6N0hx; Sat, 13 Sep 2025 06:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1757743247; bh=ukCkckAuGMje9cA2p4fcL/eu4iSUrEgrcmTG6KbdR1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M+CzmzEWar56cJJ17KOTR6P8eSnXvk4pSviym3bg7uW6BkqS0j+mtX3BQDzmjsLKN
	 cBfUjtOzG0dtMWCm8gmhsUa3Xxo4FILO/a/EoDcNG+tlw8kR4uStWeJwPdhqSPG8vi
	 dptoTCZKzdi0Lb7IKesUGcadI0V7LIgtuqv7+ljIAgi+MxFM4i8iy5ZzhN+eNcVDkT
	 2U5qJFAQwTYKNKjXv/HnQbujbbxSSpVXj5bVy2aRYmWxFocdRZ21hDbVAksBWj/ayB
	 IyVl/MGqAXPtO85g0YsubzV7s6ahQw9h0Csu9TVUFWQlf+WnPcHv5LpdW2BLaZTSLx
	 MMPWrLyToEYejhS/laszKvXwNVgYIRKtn46zcfAmgWcVrksJjmgrxaFWOjZaf7IcIu
	 69gMcfJR5mcDILFbprN0LrSSpnH27j6cHrFVqj50Pgarn5Z+5kEA74Cuh7F+wkwKag
	 IgiVg9veF2ZWXTokCLUb6KziC0viJ3MFRPeERhFpkN9McnxLf/Lom5CWCUO/GLLsrO
	 Ik0vYi9bLtv3NWaKGrZ5U38zUX6p3F6aTmchXQOEPOWj3S4lIPOayyV2rrbopxaE+l
	 7bAPj5LxiMGFgfJow+wWYdkCpmcS3w+RlVWftduP1hFNqKDXn6mv7Glb2r+ccLg5uk
	 Ktt/rgo0zlxIwboDscbgVlBU=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 3961D40E015C;
	Sat, 13 Sep 2025 05:59:52 +0000 (UTC)
Date: Sat, 13 Sep 2025 07:59:45 +0200
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
	Alexander Graf <graf@amazon.com>, Rob Landley <rob@landley.net>,
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
Message-ID: <20250913055851.GBaMUIGyF8VhpUsOZg@fat_crate.local>
References: <20250913003842.41944-1-safinaskar@gmail.com>
 <20250913003842.41944-29-safinaskar@gmail.com>
 <20250913054837.GAaMUFtd4YlaPqL2Ov@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250913054837.GAaMUFtd4YlaPqL2Ov@fat_crate.local>

On Sat, Sep 13, 2025 at 07:48:37AM +0200, Borislav Petkov wrote:
> On Sat, Sep 13, 2025 at 12:38:07AM +0000, Askar Safin wrote:
> > Rename initrd_start to virt_external_initramfs_start and
> > initrd_end to virt_external_initramfs_end.
> 
> "virt" as in "virtualization"?

Ooh, now I see it - you have virtual and physical initramfs address things. We
usually call those "va" and "pa". So

initramfs_{va,pa}_{start,end}

perhaps...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

