Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4545C77EC00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 23:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346564AbjHPVkB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 17:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346568AbjHPVjp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:39:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE18FDC
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 14:39:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 805702187E;
        Wed, 16 Aug 2023 21:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692221982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3fIwOsgavtp1XzKgwoYAyukf5Wc3UdrMiQ97zF+okNE=;
        b=xengWMueqDZPZgIDhr+9LPt+UVJDdyC0vOuZk1oR9oiHloDeDLrtdr4NjGGKkG1/WrwK/Q
        rLmS8v0q46KcEKDVOe65DvHiipLSBHFASVZRONKtWNiU8SBjFDjan4ooQsbFQDJJ4hiLPi
        UMzMFrfaZKS4cnJV3THWO9eW6fLXKaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692221982;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3fIwOsgavtp1XzKgwoYAyukf5Wc3UdrMiQ97zF+okNE=;
        b=NuZZzAnD0PdTlLfqfPW6YPzxCftS+VByHK1g7XFNdlyg5F4uWtVH4FlPxkDlN/oO5Ftla3
        aC5wUdVOKZe8neCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 712851353E;
        Wed, 16 Aug 2023 21:39:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /5ySGx5C3WSVQgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 16 Aug 2023 21:39:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F39B4A0769; Wed, 16 Aug 2023 23:39:41 +0200 (CEST)
Date:   Wed, 16 Aug 2023 23:39:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, jack@suse.cz,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: open the block device after allocation the
 super_block
Message-ID: <20230816213941.4767piue43zuvl6t@quack3>
References: <20230724175145.201318-1-hch@lst.de>
 <20230815-zeitdokument-quintessenz-7b75f29456a7@brauner>
 <20230816-anlangt-trimmen-5fa7744a954f@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816-anlangt-trimmen-5fa7744a954f@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 16-08-23 09:29:08, Christian Brauner wrote:
> On Tue, Aug 15, 2023 at 04:43:12PM +0200, Christian Brauner wrote:
> > >  		up_write(&s->s_umount);
> > > -		blkdev_put(bdev, fs_type);
> > > +		error = setup_bdev_super(s, flags, NULL);
> > >  		down_write(&s->s_umount);
> > 
> > So I've been looking through the branches to see what's ready for v6.6
> > and what needs some more time. While doing so I went over this again and
> > realized that we have an issue here.
> > 
> > While it looks like dropping s_umount here and calling
> > setup_bdev_super() is fine I think it isn't. Consider two processes
> > racing to create the same mount:
> > 
> > P1                                                                    P2
> > vfs_get_tree()                                                        vfs_get_tree()
> > -> get_tree() == get_tree_bdev()                                      -> get_tree() == get_tree_bdev()
> >    -> sget_fc()                                                          -> sget_fc()
> >         // allocate new sb; no matching sb found
> >       -> sb_p1 = alloc_super()
> >       -> hlist_add_head(&s->s_instances, &s->s_type->fs_supers)
> >       -> spin_unlock(&sb_lock)                                              
> >       // yield s_umount to avoid deadlocks
> >    -> up_write(&sb->s_umount)
> >                                                                             -> spin_lock(&sb_lock)
> >                                                                                // find sb_p1
> >                                                                                if (test(old, fc))
> >                                                                                        goto share_extant_sb;
> >       // Assume P1 sleeps on bdev_lock or open_mutex
> >       // in blkdev_get_by_dev().
> >    -> setup_bdev_super()
> >    -> down_write(&sb->s_umount)
> > 
> > Now P2 jumps to the share_extant_sb label and calls:
> > 
> > grab_super(sb_p1)
> > -> spin_unlock(&sb_lock)
> > -> down_write(&s->s_umount)
> > 
> > Since s_umount is unlocked P2 doesn't go to sleep and instead immediately
> > goes to retry by jumping to the "retry" label. If P1 is still sleeping
> > on a a bdev mutex the same thing happens again.
> > 
> > So if you have a range of processes P{1,n} that all try to mount the
> > same device you're hammering endlessly on sb_lock without ever going to
> > sleep like we used to. The same problem exists for all iterate_supers()
> 
> That part is wrong. If you have P{1,n} and P1 takes s_umount exclusively
> then P{2,n} will sleep on s_umount until P1 is done. But there's still
> at least on process spinning through sget_fc() for no good reason.

No, you're right that the second process is going to effectively busyloop
waiting for SB_BORN to be set. I agree we should add some sleeping wait to
the loop to avoid pointlessly burning CPU cycles. I'll look into some
elegant solution tomorrow.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
