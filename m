Return-Path: <linux-fsdevel+bounces-45922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F42AA7F3FE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 07:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C237E165B1A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 05:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE69226170;
	Tue,  8 Apr 2025 05:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jARFzccI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FA2198A08;
	Tue,  8 Apr 2025 05:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744088799; cv=none; b=hLRZmGyHSizwH0pgaH2BjYnXMTB9spyaat2dS30tDEkMMTwPIt+x5yG40sUQ60NwDAr0W8dHs3okSETcAwzi2N8+stODPOuwJcWTUF251hsiTL336pZhGJYlK5mZUTeIMyvQBG2UwTLxJFZDbED1Qg/O9J3KeisSMxD18dhwaQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744088799; c=relaxed/simple;
	bh=jPL4cTU4N6dYBSPim5l270hzGtFyOzB6FzEPjgLY3kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHUYiAoF6aH8V0fg9ARBWr3V5m33eNZkxMfkOcirv3PnzmHykh7lSwZ22VrebwgG+ESQ2QLYF3thaWv5YMcN2SO0HikXp3OPFble9VnGedtEtAj3fQ1b5tK7KtGCEY3+vQS5EMT0DgzSEOI5973NH1/XsO1z5y5kAVo5+XVFxJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jARFzccI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m8Z5pGk0dbqJmSQOK+i21T/S62P6WzGFJz441PZRy1c=; b=jARFzccIfDIp38VY/PA5iB1jqP
	yAdP8IcJL5fYzpooPyTIMHr6HH6p5uzEUEgvD98dVPXPI6KOpEY2DW1/iYKcvUiivefspvAXhqiNZ
	hDvg5dHkO6aIkGIv1yrfnjG1mq33DHRrszr4tcl51Q+ljw0geVhODMDewN9cbiSvH48HvXgJVvRKV
	ibaXXRW0MmuLBlBwTb9qy8VZM2XZYt9qidXkF50owI9vTIfw63JSWuNrQbxnyARkKjltPu7gb/S1v
	Jt1ds0PKO9sIYSPdCh9g2caVh1H7xoXTBd4UCOwrLekPYLagal+Gn42Kz/ijt1NKKgN1Kx932XAYu
	pwLZDwhA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u21AP-00000002kVB-2Vrr;
	Tue, 08 Apr 2025 05:06:33 +0000
Date: Mon, 7 Apr 2025 22:06:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Christian Brauner <brauner@kernel.org>,
	Leon Romanovsky <leon@kernel.org>, pr-tracker-bot@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs mount
Message-ID: <Z_Su2cIL2U27mZ-N@infradead.org>
References: <20250401170715.GA112019@unreal>
 <20250403-bankintern-unsympathisch-03272ab45229@brauner>
 <20250403-quartal-kaltstart-eb56df61e784@brauner>
 <196c53c26e8f3862567d72ed610da6323e3dba83.camel@HansenPartnership.com>
 <6pfbsqikuizxezhevr2ltp6lk6vqbbmgomwbgqfz256osjwky5@irmbenbudp2s>
 <CAHk-=wjksLMWq8At_atu6uqHEY9MnPRu2EuRpQtAC8ANGg82zw@mail.gmail.com>
 <Z--YEKTkaojFNUQN@infradead.org>
 <CAHk-=wjjGb0Uik101G-B76pp+Xvq5-xa1azJF0EwRxb_kisi2Q@mail.gmail.com>
 <Z_OSEJ-Bd-wL1CpS@infradead.org>
 <CAHk-=wgtKqZoQZB6VzJr+EQNfsT1r1A9U2zxOrGFb+pqtkTXFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgtKqZoQZB6VzJr+EQNfsT1r1A9U2zxOrGFb+pqtkTXFA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 07, 2025 at 09:00:10AM -0700, Linus Torvalds wrote:
> On Mon, 7 Apr 2025 at 01:51, Christoph Hellwig <hch@infradead.org> wrote:
> >
> > The scoped one with proper indentation is fine.  The non-scoped one is
> > the one that is really confusing and odd.
> 
> Ahh, I misunderstood you.
> 
> You're obviously right in a "visually obvious" way - even if it was
> the scoped one that caused problems.
> 
> But the non-scoped one is *so* convenient when you have a helper
> function that just wants to run with some local (or RCU) held.

I wish we'd just hage a way to run an existing scope, especially a
funtion fun with a lock, e.g.

int some_helper(....)
	scoped_lock(&some_mutex)
{
	...
}

which would give you that with a much more obvious and redable
syntax.  Not taking the resource in the middle of the block and
releasing it at the end will also fix tons of bugs for non-obvious
behavior.


