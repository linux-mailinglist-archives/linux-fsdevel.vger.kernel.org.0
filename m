Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8164B055
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 05:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbfFSDGA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 23:06:00 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47305 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726037AbfFSDGA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 23:06:00 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5J35NPK021631
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jun 2019 23:05:24 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C0BD1420484; Tue, 18 Jun 2019 23:05:22 -0400 (EDT)
Date:   Tue, 18 Jun 2019 23:05:22 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
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
Message-ID: <20190619030522.GA28351@mit.edu>
References: <20190606155205.2872-1-ebiggers@kernel.org>
 <20190606155205.2872-15-ebiggers@kernel.org>
 <20190615153112.GO6142@mit.edu>
 <20190618175117.GF184520@gmail.com>
 <20190618224615.GB4576@mit.edu>
 <20190618234133.GL184520@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618234133.GL184520@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 18, 2019 at 04:41:34PM -0700, Eric Biggers wrote:
> 
> I don't think your proposed solution is so simple.  By definition the last
> extent ends on a filesystem block boundary, while the Merkle tree ends on a
> Merkle tree block boundary.  In the future we might support the case where these
> differ, so we don't want to preclude that in the on-disk format we choose now.
> Therefore, just storing the desc_size isn't enough; we'd actually have to store
> (desc_pos, desc_size), like I'm doing in the xattr.

I don't think any of this matters much, since what you're describing
above is all about the Merkle tree, and that doesn't affect how we
find the fsverity descriptor information.  We can just say that
fsverity descriptor block begins on the next file system block
boundary after the Merkle tree.  And in the case where say, the Merkle
tree is 4k and the file system block size is 64k, that's fine --- the
fs descriptor would just begin at the next 64k (fs blocksize)
boundary.

> Also, using ext4_find_extent() to find the last mapped block (as the v1 and v2
> patchsets did) assumes the file actually uses extents.  So we'd have to forbid
> non-extents based files as a special case, as the v2 patchset did.  We'd also
> have to find a way to implement the same functionality on f2fs (which should be
> possible, but it seems it would require some new code; there's nothing like
> f2fs_get_extent()) unless we did something different for f2fs.

So first, if f2fs wants to continue using the xattr, that's fine.  The
code to write and fetch the fsverity descriptor is in file system
specific code, and so this is something I'm happy to support just for
ext4, and it shouldn't require any special changes in the common
fsverity code at all.  Secondly, I suspect it's not *that* hard to
find the last logical block mapping in f2fs, but I'll let Jaeguk
comment on that.

Finally, it's not that hard to find the last mapped block for indirect
blocks, if we really care about supporting that combination.  (There
are enough other things --- like fallocate --- which don't work with
indirect mapped files, so I don't feel especially bad forbidding that
combination.  A quick check in enable_verity() to return EOPNOTSUPP if
the EXTENTS_FL flag is not present is not all that different from what
we do with fallocate today.)

But if we *did* want to support it, it's actually quite easy to find
the last mapped block for an indirect mapped inode.  I just didn't
bother to write the code, but it requires at most 3 block reads if
there is a triple indirection block.  Otherwise, if there is a double
indirection block in the inode, it requires at most 2 block reads, and
otherwise, at most a single block read.

> Note that on Android devices (the motivating use case for fs-verity), the xattrs
> of user data files on ext4 already spill into an external xattr block, due to
> the fscrypt and SELinux xattrs.  If/when people actually start caring about
> this, they'll need to increase the inode size to 512 bytes anyway, in which case
> there will be plenty of space for a few more in-line xattrs.  So I don't think
> we should jump through too many hoops to avoid using an xattr.

I'm thinking about other cases where we might not be using fscrypt,
but where we might still be using fsverity and SELinux --- or maybe
cases where the file systems are using 128 byte inodes, and where only
fsverity is required.  (There are a *vast* number of production file
systems using 128 byte inodes.)

Cheers,

						- Ted
