Return-Path: <linux-fsdevel+bounces-74582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BA7D3C09C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 08:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 998D6407EF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 07:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACD53A7F4A;
	Tue, 20 Jan 2026 07:32:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9C73A7DFA;
	Tue, 20 Jan 2026 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768894346; cv=none; b=tvUtjqtfggLBpPNvZ6yq8NX1MOut5PXU4yiG5XLpPv5S+13TwIhiZieE+ZlQg8jGdIc6Mi9tIQ4cbLU/OGH0wedPCxWces75MkJ+m1hlArl2aV21Wppo+KxtFrfcXeBiuWgPAggM8WmUQC3WME18iB7MgjPKZXtGoqp0iPBbqI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768894346; c=relaxed/simple;
	bh=UcjeCV1pmWq68UG6mKTvuW3ZSkrfs3Ahq6enbyDbanU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTcqU0oiStujaoRS45dtnZb209OuUr9GNDOzb9YVYFH9+Mv45kK0se8W49cI+BdATsQHIFO2IjlfZCtO/1nKcVuBB02JXckXXg64nBGgHY/j51Mv8sX4kCtn0ZojY3Hdhu3QIawuiV7vEYMMQrscujTBHJ3B3MkvFhhO/6UONdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B21F5227AA8; Tue, 20 Jan 2026 08:32:18 +0100 (CET)
Date: Tue, 20 Jan 2026 08:32:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	aalbersh@kernel.org, david@fromorbit.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org, jaegeuk@kernel.org, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: fsverity metadata offset, was: Re: [PATCH v2 0/23] fs-verity
 support for XFS with post EOF merkle tree
Message-ID: <20260120073218.GA6757@lst.de>
References: <cover.1768229271.patch-series@thinky> <aWZ0nJNVTnyuFTmM@casper.infradead.org> <op5poqkjoachiv2qfwizunoeg7h6w5x2rxdvbs4vhryr3aywbt@cul2yevayijl> <aWci_1Uu5XndYNkG@casper.infradead.org> <20260114061536.GG15551@frogsfrogsfrogs> <5z5r6jizgxqz5axvzwbdmtkadehgdf7semqy2oxsfytmzzu6ik@zfvhexcp3fz2> <6r24wj3o3gctl3vz4n3tdrfjx5ftkybdjmmye2hejdcdl6qseh@c2yvpd5d4ocf> <20260119063349.GA643@lst.de> <20260119193242.GB13800@sol> <20260119195816.GA15583@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119195816.GA15583@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 19, 2026 at 11:58:16AM -0800, Darrick J. Wong wrote:
> > >  a) not all architectures are reasonable.  As Darrick pointed out
> > >     hexagon seems to support page size up to 1MiB.  While I don't know
> > >     if they exist in real life, powerpc supports up to 256kiB pages,
> > >     and I know they are used for real in various embedded settings
> 
> They *did* way back in the day, I worked with some seekrit PPC440s early
> in my career.  I don't know that any of them still exist, but the code
> is still there...

Sorry, I meant I don't really know how real the hexagon large page
sizes are.  I know about the ppcs one personally, too.

> > If we do need to fix this, there are a couple things we could consider
> > doing without changing the on-disk format in ext4 or f2fs: putting the
> > data in the page cache at a different offset than it exists on-disk, or
> > using "small" pages for EOF specifically.
> 
> I'd leave the ondisk offset as-is, but change the pagecache offset to
> roundup(i_size_read(), mapping_max_folio_size_supported()) just to keep
> file data and fsverity metadata completely separate.

Can we find a way to do that in common code and make ext4 and f2fs do
the same?


