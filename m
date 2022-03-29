Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8774EAB0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 12:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbiC2KMU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 06:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbiC2KMT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:12:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1A01D306F;
        Tue, 29 Mar 2022 03:10:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD52861175;
        Tue, 29 Mar 2022 10:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2D3C340ED;
        Tue, 29 Mar 2022 10:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648548636;
        bh=8ZB4+m0cBb+PTExehPxjGEI3iJeJ4mAnnHPkbw/jvwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U9qjZpg6nVAqS5Iia7V+3i8K/l7l9nfjLudOSkoc43Mmd6255oMwf1CISxfJ0ImRO
         FnJaf1EQb7CykLHvJYmjzRPVK9yw0r+y1EMh/qDDKHDCxCyo0UBHQAzlIue5oGp/b1
         pUwrA3u4/+QuEVD+KBtLjuE7BA7UnELyHQ1rmrqwY1LpDWvRAqTxsQVaMbSNP7Te5G
         WdbXIgbIlQofpO6EYANW1MMwpDf4pD2s15FXhZxPvHmxxRmR182zxAl7/fgaFOWk41
         VSiVI7dJzx0Is2RY+abyhNKl/r7C+tZEKFwqpTlPeJJkbGwX4RxSyLP0lmbuULGVMv
         cfm6UZktD4lKQ==
Date:   Tue, 29 Mar 2022 11:10:33 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        david@fromorbit.com
Subject: Re: [PATCH v4 3/3] btrfs: assert that relocation is protected with
 sb_start_write()
Message-ID: <YkLbGYSbJg5Gkl2Q@debian9.Home>
References: <cover.1648535838.git.naohiro.aota@wdc.com>
 <28e3e02ed14fe7c0859707e1a10a447fe4338c16.1648535838.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28e3e02ed14fe7c0859707e1a10a447fe4338c16.1648535838.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 29, 2022 at 03:56:00PM +0900, Naohiro Aota wrote:
> Relocation of a data block group creates ordered extents. They can cause a
> hang when a process is trying to thaw the filesystem.
> 
> We should have called sb_start_write(), so the filesystem is not being
> frozen. Add an ASSERT to check it is protected.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/relocation.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index fdc2c4b411f0..5e52cd8d5f23 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -3977,6 +3977,16 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
>  	if (!bg)
>  		return -ENOENT;
>  
> +	/*
> +	 * Relocation of a data block group creates ordered extents.
> +	 * Without sb_start_write(), we can freeze the FS while unfinished
> +	 * ordered extents are left. Such ordered extents can cause a
> +	 * deadlock e.g, when syncfs() is trying to finish them because

syncfs() is not trying to finish them, it's waiting for them to complete.

> +	 * they never finish as the FS is already frozen.

More specifically they can't finish because they block when joining a transaction,
due to the fact that the freeze locks are being held in write mode.

Anyway, I won't make you send yet another version. Perhaps this is something
David can fixup when he picks the patch.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +	 */
> +	if (bg->flags & BTRFS_BLOCK_GROUP_DATA)
> +		ASSERT(sb_write_started(fs_info->sb));
> +
>  	if (btrfs_pinned_by_swapfile(fs_info, bg)) {
>  		btrfs_put_block_group(bg);
>  		return -ETXTBSY;
> -- 
> 2.35.1
> 
