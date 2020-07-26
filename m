Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEAFF22DB62
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 04:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgGZCtW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jul 2020 22:49:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbgGZCtW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jul 2020 22:49:22 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95BDA205CB;
        Sun, 26 Jul 2020 02:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595731761;
        bh=NAdi/klNeTi1UKbatqqEO+YULbHx0XAXFAEJ2boRXms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rk0JV3yKOUVfoUzNKVR9NotJxck+84sGURjCBkcBqzTj0HgOll1QTZl7K95qYKjeU
         1+1/MouEdKh1SKByzaHGghSyQ46DxASQ8JPOOOr4iAp5aHjFmp1Wko56K2W7TZbqmp
         Ue1h8bWvDCTu45/rkYFfAsH3QAOvEe3FCGZP9Ldc=
Date:   Sat, 25 Jul 2020 19:49:20 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Satya Tangirala <satyat@google.com>,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v6 1/7] fscrypt: Add functions for direct I/O
 support
Message-ID: <20200726024920.GB14321@sol.localdomain>
References: <20200724184501.1651378-1-satyat@google.com>
 <20200724184501.1651378-2-satyat@google.com>
 <20200725001441.GQ2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725001441.GQ2005@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 25, 2020 at 10:14:41AM +1000, Dave Chinner wrote:
> > +bool fscrypt_dio_supported(struct kiocb *iocb, struct iov_iter *iter)
> > +{
> > +	const struct inode *inode = file_inode(iocb->ki_filp);
> > +	const unsigned int blocksize = i_blocksize(inode);
> > +
> > +	/* If the file is unencrypted, no veto from us. */
> > +	if (!fscrypt_needs_contents_encryption(inode))
> > +		return true;
> > +
> > +	/* We only support direct I/O with inline crypto, not fs-layer crypto */
> > +	if (!fscrypt_inode_uses_inline_crypto(inode))
> > +		return false;
> > +
> > +	/*
> > +	 * Since the granularity of encryption is filesystem blocks, the I/O
> > +	 * must be block aligned -- not just disk sector aligned.
> > +	 */
> > +	if (!IS_ALIGNED(iocb->ki_pos | iov_iter_alignment(iter), blocksize))
> > +		return false;
> 
> Doesn't this force user buffers to be filesystem block size aligned,
> instead of 512 byte aligned as is typical for direct IO?
> 
> That's going to cause applications that work fine on normal
> filesystems becaues the memalign() buffers to 512 bytes or logical
> block device sector sizes (as per the open(2) man page) to fail on
> encrypted volumes, and it's not going to be obvious to users as to
> why this happens.

The status quo is that direct I/O on encrypted files falls back to buffered I/O.

So this patch is strictly an improvement; it's making direct I/O work in a case
where previously it didn't work.

> 
> XFS has XFS_IOC_DIOINFO to expose exactly this information to
> userspace on a per-file basis. Other filesystem and VFS developers
> have said for the past 15 years "we don't need no stinking DIOINFO".
> The same people shot down adding optional IO alignment
> constraint fields to statx() a few years ago, too.
> 
> Yet here were are again, with alignment of DIO buffers being an
> issue that userspace needs to know about....
> 

A DIOINFO ioctl sounds like a good idea to me, although I'm not familiar with
previous discussions about it.

Note that there are lots of other cases where ext4 and f2fs fall back to
buffered I/O; see ext4_dio_supported() and f2fs_force_buffered_io().  So this
isn't a new problem.

- Eric
