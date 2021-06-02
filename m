Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C05398D86
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 16:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhFBO7K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 10:59:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230029AbhFBO7J (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:59:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63A6F60C3F;
        Wed,  2 Jun 2021 14:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622645846;
        bh=9S5+0imidO+Ol9OzZqRG2yXOFZnJXLzoJ8dwHhJ87c0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nTptz/RlreMg0+WvWbELEa13RR9Mh6Crt8dAeUzRJtFkqemJWRI+ULnVKfkhaZstK
         vawFGwKVXBV0TVqZkzQZDnRrbYNfKZQ6UBZTxELF8o2ClxDpl7vFkeoieBg2BRWB6V
         mQ6ozIIHUrgorrb/sJdGW9dfL/SO9mIR+UCiwgO6W9o2y45oeB/uiw6CWwYBiwJtC5
         Y0GbUj65jYHd/OgfuIqc8gs7BrFGTnDjxy80AdnLetKU7UGZ4GTin2ZgyubqFz3x9h
         oJXgwPx3LLdNBok4d7d8cab8mhdwhx5U/g7YKOr0ndvllgPTgBXNQZ/CEkkZri42kq
         hXmxbPGlR3tcw==
Subject: Re: [PATCH 2/2] f2fs: Advertise encrypted casefolding in sysfs
To:     Daniel Rosenberg <drosen@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
References: <20210602041539.123097-1-drosen@google.com>
 <20210602041539.123097-3-drosen@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <a954e38e-8ace-df39-3d74-814afd798267@kernel.org>
Date:   Wed, 2 Jun 2021 22:57:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210602041539.123097-3-drosen@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/6/2 12:15, Daniel Rosenberg wrote:
> Older kernels don't support encryption with casefolding. This adds
> the sysfs entry encrypted_casefold to show support for those combined
> features. Support for this feature was originally added by
> commit 7ad08a58bf67 ("f2fs: Handle casefolding with Encryption")

Shouldn't this be backported to the kernel where we support casefolding
with encryption? So adding a fixes tag here?

Thanks,

> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---
>   fs/f2fs/sysfs.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 09e3f258eb52..3c1095a76710 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -161,6 +161,9 @@ static ssize_t features_show(struct f2fs_attr *a,
>   	if (f2fs_sb_has_compression(sbi))
>   		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
>   				len ? ", " : "", "compression");
> +	if (f2fs_sb_has_casefold(sbi) && f2fs_sb_has_encrypt(sbi))
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
> +				len ? ", " : "", "encrypted_casefold");
>   	len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
>   				len ? ", " : "", "pin_file");
>   	len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
> @@ -579,6 +582,7 @@ enum feat_id {
>   	FEAT_CASEFOLD,
>   	FEAT_COMPRESSION,
>   	FEAT_TEST_DUMMY_ENCRYPTION_V2,
> +	FEAT_ENCRYPTED_CASEFOLD,
>   };
>   
>   static ssize_t f2fs_feature_show(struct f2fs_attr *a,
> @@ -600,6 +604,7 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
>   	case FEAT_CASEFOLD:
>   	case FEAT_COMPRESSION:
>   	case FEAT_TEST_DUMMY_ENCRYPTION_V2:
> +	case FEAT_ENCRYPTED_CASEFOLD:
>   		return sprintf(buf, "supported\n");
>   	}
>   	return 0;
> @@ -704,6 +709,9 @@ F2FS_GENERAL_RO_ATTR(avg_vblocks);
>   #ifdef CONFIG_FS_ENCRYPTION
>   F2FS_FEATURE_RO_ATTR(encryption, FEAT_CRYPTO);
>   F2FS_FEATURE_RO_ATTR(test_dummy_encryption_v2, FEAT_TEST_DUMMY_ENCRYPTION_V2);
> +#ifdef CONFIG_UNICODE
> +F2FS_FEATURE_RO_ATTR(encrypted_casefold, FEAT_ENCRYPTED_CASEFOLD);
> +#endif
>   #endif
>   #ifdef CONFIG_BLK_DEV_ZONED
>   F2FS_FEATURE_RO_ATTR(block_zoned, FEAT_BLKZONED);
> @@ -815,6 +823,9 @@ static struct attribute *f2fs_feat_attrs[] = {
>   #ifdef CONFIG_FS_ENCRYPTION
>   	ATTR_LIST(encryption),
>   	ATTR_LIST(test_dummy_encryption_v2),
> +#ifdef CONFIG_UNICODE
> +	ATTR_LIST(encrypted_casefold),
> +#endif
>   #endif
>   #ifdef CONFIG_BLK_DEV_ZONED
>   	ATTR_LIST(block_zoned),
> 
