Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349992A592A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 23:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbgKCWFZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 17:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730549AbgKCUmg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 15:42:36 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34639C0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 12:42:36 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id r7so16501222qkf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 12:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GBxKGog+qQpjWU9k5zT7DztWd+7mJRuZvrbzWn1+YpE=;
        b=bvD31TNl8jfM0wpwHCWI/u8CybLpHKDKV1OrnBfeLjBZYEkT/iaLgoMReKEIQXCBq7
         J8Hl7oWbGjsdfsCwtpGTDksNZQHZ9igOwCq2GWMlB8hYOwVN4NZ3DnSCt3AsfuqlgdPh
         m9C8FpoKTWuEoTaTWv89h9rLbyjj372GsPcdhqSUVv6ZZDPKFr/8761mSkJfobGCfR0s
         H8NL0O4pnsr3zIKlyiXeGZgLhHUxAbxfMJx70i5Wg7vrUuto2ndVJ18N98rQC98QZn2k
         hzKFgi26gncPDXT00ZlSJHELNpR6qHS8gcj12ChdHOYed37ybp4b02M4t8OO0qK3dXHR
         urxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GBxKGog+qQpjWU9k5zT7DztWd+7mJRuZvrbzWn1+YpE=;
        b=XNpWU8rW0F5qaXFDkTzYCf8IlMTWKlbplMoTkjUiWQcD16IV2K54/SjiLtzC0irbDY
         42C8s+oQcicEjSehfioiKjRWsKnPDiWGo/ePEuqAFaU2UqfrQiRyNLYw7vaJiuvb+GW1
         OHfhFaZ7mrb4MRU8ZjH/rg1qbzHitU0hnCJ93RTej1WLg7iIiOu5MXGpuJRjEH0jKlK0
         wiy6CpetmBUDqALVoxXilEwmK6qKtWmletyvBjShFtE6WkNmtxh/DHMba+DZ466w8Gt0
         fz1fWm8mOly1vuIwZrFifN7HDEXN91tjVxmMPYHyOTRTmi4KLRI91QX8f3H4f5xBFMVy
         DwLg==
X-Gm-Message-State: AOAM5331KJ8KFeUxeH+AkNKBVpdrOdG1g1Tn64Fseq8N0oX6t/WTwQEO
        DwW/OqCx2oKYM2yx2qyDTrav7Q==
X-Google-Smtp-Source: ABdhPJzuAuR+JwbkxT48lDDAwx/QhvJqsgSA+R6S/C1bTiCIdKcgawgk5ZLUnavIVGbGB/Z6PlKj1A==
X-Received: by 2002:a05:620a:40f:: with SMTP id 15mr21280972qkp.398.1604436155345;
        Tue, 03 Nov 2020 12:42:35 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n127sm10047169qke.92.2020.11.03.12.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 12:42:34 -0800 (PST)
Subject: Re: [PATCH v9 37/41] btrfs: split alloc_log_tree()
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <71b8f94034f04da6f69f1ea0720825aabc852a54.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <502ce12d-1ba6-5e3c-9aab-3b1b42a16bcf@toxicpanda.com>
Date:   Tue, 3 Nov 2020 15:42:33 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <71b8f94034f04da6f69f1ea0720825aabc852a54.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> This is a preparation for the next patch. This commit split
> alloc_log_tree() to allocating tree structure part (remains in
> alloc_log_tree()) and allocating tree node part (moved in
> btrfs_alloc_log_tree_node()). The latter part is also exported to be used
> in the next patch.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/disk-io.c | 31 +++++++++++++++++++++++++------
>   fs/btrfs/disk-io.h |  2 ++
>   2 files changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 2b30ef8a7034..70885f3d3321 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1211,7 +1211,6 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
>   					 struct btrfs_fs_info *fs_info)
>   {
>   	struct btrfs_root *root;
> -	struct extent_buffer *leaf;
>   
>   	root = btrfs_alloc_root(fs_info, BTRFS_TREE_LOG_OBJECTID, GFP_NOFS);
>   	if (!root)
> @@ -1221,6 +1220,14 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
>   	root->root_key.type = BTRFS_ROOT_ITEM_KEY;
>   	root->root_key.offset = BTRFS_TREE_LOG_OBJECTID;
>   
> +	return root;
> +}
> +
> +int btrfs_alloc_log_tree_node(struct btrfs_trans_handle *trans,
> +			      struct btrfs_root *root)
> +{
> +	struct extent_buffer *leaf;
> +
>   	/*
>   	 * DON'T set SHAREABLE bit for log trees.
>   	 *
> @@ -1233,26 +1240,31 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
>   
>   	leaf = btrfs_alloc_tree_block(trans, root, 0, BTRFS_TREE_LOG_OBJECTID,
>   			NULL, 0, 0, 0, BTRFS_NESTING_NORMAL);
> -	if (IS_ERR(leaf)) {
> -		btrfs_put_root(root);
> -		return ERR_CAST(leaf);
> -	}
> +	if (IS_ERR(leaf))
> +		return PTR_ERR(leaf);
>   
>   	root->node = leaf;
>   
>   	btrfs_mark_buffer_dirty(root->node);
>   	btrfs_tree_unlock(root->node);
> -	return root;
> +
> +	return 0;
>   }
>   
>   int btrfs_init_log_root_tree(struct btrfs_trans_handle *trans,
>   			     struct btrfs_fs_info *fs_info)
>   {
>   	struct btrfs_root *log_root;
> +	int ret;
>   
>   	log_root = alloc_log_tree(trans, fs_info);
>   	if (IS_ERR(log_root))

newline.

>   		return PTR_ERR(log_root);
> +	ret = btrfs_alloc_log_tree_node(trans, log_root);
> +	if (ret) {
> +		kfree(log_root);

btrfs_put_root(log_root);

> +		return ret;
> +	}

newline.  Thanks,

Josef
