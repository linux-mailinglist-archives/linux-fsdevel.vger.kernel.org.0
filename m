Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1773349A1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 20:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhCYTWV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 15:22:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhCYTVv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:21:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9489761A2D;
        Thu, 25 Mar 2021 19:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616700110;
        bh=ziH8ogtlFgf/xOHmwTBESqJ99TGlQQhBRPL/aLU87cA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JAY+5fXqPKWwLnTbdHOAB5nICVjmbMd7AjyjWXvTU4tNS/swPQ6ClAN8NLqu8kd9p
         tj9bu2iwzf1ywkBkoD927nDvdNKKkPrmNWZj0C6C1xwxHmL7D+mwYB0ZaPunZoQ4Hr
         yOY4L40EcGNjhEsI7IyEMsRff/IMO5Y3hyu1OIut1c+z+eVARbNiSlpkzoH9zcQlPu
         8VgxPP2Edk36MNkXi9Jc2OkrJE9a88C7Gi10v5/34VRIKGAyHBTvhMWIP5aseHvs/R
         IaGa0JdlI8sfo4keKEIDwa0wy9XaBlraoNckKUN3lDQKZLiB9AKTjtlyAileb0DbIC
         RkQZRhcn0It/g==
Date:   Thu, 25 Mar 2021 12:21:49 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, krisman@collabora.com, drosen@google.com,
        yuchao0@huawei.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
Subject: Re: [PATCH v4 2/5] fs: Check if utf8 encoding is loaded before
 calling utf8_unload()
Message-ID: <YFziza/VMyzEs4s1@sol.localdomain>
References: <20210325000811.1379641-1-shreeya.patel@collabora.com>
 <20210325000811.1379641-3-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325000811.1379641-3-shreeya.patel@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 25, 2021 at 05:38:08AM +0530, Shreeya Patel wrote:
> utf8_unload is being called if CONFIG_UNICODE is enabled.
> The ifdef block doesn't check if utf8 encoding has been loaded
> or not before calling the utf8_unload() function.
> This is not the expected behavior since it would sometimes lead
> to unloading utf8 even before loading it.
> Hence, add a condition which will check if sb->encoding is NOT NULL
> before calling the utf8_unload().
> 
> Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
>  fs/ext4/super.c | 6 ++++--
>  fs/f2fs/super.c | 9 ++++++---
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index ad34a37278cd..e438d14f9a87 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1259,7 +1259,8 @@ static void ext4_put_super(struct super_block *sb)
>  	fs_put_dax(sbi->s_daxdev);
>  	fscrypt_free_dummy_policy(&sbi->s_dummy_enc_policy);
>  #ifdef CONFIG_UNICODE
> -	utf8_unload(sb->s_encoding);
> +	if (sb->s_encoding)
> +		utf8_unload(sb->s_encoding);
>  #endif
>  	kfree(sbi);
>  }


What's the benefit of this change?  utf8_unload is a no-op when passed a NULL
pointer; why not keep it that way?

- Eric
