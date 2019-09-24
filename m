Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDA3BC5A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 12:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409454AbfIXK3g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 06:29:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37413 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405224AbfIXK3g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 06:29:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id c17so1082314pgg.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2019 03:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cWHGhu/xEva0NCUnsouhp2Rqjl7y8RfVbbdYtfLeN1A=;
        b=NXTlTyI2vIC+atFvgwWyJ3X4f1wCJA+4VK9JPTs1mEoi1HY2sx4ltdBARifdKoKcS9
         2yx9TcD/NNgkKGikxuWo09JtjlGYqkNrS4fGR5K76CoDkswsT9/pudKgmJYuMUwxkQim
         AVFMwL6sCWE2Jv2X/udeSLAJL3CdAT2QewEdvE4vqp+tP5my453goJ5AA05WSH2//mXI
         nipsqAuVLye7htJ4SftWF8jyqGju1+piB2jpn3C0SpvaebgJAlbfN7tJKZeSvd91DLMW
         JW5XV4ES9R6hTdYZrVjx188QWdHIiODMNHHxuV8LOEYIXwe0n6MtfBBRwhWlC2GPjCuv
         Fnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cWHGhu/xEva0NCUnsouhp2Rqjl7y8RfVbbdYtfLeN1A=;
        b=mym6emA8EEfnOXT7f0HsA/U7mLfa+C6BL2rzh8qQtudiFMypuEXh6LHBaz9clpiP35
         9FlRZt2hr4VG1zY2G8FbcaIMxr5qjkjBD0STf4r3RVDl5/MyS4WiPsAZxbkKt8uGXfae
         YXxu2ZbHqYEXcLX4w7//ORfRJF5W3aHWq36117RRiei87DkXlbMV+OB3waB6sEoGl70N
         ITJLzQOn25lFYEnTMVcYixdrnz82P4iueKfHtIHDRfaavilC6poCzuV8Ql6SfF7W73lr
         VdfJoPKxHTOzIleEY6cwBXBCsQ8vfkak96h2wqOTmGxPwzL/zxBpAbocg7WY+kZ89vgI
         fyog==
X-Gm-Message-State: APjAAAW0cABvPH4WP8Wzci/sSi+MhwtmEE9HQJyFj305aM8GCR1jGn30
        xtCmumFmrZpI9UqVfoSOBkzU
X-Google-Smtp-Source: APXvYqy5qJMRHiBOqREZujbqzO1hT2uDA4E6FhAximKLjJJKWV2Mj0Z9FbBtcBXhVGD2Kb56U2B9IA==
X-Received: by 2002:a17:90a:2301:: with SMTP id f1mr2163987pje.121.1569320973166;
        Tue, 24 Sep 2019 03:29:33 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id s1sm5023004pjs.31.2019.09.24.03.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 03:29:32 -0700 (PDT)
Date:   Tue, 24 Sep 2019 20:29:26 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
Subject: Re: [PATCH v3 5/6] ext4: introduce direct IO write path using iomap
 infrastructure
Message-ID: <20190924102926.GC17526@bobrowski>
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
 <db33705f9ba35ccbe20fc19b8ecbbf2078beff08.1568282664.git.mbobrowski@mbobrowski.org>
 <20190923211011.GH20367@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923211011.GH20367@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 23, 2019 at 11:10:11PM +0200, Jan Kara wrote:
