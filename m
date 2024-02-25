Return-Path: <linux-fsdevel+bounces-12705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF7F862946
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 07:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB7C1C20BE3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 06:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F3CD271;
	Sun, 25 Feb 2024 06:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WQf5+p03"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ED49454
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 06:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708841685; cv=none; b=altwyl0fJSN03HCMVOg+QJhRK0HY2q+U1j7AMQR9CHxyXIp2p0q7+Ba+C5kM/v5K0uov3895ChTZ7wSUIbSm0EQ5siFwN02fA7eHHsCmILeCLn4u+ihG77AxHQ6QCflHtaVoYSE6yz3KsLQu9KUoUxCwtWS+SnhsycYhkqMTkzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708841685; c=relaxed/simple;
	bh=Thhad8bOoqBfWRyLRqhOVbSKV7YzETTjZwmrfCBuc+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgbwImpTJABef3V1B+f1+bxyWFXpNACiMCHKgehWpoUAZh5+GUG45A1NsRofTpjfJBGy/6+2ctjsTj5Va46GymO0wPWYWpumpGctULAwqLgvaVf33lckfN+zDmZrcTwhP0o+5GAS32U2+Nhqt2d4px/HQhWLKH5tMBAVMLeTbHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WQf5+p03; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 25 Feb 2024 01:14:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708841682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fUUif9KcYlLFn7lITsjP4DXv1Tc/bfc10B0pakN5FX0=;
	b=WQf5+p03sTi/0WL/y9jKjAJvaQTUQiPIImuFYpcY5QqD/vQIjhCnXfZfAdTODQ4DnIxPz0
	0IejpthyZSx3chxfUEWymAtMRGpn0FI6lWZnp29OGxEODUkmWyNYK0hvBRvlvBs7ragNM6
	9kyb9LoPtTgc/zu4+l5LOHw78ysYvO4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Matthew Wilcox <willy@infradead.org>, 
	David Laight <David.Laight@aculab.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Thomas Graf <tgraf@suug.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/1] Rosebush, a new hash table
Message-ID: <awtiorxst6k5skhzzvrrt5kfhz67cqza2x5acuc7xiejo4sasw@vd6ohpsx76fd>
References: <20240222203726.1101861-1-willy@infradead.org>
 <Zdk2YgIoAGOEvcJi@gondor.apana.org.au>
 <4a1416fcb3c547eb9612ce07da6a77ed@AcuMS.aculab.com>
 <2s73sed5n6kxg42xqceenjtcwxys4j2r5dc5x4fdtwkmhkw3go@7viy7qli43wd>
 <ZdrJn0lkFeYGuYIC@casper.infradead.org>
 <5p5sypt3y643rr7kp66lhmgksgtuvdgijrryh53mqiiqkrgyty@d4zcnya22owg>
 <ZdrV3+kNz/ez4iai@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdrV3+kNz/ez4iai@gondor.apana.org.au>
X-Migadu-Flow: FLOW_OUT

On Sun, Feb 25, 2024 at 01:53:35PM +0800, Herbert Xu wrote:
> On Sun, Feb 25, 2024 at 12:51:06AM -0500, Kent Overstreet wrote:
> >
> > but your distribution actually is accurate in general, golden ratio hash
> > is relly nice for sequential integers. the actual problem with your test
> > is that you're testing 100% occupancy - no one does that.
> > 
> > 75% occupancy, siphash:
> > 0: 933
> > 1: 60
> > 2: 6
> > 3: 1
> > 4: 0
> > 
> > that looks about right to me.
> 
> The point is that the worst-case length grows with the size of
> the table so it won't always be 3.  You need to take into account
> the largest table size that you will support.

ok, but - one million entries, siphash, 75% fill factor

0: 472053
1: 354786
2: 132663
3: 33267
4: 6218
5: 884
6: 110
7: 17
8: 2
9: 0

100 million:

0: 51342703
1: 34224025
2: 11413241
3: 2534946
4: 421816
5: 56271
6: 6346
7: 593
8: 56
9: 3
10: 0

it's a log curve - chain length of 16 means you picked a bad hash
function.

