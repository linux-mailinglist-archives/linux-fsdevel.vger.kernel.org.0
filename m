Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 752D54A8C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 19:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbfFRRvV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 13:51:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729285AbfFRRvV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 13:51:21 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E84DC205F4;
        Tue, 18 Jun 2019 17:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560880280;
        bh=+JwMW+EfA+1KPkG7+F9JNJm/PdgIsMm+vsIk5VyMsXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jN+UHuS7ftaLSzRz/uIHx1sk5q1R1x1AoYmkjyFeRGM23VC4+ycH6vhtDO6U3CLbJ
         QF9MEni6U1cDt7guNvx25VfpXPIjhqjCq5psE955shlVQKm+NnVxKNBEUDRsVxFZbD
         NijVFVXBjZzTi6Rjldw9aQ2M2ZOZ8+cRambf8Z+A=
Date:   Tue, 18 Jun 2019 10:51:18 -0700
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
Message-ID: <20190618175117.GF184520@gmail.com>
References: <20190606155205.2872-1-ebiggers@kernel.org>
 <20190606155205.2872-15-ebiggers@kernel.org>
 <20190615153112.GO6142@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615153112.GO6142@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 15, 2019 at 11:31:12AM -0400, Theodore Ts'o wrote:
> On Thu, Jun 06, 2019 at 08:52:03AM -0700, Eric Biggers wrote:
> > +/*
> > + * Format of ext4 verity xattr.  This points to the location of the verity
> > + * descriptor within the file data rather than containing it directly because
> > + * the verity descriptor *must* be encrypted when ext4 encryption is used.  But,
> > + * ext4 encryption does not encrypt xattrs.
> > + */
> > +struct fsverity_descriptor_location {
> > +	__le32 version;
> > +	__le32 size;
> > +	__le64 pos;
> > +};
> 
> What's the benefit of storing the location in an xattr as opposed to
> just keying it off the end of i_size, rounded up to next page size (or
> 64k) as I had suggested earlier?
> 
> Using an xattr burns xattr space, which is a limited resource, and it
> adds some additional code complexity.  Does the benefits outweigh the
> added complexity?
> 
> 						- Ted

It means that only the fs/verity/ support layer has to be aware of the format of
the fsverity_descriptor, and the filesystem can just treat it an as opaque blob.

Otherwise the filesystem would need to read the first 'sizeof(struct
fsverity_descriptor)' bytes and use those to calculate the size as
'sizeof(struct fsverity_descriptor) + le32_to_cpu(desc.sig_size)', then read the
rest.  Is this what you have in mind?

Alternatively the filesystem could prepend the fsverity_descriptor with its
size, similar to how in the v1 and v2 patchsets there was an fsverity_footer
appended to the fsverity_descriptor.  But an xattr seems a cleaner approach to
store a few bytes that don't need to be encrypted.

Putting the verity descriptor before the Merkle tree also means that we'd have
to pass the desc_size to ->begin_enable_verity(), ->read_merkle_tree_page(), and
->write_merkle_tree_block(), versus just passing the merkle_tree_size to
->end_enable_verity().  This would be easy, but it would still add a bit of
complexity in the fsverity_operations rather than reduce it.

It's also somewhat nice to have the version number in the xattr, in case we ever
introduce a new fs-verity format for ext4 or f2fs.

So to me, it doesn't seem like the other possible solutions are better.

- Eric
