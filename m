Return-Path: <linux-fsdevel+bounces-12702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D88F86293A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 06:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BA141F21A9E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 05:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36777C13B;
	Sun, 25 Feb 2024 05:53:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761723201;
	Sun, 25 Feb 2024 05:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708840418; cv=none; b=srg5IKWnQFL2ML5DEpAJYn8gkxhsqgB3GacZWl8bRuFX4inDT3eN4dDOk7lWNvQt9TVU4UCiBsk0Qbentmkwi1UTrGVLJqD7/6WT2N/SxlbdAYSK0ni9k1Y97zbyv9ejusuyHfvkQo3wMBEHfsabAbkdWGKVryIPSykRtM5iowY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708840418; c=relaxed/simple;
	bh=zAHIzMeRwf0+2hZbQZq917hWjTFkGaeqRoTKoOY7VsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0JdBtS4bcJtyWNLf9eq+flpCsP9L5GuDAhWTatV8CRs184a/h1dlgGk6yK+XbnxSCgYfKiGTrztKo5torkHIo3YZd5uVSiz42Mq9jiVY4GMNIv3PgSmrUbDWuaWc3YKK/i5clrdXC2v+oDoc1V1L/xGDPK6eZa7iNF6kL1O52s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1re7Rw-00HVnp-Fl; Sun, 25 Feb 2024 13:53:21 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 25 Feb 2024 13:53:35 +0800
Date: Sun, 25 Feb 2024 13:53:35 +0800
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
Message-ID: <ZdrV3+kNz/ez4iai@gondor.apana.org.au>
References: <20240222203726.1101861-1-willy@infradead.org>
 <Zdk2YgIoAGOEvcJi@gondor.apana.org.au>
 <4a1416fcb3c547eb9612ce07da6a77ed@AcuMS.aculab.com>
 <2s73sed5n6kxg42xqceenjtcwxys4j2r5dc5x4fdtwkmhkw3go@7viy7qli43wd>
 <ZdrJn0lkFeYGuYIC@casper.infradead.org>
 <5p5sypt3y643rr7kp66lhmgksgtuvdgijrryh53mqiiqkrgyty@d4zcnya22owg>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5p5sypt3y643rr7kp66lhmgksgtuvdgijrryh53mqiiqkrgyty@d4zcnya22owg>

On Sun, Feb 25, 2024 at 12:51:06AM -0500, Kent Overstreet wrote:
>
> but your distribution actually is accurate in general, golden ratio hash
> is relly nice for sequential integers. the actual problem with your test
> is that you're testing 100% occupancy - no one does that.
> 
> 75% occupancy, siphash:
> 0: 933
> 1: 60
> 2: 6
> 3: 1
> 4: 0
> 
> that looks about right to me.

The point is that the worst-case length grows with the size of
the table so it won't always be 3.  You need to take into account
the largest table size that you will support.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

