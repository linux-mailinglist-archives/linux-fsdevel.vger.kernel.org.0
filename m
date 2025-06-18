Return-Path: <linux-fsdevel+bounces-51997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 411F8ADE29E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 06:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63CFE17B98A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 04:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD131EF092;
	Wed, 18 Jun 2025 04:36:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AA1134AC;
	Wed, 18 Jun 2025 04:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750221366; cv=none; b=pbYqjWf4CSveeqfH+bPm/s1+eo00SI1fvRg3HRhAhrJJGNi4h/SmibkoYnEv2nh9V6qOdlAf1Lc2CxncOOZqPxRITmOxI+QmL8YqKksWdMXh3qo/Pkjj8El3LaXpBU3UD9hBojFkl/ER7KwyS7sO1x9vdJq4eeTJPrDsLUuXXOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750221366; c=relaxed/simple;
	bh=WFZ8DLYLNpBbTGmKbBn9+AGBYtGiOB4wlvj05QzoGM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0Ulv56XT7x0YEWRcqm+jq3gQPFLyJXHsEbqJ9iIs9Wuw+HiYpAdwrFMd+WouwRb4446s0lbs+0ObGXDeQXhU/2c5yoIFNOnddUfMasEAVjMJH4mQq1E8qA/jHFsG26IiisPpewiUT1AW5PaWp+xfwtjP2sWjeK8rG06NH9I79s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 52CD268D0E; Wed, 18 Jun 2025 06:35:53 +0200 (CEST)
Date: Wed, 18 Jun 2025 06:35:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 01/11] iomap: pass more arguments using struct
 iomap_writepage_ctx
Message-ID: <20250618043552.GA28041@lst.de>
References: <20250617105514.3393938-1-hch@lst.de> <20250617105514.3393938-2-hch@lst.de> <CAJnrk1YZyuAX+OjuGdRWq1QpNj7R2BU5+Zx8mam6k+VfT9bULQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1YZyuAX+OjuGdRWq1QpNj7R2BU5+Zx8mam6k+VfT9bULQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 17, 2025 at 10:54:26AM -0700, Joanne Koong wrote:
> > -       struct iomap_writepage_ctx wpc = { };
> > +       struct iomap_writepage_ctx wpc = {
> > +               .inode          = mapping->host,
> > +               .wbc            = wbc,
> > +               .ops            = &blkdev_writeback_ops
> 
> Would it be worth defining the writeback ops inside the wpc struct as
> well instead of having that be in a separate "static const struct
> iomap_writeback_ops" definition outside the function? imo it makes it
> easier to follow to just have everything listed in one place

I'd rather not do that.  Having the structure that has function pointers
marked const and away from the data it operates on is nice to reduce the
attack surface. 


