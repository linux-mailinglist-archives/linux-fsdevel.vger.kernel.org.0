Return-Path: <linux-fsdevel+bounces-12637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A75C086211E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 01:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47DE31F25F28
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 00:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED33ECF;
	Sat, 24 Feb 2024 00:21:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCE919A;
	Sat, 24 Feb 2024 00:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708734064; cv=none; b=c/PG1GJMUFFBNLT5yHCA6Pn4L6MkaUM3Q+bIvT4k5Are2611LPkr+zFrX9QR8CzS8gMdpOo0RvGdqmSvNet/aHD9vJsvrxf1qC+kI+xjThejZkAH8Rne6H5r3rXvrtMetQH8BQ8dVt6URLvoOiT5M2b4AG1AxIdk9s1bPNNmDX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708734064; c=relaxed/simple;
	bh=aKvxed/I9m8KBzl5cPZ2gMhHmhpX6/QrLsQZfD2oYvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyS3dK95W3kTG2AoGJu79+vciX66TgPkPMiGxxjYcXK66m7AmkaAEU3MJyb8gVkSbqXY5a981rcRopdfF7Bzk9gO0F6J6DhKBx7N8mRIevh37UX0yOwb/wMxdRoR18XO6zILamwUY3Zx9SjEBXP9iV8/WhBnC3J/+FeZ3KwRaL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rdfmO-00HDXA-9c; Sat, 24 Feb 2024 08:20:37 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 24 Feb 2024 08:20:50 +0800
Date: Sat, 24 Feb 2024 08:20:50 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, Thomas Graf <tgraf@suug.ch>,
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org, rcu@vger.kernel.org
Subject: Re: [PATCH 0/1] Rosebush, a new hash table
Message-ID: <Zdk2YgIoAGOEvcJi@gondor.apana.org.au>
References: <20240222203726.1101861-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222203726.1101861-1-willy@infradead.org>

On Thu, Feb 22, 2024 at 08:37:23PM +0000, Matthew Wilcox (Oracle) wrote:
>
> Where I expect rosebush to shine is on dependent cache misses.
> I've assumed an average chain length of 10 for rhashtable in the above
> memory calculations.  That means on average a lookup would take five cache
> misses that can't be speculated.  Rosebush does a linear walk of 4-byte

Normally an rhashtable gets resized when it reaches 75% capacity
so the average chain length should always be one.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

