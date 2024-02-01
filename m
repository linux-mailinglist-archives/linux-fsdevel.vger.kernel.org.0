Return-Path: <linux-fsdevel+bounces-9882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE56845AAA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 15:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3119B27ECC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 14:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1432A5F493;
	Thu,  1 Feb 2024 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzPHwvGm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C095D499;
	Thu,  1 Feb 2024 14:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799175; cv=none; b=mibnWLtCcQJXB3eM/fFx0FYZoeaRDHSJVGXgU9WtNsN5v8cl3YLjBJG9tOjDzZgGnvlgmgbiXt7yBviA0s609exONPVzlHa+qp8R3S7hPqZ2BD5KnzmqZGFk6rSNWT43gLqMlwtqimAN89iBMhiChwEIKmIUCKql/2o0T7YJ2zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799175; c=relaxed/simple;
	bh=iCSucure+BfDRAGhWXz/HK0rw6509srwDNZIRwwEwDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIUIFiZ9SkBN/OCfzTQpw/dQlzn9IkGCyGGDTqQ6Vm9ArZkgZyWoUXX5F4wlixhAjTvwhUj5yG3TIAYduY7S2KzPACPxbbIITvgCtuEq5Psdm2qylJRTXSWVyGGyrYgqnwE2qJj1ROGSG7tsco+iNORd/nUwsWPEead3oVKdDEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzPHwvGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5E7C433C7;
	Thu,  1 Feb 2024 14:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706799174;
	bh=iCSucure+BfDRAGhWXz/HK0rw6509srwDNZIRwwEwDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XzPHwvGmyhGGXy6BPovQEcTvhrDwHvvD+Ns1SvOeIrh5/BoLOztp5wg/z4iT+CU5z
	 nO4tJX3za+/gpyzuWtvuDBIr5h05vEglIWRsqp7YF2GHBNIdf0+I84hrzrP5GRicaf
	 /tfp6sUZh/YfQDs0N2JSLqY+IudxJ578bFjLxluS0srVGg0Fzj0zt4zvxZzgNJ9qGB
	 LKzVhpHjW9mGS+5QxRGt8xzdsWAXfzsrfKPuhL8yP2eLAM6BEMaHT2WGwJAXkfks36
	 tN02vMqsAPh2c/c29JfP0NewVAk0pQnPlqCmYNwlZcVFqz6frK4VcXm/8YZMK/z+p6
	 HgyT+aZBnZRjg==
Date: Thu, 1 Feb 2024 15:52:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 29/34] bdev: make struct bdev_handle private to the
 block layer
Message-ID: <20240201-loten-unbefangen-f667e094554b@brauner>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-29-adbd023e19cc@kernel.org>
 <20240201112347.jfpr26a5zhgvzmtu@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240201112347.jfpr26a5zhgvzmtu@quack3>

On Thu, Feb 01, 2024 at 12:23:47PM +0100, Jan Kara wrote:
> On Tue 23-01-24 14:26:46, Christian Brauner wrote:
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> One more thing I've noticed:
> 
> > -struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
> > -				     const struct blk_holder_ops *hops)
> > +int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
> > +	      const struct blk_holder_ops *hops, struct file *bdev_file)
> >  {
> >  	struct bdev_handle *handle = kmalloc(sizeof(struct bdev_handle),
> >  					     GFP_KERNEL);
> > -	struct block_device *bdev;
> >  	bool unblock_events = true;
> > -	struct gendisk *disk;
> > +	struct gendisk *disk = bdev->bd_disk;
> >  	int ret;
> >  
> > +	handle = kmalloc(sizeof(struct bdev_handle), GFP_KERNEL);
> 
> You are leaking handle here. It gets fixed up later in the series but
> still...

Bah, called twice instead of removed it. Fixed.

