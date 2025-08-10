Return-Path: <linux-fsdevel+bounces-57238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E75FFB1FAD1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 17:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA27189453A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 15:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD5C26D4E6;
	Sun, 10 Aug 2025 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lB2zdLGg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1386FC0B;
	Sun, 10 Aug 2025 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754840392; cv=none; b=kPrn7K4t9FFpsGSDpq80leK37ZwOc3dKfsrUaGvlnKvMdFPedz+VTHeTIcVEPQI3SiX/d/5ODi7Os/CO1ly9Rjw+hrXIZdIYLzsY8pxW95PASge7hqh+nX3iscrwu2bvPScn+G1Ml7puiM3YZ32OW/5Cd1mg4uAbr6RbtobJnHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754840392; c=relaxed/simple;
	bh=+j1Bp9s9rjELiXx3hwgwck5ohy+WjMZZHHd17dhpuB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaKeCkHIiFAFRW9Dyq4sgMxQCkO8YYkCgraAqoJxe7xx/TJIfxyEmb7t9/oU47vUHmJv7v+DZtNNHJ0W0HUUZwHS/uJ3oZ5akMiGjrxG/0UtPP1+lFodi/xzb/55pXrx6q28N90vUXEuteqIvPpB3i1rG3hs+fYwXlJqgzPf2KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lB2zdLGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E7AC4CEEB;
	Sun, 10 Aug 2025 15:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754840392;
	bh=+j1Bp9s9rjELiXx3hwgwck5ohy+WjMZZHHd17dhpuB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lB2zdLGghuvCm4jhOTpUwNyIHAMXiz8KbNdPmjh+BqWTL2lmjMJlgcmWDzPj8Ao7L
	 MkvbqMvedvGFL7mAEnL5T4J8f+BLKBn9NN6LtaY4vFUC+9wUjjK4kEDR7MxIeEyVa4
	 8ABQ5y5lOOSK52C/BiJL8K82Wkmx2izLu6NKg39dMu6BwUznpPTXfgdFe40ZKIcjGU
	 PWzrB7xNJ+6KoaRrOADBhr9cQ171iVunpVVljdvvimpdUjnW5xzncpanuCv+JNnoIR
	 /y2WmbXOszvDQ9WJF8QWkUahLwoE/Apd0HXIBHPCh85gsy2jCno5ZxKXur9qXKZRfw
	 5g22Atux9A/lw==
Date: Sun, 10 Aug 2025 09:39:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk,
	brauner@kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv2 1/7] block: check for valid bio while splitting
Message-ID: <aJi9RgOAjXm8Hwlo@kbusch-mbp>
References: <20250805141123.332298-1-kbusch@meta.com>
 <20250805141123.332298-2-kbusch@meta.com>
 <aJiusAtZ-CsnPTOR@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJiusAtZ-CsnPTOR@infradead.org>

On Sun, Aug 10, 2025 at 07:37:36AM -0700, Christoph Hellwig wrote:
> On Tue, Aug 05, 2025 at 07:11:17AM -0700, Keith Busch wrote:
> > @@ -341,6 +344,8 @@ int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
> >  	 * we do not use the full hardware limits.
> >  	 */
> >  	bytes = ALIGN_DOWN(bytes, bio_split_alignment(bio, lim));
> > +	if (!bytes)
> > +		return -EINVAL;
> 
> How is this related to the other hunk and the patch description?

The patchset allows you to submit an io with vectors that are partial
logical blocks. Misuse could create a bio that exceeds the device max
vectors or introduces virtual boundary gaps, requiring a split into
something that is smaller than a block size. This check catches that.

Quick example: nvme with a 4k logical block size, and the usual 4k
virtual boundary. Send an io with four vectors iov_len=1k. The total
size is block sized, but there's no way that could split into a valid
io. There's a test specifically for this in my reply about xfstests.

