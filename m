Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B80077DB1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 09:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242412AbjHPH3X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 03:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242439AbjHPH3N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:29:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5C1198E
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 00:29:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C2656432E
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 07:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3759C433C8;
        Wed, 16 Aug 2023 07:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692170952;
        bh=eFOkavUZDo1Jfs0mQmhT21scZS+uOiuosjxa7Z22bzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jCDiNvQO4t7Xd1r+TpRNARtFo3QfqsPCz1wTl2q5nobFPgEaK+5MK29w7fUJWlUpA
         gjHGhYpnEzuJvjkqZlNjTgjZgzM1AguIdy55ElNG4LMla69GG4/lsQDXDh6zURLqBs
         GzbETMxwpXmNyCSWYkz2ZewMiyDKOpquf9CVAwfJ3Gjo7ge5hca2TOFi8+vVTYQ4Jm
         5sMdtTbmq1daY5vIx2FpBQYfLa4XXb6zs+9wOX8r2mQYbKwuphq3jwVXUBmxu4KQ0Z
         voOOzNcPGEp8H7oke5W6oDpgmXRsKbMQ+J9vaEAqKBfbBLv0DeS399T7vpwN4qGU+c
         DlLNIR4iTR3uA==
Date:   Wed, 16 Aug 2023 09:29:08 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, jack@suse.cz
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: open the block device after allocation the
 super_block
Message-ID: <20230816-anlangt-trimmen-5fa7744a954f@brauner>
References: <20230724175145.201318-1-hch@lst.de>
 <20230815-zeitdokument-quintessenz-7b75f29456a7@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230815-zeitdokument-quintessenz-7b75f29456a7@brauner>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 15, 2023 at 04:43:12PM +0200, Christian Brauner wrote:
> >  		up_write(&s->s_umount);
> > -		blkdev_put(bdev, fs_type);
> > +		error = setup_bdev_super(s, flags, NULL);
> >  		down_write(&s->s_umount);
> 
> So I've been looking through the branches to see what's ready for v6.6
> and what needs some more time. While doing so I went over this again and
> realized that we have an issue here.
> 
> While it looks like dropping s_umount here and calling
> setup_bdev_super() is fine I think it isn't. Consider two processes
> racing to create the same mount:
> 
> P1                                                                    P2
> vfs_get_tree()                                                        vfs_get_tree()
> -> get_tree() == get_tree_bdev()                                      -> get_tree() == get_tree_bdev()
>    -> sget_fc()                                                          -> sget_fc()
>         // allocate new sb; no matching sb found
>       -> sb_p1 = alloc_super()
>       -> hlist_add_head(&s->s_instances, &s->s_type->fs_supers)
>       -> spin_unlock(&sb_lock)                                              
>       // yield s_umount to avoid deadlocks
>    -> up_write(&sb->s_umount)
>                                                                             -> spin_lock(&sb_lock)
>                                                                                // find sb_p1
>                                                                                if (test(old, fc))
>                                                                                        goto share_extant_sb;
>       // Assume P1 sleeps on bdev_lock or open_mutex
>       // in blkdev_get_by_dev().
>    -> setup_bdev_super()
>    -> down_write(&sb->s_umount)
> 
> Now P2 jumps to the share_extant_sb label and calls:
> 
> grab_super(sb_p1)
> -> spin_unlock(&sb_lock)
> -> down_write(&s->s_umount)
> 
> Since s_umount is unlocked P2 doesn't go to sleep and instead immediately
> goes to retry by jumping to the "retry" label. If P1 is still sleeping
> on a a bdev mutex the same thing happens again.
> 
> So if you have a range of processes P{1,n} that all try to mount the
> same device you're hammering endlessly on sb_lock without ever going to
> sleep like we used to. The same problem exists for all iterate_supers()

That part is wrong. If you have P{1,n} and P1 takes s_umount exclusively
then P{2,n} will sleep on s_umount until P1 is done. But there's still
at least on process spinning through sget_fc() for no good reason.
