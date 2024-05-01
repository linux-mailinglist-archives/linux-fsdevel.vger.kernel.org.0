Return-Path: <linux-fsdevel+bounces-18411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9D68B8627
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 09:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B42F1C2188F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 07:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076B14D13F;
	Wed,  1 May 2024 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AELKk3cK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A2C1D6BD;
	Wed,  1 May 2024 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714548973; cv=none; b=dXxx1AG3SCLoQoVqL1jwpMAAS4YlbCBvqoSNY56roPRnj2yeWaOxfrjagfZ8mFd81vNRIGeXoABVg6q2uR6tVAxyr7mGn5nqv5veiMJSQEAXyNlVgL1SY/xf5pO7zzRidZUj5dXgVhguIJjH1eSuTl6CdbfWONha0Sj5BVPNWI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714548973; c=relaxed/simple;
	bh=78OtVTU0S7VeuAEcwb5RQREB9F0J7C1SWmxUj81GLkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLIhTX7xwVizT2ce2fJNlS5rbhpDbngAv3UQAmSUKkyCmx8GqoiCHrAb6ZQi+IPU/T3tRxND9GOgBtTPoWxHHpo2cZV5yIaqaw2ulcNjqahic0IBpldOUE08IrBsNnCbetL3TWwhhUT/6Pn/Vlhg+tJlsc4g9Y9pk6QYSszISQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AELKk3cK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AuAV651yDKAHBeEcELA6xnyO7eX02trO0Cc/JJpvPC4=; b=AELKk3cKk+Hgjz906P5C7zzMX8
	IqAKtlHgXBtXfePcO9q8awmQSVqhoubbHaXnkvw5VeQmtI8CFyhgr9HC1btpnGsqcHe6bjCNAdFEd
	QGJkvEyB/bPfrS91mXmDGOLlKOvaxbw9RrCLUNCanZo7L6yCGZwZ0qetnY873niBpnJ+os8ScPR1x
	zscDeUI8MmVXsAr0ffZ1GMTZ7rmne65qUb8omr/0rLNkEowsxYSWZMoS7vX0/7mvsx+FIZu/xiNWl
	qM3CTp9F881mNbJMSDxLu/qY1D/QV7jF+oj2GiDv04zO3LVuCmRXHeV035kYPS/cX9Xhwv75GM98L
	+qq1j6YA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s24Vf-00000008lII-350g;
	Wed, 01 May 2024 07:36:11 +0000
Date: Wed, 1 May 2024 00:36:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, ebiggers@kernel.org, linux-xfs@vger.kernel.org,
	alexl@redhat.com, walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/18] fsverity: support block-based Merkle tree caching
Message-ID: <ZjHw6wt3K164hOBr@infradead.org>
References: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
 <171444679658.955480.4637262867075831070.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171444679658.955480.4637262867075831070.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> @@ -377,6 +391,19 @@ int fsverity_read_merkle_tree_block(struct inode *inode,
>  
>  	block->pos = pos;
>  	block->size = params->block_size;
> +	block->verified = false;
> +
> +	if (vops->read_merkle_tree_block) {
> +		struct fsverity_readmerkle req = {
> +			.inode = inode,
> +			.ra_bytes = ra_bytes,
> +		};
> +
> +		err = vops->read_merkle_tree_block(&req, block);
> +		if (err)
> +			goto bad;
> +		return 0;

I still don't understand why we're keeping two interfaces instead of
providing a read through pagecache helper that implements the
->read_block interface.  That makes the interface really hard to follow
and feel rather ad-hoc.  I also have vague memories of providing such a
refactoring a long time ago.


