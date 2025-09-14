Return-Path: <linux-fsdevel+bounces-61262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04022B56C17
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 22:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CAF11897F02
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 20:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098022E7BDA;
	Sun, 14 Sep 2025 20:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2UPxRGMw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92F8EEAB;
	Sun, 14 Sep 2025 20:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757880804; cv=none; b=MyB2Gwyu1BOl0hAoRbOp+7v4Qz6eKsfNO4fR69Z5DlP2Bm2/EpqHpaX3ADhgUCrt8Zt3bOYLuKolTii5c8EvseGYI6Lg65JHlTj/trkkBlr1xmqRYxxl6NO8/w5Lqjl+Gj0yPHZrakntpFwKMFx8fl9oXX9uW4TLrC1fOBDAyIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757880804; c=relaxed/simple;
	bh=S1O2mYg/nuSFWiepEfi3INn1/VxeJMAKyzsDV4vYqvg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=J+jptC/J4YKLwKI3aHT7snFfP84NJQk0HTR18Ww5e2AXCQg3c6guvNc9b3LB3SOubHVnQHwAP6wzn+xnhQlwtRG/xPpZ4PicPNMfgb41hm3EfwS3OTsNwBXv5FciZQTzyw1WObPXMCJhz+FNCsWkcCzc3PW2ZIGvVRKS+Izs6CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2UPxRGMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D19C4CEF0;
	Sun, 14 Sep 2025 20:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757880803;
	bh=S1O2mYg/nuSFWiepEfi3INn1/VxeJMAKyzsDV4vYqvg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2UPxRGMw8I/maQZ+HN3ir+gn07zWGBMkkdWTdW2X4OKEgkpUDDbZLiyj3E0pJDtL3
	 1+D42ZKa/D0blrtutGoeATk6sFzQAtpGrIpNKIWACFz+9+7ensOkK9v2abyA5QnetQ
	 dB1gPfBNpyMhvJhlFN9WW4x1lQUIWNYqbIuD5q6A=
Date: Sun, 14 Sep 2025 13:13:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Askar Safin <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, Al
 Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig
 <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, Thomas
 =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, Julian
 Stecklina <julian.stecklina@cyberus-technology.de>, Gao Xiang
 <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, Eric
 Curtin <ecurtin@redhat.com>, Alexander Graf <graf@amazon.com>, Rob Landley
 <rob@landley.net>, Lennart Poettering <mzxreary@0pointer.de>,
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
 linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, "Theodore Y . Ts'o"
 <tytso@mit.edu>, linux-acpi@vger.kernel.org, Michal Simek
 <monstr@monstr.eu>, devicetree@vger.kernel.org, Luis Chamberlain
 <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, Thorsten Blum
 <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>,
 patches@lists.linux.dev
Subject: Re: [PATCH RESEND 21/62] init: remove all mentions of
 root=/dev/ram*
Message-Id: <20250914131321.df00dfc835be48c10f4cce4b@linux-foundation.org>
In-Reply-To: <a079375f-38c2-4f38-b2be-57737084fde8@kernel.org>
References: <20250913003842.41944-1-safinaskar@gmail.com>
	<20250913003842.41944-22-safinaskar@gmail.com>
	<a079375f-38c2-4f38-b2be-57737084fde8@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Sep 2025 12:06:24 +0200 Krzysztof Kozlowski <krzk@kernel.org> wrote:

> >  Documentation/admin-guide/kernel-parameters.txt          | 3 +--
> >  Documentation/arch/m68k/kernel-options.rst               | 9 ++-------
> >  arch/arm/boot/dts/arm/integratorap.dts                   | 2 +-
> >  arch/arm/boot/dts/arm/integratorcp.dts                   | 2 +-
> >  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-cmm.dts     | 2 +-
> >  .../boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dts    | 2 +-
> >  .../arm/boot/dts/aspeed/aspeed-bmc-facebook-minipack.dts | 2 +-
> >  .../arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge100.dts | 2 +-
> >  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge40.dts | 2 +-
> >  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yamp.dts    | 2 +-
> >  .../boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi  | 2 +-
> 
> No, don't do that. DTS is always separate.

Why can't DTS changes be carried in a different tree?

