Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9B548D630
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 11:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbiAMK6E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 05:58:04 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43218 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbiAMK6C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:58:02 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 40CE71F3BC;
        Thu, 13 Jan 2022 10:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642071481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jG2YBmKxjGm7yo2Ve7nOVVYEHMKVyhyJf6tIbfNxbRM=;
        b=xaEBgzRALckvYaXQWmg0Sp787ke7YPnqaZ2GgC2sp/walSexq0QHRNs0E/6sHmlx5xKelc
        NJwoBZHbGMGjjvn8yqZOEkz6Pm7YPZEjkL2e9/TdOBj4pSVS0ClGKRovoBa2m4Ju5FEeJj
        NP9UcuF/PnucO4i6INRvlydh1kAC4tI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642071481;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jG2YBmKxjGm7yo2Ve7nOVVYEHMKVyhyJf6tIbfNxbRM=;
        b=Cgjr6zCU/nrJzGkMdXvSwhSSk8ftcCjcJRB60rbuIKLIGSNQnZ08zAVL9Migzjyi+z7MMB
        z2RbVJL13CZSbVAw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2F9F6A3B83;
        Thu, 13 Jan 2022 10:58:01 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CCCB2A05E2; Thu, 13 Jan 2022 11:58:00 +0100 (CET)
Date:   Thu, 13 Jan 2022 11:58:00 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, tytso@mit.edu,
        Eric Whitney <enwlinux@gmail.com>
Subject: Re: [PATCH 2/6] ext4: Remove redundant max inline_size check in
 ext4_da_write_inline_data_begin()
Message-ID: <20220113105800.onazeyrdh3mr2bjw@quack3.lan>
References: <cover.1642044249.git.riteshh@linux.ibm.com>
 <fc7f7b3ad709da48c49ab14a2ce86e00a7defe0e.1642044249.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc7f7b3ad709da48c49ab14a2ce86e00a7defe0e.1642044249.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 13-01-22 08:56:25, Ritesh Harjani wrote:
> ext4_prepare_inline_data() already checks for ext4_get_max_inline_size()
> and returns -ENOSPC. So there is no need to check it twice within
> ext4_da_write_inline_data_begin(). This patch removes the extra check.
> 
> It also makes it more clean.
> 
> No functionality change in this patch.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inline.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 31741e8a462e..c52b0037983d 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -913,7 +913,7 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
>  				    struct page **pagep,
>  				    void **fsdata)
>  {
> -	int ret, inline_size;
> +	int ret;
>  	handle_t *handle;
>  	struct page *page;
>  	struct ext4_iloc iloc;
> @@ -930,14 +930,9 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
>  		goto out;
>  	}
>  
> -	inline_size = ext4_get_max_inline_size(inode);
> -
> -	ret = -ENOSPC;
> -	if (inline_size >= pos + len) {
> -		ret = ext4_prepare_inline_data(handle, inode, pos + len);
> -		if (ret && ret != -ENOSPC)
> -			goto out_journal;
> -	}
> +	ret = ext4_prepare_inline_data(handle, inode, pos + len);
> +	if (ret && ret != -ENOSPC)
> +		goto out_journal;
>  
>  	/*
>  	 * We cannot recurse into the filesystem as the transaction
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
