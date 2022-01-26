Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606CF49C7C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 11:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbiAZKpF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 05:45:05 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54434 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiAZKpE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:45:04 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 97A031F393;
        Wed, 26 Jan 2022 10:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643193903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0bwIHvKMplEnJWvc6E0x0BnshcGyHdZHSvcnp1bgeyI=;
        b=xs+ldCQihqU3lsYDl6uxIF7kFdO07owhjDpEoGQwo1tk1/YS4uRQ3h+azO979TJHmfT4Ty
        3tWsXuMLJkoF8M3VQwXrYbeE+Ppd7rwGn6qesYecc/HL20aLToHe0gjrA9bLsXB72S0osA
        KzzzDJcuEGlxLjez4Sv7mRFUtC8QpmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643193903;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0bwIHvKMplEnJWvc6E0x0BnshcGyHdZHSvcnp1bgeyI=;
        b=gET7tLLxmXy+9QZNFI9tOM9HVIJ6GHKcGnkzW2jeCkybx4hNP8voWqpKJx1nh42E7x8w9e
        yCYF2WWvkCzQswDw==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 89883A3B83;
        Wed, 26 Jan 2022 10:45:03 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 27984A05E6; Wed, 26 Jan 2022 11:45:02 +0100 (CET)
Date:   Wed, 26 Jan 2022 11:45:02 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.com
Subject: Re: [PATCH 3/4] quota: make dquot_quota_sync return errors from
 ->sync_fs
Message-ID: <20220126104502.z76q2s2ylqgsjfdo@quack3.lan>
References: <164316348940.2600168.17153575889519271710.stgit@magnolia>
 <164316350602.2600168.17959517250738452981.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164316350602.2600168.17959517250738452981.stgit@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 25-01-22 18:18:26, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Strangely, dquot_quota_sync ignores the return code from the ->sync_fs
> call, which means that quotacalls like Q_SYNC never see the error.  This
> doesn't seem right, so fix that.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/quota/dquot.c |   11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 22d904bde6ab..a74aef99bd3d 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -690,9 +690,14 @@ int dquot_quota_sync(struct super_block *sb, int type)
>  	/* This is not very clever (and fast) but currently I don't know about
>  	 * any other simple way of getting quota data to disk and we must get
>  	 * them there for userspace to be visible... */
> -	if (sb->s_op->sync_fs)
> -		sb->s_op->sync_fs(sb, 1);
> -	sync_blockdev(sb->s_bdev);
> +	if (sb->s_op->sync_fs) {
> +		ret = sb->s_op->sync_fs(sb, 1);
> +		if (ret)
> +			return ret;
> +	}
> +	ret = sync_blockdev(sb->s_bdev);
> +	if (ret)
> +		return ret;
>  
>  	/*
>  	 * Now when everything is written we can discard the pagecache so
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
