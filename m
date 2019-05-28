Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD6A42C1B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 10:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfE1IxY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 04:53:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:42388 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726649AbfE1IxY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 04:53:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3CFCCAF1C;
        Tue, 28 May 2019 08:53:22 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     Dave Chinner <david@fromorbit.com>
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
References: <20190526061100.21761-1-amir73il@gmail.com>
        <20190526061100.21761-7-amir73il@gmail.com>
        <20190527143539.GA14980@hermes.olymp>
        <20190527220513.GB29573@dread.disaster.area>
Date:   Tue, 28 May 2019 09:53:20 +0100
In-Reply-To: <20190527220513.GB29573@dread.disaster.area> (Dave Chinner's
        message of "Tue, 28 May 2019 08:05:13 +1000")
Message-ID: <875zpvrmdb.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dave Chinner <david@fromorbit.com> writes:

> On Mon, May 27, 2019 at 03:35:39PM +0100, Luis Henriques wrote:
>> On Sun, May 26, 2019 at 09:10:57AM +0300, Amir Goldstein wrote:
>> > From: Dave Chinner <dchinner@redhat.com>
>> > 
>> > Timestamps are not updated right now, so programs looking for
>> > timestamp updates for file modifications (like rsync) will not
>> > detect that files have changed. We are also accessing the source
>> > data when doing a copy (but not when cloning) so we need to update
>> > atime on the source file as well.
>> > 
>> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
>> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>> > ---
>> >  fs/read_write.c | 10 ++++++++++
>> >  1 file changed, 10 insertions(+)
>> > 
>> > diff --git a/fs/read_write.c b/fs/read_write.c
>> > index e16bcafc0da2..4b23a86aacd9 100644
>> > --- a/fs/read_write.c
>> > +++ b/fs/read_write.c
>> > @@ -1576,6 +1576,16 @@ int generic_copy_file_range_prep(struct file *file_in, struct file *file_out)
>> >  
>> >  	WARN_ON_ONCE(!inode_is_locked(file_inode(file_out)));
>> >  
>> > +	/* Update source timestamps, because we are accessing file data */
>> > +	file_accessed(file_in);
>> > +
>> > +	/* Update destination timestamps, since we can alter file contents. */
>> > +	if (!(file_out->f_mode & FMODE_NOCMTIME)) {
>> > +		ret = file_update_time(file_out);
>> > +		if (ret)
>> > +			return ret;
>> > +	}
>> > +
>> 
>> Is this the right place for updating the timestamps?  I see that in same
>> cases we may be updating the timestamp even if there was an error and no
>> copy was performed.  For example, if file_remove_privs fails.
>
> It's the same place we do it for read - file_accessed() is called
> before we do the IO - and the same place for write -
> file_update_time() is called before we copy data into the pagecache
> or do direct IO. As such, it really doesn't matter if it is before
> or after file_remove_privs() - the IO can still fail for many
> reasons after we've updated the timestamps and in some of the
> failure cases (e.g. we failed the sync at the end of an O_DSYNC
> buffered write) we still want the timestamps to be modified because
> the data and/or user visible metadata /may/ have been changed.
>
> cfr operates under the same constraints as read() and write(), so we
> need to update the timestamps up front regardless of whether the
> copy ends up succeeding or not....

Great, thanks for explaining it.  It now makes sense, even for
consistency, to have this operation here.

Cheers,
-- 
Luis
