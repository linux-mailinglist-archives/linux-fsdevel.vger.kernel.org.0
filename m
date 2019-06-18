Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2BA4A6E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 18:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfFRQbV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 12:31:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729319AbfFRQbV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:31:21 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3AE32054F;
        Tue, 18 Jun 2019 16:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560875480;
        bh=8s8EM+uYReYgUA7GU9MPlmqiEwIExiskI/J8sVZVt2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wgRJzptgTLpjPDiEHTaZP7Qip+BiPwTjsvkocLXBfaZEI/gTRT5gSpoRGEMSpNuHe
         U5HifCFDwTn9R81SiN+y7/MXL3wJ9s2x4LNgLhYTvryiwZpwtId2IibVduHFLs4qAP
         P2C8p4W6B8LMCJMcvopWfhP9eOwKX0fxQoCm8fnE=
Date:   Tue, 18 Jun 2019 09:31:18 -0700
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
Subject: Re: [PATCH v4 01/16] fs-verity: add a documentation file
Message-ID: <20190618163116.GA184520@gmail.com>
References: <20190606155205.2872-1-ebiggers@kernel.org>
 <20190606155205.2872-2-ebiggers@kernel.org>
 <20190615123920.GB6142@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615123920.GB6142@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ted,

On Sat, Jun 15, 2019 at 08:39:20AM -0400, Theodore Ts'o wrote:
> On Thu, Jun 06, 2019 at 08:51:50AM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Add a documentation file for fs-verity, covering....
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Looks good; you can add:
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>
> 
> 
> One minor design point below:
> 
> > +ext4 stores the verity metadata (Merkle tree and fsverity_descriptor)
> > +past the end of the file, starting at the first page fully beyond
>                                                    ^^^^
> > +i_size.  This approach works because (a) verity files are readonly,
> > +and (b) pages fully beyond i_size aren't visible to userspace but can
> > +be read/written internally by ext4 with only some relatively small
> > +changes to ext4.  This approach avoids having to depend on the
> > +EA_INODE feature and on rearchitecturing ext4's xattr support to
> > +support paging multi-gigabyte xattrs into memory, and to support
> > +encrypting xattrs.  Note that the verity metadata *must* be encrypted
> > +when the file is, since it contains hashes of the plaintext data.
> 
> If we ever want to support mounting, say, a file system with 4k blocks
> and fsverity enabled on a architecture with a 16k or 64k page size,
> then "page" in that first sentence will need to become "block".  At
> the moment we only support fsverity when page size == block size, so
> it's not an issue.
> 
> However, it's worth reflecting on what this means.  In order to
> satisfy this requirement (from the mmap man page):
> 
>        A file is mapped in multiples of the page size.  For a file
>        that is not a multiple of the page size, the remaining memory
>        is zeroed when mapped...
> 
> we're going to have to special case how the last page gets mmaped.
> The simplest way to do this will be to map in an anonymous page which
> just has the blocks that are part of the data block copied in, and the
> rest of the page can be zero'ed.
> 
> One thing we might consider doing just to make life much easier for
> ourselves (should we ever want to support page size != block size ---
> which I could imagine some folks like Chandan might find desirable) is
> to specify that the fsverity metadata begins at an offset which begins
> at i_size rounded up to the next 64k binary, which should handle all
> current and future architectures' page sizes.
> 

Thanks for the review.  Good point; I think we should just go with the "always
round up to the next 64K boundary" method.  Special-casing how the last page
gets mmap()ed seems it would be really painful.

Since there can be a hole between the end of the file and the start of the
verity metadata, this doesn't even necessarily use any additional disk space.

For consistency and since there is little downside I think I'll do the same for
f2fs too, though f2fs doesn't currently support PAGE_SIZE != 4096 at all anyway.

- Eric
