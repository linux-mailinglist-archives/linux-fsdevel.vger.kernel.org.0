Return-Path: <linux-fsdevel+bounces-16952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCCF8A565C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 17:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B392E281341
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 15:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE9D78C8A;
	Mon, 15 Apr 2024 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t4Xb2I1z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE2A78C76;
	Mon, 15 Apr 2024 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194852; cv=none; b=FvcNSx9DE96KhH90YLD4LF9IqQ568I7TRbBZQAUhT1akhegBfFBN+H8OqkRVw2ICcYBPVMIgcoEcFWB/zJBIOQpRbM2k6J+Fhu593M2yWjFVfK30VZhjy7Rt00WbH/O65FENxEV89+d92iHqfubS4Au0lJSizENyfPT0pD9pcE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194852; c=relaxed/simple;
	bh=E/E6uPhEQFTDXKNsZdTcJGdhj+vgxMgRtVlDrOkU9tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYnZ/hpdVhC9hb6Gc/JTC5wK8rDdn9zh3JKuHjVd1lybDTHeslHGK+g6MDam6WD3/gI5heHBxCOasm5VzhD7azGnPxR0uQnSa1y2jP+QJw6Q5+aY3jJMWs/28s7hSRZrmJrUR+aV3izcXbClm51HkB1HRRFyY1W8NVAUU3CfUxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t4Xb2I1z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uOrEsRLhKT6ZKVtPRnTeUpJwpod8q+jzfgJFwajhhYI=; b=t4Xb2I1zIQ+nHD8XpAUxr6peIt
	yTVdzlk2Z51Z1B941Ni1dtCjKVs4YelQrv4MOpKn8RNNIsGoVo8MYTZGPN+jUwKrkuzL4kxchJtj8
	ZKjpVi4AxqMn3Bhf96fNAK5zLocoPjflNZoOqvKKEqcJ4n5WAb3iosv9esAU6jU7BN9nHgW6Kinel
	8WrBD/3jMcXOC5OFcfsiXiF8NpP8Ihd/83n+wXXGiN+P74WY5SVHKTVAkE3uUuSyy6qu5ZV+j6Fso
	PjgSVauXJdaAVlP0G4xzam8ImRsILxmpuynQut7iA8/4M2+DNbZALq3bHfGkepRROVjsWMR3kRYx9
	1POAhrkA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwOEw-0000000Fy1B-3I56;
	Mon, 15 Apr 2024 15:27:26 +0000
Date: Mon, 15 Apr 2024 16:27:26 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Anton Altaparmakov <anton@tuxera.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	Namjae Jeon <linkinjeon@kernel.org>,
	"ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
	Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
	"linux-ntfs-dev@lists.sourceforge.net" <linux-ntfs-dev@lists.sourceforge.net>,
	Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 2/2] ntfs3: remove warning
Message-ID: <Zh1HXjcluA0dXycM@casper.infradead.org>
References: <ZgFN8LMYPZzp6vLy@hovoldconsulting.com>
 <20240325-shrimps-ballverlust-dc44fa157138@brauner>
 <a417b52b-d1c0-4b7d-9d8f-f1b2cd5145f6@leemhuis.info>
 <b0fa3c40-443b-4b89-99e9-678cbb89a67e@paragon-software.com>
 <Zhz5S3TA-Nd_8LY8@hovoldconsulting.com>
 <Zhz_axTjkJ6Aqeys@hovoldconsulting.com>
 <8FE8DF1E-C216-4A56-A16E-450D2AED7F5E@tuxera.com>
 <Zh0SicjFHCkMaOc0@hovoldconsulting.com>
 <20240415-warzen-rundgang-ce78bedb5f19@brauner>
 <CAHk-=whPTEYv3F9tgvJf-OakOxyGw2jzRVD0BMkXmC5ANPj0YA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whPTEYv3F9tgvJf-OakOxyGw2jzRVD0BMkXmC5ANPj0YA@mail.gmail.com>

On Mon, Apr 15, 2024 at 08:23:46AM -0700, Linus Torvalds wrote:
> On Mon, 15 Apr 2024 at 07:16, Christian Brauner <brauner@kernel.org> wrote:
> >
> > (1) Since the ntfs3 driver is supposed to serve as a drop-in replacement
> >     for the legacy ntfs driver we should to it the same way we did it
> >     for ext3 and ext4 where ext4 registers itself also for the ext3
> >     driver. In other words, we would register ntfs3 as ntfs3 filesystem
> >     type and as legacy ntfs filesystem type.
> 
> I think that if just registering it under the same name solves the
> immediate issue, that's the one we should just go for.

I agree.

> >     To make it fully compatible
> >     we also need to make sure it's persistently mounted read-only.
> 
> My reaction to that is "only if it turns out we really need to".

Unfortunately, we do.  It seems that ntfs3 has some bugs, and (according
to Anton, the ntfs-classic maintainer) it's actually corrupting perfectly
good filesystems.  I'd expected that this kind of bug would have been
shaken out by now (it's been in the kernel for over two and a half years!)
but it seems like people just haven't been using it.


