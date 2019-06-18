Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 009E64A705
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 18:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbfFRQfH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 12:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729386AbfFRQfH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:35:07 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0758720673;
        Tue, 18 Jun 2019 16:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560875706;
        bh=GeIvHcqxM8GaaYPQkIqVTtuvhdr1Xv+rCU27pAM0CSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yo9Vew7Bm0+5tZyNbxb/SXmKNcf/bFXBgzKVl3flNIxOzH8wbcJTYEsVheeLxJoNA
         PwmDSlPYT48h693vme8664sJ0r3s1gRftmE9pqtaT1HaMiWQbV9OgBggVcgDorla1v
         aOgwjKhoYToWhR4vzNmuDK39hClHFyzbqh2cXHWA=
Date:   Tue, 18 Jun 2019 09:35:04 -0700
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
Subject: Re: [PATCH v4 07/16] fs-verity: add the hook for file ->open()
Message-ID: <20190618163503.GC184520@gmail.com>
References: <20190606155205.2872-1-ebiggers@kernel.org>
 <20190606155205.2872-8-ebiggers@kernel.org>
 <20190615144207.GH6142@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615144207.GH6142@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 15, 2019 at 10:42:07AM -0400, Theodore Ts'o wrote:
> On Thu, Jun 06, 2019 at 08:51:56AM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Add the fsverity_file_open() function, which prepares an fs-verity file
> > to be read from.  If not already done, it loads the fs-verity descriptor
> > from the filesystem and sets up an fsverity_info structure for the inode
> > which describes the Merkle tree and contains the file measurement.  It
> > also denies all attempts to open verity files for writing.
> > 
> > This commit also begins the include/linux/fsverity.h header, which
> > declares the interface between fs/verity/ and filesystems.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Looks good; you can add:
> 
> Reviewed-off-by: Theodore Ts'o <tytso@mit.edu>
> 
> 						- Ted
> 
> > +/*
> > + * Validate the given fsverity_descriptor and create a new fsverity_info from
> > + * it.  The signature (if present) is also checked.
> > + */
> > +struct fsverity_info *fsverity_create_info(const struct inode *inode,
> > +					   const void *_desc, size_t desc_size)
> 
> Well, technically it's not checked (yet).  It doesn't get checked
> until [PATCH 13/16]: support builtin file signatures.  If we want to
> be really nit-picky, that portion of the comment could be moved to
> later in the series.
> 

Yes, I missed this when splitting out the patches.  I'll move it to patch 13.

- Eric
