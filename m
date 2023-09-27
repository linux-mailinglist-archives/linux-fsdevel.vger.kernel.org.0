Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75E77B07FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 17:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjI0PTP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 11:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbjI0PTN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:19:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54102126
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 08:19:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB738C433C8;
        Wed, 27 Sep 2023 15:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695827951;
        bh=tRY/Dx0dTF3kQNj6HII/AUgy/lIthijxZkeKwl0XorU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RkoAaH9RGVNNdtY2Az4+e6eEHtcoUduheLDeA9OuCnS2LWdtBFLTc2Qp0P6GP4WkT
         bc9Dlxk8Wl5HT50QebEs1XZdr+VqYhpJzNBPmPj4+9bu5O3zvAv+mef8pNa1EHNrMb
         HDpqtVWqrZdPO2o7UU9Lgz/OgJok0hw8tS2Cthxd4vdCFLDFpdfNF9hTg7YuAarJuT
         NCdPV1rOkmK6G4qblybUQSRyfy2R8odyuYmTGe0wCz6rb2iba6EZEuCD/3oLWFa1Q8
         Vhosj6xIe0xKW65nZVVgvUm4Nne6LNVCgsLP7knm2tPUVkbXCuvvhS8go6zJSBA5t1
         8/SMWgbtr7H7g==
Date:   Wed, 27 Sep 2023 08:19:11 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 7/7] porting: document block device freeze and thaw
 changes
Message-ID: <20230927151911.GG11414@frogsfrogsfrogs>
References: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org>
 <20230927-vfs-super-freeze-v1-7-ecc36d9ab4d9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927-vfs-super-freeze-v1-7-ecc36d9ab4d9@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 27, 2023 at 03:21:20PM +0200, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  Documentation/filesystems/porting.rst | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
> index 4d05b9862451..fef97a2e6729 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1045,3 +1045,28 @@ filesystem type is now moved to a later point when the devices are closed:
>  As this is a VFS level change it has no practical consequences for filesystems
>  other than that all of them must use one of the provided kill_litter_super(),
>  kill_anon_super(), or kill_block_super() helpers.
> +
> +---
> +
> +**mandatory**
> +
> +Block device freezing and thawing have been moved to holder operations. As we
> +can now go straight from block devcie to superblock the get_active_super()

s/devcie/device/

> +and bd_fsfreeze_sb members in struct block_device are gone.
> +
> +The bd_fsfreeze_mutex is gone as well since we can rely on the bd_holder_lock
> +to protect against concurrent freeze and thaw.
> +
> +Before this change, get_active_super() would only be able to find the
> +superblock of the main block device, i.e., the one stored in sb->s_bdev. Block
> +device freezing now works for any block device owned by a given superblock, not
> +just the main block device.

You might want to document this new fs_holder_ops scheme:

"Filesystems opening a block device must pass the super_block object
and fs_holder_ops as the @holder and @hops parameters."

Though TBH I see a surprising amount of fs code that doesn't do this, so
perhaps it's not so mandatory?

--D

> +
> +When thawing we now grab an active reference so we can hold bd_holder_lock
> +across thaw without the risk of deadlocks (because the superblock goes away
> +which would require us to take bd_holder_lock). That allows us to get rid of
> +bd_fsfreeze_mutex. Currently we just reacquire s_umount after thaw_super() and
> +drop the active reference we took before. This someone could grab an active
> +reference before we dropped the last one. This shouldn't be an issue. If it
> +turns out to be one we can reshuffle the code to simply hold s_umount when
> +thaw_super() returns and drop the reference.
> 
> -- 
> 2.34.1
> 
