Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7CE731B8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 16:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344888AbjFOOkK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 10:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345110AbjFOOkE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:40:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4BA10F7;
        Thu, 15 Jun 2023 07:40:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7E6181FE0D;
        Thu, 15 Jun 2023 14:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686840000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rg0LVmR77Ii9gfVj41bv0FKC78jxC9AyYGMjHjJPx/4=;
        b=k26eHXpQyMUrWoaZsgw9XnsEZbLp/+9taf9ZTxq6OlGoU5uDUWZtyKDJZFUlQXPUGsNIMs
        cIq51dqXFXlrccSPRv5776Dufyjl43TEJVdYidPRd8r6RXy6l1SBXUONYN8qi3yJcexEiw
        cIkOh9Yf0gRaXnMKWwm72F9tWmnH+XM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686840000;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rg0LVmR77Ii9gfVj41bv0FKC78jxC9AyYGMjHjJPx/4=;
        b=KFSDgIxqRjceh/cwfxB2a3au9zOHdxQVpOUqh3CZtXGfrw85b0WidK62Bwl784f4MBKB74
        d1b2EnDhd/vSAJAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6F3D013A32;
        Thu, 15 Jun 2023 14:40:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8BYdG8Aii2SIewAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 15 Jun 2023 14:40:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0144EA0755; Thu, 15 Jun 2023 16:39:59 +0200 (CEST)
Date:   Thu, 15 Jun 2023 16:39:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, yebin <yebin@huaweicloud.com>,
        linux-fsdevel@vger.kernel.org,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted
 devices
Message-ID: <20230615143959.6ajtc27eehpxje54@quack3>
References: <20230612161614.10302-1-jack@suse.cz>
 <ZIf6RrbeyZVXBRhm@infradead.org>
 <CACT4Y+ZsN3wemvGLVyNWj9zjykGwcHoy581w7GuAHGpAj1YLxg@mail.gmail.com>
 <ZIlphqM9cpruwU6m@infradead.org>
 <20230614-anstalt-gepfercht-affd490e6544@brauner>
 <20230614103654.ydiosiv6ptljwd7i@quack3>
 <20230614-witzbold-liedtexte-ea9a6420606a@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614-witzbold-liedtexte-ea9a6420606a@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 14-06-23 14:48:17, Christian Brauner wrote:
> On Wed, Jun 14, 2023 at 12:36:54PM +0200, Jan Kara wrote:
> > On Wed 14-06-23 10:18:16, Christian Brauner wrote:
> > > On Wed, Jun 14, 2023 at 12:17:26AM -0700, Christoph Hellwig wrote:
> > > > On Tue, Jun 13, 2023 at 08:09:14AM +0200, Dmitry Vyukov wrote:
> > > > > I don't question there are use cases for the flag, but there are use
> > > > > cases for the config as well.
> > > > > 
> > > > > Some distros may want a guarantee that this does not happen as it
> > > > > compromises lockdown and kernel integrity (on par with unsigned module
> > > > > loading).
> > > > > For fuzzing systems it also may be hard to ensure fine-grained
> > > > > argument constraints, it's much easier and more reliable to prohibit
> > > > > it on config level.
> > > > 
> > > > I'm fine with a config option enforcing write blocking for any
> > > > BLK_OPEN_EXCL open.  Maybe the way to it is to:
> > > > 
> > > >  a) have an option to prevent any writes to exclusive openers, including
> > > >     a run-time version to enable it
> > > 
> > > I really would wish we don't make this runtime configurable. Build time
> > > and boot time yes but toggling it at runtime makes this already a lot
> > > less interesting.
> > 
> > I see your point from security POV. But if you are say a desktop (or even
> > server) user you may need to say resize your LVM or add partition to your
> > disk or install grub2 into boot sector of your partition. In all these
> > cases you need write access to a block device that is exclusively claimed
> > by someone else. Do you mandate reboot in permissive mode for all these
> > cases? Realistically that means such users just won't bother with the
> > feature and leave it disabled all the time. I'm OK with such outcome but I
> > wanted to point out this "no protection change after boot" policy noticably
> > restricts number of systems where this is applicable.
> 
> You're asking the hard/right questions.
> 
> Installing the boot loader into a boot sector seems like an archaic
> scenario. With UEFI this isn't necessary and systems that do want this
> they should turn the Kconfig off or boot with it turned off.

OK.
 
> I'm trying to understand the partition and lvm resize issue. I've
> chatted a bit about this and it seems that in this protected mode we
> should ensure that we cannot write to the main block device's sectors
> that are mapped to a partition block device. If you write to the main
> block device of a partitioned device one should only be able to modify
> the footer and header but nothing where you have a partition block
> device on. That should mean you can resize an LVM partition afaict.
> 
> I've been told that the partition block devices and the main block
> devices have different buffer caches. But that means you cannot mix
> accesses to them because writes to one will not show up on the other
> unless caches are flushed on both devices all the time.
> 
> So it'd be neat if the writes to the whole block device would simply be
> not allowed at all to areas which are also exposed as partition block
> devices.

So you're touching very similar areas I've replied to elsewhere [1] in this
thread. But let me go into more details here:

1) Disallowing modifications to area covered by some partition through the
main block device is doable but it means arbitration needs to happen on
each write (or page fault ???) which has performance implications. 

2) With LVM, device mapper exclusively claims the underlying device, places
header / footer to it and then exposes the rest of the device as another
block device (possibly after further block remapping games). Loop device
can do the same. With LVM you can also have multiple block devices mapping
to the same underlying block device and possibly overlapping ranges
(userspace fully controls this), in fact partitioning on top of RAID or
multipath devices is done this way AFAIK.

So tracking all these ranges, how they are remapped and what is actually
used by whom seems like a really complex task that would need to propagate
the information through multiple layers.

So I would backtrack a bit and maybe ask what is the threat model and what
protection you'd like to achieve? Because as you mentioned above, each
block device has a separate (incoherent) buffer cache. That is also a good
thing because protecting "filesystem's" buffer cache from corruption means
we need to just protect that one block device when the filesystem is using
it to avoid the worst problems. Writes to the same physical location
through different block devices will corrupt the data "at rest" but the
filesystem should do enough verification to catch this when loading the
data into the buffer cache. So we could make blkdev_get_by_dev() calls when
mounting filesystems disallow any other FMODE_WRITE opens of the block
device and that should still allow modifying partition tables or LVM setup.
It will break legacy boot setups & tuning ext4 parameters while the
filesystem is mounted but I'm fine with just saying "don't use this feature
if you do this". What do you think?

								Honza

[1] https://lore.kernel.org/all/20230614101256.kgnui242k72lmp4e@quack3

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
