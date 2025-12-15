Return-Path: <linux-fsdevel+bounces-71339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EBFCBE333
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 15:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C86C3014722
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 14:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6143314C0;
	Mon, 15 Dec 2025 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I1sDsTSU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D58D32B9A2;
	Mon, 15 Dec 2025 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807812; cv=none; b=Pdy6ZcNxQucCDhUiJ2r6oPze70SXLIHs9lacg3bGuVfb0jo7TGf1vZFLASAvZI6QY0rd0HGQlO+cwhpeV41atAk1zMdvwU+1RsvkyAEbydU2IOOYh/nekNaVM1Cr0vzA/aPLSQDdFPjKv57+n6Q7JUQly6CMldObNDWHrq9ee/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807812; c=relaxed/simple;
	bh=JzUuQZ6PTK7J4bmbQecxHYg1BWa8IyxJIw5BwLjae+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlQvhnDBZLbghVFD5lxC9zYn8Eyr7zF3EwNYDJpzuaq/ZJEZ/A+mtQCUO0Kmq7kfwiat9FTAJPHRdjpHbexF5OK2m1MB9sZFdpRGx9Jhk9KNwbzZNHl8EuuBFVei7Y8MlaaxfNnKNj/hIksWUVBMz8tDlH2tQX4iAPIUJD1z/So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I1sDsTSU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=a2AIMEuMO63fon6DvcO/Y3XcQwHDOR1ZxHudwpfq7s8=; b=I1sDsTSU1KfjM9/bdkkapQkmOr
	GnW3sElZMeHfkA2DsdbS+56hxgM4DKcfeH+K8oKvGK09YGJeqqTDCGLAtQ3uwvgd6/nKeeLsXwFBq
	k6VycbSzkyfGJPHZUAhFIGkXEddbFjUL8ackwcLE5SFh1eDg2IJyUftdRcn8hWqeycc6Z4GHRfSPv
	ku26eth540qcA8sJe+tOukoYFdH91TMLHH+I2Xm5OLkrBHyfAY/NZHou/4xfGq1vYqr/UDTm6Vh44
	j5h+OgxnrStBSKTbRjMK00DU+G8jK3o1W+/wOQgrD6AqTTSdRFQk9A/63Cj+CTmUNLD0YL21C/Dyl
	IJ4Z5yGw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vV9H6-00000001znb-1m3c;
	Mon, 15 Dec 2025 14:10:08 +0000
Date: Mon, 15 Dec 2025 14:10:08 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: jack@suse.cz, Deepakkumar Karn <dkarn@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] fs/buffer: add alert in try_to_free_buffers() for
 folios without buffers
Message-ID: <aUAWwPWDq0GgAjnP@casper.infradead.org>
References: <20251211131211.308021-1-dkarn@redhat.com>
 <20251215-zuckungen-autogramm-a0c4291e525b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215-zuckungen-autogramm-a0c4291e525b@brauner>

On Mon, Dec 15, 2025 at 03:07:35PM +0100, Christian Brauner wrote:
> On Thu, 11 Dec 2025 18:42:11 +0530, Deepakkumar Karn wrote:
> > try_to_free_buffers() can be called on folios with no buffers attached
> > when filemap_release_folio() is invoked on a folio belonging to a mapping
> > with AS_RELEASE_ALWAYS set but no release_folio operation defined.
> > 
> > In such cases, folio_needs_release() returns true because of the
> > AS_RELEASE_ALWAYS flag, but the folio has no private buffer data. This
> > causes try_to_free_buffers() to call drop_buffers() on a folio with no
> > buffers, leading to a null pointer dereference.
> > 
> > [...]
> 
> Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
> Patches in the vfs-7.0.misc branch should appear in linux-next soon.

No, this is the wrong fix.  Please drop.

