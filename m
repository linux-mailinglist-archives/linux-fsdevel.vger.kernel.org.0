Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEA86C1EB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 18:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCTR6S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 13:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjCTR55 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:57:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4202238B7B
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 10:53:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E54AB21A9A;
        Mon, 20 Mar 2023 17:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679334699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GRnFPbzooMWZJFxO7VzdDsDtC5lwueBazWgNaHtvilc=;
        b=XNB8njeSyMhpodw27SNnoCK5OPFhkg+Hkzk0iiXFcyz0Fu0a+Ky4BTqRB9oai1AeuVID2A
        RPGhIyNFmZzvWLaohevzVWSvro2yUDMcm9ZDBooiWEWQPAAYS9gA31LEXdIHEanhjLcTUn
        mAYciBT5GyKaDvE/PWQVainu5i8BmXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679334699;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GRnFPbzooMWZJFxO7VzdDsDtC5lwueBazWgNaHtvilc=;
        b=nuUaMpwzFMjPmV6fMAF8lsVvj4L2ty9+IIluQC8+fVAqUU62rmnE/1uT4B5r5K2Y2IWBm7
        GolOFgJQDv9g4OAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF2F013416;
        Mon, 20 Mar 2023 17:51:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id a3J+MiudGGRNGAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 20 Mar 2023 17:51:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 206D6A0719; Mon, 20 Mar 2023 18:51:39 +0100 (CET)
Date:   Mon, 20 Mar 2023 18:51:39 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, lsf-pc@lists.linux-foundation.org
Subject: Re: [RFCv1][WIP] ext2: Move direct-io to use iomap
Message-ID: <20230320175139.l5oqbwuae4schgcu@quack3>
References: <87ttz889ns.fsf@doe.com>
 <eae9d2125de1887f55186668937df7475b0a33f4.1678977084.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eae9d2125de1887f55186668937df7475b0a33f4.1678977084.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 16-03-23 20:10:29, Ritesh Harjani (IBM) wrote:
