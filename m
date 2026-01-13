Return-Path: <linux-fsdevel+bounces-73379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D73D173F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 09:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AEAA300B83D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 08:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A8237FF56;
	Tue, 13 Jan 2026 08:19:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31FA314A89;
	Tue, 13 Jan 2026 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768292365; cv=none; b=VN8c0sIXeK1GUWE+CPWB5oBd8j3lssOyOQ8K5H7eRyuarUfjC+KAPnjZrAFDtKZC9lRYaVVFe1LntKBQC4Wz8hFQ1NT1gGZ8DlnZKAdEF9xqSWcVjcCejiGhav2R2SutYrIJ/SutbUJk2mwauHv3n/FqSZNZHPTiWjDAAyQaLQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768292365; c=relaxed/simple;
	bh=T+M+EGT+9LnhHqqz3Q8jSpsMKlvQE918eUy35nbwZNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iual2SRzeyoYLkF0IL1LUhGId2kwi/MAY5og1SxQ6btUgLVeGdLdLkppuO/ZpHDRVc94Oj4/FS5aFceiiRmMo8OHFAHyIk80qm5Q0qx5ZTmsw0bwNtvX3FpKjQ9Ikvbu/0Vl1WLS2sBUiVwsFOV24ALeJBtw+2/SAeQNlmefAa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8FAC5227AA8; Tue, 13 Jan 2026 09:19:20 +0100 (CET)
Date: Tue, 13 Jan 2026 09:19:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
	aalbersh@kernel.org, djwong@kernel.org, david@fromorbit.com,
	hch@lst.de
Subject: Re: [PATCH v2 5/22] iomap: integrate fs-verity verification into
 iomap's read path
Message-ID: <20260113081920.GD30809@lst.de>
References: <cover.1768229271.patch-series@thinky> <fm6mhsjqpa4tgpubffqp6rdeinvjkp6ugdmpafzelydx6sxep2@vriwphnloylb>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fm6mhsjqpa4tgpubffqp6rdeinvjkp6ugdmpafzelydx6sxep2@vriwphnloylb>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 12, 2026 at 03:50:26PM +0100, Andrey Albershteyn wrote:
> +#ifdef CONFIG_FS_VERITY
> +static void
> +iomap_read_fsverify_end_io_work(struct work_struct *work)
> +{
> +	struct iomap_fsverity_bio *fbio =
> +		container_of(work, struct iomap_fsverity_bio, work);
> +
> +	fsverity_verify_bio(&fbio->bio);
> +	iomap_read_end_io(&fbio->bio);
> +}

I'd much rather use the ioend processing infrastructure for this rather
the reinventing another deferral method.  This series:

https://git.infradead.org/?p=users/hch/misc.git;a=shortlog;h=refs/heads/iomap-pi

has the small patches enabling it for reads, and I will post a rebased
and updated version soon.


