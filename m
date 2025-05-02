Return-Path: <linux-fsdevel+bounces-47897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7ABAA6B48
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 09:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9344C04AE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 07:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DD826773A;
	Fri,  2 May 2025 07:05:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA6C288DA;
	Fri,  2 May 2025 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746169545; cv=none; b=REwxV2nJFWpF4qzpSoTSzn/7zIoTkHn/UlsInEfx2/aHxWQf9V4N9At6zIbdQ3bDprDWUSJgMH3CMZPDCQ2xp1ZhJjLHjEyql3eombo0/a85PMFmvxGlaYurMN9trUxXNwDQAeQYhuOlQ34QQlAnpfa+WbjT40zmVUweX+mImCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746169545; c=relaxed/simple;
	bh=E7uWLqpiUSJQeuGNiKliTZyr4qv/ug0M4WqZ6POeUW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuSaCWrmtwH4tPy+RMjauft0VbdDYsXDl8i8Htcq+85IiPVky1nJnEGXvERgt5uy9KlvMlyWcowjv7zm/v8VP8YFwaAmcYTwBKkSNfdk6oOE9t6FlJVnIWkUvpxGhcWMM8wfFJPjP7QvxkokXj2YwcnG1h3St6QiGHorT33JA3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E60F467373; Fri,  2 May 2025 09:05:37 +0200 (CEST)
Date: Fri, 2 May 2025 09:05:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
	linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 07/19] block: simplify bio_map_kern
Message-ID: <20250502070537.GA8402@lst.de>
References: <20250430212159.2865803-1-hch@lst.de> <20250430212159.2865803-8-hch@lst.de> <282b0a35-cc60-4d61-a3b7-9b565c57b8bf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <282b0a35-cc60-4d61-a3b7-9b565c57b8bf@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, May 02, 2025 at 03:56:08AM +0900, Damien Le Moal wrote:
> > -	unsigned long kaddr = (unsigned long)data;
> > -	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > -	unsigned long start = kaddr >> PAGE_SHIFT;
> > -	const int nr_pages = end - start;
> > -	bool is_vmalloc = is_vmalloc_addr(data);
> > -	struct page *page;
> > -	int offset, i;
> > +	unsigned int nr_vecs = bio_add_max_vecs(data, len);
> >  	struct bio *bio;
> >  
> > -	bio = bio_kmalloc(nr_pages, gfp_mask);
> > +	bio = bio_kmalloc(nr_vecs, gfp_mask);
> 
> This may also fail if nr_vecs is larger than UIO_MAXIOV, in which case, the
> ENOMEM error may not really be appropriate. I guess we can sort this out
> separately though.

Yeah.  It's also existing behavior, so no real change here.


