Return-Path: <linux-fsdevel+bounces-53299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FD8AED409
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 07:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A81567A7A7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 05:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4148E1C6FF4;
	Mon, 30 Jun 2025 05:45:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC8D4A32;
	Mon, 30 Jun 2025 05:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751262347; cv=none; b=GK83T4m8RxdRMwnpwIa3L2Q7p6A3TyvTBwKZeAQW2Arkr3H3jZhWvi5wlwYwAmKZ+lyGSs3m06Vy4/XwZFmyP3GmHcsmt7X8w1iG8b3y9quCS62Dk2m8VJcGSRHgPPc2MG2l6383ciYNGYs+Bl8b/TQNGQNClqI8ckROvUeUy7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751262347; c=relaxed/simple;
	bh=yjwZRf19G9gpDwKJ0bdAop7S1tJsQHrFLh3YwyZqFKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJfUjZq0KR1tPteNIQ9KUe++Ryo8Ub4nVqnvIoh6Rxik9kCz7ZSiwp4WbT3R3IVNQ3beU0yxsXHgWpOmGxSY+didzDepzk7ysV7WlYnHg178hzGAjUdDKGaV8SCL7iMClKXra+PUFBmcs1VFJczNU72hWwtuISVVa4qWxQSrFyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0EBCE68AA6; Mon, 30 Jun 2025 07:45:43 +0200 (CEST)
Date: Mon, 30 Jun 2025 07:45:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 08/12] iomap: move folio_unlock out of
 iomap_writeback_folio
Message-ID: <20250630054542.GE28532@lst.de>
References: <20250627070328.975394-1-hch@lst.de> <20250627070328.975394-9-hch@lst.de> <aF7JHFdLCi89sFpn@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF7JHFdLCi89sFpn@bfoster>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 27, 2025 at 12:38:52PM -0400, Brian Foster wrote:
> > Move unlocking the folio out of iomap_writeback_folio into the caller.
> > This means the end writeback machinery is now run with the folio locked
> > when no writeback happend, or writeback completed extremely fast.
> > 
> 
> I notice that folio_end_dropbehind_write() (via folio_end_writeback())
> wants to trylock the folio in order to do its thing. Is this going to
> cause issues with that (i.e. prevent invalidations)?

Good point.  It renders the filemap_end_dropbehind_write call (the
function got renamed in 6.16-rc) essentially useless.  OTOH this is
the case where no writeback happened due to a race, so it isn't needed
to start with.  But it might be worth documenting that fact.


