Return-Path: <linux-fsdevel+bounces-57788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C0FB25440
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 22:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1B817B2DA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 20:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0072FD7D3;
	Wed, 13 Aug 2025 20:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaA6/QFQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD8C2FD7B8;
	Wed, 13 Aug 2025 20:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755115583; cv=none; b=J/nqA8O/MvuRDWNeHl/7m3uE2J96RkkO4L/zrSF7qVPGVlxWqrSwJ8MoXx/tu1sFdDuYyRPKkxgbT+zmaBSY1ZoR8dtmAg8v8p97ELDsFeDD2G73MVFXhhtHPupZ8S5tEmbMlMIgxhwS+zYs74iaj5BwUie5ytxsIa5IhWlQcpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755115583; c=relaxed/simple;
	bh=MITMK6arStSROO99HgFrV3njjzctU3Jclr9cKBRlHwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aegQrCPHRAqZP/CHQIEXe6PVJKlG4fIT4GzkBAfs2t2GBYSXY3oJpUvvwS2WZXSRWMYNvkZTP5a/mWgYCoQMS1IE1ZHUCWmpEzrlelyZyfTrqCfGZ9+LmyYre0SISr/XMqheXnvATf+5AzJvu0WfLta+7DRVuyGC0/jV1pq5wUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaA6/QFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DD8C4CEEB;
	Wed, 13 Aug 2025 20:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755115581;
	bh=MITMK6arStSROO99HgFrV3njjzctU3Jclr9cKBRlHwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DaA6/QFQAY4T6096Mq+zahNS5iKjjeyEAGrHj+m7q6g6Y09qigRyJW/xruyD0IXXB
	 Aji/yksQO+GIFWgx5GAfqeEg3ORQmUlJXcPN1f/RAis6hgMT3yjstObIw8H44uvjLn
	 j2BV3UYC1/GCSCogaFulGWI3C9J+2okpuE2QGAipS2j5GrCenSegMvAAS6J+I06wBg
	 C8vt0uECEh9W7xPzjlOU9tYVOF33yHZlVFwtfNSabI8h8RZBGyK0GlQRPeH3ogPFVs
	 sN9V2NJKLTfbNuS/wbeMPb2pp90FESGj2ufz9xNC7MinyWFs4+MwZVjumcvmCbOUd7
	 o9GIsa68I45sw==
Date: Wed, 13 Aug 2025 14:06:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, snitzer@kernel.org, axboe@kernel.dk,
	dw@davidwei.uk, brauner@kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv2 1/7] block: check for valid bio while splitting
Message-ID: <aJzwO9dYeBQAHnCC@kbusch-mbp>
References: <20250805141123.332298-1-kbusch@meta.com>
 <20250805141123.332298-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805141123.332298-2-kbusch@meta.com>

On Tue, Aug 05, 2025 at 07:11:17AM -0700, Keith Busch wrote:
>  	bio_for_each_bvec(bv, bio, iter) {
> +		if (bv.bv_offset & lim->dma_alignment)
> +			return -EINVAL;

I have a question about this part here because testing with various scsi
is showing odd results.

NVMe wants this check to actually be this:

		if ((bv.bv_offset | bv.bv_len) & lim->dma_alignment)

because the dma alignment defines not only the starting address offset,
but also the length. NVMe's default alignment is 4 bytes.

But I can't make that change because many scsi devices don't set the dma
alignment and get the default 511 value. This is fine for the memory
address offset, but the lengths sent for various inquriy commands are
much smaller, like 4 and 32 byte lengths. That length wouldn't pass the
dma alignment granularity, so I think the default value is far too
conservative. Does the address start size need to be a different limit
than minimum length? I feel like they should be the same, but maybe
that's just an nvme thing.

