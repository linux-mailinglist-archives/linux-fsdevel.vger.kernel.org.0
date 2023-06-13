Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC0D72DEA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 12:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241769AbjFMKAL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 06:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242072AbjFMJ7e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:59:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508C71BD3;
        Tue, 13 Jun 2023 02:59:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E483B1FD6D;
        Tue, 13 Jun 2023 09:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686650357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=izpMobTKvhq6yHh0j5o5xSisZ7oVImVWUjKPXhM7spQ=;
        b=ZwM28gSEB+9OQy9VYs6vm0llgXUiTdyufue5KjnQKiEjw/+4bbwl0qBYo+mA0mSgJ61uZG
        oSlAvPfu29EXBmYl7HhWv1OnLiRJVke/0+kgxfV6cnAKyB0wwJcsVMQwnFzDkcbg0TP3Ho
        4X7GRd0JDz/L0KqRL8zElYtidMjL2OY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686650357;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=izpMobTKvhq6yHh0j5o5xSisZ7oVImVWUjKPXhM7spQ=;
        b=7MrIo3nuVLriTyUvOy1Zhyq2k4OXjyN5ieEn5FcfxPKVC+KLFeXZZe6aGW/FvrH5la8J/Q
        nG6OM/ZEJ9DgpiBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D661713345;
        Tue, 13 Jun 2023 09:59:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hmdMNPU9iGS0ZAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 13 Jun 2023 09:59:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6B85BA0717; Tue, 13 Jun 2023 11:59:17 +0200 (CEST)
Date:   Tue, 13 Jun 2023 11:59:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFCv2 2/5] ext4: Remove PAGE_SIZE assumption of folio from
 mpage_submit_folio
Message-ID: <20230613095917.trpqw2iv2f7kutaz@quack3>
References: <ZIdvJLE945Qbzy+H@casper.infradead.org>
 <87zg54580d.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zg54580d.fsf@doe.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 13-06-23 09:27:38, Ritesh Harjani wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> > On Mon, Jun 12, 2023 at 11:55:55PM +0530, Ritesh Harjani wrote:
> >> Matthew Wilcox <willy@infradead.org> writes:
> >> I couldn't respond to your change because I still had some confusion
> >> around this suggestion -
> >>
> >> > So do we care if we write a random fragment of a page after a truncate?
> >> > If so, we should add:
> >> >
> >> >         if (folio_pos(folio) >= size)
> >> >                 return 0; /* Do we need to account nr_to_write? */
> >>
> >> I was not sure whether if go with above case then whether it will
> >> work with collapse_range. I initially thought that collapse_range will
> >> truncate the pages between start and end of the file and then
> >> it can also reduce the inode->i_size. That means writeback can find an
> >> inode->i_size smaller than folio_pos(folio) which it is writing to.
> >> But in this case we can't skip the write in writeback case like above
> >> because that write is still required (a spurious write) even though
> >> i_size is reduced as it's corresponding FS blocks are not truncated.
> >>
> >> But just now looking at ext4_collapse_range() code it doesn't look like
> >> it is the problem because it waits for any dirty data to be written
> >> before truncate. So no matter which folio_pos(folio) the writeback is
> >> writing, there should not be an issue if we simply return 0 like how
> >> you suggested above.
> >>
> >>     static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
> >>
> >>     <...>
> >>         ioffset = round_down(offset, PAGE_SIZE);
> >>         /*
> >>         * Write tail of the last page before removed range since it will get
> >>         * removed from the page cache below.
> >>         */
> >>
> >>         ret = filemap_write_and_wait_range(mapping, ioffset, offset);
> >>         if (ret)
> >>             goto out_mmap;
> >>         /*
> >>         * Write data that will be shifted to preserve them when discarding
> >>         * page cache below. We are also protected from pages becoming dirty
> >>         * by i_rwsem and invalidate_lock.
> >>         */
> >>         ret = filemap_write_and_wait_range(mapping, offset + len,
> >>                         LLONG_MAX);
> >>         truncate_pagecache(inode, ioffset);
> >>
> >>         <... within i_data_sem>
> >>         i_size_write(inode, new_size);
> >>
> >>     <...>
> >>
> >>
> >> However to avoid problems like this I felt, I will do some more code
> >> reading. And then I was mostly considering your second suggestion which
> >> is this. This will ensure we keep the current behavior as is and not
> >> change that.
> >>
> >> > If we simply don't care that we're doing a spurious write, then we can
> >> > do something like:
> >> >
> >> > -               len = size & ~PAGE_MASK;
> >> > +               len = size & (len - 1);
> >
> > For all I know, I've found a bug here.  I don't know enough about ext4; if
> > we have truncated a file, and then writeback a page that is past i_size,
> > will the block its writing to have been freed?
> 
> I don't think so. If we look at truncate code, it first reduces i_size,
> then call truncate_pagecache(inode, newsize) and then we will call
> ext4_truncate() which will free the corresponding blocks.
> Since writeback happens with folio lock held until completion, hence I
> think truncate_pagecache() should block on that folio until it's lock
> has been released.
> 
> - IIUC, if truncate would have completed then the folio won't be in the
> foliocache for writeback to happen. Foliocache is kept consistent
> via
>     - first truncate the folio in the foliocache and then remove/free
>     the blocks on device.

Yes, correct.

> - Also the reason we update i_size "before" calling truncate_pagecache()
>   is to synchronize with mmap/pagefault.

Yes, but these days mapping->invalidate_lock works for that instead for
ext4.

> > Is this potentially a silent data corruptor?
> 
> - Let's consider a case when folio_pos > i_size but both still belongs
> to the last block. i.e. it's a straddle write case.
> In such case we require writeback to write the data of this last folio
> straddling i_size. Because truncate will not remove/free this last folio
> straddling i_size & neither the last block will be freed. And I think
> writeback is supposed to write this last folio to the disk to keep the
> cache and disk data consistent. Because truncate will only zero out
> the rest of the folio in the foliocache. But I don't think it will go and
> write that folio out (It's not required because i_size means that the
> rest of the folio beyond i_size should remain zero).
> 
> So, IMO writeback is supposed to write this last folio to the disk. And,
> if we skip this writeout, then I think it may cause silent data corruption.
> 
> But I am not sure about the rest of the write beyond the last block of
> i_size. I think those could just be spurious writes which won't cause
> any harm because truncate will eventually first remove this folio from
> file mapping and then will release the corresponding disk blocks.
> So writing those out should does no harm

Correct. The block straddling i_size must be written out, the blocks fully
beyond new i_size (but below old i_size) may or may not be written out. As
you say these extra racing writes to blocks that will get truncated cause
no harm.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
