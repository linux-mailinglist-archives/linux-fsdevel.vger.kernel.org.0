Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03384777671
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 13:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjHJLFw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 07:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjHJLFv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:05:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E8F2108;
        Thu, 10 Aug 2023 04:05:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5FD561F749;
        Thu, 10 Aug 2023 11:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691665548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1DFh8evqtxspjStydxXxKkjnilpW0tYumnluwrTMIZo=;
        b=vLT7nxhsKaVB+2d6j1Yf5X8t1GLYqRuuN4g6ZutMMICOunL7y0FZNv7gLZiYXzC/l2Xomu
        I8xmm0CPUZCp/iFMbz+eWr+/L/YJb1/utRAjSeiWYdJX1v/2EQl6s2syK6Yg4TzJfLlWXK
        j+SruuD6SzbR8Z3B6IZKMOfh62510CU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691665548;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1DFh8evqtxspjStydxXxKkjnilpW0tYumnluwrTMIZo=;
        b=gjop8gtt3TnFXcbkSm06MHlxNzKkmd+CJQt27qbqqSRylA/dQexstbBZ/MQ0KnNaiV041a
        Mrb6ToOuPtQHkpAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4EB2E138E2;
        Thu, 10 Aug 2023 11:05:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bLIxE4zE1GQpLAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 10 Aug 2023 11:05:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D2565A076F; Thu, 10 Aug 2023 13:05:47 +0200 (CEST)
Date:   Thu, 10 Aug 2023 13:05:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 02/12] nilfs2: use setup_bdev_super to de-duplicate the
 mount code
Message-ID: <20230810110547.ks62g2flysgwpgru@quack3>
References: <20230802154131.2221419-1-hch@lst.de>
 <20230802154131.2221419-3-hch@lst.de>
 <20230803114651.ihtqqgthbdjjgxev@quack3>
 <CAKFNMomzHg33SHnp6xGMEZY=+k6Y4t7dvBvgBDbO9H3ujzNDCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKFNMomzHg33SHnp6xGMEZY=+k6Y4t7dvBvgBDbO9H3ujzNDCw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 04-08-23 11:01:39, Ryusuke Konishi wrote:
> On Thu, Aug 3, 2023 at 8:46 PM Jan Kara wrote:
> >
> > On Wed 02-08-23 17:41:21, Christoph Hellwig wrote:
> > > Use the generic setup_bdev_super helper to open the main block device
> > > and do various bits of superblock setup instead of duplicating the
> > > logic.  This includes moving to the new scheme implemented in common
> > > code that only opens the block device after the superblock has allocated.
> > >
> > > It does not yet convert nilfs2 to the new mount API, but doing so will
> > > become a bit simpler after this first step.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> > AFAICS nilfs2 could *almost* use mount_bdev() directly and then just do its
> 
> > snapshot thing after mount_bdev() returns. But it has this weird logic
> > that: "if the superblock is already mounted but we can shrink the whole
> > dcache, then do remount instead of ignoring mount options". Firstly, this
> > looks racy - what prevents someone from say opening a file on the sb just
> > after nilfs_tree_is_busy() shrinks dcache? Secondly, it is inconsistent
> > with any other filesystem so it's going to surprise sysadmins not
> > intimately knowing nilfs2. Thirdly, from userspace you cannot tell what
> > your mount call is going to do. Last but not least, what is it really good
> > for? Ryusuke, can you explain please?
> >
> >                                                                 Honza
> 
> I think you are referring to the following part:
> 
> >        if (!s->s_root) {
> ...
> >        } else if (!sd.cno) {
> >                if (nilfs_tree_is_busy(s->s_root)) {
> >                        if ((flags ^ s->s_flags) & SB_RDONLY) {
> >                                nilfs_err(s,
> >                                          "the device already has a %s mount.",
> >                                          sb_rdonly(s) ? "read-only" : "read/write");
> >                                err = -EBUSY;
> >                                goto failed_super;
> >                        }
> >                } else {
> >                        /*
> >                         * Try remount to setup mount states if the current
> >                         * tree is not mounted and only snapshots use this sb.
> >                         */
> >                        err = nilfs_remount(s, &flags, data);
> >                        if (err)
> >                                goto failed_super;
> >                }
> >        }
> 
> What this logic is trying to do is, if there is already a nilfs2 mount
> instance for the device, and are trying to mounting the current tree
> (sd.cno is 0, so this is not a snapshot mount), then will switch
> depending on whether the current tree has a mount:
> 
> - If the current tree is mounted, it's just like a normal filesystem.
> (A read-only mount and a read/write mount can't coexist, so check
> that, and reuse the instance if possible)
> - Otherwise, i.e. for snapshot mounts only, do whatever is necessary
> to add a new current mount, such as starting a log writer.
>    Since it does the same thing that nilfs_remount does, so
> nilfs_remount() is used there.
> 
> Whether or not there is a current tree mount can be determined by
> d_count(s->s_root) > 1 as nilfs_tree_is_busy() does.
> Where s->s_root is always the root dentry of the current tree, not
> that of the mounted snapshot.

I see now, thanks for explanation! But one thing still is not clear to me.
If you say have a snapshot mounted read-write and then you mount the
current snapshot (cno == 0) read-only, you'll switch the whole superblock
to read-only state. So also the mounted snapshot is suddently read-only
which is unexpected and actually supposedly breaks things because you can
still have file handles open for writing on the snapshot etc.. So how do
you solve that?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
