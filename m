Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2F14D637A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 15:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349358AbiCKOeo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 09:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237268AbiCKOen (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:34:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F341C2F7E;
        Fri, 11 Mar 2022 06:33:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F155DB82A73;
        Fri, 11 Mar 2022 14:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FF1C340ED;
        Fri, 11 Mar 2022 14:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647009217;
        bh=XU8vvakF1HtioHO7n+bk6PC78L5B+0hUe4nIbxk1v9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m1qDfCbDJYfkv475CU/kv6jWL0Mh8htXOFjtkhm2qTQFyZ1A9MnhX3HLAddTFfakT
         heAAduzUEq0dZqfGtxZSBb077oX0Em5Ic9FJxwPeROZH3LcDzyoq5iD2ixnnU1Wd/G
         jWyHGAx1sATikwlewDK3GRGXXk0Tw/IgSzW80H1wb+VAeFU1J9AiLDAjBWIh2/zBsj
         BleKOeWN3OEeRx53YkNrQNuT4ClXpTLo0QwDl511tr59sRKCz+cK92vLEJ6IgSry79
         mMG7iv7kq8DEVXzWn6UcMchdR9upEDjplCxHWSZZm0IANPCkN8mayz/rQ3k9iYHe1u
         im5Yt84HknBNQ==
Date:   Fri, 11 Mar 2022 14:33:34 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        david@fromorbit.com
Subject: Re: [PATCH 4/4] btrfs: assert that relocation is protected with
 sb_start_write()
Message-ID: <YitdvtFdsFSLHRYd@debian9.Home>
References: <cover.1646983176.git.naohiro.aota@wdc.com>
 <697674ea626a3d04218b02dbb12e07bdd851d3f0.1646983176.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <697674ea626a3d04218b02dbb12e07bdd851d3f0.1646983176.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 11, 2022 at 04:38:05PM +0900, Naohiro Aota wrote:
> btrfs_relocate_chunk() initiates new ordered extents. They can cause a
> hang when a process is trying to thaw the filesystem.
> 
> We should have called sb_start_write(), so the filesystem is not being
> frozen. Add an ASSERT to check it is protected.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
>  fs/btrfs/volumes.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 0d27d8d35c7a..b558fd293ffa 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3239,6 +3239,9 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
>  	u64 length;
>  	int ret;
>  
> +	/* Assert we called sb_start_write(), not to race with FS freezing */
> +	ASSERT(sb_write_started(fs_info->sb));

Does this pass the scenario of patch 1/4 (resuming balance on mount)?

Because as commented in that patch, we have the sb_start_write() done
in the mount task, and not by the task that actually runs balance - the
balance kthread.

Anyway, this change looks good, my concerns are only about patch 1/4.

Thanks.

> +
>  	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
>  		btrfs_err(fs_info,
>  			  "relocate: not supported on extent tree v2 yet");
> -- 
> 2.35.1
> 
