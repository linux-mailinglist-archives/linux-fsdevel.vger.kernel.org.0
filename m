Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76582FD9E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 20:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392602AbhATTmD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 14:42:03 -0500
Received: from verein.lst.de ([213.95.11.211]:57139 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388101AbhATSoo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:44:44 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id ED2DA68B05; Wed, 20 Jan 2021 19:44:00 +0100 (CET)
Date:   Wed, 20 Jan 2021 19:44:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, avi@scylladb.com,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 11/11] xfs: reduce exclusive locking on unaligned dio
Message-ID: <20210120184400.GA29173@lst.de>
References: <20210118193516.2915706-1-hch@lst.de> <20210118193516.2915706-12-hch@lst.de> <20210120184056.GC3133414@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120184056.GC3133414@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[another full quote removed, guys please send properly formatted email]

On Wed, Jan 20, 2021 at 10:40:56AM -0800, Darrick J. Wong wrote:
> > +	if (!(flags & IOMAP_DIO_UNALIGNED))
> > +		inode_dio_wait(VFS_I(ip));
> 
> Er... this really confused me when I read it -- my first thought was
> "How can we be in the unaligned direct write function but DIO_UNALIGNED
> isn't set?  Wouldn't we be in some other function if we're doing an
> aligned direct write?"
> 
> Then I looked upthread to where Christph said he'd renamed it
> IOMAP_DIO_SUBBLOCK, but I didn't think that was sufficiently better:
> 
> 	if (!(flags & IOMAP_DIO_SUBBLOCK))
> 		iomap_dio_wait(...);
> 
> This flag doesn't have a 1:1 relationship with the iocb asking for an
> (fsblock-)unaligned write or the iocb saying that the write involves
> sub-block io -- this flag really means "I require a stable written
> mapping, no post-processing (of the disk block) allowed".

Would:

	if (flags & IOMAP_DIO_FORCE_WAIT)
		inode_dio_wait(VFS_I(ip));

look any better to you?  Behavior would be the same.
