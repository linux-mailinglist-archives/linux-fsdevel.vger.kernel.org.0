Return-Path: <linux-fsdevel+bounces-30834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAD698EA2B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 09:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00DFC1F21212
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 07:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631F084A39;
	Thu,  3 Oct 2024 07:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hn+2e0JE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317921C32;
	Thu,  3 Oct 2024 07:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939559; cv=none; b=pxenQYp6xh6iNEMdJcvQo6hnIFVSfIFsXCf+Gi60o+8h/6UGi3g5mWxkR52aKPLglqhi8qhfrbJGKWSf76XIixIzWSOaTROEH94SJkUrJ+6D+2sfEqSnQXE3JtHFqSIEBtg/t7SmFtw1CaoaFY9PePYWyeQUhZZ1A/MlAHxf0es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939559; c=relaxed/simple;
	bh=PTsd+bP5qeURqISyWi5hCOZES9sZvDVoSBKYRaT7tvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piWH0pJWRoHfLrKlY44ICM1+n0jTcMmZ9FgKGX92Q0hFLvg7rSJyQytE2A7StRbCc6MwXhixql72q2b3rXcQNTM/mrhK5y58xmHIXJQs5fZyJpgQ62n1GQsNv++d3IW/1U8weg5TBQNpWROoE3JKMiBs/vwo4b04NLbQSqAuz8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Hn+2e0JE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=a/AwfTwwoIBd5qDOz+f5wKGc+JlskK1uYnVh3TKbyJw=; b=Hn+2e0JEJsXFjGQ7DJ231AP1Li
	gEg0oTg9EurLIcXCOCvtQAELsGsjoDrlLWchsNypf5Kk0o7Sj2bak+b8LTb9xhj0z1nNtnIkNaJbx
	ffyvhi1KganixppOAvEI+uYGejpeFMjuQJpGOZsb43uVoEGDnR74fnkr432+K+nbb7zhHtqVb1bTJ
	3cPysSIrTY8GV44rKJyH8jgbXEWhZMEAofIAGI7I+NmnWTYlhC3TnO3UewKC3Ar56t7zjNjCy1uNc
	tQctHNMivaPLpVq+ENYHfaDCWkkPQizTbZqpwsOA/UiO3dKct3JVobQD0smxodItIOtKKyrBNSpcJ
	DUUPGIEw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swG0j-00000008MdQ-3G4a;
	Thu, 03 Oct 2024 07:12:29 +0000
Date: Thu, 3 Oct 2024 00:12:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 2/7] vfs: add inode iteration superblock method
Message-ID: <Zv5D3ag3HlYFsCAX@infradead.org>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002014017.3801899-3-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002014017.3801899-3-david@fromorbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 02, 2024 at 11:33:19AM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Add a new superblock method for iterating all cached inodes in the
> inode cache.

The method is added later, this just adds an abstraction.

> +/**
> + * super_iter_inodes - iterate all the cached inodes on a superblock
> + * @sb: superblock to iterate
> + * @iter_fn: callback to run on every inode found.
> + *
> + * This function iterates all cached inodes on a superblock that are not in
> + * the process of being initialised or torn down. It will run @iter_fn() with
> + * a valid, referenced inode, so it is safe for the caller to do anything
> + * it wants with the inode except drop the reference the iterator holds.
> + *
> + */

Spurious empty comment line above.

> +void super_iter_inodes_unsafe(struct super_block *sb, ino_iter_fn iter_fn,
> +		void *private_data)
> +{
> +	struct inode *inode;
> +	int ret;
> +
> +	rcu_read_lock();
> +	spin_lock(&sb->s_inode_list_lock);
> +	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> +		ret = iter_fn(inode, private_data);
> +		if (ret == INO_ITER_ABORT)
> +			break;
> +	}

Looking at the entire series, splitting the helpers for the unsafe
vs safe iteration feels a bit of an odd API design given that the
INO_ITER_REFERENCED can be passed to super_iter_inodes, but is an
internal flag pass here to the file system method.  Not sure what
the best way to do it, but maybe just make super_iter_inodes
a wrapper that calls into the method if available, or
a generic_iter_inodes_unsafe if the unsafe flag is set, else
a plain generic_iter_inodes?

> +/* Inode iteration callback return values */
> +#define INO_ITER_DONE		0
> +#define INO_ITER_ABORT		1
> +
> +/* Inode iteration control flags */
> +#define INO_ITER_REFERENCED	(1U << 0)
> +#define INO_ITER_UNSAFE		(1U << 1)

Please adjust the naming a bit to make clear these are different
namespaces, e.g. INO_ITER_RET_ and INO_ITER_F_.


