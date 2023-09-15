Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A077A24A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 19:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbjIOR2g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 13:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236118AbjIOR2c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:28:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3341BF2;
        Fri, 15 Sep 2023 10:28:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C91941F74D;
        Fri, 15 Sep 2023 17:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694798905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jYlrXr9COsiXTqZelDYIvgSCoIEmwG74Vx0nCHq6QF4=;
        b=Ri5ozDQmN+12TtSf7/86mvip2TrUxYmT0KtDA2adIhQWfaJ8nbofS2/7HSdjGItU1HaKF9
        CU6HlSSYBR23C33IfBEmcqKS14SH6mstqOm3r4FlPvZqoxlLgggMXsz1kkBHIGO5nnmiUJ
        OUvvykuDidP7HORcTXLRznxgIQPIXXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694798905;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jYlrXr9COsiXTqZelDYIvgSCoIEmwG74Vx0nCHq6QF4=;
        b=yN+SOk2sDHFaDDAew0tRGThDY9EavXDcQkSD3mtfLV16TSOHJIRvZf2OYKiTRfnJ5LdT3m
        IwT7IIdzFpVqV+CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B528F1358A;
        Fri, 15 Sep 2023 17:28:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6Cw/LDmUBGXtTwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 15 Sep 2023 17:28:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 43D39A0759; Fri, 15 Sep 2023 19:28:25 +0200 (CEST)
Date:   Fri, 15 Sep 2023 19:28:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Darrick J . Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-s390@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: remove get_super
Message-ID: <20230915172825.xedwomfct3sc6ars@quack3>
References: <20230811100828.1897174-1-hch@lst.de>
 <20230912174245.GC20408@twin.jikos.cz>
 <20230914084809.arzw34svsvvkwivm@quack3>
 <20230914120320.GY20408@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914120320.GY20408@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 14-09-23 14:03:20, David Sterba wrote:
> On Thu, Sep 14, 2023 at 10:48:09AM +0200, Jan Kara wrote:
> > On Tue 12-09-23 19:42:45, David Sterba wrote:
> > > On Fri, Aug 11, 2023 at 12:08:11PM +0200, Christoph Hellwig wrote:
> > > > Hi all,
> > > > 
> > > > this series against the VFS vfs.super branch finishes off the work to remove
> > > > get_super and move (almost) all upcalls to use the holder ops.
> > > > 
> > > > The first part is the missing btrfs bits so that all file systems use the
> > > > super_block as holder.
> > > > 
> > > > The second part is various block driver cleanups so that we use proper
> > > > interfaces instead of raw calls to __invalidate_device and fsync_bdev.
> > > > 
> > > > The last part than replaces __invalidate_device and fsync_bdev with upcalls
> > > > to the file system through the holder ops, and finally removes get_super.
> > > > 
> > > > It leaves user_get_super and get_active_super around.  The former is not
> > > > used for upcalls in the traditional sense, but for legacy UAPI that for
> > > > some weird reason take a dev_t argument (ustat) or a block device path
> > > > (quotactl).  get_active_super is only used for calling into the file system
> > > > on freeze and should get a similar treatment, but given that Darrick has
> > > > changes to that code queued up already this will be handled in the next
> > > > merge window.
> > > > 
> > > > A git tree is available here:
> > > > 
> > > >     git://git.infradead.org/users/hch/misc.git remove-get_super
> > > 
> > > FYI, I've added patches 2-5 as a topic branch to btrfs for-next.
> > 
> > Hum, I don't see them there. Some glitch somewhere?
> 
> There will be a delay before the patches show up in the pushed for-next
> branch, some tests failed (maybe not related to this series) and there
> are other merge conflicts that I need to resolve first.

Thanks for picking up the patches, I can see them in your tree now. But
I've also noticed (by comparing my local branch with your tree), that in
this series is also a patch 6/17 "btrfs: use the super_block as holder when
mounting file systems" which you didn't pick up. It actually fixes block
device freezing for btrfs as a sideeffect as Christian found out [1]. Can
you please pick it up as well? Thanks!

								Honza

[1] https://lore.kernel.org/all/20230908-merklich-bebauen-11914a630db4@brauner

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
