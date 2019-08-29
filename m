Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4243A1380
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 10:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfH2ISd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 04:18:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:59050 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbfH2ISd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:18:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B24FDAD23;
        Thu, 29 Aug 2019 08:18:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4709D1E3BE6; Thu, 29 Aug 2019 10:18:31 +0200 (CEST)
Date:   Thu, 29 Aug 2019 10:18:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, riteshh@linux.ibm.com
Subject: Re: [PATCH 2/5] ext4: move inode extension/truncate code out from
 ext4_iomap_end()
Message-ID: <20190829081831.GB19156@quack2.suse.cz>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <774754e9b2afc541df619921f7743d98c5c6a358.1565609891.git.mbobrowski@mbobrowski.org>
 <20190828195914.GF22343@quack2.suse.cz>
 <20190828215421.GA9221@athena.bobrowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828215421.GA9221@athena.bobrowski.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 29-08-19 07:54:21, Matthew Bobrowski wrote:
> On Wed, Aug 28, 2019 at 09:59:14PM +0200, Jan Kara wrote:
> > > @@ -257,6 +308,13 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
> > >  		goto out;
> > >  
> > >  	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
> > > +
> > > +	if (ret > 0 && iocb->ki_pos > i_size_read(inode)) {
> > > +		err = ext4_handle_inode_extension(inode, iocb->ki_pos,
> > > +						  iov_iter_count(from));
> > > +		if (err)
> > > +			ret = err;
> > > +	}
> 
> I noticed that within ext4_dax_write_iter() we're not accommodating
> for error cases. Subsequently, there's no clean up code that goes with
> that. So, for example, in the case where we've added the inode onto
> the orphan list as a result of an extension and we bump into any error
> i.e. -ENOSPC, we'll be left with inconsistencies. Perhaps it might be
> worthwhile to introduce a helper here
> i.e. ext4_dax_handle_failed_write(), which would be the path taken to
> perform any necessary clean up routines in the case of a failed write?
> I think it'd be better to have this rather than polluting
> ext4_dax_write_iter(). What do you think?

Esentially you'll need the same error-handling code as you have in
ext4_dio_write_end_io(). So probably just factor that out into a common
helper like ext4_handle_failed_inode_extension() and call it from
ext4_dio_write_end_io() and ext4_dax_write_iter().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
