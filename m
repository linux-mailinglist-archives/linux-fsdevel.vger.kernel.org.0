Return-Path: <linux-fsdevel+bounces-63527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10014BC022E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 06:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D305E4F2D4E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 04:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81262192E4;
	Tue,  7 Oct 2025 04:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mbmGUf3a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73D31A9F8D;
	Tue,  7 Oct 2025 04:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759810229; cv=none; b=S6Q4JTk+qic3ThNASrvrGJP5E9LMrv1BaPuzQc0uhclQyGuVFmA6KSE619BHv5f7UiHgNVrr7KMLZSILlEPu7NhCZXij1EmMLwUdK2/lFRnErD+EWX6sWiwWmU2z9luXes3WqnZbd4ew2mhTOdL/erQO+NlsSIdmb7g53rAuiOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759810229; c=relaxed/simple;
	bh=bUH3TRWCmVlvgXp1idu1SnCmpL88AXJZ0NhVdnPre20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5vfqs2LtOprJcP2V4mI3F/xiFsnELg60ugaYUVqQ1ldMp2qVqyPwveuvWbCuJsH7K3OZ6j3O17VmL8LLMne5+OtYxVEPaSEFxQxJAUL4/s6kbS0zIRpdO11sth7uHQlkAn2Wg5UGtgh7Gh5mh4+eofRa0qimHa+rdh7YeYrFsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mbmGUf3a; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Yl+ugw6Z29aoam/wvlWxMZWhNFPkaJOCTPwiBzwrPOU=; b=mbmGUf3a2ILWleMHXOqS9Siuq0
	7HJEFmhCdx7WFhlUE5czBTpUKnO13FunLb0436KlrYFKa0HI2NWphEC+FweFOVLYDvxKmTEzIqwiH
	IJ3sRewdv6MUJ0jB3DC8VVuAPANJyLGfqsuefObmuurT7LaJhvQNAz0GLXLHsPo0AyMkn4OXlwqIY
	efiKuFmOcjUIDw/7H7aJSHIGRlBrvayrCw5SiATKJmucdEmsGrGO6smaDAwsgNu3RA6iwMXREbjEa
	r26H7sPaayp/UeGe44tC2FpUJsokiE21X/189lxVtvfd6Ab/JY+l4qIWqDPO1iVt9S+MU2JDdkAEt
	yKpYiYOw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5z1v-00000001F05-1zQJ;
	Tue, 07 Oct 2025 04:10:27 +0000
Date: Mon, 6 Oct 2025 21:10:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, brauner@kernel.org, djwong@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH RFC] iomap: ensure iomap_dio_bio_iter() only submit bios
 that are fs block aligned
Message-ID: <aOSSs2CodljBMeTL@infradead.org>
References: <aeed3476f7cff20c59172f790167b5879f5fec87.1759806405.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeed3476f7cff20c59172f790167b5879f5fec87.1759806405.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 07, 2025 at 01:40:22PM +1030, Qu Wenruo wrote:
> +++ b/fs/iomap/direct-io.c
> @@ -419,6 +419,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
>  	do {
>  		size_t n;
> +		size_t unaligned;
>  		if (dio->error) {

Nit: please add an empty line after the ceclarations when touching this.
The existing version keeps irking me every time I get into this code.

> +		/*
> +		 * bio_iov_iter_get_pages() can split the ranges at page boundary,

Overly long line.

> +		 * if the fs has block size > page size and requires checksum,
> +		 * such unaligned bio will cause problems.
> +		 * Revert back to the fs block boundary.
> +		 */

The comment here feels a bit too specific to your use case.

> +		unaligned = bio->bi_iter.bi_size & (fs_block_size - 1);
> +		bio->bi_iter.bi_size -= unaligned;
> +		iov_iter_revert(dio->submit.iter, unaligned);
>  		n = bio->bi_iter.bi_size;

But more importantly I think this is the wrong layer.  In Linus'
current tree, Keith added bio_iov_iter_get_pages_aligned which can pass
in the expected alignment.  We should use that, and figure out a way
to make it conditional and not require the stricter alignment for
everyone, i.e. by adding a flag passes through the dio_flags argument
to iomap_dio_rw.


