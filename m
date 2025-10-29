Return-Path: <linux-fsdevel+bounces-66197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D2FC1935E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 09:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E30950948C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 08:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568B2314B85;
	Wed, 29 Oct 2025 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UvJyccR5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6BE313E1B
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 08:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727016; cv=none; b=cwI0heADMmrYU/WXnYKNnUrb784kdCoLC/y4jrpDtJFnSdnkZ9SvNqTqoxyG7XQYfeoy6s+z795XGo2AHYprAC5hnvqdwDWO/KnakYKnqTAynVj+R/3TdaXHCE+NARU10bNTq+IuicgFOVNM7aKpzzWpgeIIlytfISbCPek54j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727016; c=relaxed/simple;
	bh=yRB+gzDBF9w3AaMV2lgKMvKtwdlRjJSNeucHfNtamnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gw6MVrvE3DhlUfKzguszGqtoOaGAUlgfJ4Jyb/ZmY5SOh+SbiNstlbo+/M0xZ39++TMbFd74IZkzZkV4xlN1z0EfN//H78JWqRLyIKfFAxgxk5DuyAUsi5gnNnR69WxSDybiBUQQWXv1gE1+YJDoKquP7fjgsaWUQNMx1sdcrPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UvJyccR5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MfbOKO2nnCl67oBvxW6HPT8xjKwksdJNT1Z5PipaKBM=; b=UvJyccR5Qo1380GRVRyZIER56I
	+CzK/ctyfh+gavFOo8XYbtI8TtmkeRwZEBInn8UrhtV1ONL5pNBQlGS1XpzHDl9gs7ePDWZirqxiH
	9UccUlLQnvl0bQ9NAKBIXFkOWgl/IIgecWqIJmtMhXzV4KopQja+IkwB8ALn9d60Jn7KZB8bqJ8yt
	v8uaAdeJYvkA8trWR7WOOcUGgZ+9Res/cIN3D7w3+q1iRH+s3958iLkGBUsKbcjLx0ensyYVl+tXo
	ESgMfmtuXsJNmyrVIP+kKlpm68xUL1NwBoJVwZp1Ja2CmplAS2xm7RNznqLCAytzEz+5Bf435frXn
	ez9+Ssyw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE1fn-00000000KYL-3j0i;
	Wed, 29 Oct 2025 08:36:51 +0000
Date: Wed, 29 Oct 2025 01:36:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org,
	bfoster@redhat.com, hch@infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iomap: rename bytes_pending/bytes_accounted to
 bytes_submitted/bytes_not_submitted
Message-ID: <aQHSI43zlNmALF1-@infradead.org>
References: <20251028181133.1285219-1-joannelkoong@gmail.com>
 <20251028181133.1285219-2-joannelkoong@gmail.com>
 <20251029055613.GQ4015566@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029055613.GQ4015566@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 28, 2025 at 10:56:13PM -0700, Darrick J. Wong wrote:
> On Tue, Oct 28, 2025 at 11:11:32AM -0700, Joanne Koong wrote:
> > As mentioned by Brian in [1], the naming "bytes_pending" and
> > "bytes_accounting" may be confusing and could be better named. Rename
> > this to "bytes_submitted" and "bytes_not_submitted" to make it more
> > clear that these are bytes we passed to the IO helper to read in.
> > 
> > [1] https://lore.kernel.org/linux-fsdevel/aPuz4Uop66-jRpN-@bfoster/
> > 
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> 
> Looks fine to me, though it's gonna be hard for me to figure out what's
> going on in patch 2 because first I have to go find this 6.19 iomap
> branch that everyone's talking about...

https://web.git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs-6.19.iomap


