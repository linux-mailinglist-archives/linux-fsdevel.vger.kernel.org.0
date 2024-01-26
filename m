Return-Path: <linux-fsdevel+bounces-9127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3A683E58B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 23:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15DEC1F2274F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 22:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E039347F4C;
	Fri, 26 Jan 2024 22:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vyGeS6o0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A86A481A8;
	Fri, 26 Jan 2024 22:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308456; cv=none; b=JZkBaCxQINLwkqef27ykez4ZwCvu2hN40pwO+EIvKkUbUsbCfXMD0uIenpl+5Q/pdmZp8PUcfJjjSFm5UEgBq9IG3MkXw6ojxmt8/8A91LVa4nTn/p4knYpKNWOYB3zO6/zhrcF8XKeGOpcqlXjuy7VWmOSBpJKqNdBVOO0Yzm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308456; c=relaxed/simple;
	bh=zkqoCMyzx2qjq6i147OphYeumAhy30zhpTYu2BLN/JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikkHnUSb7BXYmEGv6SLSqV5y/ueXiFYatBpG/ScWAV3OGH8tWiERYspAIPV7VnanO2XozBq8jkVYds1l3GhaNPCCD1ltMGXVcgoW+PaiFixJpZSMJxWBaipRJ3xzH8rLFUZbSdlnVZTRM4Fsnk4bN+6iJApm+5Oj5sMJKs95cLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vyGeS6o0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mYAHlDNex9wbOcNfsf4H6GLUDwhTljs91llwoVK/dq0=; b=vyGeS6o07MbDfrCWspAlhgVycZ
	cN65OoiUOsC1wTLBqHHlBxoo9Vkt/FMvoMZEIu8tHg8K7KA8H9X+SBPiVz5HtVJCWoj0i0/HLJVVk
	Wbwre1op0p0HQ2pR3v3fCak9tdOGalPQg0r93GnFvDm2ya0CyCEa1e7aqD1m7HsLoicdwK/4hJuo3
	HaHxL5mNIGDEOCQ3Jp8J0F96ATfFtg1oczGu4HO/+plhD/MXV4MZwc+fewZJjk5vdx3jPChppdncO
	QXmaKhZjUCwUlui5xbgWkonFBWEk0lqgKsA9uh9FR2I7cZEh8FrioXNrcfDp4jtdgrE+e7P7WOXE7
	AxBlM9dQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTUlx-0000000F3X4-3QSg;
	Fri, 26 Jan 2024 22:34:06 +0000
Date: Fri, 26 Jan 2024 22:34:05 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
Message-ID: <ZbQzXfqA5vK5JXZS@casper.infradead.org>
References: <20240126150209.367ff402@gandalf.local.home>
 <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home>
 <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
 <8547159a-0b28-4d75-af02-47fc450785fa@efficios.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8547159a-0b28-4d75-af02-47fc450785fa@efficios.com>

On Fri, Jan 26, 2024 at 05:14:12PM -0500, Mathieu Desnoyers wrote:
> I would suggest this straightforward solution to this:
> 
> a) define a EVENTFS_MAX_INODES (e.g. 4096 * 8),
> 
> b) keep track of inode allocation in a bitmap (within a single page),
> 
> c) disallow allocating more than "EVENTFS_MAX_INODES" in eventfs.

... reinventing the IDA?

