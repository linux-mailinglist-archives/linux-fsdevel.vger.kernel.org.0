Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5429B470A3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2019 17:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfFOPIq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Jun 2019 11:08:46 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57351 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725944AbfFOPIp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Jun 2019 11:08:45 -0400
Received: from callcc.thunk.org (rrcs-74-87-88-165.west.biz.rr.com [74.87.88.165])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5FF8Lhv005865
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Jun 2019 11:08:22 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2BC23420484; Sat, 15 Jun 2019 11:08:21 -0400 (EDT)
Date:   Sat, 15 Jun 2019 11:08:21 -0400
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
Subject: Re: [PATCH v4 10/16] fs-verity: implement FS_IOC_ENABLE_VERITY ioctl
Message-ID: <20190615150821.GK6142@mit.edu>
References: <20190606155205.2872-1-ebiggers@kernel.org>
 <20190606155205.2872-11-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606155205.2872-11-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 06, 2019 at 08:51:59AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add a function for filesystems to call to implement the
> FS_IOC_ENABLE_VERITY ioctl.  This ioctl enables fs-verity on a file.
> 
> See the "FS_IOC_ENABLE_VERITY" section of
> Documentation/filesystems/fsverity.rst for the documentation.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

> diff --git a/fs/verity/enable.c b/fs/verity/enable.c
> new file mode 100644
> index 000000000000..7e7ef9d3c376
> --- /dev/null
> +++ b/fs/verity/enable.c
> +	/* Tell the filesystem to finish enabling verity on the file */
> +	err = vops->end_enable_verity(filp, desc, desc_size, params.tree_size);
> +	if (err) {
> +		fsverity_err(inode, "%ps() failed with err %d",
> +			     vops->end_enable_verity, err);
> +		fsverity_free_info(vi);
> +	} else {
> +		/* Successfully enabled verity */
> +
> +		WARN_ON(!IS_VERITY(inode));
> +
> +		/*
> +		 * Readers can start using ->i_verity_info immediately, so it
> +		 * can't be rolled back once set.  So don't set it until just
> +		 * after the filesystem has successfully enabled verity.
> +		 */
> +		fsverity_set_info(inode, vi);
> +	}

If end_enable_Verity() retuns success, and IS_VERITY is not set, I
would think that we should report the error via fsverity_err() and
return an error to userspace, and *not* call fsverity_set_info().  I
don't think the stack trace printed by WARN_ON is going to very
interesting, since the call path which gets us to enable_verity() is
not going to be surprising.

> +
> +	if (inode->i_size <= 0) {
> +		err = -EINVAL;
> +		goto out_unlock;
> +	}

How hard would it be to support fsverity for zero-length files?  There
would be no Merkle tree, but there still would be an fsverity header
file on which we can calculate a checksum for the digital signature.

     	      	     	       	 - Ted

