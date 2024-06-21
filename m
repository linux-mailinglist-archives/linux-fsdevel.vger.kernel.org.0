Return-Path: <linux-fsdevel+bounces-22139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD788912C6F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 19:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7389E1F24A63
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 17:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D1E1684BC;
	Fri, 21 Jun 2024 17:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYSThMFJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6DC15D1;
	Fri, 21 Jun 2024 17:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718990841; cv=none; b=XHGyI4a/NMntipJdBlMaR7gJ2PNyIz01SqA1Yba/LrYQtWbLgLIfdVx4P5unQzJqP2W8MI37AhbZFhBR6/S3g9Yo2K7g+4jOGnuEKn8bC/+vDK6X2QbEfxRlLTy0FDyUX44CaZ27vb9D21KHFswLbmEC+zV3m4tcf/1G99u8zew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718990841; c=relaxed/simple;
	bh=triNaJ4tVG0Fzjp2eD2BMj9aq4hcFHgsAZSxR8X33Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTUE39B/R1q/H3BjezCm6D935YwLtK1IOJNFXbxycIj/G07c6GuStclmRptfujDBLjSfsEp3nWCxt/yPZHhpLDt/0TIxPa7mbY2czGK8Lwdc5naOuaRIofBP2Jd5cMLW2o23vSPk9sn7fVFK7JrhNxUJgre/hoaqekg0brbhfKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYSThMFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474C3C4AF07;
	Fri, 21 Jun 2024 17:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718990841;
	bh=triNaJ4tVG0Fzjp2eD2BMj9aq4hcFHgsAZSxR8X33Z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VYSThMFJ7CUI/Xj3h1VsQlxZry41CbfCn00lJKcAZ9PrH1HFdjcs45rps2Q3UfiGn
	 fyh+4PuLXwOnm2SaKwx7vrPRBUu8cRwPDysx87ibZ/3NOFT8NBLa1pL4hd0nwsKTb6
	 qU58xZCgrBS0sh98neG5kOQbc61yPk17GwPXUDc8PV2CzDdS3142ZrR2J1ICXgi38n
	 PQwLWMmdHf2WN5jv/Npf43tXw8B2E94bqKkproLLLrkTIHWeGAF/NuO6TWq7DyWPxg
	 XlRCryjMCXfLf+PTk0+TPj92i22yr8lMH+CqyMOAtvKXB6L6kvEFpCobz0wVJa6SlL
	 S0Ag9KfW49M8g==
Date: Fri, 21 Jun 2024 10:27:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	xfs <linux-xfs@vger.kernel.org>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	fsverity@lists.linux.dev, Eric Sandeen <sandeen@redhat.com>,
	Shirley Ma <shirley.ma@oracle.com>
Subject: Re: Handing xfs fsverity development back to you
Message-ID: <20240621172720.GD3058325@frogsfrogsfrogs>
References: <20240612190644.GA3271526@frogsfrogsfrogs>
 <vg3n7rusjj2cnkdfm45bnsgf4jacts5elc2umbyxcfhcatmtvc@z7u64a5n4wc6>
 <20240621043511.GB4362@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621043511.GB4362@sol.localdomain>