> [DO NOT MERGE] [WORK-IN-PROGRESS]
> 
> Hello Jan,
> 
> This is an initial version of the patch set which I wanted to share
> before today's call. This is still work in progress but atleast passes
> the set of test cases which I had kept for dio testing (except 1 from my
> list).
> 
> Looks like there won't be much/any changes required from iomap side to
> support ext2 moving to iomap apis.
> 
> I will be doing some more testing specifically test generic/083 which is
> occassionally failing in my testing.
> Also once this is stabilized, I can do some performance testing too if you
> feel so. Last I remembered we saw some performance regressions when ext4
> moved to iomap for dio.
> 
> PS: Please ignore if there are some silly mistakes. As I said, I wanted
> to get this out before today's discussion. :)
> 
> Thanks for your help!!
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/ext2/ext2.h  |   1 +
>  fs/ext2/file.c  | 114 ++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/ext2/inode.c |  20 +--------
>  3 files changed, 117 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
> index cb78d7dcfb95..cb5e309fe040 100644
> --- a/fs/ext2/ext2.h
> +++ b/fs/ext2/ext2.h
> @@ -753,6 +753,7 @@ extern unsigned long ext2_count_free (struct buffer_head *, unsigned);
>  extern struct inode *ext2_iget (struct super_block *, unsigned long);
>  extern int ext2_write_inode (struct inode *, struct writeback_control *);
>  extern void ext2_evict_inode(struct inode *);
> +extern void ext2_write_failed(struct address_space *mapping, loff_t to);
>  extern int ext2_get_block(struct inode *, sector_t, struct buffer_head *, int);
>  extern int ext2_setattr (struct mnt_idmap *, struct dentry *, struct iattr *);
>  extern int ext2_getattr (struct mnt_idmap *, const struct path *,
> diff --git a/fs/ext2/file.c b/fs/ext2/file.c
> index 6b4bebe982ca..7a8561304559 100644
> --- a/fs/ext2/file.c
> +++ b/fs/ext2/file.c
> @@ -161,12 +161,123 @@ int ext2_fsync(struct file *file, loff_t start, loff_t end, int datasync)
>  	return ret;
>  }
> 
> +static ssize_t ext2_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
> +{
> +	struct file *file = iocb->ki_filp;
> +	struct inode *inode = file->f_mapping->host;
> +	ssize_t ret;
> +
> +	inode_lock_shared(inode);
> +	ret = iomap_dio_rw(iocb, to, &ext2_iomap_ops, NULL, 0, NULL, 0);
> +	inode_unlock_shared(inode);
> +
> +	return ret;
> +}
> +
> +static int ext2_dio_write_end_io(struct kiocb *iocb, ssize_t size,
> +				 int error, unsigned int flags)
> +{
> +	loff_t pos = iocb->ki_pos;
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	if (error)
> +		return error;
> +

I guess you should carry over here relevant bits of the comment from
ext4_dio_write_end_io() explaining that doing i_size update here is
necessary and actually safe.

> +	pos += size;
> +	if (pos > i_size_read(inode))
> +		i_size_write(inode, pos);
> +
> +	return 0;
> +}
> +
> +static const struct iomap_dio_ops ext2_dio_write_ops = {
> +	.end_io = ext2_dio_write_end_io,
> +};
> +
> +static ssize_t ext2_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
> +{
> +	struct file *file = iocb->ki_filp;
> +	struct inode *inode = file->f_mapping->host;
> +	ssize_t ret;
> +	unsigned int flags;
> +	unsigned long blocksize = inode->i_sb->s_blocksize;
> +	loff_t offset = iocb->ki_pos;
> +	loff_t count = iov_iter_count(from);
> +
> +
> +	inode_lock(inode);
> +	ret = generic_write_checks(iocb, from);
> +	if (ret <= 0)
> +		goto out_unlock;
> +	ret = file_remove_privs(file);
> +	if (ret)
> +		goto out_unlock;
> +	ret = file_update_time(file);
> +	if (ret)
> +		goto out_unlock;
> +
> +	/*
> +	 * We pass IOMAP_DIO_NOSYNC because otherwise iomap_dio_rw()
> +	 * calls for generic_write_sync in iomap_dio_complete().
> +	 * Since ext2_fsync nmust be called w/o inode lock,
> +	 * hence we pass IOMAP_DIO_NOSYNC and handle generic_write_sync()
> +	 * ourselves.
> +	 */
> +	flags = IOMAP_DIO_NOSYNC;

Meh, this is kind of ugly and we should come up with something better for
simple filesystems so that they don't have to play these games. Frankly,
these days I doubt there's anybody really needing inode_lock in
__generic_file_fsync(). Neither sync_mapping_buffers() nor
sync_inode_metadata() need inode_lock for their self-consistency. So it is
only about flushing more consistent set of metadata to disk when fsync(2)
races with other write(2)s to the same file so after a crash we have higher
chances of seeing some real state of the file. But I'm not sure it's really
worth keeping for filesystems that are still using sync_mapping_buffers().
People that care about consistency after a crash have IMHO moved to other
filesystems long ago.

> +
> +	/* use IOMAP_DIO_FORCE_WAIT for unaligned of extending writes */
						  ^^ or

> +	if (iocb->ki_pos + iov_iter_count(from) > i_size_read(inode) ||
> +	   (!IS_ALIGNED(iocb->ki_pos | iov_iter_alignment(from), blocksize)))
> +		flags |= IOMAP_DIO_FORCE_WAIT;
> +
> +	ret = iomap_dio_rw(iocb, from, &ext2_iomap_ops, &ext2_dio_write_ops,
> +			   flags, NULL, 0);
> +
> +	if (ret == -ENOTBLK)
> +		ret = 0;

So iomap_dio_rw() doesn't have the DIO_SKIP_HOLES behavior of
blockdev_direct_IO(). Thus you have to implement that in your
ext2_iomap_ops, in particular in iomap_begin...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
