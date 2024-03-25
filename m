Return-Path: <linux-fsdevel+bounces-15248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B17888AFAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 20:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4621C3C13E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 19:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1526A182DF;
	Mon, 25 Mar 2024 19:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Uo4sl+Qh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC8312B6C;
	Mon, 25 Mar 2024 19:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394351; cv=none; b=t+SuwwD1kvEGjjBrqPezQe/hC91rclxD/CoTVszyV0T3qm8hc7+ktnA3uc9+dbhgm1wWDEGcLAPNa7ko8MWmImjLfjkdZYZ5740nr4/bAaKc2+Iut8bp/zLsCcdx/FYn6l52P6hMCHh2atLQPGvSFMxsaCwfbK+/uS8PIyVwiBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394351; c=relaxed/simple;
	bh=T90UZpzDGEueZT19plmw9vcP8zjaY3O5nA88rBtE2Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzUVBEEd/C1Tw7jeVeGhoAkMagr5Sz/p9VBCd6G0LNZZLP6gUJuQ9ySxSQspEtFwo0B1YlDFfp17TgU4jH3rYgmYJtsfwHKdB8NWyNTU9wvxsghVJ4J5Jfcif5YLQjNj3FQRWuhlbsVjkuYjZHabdwkXBhgDqb96Q0mhei5xVXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Uo4sl+Qh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=S76rMVbjP+0D2W7EDE1El8rQ89zrw/wPuPDN4wnmWiI=; b=Uo4sl+QhnSVYCJFwPLHabt7imN
	Wls4Z043JkcDZU6AsE8tF6qULidYQ3MtDIi74t8xurHGIQOqrJI7tCVosrIE2ZxtMqUdItlhS4evK
	VZGKfAbzEPnWqPJ+Wx/Riln3N8T7APwYqubNkOOt2dcXVOdLtGp4AQuOxFxqoX4ll2e7uABxBFQ27
	pT1wb1JzJQH3uZoVRNGfcWjsJp3OuZkOhdpRBdcDzVcxXEGnaJ2QgfDS4wbE2AphFbRMKyPsZ4k39
	SLD2bukPPdrcn2x4H9BRPKloNRnHE2i5ZpMK90pbxfqz7bpIPN7EFnxFg6QxXFRvoZwqPa6pQhQVB
	RdN0GEnQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ropqd-0000000H9bi-2a8f;
	Mon, 25 Mar 2024 19:19:07 +0000
Date: Mon, 25 Mar 2024 19:19:07 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gost.dev@samsung.com, chandan.babu@oracle.com, hare@suse.de,
	mcgrof@kernel.org, djwong@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, david@fromorbit.com,
	akpm@linux-foundation.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3 00/11] enable bs > ps in XFS
Message-ID: <ZgHOK9T2K9HKkju1@casper.infradead.org>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313170253.2324812-1-kernel@pankajraghav.com>

On Wed, Mar 13, 2024 at 06:02:42PM +0100, Pankaj Raghav (Samsung) wrote:
> This is the third version of the series that enables block size > page size
> (Large Block Size) in XFS. The context and motivation can be seen in cover
> letter of the RFC v1[1]. We also recorded a talk about this effort at LPC [3],
> if someone would like more context on this effort.

Thank you.  This is a lot better.

I'm still trying to understand your opinion on the contents of the
file_ra_state.  Is it supposed to be properly aligned at all times, or
do we work with it in the terms of "desired number of pages" and then
force it to conform to the minimum-block-size reality right at the end?
Because you seem to be doing both at various points.

