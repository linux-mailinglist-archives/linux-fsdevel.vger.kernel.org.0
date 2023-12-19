Return-Path: <linux-fsdevel+bounces-6520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E618190BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 20:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267D41C24797
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 19:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAE839854;
	Tue, 19 Dec 2023 19:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hASqtFp8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEE639AC0;
	Tue, 19 Dec 2023 19:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1703014190;
	bh=GMFosoqH618A0escG3KIeky1Bglzu9iNu3oJdI75r2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hASqtFp8t11cv7FEJdQUJ9GxREwItyc99qkE4NvBl5NoggRb0wDTMY60eN8hn4LNd
	 Hny29ryLOertfQrxFYW+0RZTky3PESA471v0LguQi8ddRcFuZ8BLut0FkPqxGTRU/4
	 QNqIiynuflzz2mjSZu2gyKOFTH79xuPyRZR/t7DQ=
Date: Tue, 19 Dec 2023 20:29:50 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Luis Chamberlain <mcgrof@kernel.org>, 
	Julia Lawall <julia.lawall@inria.fr>
Cc: Joel Granados <j.granados@samsung.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Iurii Zaikin <yzaikin@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
Message-ID: <a0d96e7b-544f-42d5-b8da-85bc4ca087a9@t-8ch.de>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
 <20231207104357.kndqvzkhxqkwkkjo@localhost>
 <fa911908-a14d-4746-a58e-caa7e1d4b8d4@t-8ch.de>
 <20231208095926.aavsjrtqbb5rygmb@localhost>
 <8509a36b-ac23-4fcd-b797-f8915662d5e1@t-8ch.de>
 <20231212090930.y4omk62wenxgo5by@localhost>
 <ZXligolK0ekZ+Zuf@bombadil.infradead.org>
 <20231217120201.z4gr3ksjd4ai2nlk@localhost>
 <908dc370-7cf6-4b2b-b7c9-066779bc48eb@t-8ch.de>
 <ZYC37Vco1p4vD8ji@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZYC37Vco1p4vD8ji@bombadil.infradead.org>

Hi Luis and Julia,

(Julia, there is a question and context for you inline, marked with your name)

On 2023-12-18 13:21:49-0800, Luis Chamberlain wrote:
> So we can split this up concentually in two:
> 
>  * constificaiton of the table handlers
>  * constification of the table struct itself
> 
> On Sun, Dec 17, 2023 at 11:10:15PM +0100, Thomas Weißschuh wrote:
> > The handlers can already be made const as shown in this series,
> 
> The series did already produce issues with some builds, and so
> Julia's point is confirmed that the series only proves hanlders
> which you did build and for which 0-day has coverage for.
> 
> The challenge here was to see if we could draw up a test case
> that would prove this without build tests, and what occurred to
> me was coccinelle or smatch.

I used the following coccinelle script to find more handlers that I
missed before:

virtual patch
virtual context
virtual report

@@
identifier func;
identifier ctl;
identifier write;
identifier buffer;
identifier lenp;
identifier ppos;
type loff_t;
@@

int func(
- struct ctl_table *ctl,
+ const struct ctl_table *ctl,
  int write, void *buffer, size_t *lenp, loff_t *ppos) { ... }

It did not find any additional occurrences while it was able to match
the existing changes.

After that I manually reviewed all handlers that they are not modifying
their table argument, which they don't.

Should we do more?


For Julia:

Maybe you could advise on how to use coccinelle to find where a const
function argument or one of its members are modified directly or passed
to some other function as non-const arguments.
See the coccinelle patch above.

Is this possible?

> > > If that is indeed what you are proposing, you might not even need the
> > > un-register step as all the mutability that I have seen occurs before
> > > the register. So maybe instead of re-registering it, you can so a copy
> > > (of the changed ctl_table) to a const pointer and then pass that along
> > > to the register function.
> > 
> > Tables that are modified, but *not* through the handler, would crop
> > during the constification of the table structs.
> > Which should be a second step.
> 
> Instead of "croping up" at build time again, I wonder if we can do
> better with coccinelle / smatch.

As for smatch:

Doesn't smatch itself run as part of a normal build [0]?
So it would have the same visibility issues as the compiler itself.

> Joel, and yes, what you described is what I was suggesting, that is to
> avoid having to add a non-const handler a first step, instead we modify
> those callers which do require to modify the table by first a
> deregistration and later a registration. In fact to make this even
> easier a new call would be nice so to aslo be able to git grep when
> this is done in the kernel.
> 
> But if what you suggest is true that there are no registrations which
> later modify the table, we don't need that. It is the uncertainty that
> we might have that this is a true statment that I wanted to challenge
> to see if we could do better. Can we avoid this being a stupid
> regression later by doing code analysis with coccinelle / smatch?
> 
> The template of the above endeavor seems useful not only to this use
> case but to any place in the kernel where this previously has been done
> before, and hence my suggestion that this seems like a sensible thing
> to think over to see if we could generalize.

I'd like to split the series and submit the part up until and including
the constification of arguments first and on its own.
It keeps the subsystem maintainers out of the discussion of the core
sysctl changes.

I'll submit the core sysctl changes after I figure out proper responses
to all review comments and we can do this in parallel to the tree-wide
preparation.

What do you think Luis and Joel?

[0] https://repo.or.cz/smatch.git/blob/HEAD:/smatch_scripts/test_kernel.sh