> On Thu 12-09-19 21:04:46, Matthew Bobrowski wrote:
> > +/*
> > + * For a write that extends the inode size, ext4_dio_write_iter() will
> > + * wait for the write to complete. Consequently, operations performed
> > + * within this function are still covered by the inode_lock(). On
> > + * success, this function returns 0.
> > + */
> > +static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size, int error,
> > +				 unsigned int flags)
> > +{
> > +	int ret;
> > +	loff_t offset = iocb->ki_pos;
> > +	struct inode *inode = file_inode(iocb->ki_filp);
> > +
> > +	if (error) {
> > +		ret = ext4_handle_failed_inode_extension(inode, offset + size);
> > +		return ret ? ret : error;
> > +	}
> > +
> > +	if (flags & IOMAP_DIO_UNWRITTEN) {
> > +		ret = ext4_convert_unwritten_extents(NULL, inode,
> > +						     offset, size);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	if (offset + size > i_size_read(inode)) {
> > +		ret = ext4_handle_inode_extension(inode, offset, size, 0);
> > +		if (ret)
> > +			return ret;
> > +	}
> 
> With the suggestions I made to your patch 3/6 this could be simplified to:
> 
> 	if (!error && flags & IOMAP_DIO_UNWRITTEN) {
> 		error = ext4_convert_unwritten_extents(NULL, inode, offset,
> 						       size);
> 	}
> 	return ext4_handle_inode_extension(inode, offset, error ? : size, size);
> 
> 
> Note the change that when ext4_convert_unwritten_extents() fails (although
> this should not really happen unless there's some corruption going on), we
> do properly truncate possible extents beyond i_size.

This sounds good to me. I like this idea.
 
> > +static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
> > +{
> > +	ssize_t ret;
> > +	size_t count;
> > +	loff_t offset = iocb->ki_pos;
> > +	struct inode *inode = file_inode(iocb->ki_filp);
> > +	bool extend = false, overwrite = false, unaligned_aio = false;
> > +
> > +	if (!inode_trylock(inode)) {
> > +		if (iocb->ki_flags & IOCB_NOWAIT)
> > +			return -EAGAIN;
> > +		inode_lock(inode);
> > +	}
> > +
> > +	if (!ext4_dio_checks(inode)) {
> > +		inode_unlock(inode);
> > +		/*
> > +		 * Fallback to buffered IO if the operation on the
> > +		 * inode is not supported by direct IO.
> > +		 */
> > +		return ext4_buffered_write_iter(iocb, from);
> > +	}
> > +
> > +	ret = ext4_write_checks(iocb, from);
> > +	if (ret <= 0) {
> > +		inode_unlock(inode);
> > +		return ret;
> > +	}
> > +
> > +	/*
> > +	 * Unaligned direct AIO must be serialized among each other as
> > +	 * the zeroing of partial blocks of two competing unaligned
> > +	 * AIOs can result in data corruption.
> > +	 */
> > +	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS) &&
> > +	    !is_sync_kiocb(iocb) && ext4_unaligned_aio(inode, from, offset)) {
> > +		unaligned_aio = true;
> > +		inode_dio_wait(inode);
> > +	}
> > +
> > +	/*
> > +	 * Determine whether the IO operation will overwrite allocated
> > +	 * and initialized blocks. If so, check to see whether it is
> > +	 * possible to take the dioread_nolock path.
> > +	 */
> > +	count = iov_iter_count(from);
> > +	if (!unaligned_aio && ext4_overwrite_io(inode, offset, count) &&
> > +	    ext4_should_dioread_nolock(inode)) {
> > +		overwrite = true;
> > +		downgrade_write(&inode->i_rwsem);
> > +	}
> > +
> > +	if (offset + count > i_size_read(inode) ||
> > +	    offset + count > EXT4_I(inode)->i_disksize) {
> > +		ext4_update_i_disksize(inode, inode->i_size);
> > +		extend = true;
> > +	}
> 
> This call to ext4_update_i_disksize() is definitely wrong. If nothing else,
> you need to also have transaction started and call ext4_mark_inode_dirty()
> to actually journal the change of i_disksize (ext4_update_i_disksize()
> updates only the in-memory copy of the entry). Also the direct IO code
> needs to add the inode to the orphan list so that in case of crash, blocks
> allocated beyond EOF get truncated on next mount. That is the whole point
> of this excercise with i_disksize after all.
> 
> But I'm wondering if i_disksize update is needed. Truncate cannot be in
> progress (we hold i_rwsem) and dirty pages will be flushed by
> iomap_dio_rw() before we start to allocate any blocks. So it should be
> enough to have here:

Well, I initially thought the same, however doing some research shows that we
have the following edge case:
     - 45d8ec4d9fd54
     and
     - 73fdad00b208b

In fact you can reproduce the exact same i_size corruption issue by running
the generic/475 xfstests mutitple times, as articulated within
45d8ec4d9fd54. So with that, I'm kind of confused and thinking that there may
be a problem that resides elsewhere that may need addressing?
 
> 	if (offset + count > i_size_read(inode)) {
> 		/*
> 		 * Add inode to orphan list so that blocks allocated beyond
> 		 * EOF get properly truncated in case of crash.
> 		 */
> 		start transaction handle
> 		add inode to orphan list
> 		stop transaction handle
> 	}
> 
> And just leave i_disksize at whatever it currently is.

I originally had the code which added the inode to the orphan list here, but
then I thought to myself that it'd make more sense to actually do this step
closer to the point where we've managed to successfully allocate the required
blocks for the write. This prevents the need to spray orphan list clean up
code all over the place just to cover the case that a write which had intended
to extend the inode beyond i_size had failed prematurely (i.e. before block
allocation). So, hence the reason why I thought having it in
ext4_iomap_begin() would make more sense, because at that point in the write
path, there is enough/or more assurance to make the call around whether we
will in fact be able to perform the write which will be extending beyond
i_size, or not and consequently whether the inode should be placed onto the
orphan list?

Ideally I'd like to turn this statement into:

	if (offset + count > i_size_read(inode))
	        extend = true;

Maybe I'm missing something here and there's actually a really good reason for
doing this nice and early? What are your thoughts about what I've mentioned
above?

> > -		 * If we added blocks beyond i_size, we need to make sure they
> > -		 * will get truncated if we crash before updating i_size in
> > -		 * ext4_iomap_end(). For faults we don't need to do that (and
> > -		 * even cannot because for orphan list operations inode_lock is
> > -		 * required) - if we happen to instantiate block beyond i_size,
> > -		 * it is because we race with truncate which has already added
> > -		 * the inode to the orphan list.
> > +		 * If we added blocks beyond i_size, we need to make
> > +		 * sure they will get truncated if we crash before
> > +		 * updating the i_size. For faults we don't need to do
> > +		 * that (and even cannot because for orphan list
> > +		 * operations inode_lock is required) - if we happen
> > +		 * to instantiate block beyond i_size, it is because
> > +		 * we race with truncate which has already added the
> > +		 * inode to the orphan list.
> >  		 */
> 
> Just a nit but it would be nice to use full width of 80 columns when
> formatting comments so that they don't get unnecessarily long.

Sure. I'm blaming emacs for this. :P

--<M>--
