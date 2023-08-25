Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECD77888EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 15:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245250AbjHYNs1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 09:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbjHYNsE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:48:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA72C2136;
        Fri, 25 Aug 2023 06:47:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 49AEC21F79;
        Fri, 25 Aug 2023 13:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692971277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BpzfsfMiRxmg30OdFnKzv1mOgTevyt5wkPNcyneGwG0=;
        b=uohLnKnqtpENx2vCia+CF25VunAvqKNxW8Gl/JZPjm2522sG0QzHP89CKm9gvg5uhIQmJN
        WBEcUX07tygEsfRFeW0MDCmmX2lneinhEWFdq+jYTgqP+tDCYKowqEsMW88igvW28lrojs
        hfcd/30g2Ie/qrM4mt7e3dhBm3c9V28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692971277;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BpzfsfMiRxmg30OdFnKzv1mOgTevyt5wkPNcyneGwG0=;
        b=avw/hNX+TPhBa6q/Pyjq6dsHiVTX81moNODEW9+kRWtkr4cKF/cxPXXUPquXV79uoK0IL4
        nSbq/d/haJGtPRAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28033138F9;
        Fri, 25 Aug 2023 13:47:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UJRbCQ2x6GQZAwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 25 Aug 2023 13:47:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A432FA0774; Fri, 25 Aug 2023 15:47:56 +0200 (CEST)
Date:   Fri, 25 Aug 2023 15:47:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Alasdair Kergon <agk@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anna Schumaker <anna@kernel.org>, Chao Yu <chao@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        David Sterba <dsterba@suse.com>, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com, Gao Xiang <xiang@kernel.org>,
        Jack Wang <jinpu.wang@ionos.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        jfs-discussion@lists.sourceforge.net,
        Joern Engel <joern@lazybastard.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Minchan Kim <minchan@kernel.org>, ocfs2-devel@oss.oracle.com,
        reiserfs-devel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Song Liu <song@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        target-devel@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        xen-devel@lists.xenproject.org, Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 0/29] block: Make blkdev_get_by_*() return handle
Message-ID: <20230825134756.o3wpq6bogndukn53@quack3>
References: <20230810171429.31759-1-jack@suse.cz>
 <20230825015843.GB95084@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825015843.GB95084@ZenIV>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 25-08-23 02:58:43, Al Viro wrote:
> On Fri, Aug 11, 2023 at 01:04:31PM +0200, Jan Kara wrote:
> > Hello,
> > 
> > this is a v2 of the patch series which implements the idea of blkdev_get_by_*()
> > calls returning bdev_handle which is then passed to blkdev_put() [1]. This
> > makes the get and put calls for bdevs more obviously matching and allows us to
> > propagate context from get to put without having to modify all the users
> > (again!).  In particular I need to propagate used open flags to blkdev_put() to
> > be able count writeable opens and add support for blocking writes to mounted
> > block devices. I'll send that series separately.
> > 
> > The series is based on Christian's vfs tree as of yesterday as there is quite
> > some overlap. Patches have passed some reasonable testing - I've tested block
> > changes, md, dm, bcache, xfs, btrfs, ext4, swap. This obviously doesn't cover
> > everything so I'd like to ask respective maintainers to review / test their
> > changes. Thanks! I've pushed out the full branch to:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git bdev_handle
> > 
> > to ease review / testing.
> 
> Hmm...  Completely Insane Idea(tm): how about turning that thing inside out and
> having your bdev_open_by... return an actual opened struct file?
> 
> After all, we do that for sockets and pipes just fine and that's a whole lot
> hotter area.
> 
> Suppose we leave blkdev_open()/blkdev_release() as-is.  No need to mess with
> what we have for normal opened files for block devices.  And have block_open_by_dev()
> that would find bdev, etc., same yours does and shove it into anon file.
> 
> Paired with plain fput() - no need to bother with new primitives for closing.
> With a helper returning I_BDEV(bdev_file_inode(file)) to get from those to bdev.
> 
> NOTE: I'm not suggesting replacing ->s_bdev with struct file * if we do that -
> we want that value cached, obviously.  Just store both...
> 
> Not saying it's a good idea, but... might be interesting to look into.
> Comments?

I can see the appeal of not having to introduce the new bdev_handle type
and just using struct file which unifies in-kernel and userspace block
device opens. But I can see downsides too - the last fput() happening from
task work makes me a bit nervous whether it will not break something
somewhere with exclusive bdev opens. Getting from struct file to bdev is
somewhat harder but I guess a helper like F_BDEV() would solve that just
fine.

So besides my last fput() worry about I think this could work and would be
probably a bit nicer than what I have. But before going and redoing the whole
series let me gather some more feedback so that we don't go back and forth.
Christoph, Christian, Jens, any opinion?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
