Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09152761871
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 14:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjGYMfU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 08:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjGYMfS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:35:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06203172E
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 05:35:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9114B6153D
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 12:35:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B26C433C8;
        Tue, 25 Jul 2023 12:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690288517;
        bh=iKohLfAs6pZ6Z4tqygkzEaqg/hc/tQGPhndURUgjUTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oDQnMgKansrnJ0VwZGid9wJtGEA+Umb3N2A5H0gk5wDPORRPW5NjjIqQLq7MJVgMq
         /z5964JYgW4/BqMHubHXSFrTY8413M5b7E/gwgoPZqfl2i/6cqzkK7nPnA9o4gHfqk
         NehZwz7Gm8k5znWjv6VxoVzu2wGX1EOOxvm7ASUu/zQfh9cmQQ9f8dW4y5B6hN1DGx
         cohFHVtRClDpVF6BZUVOvtB962DzGYccwH4p/NKU+ZrlIXNgFS8q59TFZE9/HWR3ma
         Vyvqvk+pUJ4m2IIkwEoNoXm3O/M73oUNZhcSRllqUxvpdctkryfhg65YLDFnlcQP4/
         hO6sLo7IHAtdA==
Date:   Tue, 25 Jul 2023 14:35:12 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     viro@zeniv.linux.org.uk, jack@suse.cz,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: open the block device after allocation the
 super_block
Message-ID: <20230725-tagebuch-gerede-a28f8fd8084a@brauner>
References: <20230724175145.201318-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230724175145.201318-1-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 24, 2023 at 10:51:45AM -0700, Christoph Hellwig wrote:
> From: Jan Kara <jack@suse.cz>
> 
> Currently get_tree_bdev and mount_bdev open the block device before
> commiting to allocating a super block.  This means the block device
> is opened even for bind mounts and other reuses of the super_block.
> 
> That creates problems for restricting the number of writers to a device,
> and also leads to a unusual and not very helpful holder (the fs_type).
> 
> Reorganize the mount code to first look whether the superblock for a
> particular device is already mounted and open the block device only if
> it is not.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> [hch: port to before the bdev_handle changes,
>       duplicate the bdev read-only check from blkdev_get_by_path,
>       extend the fsfree_mutex coverage to protect against freezes,
>       fix an open bdev leak when the bdev is frozen,
>       use the bdev local variable more,
>       rename the s variable to sb to be more descriptive]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> 
> So I promised to get a series that builds on top of this ready, but
> I'm way to busy and this will take a while.  Getting this reworked
> version of Jan's patch out for everyone to use it as a based given
> that Christian is back from vacation, and I think Jan should be about
> back now as well.

I'm in the middle of reviewing this. You're probably aware, but both
btrfs and nilfs at least still open the devices first since they
open-code their bdev and sb handling.
