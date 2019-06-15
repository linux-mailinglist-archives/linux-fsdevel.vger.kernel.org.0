Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9057A46FED
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2019 14:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfFOMjv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Jun 2019 08:39:51 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35245 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725943AbfFOMjv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Jun 2019 08:39:51 -0400
Received: from callcc.thunk.org (rrcs-74-87-88-165.west.biz.rr.com [74.87.88.165])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5FCdL7J031269
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Jun 2019 08:39:22 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A4E1B420484; Sat, 15 Jun 2019 08:39:20 -0400 (EDT)
Date:   Sat, 15 Jun 2019 08:39:20 -0400
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
Subject: Re: [PATCH v4 01/16] fs-verity: add a documentation file
Message-ID: <20190615123920.GB6142@mit.edu>
References: <20190606155205.2872-1-ebiggers@kernel.org>
 <20190606155205.2872-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606155205.2872-2-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 06, 2019 at 08:51:50AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add a documentation file for fs-verity, covering....
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good; you can add:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>


One minor design point below:

> +ext4 stores the verity metadata (Merkle tree and fsverity_descriptor)
> +past the end of the file, starting at the first page fully beyond
                                                   ^^^^
> +i_size.  This approach works because (a) verity files are readonly,
> +and (b) pages fully beyond i_size aren't visible to userspace but can
> +be read/written internally by ext4 with only some relatively small
> +changes to ext4.  This approach avoids having to depend on the
> +EA_INODE feature and on rearchitecturing ext4's xattr support to
> +support paging multi-gigabyte xattrs into memory, and to support
> +encrypting xattrs.  Note that the verity metadata *must* be encrypted
> +when the file is, since it contains hashes of the plaintext data.

If we ever want to support mounting, say, a file system with 4k blocks
and fsverity enabled on a architecture with a 16k or 64k page size,
then "page" in that first sentence will need to become "block".  At
the moment we only support fsverity when page size == block size, so
it's not an issue.

However, it's worth reflecting on what this means.  In order to
satisfy this requirement (from the mmap man page):

       A file is mapped in multiples of the page size.  For a file
       that is not a multiple of the page size, the remaining memory
       is zeroed when mapped...

we're going to have to special case how the last page gets mmaped.
The simplest way to do this will be to map in an anonymous page which
just has the blocks that are part of the data block copied in, and the
rest of the page can be zero'ed.

One thing we might consider doing just to make life much easier for
ourselves (should we ever want to support page size != block size ---
which I could imagine some folks like Chandan might find desirable) is
to specify that the fsverity metadata begins at an offset which begins
at i_size rounded up to the next 64k binary, which should handle all
current and future architectures' page sizes.

					- Ted
