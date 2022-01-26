Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5658749C7C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 11:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbiAZKof (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 05:44:35 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54354 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiAZKof (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:44:35 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 094F51F396;
        Wed, 26 Jan 2022 10:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643193874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Q5dZ//HYXDnNIVJOX5sjUjMG4tNaPRa/xw3o6RRzKE=;
        b=xrtdFKdfg5iBiQK7OghcTR3sxdqdTsmbRrWfO/iM9s1Thw3ytI0q6MgPlo0lUvVSvXX0HX
        8KQizyGTj93dGbITmriUI3Zj59wWsadc9sA6SDu6zGb9GqyZ9Zlr2NOeGxNRwB3GVLnYJT
        U4/2uUo9z+zOLfnpxtdtPgHsgsqwswU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643193874;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Q5dZ//HYXDnNIVJOX5sjUjMG4tNaPRa/xw3o6RRzKE=;
        b=Ic8mljeZIoNbNMdHPxLJdkcUmMsW1/JL3S2MQ8Ix33IZIFEQEe1L1PL7VNJGfE9gszB2/A
        vrAlh9YBtT6ppTDw==
Received: from quack3.suse.cz (jack.udp.ovpn2.nue.suse.de [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EA8A1A3B8C;
        Wed, 26 Jan 2022 10:44:33 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A4F9DA05E6; Wed, 26 Jan 2022 11:44:33 +0100 (CET)
Date:   Wed, 26 Jan 2022 11:44:33 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.com
Subject: Re: [PATCH 2/4] vfs: make sync_filesystem return errors from
 ->sync_fs
Message-ID: <20220126104433.v7in47366v7mun6x@quack3.lan>
References: <164316348940.2600168.17153575889519271710.stgit@magnolia>
 <164316350055.2600168.13687764982467881652.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164316350055.2600168.13687764982467881652.stgit@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 25-01-22 18:18:20, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Strangely, sync_filesystem ignores the return code from the ->sync_fs
> call, which means that syscalls like syncfs(2) never see the error.
> This doesn't seem right, so fix that.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/sync.c |   18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> 
> diff --git a/fs/sync.c b/fs/sync.c
> index 3ce8e2137f31..c7690016453e 100644
> --- a/fs/sync.c
> +++ b/fs/sync.c
> @@ -29,7 +29,7 @@
>   */
>  int sync_filesystem(struct super_block *sb)
>  {
> -	int ret;
> +	int ret = 0;
>  
>  	/*
>  	 * We need to be protected against the filesystem going from
> @@ -52,15 +52,21 @@ int sync_filesystem(struct super_block *sb)
>  	 * at a time.
>  	 */
>  	writeback_inodes_sb(sb, WB_REASON_SYNC);
> -	if (sb->s_op->sync_fs)
> -		sb->s_op->sync_fs(sb, 0);
> +	if (sb->s_op->sync_fs) {
> +		ret = sb->s_op->sync_fs(sb, 0);
> +		if (ret)
> +			return ret;
> +	}
>  	ret = sync_blockdev_nowait(sb->s_bdev);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	sync_inodes_sb(sb);
> -	if (sb->s_op->sync_fs)
> -		sb->s_op->sync_fs(sb, 1);
> +	if (sb->s_op->sync_fs) {
> +		ret = sb->s_op->sync_fs(sb, 1);
> +		if (ret)
> +			return ret;
> +	}
>  	return sync_blockdev(sb->s_bdev);
>  }
>  EXPORT_SYMBOL(sync_filesystem);
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
