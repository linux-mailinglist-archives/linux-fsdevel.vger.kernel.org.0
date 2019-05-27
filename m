Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFCA2BBE1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 00:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfE0WFV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 May 2019 18:05:21 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:53551 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727217AbfE0WFV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 May 2019 18:05:21 -0400
Received: from dread.disaster.area (pa49-180-144-61.pa.nsw.optusnet.com.au [49.180.144.61])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 4A54A3DCEE1;
        Tue, 28 May 2019 08:05:14 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hVNk1-0006hz-7b; Tue, 28 May 2019 08:05:13 +1000
Date:   Tue, 28 May 2019 08:05:13 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Luis Henriques <lhenriques@suse.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-api@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v2 6/8] vfs: copy_file_range should update file timestamps
Message-ID: <20190527220513.GB29573@dread.disaster.area>
References: <20190526061100.21761-1-amir73il@gmail.com>
 <20190526061100.21761-7-amir73il@gmail.com>
 <20190527143539.GA14980@hermes.olymp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527143539.GA14980@hermes.olymp>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=8RU0RCro9O0HS2ezTvitPg==:117 a=8RU0RCro9O0HS2ezTvitPg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=E5NmQfObTbMA:10
        a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=7-415B0cAAAA:8 a=6473QJAXGLPk3sUS-KIA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 27, 2019 at 03:35:39PM +0100, Luis Henriques wrote:
> On Sun, May 26, 2019 at 09:10:57AM +0300, Amir Goldstein wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Timestamps are not updated right now, so programs looking for
> > timestamp updates for file modifications (like rsync) will not
> > detect that files have changed. We are also accessing the source
> > data when doing a copy (but not when cloning) so we need to update
> > atime on the source file as well.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/read_write.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/fs/read_write.c b/fs/read_write.c
> > index e16bcafc0da2..4b23a86aacd9 100644
> > --- a/fs/read_write.c
> > +++ b/fs/read_write.c
> > @@ -1576,6 +1576,16 @@ int generic_copy_file_range_prep(struct file *file_in, struct file *file_out)
> >  
> >  	WARN_ON_ONCE(!inode_is_locked(file_inode(file_out)));
> >  
> > +	/* Update source timestamps, because we are accessing file data */
> > +	file_accessed(file_in);
> > +
> > +	/* Update destination timestamps, since we can alter file contents. */
> > +	if (!(file_out->f_mode & FMODE_NOCMTIME)) {
> > +		ret = file_update_time(file_out);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> 
> Is this the right place for updating the timestamps?  I see that in same
> cases we may be updating the timestamp even if there was an error and no
> copy was performed.  For example, if file_remove_privs fails.

It's the same place we do it for read - file_accessed() is called
before we do the IO - and the same place for write -
file_update_time() is called before we copy data into the pagecache
or do direct IO. As such, it really doesn't matter if it is before
or after file_remove_privs() - the IO can still fail for many
reasons after we've updated the timestamps and in some of the
failure cases (e.g. we failed the sync at the end of an O_DSYNC
buffered write) we still want the timestamps to be modified because
the data and/or user visible metadata /may/ have been changed.

cfr operates under the same constraints as read() and write(), so we
need to update the timestamps up front regardless of whether the
copy ends up succeeding or not....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
