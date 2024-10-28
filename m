Return-Path: <linux-fsdevel+bounces-33057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A949B2F77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 12:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51511C20F41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 11:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018591D86DC;
	Mon, 28 Oct 2024 11:59:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E763A189B8D;
	Mon, 28 Oct 2024 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116778; cv=none; b=edXzjREjfN4jRlOiRssleshUL8VqlbOsKWhVi9hQe+/tzZuuhRbgFuvTd2N5bkfy98zaoE5ZsaIPncM5CiJOQNegq/7hvMEuDRh24YVeGkOq4vYPULCrOq8Q7MX6FHsKvj/NEwwcqo7dUT+SSY/S10TczEH14dq5nhobRX5Ho9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116778; c=relaxed/simple;
	bh=A93YXKktDcp5l4ZKvNgk8vvFDuzqgXHqC4elv6hexpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6r7iiszjWH9sD9XlZH9l0ik8V4PqpNmBp23PPVOkya7HkFbfIi/5pTBpFfL31T0yF1P4ZbFwIS8s9rhsNYWRC9Rc7rgSYVNpjFao73a54nBUHYAcKu97UuptOlbUjgXfXnrvyQUbAMlCilF6oZxruf0lE6oR0eDJAJsEwVCLXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4C76468BFE; Mon, 28 Oct 2024 12:59:33 +0100 (CET)
Date: Mon, 28 Oct 2024 12:59:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hch@lst.de, joshi.k@samsung.com,
	javier.gonz@samsung.com, bvanassche@acm.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv9 4/7] block, fs: add write hint to kiocb
Message-ID: <20241028115932.GE8517@lst.de>
References: <20241025213645.3464331-1-kbusch@meta.com> <20241025213645.3464331-5-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025213645.3464331-5-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 25, 2024 at 02:36:42PM -0700, Keith Busch wrote:
> +static u16 blkdev_write_hint(struct kiocb *iocb, struct block_device *bdev)
> +{
> +	u16 hint = iocb->ki_write_hint;
> +
> +	if (!hint)
> +		return file_inode(iocb->ki_filp)->i_write_hint;
> +
> +	if (hint > bdev_max_write_hints(bdev))
> +		return file_inode(iocb->ki_filp)->i_write_hint;
> +
> +	if (bdev_is_partition(bdev) &&
> +	    !test_bit(hint - 1, bdev->write_hint_mask))
> +		return file_inode(iocb->ki_filp)->i_write_hint;

I would have expected an error when using an invalid stream identifier.

That of course requires telling the application how many are available
through e.g. statx as requested last time.


