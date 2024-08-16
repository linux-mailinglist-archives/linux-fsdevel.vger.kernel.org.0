Return-Path: <linux-fsdevel+bounces-26156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFF29553C9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 01:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68671F22E28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 23:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A96146000;
	Fri, 16 Aug 2024 23:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hf4I8o69"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794E21459F7
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 23:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723851328; cv=none; b=s/6uhFh6ux9Kn4dHax2eNjU6sAKtnmVF691vvjfG26ryOThK5AH9qhSR6hVgodktoPot8N7fuWLf5/Byln/by4AyNqBtZqZoLeGHzZXBdurJgAGmk8k0eYw52T7245tpe+298JCj0whXu3BMbIu9v+5r0I9wRU1rzItRCnF6REI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723851328; c=relaxed/simple;
	bh=bzd7vy4+F7Htyy6NFrmPlGezlVvZG/9uZNXhBZqmLZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxQFGrOinEM2XPCslZJsY0uu6x39xiTRFatPYIsADQ0okBEk9tWpOV5fALLpOH5LMHI2kZuLM7SRct8ThdQ5VfWmaMg7N+bUzib6Bv85d4p80tVdUX9zMwpp86gLfnwsATv53AjqVimg1renWS6g3Md4Qj3izHFNUYX0TlSd3Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hf4I8o69; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k65fugEgMkgaKJAujr0zUmmJLRIUHXpqQ1CrDCX7ijo=; b=hf4I8o69YwArwJ87p/BPyvM6E8
	fL5bz9DiyY4CBtUM7negJXAcdLZh8Sojc/006PB8kM9BTvmyvlDFc0tyEwQhIwc+hH8kEJfzwhJW3
	N9JYRewTE2dJE9LtPIwum1Yzqx+i1X5rpE4tlYKYrDHSXkVHIxAPnh9Zy7qBlSm1Og2e+OIPNyOq3
	17mj6euWE9Kdc4/At0pbW8zxEN0n3a1FMLErCJ8IfRnlJ9AvPm27/Cyogleh3hr5xTyWTcdCwuVzM
	TxpTZqJK8a5ONvIMGKfSUtXUFB3qbz+UKrkKmnADRyE8eVeqZWAiXw5Lb2we5wq1cJuJOyeNJe9QI
	ljVVtj8g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sf6TZ-00000002QZn-16rv;
	Fri, 16 Aug 2024 23:35:21 +0000
Date: Sat, 17 Aug 2024 00:35:21 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC] more close_range() fun
Message-ID: <20240816233521.GF504335@ZenIV>
References: <20240816030341.GW13701@ZenIV>
 <CAHk-=wh_K+qj=gmTjiUqr8R3x9Tco31FSBZ5qkikKN02bL4y7A@mail.gmail.com>
 <20240816171925.GB504335@ZenIV>
 <CAHk-=wh7NJnJeKroRhZsSRxWGM4uYTgONWX7Ad8V9suO=t777w@mail.gmail.com>
 <20240816181545.GD504335@ZenIV>
 <CAHk-=wiawf_fuA8E45Qo6hjf8VB5Tb49_6=Sjvo6zefMEsTxZA@mail.gmail.com>
 <20240816202657.GE504335@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816202657.GE504335@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Aug 16, 2024 at 09:26:57PM +0100, Al Viro wrote:
> On Fri, Aug 16, 2024 at 11:26:10AM -0700, Linus Torvalds wrote:
> > On Fri, 16 Aug 2024 at 11:15, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > As in https://lore.kernel.org/all/20240812064427.240190-11-viro@zeniv.linux.org.uk/?
> > 
> > Heh. Ack.
> 
> Variant being tested right now:

	No regressions, AFAICT.  Pushed to
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #proposed-fix
(head at 8c86f1a4574d).  Unless somebody objects, I'm going to take that
into #fixes...

