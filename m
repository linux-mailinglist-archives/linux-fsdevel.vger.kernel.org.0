Return-Path: <linux-fsdevel+bounces-40779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C52A27727
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 17:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B2637A3355
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 16:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9442153E4;
	Tue,  4 Feb 2025 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdBUBIq2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA52215170;
	Tue,  4 Feb 2025 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738686581; cv=none; b=h5GNioEt0IaMYTVMdtn9sQaXRJb2PDTQ6LgVO8QVxevC3LC0NL46YL/x1IvfG5ILnCqkveOyv0vHn/U5gfvfPYFmiMxwJ1s01DMh6v/em9WPOas6xXHsvmjmkLm3bzJCvJ7KDWH46rR79P9D1KSN754uy5Ly7pvWBsYCbhse9mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738686581; c=relaxed/simple;
	bh=Qs6e0KJlL+rHWKqr6JOBVAvvD5sz4CzA9l65oUAebTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2TSjsU/T2/dE3CkJ+NAzFer0tRQnLg5cDNdloNNS+QmkTabtUjFpJWdpcIMW+AazBR8S/h0mdvRybbAZAlhDXd2HWdKI9qugcgaEj9LfEmAm9Qjr1NZ2bTSycdY7nUXAd2XB3PyRZyuC1wkc//G21UDLwDsXR/DCTDiz3W/AzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdBUBIq2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17810C4CEE8;
	Tue,  4 Feb 2025 16:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738686580;
	bh=Qs6e0KJlL+rHWKqr6JOBVAvvD5sz4CzA9l65oUAebTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JdBUBIq2xMKlpcYxMCmcKUd8j1Xq6x+z+tYS1Ajbxt/YfVapIZXoDhF+iiNxkpWA/
	 7RdPXRapN18qMjALO09/YSt9NZBvTyHpBFUsT9YIk9oL65epwkfwZPOsheVyOQqGSY
	 goNCRj4deYMxVLxFJmJb/jAXmLG44wXfsGUFTJrq/JWFkoL5NLkIvvfOrUfWPvE9hK
	 B1+I1FKLgtRQsVOlRerK33LV11JwmXezP4Rc3sKRMzNx/MRLdPQGl+lJaB55d0VEL+
	 hgzbWmQypQ56XtjWEgnBXxcAw/BSYHHSYhN1jAUisrCepGafrZcgKUOvquOVi0x1iB
	 165DdMvrdH+2A==
Date: Tue, 4 Feb 2025 16:29:38 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2 v6] add ioctl/sysfs to donate file-backed pages
Message-ID: <Z6JAcsAOCCWp-y66@google.com>
References: <20250117164350.2419840-1-jaegeuk@kernel.org>
 <Z4qb9Pv-mEQZrrXc@casper.infradead.org>
 <Z4qmF2n2pzuHqad_@google.com>
 <Z4qpurL9YeCHk5v2@casper.infradead.org>
 <Z4q_cd5qNRjqSG8i@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4q_cd5qNRjqSG8i@google.com>

On 01/17, Jaegeuk Kim wrote:
> On 01/17, Matthew Wilcox wrote:
> > On Fri, Jan 17, 2025 at 06:48:55PM +0000, Jaegeuk Kim wrote:
> > > > I don't understand how this is different from MADV_COLD.  Please
> > > > explain.
> > > 
> > > MADV_COLD is a vma range, while this is a file range. So, it's more close to
> > > fadvise(POSIX_FADV_DONTNEED) which tries to reclaim the file-backed pages
> > > at the time when it's called. The idea is to keep the hints only, and try to
> > > reclaim all later when admin expects system memory pressure soon.
> > 
> > So you're saying you want POSIX_FADV_COLD?
> 
> Yeah, the intention looks similar like marking it cold and paging out later.

Kindly ping, for the feedback on the direction. If there's demand for something
generalized api, I'm happy to explore.

