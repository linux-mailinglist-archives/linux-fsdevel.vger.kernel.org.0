Return-Path: <linux-fsdevel+bounces-44457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DB0A69484
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 17:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5350B8842FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 16:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41081DE4DF;
	Wed, 19 Mar 2025 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B6Lk+cbG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAC32D78A;
	Wed, 19 Mar 2025 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400872; cv=none; b=U4xKnaeVtMJv323WjYC/SV3tc2y38xKsfqgT0miEJEZPMMuQUPbZHfXvoyUFstgKrqlQrkZ11XYOw1kYQy8tqAjdRI5RvVnuaQN/aY7yaC2KzTSTyojZEEd/Bjt1dWyR3ylb+XMVp6oHmT04QddTtcfX07MUUxyVum6Qo45OW48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400872; c=relaxed/simple;
	bh=x709FiLUI2ydKxVekyPucdWkhGQlbP52OAvNPOJVxvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBoAeG7+ckNdvwSdJLta+tALaOO5sGMHdHXiQorpxacLdImaFNpGvA1gW1TU2mulgm0WSO0jF6dK/wFxSNMleJ1nyQJAc9jrOOi7Jh8500IBEzcqeWinlbvqCDlOwLUbniSFCvKsmobdGZ/y/0ea0YVsVT/F5rR4XZzDAyrSUXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B6Lk+cbG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TriotLv3nyl4w+flub5w4GW0wa/2B33VE1ftY5OUZSM=; b=B6Lk+cbGqUrtwm5imzc8FhlFPq
	20nOPvlSPrxAz4FoeSoeAJMyHToxv7j+SMsihtUZPCsojyrx60ZDE1HteaXG05TA2DHwH7Urvz+1Q
	Y8P9pOE8M18CyUDpXkhJSbk6WSINink6E349ILrSe7lRS8+H17GMN6SmFlDveM5zvR4GKb9QyWAwY
	B9dmmt3oue4Z1WuDb3GrNPUXlFHERdcAf+KHSqyFdbp8t5T5k7Bxf47l7kMxa9xI3Ml/MMrkjjI7x
	kQ3oyTtWWU9mYwPxDMycBdcanEHsOjXGWctK3jKZ2rWjItKBJKoW7wkYUEkWJeRIeeimTHXEf8qoH
	esggwaKA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tuw3i-0000000CD9W-0mFs;
	Wed, 19 Mar 2025 16:14:22 +0000
Date: Wed, 19 Mar 2025 16:14:22 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: load the ->i_sb pointer once in
 inode_sb_list_{add,del}
Message-ID: <Z9rtXtqFAg7S5A1k@casper.infradead.org>
References: <20250319004635.1820589-1-mjguzik@gmail.com>
 <nb5g34ehva6wmjusa3tin3wbsr26gm6shvuxfspzkwpor6edxk@ncx2um24ipwq>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nb5g34ehva6wmjusa3tin3wbsr26gm6shvuxfspzkwpor6edxk@ncx2um24ipwq>

On Wed, Mar 19, 2025 at 05:11:25PM +0100, Jan Kara wrote:
> On Wed 19-03-25 01:46:35, Mateusz Guzik wrote:
> > While this may sound like a pedantic clean up, it does in fact impact
> > code generation -- the patched add routine is slightly smaller.
> > 
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> 
> I'm surprised it matters for the compiler but as Christian wrote, why not.
> Feel free to add:

I suspect it's because there's a spin_lock() involved.  The barriers
we have probably mean we've told the compiler that it can't cache the
value loaded before the spin_lock().

