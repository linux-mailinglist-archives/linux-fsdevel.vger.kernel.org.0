Return-Path: <linux-fsdevel+bounces-26266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2121956BEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 15:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E321C22769
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 13:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBFA16DEB6;
	Mon, 19 Aug 2024 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pnrb7YBJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44FC16C84A;
	Mon, 19 Aug 2024 13:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724073736; cv=none; b=Pxe7v39jwipbd3A3G4BOvPd3yr/x6VE5BENvP6AhCidDE0z4m0VCUiVuGzQXJ5IRgPQxWnyNNo5WR4yEC4WqPkPmVldWyb9BobrTzX6k/QjvE01uE+zaYitFLiX5qmekOvZHaFpM+bco4xZtdgi7Tuve5m4rSasXlLvdv4BNT70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724073736; c=relaxed/simple;
	bh=kKHKTTTD8zi67vICLMaaD4gd7kZAlugx8Ly24EoYvc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EN7MaBi86MxKYV4ygU3SkjpyZIhfU+9m1FPTs6FDTotn/O9nF6Ev1xOU5FGVpfdCXzcx/0tbNzN95oKTSrsGJpfMnhbBXqK4NBC+/voxi+hKZS5mSAovtz4DKHBD+bbqmIq1MG+VEEm3aq9fEG/UhDi8laC8o6ZfazABwfOLZ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Pnrb7YBJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IBvszCWkiNzillg0FDR74Luw2/OWMERi5dJ9uDggJx4=; b=Pnrb7YBJqQ9c05egI9ygDVyehx
	x/yK6WxP/JWiK2b8MGjVLcSKJURGdZ2ZKjjsZ3lV9SZa1eXznDrry6LM0S7WylPTdCAZ4Wb2syEOP
	bm++UI6tLd54jeLe5nCKvXFzBUTUgB4amejMXWk907JKR52pQbpx/pBB7UsoiUh+AlXtt9MPymQwB
	KWWSpNfTr4hxRI7nOZ/U3AJnXeuFM+4/Rxt7/u2kBy94NLjZskEhPSiaFF49zJ0DM4nsbC6ZdrPRJ
	uBeks3BLHY/13ebjZJwH4x+4as38Zr7F34XFnEfKGmIuRFEWQ+3K2FQ4LqEvzRJ9GUql/ToW2Tkkn
	LcNV2dIg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg2Kh-00000006ln8-0Be6;
	Mon, 19 Aug 2024 13:22:03 +0000
Date: Mon, 19 Aug 2024 14:22:02 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Hui Guo <guohui.study@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Carlos Llamas <cmllamas@google.com>, Jens Axboe <axboe@kernel.dk>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: stack-out-of-bounds Write in end_buffer_read_sync
Message-ID: <ZsNG-teuPe8Tch25@casper.infradead.org>
References: <CAHOo4gJyho_xXKRJB52qTJuCrrq9L-RL59XYyo_oS5+vN7Osiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHOo4gJyho_xXKRJB52qTJuCrrq9L-RL59XYyo_oS5+vN7Osiw@mail.gmail.com>

On Mon, Aug 19, 2024 at 08:50:48PM +0800, Hui Guo wrote:
> Hi Kernel Maintainers,
> Our tool found the following kernel bug "KASAN: stack-out-of-bounds
> Write in end_buffer_read_sync" on:
> HEAD Commit: 6b0f8db921abf0520081d779876d3a41069dab95 Merge tag
> 'execve-v6.11-rc4' of
> git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
> kernel config: https://github.com/androidAppGuard/KernelBugs/blob/main/6b0f8db921abf0520081d779876d3a41069dab95/.config
> repro log: https://github.com/androidAppGuard/KernelBugs/blob/main/6b0f8db921abf0520081d779876d3a41069dab95/d41d191102504ccfea2e8408a29f03973e4ccc81/repro.log
> syz repro: https://github.com/androidAppGuard/KernelBugs/blob/main/6b0f8db921abf0520081d779876d3a41069dab95/d41d191102504ccfea2e8408a29f03973e4ccc81/repro.prog
> 
> Please let me know if there is anything I can help.

You could bisect it to the commit that introduced the problem

