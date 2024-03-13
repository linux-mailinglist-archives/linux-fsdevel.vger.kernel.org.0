Return-Path: <linux-fsdevel+bounces-14266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543D787A3C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 08:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3BC282E68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 07:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DBD17566;
	Wed, 13 Mar 2024 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UzxXb4FR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D94171A6;
	Wed, 13 Mar 2024 07:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710316730; cv=none; b=iAszUwPUbjYTTy2XcTfWyMY5GcgH4pAvfDBd1bFXZOg5LWYno5Ns49jV6fhvz1mOAeW6oHw+mfuV5AviAqrKe10z6y5MKYT6p1vh9iNSHcGzUAvXC8mTHTeQFhz4j0CPdBFTkO1acUXSczoACxKquMRsuloXAh6HcUNHCEB6nMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710316730; c=relaxed/simple;
	bh=JlKuSkPUwrhxX3vqcCM8N8UvB8OUNHKL9iWYmIFdDv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZUiUx6claVs/uV9KjMtk5QdctsczuCA3iUEnoEpppbOZahmnZVYpy6IutHRfF5sM7ytCqh0AcgeYjzWxAgTtfOfEZEDMdL3QyhkvtK+DD18s1OKSRvoBNLoc+SrhtMAujaKKNslmU1SZoO0lCPg3y4mugbaGME9Oi+L5glr7QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=UzxXb4FR; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=y3By8P/lmmAckKltg6fI83BkWW0s7sRt/a2ltlsOLZk=; b=UzxXb4FRlE4diPpaDJny1V+AWK
	dfW6zRl/Iv9JQU5BF5DJv2ry0lyLUkLXk3hU+pQgE7hjTneLobsBDyE3cQ4CXbmwq3IUsgwlewcGF
	eifIniIDRAMDhewe14wFwLlta6vrH1S5atV1LZ+6v/tI1WbmP52fsx6FxpC8/5xdOXcGQ8X9d1Fco
	mqAAg0KPuvsYS29psALFTCjuTA/KUHyD5BdhyWFjfeBz4AMHzBScAapaMGzzmU7Kos1bw2UKu5IP3
	j/9S+F04aq1rgGFLUSAo9Y1ORlI2cEHtdny1oop8a0iWoF3S4CGH3NHg+9Z1a6AbCkB/TsPAQuPU9
	t7IjzWjQ==;
Received: from [179.93.183.242] (helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rkJVT-009lNI-Pu; Wed, 13 Mar 2024 08:58:36 +0100
Date: Wed, 13 Mar 2024 04:58:29 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>, dlunev@chromium.org
Subject: Re: [PATCH] fat: ignore .. subdir and always add a link to dirs
Message-ID: <ZfFcpWRWdnWmtebd@quatroqueijos.cascardo.eti.br>
References: <874jdzpov7.fsf@mail.parknet.co.jp>
 <87zfvroa1c.fsf@mail.parknet.co.jp>
 <ZdhsYAUCe9GVMnYE@quatroqueijos.cascardo.eti.br>
 <87v86fnz2o.fsf@mail.parknet.co.jp>
 <Zd6PdxOC8Gs+rX+j@quatroqueijos.cascardo.eti.br>
 <87le75s1fg.fsf@mail.parknet.co.jp>
 <Zd74fjlVJZic8UxI@quatroqueijos.cascardo.eti.br>
 <87h6hek50l.fsf@mail.parknet.co.jp>
 <Ze2IAnSX7lr1fZML@quatroqueijos.cascardo.eti.br>
 <87cys2jfop.fsf@mail.parknet.co.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cys2jfop.fsf@mail.parknet.co.jp>

On Sun, Mar 10, 2024 at 11:59:34PM +0900, OGAWA Hirofumi wrote:
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com> writes:
> 
> >> If we really want to accept this image, we have to change the fat driver
> >> without affecting good image.  And your patch affects to good image,
> >> because that patch doesn't count directory correctly, so bad link count.
> >> 
> >
> > Well, it does behave the same on a correct image. It ignores the existence of
> > ".." when counting subdirs, but always adds an extra link count.
> >
> > So, images that have both "." and ".." subdirs, will have the 2 links, both
> > with the patch and without the patch.
> 
> You are forgetting to count about normal dirs other than "." and ".."?
> 

Yes, I was not counting those. The patch simply ignores ".." when counting dirs
(which is used only for determining the number of links), and always adds one
link. Then, when validating the inode, it also only requires that at least one
link exists instead of two.

There is only one other instance of fat_subdirs being called and that's when
the root dir link count is determined. I left that one unchanged, as usually
"." and ".." does not exist there and we always add two links there.

Cascardo.

> Thanks.
> 
> > Images with neither dirs will be rejected before the patch and have a link
> > count of 1 after the patch. Still, creating and removing subdirs will work.
> > Removing the bad dir itself also works.
> >
> > Images with only "." or only ".." would have a link count of 1 and be rejected
> > without the patch.
> >
> > With the patch, directories with only ".." should behave the same as if they
> > had neither subdirs. That is, link count of 1. And directories with only "."
> > will have a link count of 2.
> -- 
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

