Return-Path: <linux-fsdevel+bounces-63533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DBABC02C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 07:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29F0189C3C5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 05:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38ED11DDA1E;
	Tue,  7 Oct 2025 05:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z6Lu+2ZJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D914C6C;
	Tue,  7 Oct 2025 05:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759813834; cv=none; b=JZu+c2Nn5DZj4qioVvkGUt9xGytE4A8HZ1qXa65ogfZViUX3wBtWX5G2cJHO4V1V4IauNamg1EpE/ogrknsV/uBZoNymVvThxPOuwRy+OK/VuwySBpGotWH+8VPiUR7Ks9Th78ubTSzvkaHYiamcjF6yl7yGLDmuiDR5QYcC4Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759813834; c=relaxed/simple;
	bh=RTEiExciP8/R4hGtwF66A3na/tFaTqWtPRoTMHyhGVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwUkE+fCJ5ApOxnd6ra527kVparPmuQ3r5xKC7mJp/dokwMLHZ19Y+58P0KVuF/110qLQCwKryT+gbweIts7a6bP5C3vy4SdJHdEnAZsn+v37oaH7wNLXS3Xi511AuK0IqMNqTkWZgvHXlG6Yy6mWXV022mWBhgUoXUsnE8kXwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=z6Lu+2ZJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=H7+kqJdrOtlrnhWTU+oo8aVXwAXn0Jj3b2J0DwZYPa4=; b=z6Lu+2ZJWEM4PGwIYsZF4X6mp/
	zeB3ivMcxgMAynWW1oqk4lWBLhDDWqZUwpdnwJBKFDZx5abS6bg78IZhNjWgAStDOI4cEthI/P1ty
	gyW1Ml8U20NvfCCO3bJY10DMRTSpW6IO+DPVwQkEIl/p1tlDCSWKaENhAoXTn/8iHARjy5m7EIoTB
	Anlv/Z/j/KWyohmaYSFtgbO40W8kHO7HPj8fBl5dNgJa53Ox2ULHwvgEME6XlH+JZmVfiSvjX/9Pv
	xUMD4UYoNl8D1ijFrZ5B1AwnB61+tE/iBxAjala8PvY9k5Bn9GMn5vvGjlFhUjIk2z0osv7OCbTP5
	sx/DQ7dg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5zy4-00000001GzI-1bbO;
	Tue, 07 Oct 2025 05:10:32 +0000
Date: Mon, 6 Oct 2025 22:10:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Pavel Emelyanov <xemul@scylladb.com>, linux-fsdevel@vger.kernel.org,
	"Raphael S . Carvalho" <raphaelsc@scylladb.com>,
	linux-api@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] fs: Propagate FMODE_NOCMTIME flag to user-facing
 O_NOCMTIME
Message-ID: <aOSgyIqL3DS-ida1@infradead.org>
References: <20251003093213.52624-1-xemul@scylladb.com>
 <aOCiCkFUOBWV_1yY@infradead.org>
 <aOLr8M6s1W2qC5-Q@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOLr8M6s1W2qC5-Q@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 06, 2025 at 09:06:40AM +1100, Dave Chinner wrote:
> If you don't care about accurate c/mtime, then mount the filesystem
> with '-o lazytime' to degrade c/mtime updates to "eventual
> consistency" behaviour for IO operations.

Exactly.

> Lazytime updates can generally be done in a non-blocking manner
> right now (someone raised that in the context of io-uring on #xfs
> about a month ago), but the NOWAIT behaviour for timestamp updates
> is done at a higher level in the VFS and does not take into account
> filesystem specific non-blocking lazytime updates at all.  If we
> push the NOWAIT checking behaviour down to the filesystem, we can do
> this.

We might not even have to push it out, but just make the VFS/rw helper
check aware of lazytime.  Either way currently even a lazytime
timestampt update will cause a write to block, which renders the
nowait writes pretty useless on anything but block devices.


