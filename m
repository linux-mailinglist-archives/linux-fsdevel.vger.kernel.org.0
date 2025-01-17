Return-Path: <linux-fsdevel+bounces-39513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F19BEA15649
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 19:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 341D97A04C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 18:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFE91A2622;
	Fri, 17 Jan 2025 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wTSkYsV8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664C8A95C;
	Fri, 17 Jan 2025 18:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737137144; cv=none; b=uWl8YnDFXTekP3ZofVGH+LkVSgyxlkYi5PCioyByZ+KI6gm2o89c1WdK7BpsOY4MAxWh5R81C6L9/J5JnREAbvQmmJNnHduaGIVKggWD55KxmFzKO3mqIKazwN3as9Dpoo46MTpVkWwL6lpFI0sgimbo35ORov52SfNBeXTo5Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737137144; c=relaxed/simple;
	bh=9bjlHAMtCnylIU16xn1UJTwDeujlQLfWOon2BQrViE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4XSE8TIhbzIaN3S8zbOYSoU/23lOj7DThKny4xYYj7GmXNqDA85B/t57OXK2V/jYZPGktGu7ZiN1OcuZuRE47Fp/EF90HjNihO2IPpJ5LeIYaoCEIwFUeXiKZwHa20LTpY9JQNrOXP4o8dRehP3id/OpVjQupt88EfdX3FkOcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wTSkYsV8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=crFctZGK1/RGRGxYEhsR3mb5wLIScLWaRkZC5BjZqXk=; b=wTSkYsV8/8R1DPP5PTZSUbjVKt
	7SS02vKzNybTsz2f3gvUwRlTvGiIqDZDxf+2n/CMCjPNyVCHDRGMaKZITpxBfeLwIXHaE/UJF0lBz
	GAThwEcXWIzsXt0qOaJgQM/YwROOAmwwccTqwBiRhP0mKcZWB8ViXJHTsVl8jB+hhXCgYzgz4vtmh
	hKDEtcxTTdU3BvOkD8n7wEXkhElCCWVnPlmkI0HtoJGO3FDupKSC9hU1DiQOooccul5xicwqscQ3s
	wQYZcQopSoGqedln7PIeVUAwtvLsvPoB+6/D92xP4ShbH1xO59NBPMx5E2OLv3l+RpsBSm4NSRTc2
	nEieqEpQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYqiy-00000000UqK-17Vc;
	Fri, 17 Jan 2025 18:05:40 +0000
Date: Fri, 17 Jan 2025 18:05:40 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2 v6] add ioctl/sysfs to donate file-backed pages
Message-ID: <Z4qb9Pv-mEQZrrXc@casper.infradead.org>
References: <20250117164350.2419840-1-jaegeuk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117164350.2419840-1-jaegeuk@kernel.org>

On Fri, Jan 17, 2025 at 04:41:16PM +0000, Jaegeuk Kim wrote:
> If users clearly know which file-backed pages to reclaim in system view, they
> can use this ioctl() to register in advance and reclaim all at once later.
> 
> To MM and others,
> 
> I'd like to propose this API in F2FS only, since
> 1) the use-case is quite limited in Android at the moment. Once it's generall
> accepted with more use-cases, happy to propose a generic API such as fadvise.
> Please chime in, if there's any needs.
> 
> 2) it's file-backed pages which requires to maintain the list of inode objects.
> I'm not sure this fits in MM tho, also happy to listen to any feedback.

You didn't cc the patches to linux-mm, so that's a bad start.

I don't understand how this is different from MADV_COLD.  Please
explain.

