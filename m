Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930B9736993
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 12:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjFTKl1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 06:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjFTKlY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:41:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF90101;
        Tue, 20 Jun 2023 03:41:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0666E21877;
        Tue, 20 Jun 2023 10:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687257672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XKKbRxLiK5MjN6DjyshZqib7TaD9MYDDfRwwRT9YtA8=;
        b=Jp+q+4HyZOYYp945K1qX1fnrs3NUtbB81jfuZV9cVnKbgkoaWeSpWlR8G1ZBZp90D5PovL
        2Zax+vZx6iyAztNuVuYLYgmSff3LNGkamFmXTfAfyfs/0B8FJIpqS3MnLFqBcXoAJi2FaF
        TWY29e6pyjAXTLk8gQ4QyKC9PY5ZjSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687257672;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XKKbRxLiK5MjN6DjyshZqib7TaD9MYDDfRwwRT9YtA8=;
        b=aIiT1BnpOztM/uhMdtG68JiZScMq/zFaK63h9zDnaq1S39ORTlSI7tr2Jgjxmhv0j9vftF
        u1N2cZbduLv9C6Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E98651346D;
        Tue, 20 Jun 2023 10:41:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VwP9OEeCkWRTYQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 20 Jun 2023 10:41:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 776D4A075D; Tue, 20 Jun 2023 12:41:11 +0200 (CEST)
Date:   Tue, 20 Jun 2023 12:41:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Ted Tso <tytso@mit.edu>, yebin <yebin@huaweicloud.com>,
        linux-fsdevel@vger.kernel.org, Kees Cook <keescook@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted
 devices
Message-ID: <20230620104111.pnjoouegp2dx6pcp@quack3>
References: <20230612161614.10302-1-jack@suse.cz>
 <ZIf6RrbeyZVXBRhm@infradead.org>
 <20230613205614.atlrwst55bpqjzxf@quack3>
 <ZIlqLJ6dFs1P4aj7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIlqLJ6dFs1P4aj7@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Christoph!

On Wed 14-06-23 00:20:12, Christoph Hellwig wrote:
> On Tue, Jun 13, 2023 at 10:56:14PM +0200, Jan Kara wrote:
> > Well, as I've mentioned in the changelog there are old setups (without
> > initrd) that run fsck on root filesystem mounted read-only and fsck
> > programs tend to open the device with O_RDWR. These would be broken by this
> > change (for the filesystems that would use BLK_OPEN_ flag).
> 
> But that's also a really broken setup that will corrupt data in many
> cases.  So yes, maybe we need a way to allow it, but it probably would
> have to be per-file system.

I was looking into implementing the write hardening support and I've come
across the following obstacle: Your patch series that is in linux-block.git
removes the 'mode' argument from blkdev_put() which makes it impossible to
track how many writers there are for the block device. This is needed so
that we can check whether the filesystem is safe when mounting the device.

I can see several solutions but since you've just reworked the code and I'm
not 100% certain about the motivation, I figured I'll ask you first before
spending significant time on something you won't like:

1) Just return the mode argument to blkdev_put().

2) Only pass to blkdev_put() whether we have write access or not as a
separate argument.

3) Don't track number of opens for writing, instead check whether writes
are blocked on each write access. I think this has a number of downsides
but I mention it for completeness. One problem is we have to add checks to
multiple places (buffered IO, direct IO) and existing mmap in particular
will be very hard to deal with (need to add page_mkwrite() handler). All
these checks add performance overhead. It is practically impossible
(without significant performance overhead or new percpu datastructures) to
properly synchronize open that wants to block writers against already
running writes.

So what would you prefer? Thanks in advance for your input.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
