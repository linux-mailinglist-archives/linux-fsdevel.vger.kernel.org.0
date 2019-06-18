Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6F0D4AED0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 01:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfFRXlj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 19:41:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfFRXli (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 19:41:38 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73DD02080C;
        Tue, 18 Jun 2019 23:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560901296;
        bh=JUDJyewBHmFtJkoI2vLr2zAbbPh3Fi6hkTWf+B7Ew6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZbYloxi7MOCwuUvW/nmSNQZQ4Yhb20pBMzG/c2xaN6MJitN9K2us5Gw4T3cJw3X1U
         xKnS6g1e8Cs7JWs0JdapN0ScnIMO+xV2wC5UiIyCkPxIGeuGoU3/c0RZDuRi6CptYJ
         x5eKyG+F+TZX/hs0+P92wWoWZFqhpXb876Nl1Y94=
Date:   Tue, 18 Jun 2019 16:41:34 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 14/16] ext4: add basic fs-verity support
Message-ID: <20190618234133.GL184520@gmail.com>
References: <20190606155205.2872-1-ebiggers@kernel.org>
 <20190606155205.2872-15-ebiggers@kernel.org>
 <20190615153112.GO6142@mit.edu>
 <20190618175117.GF184520@gmail.com>
 <20190618224615.GB4576@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618224615.GB4576@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 18, 2019 at 06:46:15PM -0400, Theodore Ts'o wrote:
> On Tue, Jun 18, 2019 at 10:51:18AM -0700, Eric Biggers wrote:
> > On Sat, Jun 15, 2019 at 11:31:12AM -0400, Theodore Ts'o wrote:
> > > On Thu, Jun 06, 2019 at 08:52:03AM -0700, Eric Biggers wrote:
> > > > +/*
> > > > + * Format of ext4 verity xattr.  This points to the location of the verity
> > > > + * descriptor within the file data rather than containing it directly because
> > > > + * the verity descriptor *must* be encrypted when ext4 encryption is used.  But,
> > > > + * ext4 encryption does not encrypt xattrs.
> > > > + */
> > > > +struct fsverity_descriptor_location {
> > > > +	__le32 version;
> > > > +	__le32 size;
> > > > +	__le64 pos;
> > > > +};
> > > 
> > > What's the benefit of storing the location in an xattr as opposed to
> > > just keying it off the end of i_size, rounded up to next page size (or
> > > 64k) as I had suggested earlier?
> > > 
> > > Using an xattr burns xattr space, which is a limited resource, and it
> > > adds some additional code complexity.  Does the benefits outweigh the
> > > added complexity?
> > > 
> > > 						- Ted
> > 
> > It means that only the fs/verity/ support layer has to be aware of the format of
> > the fsverity_descriptor, and the filesystem can just treat it an as opaque blob.
> > 
> > Otherwise the filesystem would need to read the first 'sizeof(struct
> > fsverity_descriptor)' bytes and use those to calculate the size as
> > 'sizeof(struct fsverity_descriptor) + le32_to_cpu(desc.sig_size)', then read the
> > rest.  Is this what you have in mind?
> 
> So right now, the way enable_verity() works is that it appends the
> Merkle tree to the data file, rounding up to the next page (but we
> might change so we round up to the next 64k boundary).  Then it calls
> end_enable_verity(), which is a file system specific function, passing
> in the descriptor and the descriptor size.
> 
> Today ext4 and f2fs appends the descriptor after the Merkle, and then
> sets the xattr containing the fsverity_descriptor_location.  Correct?

That's all correct, except that enable_verity() itself doesn't know or care that
the Merkle tree is being appended to the file.  That's up to the
->write_merkle_tree_block() and ->read_merkle_tree_page() methods which are
filesystem-specific.

> 
> What I'm suggesting that ext4 do instead is that it appends the
> descriptor to the Merkle tree, and then assuming that there is the
> (descriptor size % block_size) is less than PAGE_SIZE-4, we can write
> the descriptor size into the last 4 bytes of the last block in the
> file.  If there is not enough space at the end of the descriptor, then
> we append a block to the file, and then write the descriptor_size into
> last 4 bytes of that block.
> 
> When ext4 needs to find the descriptor, it simply reads the last block
> from the file, reads it into the page cache, reads the last 4 bytes
> from that block to fetch the descriptor size, and it can use the
> logical offset of the last block and the descriptor size to calculate
> the beginning offset of the descriptor size.
> 
> We can then fake up the fsverity_descriptor_location structure, and
> pass that into fsverity.
> 
> It does add a bit of extra complexity, but 99.9% of the time, it
> requires no extra space.  The last 0.098% of the time, the file size
> will grow by 4k, but if we can avoid spilling over to an external
> xattr block, it will all be worth it.
> 
> And in the V1 version of the fsverity code, I had already written the
> code to descend the extent tree to find the last logical block in the
> extent tree.
> 

I don't think your proposed solution is so simple.  By definition the last
extent ends on a filesystem block boundary, while the Merkle tree ends on a
Merkle tree block boundary.  In the future we might support the case where these
differ, so we don't want to preclude that in the on-disk format we choose now.
Therefore, just storing the desc_size isn't enough; we'd actually have to store
(desc_pos, desc_size), like I'm doing in the xattr.

Also, using ext4_find_extent() to find the last mapped block (as the v1 and v2
patchsets did) assumes the file actually uses extents.  So we'd have to forbid
non-extents based files as a special case, as the v2 patchset did.  We'd also
have to find a way to implement the same functionality on f2fs (which should be
possible, but it seems it would require some new code; there's nothing like
f2fs_get_extent()) unless we did something different for f2fs.

Note that on Android devices (the motivating use case for fs-verity), the xattrs
of user data files on ext4 already spill into an external xattr block, due to
the fscrypt and SELinux xattrs.  If/when people actually start caring about
this, they'll need to increase the inode size to 512 bytes anyway, in which case
there will be plenty of space for a few more in-line xattrs.  So I don't think
we should jump through too many hoops to avoid using an xattr.

> > It's also somewhat nice to have the version number in the xattr, in case we ever
> > introduce a new fs-verity format for ext4 or f2fs.
> 
> We already have a version number in the fsverity descriptor.  Surely
> that is what we would bump if we need to itnroduce a new fs-verity
> format?
> 

I'm talking about if we ever wanted to make a filesystem-specific change to
where the verity metadata is stored.  That's what the version number in the
filesystem-specific xattr is for.  The version number in the fsverity_descriptor
is different: that's for if we made a change to fs-verity for *all* filesystems.
We hopefully won't ever need the filesystem-specific version number, but as long
as we have to store the (desc_pos, desc_size) anyway, I think it's wise to add a
version number just in case; it doesn't really cost anything.

- Eric