On Thu, Jun 20, 2024 at 09:35:11PM -0700, Eric Biggers wrote:
> On Mon, Jun 17, 2024 at 11:34:13AM +0200, Andrey Albershteyn wrote:
> > On 2024-06-12 12:06:44, Darrick J. Wong wrote:
> > > Hi Andrey,
> > > 
> > > Yesterday during office hours I mentioned that I was going to hand the
> > > xfs fsverity patchset back to you once I managed to get a clean fstests
> > > run on my 6.10 tree.  I've finally gotten there, so I'm ready to
> > > transfer control of this series back to you:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fsverity_2024-06-12
> > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=fsverity_2024-06-12
> > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=fsverity_2024-06-12
> > > 
> > > At this point, we have a mostly working implementation of fsverity
> > > that's still based on your original design of stuffing merkle data into
> > > special ATTR_VERITY extended attributes, and a lightweight buffer cache
> > > for merkle data that can track verified status.  No contiguously
> > > allocated bitmap required, etc.  At this point I've done all the design
> > > and coding work that I care to do, EXCEPT:
> > > 
> > > Unfortunately, the v5.6 review produced a major design question that has
> > > not been resolved, and that is the question of where to store the ondisk
> > > merkle data.  Someone (was it hch?) pointed out that if xfs were to
> > > store that fsverity data in some post-eof range of the file (ala
> > > ext4/f2fs) then the xfs fsverity port wouldn't need the large number of
> > > updates to fs/verity; and that a future xfs port to fscrypt could take
> > > advantage of the encryption without needing to figure out how to encrypt
> > > the verity xattrs.
> > > 
> > > On the other side of the fence, I'm guessing you and Dave are much more
> > > in favor of the xattr method since that was (and still is) the original
> > > design of the ondisk metadata.  I could be misremembering this, but I
> > > think willy isn't a fan of the post-eof pagecache use either.
> > > 
> > > I don't have the expertise to make this decision because I don't know
> > > enough (or anything) about cryptography to know just how difficult it
> > > actually would be to get fscrypt to encrypt merkle tree data that's not
> > > simply located in the posteof range of a file.  I'm aware that btrfs
> > > uses the pagecache for caching merkle data but stores that data
> > > elsewhere, and that they are contemplating an fscrypt implementation,
> > > which is why Sweet Tea is on the cc list.  Any thoughts?
> > > 
> > > (This is totally separate from fscrypt'ing regular xattrs.)
> > > 
> > > If it's easy to adapt fscrypt to encrypt fsverity data stored in xattrs
> > > then I think we can keep the current design of the patchset and try to
> > > merge it for 6.11.  If not, then I think the rest of you need to think
> > > hard about the tradeoffs and make a decision.  Either way, the depth of
> > > my knowledge about this decision is limited to thinking that I have a
> > > good enough idea about whom to cc.
> 
> Assuming that you'd like to make the Merkle tree be totally separate from the
> file contents stream (which would preclude encrypting it as part of that stream
> even if it was stored separately), I think the logical way to encrypt it would
> be to derive a Merkle tree encryption key for each file and encrypt the Merkle
> tree using that key, using the same algorithm as file contents.  These days
> fscrypt uses HKDF, so it's relatively straightforward to derive new keys.
> 
> > > 
> > > Other notes about the branches I linked to:
> > > 
> > > I think it's safe to skip all the patches that mention disabling
> > > fsverity because that's likely DOA anyway.
> > > 
> > > Christoph also has a patch to convert the other fsverity implementations
> > > (btrfs/ext4/f2fs) to use the read/drop_merkle_tree_block interfaces:
> > > https://lore.kernel.org/linux-xfs/ZjMZnxgFZ_X6c9aB@infradead.org/
> > > 
> > > I'm not sure if it actually handles PageChecked for the case that the
> > > merkle tree block size != base page size.
> > > 
> 
> Note that I worked on this more at
> https://lore.kernel.org/fsverity/20240515015320.323443-1-ebiggers@kernel.org/
> 
> As I said: my reworked patch seems good to me, but it only makes sense to apply
> it if XFS is going to use it.
> 
> Though, now I'm wondering if ->read_merkle_tree_block should hand back a (page,
> offset) pair instead of a virtual address, and let fs/verity/ handle the
> kmap_local_page() and kunmap_local().  Currently verify_data_block() does want
> the kmap of each block to live as long as the reference to the block itself, for
> up to FS_VERITY_MAX_LEVELS blocks at a time.  The virtual address based
> interface works well for that.  But I realized recently that there's a slightly
> more efficient way to implement verify_data_block() that would also have the
> side effect of there being only one kmap needed at a time.

(I'm only responding to the part for which I think I can answer
reasonably.)

That sounds like a good approach for ext4 which will likely be feeding
you folios from the pagecache anyway.  If Andrey sticks with the buffer
cache that I wrote, then the virtual address is a slab allocation which
is already mapped.

I guess you could return (folio, offset_in_folio, vaddr) and have
fs/verity do kmap_local if !vaddr.

--D

> 
> - Eric
> 

