Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF7E6162D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jul 2019 20:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfGGSvw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Jul 2019 14:51:52 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46647 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726044AbfGGSvw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Jul 2019 14:51:52 -0400
Received: from callcc.thunk.org (75-104-86-74.mobility.exede.net [75.104.86.74] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x67IpJhW015414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 7 Jul 2019 14:51:25 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CD13542002E; Sun,  7 Jul 2019 14:51:17 -0400 (EDT)
Date:   Sun, 7 Jul 2019 14:51:17 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v6 14/17] ext4: add basic fs-verity support
Message-ID: <20190707185117.GC19775@mit.edu>
References: <20190701153237.1777-1-ebiggers@kernel.org>
 <20190701153237.1777-15-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701153237.1777-15-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 01, 2019 at 08:32:34AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add most of fs-verity support to ext4.  fs-verity is a filesystem
> feature that enables transparent integrity protection and authentication
> of read-only files.  It uses a dm-verity like mechanism at the file
> level: a Merkle tree is used to verify any block in the file in
> log(filesize) time.  It is implemented mainly by helper functions in
> fs/verity/.  See Documentation/filesystems/fsverity.rst for the full
> documentation.
> 
> This commit adds all of ext4 fs-verity support except for the actual
> data verification, including:
> 
> - Adding a filesystem feature flag and an inode flag for fs-verity.
> 
> - Implementing the fsverity_operations to support enabling verity on an
>   inode and reading/writing the verity metadata.
> 
> - Updating ->write_begin(), ->write_end(), and ->writepages() to support
>   writing verity metadata pages.
> 
> - Calling the fs-verity hooks for ->open(), ->setattr(), and ->ioctl().
> 
> ext4 stores the verity metadata (Merkle tree and fsverity_descriptor)
> past the end of the file, starting at the first 64K boundary beyond
> i_size.  This approach works because (a) verity files are readonly, and
> (b) pages fully beyond i_size aren't visible to userspace but can be
> read/written internally by ext4 with only some relatively small changes
> to ext4.  This approach avoids having to depend on the EA_INODE feature
> and on rearchitecturing ext4's xattr support to support paging
> multi-gigabyte xattrs into memory, and to support encrypting xattrs.
> Note that the verity metadata *must* be encrypted when the file is,
> since it contains hashes of the plaintext data.
> 
> This patch incorporates work by Theodore Ts'o and Chandan Rajendra.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good.  You can add:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

Thanks,

					- Ted
