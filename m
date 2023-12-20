Return-Path: <linux-fsdevel+bounces-6590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC0B81A130
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 15:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802731C22669
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 14:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FE93B78F;
	Wed, 20 Dec 2023 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BHF2GqHW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F244D3B2A7;
	Wed, 20 Dec 2023 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KxkjqpiRhDDXCtVOxBcLzEwoOuA/MLwLsDAq8dy0YWY=; b=BHF2GqHWuAnU1Twu9UvJy9agEU
	h4yAoWEeR2Hw1DpM5opy5WX4q6fw++idDTVF1sB4CAeT4yznSiudWA4EpjCe3E9EZ0TiIp1LEAngB
	K4yZ/HEWpv8vTDgAvoDY/N2MkXNEW+qxNYw00E/7p1EQvhFF7U9/GT/z8qWE20A9SoAMVpqTuM0ZU
	bOgbjq5bxutfk98c8NCtJt6nMHGFlYVAcpUPWgjzsc4yneh8yC4isK1X2E2teOsVvdHYaraQjNYp7
	g9rHmoB6tgPmd8u34US9uEqD1xqEZSP2wCO0NBNraq3r/4czSlfwFdwrhpIBxW3sZsIyrmdQ4U7bs
	mh4fyu2w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFxen-0006FK-1M;
	Wed, 20 Dec 2023 14:34:45 +0000
Date: Wed, 20 Dec 2023 06:34:45 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Joel Granados <j.granados@samsung.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Iurii Zaikin <yzaikin@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
Message-ID: <ZYL7hS1ARS6ygPBP@bombadil.infradead.org>
References: <20231212090930.y4omk62wenxgo5by@localhost>
 <ZXligolK0ekZ+Zuf@bombadil.infradead.org>
 <20231217120201.z4gr3ksjd4ai2nlk@localhost>
 <908dc370-7cf6-4b2b-b7c9-066779bc48eb@t-8ch.de>
 <ZYC37Vco1p4vD8ji@bombadil.infradead.org>
 <a0d96e7b-544f-42d5-b8da-85bc4ca087a9@t-8ch.de>
 <ZYIGi9Gf7oVI7ksf@bombadil.infradead.org>
 <alpine.DEB.2.22.394.2312192218050.3196@hadrien>
 <ZYIwpHXkqBkMB8zl@bombadil.infradead.org>
 <alpine.DEB.2.22.394.2312200838160.3151@hadrien>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2312200838160.3151@hadrien>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Wed, Dec 20, 2023 at 08:39:20AM +0100, Julia Lawall wrote:
> 
> 
> On Tue, 19 Dec 2023, Luis Chamberlain wrote:
> 
> > On Tue, Dec 19, 2023 at 10:21:25PM +0100, Julia Lawall wrote:
> > > > As I noted, I think this is a generically neat endeavor and so I think
> > > > it would be nice to shorthand *any* member of the struct. ctl->any.
> > > > Julia, is that possible?
> > >
> > > What do you mean by *any* member?
> >
> > I meant when any code tries to assign a new variable to any of the
> > members of the struct ctl_table *foo, so any foo->*any*
> 
> Declaring any to be an identifier metavariable would be sufficient.

Fantastic thanks!

> > > If any is an identifier typed
> > > metavariable then that would get any immediate member.  But maybe you want
> > > something like
> > >
> > > <+...ctl->any...+>
> > >
> > > that will match anything that has ctl->any as a subexpression?
> >
> > If as just an expression, then no, we really want this to be tied to
> > the data struture in question we want to modify.
> 
> What about foo->a.b?  Or maybe that doesn't occur in your structure?

We'll consider that too, good idea!

  Luis

