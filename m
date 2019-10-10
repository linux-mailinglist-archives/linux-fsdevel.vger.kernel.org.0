Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C353D2D4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2019 17:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfJJPJJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Oct 2019 11:09:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:55778 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbfJJPJJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Oct 2019 11:09:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5DE4EAF23;
        Thu, 10 Oct 2019 15:09:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B5EFC1E4814; Thu, 10 Oct 2019 17:09:06 +0200 (CEST)
Date:   Thu, 10 Oct 2019 17:09:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH 0/2] iomap: Waiting for IO in iomap_dio_rw()
Message-ID: <20191010150906.GB25364@quack2.suse.cz>
References: <20191009202736.19227-1-jack@suse.cz>
 <20191009230227.GH16973@dread.disaster.area>
 <20191010075420.GA28344@infradead.org>
 <20191010144718.GI13108@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010144718.GI13108@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 10-10-19 07:47:18, Darrick J. Wong wrote:
> On Thu, Oct 10, 2019 at 12:54:20AM -0700, Christoph Hellwig wrote:
> > On Thu, Oct 10, 2019 at 10:02:27AM +1100, Dave Chinner wrote:
> > > That would mean the callers need to do something like this by
> > > default:
> > > 
> > > 	ret = iomap_dio_rw(iocb, iter, ops, dops, is_sync_kiocb(iocb));
> > > 
> > > And filesystems like XFS will need to do:
> > > 
> > > 	ret = iomap_dio_rw(iocb, iter, ops, dops,
> > > 			is_sync_kiocb(iocb) || unaligned);
> > > 
> > > and ext4 will calculate the parameter in whatever way it needs to.
> > 
> > I defintively like that.
> > 
> > > 
> > > In fact, it may be that a wrapper function is better for existing
> > > callers:
> > > 
> > > static inline ssize_t iomap_dio_rw()
> > > {
> > > 	return iomap_dio_rw_wait(iocb, iter, ops, dops, is_sync_kiocb(iocb));
> > > }
> > > 
> > > And XFS/ext4 writes call iomap_dio_rw_wait() directly. That way we
> > > don't need to change the read code at all...
> > 
> > I have to say I really hated the way we were growing all these wrappers
> > in the old direct I/O code, so I've been asked Jan to not add the
> > wrapper in his old version.  But compared to the force_sync version it
> > at least makes a little more sense here.  I'm just not sure if
> > iomap_dio_rw_wait is the right name, but the __-prefix convention for
> > non-trivial differences also sucks.  I can't think of a better name,
> > though.
> 
> <shrug> I'd just add the 'bool wait' parameter at the end of
> iomap_dio_rw() and leave it that way.  If we ever develop more than one
> caller that passes in "is_sync_kiocb(iocb)" (or more than two lucky
> callers screwing it up I guess?) for that parameter then maybe we can
> re-evaluate.

OK, fine by me. I guess this is the least controversial proposal so I'll
resend patches with this change tomorrow...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
