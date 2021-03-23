Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA7F34689D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 20:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhCWTLF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 15:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbhCWTKp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 15:10:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C6BC061574;
        Tue, 23 Mar 2021 12:10:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id EA0A21F455E1
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, ebiggers@google.com, drosen@google.com,
        ebiggers@kernel.org, yuchao0@huawei.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
Subject: Re: [PATCH v3 2/5] fs: Check if utf8 encoding is loaded before
 calling utf8_unload()
Organization: Collabora
References: <20210323183201.812944-1-shreeya.patel@collabora.com>
        <20210323183201.812944-3-shreeya.patel@collabora.com>
Date:   Tue, 23 Mar 2021 15:10:40 -0400
In-Reply-To: <20210323183201.812944-3-shreeya.patel@collabora.com> (Shreeya
        Patel's message of "Wed, 24 Mar 2021 00:01:58 +0530")
Message-ID: <87sg4ld6tr.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Shreeya Patel <shreeya.patel@collabora.com> writes:

> utf8_unload is being called if CONFIG_UNICODE is enabled.
> The ifdef block doesn't check if utf8 encoding has been loaded
> or not before calling the utf8_unload() function.
> This is not the expected behavior since it would sometimes lead
> to unloading utf8 even before loading it.
> Hence, add a condition which will check if sb->encoding is NOT NULL
> before calling the utf8_unload().

Just to mention this used to be safe, since it was just doing a
kfree(NULL), but won't be anymore after the rest of this series.

Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>

>
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
>
> Changes in v3
>   - Add this patch to the series which checks if utf8 encoding
>     was loaded before calling uft8_unload().
>  
>  fs/ext4/super.c | 6 ++++--
>  fs/f2fs/super.c | 9 ++++++---
>  2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index ad34a3727..e438d14f9 100644
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
> @@ -5165,7 +5166,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  		crypto_free_shash(sbi->s_chksum_driver);
>  
>  #ifdef CONFIG_UNICODE
> -	utf8_unload(sb->s_encoding);
> +	if (sb->s_encoding)
> +		utf8_unload(sb->s_encoding);
>  #endif
>  
>  #ifdef CONFIG_QUOTA
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 706979375..0a04983c2 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1430,7 +1430,8 @@ static void f2fs_put_super(struct super_block *sb)
>  	for (i = 0; i < NR_PAGE_TYPE; i++)
>  		kvfree(sbi->write_io[i]);
>  #ifdef CONFIG_UNICODE
> -	utf8_unload(sb->s_encoding);
> +	if (sb->s_encoding)
> +		utf8_unload(sb->s_encoding);
>  #endif
>  	kfree(sbi);
>  }
> @@ -4073,8 +4074,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  		kvfree(sbi->write_io[i]);
>  
>  #ifdef CONFIG_UNICODE
> -	utf8_unload(sb->s_encoding);
> -	sb->s_encoding = NULL;
> +	if (sb->s_encoding) {
> +		utf8_unload(sb->s_encoding);
> +		sb->s_encoding = NULL;
> +	}
>  #endif
>  free_options:
>  #ifdef CONFIG_QUOTA

-- 
Gabriel Krisman Bertazi
