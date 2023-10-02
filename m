Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507C77B4C49
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 09:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235641AbjJBHKn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 03:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbjJBHKn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:10:43 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CAFBC
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 00:10:40 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3198168C7B; Mon,  2 Oct 2023 09:10:37 +0200 (CEST)
Date:   Mon, 2 Oct 2023 09:10:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH 3/7] bdev: implement freeze and thaw holder operations
Message-ID: <20231002071036.GD2068@lst.de>
References: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org> <20230927-vfs-super-freeze-v1-3-ecc36d9ab4d9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927-vfs-super-freeze-v1-3-ecc36d9ab4d9@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  
> +static struct super_block *get_bdev_super(const struct block_device *bdev)
> +{
> +	struct super_block *sb_bdev = bdev->bd_holder, *sb = NULL;
> +
> +	if (!sb_bdev)
> +		return NULL;
> +	if (super_lock_excl(sb_bdev) && atomic_inc_not_zero(&sb_bdev->s_active))
> +		sb = sb_bdev;
> +	super_unlock_excl(sb_bdev);
> +	return sb;

I find the flow here a bit confusing, because to me sb_bdev implies
the super_block of the bdev fs, and because the super_lock_excl calling
convention that always locks no matter of the return value is very
confusing.  Maybe at least rename sb_bdev to holder_bdev?

> +static int fs_bdev_freeze(struct block_device *bdev)
> +	__releases(&bdev->bd_holder_lock)
> +{
> +	struct super_block *sb;
> +	int error = 0;
> +
> +	lockdep_assert_held(&bdev->bd_holder_lock);
> +
> +	sb = get_bdev_super(bdev);
> +	if (sb) {

We always have a sb in bdev->bd_holder.  So the only way get_bdev_super
could return NULL is if we can't get an active reference or the fs is
marked as SB_DYING.  I think the best is to just give up and not even
bother with the sync, which is going to cause more problems than it
could help.  I think we're better off just straight returning an
error here, and don't bother with the sync_blockdev.
