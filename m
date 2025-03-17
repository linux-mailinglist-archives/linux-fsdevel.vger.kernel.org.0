Return-Path: <linux-fsdevel+bounces-44161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAEBA6404F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 06:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1281890DC7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 05:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862DE2192FD;
	Mon, 17 Mar 2025 05:53:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2221DAC97;
	Mon, 17 Mar 2025 05:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742190789; cv=none; b=UyH6BBQcv4yW/jvju1nL3eyPfhAscEIn2kgOVJQjHuP7wOEXx5fsz5WZXTes4fpMVQJ4dLw9DUzBt7vqcVEhm5LKxCZymUCMD1mJuU56/u7TOWGAGuhu5+O5J4MpvnSfbWlF9epnBFCAwIIa6uVWS5M1Ms+r1IoOh2QtrwwLrJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742190789; c=relaxed/simple;
	bh=wZb7vt/O2Ac8SAIisazHSJoNOvwudjWDPkkW6A5b1+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGtjFnDwNBeR5d3whGMFJz/YVaju9R4SZRcP5xMKU5hYoWOP4WaqcM9eWphgjb5kd3mZygsdz1MoyWS1+3Q9canfWNvxelVLfqjvKogM6nTDUEOvzgxdPeItaE3vExZISSMGOcSMPyvnAxFoM+7/lFNIY1/YV/aEAUek2U/b0QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E72B768D0A; Mon, 17 Mar 2025 06:52:54 +0100 (CET)
Date: Mon, 17 Mar 2025 06:52:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>, Goldwyn Rodrigues <rgoldwyn@suse.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/7] iomap: add bioset in iomap_read_folio_ops for
 filesystems to use own bioset
Message-ID: <20250317055254.GA26662@lst.de>
References: <20250203094322.1809766-1-hch@lst.de> <20250203094322.1809766-4-hch@lst.de> <Z9Ljd-AwJGnk7f2D@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9Ljd-AwJGnk7f2D@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Mar 13, 2025 at 01:53:59PM +0000, Matthew Wilcox wrote:
> On Mon, Feb 03, 2025 at 10:43:07AM +0100, Christoph Hellwig wrote:
> > Allocate the bio from the bioset provided in iomap_read_folio_ops.
> > If no bioset is provided, fs_bio_set is used which is the standard
> > bioset for filesystems.
> 
> It feels weird to have an 'ops' that contains a bioset rather than a
> function pointer.  Is there a better name we could be using?  ctx seems
> wrong because it's not a per-op struct.

As Darrick pointed out ops commonly have non-method static fields of
some kind.  After at all it still mostly is about ops, the bio_set
pointer just avoids having to add a special alloc indirection that
will all end up using the same code just with a different bio_set.


