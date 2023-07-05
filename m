Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63D7748908
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 18:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjGEQOH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 12:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjGEQOF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:14:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3999A1700;
        Wed,  5 Jul 2023 09:14:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8C022218EA;
        Wed,  5 Jul 2023 16:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688573641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ArN3dm9434Tcpervk5arIVNIxqqHdxPn08iNSUdER3s=;
        b=vUJGx30prcd9pjGwKtLTCS1kU+bGJcdsiVXayv0sVsAli0hJs3DphbYXGnQINP40uQwCgM
        ZhvUGi+mFF6F9+j2esjxXEgDNfKq4SBHVMa68J6rqCetob02iWnuu+wB6ZQe46bn08rjXA
        +ZVNUPajxlIi4DtdnYRn5JeDzanBiQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688573641;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ArN3dm9434Tcpervk5arIVNIxqqHdxPn08iNSUdER3s=;
        b=YrDkjE7MOQM2p+Kb0l3auCM5AiFEZ7rg+wXGy6hKCy5+M2PSh+3gNmHSWJcqFp9EntNST2
        RQuGrits9C8XWAAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BCD1134F3;
        Wed,  5 Jul 2023 16:14:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SuwwHsmWpWQrQQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 05 Jul 2023 16:14:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F238DA0707; Wed,  5 Jul 2023 18:14:00 +0200 (CEST)
Date:   Wed, 5 Jul 2023 18:14:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        Ted Tso <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        Eric Biggers <ebiggers@google.com>, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 6/6] fs: Make bind mounts work with
 bdev_allow_write_mounted=n
Message-ID: <20230705161400.ihqbg7ftkdoa4ylf@quack3>
References: <20230704122727.17096-1-jack@suse.cz>
 <20230704125702.23180-6-jack@suse.cz>
 <20230704-fasching-wertarbeit-7c6ffb01c83d@brauner>
 <20230705130033.ttv6rdywj5bnxlzx@quack3>
 <20230705-pumpwerk-vielversprechend-a4b1fd947b65@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705-pumpwerk-vielversprechend-a4b1fd947b65@brauner>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:46:19, Christian Brauner wrote:
> On Wed, Jul 05, 2023 at 03:00:33PM +0200, Jan Kara wrote:
> > On Tue 04-07-23 15:59:41, Christian Brauner wrote:
> > > On Tue, Jul 04, 2023 at 02:56:54PM +0200, Jan Kara wrote:
> > > > When we don't allow opening of mounted block devices for writing, bind
> > > > mounting is broken because the bind mount tries to open the block device
> > > 
> > > Sorry, I'm going to be annoying now...
> > > 
> > > Afaict, the analysis is misleading but I'm happy to be corrected ofc.
> > 
> > I'm not sure what your objection exactly is. Probably I was imprecise in my
> > changelog description. What gets broken by not allowing RW open of a
> > mounted block device is:
> > 
> > mount -t ext4 /dev/sda1 /mnt1
> > mount -t ext4 /dev/sda1 /mnt2
> > 
> > The second mount should create another mount of the superblock created by
> > the first mount but before that is done, get_tree_bdev() tries to open the
> > block device and fails when only patches 1 & 2 are applied. This patch
> > fixes that.
> 
> My objection is that this has nothing to do with mounts but with
> superblocks. :) No mount need exist for this issue to appear. And I would
> prefer if we keep superblock and mount separate as this leads to unclear
> analysis and changelogs.
> 
> > 
> > > Finding an existing superblock is independent of mounts. get_tree_bdev()
> > > and mount_bdev() are really only interested in finding a matching
> > > superblock independent of whether or not a mount for it already exists.
> > > IOW, if you had two filesystem contexts for the same block device with
> > > different mount options:
> > > 
> > > T1								T2
> > > fd_fs = fsopen("ext4");						fd_fs = fsopen("ext4");
> > > fsconfig(fd_fs, FSCONFIG_SET_STRING, "source", "/dev/sda");	fsconfig(fd_fs, FSCONFIG_SET_STRING, "source", "/dev/sda");
> > > 
> > > // create superblock
> > > fsconfig(fd_fs, FSCONFIG_CMD_CREATE, ...)
> > > 								// finds superblock of T1 if opts are compatible
> > > 								fsconfig(fd_fs, FSCONFIG_CMD_CREATE, ...)
> > > 
> > > you should have the issue that you're describing.
> > 
> > Correct, this will get broken when not allowing RW open for mounted block
> > devices as well because the second fsconfig(fd_fs, FSCONFIG_CMD_CREATE,
> > ...) will fail to open the block device in get_tree_bdev(). But again this
> > patch should fix that.
> > 
> > > But for neither of them does a mount already exist as the first mount
> > > here would only be created when:
> > > 
> > > T1								T2
> > > fsmount(fd_fs);							fsmount(fd_fs);
> > > 
> > > is called at which point the whole superblock issue is already settled.
> > > Afterwards, both mounts of both T1 and T2 refer to the same superblock -
> > > as long as the fs and the mount options support this ofc.
> > 
> > I guess the confusion comes from me calling "mount" an operation as
> > performed by the mount(8) command but which is in fact multiple operations
> > with the new mount API. Anyway, is the motivation of this patch clearer
> > now?
> 
> I'm clear about what you're doing here. I would just like to not have
> mounts brought into the changelog. Even before the new mount api what
> you were describing was technically a superblock only issue. If someone
> reads the changelog I want them to be able to clearly see that this is a
> fix for superblocks, not mounts.
> 
> Especially, since the code you touch really only has to to with
> superblocks.
> Let me - non ironically - return the question: Is my own request clearer
> now?

Yes, I understand now :). Thanks for explanation. I'll rephrase the
changelog to speak about superblocks.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
