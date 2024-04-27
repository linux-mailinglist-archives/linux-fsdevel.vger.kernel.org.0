Return-Path: <linux-fsdevel+bounces-17968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DED8B44F2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 09:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D56F91C21355
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 07:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8E545948;
	Sat, 27 Apr 2024 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="gEqEbcAY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38483376EC;
	Sat, 27 Apr 2024 07:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714203652; cv=none; b=UY1otfYt7LzaThluwcz4PqDrjfBzo61C7gJOuXywvhysJTpledZs9sAClSmpGbrhWsVaDYCRzEAtXTdjuME8dCcDRfEm/qFUQdGYxefw2bjVfD7emapmOtWMAuF3jXo1Vh2z/rLwUjLjEWcjSxcwFcRw3oXQR2lrYtRkq1/TDEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714203652; c=relaxed/simple;
	bh=CzgUKxV1DiRGrX9zQXzZL6Gotui8EXJUqYQ3eQT9fT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EldON3TuhubwZAoNWjdObGunaICbj7oTMsx5nhciB0CMEiZ76f/cBRB9AJTeoRbsLyAv6WPgwpS4WlNdUhZ8IP6in0Aflo7GIy7d0cFxduAzBPcQ9JYnLlP5wI90lnkBr/+olVU+D5IPfDqqastftUc2DBKBdaTuhXzRdhnLui4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=gEqEbcAY; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1714203646;
	bh=CzgUKxV1DiRGrX9zQXzZL6Gotui8EXJUqYQ3eQT9fT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gEqEbcAYbNH1Cl76LGX0IqteTFz6QZM2G7WkdPY5ve6JFJe7QvQdYePk2UkJVcvTR
	 6u5FIHxh7+/FsU6vrbi0R0NpqVH+T4CvlFrv7BQ8Kzndu1PmGsnulYTnxUn5nJrEUi
	 e3WiuV0em4CHQ+eAmWIJfWacyiMhggB7HEWeZqN8=
Date: Sat, 27 Apr 2024 09:40:43 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Jakub Kicinski <kuba@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Joel Granados <j.granados@samsung.com>
Cc: Kees Cook <keescook@chromium.org>, Eric Dumazet <edumazet@google.com>, 
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-xfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, kexec@lists.infradead.org, 
	linux-hardening@vger.kernel.org, bridge@lists.linux.dev, lvs-devel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
	linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com
Subject: Re: [PATCH v3 00/11] sysctl: treewide: constify ctl_table argument
 of sysctl handlers
Message-ID: <38a87a0f-02c7-4072-9342-8f6697ea1a17@t-8ch.de>
References: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
 <20240424201234.3cc2b509@kernel.org>
 <9e657181-866a-4626-82d0-e0030051b003@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e657181-866a-4626-82d0-e0030051b003@t-8ch.de>

On 2024-04-25 09:10:27+0000, Thomas Weißschuh wrote:
> On 2024-04-24 20:12:34+0000, Jakub Kicinski wrote:
> > On Tue, 23 Apr 2024 09:54:35 +0200 Thomas Weißschuh wrote:
> > > The series was split from my larger series sysctl-const series [0].
> > > It only focusses on the proc_handlers but is an important step to be
> > > able to move all static definitions of ctl_table into .rodata.
> > 
> > Split this per subsystem, please.
> 
> Unfortunately this would introduce an enormous amount of code churn.
> 
> The function prototypes for each callback have to stay consistent.
> So a another callback member ("proc_handler_new") is needed and users
> would be migrated to it gradually.
> 
> But then *all* definitions of "struct ctl_table" throughout the tree need to
> be touched.
> In contrast, the proposed series only needs to change the handler
> implementations, not their usage sites.
> 
> There are many, many more usage sites than handler implementations.
> 
> Especially, as the majority of sysctl tables use the standard handlers
> (proc_dostring, proc_dobool, ...) and are not affected by the proposed
> aproach at all.
> 
> And then we would have introduced a new handler name "proc_handler_new"
> and maybe have to do the whole thing again to rename it back to
> the original and well-known "proc_handler".

This aproach could be optimized by only migrating the usages of the
custom handler implementations to "proc_handler_new".
After this we could move over the core handlers and "proc_handler" in
one small patch that does not need to touch the usages sites.

Afterwards all non-core usages would be migrated back from
"proc_handler_new" to "proc_handler" and the _new variant could be
dropped again.

It would still be more than twice the churn of my current patch.
And these patches would be more complex than the current
"just add a bunch of consts, nothing else".

Personally I still prefer the original aproach.


Thomas

