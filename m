Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32073E11B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 11:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239937AbhHEJ4e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 05:56:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57638 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbhHEJ4e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 05:56:34 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0F6971FE42;
        Thu,  5 Aug 2021 09:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628157379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gfY4K5+0+7vBrDy12tOrfA0yGsug6efsrXkibuaP9XI=;
        b=JXs0cuhMxm04010Ez7oiVyiCph0E6fkmVywfD0VoCTkiTRA/YAbvcDTE5y9EgOsxQ+kBEZ
        J/3yBu1Cxh6pE/CVUF73KLqUbbLJddXAgGdnIbr+hs/Pa/jRALH+0Q7+P5NXf4lTIz7L1e
        1smJeMD2RRsGBcpkd23tR7TZtDnG10M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628157379;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gfY4K5+0+7vBrDy12tOrfA0yGsug6efsrXkibuaP9XI=;
        b=1ATS2f59ObC+xHetWqfLT8aEi+uTOKZapPrHYShJAxRX9Dv5JperNSmbGCAFaIHIzX5pTP
        N0Ju1Vct6EjUlcDw==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id E4317A3B94;
        Thu,  5 Aug 2021 09:56:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BB2A41E1511; Thu,  5 Aug 2021 11:56:18 +0200 (CEST)
Date:   Thu, 5 Aug 2021 11:56:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v5 14/23] fanotify: Encode invalid file handler when no
 inode is provided
Message-ID: <20210805095618.GF14483@quack2.suse.cz>
References: <20210804160612.3575505-1-krisman@collabora.com>
 <20210804160612.3575505-15-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804160612.3575505-15-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 04-08-21 12:06:03, Gabriel Krisman Bertazi wrote:
> Instead of failing, encode an invalid file handler in fanotify_encode_fh
> if no inode is provided.  This bogus file handler will be reported by
> FAN_FS_ERROR for non-inode errors.
> 
> Also adjust the single caller that might rely on failure after passing
> an empty inode.

It is not 'file handler' but rather 'file handle' - several times in the
changelog and in subject :).

> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/notify/fanotify/fanotify.c | 39 ++++++++++++++++++++---------------
>  fs/notify/fanotify/fanotify.h |  6 ++++--
>  2 files changed, 26 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 0d6ba218bc01..456c60107d88 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -349,12 +349,6 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
>  	void *buf = fh->buf;
>  	int err;
>  
> -	fh->type = FILEID_ROOT;
> -	fh->len = 0;
> -	fh->flags = 0;
> -	if (!inode)
> -		return 0;
> -

I'd keep the fh->flags initialization here. Otherwise it will not be
initialized on some error returns.

> @@ -363,8 +357,9 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
>  	if (fh_len < 4 || WARN_ON_ONCE(fh_len % 4))
>  		goto out_err;
>  
> -	/* No external buffer in a variable size allocated fh */
> -	if (gfp && fh_len > FANOTIFY_INLINE_FH_LEN) {
> +	fh->flags = 0;
> +	/* No external buffer in a variable size allocated fh or null fh */
> +	if (inode && gfp && fh_len > FANOTIFY_INLINE_FH_LEN) {
>  		/* Treat failure to allocate fh as failure to encode fh */
>  		err = -ENOMEM;
>  		ext_buf = kmalloc(fh_len, gfp);
> @@ -376,14 +371,24 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
>  		fh->flags |= FANOTIFY_FH_FLAG_EXT_BUF;
>  	}
>  
> -	dwords = fh_len >> 2;
> -	type = exportfs_encode_inode_fh(inode, buf, &dwords, NULL);
> -	err = -EINVAL;
> -	if (!type || type == FILEID_INVALID || fh_len != dwords << 2)
> -		goto out_err;
> -
> -	fh->type = type;
> -	fh->len = fh_len;
> +	if (inode) {
> +		dwords = fh_len >> 2;
> +		type = exportfs_encode_inode_fh(inode, buf, &dwords, NULL);
> +		err = -EINVAL;
> +		if (!type || type == FILEID_INVALID || fh_len != dwords << 2)
> +			goto out_err;
> +		fh->type = type;
> +		fh->len = fh_len;
> +	} else {
> +		/*
> +		 * Invalid FHs are used on FAN_FS_ERROR for errors not
> +		 * linked to any inode. Caller needs to guarantee the fh
> +		 * has at least FANOTIFY_NULL_FH_LEN bytes of space.
> +		 */
> +		fh->type = FILEID_INVALID;
> +		fh->len = FANOTIFY_NULL_FH_LEN;
> +		memset(buf, 0, FANOTIFY_NULL_FH_LEN);
> +	}

Maybe it will become clearer later during the series but why do you set
fh->len to FANOTIFY_NULL_FH_LEN and not 0?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
