Return-Path: <linux-fsdevel+bounces-9208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 348AE83EDBD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 15:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C891F2242B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 14:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A7B28DAE;
	Sat, 27 Jan 2024 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="eGPk/ly2";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="eGPk/ly2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B948C25629
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706367556; cv=none; b=buEzMgvaoTFwYYhui9BlO9R8H85QbXlvvT3tlvCeDDHY9LyVV3kJSxO2tbQuHSGs8jXIxNqscw4FxmAGf5TpE6dXlaPYjEoCEeqX6gLX8zFDnu3jdtYVNP6EAYk1sdl3L/I5GM0hYpn8KoeuWOL1GIaEDYpyoFttcr3Em1l+aj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706367556; c=relaxed/simple;
	bh=jk7bFkoYzF+XHYrzjj0iuyo/A5nRVpoWxmzEke5I2tU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RD727JgqfU1aejh9yU0kk9MjkSscyf5RoCqYr9cqerohK7+nB+o5bVSUBoxtSeaPSufEqvbdMcogskFeT9ZT91C+lKOLNZ4StYiyZmFdML0s3/XUGhXOmWRUUq6x7WnnbZCeH3E/R/vgwUNl2dr4bq0ads6mifFzs5qUXGQ+UL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=eGPk/ly2; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=eGPk/ly2; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1706367553;
	bh=jk7bFkoYzF+XHYrzjj0iuyo/A5nRVpoWxmzEke5I2tU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=eGPk/ly2W+0rxG8znMh2lGom/4lK474TgBh0vHrn2eYKfvtGQajuVJAiomsuUUssG
	 Sw20WzUKi92m7QyyjKjVGgfD5irZFWBIEUFFJ53pjT9Kfrl//u2aCjL2TR/LZeKias
	 DFkWUzuMcAQO2FdPi/JUuKpPh2mKFxKJ9kjRM/18=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8ABB91281BDA;
	Sat, 27 Jan 2024 09:59:13 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id kmTTlxDjm9JL; Sat, 27 Jan 2024 09:59:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1706367553;
	bh=jk7bFkoYzF+XHYrzjj0iuyo/A5nRVpoWxmzEke5I2tU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=eGPk/ly2W+0rxG8znMh2lGom/4lK474TgBh0vHrn2eYKfvtGQajuVJAiomsuUUssG
	 Sw20WzUKi92m7QyyjKjVGgfD5irZFWBIEUFFJ53pjT9Kfrl//u2aCjL2TR/LZeKias
	 DFkWUzuMcAQO2FdPi/JUuKpPh2mKFxKJ9kjRM/18=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8C2C81281947;
	Sat, 27 Jan 2024 09:59:12 -0500 (EST)
Message-ID: <d661e4a68a799d8ae85f0eab67b1074bfde6a87b.camel@HansenPartnership.com>
Subject: Re: [LSF/MM TOPIC] Making pseudo file systems inodes/dentries more
 like normal file systems
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Amir Goldstein <amir73il@gmail.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Christian Brauner <brauner@kernel.org>, Al Viro
	 <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 27 Jan 2024 09:59:10 -0500
In-Reply-To: <CAOQ4uxjRxp4eGJtuvV90J4CWdEftusiQDPb5rFoBC-Ri7Nr8BA@mail.gmail.com>
References: <20240125104822.04a5ad44@gandalf.local.home>
	 <2024012522-shorten-deviator-9f45@gregkh>
	 <20240125205055.2752ac1c@rorschach.local.home>
	 <2024012528-caviar-gumming-a14b@gregkh>
	 <20240125214007.67d45fcf@rorschach.local.home>
	 <2024012634-rotten-conjoined-0a98@gregkh>
	 <20240126101553.7c22b054@gandalf.local.home>
	 <2024012600-dose-happiest-f57d@gregkh>
	 <20240126114451.17be7e15@gandalf.local.home>
	 <CAOQ4uxjRxp4eGJtuvV90J4CWdEftusiQDPb5rFoBC-Ri7Nr8BA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Sat, 2024-01-27 at 12:15 +0200, Amir Goldstein wrote:
> I would like to attend the talk about what happened since we
> suggested that you use kernfs in LSFMM 2022 and what has happened
> since. I am being serious, I am not being sarcastic and I am not
> claiming that you did anything wrong :)

Actually, could we do the reverse and use this session to investigate
what's wrong with the VFS for new coders?  I had a somewhat similar
experience when I did shiftfs way back in 2017.  There's a huge amount
of VFS knowledge you simply can't pick up reading the VFS API.  The way
I did it was to look at existing filesystems (for me overlayfs was the
closes to my use case) as well (and of course configfs which proved to
be too narrow for the use case).  I'd say it took a good six months
before I understood the subtleties enough to propose a new filesystem
and be capable of answering technical questions about it.  And
remember, like Steve, I'm a fairly competent kernel programmer.  Six
months plus of code reading is an enormous barrier to place in front of
anyone wanting to do a simple filesystem, and it would be way bigger if
that person were new(ish) to Linux.

It was also only after eventfs had gone around the houses several times
that people suggested kernfs; it wasn't the default answer (why not?).
Plus, if kernfs should have been the default answer early on, why is
there no documentation at all?  I mean fine, eventfs isn't really a new
filesystem, it's an extension of the existing tracefs, which is perhaps
how it sailed under the radar until the initial blow up, but that still
doesn't answer how hostile an environment the VFS currently is to new
coders who don't have six months or more to invest.

James


