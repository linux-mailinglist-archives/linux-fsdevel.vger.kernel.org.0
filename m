Return-Path: <linux-fsdevel+bounces-12706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6079862949
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 07:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDF171C20A40
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 06:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F62DC8F3;
	Sun, 25 Feb 2024 06:17:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B8028E8;
	Sun, 25 Feb 2024 06:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708841846; cv=none; b=juB5+3xPwK1o1pk3A32cD3A41Cuqwlha7P4+svxc2xsFKAsK3kgFMf+V17aAZl05Sxrb6TLhtyiDzB8GkF3YCOF8n/nSTu3XEShUCBiFNhPhXzei6X+zvaZXtEydXFYwNQZRNC9AF1N9m07dGDlhDPvkVXvF3fUJ5j37AYDCuYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708841846; c=relaxed/simple;
	bh=Vet3kNFNvQtLD/iQwxj+UEJSwFYFiQ2CtoXZP3rREUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XF/FtMeupCcVU4Dd6Rvah1f/ojPNpZjic7ml47KpXikKufZPi+FlchBn7WLFG9FjdMSCD1qo5lw7MkS2ZxGgANcvuXZPj8i2j+m6wYqM9PpP9u092kMgvF4hQXXnEsn3dv/4yTHoszQsCoej/3kJ4Iw9l5Bgce/B6n7zqoJ8soY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1re7ov-00HW18-1n; Sun, 25 Feb 2024 14:17:06 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 25 Feb 2024 14:17:19 +0800
Date: Sun, 25 Feb 2024 14:17:19 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>,
	David Laight <David.Laight@aculab.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Graf <tgraf@suug.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/1] Rosebush, a new hash table
Message-ID: <Zdrbb1oqX9rB4VCV@gondor.apana.org.au>
References: <20240222203726.1101861-1-willy@infradead.org>
 <Zdk2YgIoAGOEvcJi@gondor.apana.org.au>
 <4a1416fcb3c547eb9612ce07da6a77ed@AcuMS.aculab.com>
 <2s73sed5n6kxg42xqceenjtcwxys4j2r5dc5x4fdtwkmhkw3go@7viy7qli43wd>
 <ZdrJn0lkFeYGuYIC@casper.infradead.org>
 <5p5sypt3y643rr7kp66lhmgksgtuvdgijrryh53mqiiqkrgyty@d4zcnya22owg>
 <ZdrV3+kNz/ez4iai@gondor.apana.org.au>
 <awtiorxst6k5skhzzvrrt5kfhz67cqza2x5acuc7xiejo4sasw@vd6ohpsx76fd>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awtiorxst6k5skhzzvrrt5kfhz67cqza2x5acuc7xiejo4sasw@vd6ohpsx76fd>

On Sun, Feb 25, 2024 at 01:14:39AM -0500, Kent Overstreet wrote:
>
> it's a log curve -

Yes it's O(log N/log log N).

> chain length of 16 means you picked a bad hash
> function.

Or that someone is trying to attack you.  The number 16 is the
cut-off where we decide that someone has discovered our hash
secret and can cause a particular to chain to grow without bound.

At this point rhashtable will force a rehash with a different
secret.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

