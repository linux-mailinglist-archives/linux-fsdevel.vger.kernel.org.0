Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 301DB47017
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2019 14:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfFOM55 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Jun 2019 08:57:57 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37891 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725999AbfFOM55 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Jun 2019 08:57:57 -0400
Received: from callcc.thunk.org (rrcs-74-87-88-165.west.biz.rr.com [74.87.88.165])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5FCvWOZ003473
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Jun 2019 08:57:33 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0D4F8420484; Sat, 15 Jun 2019 08:57:32 -0400 (EDT)
Date:   Sat, 15 Jun 2019 08:57:31 -0400
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
Subject: Re: [PATCH v4 05/16] fs-verity: add Kconfig and the helper functions
 for hashing
Message-ID: <20190615125731.GF6142@mit.edu>
References: <20190606155205.2872-1-ebiggers@kernel.org>
 <20190606155205.2872-6-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606155205.2872-6-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 06, 2019 at 08:51:54AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add the beginnings of the fs/verity/ support layer, including the
> Kconfig option and various helper functions for hashing.  To start, only
> SHA-256 is supported, but other hash algorithms can easily be added.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good; you can add:

Reviewed-off-by: Theodore Ts'o <tytso@mit.edu>

One thought for consideration below...


> +
> +/*
> + * Maximum depth of the Merkle tree.  Up to 64 levels are theoretically possible
> + * with a very small block size, but we'd like to limit stack usage during
> + * verification, and in practice this is plenty.  E.g., with SHA-256 and 4K
> + * blocks, a file with size UINT64_MAX bytes needs just 8 levels.
> + */
> +#define FS_VERITY_MAX_LEVELS		16

Maybe we should make FS_VERITY_MAX_LEVELS 8 for now?  This is an
implementation-level restriction, and currently we don't support any
architectures that have a page size < 4k.  We can always bump this
number up in the future if it ever becomes necessary, and limiting max
levels to 8 saves almost 100 bytes of stack space in verify_page().

						- Ted
