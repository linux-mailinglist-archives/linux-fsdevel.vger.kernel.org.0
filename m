Return-Path: <linux-fsdevel+bounces-57331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9771AB20834
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 13:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B59A18C5DAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 11:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF242D29C6;
	Mon, 11 Aug 2025 11:50:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C58B2264DE;
	Mon, 11 Aug 2025 11:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754913030; cv=none; b=UTYkzENZT3dS0TW3bpcGbpy4QxTmnlg5ITjomZhsOWUl/Ki+714OgsBHAq/4CvSoPkKxpq0IyAkgv+T/SHZ7cEL0tg7ZdKt1Hr1JLYRgOPpNSy/ZHeV6/5mpKtpcBY9UzgWnLOCf2ElesdXn0CWEs6b/4iI+oNPdS6UuCr90VjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754913030; c=relaxed/simple;
	bh=H4X9Pk+nJIJFC+/8Auh/s7oadlBVdQdjPoyt2wnKcO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2qqfRZioXFTDbalJQn6OsiHdxorh8pgJH3xuHZwTEL5UjC4kiDqepAZdfks5BxuuLz32EQqhOI6qZYFeZ0jH4TRe167SZ5ns3JA6huo0drfZqD4Ne/0Ji1Ui+Vp5PEZYJxxGR3Y9dQjy01ewTH0ZXxAYWveHJyeEA+IIq7Gbps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5070468AA6; Mon, 11 Aug 2025 13:50:24 +0200 (CEST)
Date: Mon, 11 Aug 2025 13:50:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org,
	ebiggers@kernel.org, hch@lst.de,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH RFC 14/29] xfs: add attribute type for fs-verity
Message-ID: <20250811115023.GD8969@lst.de>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org> <20250728-fsverity-v1-14-9e5443af0e34@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728-fsverity-v1-14-9e5443af0e34@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 28, 2025 at 10:30:18PM +0200, Andrey Albershteyn wrote:
> From: Andrey Albershteyn <aalbersh@redhat.com>
> 
> The fsverity descriptor is stored in the extended attributes of the
> inode. Add new attribute type for fs-verity metadata. Add
> XFS_ATTR_INTERNAL_MASK to skip parent pointer and fs-verity attributes
> as those are only for internal use. While we're at it add a few comments
> in relevant places that internally visible attributes are not suppose to
> be handled via interface defined in xfs_xattr.c.

So ext4 and other seems to place the descriptor just before the verity
data.  What is the benefit of an attr?


