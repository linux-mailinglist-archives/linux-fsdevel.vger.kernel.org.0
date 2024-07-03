Return-Path: <linux-fsdevel+bounces-22993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BB99252DB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 07:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418D72866EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 05:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EF04965C;
	Wed,  3 Jul 2024 05:16:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC74C2C95;
	Wed,  3 Jul 2024 05:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719983784; cv=none; b=g9+HKZvK5V61+fVvFV5/5bD7ZHdo9pVwBRaAseGZI9LxGGvpEbFqzpMjwc1X6BsGZE0/IA0GTp8EjHNeZi0uenvBCH+4ZUmLXDUb9ujgfuNX+AG9fu3+vNJjJUK1tuUGmIq1MPJfE6OLnoPNC4R+D+7bOG5I6ouY78uNesy0k7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719983784; c=relaxed/simple;
	bh=zBM/OwFTXglD9n4ThuEV7Jg/PFbcp1z2kFMxyIINViY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ow67PN11BS41GgdP3CaWMU6gN7Pr0EYE8p9TBgSrL1Wm5RrVfOpjA/0GUB+5CJUxRv3iN7XYDWCL5QT30oosDL4ZBknP6L0ZJZwWtXnee6S7lPYMd0NmRR51fhMTBB9jOgJeQyYs6C7rxo1aHJo6PAKW4zMnnGNsyG429RRcGk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 788DD227A87; Wed,  3 Jul 2024 07:16:16 +0200 (CEST)
Date: Wed, 3 Jul 2024 07:16:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@lst.de>,
	david@fromorbit.com, chandan.babu@oracle.com, djwong@kernel.org,
	brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 06/10] iomap: fix iomap_dio_zero() for fs bs >
 system page size
Message-ID: <20240703051616.GA25052@lst.de>
References: <20240625114420.719014-1-kernel@pankajraghav.com> <20240625114420.719014-7-kernel@pankajraghav.com> <20240702074203.GA29410@lst.de> <20240702101556.jdi5anyr3v5zngnv@quentin> <20240702120250.GA17373@lst.de> <20240702140123.emt2gz5kbigth2en@quentin> <20240702154216.GA1037@lst.de> <20240702161329.i4w6ipfs7jg5rpwx@quentin> <ZoQwKlYkI5oik32m@casper.infradead.org> <20240702171014.reknnw3smasylbtc@quentin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702171014.reknnw3smasylbtc@quentin>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 02, 2024 at 05:10:14PM +0000, Pankaj Raghav (Samsung) wrote:
> > > Yes, I will rename it to ZERO_PAGE_SZ_64K as you suggested.
> > 
> > No.  It needs a symbolic name that doesn't include the actual size.
> > Maybe ZERO_PAGE_IO_MAX.  Christoph suggested using SZ_64K to define
> > it, not to include it in the name.
> 
> Initially I kept the name as ZERO_FSB_PAGE as it is used to do sub-block
> zeroing. But I know John from Oracle is already working on using it for
> rt extent zeroing. So I will just go with ZERO_PAGE_IO_MAX for now.
> Understood about the SZ_64K part. Thanks for the clarification.

IOMAP_ZERO_PAGE_SIZE ?

(I kind regret not going for just adding zero page as originally
suggested, but then we'd keep arguing about the nr_vecs sizing and
naming :))

