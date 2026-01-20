Return-Path: <linux-fsdevel+bounces-74583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C68D3C0AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 08:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B8CD83E5455
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 07:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11D83A89A3;
	Tue, 20 Jan 2026 07:35:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C075F39E6E3;
	Tue, 20 Jan 2026 07:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768894544; cv=none; b=RnfIiXqvfAba8z80bqV9yA3kYX72oFnTawX8NiHN52df0Km6g1Un3MZyQMgRYmsXNL+YOxrHGXw2Nt0ohJV0GT79RoVxgsIUVPLgUpqsmf5aOtGXF8mlMmi0aNxPF7hSxJDX1oqg/5mlQDVTgMG0HrzpSghrcewko5hkyhVhnIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768894544; c=relaxed/simple;
	bh=zAXXA3jH/JJwkXmAwripNCXOvHEUcHXSeGFfIPu+2a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZ6VV5HMgWci+bAgjdtUiUDO4t4n6cb5p2XGJ8u5xCNFaWRI4UvogkODjMImZcpMHeVJ7U7QazAy8eBGkrGuh/VfEJexW12A0O8WRBv7qATSmkEdZ4Df2j4uyBEc6NxTDEhT1G9bs5K0Wek7uARUxGfurcIQIE8NwTnLkL0O9MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 64B75227AA8; Tue, 20 Jan 2026 08:35:38 +0100 (CET)
Date: Tue, 20 Jan 2026 08:35:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev, willy@infradead.org
Subject: Re: [PATCH 4/6] fsverity: use a hashtable to find the fsverity_info
Message-ID: <20260120073538.GA6956@lst.de>
References: <20260119062250.3998674-1-hch@lst.de> <20260119062250.3998674-5-hch@lst.de> <20260119190536.GA13800@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119190536.GA13800@sol>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 19, 2026 at 11:05:36AM -0800, Eric Biggers wrote:
> On Mon, Jan 19, 2026 at 07:22:45AM +0100, Christoph Hellwig wrote:
> > Use the kernel's resizable hash table to find the fsverity_info.  This
> > way file systems that want to support fsverity don't have to bloat
> > every inode in the system with an extra pointer.  The tradeoff is that
> > looking up the fsverity_info is a bit more expensive now, but the main
> > operations are still dominated by I/O and hashing overhead.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Has anything changed from my last feedback at
> https://lore.kernel.org/linux-fsdevel/20250810170311.GA16624@sol/ ?
> 
> Any additional data on the cycles and icache footprint added to data
> verification?  The preliminary results didn't look all that good to me.

Nothing has changed, as as expected by then and now the lookup overhead
is completely dwarfed by other parts of the read, even when the
data and hashes are already cached.  Of course if you look into the lookup
in itself, any kind of data structure will be significantly more expensive
than a pointer dereference and nothing will change that.

> It also seems odd to put this in an "fsverity optimzations and speedups"
> patchset, given that it's the opposite.

It optimizes the memory usage and doesn't require bloating the inode
for new file systems adding fsverity support.  size of the inode is
a major concern, and is even more so for a feature that is not
commonly used and then not for most files.


