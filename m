Return-Path: <linux-fsdevel+bounces-64985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833F4BF7E1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 19:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4872958137E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E64635581B;
	Tue, 21 Oct 2025 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sH0HieRS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E281355804;
	Tue, 21 Oct 2025 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067163; cv=none; b=NHJcQ0uvYW/ll+bkvoYTu5/v+t+N/DXmTaiw7AgXlivQ9CgIsQgmmBnb1ATPxKkJoStd7m+y62pgHeJGGJ84NqMS5mOMe7xhh8y1Nukha4lPoX9x2NX1pMObY+vTsl1vIACTJwHaeorBkgy82/JXOewuOLtq1E5miPtm5YWb64A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067163; c=relaxed/simple;
	bh=GiBz0AD+U5higfP54JTIWbURN7LMLdXTQYQaOgJ+Bl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEp5SvGEepR0EtpKIBga6AoVlNW+OakiRjn2TAyD+AIcNzuITFJcjOQEKjb4FhZCQWKISpaCR3lhgSGVlRj6skAYgOFc/ao/PvYeZ+ObpCWLk99ZB2cuWzmawbTRlFu6FrnK7Zcuzr6OVYt3umZoF+hcWsPcybxNN72kHa51FFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sH0HieRS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GiBz0AD+U5higfP54JTIWbURN7LMLdXTQYQaOgJ+Bl0=; b=sH0HieRSdZyPzGqjC4vCbXfpKm
	yJYGFutbqau5ccJh8yltYVSlMxcWDKcGbOGU4jJV41RHFabFrviYfBHkfbfgHkEhT65jW/+WtN/BL
	/JZBkhTiW1CQiN61+JYIPfkeX6l7+16NHnxi9t5Stb5JTGZE+MLm2+Spsne7Sf5XZhUrTnDMLwfSB
	ubssjtmD6B6nzIu2WKaMg7Ara+KYNFOyr8oi0Rk2NLElQQamfPbvsKOYiPJIpjTB+WhyawvIwepF1
	MyB4q32gQfgNBHsGLOaN8szWOf/1dB+Wy+JdaoUCsRYypGjKRUX6jnpoN3m9m1Qod3sGovfmn720/
	OZ4MifGg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBG0e-0000000DsZ0-2xKs;
	Tue, 21 Oct 2025 17:18:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F40E13031AF; Tue, 21 Oct 2025 16:44:35 +0200 (CEST)
Date: Tue, 21 Oct 2025 16:44:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Laight <david.laight.linux@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	kernel test robot <lkp@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [patch V3 07/12] uaccess: Provide scoped masked user access
 regions
Message-ID: <20251021144435.GG4067720@noisy.programming.kicks-ass.net>
References: <20251017085938.150569636@linutronix.de>
 <20251017093030.253004391@linutronix.de>
 <20251020192859.640d7f0a@pumpkin>
 <877bwoz5sp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877bwoz5sp.ffs@tglx>

On Tue, Oct 21, 2025 at 04:29:58PM +0200, Thomas Gleixner wrote:

> So simply naming it scoped_user_$MODE_access() is probably the least
> confusing of all.

Yeah, that makes sense.

