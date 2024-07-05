Return-Path: <linux-fsdevel+bounces-23201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C068F928A10
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 15:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693841F23B7D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 13:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB07315216D;
	Fri,  5 Jul 2024 13:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UPLDKLdF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A34149E13;
	Fri,  5 Jul 2024 13:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187126; cv=none; b=treTf+kvTy0FodC5bdiBXMHala/91Rg74cvUR+84v1a6fltpTlqTEjQPPnmh/E126wzI7Ui++NNSBTvER8sAFfUAcpXgoAydgPEbWKxeXeV6zuh67tUZDoT4509uoLQAaKXLuTcFgciPbXdk2awoA0QfAtC98i6rwrZ6wAWfdGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187126; c=relaxed/simple;
	bh=wc2v+Q09v9L7Mtq387oLOS6V5UakE/iNxIDyJRmZMDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVPiRSMJ7S+Xl6CZqvAtBNjbCOnXtx0SjnDgFHsTNbcwKCqVbEJiMel65DtdTWRcQqNqNqPjg1gFXvVbKV5NZUKrkt+SCNQErO/vcU/FekCJ6WX8edBuKv434Gvi2+PsYA7f8k3N7ZB7i9VGVuRp4uMEDiFciNIXWhzghWh/vHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UPLDKLdF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YME2d8BnEFeEdK387vh+da2OIWz9n+MVJ/tNFyY+bkU=; b=UPLDKLdFfb3eY3+OcPPc9RfNO+
	vY/mA/AnBu5zUkB5FrJNATHBdV5hnkPhMGxhpUb1w5ZyPEiYogJEgd276bHez7qFQWnjZUmf2ZaJ1
	7HDOi0KZik96WCmx9K+FBCG1lFdeLmVtMDfpkW8GSvZg/bC5u/FrflxPaZPzoa0+Yr+bIS/coTH8r
	6k57rVxuc9AGea+hOm5b47HI8ukZF1AXc2KI73VqtjT79Hx+0q31CLcHqo1CDSWsKqY2f0/cPzW7s
	HrrBSV5B6d7qUhbWtZ6+D2/3oHw3LTFp4l9Lk0fSo9jPAC5k73Cm2pVfFRfRIFiwnAvfni/9rHtnG
	8QFo55EA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPjFa-0000000G6Un-3qdK;
	Fri, 05 Jul 2024 13:45:22 +0000
Date: Fri, 5 Jul 2024 06:45:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Neil Brown <neilb@suse.de>, Mike Snitzer <snitzer@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Christoph Hellwig <hch@infradead.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: Security issue in NFS localio
Message-ID: <Zof48g7oQi4O4UG6@infradead.org>
References: <172004548435.16071.5145237815071160040@noble.neil.brown.name>
 <23DE2D13-1E1D-4EFE-9348-5B9055B30009@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23DE2D13-1E1D-4EFE-9348-5B9055B30009@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jul 04, 2024 at 07:00:23PM +0000, Chuck Lever III wrote:
> > 3/ The current code uses the 'struct cred' of the application to look up
> >   the file in the server code.  When a request goes over the wire the
> >   credential is translated to uid/gid (or krb identity) and this is
> >   mapped back to a credential on the server which might be in a
> >   different uid name space (might it?  Does that even work for nfsd?)
> > 
> >   I think that if rootsquash or allsquash is in effect the correct
> >   server-side credential is used but otherwise the client-side
> >   credential is used.  That is likely correct in many cases but I'd
> >   like to be convinced that it is correct in all case.  Maybe it is
> >   time to get a deeper understanding of uid name spaces.
> 
> I've wondered about the idmapping issues, actually. Thanks
> for bringing that up. I think Christian and linux-fsdevel
> need to be involved in this conversation; added.

There is a lot more issues than just idmapping.  That's why I don't
think the current approach where the open is executed in the client
can work.  The right way is to ensure the open always happens in and
nfsd thread context which just pases the open file to client for doing
I/O.

