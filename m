Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C95F77CE58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 16:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbjHOOnp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 10:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235534AbjHOOnN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:43:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7ADC5
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 07:43:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0837964954
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 14:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A30C433C7;
        Tue, 15 Aug 2023 14:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692110591;
        bh=mkQSyf5DnXlFNVatWeAHjaJ4Px+vNnPbZ4Pgg79A708=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wp2BZ8ymPb+J4+a/dCSSIBhlIGY29h9nPoibG4laFRdChW2+UUs2oc4xE3LQzikjE
         ZBo5Vnl+XOZzCMr6OuQadLp3qpIqb8/RM7DD1CzSS/k4voyzH0DQS5jvpAeMir/2AC
         Hjkx4jF/UxIHNbUjnvDOv6z3mnCIjXa+zam5q4nqNFdiSM3WbaX0YV/LC6bfQqtq1z
         /7ZR583iGc1NEB6qt+5nOI6d4ymxQ3VwUUM2gqyfqAyyWCHDYE01BH4ZlRfd6TvtFF
         XQKbnR0+JOQtj5R6lzqJMoFeMo5TtwzaNj0hWttvc1Vg6px5en+cpCduLzS0JkfIKU
         JUBN0jsp6+Ovg==
Date:   Tue, 15 Aug 2023 16:43:07 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, jack@suse.cz
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: open the block device after allocation the
 super_block
Message-ID: <20230815-zeitdokument-quintessenz-7b75f29456a7@brauner>
References: <20230724175145.201318-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230724175145.201318-1-hch@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  		up_write(&s->s_umount);
> -		blkdev_put(bdev, fs_type);
> +		error = setup_bdev_super(s, flags, NULL);
>  		down_write(&s->s_umount);

So I've been looking through the branches to see what's ready for v6.6
and what needs some more time. While doing so I went over this again and
realized that we have an issue here.

While it looks like dropping s_umount here and calling
setup_bdev_super() is fine I think it isn't. Consider two processes
racing to create the same mount:

P1                                                                    P2
vfs_get_tree()                                                        vfs_get_tree()
-> get_tree() == get_tree_bdev()                                      -> get_tree() == get_tree_bdev()
   -> sget_fc()                                                          -> sget_fc()
        // allocate new sb; no matching sb found
      -> sb_p1 = alloc_super()
      -> hlist_add_head(&s->s_instances, &s->s_type->fs_supers)
      -> spin_unlock(&sb_lock)                                              
      // yield s_umount to avoid deadlocks
   -> up_write(&sb->s_umount)
                                                                            -> spin_lock(&sb_lock)
                                                                               // find sb_p1
                                                                               if (test(old, fc))
                                                                                       goto share_extant_sb;
      // Assume P1 sleeps on bdev_lock or open_mutex
      // in blkdev_get_by_dev().
   -> setup_bdev_super()
   -> down_write(&sb->s_umount)

Now P2 jumps to the share_extant_sb label and calls:

grab_super(sb_p1)
-> spin_unlock(&sb_lock)
-> down_write(&s->s_umount)

Since s_umount is unlocked P2 doesn't go to sleep and instead immediately
goes to retry by jumping to the "retry" label. If P1 is still sleeping
on a a bdev mutex the same thing happens again.

So if you have a range of processes P{1,n} that all try to mount the
same device you're hammering endlessly on sb_lock without ever going to
sleep like we used to. The same problem exists for all iterate_supers()
and user_get_dev() variants afaict. So that needs fixing unless I'm
wrong. grab_super() and other variants need to sleep until
setup_bdev_super() is done and not busy loop. Am I wrong here?
