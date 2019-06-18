Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9674A6FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 18:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfFRQc7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 12:32:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729319AbfFRQc7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:32:59 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C47A220673;
        Tue, 18 Jun 2019 16:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560875578;
        bh=c+umwQIh0bq3RoOE7M7YQapUsBWn1clXKm5dtzKnwjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZnooGdOeFDR5eiKPevy+1NBVA7DV3HmHSIp0MGKqX+kds9e9W/++UaNr1Z6zF7DAQ
         vbB+JX+pEG5QdiD0IKvFvzq/9TGBH2j/cMzjQoiMJNZmSJP5weUk/Sxg+fy/ejIStN
         z3QukToLd3+GkKLZHn8B/laefXDpx2QhOp83dh6w=
Date:   Tue, 18 Jun 2019 09:32:56 -0700
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
Subject: Re: [PATCH v4 05/16] fs-verity: add Kconfig and the helper functions
 for hashing
Message-ID: <20190618163255.GB184520@gmail.com>
References: <20190606155205.2872-1-ebiggers@kernel.org>
 <20190606155205.2872-6-ebiggers@kernel.org>
 <20190615125731.GF6142@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615125731.GF6142@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 15, 2019 at 08:57:31AM -0400, Theodore Ts'o wrote:
> On Thu, Jun 06, 2019 at 08:51:54AM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Add the beginnings of the fs/verity/ support layer, including the
> > Kconfig option and various helper functions for hashing.  To start, only
> > SHA-256 is supported, but other hash algorithms can easily be added.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Looks good; you can add:
> 
> Reviewed-off-by: Theodore Ts'o <tytso@mit.edu>
> 
> One thought for consideration below...
> 
> 
> > +
> > +/*
> > + * Maximum depth of the Merkle tree.  Up to 64 levels are theoretically possible
> > + * with a very small block size, but we'd like to limit stack usage during
> > + * verification, and in practice this is plenty.  E.g., with SHA-256 and 4K
> > + * blocks, a file with size UINT64_MAX bytes needs just 8 levels.
> > + */
> > +#define FS_VERITY_MAX_LEVELS		16
> 
> Maybe we should make FS_VERITY_MAX_LEVELS 8 for now?  This is an
> implementation-level restriction, and currently we don't support any
> architectures that have a page size < 4k.  We can always bump this
> number up in the future if it ever becomes necessary, and limiting max
> levels to 8 saves almost 100 bytes of stack space in verify_page().
> 
> 						- Ted

Yes, I agree.  I'll reduce MAX_LEVELS to 8 for now and tweak the comment.

- Eric
