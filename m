Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEB0AFC7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 14:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfIKMZP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 08:25:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:33254 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727899AbfIKMZP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 08:25:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A8E69AD44;
        Wed, 11 Sep 2019 12:25:13 +0000 (UTC)
Date:   Wed, 11 Sep 2019 07:25:11 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Andres Freund <andres@anarazel.de>, linux-fsdevel@vger.kernel.org,
        jack@suse.com, hch@infradead.org
Subject: Re: Odd locking pattern introduced as part of "nowait aio support"
Message-ID: <20190911122511.tygfujqgjtshkzym@fiona>
References: <20190910223327.mnegfoggopwqqy33@alap3.anarazel.de>
 <20190911040420.GB27547@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911040420.GB27547@dread.disaster.area>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14:04 11/09, Dave Chinner wrote:
> On Tue, Sep 10, 2019 at 03:33:27PM -0700, Andres Freund wrote:
> > Hi,
> > 
> > Especially with buffered io it's fairly easy to hit contention on the
> > inode lock, during writes. With something like io_uring, it's even
> > easier, because it currently (but see [1]) farms out buffered writes to
> > workers, which then can easily contend on the inode lock, even if only
> > one process submits writes.  But I've seen it in plenty other cases too.
> > 
> > Looking at the code I noticed that several parts of the "nowait aio
> > support" (cf 728fbc0e10b7f3) series introduced code like:
> > 
> > static ssize_t
> > ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> > {
> > ...
> > 	if (!inode_trylock(inode)) {
> > 		if (iocb->ki_flags & IOCB_NOWAIT)
> > 			return -EAGAIN;
> > 		inode_lock(inode);
> > 	}
> 
> The ext4 code is just buggy here - we don't support RWF_NOWAIT on
> buffered writes. Buffered reads, and dio/dax reads and writes, yes,
> but not buffered writes because they are almost guaranteed to block
> somewhere. See xfs_file_buffered_aio_write():
> 
> 	if (iocb->ki_flags & IOCB_NOWAIT)
> 		return -EOPNOTSUPP;
> 
> generic_write_checks() will also reject IOCB_NOWAIT on buffered
> writes, so that code in ext4 is likely in the wrong place...

Yes, but inode_trylock is checking if we can get inode sem immidiately,
and if not bail, instead of waiting for the sem, as opposed to rejecting
bufferd I/O nowait writes.

generic_write_checks() has the checks which disallows nowait without direct
writes, so we can do away with those checks in ext4_file_write_iter().
However, the return code in generic_write_checks() is -EINVAL and
-ENOTSUPP in ext4_file_write_iter(). Removing the check in write_iter()
will change the error code to -EINVAL from -EOPNOTSUPP.


-- 
Goldwyn
