Return-Path: <linux-fsdevel+bounces-53604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971EBAF0E69
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 10:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05FB7486ECE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 08:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3781023C390;
	Wed,  2 Jul 2025 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l8JlshGA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE951A5BA4
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751446144; cv=none; b=J5uOD35brsaT7DlNx0OwSo5jY+ypAkoBahvVJREBM0vU14OdK88w1tybVCYMedP0gUldcILkd54OAlysKhwfYxENdJMZZs/3NtHtkQHoSiLxSzaLHGJyqz+rvca/BluOykOJrWobAO3yjptHH/C/elv/spqpRShyMIfK/YwX3yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751446144; c=relaxed/simple;
	bh=K/rY4/YLVyXSRiQf6FdvumyYfhAjp27chDiUsvy6IZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDNSPuJf04yaX91ZUmWibwAeFJ6ntOw5wm46lCStBNgV058i7SrUfq+h0BnG1VKhfWVanR4dV9oIXQ8j1Vhj1fe0oWiL/V5AM1ufnQ83EODmaLzPgUifmHUEdQnpqMwg+f5II/pxzzX4weZ3vxJk1fZMMNGuUGoHI2zOYrNJtGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l8JlshGA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HkMc/CIi85pPWGrV3QOu3d+l6oxfx+tUJsl+CMih4sw=; b=l8JlshGAg3ypPeV5ZnKMAFTE6R
	k8DBz7ad9PYQ9q8u21MMxLeNtGEdudAFFDbTHju2axQdib0yYj3bwuIRaBsOOfsD3y96e+JGrNT83
	N3CGDckYQtnP0PalsWQD6F7M9hgAS/b9S4noS/foEA4C0U5sGgStvCcMhXlA6LmR1G3a2gzPDV65c
	UTXc6jHMb1V8zBJTQPwdO6XIJEMZyZu36ujLFeo09gbCKhdixbnxO1mqKc4Cl/JXR72tJNSWDSXpI
	q545gnVd8EE7jrCxg31rdXbOoPip/OVpSsTQXVIor8CqCvEE13dXvB2m/GwR+BekygXi9sJ8OHDaY
	JJ8x8RMQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWt9I-00000009Js8-0ZGc;
	Wed, 02 Jul 2025 08:49:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AA321300125; Wed, 02 Jul 2025 10:48:59 +0200 (CEST)
Date: Wed, 2 Jul 2025 10:48:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, "Ahmed S. Darwish" <darwi@linutronix.de>,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH][RFC] fold fs_struct->{lock,seq} into a seqlock
Message-ID: <20250702084859.GO1613200@noisy.programming.kicks-ass.net>
References: <20250702053437.GC1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702053437.GC1880847@ZenIV>

On Wed, Jul 02, 2025 at 06:34:37AM +0100, Al Viro wrote:
> 	The combination of spinlock_t lock and seqcount_spinlock_t seq
> in struct fs_struct is an open-coded seqlock_t (see linux/seqlock_types.h).
> 	Combine and switch to equivalent seqlock_t primitives.  AFAICS,
> that does end up with the same sequence of underlying operations in all
> cases.
> 	While we are at it, get_fs_pwd() is open-coded verbatim in 
> get_path_from_fd(); rather than applying conversion to it, replace with
> the call of get_fs_pwd() there.  Not worth splitting the commit for that,
> IMO...
> 
> 	A bit of historical background - conversion of seqlock_t to
> use of seqcount_spinlock_t happened several months after the same
> had been done to struct fs_struct; switching fs_struct to seqlock_t
> could've been done immediately after that, but it looks like nobody
> had gotten around to that until now.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Right, looks sane.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

