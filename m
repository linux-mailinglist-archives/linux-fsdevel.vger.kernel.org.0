Return-Path: <linux-fsdevel+bounces-26578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 999C595A88E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 02:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC9E1F230E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 00:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F8A60B8A;
	Thu, 22 Aug 2024 00:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DnE8CfAT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EFF171088
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 00:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724284810; cv=none; b=jKXbVP3eQ+O7s26HAUVGdeMJI7hNYSoPHSx+eWn7BmfZA0WE9OGYJCH9A3bwMtH/kiRdFUMeBzov4lfB4XW7u0kw4wA13ARUMP4iw8rQD0roZVO57CPF3ZP0sX3pqhJDqfvPSoZThRIcnpisbJFpVrLFXzmXZTXJJPPM+Fv92+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724284810; c=relaxed/simple;
	bh=SJj6m8DCFZinYt4RKtzfZUvynxXUBxAJpJkGZIF/FKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlaL9a8lrZFWk7a3jzkj3frwApey1biNId6XClmqpROzi/LEgCwcfvn2jimg6uuG8NQ9RmAlX/amrAzeIFi2xSN+vw3TTamchVusswjaj5uHXJNmYDNTiAQpCLNTP28e+6+C3RFLU1OPhIK/CYMOle51JN6X+JWd0i3tiPqp0XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DnE8CfAT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=83+7VhbgpGpZBmGDUX8ey1HGcKmqoCms9WX5W9316Hg=; b=DnE8CfAT+MUFvCr6nMCEiKrxD/
	Jj9ne0ysoFyyCPorFRDyLCTZ0UXodliVjDaW60yul3t0q9VRP/9Ea8Ld0y1u5yDDKhjFkTIDl6yQU
	BJPuMyP8HN+V/P8WCKg+jSjk2Prk/mes7GWjYYMuepGfdo9OLVfer51uYJ8CMPCYlkiADhrGWMqlm
	SLWRbjlbpH8mbkNg2FXKJath7NUvhO/i9MQEZIj7sFOE+dlEcGYCkf2BZJA4A0O1UDrPlEE8a6Iq9
	M1yM8VIha5XWlON8D4H0//quW88MG8ixtOxLErlVyy8F7UudzcZyS5ZttJCwiZyuk8cK+ciFErfbY
	8UXjFogw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sgvFE-00000003vtC-410H;
	Thu, 22 Aug 2024 00:00:04 +0000
Date: Thu, 22 Aug 2024 01:00:04 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC] more close_range() fun
Message-ID: <20240822000004.GK504335@ZenIV>
References: <20240816030341.GW13701@ZenIV>
 <CAHk-=wh_K+qj=gmTjiUqr8R3x9Tco31FSBZ5qkikKN02bL4y7A@mail.gmail.com>
 <20240816171925.GB504335@ZenIV>
 <CAHk-=wh7NJnJeKroRhZsSRxWGM4uYTgONWX7Ad8V9suO=t777w@mail.gmail.com>
 <20240816181545.GD504335@ZenIV>
 <CAHk-=wiawf_fuA8E45Qo6hjf8VB5Tb49_6=Sjvo6zefMEsTxZA@mail.gmail.com>
 <20240816202657.GE504335@ZenIV>
 <20240816233521.GF504335@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816233521.GF504335@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Aug 17, 2024 at 12:35:21AM +0100, Al Viro wrote:
> On Fri, Aug 16, 2024 at 09:26:57PM +0100, Al Viro wrote:
> > On Fri, Aug 16, 2024 at 11:26:10AM -0700, Linus Torvalds wrote:
> > > On Fri, 16 Aug 2024 at 11:15, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > >
> > > > As in https://lore.kernel.org/all/20240812064427.240190-11-viro@zeniv.linux.org.uk/?
> > > 
> > > Heh. Ack.
> > 
> > Variant being tested right now:
> 
> 	No regressions, AFAICT.  Pushed to
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #proposed-fix
> (head at 8c86f1a4574d).  Unless somebody objects, I'm going to take that
> into #fixes...

Well, since nobody has objected, in #fixes it went...

