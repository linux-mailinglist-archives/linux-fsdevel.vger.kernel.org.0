Return-Path: <linux-fsdevel+bounces-47930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FE1AA7506
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 16:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 773BE4E205B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 14:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB302550D4;
	Fri,  2 May 2025 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DWdJ6Iff"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18EC254AF7
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 May 2025 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746196410; cv=none; b=J8hjAa7F8uQV7uTi0y+kYF1YwBDGm1UReqseTbCtHk17Szg2Bo5RRh6SgNlP/lay7h21dxsQTK8h7plQ+4hNPZLGiVdBuWuVhsdD8RkbwwkWLRDCn7RPdeu2LxNwgbGokG708dDNqPa9BU1XajKXuC1ZeWhLZPRiajpHMNsKpa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746196410; c=relaxed/simple;
	bh=v5Rp66tCR2rfRjAtXWG6b4cJR5z56dbvWtUuTIKvNmA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JT2In3BA0U/wPRfmokb6XhbWPanzsjF+3fJelm4KojonuStQoGpnWZ6010DYgmuPDuRcOMcaIhfeN4x4k867JUnbyOzYMSaeZrIwUAl7NN9G/E/DrU3ICsd01l13We00wKdYqj4nMIBONaB7eRTRY7irSRuOLtM8799cxSiSRpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DWdJ6Iff; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746196409; x=1777732409;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=v5Rp66tCR2rfRjAtXWG6b4cJR5z56dbvWtUuTIKvNmA=;
  b=DWdJ6IffS/dhERsMIwHAX6Ke0XDLtJ6vMy4wdZwTNLAHZqTOBQB+fUAl
   jjZ5ekRQhF9BJtPUIVL5+QEckBN2zj9K0sn7heiyEy5JhOlZdAQ4ROPLH
   cHxyPm+M00QzuLwS5xvfN0H0Lshin6RJBByHrjhfe2CaALGdOdezLG/LM
   7g6yPSwdCx/UQoyZfZxiTZ4m37HSYQugLQVkoQ/4XIX1wXUJ4gpFKt3Ob
   cc3KCs+IUo0jBX+nsLM88IyjdavuAHcM/X8vR0vQdsRvpe+wyf9LtdGQi
   9jojGZTVN1+Oymqvc7keMlSGYveKRPlBVBMFJhpyeWxrm0lk5lM3j1J02
   A==;
X-CSE-ConnectionGUID: 710Ysi1YQDWSqECfTXXNUQ==
X-CSE-MsgGUID: PNzYPHeCQLi80DZSXvdS6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="70382631"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="70382631"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 07:33:28 -0700
X-CSE-ConnectionGUID: drzra865TBe7hccIYwHQ6w==
X-CSE-MsgGUID: +aQln23+R/+E76SOFmi5qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="139832217"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO [10.245.246.151]) ([10.245.246.151])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 07:33:26 -0700
Message-ID: <2238f487c71e07aa71ffd3b1b07e3deb72674d3b.camel@linux.intel.com>
Subject: Re: [PATCH 11/11] fs: Remove aops->writepage
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Fan Ni <nifan.cxl@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, intel-gfx@lists.freedesktop.org
Date: Fri, 02 May 2025 16:33:23 +0200
In-Reply-To: <Z-wTw5p5r4yPGfFE@casper.infradead.org>
References: <20250307135414.2987755-1-willy@infradead.org>
	 <20250307135414.2987755-12-willy@infradead.org> <Z9d2JH33sLeCuzfE@fan>
	 <Z9eVdplZKs2XVB9J@casper.infradead.org>
	 <Z9iibbHs-jHTu7LP@casper.infradead.org>
	 <9937a6346feccb7ab739aff63a084f63f3ad4382.camel@linux.intel.com>
	 <Z-wTw5p5r4yPGfFE@casper.infradead.org>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi, Matthew,

On Tue, 2025-04-01 at 17:26 +0100, Matthew Wilcox wrote:
> On Tue, Mar 18, 2025 at 09:10:38AM +0100, Thomas Hellstr=C3=B6m wrote:
> > On Mon, 2025-03-17 at 22:30 +0000, Matthew Wilcox wrote:
> > > This patch fixes the compilation problem.=C2=A0 But I don't understan=
d
> > > why
> > > it's messing with the reclaim flag.=C2=A0 Thomas, can you explain?
> >=20
> > Hi, Sorry for not responding earlier. The patch that uses
> > writepage()
> > here has been around for quite some time waiting for reviews / acks
> > so
> > I failed to notice that it's going away.
>=20
> My turn to be sorry for dropping this conversation ...

Once again my turn. This disappeared in the mail flood. Sorry about
that.

>=20
> > Anyway the reclaim flag clearing follows that of pageout() in
> > vmscan.c
> > which was also the case for the i915_gem_shmem.c usage in
> > __shmem_writeback(). My understanding was that if the writeback was
> > already completed at that point, the reclaim flag was no longer
> > desirable.
>=20
> I think the question is really why you're setting it in the first
> place.
> Setting the reclaim flag indicates that you want the folio removed
> from
> the page cache as soon as possible.=C2=A0

So when the shmem swapout has been called, My understanding was that
the page had been moved from the page cache to the swap cache and now
written out to disc and this is all part of reclaim.

When TTM reaches this part of the code, it's always called from a
shrinker with the aim of freeing up memory as soon as possible.

So if this is incorrect or unsuitable usage of the reclaim flag, we
should of course remove the manipulation of it. (IIRC I was also a bit
confused as to why it didn't seem to be protected by a lock in the
callsites I looked at)=C2=A0

__shmem_writeback() in i915_gem_shmem.c and
pageout() in mm/vmscan.c

Thanks,
Thomas



>  Other changes in flight are about
> to make this more aggressive --=C2=A0 instead of waiting for the folio to
> reach the end of the writeout queue, it'll be removed upon I/O
> completion.
>=20
> It doesn't seem to me that this is what you actually want for TTM,
> but perhaps I've misunderstood the intent of the code.


