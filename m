Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FE974822B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 12:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjGEKan (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 06:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjGEKam (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:30:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA602E57;
        Wed,  5 Jul 2023 03:30:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9558022182;
        Wed,  5 Jul 2023 10:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688553038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6GYCY7SvwGbwjyd6zFjHA4s1Mqj8rjelW8jwRdbqGsA=;
        b=YwrCKChwbrTpfRWddqRsfXJFAQN5Posy00OGBQwhWRJoSU8mp4AAkDcBj16G9o1piW/637
        67HplP6Y2kg6L5AkQZyTXRisvixeCiTIvFGKtQGjmiMBsjPlFw0BRfck2kc+rGUjyVGjOa
        rSdKaOFjb7V6zyOnRVEjlTY+bEL/csQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688553038;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6GYCY7SvwGbwjyd6zFjHA4s1Mqj8rjelW8jwRdbqGsA=;
        b=VE5rQWcsYXqkeFex/GfPPDLPLbistlq4A5HHyhruyICDqyrwWibZABvooxnGJOC456q14Z
        E1+rjkuuhsTancAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84D2713460;
        Wed,  5 Jul 2023 10:30:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +EBeIE5GpWQXEAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 05 Jul 2023 10:30:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 012F5A0707; Wed,  5 Jul 2023 12:30:37 +0200 (CEST)
Date:   Wed, 5 Jul 2023 12:30:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        Ted Tso <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 1/6] block: Add config option to not allow writing to
 mounted devices
Message-ID: <20230705103037.fvizcrecsjhswngn@quack3>
References: <20230704122727.17096-1-jack@suse.cz>
 <20230704125702.23180-1-jack@suse.cz>
 <20230704184416.GE1851@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704184416.GE1851@sol.localdomain>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 04-07-23 11:44:16, Eric Biggers wrote:
> On Tue, Jul 04, 2023 at 02:56:49PM +0200, Jan Kara wrote:
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
> > Link: https://lore.kernel.org/all/60788e5d-5c7c-1142-e554-c21d709acfd9@linaro.org
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
> > +	going to cause filesystem corruption. It is also rather easy to crash
> > +	the kernel in this way since the filesystem has no practical way of
> > +	detecting these writes to buffer cache and verifying its metadata
> > +	integrity. However there are some setups that need this capability
> > +	like running fsck on read-only mounted root device, modifying some
> > +	features on mounted ext4 filesystem, and similar. If you say N, the
> > +	kernel will prevent processes from writing to block devices that are
> > +	mounted by filesystems which provides some more protection from runaway
> > +	priviledged processes. If in doubt, say Y. The configuration can be
> > +	overridden with bdev_allow_write_mounted boot option.
> 
> Does this prevent the underlying storage from being written to?  Say if the
> mounted block device is /dev/sda1 and someone tries to write to /dev/sda in the
> region that contains sda1.
> 
> I *think* the answer is no, writes to /dev/sda are still allowed since the goal
> is just to prevent writes to the buffer cache of mounted block devices, not
> writes to the underlying storage.  That is really something that should be
> stated explicitly, though.

You are correct. The answer is "no" because as Ted says, there are many
ways to do that anyway and for a filesystem it is generally not much
different from just corrupted fs image. I'll explicitely mention it in the
config text, that's a good idea.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
