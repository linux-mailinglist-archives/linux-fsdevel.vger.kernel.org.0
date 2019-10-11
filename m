Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE7BD4578
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 18:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbfJKQbb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 12:31:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:52652 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726331AbfJKQbb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:31:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 36077B258;
        Fri, 11 Oct 2019 16:31:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6482E1E4A86; Fri, 11 Oct 2019 18:31:27 +0200 (CEST)
Date:   Fri, 11 Oct 2019 18:31:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH 1/2] iomap: Allow forcing of waiting for running DIO in
 iomap_dio_rw()
Message-ID: <20191011163127.GA22122@quack2.suse.cz>
References: <20191011125520.11697-1-jack@suse.cz>
 <20191011141433.18354-1-jack@suse.cz>
 <20191011152821.GJ13108@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011152821.GJ13108@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 11-10-19 08:28:21, Darrick J. Wong wrote:
> On Fri, Oct 11, 2019 at 04:14:31PM +0200, Jan Kara wrote:
> > Filesystems do not support doing IO as asynchronous in some cases. For
> > example in case of unaligned writes or in case file size needs to be
> > extended (e.g. for ext4). Instead of forcing filesystem to wait for AIO
> > in such cases, add argument to iomap_dio_rw() which makes the function
> > wait for IO completion. This also results in executing
> > iomap_dio_complete() inline in iomap_dio_rw() providing its return value
> > to the caller as for ordinary sync IO.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>

...

> > @@ -409,6 +409,9 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> >  	if (!count)
> >  		return 0;
> >  
> > +	if (WARN_ON(is_sync_kiocb(iocb) && !wait_for_completion))
> > +		return -EINVAL;
> 
> So far in iomap we've been returning EIO when someone internal screws
> up, which (AFAICT) is the case here.

Yes. Should I resend with -EIO or will you tweak that on commit?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
