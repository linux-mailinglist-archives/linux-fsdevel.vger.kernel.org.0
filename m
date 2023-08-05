Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AE27710CD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Aug 2023 19:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjHERNY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Aug 2023 13:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHERNW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:13:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE15E6E;
        Sat,  5 Aug 2023 10:13:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C46B560C5F;
        Sat,  5 Aug 2023 17:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48498C433C8;
        Sat,  5 Aug 2023 17:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691255600;
        bh=ZfbjUjtwjQ3RdoKZ4m9be+A3vKSXVdCSc1xlaCOCYaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GPg8Jk0hmq/xHabhON9f9Wy4e6exu8iJEYNopK5zDw8GmrFoQGT2DAXxd87LbWap8
         4/d+lARj/a+CAYc0aXP8vt0XyFD50NbrypchRRdrvRVesi8hQ5+cEJMlEIBNxUxc+d
         ju3eCdqdVSpgSL9LURl8ByQA2GFWm47ugH4yf4iithQ0PhmracdrwHb7oSvfUhq7Ai
         nCDi4+LRW1PkLg70nBcnYsgykVajnsxEbLJ7zF6Rc6eY3wzAXbqT8zx3H+lqrTWMP6
         IHpiobC/SI7B85Kpm8M7ejKRDRklWb6ijfPX4OnHfxRBF3MQG4f0ma58crs+q7UJ0a
         TmEspZ09z2ylw==
Date:   Sat, 5 Aug 2023 19:13:13 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 11/12] xfs: drop s_umount over opening the log and RT
 devices
Message-ID: <20230805-langzeitfolgen-notation-dfd8a0175060@brauner>
References: <20230802154131.2221419-1-hch@lst.de>
 <20230802154131.2221419-12-hch@lst.de>
 <20230802163219.GW11352@frogsfrogsfrogs>
 <20230805083239.GA29780@lst.de>
 <20230805161904.GM11377@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230805161904.GM11377@frogsfrogsfrogs>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 05, 2023 at 09:19:04AM -0700, Darrick J. Wong wrote:
> On Sat, Aug 05, 2023 at 10:32:39AM +0200, Christoph Hellwig wrote:
> > On Wed, Aug 02, 2023 at 09:32:19AM -0700, Darrick J. Wong wrote:
> > > > +	/* see get_tree_bdev why this is needed and safe */
> > > 
> > > Which part of get_tree_bdev?  Is it this?
> > > 
> > > 		/*
> > > 		 * s_umount nests inside open_mutex during
> > > 		 * __invalidate_device().  blkdev_put() acquires
> > > 		 * open_mutex and can't be called under s_umount.  Drop
> > > 		 * s_umount temporarily.  This is safe as we're
> > > 		 * holding an active reference.
> > > 		 */
> > > 		up_write(&s->s_umount);
> > > 		blkdev_put(bdev, fc->fs_type);
> > > 		down_write(&s->s_umount);
> > 
> > Yes.  With the refactoring earlier in the series get_tree_bdev should
> > be trivial enough to not need a more specific reference.  If you
> > think there's a better way to refer to it I can update the comment,
> > though.
> 
> How about:
> 
> 	/*
> 	 * blkdev_put can't be called under s_umount, see the comment in
> 	 * get_tree_bdev for more details
> 	 */
> 
> with that and the label name change,
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Added that comment and you rvb in-tree.
