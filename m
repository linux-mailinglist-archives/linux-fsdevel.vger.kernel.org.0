Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E14648D635
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 11:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbiAMK6X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 05:58:23 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38844 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiAMK6W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:58:22 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0A311218E0;
        Thu, 13 Jan 2022 10:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642071501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4IMrKA/PfkHfsGFZxrciKPudtLRXhqWq+CAnS18bQaQ=;
        b=J0k6Wqie5VsYuLq2hLH1VAjJl/JABbfxZlaZ+8KateT+rioarTdU5jIyNBeX4cXUF5ixnK
        5EuDSaJNz1is+H4E3l4AVb4ExP+f6RYWhk113JBe11xTAmyANwS2zJT6UlQ4RIQsujzpsw
        mSTH7pPrxjFtDBTridGGhG9C439P78U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642071501;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4IMrKA/PfkHfsGFZxrciKPudtLRXhqWq+CAnS18bQaQ=;
        b=31hqsRw1ks2eT47YNtpNs4mADtu6D3ewklxEZX+Alq3uy4kC1BPIUrDibvt9s6/dO0bKVb
        teBRK16Ra+57YABg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EF023A3B83;
        Thu, 13 Jan 2022 10:58:20 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AFF16A05E2; Thu, 13 Jan 2022 11:58:20 +0100 (CET)
Date:   Thu, 13 Jan 2022 11:58:20 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, tytso@mit.edu,
        Eric Whitney <enwlinux@gmail.com>
Subject: Re: [PATCH 1/6] ext4: Fix error handling in
 ext4_restore_inline_data()
Message-ID: <20220113105820.dzusr7ytt6ih3okw@quack3.lan>
References: <cover.1642044249.git.riteshh@linux.ibm.com>
 <e10d89e0184f47ccf9093f50276c2e188c19fd3f.1642044249.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e10d89e0184f47ccf9093f50276c2e188c19fd3f.1642044249.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 13-01-22 08:56:24, Ritesh Harjani wrote:
> While running "./check -I 200 generic/475" it sometimes gives below
> kernel BUG(). Ideally we should not call ext4_write_inline_data() if
> ext4_create_inline_data() has failed.
> 
> <log snip>
> [73131.453234] kernel BUG at fs/ext4/inline.c:223!
> 
> <code snip>
>  212 static void ext4_write_inline_data(struct inode *inode, struct ext4_iloc *iloc,
>  213                                    void *buffer, loff_t pos, unsigned int len)
>  214 {
> <...>
>  223         BUG_ON(!EXT4_I(inode)->i_inline_off);
>  224         BUG_ON(pos + len > EXT4_I(inode)->i_inline_size);
> 
> This patch handles the error and prints out a emergency msg saying potential
> data loss for the given inode (since we couldn't restore the original
> inline_data due to some previous error).
> 
> [ 9571.070313] EXT4-fs (dm-0): error restoring inline_data for inode -- potential data loss! (inode 1703982, error -30)
> 
> Reported-by: Eric Whitney <enwlinux@gmail.com>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Makes sence. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inline.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 534c0329e110..31741e8a462e 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -1135,7 +1135,15 @@ static void ext4_restore_inline_data(handle_t *handle, struct inode *inode,
>  				     struct ext4_iloc *iloc,
>  				     void *buf, int inline_size)
>  {
> -	ext4_create_inline_data(handle, inode, inline_size);
> +	int ret;
> +
> +	ret = ext4_create_inline_data(handle, inode, inline_size);
> +	if (ret) {
> +		ext4_msg(inode->i_sb, KERN_EMERG,
> +			"error restoring inline_data for inode -- potential data loss! (inode %lu, error %d)",
> +			inode->i_ino, ret);
> +		return;
> +	}
>  	ext4_write_inline_data(inode, iloc, buf, 0, inline_size);
>  	ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
>  }
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
