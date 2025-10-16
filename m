Return-Path: <linux-fsdevel+bounces-64339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62714BE170C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 06:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE53F4E4664
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 04:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EE3214A79;
	Thu, 16 Oct 2025 04:38:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68908DDD2;
	Thu, 16 Oct 2025 04:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760589488; cv=none; b=DI11Msgsil7JrpzHSGYC5oF8Sk9Nd2e1eaOwvqdWeiVaLl+FryHekJicju74q/8015+92SofUbMHYzhLmNDFyfORL2f58oUjfj+xVf4ePZgYkDyc0YSWGo3cbVF+U33kVND0bICmn+uyPu1FwIJPIH5qPLs3T5BsWo0S9CW9AV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760589488; c=relaxed/simple;
	bh=Bdx3Lt0PwgAVOVp8DRZIqz4v7/eLzRQTDEw5EM2U8wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEoeLXK+/R71HX9D8BOOM9rGjuPSkaUH/rMl3lvJ2TgVbsX+uOnYZlHxFfrFN/JZU8L3a8E8Elm2OGr7SPRfxCcvgT/zVRjL6fvabW+IEz746yYEVKua6EhXMRZWTBpf9QMvGqWjVcSL7UDTu/DhAukkFkLCsBJHHT2lY4OitDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5C7DB227A87; Thu, 16 Oct 2025 06:37:58 +0200 (CEST)
Date: Thu, 16 Oct 2025 06:37:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
	dlemoal@kernel.org, hans.holmberg@wdc.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/3] writeback: allow the file system to override
 MIN_WRITEBACK_PAGES
Message-ID: <20251016043758.GB29905@lst.de>
References: <20251015062728.60104-1-hch@lst.de> <20251015062728.60104-3-hch@lst.de> <20251015155735.GC6178@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015155735.GC6178@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 15, 2025 at 08:57:35AM -0700, Darrick J. Wong wrote:
> Should this be some sort of BDI field?  Maybe there are other workloads
> that create a lot of dirty pages and the sysadmin would like to be able
> to tell the fs to schedule larger chunks of writeback before switching
> to another inode?

The BDI is not owned by the file system, but rather the gendisk, so we
can't just override it in the file systems.  I still hope that eventually
changes, in which case we could revisit it.  Having a tunable sounds neat,
but I'd rather get the fix out first and then design something like that.

> 
> XFS can have two volumes, should we be using the rtdev's bdi for
> realtime files and the data dev's bdi for non-rt files?  That looks like
> a mess to sort out though, since there's a fair number of places where
> we just dereference super_block::s_bdi.

Each file system only uses a single BDI, which in case of XFS is the
one of the gendisk that the main device sits on.  Only the bdevfs uses
multiple BDIs (one per file{) and that required hard coded hacks in the
writeback code.  I don't think there is any benefit in having multiple
BIDs for real file system, the parallelization work that just got reposted
works inside a BDI.

> Also I have no idea what we'd do for filesystem raid -- synthesize a bdi
> for that?  And then how would you advertise that such-and-such fd maps
> to a particular bdi?

btrfs allocates it's own BDI.  And I hope that we eventually move to a
model where the file system always own the BDI as that would simplify
object lifetimes an relationships and locking a lot.


