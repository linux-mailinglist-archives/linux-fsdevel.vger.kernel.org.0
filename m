Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1966C6691
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 12:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCWLaf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 07:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWLae (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:30:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3326A58
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 04:30:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C10FF33AFE;
        Thu, 23 Mar 2023 11:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679571031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PafqFtBeT3VNjLa3bxD2d3FT8QKiRREDypdho4biGYk=;
        b=xxk0H1VUm5tlRIPe31O4WpV90ssc0y40SuM926E5ZfiMAmtyd4CYgJHG0fcsAiBinUXarO
        Icqe7XddkeVqg75Hv1eN0p+TbIOVJVgZ1RuKdHaylEZLaAy44GlebE3yToPzp0VfLpXTim
        ms6jZbSYQq99XYTO8YaI/dEWrQck1Nk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679571031;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PafqFtBeT3VNjLa3bxD2d3FT8QKiRREDypdho4biGYk=;
        b=yRT7BIEczqyllmYv3ubax2JxiGI4JEyo4jgJXH2GJUEHZJ//fRPFVMbnP4CNvx/uEjvtBS
        B1brXYxd1Z48XqDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC0D213596;
        Thu, 23 Mar 2023 11:30:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RGD1KVc4HGRUEgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 23 Mar 2023 11:30:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0E952A071C; Thu, 23 Mar 2023 12:30:30 +0100 (CET)
Date:   Thu, 23 Mar 2023 12:30:30 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, lsf-pc@lists.linux-foundation.org
Subject: Re: [RFCv1][WIP] ext2: Move direct-io to use iomap
Message-ID: <20230323113030.ryne2oq27b6cx6xz@quack3>
References: <87ttz889ns.fsf@doe.com>
 <eae9d2125de1887f55186668937df7475b0a33f4.1678977084.git.ritesh.list@gmail.com>
 <20230320175139.l5oqbwuae4schgcu@quack3>
 <87zg85pa5i.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zg85pa5i.fsf@doe.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 22-03-23 12:04:01, Ritesh Harjani wrote:
> Jan Kara <jack@suse.cz> writes:
> >> +	pos += size;
> >> +	if (pos > i_size_read(inode))
> >> +		i_size_write(inode, pos);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static const struct iomap_dio_ops ext2_dio_write_ops = {
> >> +	.end_io = ext2_dio_write_end_io,
> >> +};
> >> +
> >> +static ssize_t ext2_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
> >> +{
> >> +	struct file *file = iocb->ki_filp;
> >> +	struct inode *inode = file->f_mapping->host;
> >> +	ssize_t ret;
> >> +	unsigned int flags;
> >> +	unsigned long blocksize = inode->i_sb->s_blocksize;
> >> +	loff_t offset = iocb->ki_pos;
> >> +	loff_t count = iov_iter_count(from);
> >> +
> >> +
> >> +	inode_lock(inode);
> >> +	ret = generic_write_checks(iocb, from);
> >> +	if (ret <= 0)
> >> +		goto out_unlock;
> >> +	ret = file_remove_privs(file);
> >> +	if (ret)
> >> +		goto out_unlock;
> >> +	ret = file_update_time(file);
> >> +	if (ret)
> >> +		goto out_unlock;
> >> +
> >> +	/*
> >> +	 * We pass IOMAP_DIO_NOSYNC because otherwise iomap_dio_rw()
> >> +	 * calls for generic_write_sync in iomap_dio_complete().
> >> +	 * Since ext2_fsync nmust be called w/o inode lock,
> >> +	 * hence we pass IOMAP_DIO_NOSYNC and handle generic_write_sync()
> >> +	 * ourselves.
> >> +	 */
> >> +	flags = IOMAP_DIO_NOSYNC;
> >
> > Meh, this is kind of ugly and we should come up with something better for
> > simple filesystems so that they don't have to play these games. Frankly,
> > these days I doubt there's anybody really needing inode_lock in
> > __generic_file_fsync(). Neither sync_mapping_buffers() nor
> > sync_inode_metadata() need inode_lock for their self-consistency. So it is
> > only about flushing more consistent set of metadata to disk when fsync(2)
> > races with other write(2)s to the same file so after a crash we have higher
> > chances of seeing some real state of the file. But I'm not sure it's really
> > worth keeping for filesystems that are still using sync_mapping_buffers().
> > People that care about consistency after a crash have IMHO moved to other
> > filesystems long ago.
> >
> 
> One way which hch is suggesting is to use __iomap_dio_rw() -> unlock
> inode -> call generic_write_sync(). I haven't yet worked on this part.

So I see two problems with what Christoph suggests:

a) It is unfortunate API design to require trivial (and low maintenance)
   filesystem to do these relatively complex locking games. But this can
   be solved by providing appropriate wrapper for them I guess.

b) When you unlock the inode, other stuff can happen with the inode. And
   e.g. i_size update needs to happen after IO is completed so filesystems
   would have to be taught to avoid say two racing expanding writes. That's
   IMHO really too much to ask.

