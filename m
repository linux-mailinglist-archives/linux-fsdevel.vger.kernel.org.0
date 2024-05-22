Return-Path: <linux-fsdevel+bounces-20018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F5E8CC654
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 20:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8A72819EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 18:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A493145B33;
	Wed, 22 May 2024 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHVTH4FA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93898D51E;
	Wed, 22 May 2024 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716402542; cv=none; b=DcMpjHZQeszURWCnqMbV4dMd1DIQbM2ivmeFQZ+MF9lMIbMQ3zNL/z98wxOs8SpkqtT8iNARnus+XTLCx38AB2+xelSsR6/GylgS1SeQx8uSp/YPG65DZyV2GS+9Rz7IZ4MOG+psgdyE0+JpHkp3PSbuP9vwJjKAxSmSWYnTHio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716402542; c=relaxed/simple;
	bh=QBh+Kz0JP4xQ7T1N7vHv392YPIHKOlcyxs7oMAFk2W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiozQ50Y0Ze/e5OJQU7jbg+5Q8eh8iFivbh0j6Tp94XowQOm6ZhENQTYqAoymG5nM0um/TIjfq1ndaNNkt7gBpc8baIS3UszMQSkXdf1GV1sh+PWOClkkMNxvZpt1WXcPlxlwuG2lgFYjlmQFGm/8floi6FLeEEhQS2QsZG3Ld0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHVTH4FA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9ADC2BBFC;
	Wed, 22 May 2024 18:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716402542;
	bh=QBh+Kz0JP4xQ7T1N7vHv392YPIHKOlcyxs7oMAFk2W8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dHVTH4FA89qy6c6HJ0vV3TddtRd86Ev3fQYWaFgB9YvcOU4CZvUk24rop1UU3KouI
	 yR6R6QOFfzz5p8YORvkpEBBAFiXnuPKiTls3MLZnbMKDNgsHsnUSHdbOCc9DRsC0al
	 T6BgXWrxqAhKuIHfTcnIo/gmrakgfgm09AvfS13Z1cNCQ0Trk/oQBj8hJiQEzC2V1S
	 Jbej9YV5lSVcpdaXMp4GGeMmWabCfWBES5rx5Mcb7bxxujG3XuE1mzJTx36mztiVAq
	 qIdZNoksOWGRS92i9g0KUNOqKnPLN8SHj5jlDEZObW2c9aLFoFrnBqbKZfH96goIkO
	 uVn4TebZ49y6A==
Date: Wed, 22 May 2024 11:29:00 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, aalbersh@redhat.com,
	linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/26] xfs: use merkle tree offset as attr hash
Message-ID: <20240522182900.GB1789@sol.localdomain>
References: <ZjtmVIST_ujh_ld6@infradead.org>
 <20240508202603.GC360919@frogsfrogsfrogs>
 <ZjxY_LbTOhv1i24m@infradead.org>
 <20240509200250.GQ360919@frogsfrogsfrogs>
 <Zj2r0Ewrn-MqNKwc@infradead.org>
 <Zj28oXB6leJGem-9@infradead.org>
 <20240517171720.GA360919@frogsfrogsfrogs>
 <ZktEn5KOZTiy42c8@infradead.org>
 <20240520160259.GA25546@frogsfrogsfrogs>
 <Zk4DIzXJX_gVoj2-@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk4DIzXJX_gVoj2-@infradead.org>

On Wed, May 22, 2024 at 07:37:23AM -0700, Christoph Hellwig wrote:
> On Mon, May 20, 2024 at 09:02:59AM -0700, Darrick J. Wong wrote:
> > On Mon, May 20, 2024 at 05:39:59AM -0700, Christoph Hellwig wrote:
> > > On Fri, May 17, 2024 at 10:17:20AM -0700, Darrick J. Wong wrote:
> > > > >   Note that the verity metadata *must* be encrypted when the file is,
> > > > >   since it contains hashes of the plaintext data.
> > > > 
> > > > Refresh my memory of fscrypt -- does it encrypt directory names, xattr
> > > > names, and xattr values too?  Or does it only do that to file data?
> > > 
> > > It does encrypt the file names in the directories, but nothing in
> > > xattrs as far as I can tell.
> > 
> > Do we want that for user.* attrs?  That seems like quite an omission.
> 
> I'll let Eric answer that.  Btw, is the threat model for fscrypt written
> down somewhere?

See https://www.kernel.org/doc/html/latest/filesystems/fscrypt.html?highlight=fscrypt#threat-model

As for why it stopped at file contents and names (and fsverity Merkle tree
blocks which ext4 and f2fs encrypt in the same way as contents), it's just
because it's very difficult to add more, and file contents and names alone were
enough for parity with most other file-level encryption systems.  That's just
the nature of file-level encryption.  For each additional type of data or
metadata that's encrypted, there are a huge number of things that need to be
resolved including algorithm selection, key derivation, IV selection, on-disk
format, padding, UAPI for enabling the feature, userspace tool support including
fsck and debugging tools, access semantics without the key, etc...

xattr encryption is definitely something that people have thought about, and it
probably would be the next thing to consider after the existing contents and
names.  Encrypting the exact file sizes is also something to consider.  But it's
not something that someone has volunteered to do all the work for (yet).  If you
restricted it to the contents of user xattrs only (not other xattrs, and not
xattr names), it would be more feasible than trying to encrypt the names and
values of all xattrs, though it would still be difficult.

Of course, generally speaking, when adding fscrypt support to a filesystem, it's
going to be much easier to just target the existing feature set, and not try to
include new, unproven features too.  (FWIW, this also applies to fsverity.)  If
someone is interested in taking on an experimental project add xattr encryption
support, I'd be glad to try to provide guidance, but it probably should be
separated out from adding fscrypt support in the first place.

> > > > And if we copy the ext4 method of putting the merkle data after eof and
> > > > loading it into the pagecache, how much of the generic fs/verity cleanup
> > > > patches do we really need?
> > > 
> > > We shouldn't need anything.  A bunch of cleanup
> > 
> > Should we do the read/drop_merkle_tree_block cleanup anyway?
> 
> To me the block based interface seems a lot cleaner, but Eric has some
> reservations due to the added indirect call on the drop side.

The point of the block based interface is really so that filesystems could
actually do the block-based caching.  If XFS isn't going to end up using that
after all, I think we should just stay with ->read_merkle_tree_page for now.

> > One of the advantages of xfs caching merkle tree blocks ourselves
> > is that we neither extend the usage of PageChecked when merkle blocksize
> > == pagesize nor become subject to the 1-million merkle block limit when
> > merkle blocksize < pagesize.  There's a tripping hazard if you mount a 4k
> > merkle block filesystem on a computer with 64k pages -- now you can't
> > open 6T verity files.
> > 
> > That said, it also sounds dumb to maintain a separate index for
> > pagecache pages to track a single bit.
> 
> Yeah.  As I mentioned earlier I think fsverify really should enforce
> a size limit.  Right now it will simply run out space eventually which
> doesn't seem like a nice failure mode.

You could enforce the limit of 1 << 23 Merkle tree blocks regardless of whether
the block size and page size are equal, if you want.  This probably would need
to be specific to XFS, though, as it would be a breaking change for other
filesystems.

As for ext4 and f2fs failing with EFBIG in the middle of building the Merkle
tree due to it exceeding s_maxbytes, yes that could be detected at the beginning
of building the tree to get the error right away.  This just isn't done
currently because the current way is simpler, and this case isn't really
encountered in practice so there isn't too much reason to optimize it.

- Eric

