Return-Path: <linux-fsdevel+bounces-71610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B49DCCA4DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 06:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77744301FF6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 05:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081C3306487;
	Thu, 18 Dec 2025 05:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AriwOwP7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6E7303C94;
	Thu, 18 Dec 2025 05:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766035315; cv=none; b=SjYhTU0ZmgVBw3PCNglA+4lxX2lf+65/1ov5cqRNofsO5Y3UjYgnO/MNrPyI7y2Q/wvTcn8fUHYeDSquP1RGETRJDWwtvj7gJMj9DCn70u5cJ/cjgKqPAADAkJ+vY+tC52fB08ZgfqARA9B0kasWHPAvDYyyjYs8MuaZXm4ZxfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766035315; c=relaxed/simple;
	bh=T7jaQOVSdUpeQAm/dm8hYPWxVyxizN08hSymBZCzgZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgheoSJKI/DgdH/KxOp+RxovtVXbYFQ5zx+H9dcxPdsK/I/2QARiB1Oj8w6C/WwtdJQ/fL0JCNOQVyeOHmJ1y/NI8W4fVF3/5bd9s6B5OEOjDeqGACykK6vzNjl4Z2T3w5bOnmixhKo3rLMWdDCvzKo8jwl7nUy6ZXXMMKdw5PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AriwOwP7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tvuYr5D8Q6laaTYwCJsjAZfLtDXELvjHjl5xjwK1rrc=; b=AriwOwP7oG9iQBW2psObb6x4r2
	tiTk///I53gWttq3fPQs4Z3jZdm5Rsya9nyzy3XG1p52zEv/hTrYGCoOuseBaDQQ/rDHBYIctZcuW
	xBpKvPhU03yzLRJkYCS35SH4sxT2+mQQpfjlxmZmhEFHRSvTiMrC2Fc5Vk58x8+OVanKeSfU4scVd
	NXQ/yYN4ZcfZxqrj7M7dHNgx9mVUMlGs4nfsjPsehrl1yeCWS9mBh6kolwt/Fz4b0AuYTh09vem82
	R7eWlfGKEONxkUnNbi+KfPO7UrVHMxk9yxPYyv3pN2zMfFOh4HBXDE+30wWEMe5SM73CMevhZMUB/
	ta/ngWlw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW6SW-00000007pt9-46D9;
	Thu, 18 Dec 2025 05:21:52 +0000
Date: Wed, 17 Dec 2025 21:21:52 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, linux-ext4@vger.kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gabriel@krisman.be, amir73il@gmail.com
Subject: Re: [PATCH 2/6] fs: report filesystem and file I/O errors to fsnotify
Message-ID: <aUOPcNNR1oAxa1hC@infradead.org>
References: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>
 <176602332171.686273.14690243193639006055.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176602332171.686273.14690243193639006055.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

>  	long					s_min_writeback_pages;
> +
> +	/* number of fserrors that are being sent to fsnotify/filesystems */
> +	refcount_t		s_pending_errors;

Use the same tab-alignment as the fields above?  Also is this really
a refcount?  It's a counter, but not really a reference?  I guess
that doesn't matter too much.

> +static inline void fserror_unmount(struct super_block *sb)
> +{
> +	/*
> +	 * If we don't drop the pending error count to zero, then wait for it
> +	 * to drop below 1, which means that the pending errors cleared or
> +	 * that we saturated the system with 1 billion+ concurrent events.
> +	 */
> +	if (!refcount_dec_and_test(&sb->s_pending_errors))
> +		wait_var_event(&sb->s_pending_errors,
> +			       refcount_read(&sb->s_pending_errors) < 1);
> +}

Should this be out of line?

> +/**
> + * fserror_report - report a filesystem error of some kind
> + *
> + * Report details of a filesystem error to the super_operations::report_error
> + * callback if present; and to fsnotify for distribution to userspace.  @sb,
> + * @gfp, @type, and @error must all be specified.  For file I/O errors, the
> + * @inode, @pos, and @len fields must also be specified.  For file metadata
> + * errors, @inode must be specified.  If @inode is not NULL, then @inode->i_sb
> + * must point to @sb.
> + *
> + * Reporting work is deferred to a workqueue to ensure that ->report_error is
> + * called from process context without any locks held.  An active reference to
> + * the inode is maintained until event handling is complete, and unmount will
> + * wait for queued events to drain.
> + *
> + * @sb:		superblock of the filesystem

The normal convention is to have the arguments documented above the
long description.  Any reason to deviate from that here?


