Return-Path: <linux-fsdevel+bounces-65062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D249DBFA861
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 09:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D93486A1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 07:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9A92F7475;
	Wed, 22 Oct 2025 07:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ab2x9GoW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090572F60A7;
	Wed, 22 Oct 2025 07:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761117783; cv=none; b=lIlImvTxFJEEwrUjrWG1VtYNI2LJ65zhQJQMqEIy6R4vkjk4V4dQdUq2Q0DqA72deBnadPQaElzoa5SrROLxoy5Uc3CK12bJVOBwIgkCfhC4BrZ+PwlNgT7R1FgSX7yOzjBU/Kq/O9i5SXyFpGbEow5TeOCE7Xbs5jaB0oL6Zms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761117783; c=relaxed/simple;
	bh=2cMEmbN8Jxckh4k5M+FzMZuIRSeU+pNUJKZMNKUzE7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsI84BZBcu9b8CJPtf8kFozwHw+PuDrMSoJq3XK4cyQteQz40WOuLcJJhBHvGGS/3+TRl1GTJaQhSOFyiA0k5eX+pLKjPTJKXyqVQU8ztbXZ2HqJAl9Vt+BKhHgBTXpuZxOrQewsC8AuCyzWNRiojBa4yILfFkzGi8AvfWMlL+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ab2x9GoW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jp8hcVOKyhoWq7SdhoGR9Zpb4JSwyCYDRPrya8d5ZcM=; b=Ab2x9GoWeijc96WPk0GMzNnVjE
	F0QepEFGsjZ104+ijmxjB+iRb/pAK2+XpnTxtXo8WLzqXdbcp4Y366BJm/f7S2+Fa0t0fSwkKAJ/G
	8Ho+UclRACXYe2ScsBUttmbX58rQamIfBA2uAjrSTNw8TEfL7MxfCtepD0m4n5nSuucs3uphfX4xh
	0UfB1SAYqg3WWvrAMSXbmk/jk8sb6q0wXl+E+M0MjH5dprcvL1rkVuEtGhFBYi1K60Tc9iRhYnOuy
	mJ3EdlXV2/POY6Dr63ENXCN8JCXp15UU8Ejx0zllYL9Un0hEArLEAZALdm1JutAaTlFywrTj3Cb5d
	HkBtisrw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBTBU-00000001qme-1d48;
	Wed, 22 Oct 2025 07:23:00 +0000
Date: Wed, 22 Oct 2025 00:23:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
	Christoph Hellwig <hch@infradead.org>, djwong@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] iomap: add IOMAP_DIO_FSBLOCK_ALIGNED flag
Message-ID: <aPiGVJTpM8aohQpk@infradead.org>
References: <c78d08f4e709158f30e1e88e62ab98db45dd7883.1760345826.git.wqu@suse.com>
 <20251021-leber-dienlich-0bee81a049e1@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021-leber-dienlich-0bee81a049e1@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 21, 2025 at 03:03:08PM +0200, Christian Brauner wrote:
> On Mon, 13 Oct 2025 19:35:16 +1030, Qu Wenruo wrote:
> > Btrfs requires all of its bios to be fs block aligned, normally it's
> > totally fine but with the incoming block size larger than page size
> > (bs > ps) support, the requirement is no longer met for direct IOs.
> > 
> > Because iomap_dio_bio_iter() calls bio_iov_iter_get_pages(), only
> > requiring alignment to be bdev_logical_block_size().
> > 
> > [...]
> 
> Applied to the vfs-6.19.iomap branch of the vfs/vfs.git tree.
> Patches in the vfs-6.19.iomap branch should appear in linux-next soon.

I'm not seeing it yet.


