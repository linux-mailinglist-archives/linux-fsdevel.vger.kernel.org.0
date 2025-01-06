Return-Path: <linux-fsdevel+bounces-38453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FFDA02DBB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 17:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D254D18866B6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 16:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922591DDA2D;
	Mon,  6 Jan 2025 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OnBjuc8E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808525588B;
	Mon,  6 Jan 2025 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736180872; cv=none; b=PyJUaaMjTycUqa1kPrvzbMjTWo6KnZW7Nfd+BrYdskOMrF7rsnHIjMnvh6/3vfqpyrjFL15zUiICsOkuunQjBlKnY/PuETWz4GTKGEgejaQgsR1pDLPbR3sHAmvL96mXbm9wXwt2iJ6pj7dzxfbREvEmcNx8fTvxSDu1LjW4zys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736180872; c=relaxed/simple;
	bh=Fomuz/EBD/5TGfh5JGUZufOEE3Z0Y1oj90ba/+Shcpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFDzVYMNABUKYK8brohOggICPHU1G01obEfrX7conoiJZNkPChE6030UKTu0K4doUEmoRLbHKh9a3nqVn8q8DKzQJsl0eR6Iq3DFU4AlUjd3qliwcYzWWBfiouyXXCz7AoZzB/BiTnoQbx6Pc1fe1U+hw1Zl2lBITaJs8cIWIKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OnBjuc8E; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wJ7QdkCRSNGQvgkqoChtfy+6WGylrW8PxRnF8JCCDAE=; b=OnBjuc8EFW1c4+pEHC1fIDEGe/
	tQ0Rl0/42Stp3HJdlOdsZg488e6kcsi8pI+IDaCjWTX0o4J/5IW/wXeY+3Wlw6zdXiD2Bu0/SseLm
	AppfAuXSG5IjbvRNGOmV4bhYPq6/HHa6EbLXQkNJpnJTqwdsXqKiEkWpZoQLCPFOsymAf7BL/842D
	7uQFATdYKgeMS00YP7h5McP2GUUESH7vN9e2SFbaPUCmvnyBscUJ7zVHr8wKr91LItb08GSXzCwAl
	RGBcu7NIyb4R0748KfbexBhHUMeSq1AbcL7npMksnhHRMBjyskfTVNxRjx0NQ4AUkPub75/yIX7dn
	tfjxuU+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tUpxF-00000001xR6-3aT9;
	Mon, 06 Jan 2025 16:27:49 +0000
Date: Mon, 6 Jan 2025 08:27:49 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Christoph Hellwig <hch@infradead.org>,
	Zhang Yi <yi.zhang@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	djwong@kernel.org, adilger.kernel@dilger.ca, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com,
	Sai Chaitanya Mitta <mittachaitu@gmail.com>,
	linux-xfs@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] fs: introduce FALLOC_FL_FORCE_ZERO to fallocate
Message-ID: <Z3wEhXakqrW4i3UC@infradead.org>
References: <20241228014522.2395187-1-yi.zhang@huaweicloud.com>
 <20241228014522.2395187-2-yi.zhang@huaweicloud.com>
 <Z3u-OCX86j-q7JXo@infradead.org>
 <20250106161732.GG1284777@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106161732.GG1284777@mit.edu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jan 06, 2025 at 11:17:32AM -0500, Theodore Ts'o wrote:
> Yes.  And we might decide that it should be done using some kind of
> ioctl, such as BLKDISCARD, as opposed to a new fallocate operation,
> since it really isn't a filesystem metadata operation, just as
> BLKDISARD isn't.  The other side of the argument is that ioctls are
> ugly, and maybe all new such operations should be plumbed through via
> fallocate as opposed to adding a new ioctl.  I don't have strong
> feelings on this, although I *do* belive that whatever interface we
> use, whether it be fallocate or ioctl, it should be supported by block
> devices and files in a file system, to make life easier for those
> databases that want to support running on a raw block device (for
> full-page advertisements on the back cover of the Businessweek
> magazine) or on files (which is how 99.9% of all real-world users
> actually run enterprise databases.  :-)

If you want the operation to work for files it needs to be routed
through the file system as otherwise you can't make it actually
work coherently.  While you could add a new ioctl that works on a
file fallocate seems like a much better interface.  Supporting it
on a block device is trivial, as it can mostly (or even entirely
depending on the exact definition of the interface) reuse the existing
zero range / punch hole code.

