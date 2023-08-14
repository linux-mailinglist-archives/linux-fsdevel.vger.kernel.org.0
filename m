Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD0877BE4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 18:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjHNQni (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 12:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbjHNQn3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:43:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC83610C0;
        Mon, 14 Aug 2023 09:43:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3B23D21906;
        Mon, 14 Aug 2023 16:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692031403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oUvv9I+YRijxn7USCgt6yOIKbwQjotN/UplplcOhebw=;
        b=zGZSRXl74qCuVw7E/cAaeiE2/vQA42KysW+S4tIkXmxqXJXhJQkiPVScxshWrxycoj40yN
        b4iHrkX+qQ02XiqOHXy7XbPU88X5fSiKnmIDtx/ZgO5ZBxsfjC9cMsI/EWLqF0e1tbsHHM
        s8u6+5gmXun9sz1wG+O93/QmW2Q+0Ns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692031403;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oUvv9I+YRijxn7USCgt6yOIKbwQjotN/UplplcOhebw=;
        b=0Sl/zKo/iWi48k0GHMTje0r8oHiqbSbZJINg6D90/3Ki5JyINjXiXRJOYRU9TU3i57jvrv
        tQgYE3dVl/VrEsBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2BEBC138EE;
        Mon, 14 Aug 2023 16:43:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Td+3CqtZ2mQnOwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 14 Aug 2023 16:43:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B03AFA0769; Mon, 14 Aug 2023 18:43:22 +0200 (CEST)
Date:   Mon, 14 Aug 2023 18:43:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Colin Walters <walters@verbum.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        Eric Biggers <ebiggers@google.com>,
        xfs <linux-xfs@vger.kernel.org>, linux-btrfs@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 1/6] block: Add config option to not allow writing to
 mounted devices
Message-ID: <20230814164322.ipqfug6466jmk6ca@quack3>
References: <20230704122727.17096-1-jack@suse.cz>
 <20230704125702.23180-1-jack@suse.cz>
 <0c5384c2-307b-43fc-9ea6-2a194f859e9b@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c5384c2-307b-43fc-9ea6-2a194f859e9b@app.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 04-07-23 11:56:44, Colin Walters wrote:
> On Tue, Jul 4, 2023, at 8:56 AM, Jan Kara wrote:
> > Writing to mounted devices is dangerous and can lead to filesystem
> > corruption as well as crashes. Furthermore syzbot comes with more and
> > more involved examples how to corrupt block device under a mounted
> > filesystem leading to kernel crashes and reports we can do nothing
> > about. Add tracking of writers to each block device and a kernel cmdline
> > argument which controls whether writes to block devices open with
> > BLK_OPEN_BLOCK_WRITES flag are allowed. We will make filesystems use
> > this flag for used devices.
> >
> > Syzbot can use this cmdline argument option to avoid uninteresting
> > crashes. Also users whose userspace setup does not need writing to
> > mounted block devices can set this option for hardening.
> >
> > Link: 
> > https://lore.kernel.org/all/60788e5d-5c7c-1142-e554-c21d709acfd9@linaro.org
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  block/Kconfig             | 16 ++++++++++
> >  block/bdev.c              | 63 ++++++++++++++++++++++++++++++++++++++-
> >  include/linux/blk_types.h |  1 +
> >  include/linux/blkdev.h    |  3 ++
> >  4 files changed, 82 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/Kconfig b/block/Kconfig
> > index 86122e459fe0..8b4fa105b854 100644
> > --- a/block/Kconfig
> > +++ b/block/Kconfig
> > @@ -77,6 +77,22 @@ config BLK_DEV_INTEGRITY_T10
> >  	select CRC_T10DIF
> >  	select CRC64_ROCKSOFT
> > 
> > +config BLK_DEV_WRITE_MOUNTED
> > +	bool "Allow writing to mounted block devices"
> > +	default y
> > +	help
> > +	When a block device is mounted, writing to its buffer cache very likely
> 
> s/very/is very/
> 
> > +	going to cause filesystem corruption. It is also rather easy to crash
> > +	the kernel in this way since the filesystem has no practical way of
> > +	detecting these writes to buffer cache and verifying its metadata
> > +	integrity. However there are some setups that need this capability
> > +	like running fsck on read-only mounted root device, modifying some
> > +	features on mounted ext4 filesystem, and similar. If you say N, the
> > +	kernel will prevent processes from writing to block devices that are
> > +	mounted by filesystems which provides some more protection from runaway
> > +	priviledged processes. If in doubt, say Y. The configuration can be
> 
> s/priviledged/privileged/
> 
> > +	overridden with bdev_allow_write_mounted boot option.
> 
> s/with/with the/

Thanks for the language fixes!

> > +/* open is exclusive wrt all other BLK_OPEN_WRITE opens to the device */
> > +#define BLK_OPEN_BLOCK_WRITES	((__force blk_mode_t)(1 << 5))
> 
> Bikeshed but: I think BLK and BLOCK "stutter" here.  The doc comment
> already uses the term "exclusive" so how about BLK_OPEN_EXCLUSIVE ?  

Well, we already have exclusive opens of block devices which are different
(they are exclusive only wrt other exclusive opens) so BLK_OPEN_EXCLUSIVE
will be really confusing. But BLK_OPEN_RESTRICT_WRITES sounds good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
