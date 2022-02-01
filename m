Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF09C4A5B46
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 12:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237314AbiBALf2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 06:35:28 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51338 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiBALf1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:35:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 435DA1F3A8;
        Tue,  1 Feb 2022 11:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643715326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XaHYGKnPlshI0xq0ASa1KeubArxIZ9QCeCveD3KHOaI=;
        b=YcRBvfz9W4kCDWD4/eElAPTTzZBP7OjB3XTrjD4eWwCu1XBQN+/UfaHqvXro2YWwiQzj1a
        TxSr72wYhcW8olJCM8gUHjOZfWEWgyc0BTFBymQQOWd0D9hlShYupJnejDIaUS/7bWJaqm
        tPb718CVnXqKsx6xrl9M53+2qqGeqq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643715326;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XaHYGKnPlshI0xq0ASa1KeubArxIZ9QCeCveD3KHOaI=;
        b=32l+V6dHUtGRrzIHGc1n7ukMm/ZlQrXgchfclxFz3KuZTfbZw5MoDTRhLPCcTz6yTB92Ui
        LelpeQhjMfTxyeDw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 25EB6A3B84;
        Tue,  1 Feb 2022 11:35:26 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 56262A05B1; Tue,  1 Feb 2022 12:35:25 +0100 (CET)
Date:   Tue, 1 Feb 2022 12:35:25 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [RFC 3/6] ext4: Use in_range() for range checking in
 ext4_fc_replay_check_excluded
Message-ID: <20220201113525.dwgdblhb4wb75ugv@quack3.lan>
References: <cover.1643642105.git.riteshh@linux.ibm.com>
 <54467b596f803bbaa9e76ed028011a36a522fe70.1643642105.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54467b596f803bbaa9e76ed028011a36a522fe70.1643642105.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 31-01-22 20:46:52, Ritesh Harjani wrote:
> Instead of open coding it, use in_range() function instead.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/fast_commit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 5934c23e153e..bd6a47d18716 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1874,8 +1874,8 @@ bool ext4_fc_replay_check_excluded(struct super_block *sb, ext4_fsblk_t blk)
>  		if (state->fc_regions[i].ino == 0 ||
>  			state->fc_regions[i].len == 0)
>  			continue;
> -		if (blk >= state->fc_regions[i].pblk &&
> -		    blk < state->fc_regions[i].pblk + state->fc_regions[i].len)
> +		if (in_range(blk, state->fc_regions[i].pblk,
> +					state->fc_regions[i].len))
>  			return true;
>  	}
>  	return false;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
