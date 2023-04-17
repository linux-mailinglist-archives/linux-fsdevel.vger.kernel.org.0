Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7806E4E85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 18:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjDQQpy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 12:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDQQpx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 12:45:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EA57AB9;
        Mon, 17 Apr 2023 09:45:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1D3761F6E6;
        Mon, 17 Apr 2023 16:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681749951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vSfgyeWUCMr1di6JSEW99BNSZWNgQbxTLcBjCnl+w6Y=;
        b=VYOsc6N5bWK6WV6aefJ+2qjF6rndgboFJSBRQJlS5eLuXALOBoLDvsqkiL9QPYMkO8k95G
        Z/wdct/Fpf7EYgqAvqPfY7ECmRkE7N+8TsVexkeQce7NNSJ08Mk4j9rIav2VdTITKMXuJG
        J1gt9ReLRjeDXWVeDUzypIXO+1vN71c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681749951;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vSfgyeWUCMr1di6JSEW99BNSZWNgQbxTLcBjCnl+w6Y=;
        b=4kMRYJxusszI+YtrhTVXbC9htzOPdSDBDFPsFpQCE3EycWqMRICmVxlGepUJ3sxFXUrU2o
        UZtbzVAQEqH9D9Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 085E713319;
        Mon, 17 Apr 2023 16:45:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id i56YAb93PWS/XgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 17 Apr 2023 16:45:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7CC1AA0735; Mon, 17 Apr 2023 18:45:50 +0200 (CEST)
Date:   Mon, 17 Apr 2023 18:45:50 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv5 2/9] fs/buffer.c: Add generic_buffer_fsync
 implementation
Message-ID: <20230417164550.yw6p4ddruutxqqax@quack3>
References: <20230417110149.mhrksh4owqkfw5pa@quack3>
 <87o7nmivqm.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7nmivqm.fsf@doe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 17-04-23 17:08:57, Ritesh Harjani wrote:
> Jan Kara <jack@suse.cz> writes:
> 
> > On Sun 16-04-23 15:38:37, Ritesh Harjani (IBM) wrote:
> >> Some of the higher layers like iomap takes inode_lock() when calling
> >> generic_write_sync().
> >> Also writeback already happens from other paths without inode lock,
> >> so it's difficult to say that we really need sync_mapping_buffers() to
> >> take any inode locking here. Having said that, let's add
> >> generic_buffer_fsync() implementation in buffer.c with no
> >> inode_lock/unlock() for now so that filesystems like ext2 and
> >> ext4's nojournal mode can use it.
> >>
> >> Ext4 when got converted to iomap for direct-io already copied it's own
> >> variant of __generic_file_fsync() without lock. Hence let's add a helper
> >> API and use it both in ext2 and ext4.
> >>
> >> Later we can review other filesystems as well to see if we can make
> >> generic_buffer_fsync() which does not take any inode_lock() as the
> >> default path.
> >>
> >> Tested-by: Disha Goel <disgoel@linux.ibm.com>
> >> Reviewed-by: Christoph Hellwig <hch@lst.de>
> >> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> >
> > There is a problem with generic_buffer_fsync() that it does not call
> > blkdev_issue_flush() so the caller is responsible for doing that. That's
> > necessary for ext2 & ext4 so fine for now. But historically this was the
> > case with generic_file_fsync() as well and that led to many filesystem
> > forgetting to flush caches from fsync(2).
> 
> Ok, thanks for the details.
> 
> > What is our transition plan for
> > these filesystems that currently do the cache flush from
> > generic_file_fsync()? Do we want to eventually keep generic_file_fsync()
> > doing the cache flush and call generic_buffer_fsync() instead of
> > __generic_buffer_fsync() from it?
> 
> Frankly speaking, I was thinking we will come back to this question
> maybe when we start working on those changes. At this point in time
> I only looked at it from ext2 DIO changes perspective.

Yes, we can return to this later. The only thing I wanted to kind of make
sure is we don't have to rename the function again when adding support for
other filesystems (although even that would not be a big issue given there
are two callers).

> But since you asked, here is what I think we could do -
> 
> Rename generic_file_fsync => generic_buffers_sync() to fs/buffers.c
> Then
> generic_buffers_sync() {
>     ret = generic_buffers_fsync()
>     if (!ret)
>        blkdev_issue_flush()
> }
> 
> generic_buffers_fsync() is same as in this patch which does not have the
> cache flush operation.
> (will rename from generic_buffer_fsync() to generic_buffers_fsync())
> 
> Note: The naming is kept such that-
> - sync means it will do fsync followed by cache flush.
> - fsync means it will only do the file fsync

Hum, I think the difference sync vs fsync is too subtle and non-obvious.
I can see sensible pairs like:

	__generic_buffers_fsync() - "__" indicates you should know what you
				are doing when calling this
	generic_buffers_fsync()

or

	generic_buffers_fsync()
	generic_file_fsync() - difficult at this point as there's name
			       clash

or

	generic_buffers_fsync_noflush()
	generic_buffers_fsync() - obvious what the default "safe" choice
				  is.

or something like that.

> As I understand - we would eventually like to kill the
> inode_lock() variants of generic_file_fsync() and __generic_file_fsync()
> after auditing other filesystem code, right?

Yes.

> Then for now what we need is generic_buffers_sync() function which does
> not take an inode_lock() and also does cache flush which is required for ext2.
> And generic_buffers_fsync() which does not do any cache flush operations
> required by filesystem like ext4.
> 
> Does that sound good to you? Is the naming also proper?

I agree with the plan, just the naming is hard :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
