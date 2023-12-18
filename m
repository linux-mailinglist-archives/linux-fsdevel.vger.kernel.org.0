Return-Path: <linux-fsdevel+bounces-6428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 684F0817C94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 22:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16879284029
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 21:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ED2740A8;
	Mon, 18 Dec 2023 21:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RwnBpBPE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE527349B;
	Mon, 18 Dec 2023 21:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=VC+L7rFKG6X8C4ZiU4wNQCGzHwKND4zyyzshhUNrvTo=; b=RwnBpBPEKSObuehHd52kglOds7
	qRfWT1wCChbj2oeUHWIWeqzisKj1mREJxbjq2QEsBC2yr5XUaU4f8Vdj6ZiLTCAm1cxrHwtpTKI9l
	zaJgt0I7Ma2n+WA+1BRtSgVuHkO109xFu242d+OS0gajDklSLZWo6CEyyDcsT9broqoorbK/8loIP
	6O9K7Q2nlyIu5BsDDGvxfLkPH0mCpY2fou3I2RTC3GBehV90FzFJAIUyOXbWQt0TrQ9KTeD232vYa
	/188RCbwPKHr2eBMwNhaHRTjRiaio+4sKm6JcPlXAMxvP2HE/Q+L/aoTNsW89BEKsTX+Vh7cwGO7t
	VU/1yU7A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFL3d-00C7Bt-0W;
	Mon, 18 Dec 2023 21:21:49 +0000
Date: Mon, 18 Dec 2023 13:21:49 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Joel Granados <j.granados@samsung.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Julia Lawall <julia.lawall@inria.fr>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Iurii Zaikin <yzaikin@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
Message-ID: <ZYC37Vco1p4vD8ji@bombadil.infradead.org>
References: <CGME20231204075237eucas1p27966f7e7da014b5992d3eef89a8fde25@eucas1p2.samsung.com>
 <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
 <20231207104357.kndqvzkhxqkwkkjo@localhost>
 <fa911908-a14d-4746-a58e-caa7e1d4b8d4@t-8ch.de>
 <20231208095926.aavsjrtqbb5rygmb@localhost>
 <8509a36b-ac23-4fcd-b797-f8915662d5e1@t-8ch.de>
 <20231212090930.y4omk62wenxgo5by@localhost>
 <ZXligolK0ekZ+Zuf@bombadil.infradead.org>
 <20231217120201.z4gr3ksjd4ai2nlk@localhost>
 <908dc370-7cf6-4b2b-b7c9-066779bc48eb@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <908dc370-7cf6-4b2b-b7c9-066779bc48eb@t-8ch.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>

So we can split this up concentually in two:

 * constificaiton of the table handlers
 * constification of the table struct itself

On Sun, Dec 17, 2023 at 11:10:15PM +0100, Thomas Weißschuh wrote:
> The handlers can already be made const as shown in this series,

The series did already produce issues with some builds, and so
Julia's point is confirmed that the series only proves hanlders
which you did build and for which 0-day has coverage for.

The challenge here was to see if we could draw up a test case
that would prove this without build tests, and what occurred to
me was coccinelle or smatch.

> > If that is indeed what you are proposing, you might not even need the
> > un-register step as all the mutability that I have seen occurs before
> > the register. So maybe instead of re-registering it, you can so a copy
> > (of the changed ctl_table) to a const pointer and then pass that along
> > to the register function.
> 
> Tables that are modified, but *not* through the handler, would crop
> during the constification of the table structs.
> Which should be a second step.

Instead of "croping up" at build time again, I wonder if we can do
better with coccinelle / smatch.

Joel, and yes, what you described is what I was suggesting, that is to
avoid having to add a non-const handler a first step, instead we modify
those callers which do require to modify the table by first a
deregistration and later a registration. In fact to make this even
easier a new call would be nice so to aslo be able to git grep when
this is done in the kernel.

But if what you suggest is true that there are no registrations which
later modify the table, we don't need that. It is the uncertainty that
we might have that this is a true statment that I wanted to challenge
to see if we could do better. Can we avoid this being a stupid
regression later by doing code analysis with coccinelle / smatch?

The template of the above endeavor seems useful not only to this use
case but to any place in the kernel where this previously has been done
before, and hence my suggestion that this seems like a sensible thing
to think over to see if we could generalize.

  Luis

