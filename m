Return-Path: <linux-fsdevel+bounces-61672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D852B58C39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 05:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CA702A843B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F169D261B92;
	Tue, 16 Sep 2025 03:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBxS8q66"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF09F38DDB;
	Tue, 16 Sep 2025 03:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757992145; cv=none; b=WA2g4hKhi8FJxBnR+HLPnFq1p89CC8OcTKGM9XQBFxyaJrW8PAIgaMgaGcEVlJPgr8mEt9RxJWq4Tq4Au6QsKmVjBLTnfXgv6stvc/6Cvvv8LxKOfVk4og4S9TRa7UugJ0qX1SQR8XdS5tpnouSdqGSG+rWXpCAdoVIROMLZwgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757992145; c=relaxed/simple;
	bh=clS/RriAH6/uzgbxBAN8eXzKr1t8+yo2uadqdbTxw+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KB3eGyhxwCbq+5Ki7pt2ptUepUu1YXigfVHskFBo/vQYvXrYvkG7sLNYiQ2+EncvNjRoYzkP9yy5sEsDhcUgi3UYKxelpcgDIprZUTC4o3twu+NmB/XfNC3J9OZvX25rj8UvpAWdHkRzO/l8RmYqh5OJCRFRhHPF23eAFNNRvMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBxS8q66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD31C4CEF1;
	Tue, 16 Sep 2025 03:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757992144;
	bh=clS/RriAH6/uzgbxBAN8eXzKr1t8+yo2uadqdbTxw+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bBxS8q66YdKGXiHFPJJ3//BAWLCIYoh1qbHxHfe2QgUS7fzvi8AFYBbIitGKJPiDy
	 J0h5xdTTy4wuRH1ymZPr5e0f/C36eUMrkOUag+lWBj8YkZln2Sd8hzT0pfkU01q17O
	 RT8NuwYenprY6H9Bdb8qKRjkND6VpsGEt1Rf1iUB6mNa5MQsHkHWoiFIr0vmJLaUBy
	 +Mg6Bb5Jrp6AOX9r3GJRBHhtRWiiY7tieeEbNFvl6251o5yIBpkK00NoObReShSwrw
	 BlICrcV2YfDygf6hS1MD81NdPJlMqltFalaDERfXuFBjtYfsWMd22V+qS8nHm3+ffq
	 gVOH5pLBuuEEw==
Date: Mon, 15 Sep 2025 22:09:03 -0500
From: Rob Herring <robh@kernel.org>
To: Askar Safin <safinaskar@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
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
Message-ID: <20250916030903.GA3598798-robh@kernel.org>
References: <20250913003842.41944-1-safinaskar@gmail.com>
 <20250913003842.41944-29-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913003842.41944-29-safinaskar@gmail.com>

On Sat, Sep 13, 2025 at 12:38:07AM +0000, Askar Safin wrote:
> Rename initrd_start to virt_external_initramfs_start and
> initrd_end to virt_external_initramfs_end.

There's not really any point in listing every arch in the subject.

Rob

