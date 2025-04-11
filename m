Return-Path: <linux-fsdevel+bounces-46297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23C2A862BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 18:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08009A3A72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 16:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659943FB31;
	Fri, 11 Apr 2025 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HNUdL+7P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036652144CF
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744387291; cv=none; b=nB4u2oXdHL1ytcLam5Dugj3aZpkQUZlKhYt5nt3pgxDPH7j9Tg+j7cBqTfZk8M9IugFvTAz744XomNFiiseajiiNtN5T+R/Q6Svo+RlDL2/pSz5PVIZAt19aO81BpGJXHXU1lNnnUNY3x18obLboRV0wAG6MGYbPf6ffAz3NPH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744387291; c=relaxed/simple;
	bh=30VybuAdkslZ5jMJaTPgXJDR/Yx4hDI+pYPXUjEZwDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AoWxY/4dXy06LyN7Bg6GAnxXtbr+U5jyjOEUtf6RV+gZgoCeVFJV3BrRppUPWP2SgZaIEoZM/ypR0LoidfqYTrwS0Pns8MunYDMwkao0pGlozYqkzUSggK+aAkTaQyE8pthwuAyYT3/YhzVlF14y4prYK6ixNLtdoAKm9mtNLe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HNUdL+7P; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZHvD1GZZOmzm1/odJ0j4tVXypT6BHcVH+Bk63G08T9g=; b=HNUdL+7PKhRCOfK9iJ5GiNfQcq
	YS3jkjV8Z7tnoGGawd9Vix76Z/8t3C52tIhfz5xEYj0o0v67/JNAXFn5QZmyqlQnucWdZ9aRq5fGR
	RSE/IHJdQAVIl7qgm+X2HMIV0mG0arEsvhmWP8BgjMJeUKw1ZItn3cyqykTfQcPbZDVGzhCTwi9uh
	Unhnt0aoWCaOCAn3j9/w7JHjQ5uV1E4x3AEryBFvtCqEld2xQHKtgJazl0QOIiRvgut9ygCJnA+AU
	/SRto3jR0Ph36lfZxOSTOHioX1kXNc88YtK1+4Bv8OkItS1iafEAuFPeSLcRv6wJsaPHG+CHlvSRG
	jHsfhMcA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u3Goo-00000004aod-0N9S;
	Fri, 11 Apr 2025 16:01:26 +0000
Date: Fri, 11 Apr 2025 17:01:25 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Ian Kent <raven@themaw.net>
Subject: Re: bad things when too many negative dentries in a directory
Message-ID: <Z_k81Ujt3M-H7nqO@casper.infradead.org>
References: <CAJfpegs+czRD1=s+o5yNoOp13xH+utQ8jQkJ9ec5283MNT_xmg@mail.gmail.com>
 <20250411-rennen-bleichen-894e4b8d86ac@brauner>
 <CAJfpegvaoreOeAMeK=Q_E8+3WHra5G4s_BoZDCN1yCwdzkdyJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvaoreOeAMeK=Q_E8+3WHra5G4s_BoZDCN1yCwdzkdyJw@mail.gmail.com>

On Fri, Apr 11, 2025 at 05:40:08PM +0200, Miklos Szeredi wrote:
> However, hundreds of millions of negative dentries can be created
> rather efficiently without unlink, though this one probably doesn't
> happen under normal circumstances.

Depends on your userspace.  Since we don't have union directories,
consider the not uncommon case of having a search path A:B:C.  Application
looks for D in directory A, doesn't find it, creates a negative dentry.
Application looks for D in directory B, creates a negative dentry.
Application looks for D in directory C, doesn't find it, so it creates it.
Now we have two negative dentries and one positive dentry.

And for some applications, the name "D" is going to be unique, so the
negative dentries have _no_ further use.  The application isn't even
going to open C/D again.  If there's no memory pressure, we can build
up billions of dentries.  I believe the customer is currently echoing
2 to /proc/sys/vm/drop-caches every hour.


