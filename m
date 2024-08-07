Return-Path: <linux-fsdevel+bounces-25219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DBB949EA6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 05:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 044841C23D22
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 03:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CD9266A7;
	Wed,  7 Aug 2024 03:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dImRH9zK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB7F364A0;
	Wed,  7 Aug 2024 03:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723002497; cv=none; b=lCmT4a9GVmyCw3K/RC/dNjJzK4/YuvFU0hVXcVyrw9qLx1ua4MAnApMIKoVegjAPG0LK3HeOobWUoJfq1i4noFrPRq2O6bIfjCPS+1JOnm8/N1Bo8flI+EFYkgSX44x93bCGa/6eOdVCysguDrw0cl8OVSJLxyY07kgZf2h8qOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723002497; c=relaxed/simple;
	bh=qmy3ovyhsYEjjnM3VF2SvTiTc1OzpoV8aQjzohxQrj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvDVVbzGWgppsWRCDDGcGm5S3oQGnBdpqDAboWyja/uH48R+77hNbMCRZjKnDMGH7iv+1VhwrhiRXSWdl6J0MR+NJucjTl2RAFju5tSZW4qkNjaWcds8pTG67TVZUtaxa1kkkGYnmutiGfx7PPkEX+q0KCJSTPJXKBw7+vxdEyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dImRH9zK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NgREx1DsWcBDVSTQLM/yM/zhKOhKelHZuFklDwx+PBQ=; b=dImRH9zK7aK5cUsti9r8ItOylY
	FhScaADiUSrHYUtDK/KHEcwwjkgAaCNJlFCLSWKd5WCliTTWYQCdMk26FXiWWoZUvP6qdENvdxedZ
	5p7Zx4OxwfT2/jnhCOM4oUgfbnaCFA8nCjKnY5Mrd6qRdJ9nRvBRuYyfhN8GE/CKEPrWLCUV0Koon
	nYwqMyFaOjX52ujhLLTbKQ2kzPPJxzVBsIoGdQ9eJwMmIMk880Fvo43rJeM/CoURfyWnJaA8GSNsm
	BngtrrVsL3Y2/I8ff5LwsdhLecCGQ+91Q0nLWUwFP9eMdcroDqHzP0vkbifC05lhq7dnj1DeVv2la
	+IhSm55Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbXek-00000006gXH-1gn4;
	Wed, 07 Aug 2024 03:48:10 +0000
Date: Wed, 7 Aug 2024 04:48:10 +0100
From: Matthew Wilcox <willy@infradead.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <levinsasha928@gmail.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	maple-tree@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] lib/htree: Add locking interface to new Hash Tree
Message-ID: <ZrLuelS7yx92SKk7@casper.infradead.org>
References: <20240805100109.14367-1-rgbi3307@gmail.com>
 <2024080635-neglector-isotope-ea98@gregkh>
 <CAHOvCC4-298oO9qmBCyrCdD_NZYK5e+gh+SSLQWuMRFiJxYetA@mail.gmail.com>
 <2024080615-ointment-undertone-9a8e@gregkh>
 <CAHOvCC7OLfXSN-dExxSFrPACj3sd09TAgrjT1eC96idKirrVJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHOvCC7OLfXSN-dExxSFrPACj3sd09TAgrjT1eC96idKirrVJw@mail.gmail.com>

On Wed, Aug 07, 2024 at 09:21:12AM +0900, JaeJoon Jung wrote:
> Performance comparison when the number of indexes(nr) is 1M stored:
> The numeric unit is cycles as calculated by get_cycles().
> 
> Performance  store    find    erase
> ---------------------------------------------
> XArray            4          6        14
> 
> Maple Tree     7          8        23
> 
> Hash Tree      5          3        12
> ---------------------------------------------
> 
> Please check again considering the above.

I would suggest that you find something to apply your new data structure
to.  My suggestion would be the dcache, as I did with rosebush.  That let
us find out that rosebush was not good for that application, and so I
abandoned work on it.

