Return-Path: <linux-fsdevel+bounces-38860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F032BA08E42
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 11:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05BC11684F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 10:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A3A20B7F1;
	Fri, 10 Jan 2025 10:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="ZGhTG4ih"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F5618FC80;
	Fri, 10 Jan 2025 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736505764; cv=none; b=PjKKz/5ZeEbbAVoRmKLYPTlHV4OnYsVYcqaPeiB9r99Lisq1gKDdolO9xDiFjeuky4mPZoi0QSI9iHCaDXkutbJomULbYEABedqqL1YPxgae0hcNRVHUBtUsJg8fNKnnELJbKGWea257rY4rU1MQthbrV2Ukeu/IMLovTIyHuv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736505764; c=relaxed/simple;
	bh=ohoM/SKWkKyFvW6KhIrzfvo2nFEDuXd5GKki5PYWfeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeAzWLBbAOs39az+nShHzspSOKD/5eECfYjgffQuwlF26Viv/9T83pmRO1Acic0fBcC9z8nTkRSkQfO9v6he2P+XCW7NrZCniDfHRdDoWsCrl28cIYFAyt+6YPjCWUfvQpsFnB12zYfOazrS8vkIvNsuTpr4rydQHkpLgLpP7vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=ZGhTG4ih; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=cK66ALb0EIz2SRdvZooDu5fFKEL9ZHoB4UCgLNPgQRI=; b=ZGhTG4ihUwKFlMQZl0L6kIm3aH
	c5MjlOcsrQNCfIoo3Zpe94bHe5wbyRwryTzqw/BfIoPb39mRHA2lUb3BZxMl1i7yTkrbUTF3AnpVG
	b5iDTK9qsm75ZJReBMJVIJjIxkUaWqObetUkAxYqJXKPl7/n4GSqvA2hwC42/BnE/xU//3cJo9lJM
	yI5sX8mhXBPTlZIkzUqs73bpnWMV7TZOSoKGZagKM8pJFbe1xWJlAtOInRluDVCB+QpW8V96il8vD
	26UfpGJjW9UhOx1ViWKb+m8Me1mhIK3SqX7udGNeBtp2MLGbwfDilavSQ9TBhR6oGKEKtwJJ6Bpsx
	FAnFWm3A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tWCG6-007oa4-2l;
	Fri, 10 Jan 2025 18:42:16 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 10 Jan 2025 18:42:15 +0800
Date: Fri, 10 Jan 2025 18:42:15 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: David Howells <dhowells@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	"David S. Miller" <davem@davemloft.net>,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-crypto@vger.kernel.org,
	linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/8] crypto/krb5: Provide Kerberos 5 crypto through
 AEAD API
Message-ID: <Z4D5h_KBvxwmrdQq@gondor.apana.org.au>
References: <Z4DwNPgLFcfy6jdl@gondor.apana.org.au>
 <20250110010313.1471063-1-dhowells@redhat.com>
 <20250110010313.1471063-3-dhowells@redhat.com>
 <1486113.1736505567@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1486113.1736505567@warthog.procyon.org.uk>

On Fri, Jan 10, 2025 at 10:39:27AM +0000, David Howells wrote:
>
> Is it?  That's entirely unclear.  The algorithm should deal with inserting the
> checksum in the appropriate place.  The caller should not need to know about
> that or where the checksum is or about extra bits of metadata that may need to
> be inserted (as I think the extra gssapi layer does for sunrpc).

The AEAD interface does not dictate where the authentication
tag is.  Most algorithms put it at the end, but it really could
be anywhere.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