> Are you suggesting to rip of inode_lock from __generic_file_fsync()?
> Won't it have a much larger implications?

Yes and yes :). But inode writeback already happens from other paths
without inode_lock so there's hardly any surprise there.
sync_mapping_buffers() is impossible to "customize" by filesystems and the
generic code is fine without inode_lock. So I have hard time imagining how
any filesystem would really depend on inode_lock in this path (famous last
words ;)).

> >> +	if (iocb->ki_pos + iov_iter_count(from) > i_size_read(inode) ||
> >> +	   (!IS_ALIGNED(iocb->ki_pos | iov_iter_alignment(from), blocksize)))
> >> +		flags |= IOMAP_DIO_FORCE_WAIT;
> >> +
> >> +	ret = iomap_dio_rw(iocb, from, &ext2_iomap_ops, &ext2_dio_write_ops,
> >> +			   flags, NULL, 0);
> >> +
> >> +	if (ret == -ENOTBLK)
> >> +		ret = 0;
> >
> > So iomap_dio_rw() doesn't have the DIO_SKIP_HOLES behavior of
> > blockdev_direct_IO(). Thus you have to implement that in your
> > ext2_iomap_ops, in particular in iomap_begin...
> >
> 
> Aah yes. Thanks for pointing that out -
> ext2_iomap_begin() should have something like this -
> 	/*
> 	 * We cannot fill holes in indirect tree based inodes as that could
> 	 * expose stale data in the case of a crash. Use the magic error code
> 	 * to fallback to buffered I/O.
> 	 */
> 
> Also I think ext2_iomap_end() should also handle a case like in ext4 -
> 
> 	/*
> 	 * Check to see whether an error occurred while writing out the data to
> 	 * the allocated blocks. If so, return the magic error code so that we
> 	 * fallback to buffered I/O and attempt to complete the remainder of
> 	 * the I/O. Any blocks that may have been allocated in preparation for
> 	 * the direct I/O will be reused during buffered I/O.
> 	 */
> 	if (flags & (IOMAP_WRITE | IOMAP_DIRECT) && written == 0)
> 		return -ENOTBLK;
> 
> 
> I am wondering if we have testcases in xfstests which really tests these
> functionalities also or not? Let me give it a try...
> ... So I did and somehow couldn't find any testcase which fails w/o
> above changes.

I guess we don't. It isn't that simple (but certainly possible) to test for
stale data exposure...

> Another query -
> 
> We have this function ext2_iomap_end() (pasted below)
> which calls ext2_write_failed().
> 
> Here IMO two cases are possible -
> 
> 1. written is 0. which means an error has occurred.
> In that case calling ext2_write_failed() make sense.
> 
> 2. consider a case where written > 0 && written < length.
> (This is possible right?). In that case we still go and call
> ext2_write_failed(). This function will truncate the pagecache and disk
> blocks beyong i_size. Now we haven't yet updated inode->i_size (we do
> that in ->end_io which gets called in the end during completion)
> So that means it just removes everything.
> 
> Then in ext2_dax_write_iter(), we might go and update inode->i_size
> to iocb->ki_pos including for short writes. This looks like it isn't
> consistent because earlier we had destroyed all the blocks for the short
> writes and we will be returning ret > 0 to the user saying these many
> bytes have been written.
> Again I haven't yet found a test case at least not in xfstests which
> can trigger this short writes. Let me know your thoughts on this.
> All of this lies on the fact that there can be a case where
> written > 0 && written < length. I will read more to see if this even
> happens or not. But I atleast wanted to capture this somewhere.

So as far as I remember, direct IO writes as implemented in iomap are
all-or-nothing (see iomap_dio_complete()). But it would be good to assert
that in ext4 code to avoid surprises if the generic code changes.

> Another thing -
> In dax while truncating the inode i_size in ext2_setsize(),
> I think we don't properly call dax_zero_blocks() when we are trying to
> zero the last block beyond EOF. i.e. for e.g. it can be called with len
> as 0 if newsize is page_aligned. It then will call ext2_get_blocks() with
> len = 0 and can bug_on at maxblocks == 0.

How will it call ext2_get_blocks() with len == 0? AFAICS iomap_iter() will
not call iomap_begin() at all if iter.len == 0.

> I think it should be this. I will spend some more time analyzing this
> and also test it once against DAX paths.
> 
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index 7ff669d0b6d2..cc264b1e288c 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -1243,9 +1243,8 @@ static int ext2_setsize(struct inode *inode, loff_t newsize)
>         inode_dio_wait(inode);
> 
>         if (IS_DAX(inode))
> -               error = dax_zero_range(inode, newsize,
> -                                      PAGE_ALIGN(newsize) - newsize, NULL,
> -                                      &ext2_iomap_ops);
> +               error = dax_truncate_page(inode, newsize, NULL,
> +                                         &ext2_iomap_ops);
>         else
>                 error = block_truncate_page(inode->i_mapping,
>                                 newsize, ext2_get_block);

That being said this is indeed a nice cleanup.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
