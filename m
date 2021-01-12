Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD48A2F3B30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 20:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436612AbhALTvT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 14:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406168AbhALTvS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:51:18 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A55C061795
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 11:50:38 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id c7so3055277qke.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 11:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9Cl7z3hzaRwfK3/54ZK6UJomNI+K6b2Zv5ftDD+vKXI=;
        b=OxM/hkz25OY1OC/fbpZf304ToZSUMeLpgvX18rUTqUoN+nUEnZ1V0ZFoI3z9ak+0ep
         a/h/xntjU6ZEUFFhzm3FYWDR0XKvt9ccf0vwLL+TwcUEJ0JoncN7KeliQZ8ACpNEVfFa
         JOZtWRufuv8P4yKZncwvuzZrRV0Aer0GosbOXCeE22VwiJV4c8DicQbaZ+Q0LKaitzsD
         RbKutGo99xacoYyXyQZmvuO8O19ClMJHhkKzXAxNzgMbNeJe7vuhQ8nxaX24ef792pUJ
         rahICy3rXz/vyL7vYpIaQLjD2Csfv0yG41smtFPVw9LnBuPVAABR5LAZNQP7hJakCPZH
         PTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9Cl7z3hzaRwfK3/54ZK6UJomNI+K6b2Zv5ftDD+vKXI=;
        b=PcZ0yvHNFfk9USRgLY1tTLjzm9esZH1M9lQuJX3FJMQK93i8O1Ymtnje5F2cjOgNEf
         ep02BpJO+YEasZl8cnXsoOxs1hs/KzD+PBTR4Ly8FKEKD71kcNPAz4MZdtNxSHGeAGok
         KY7G+cC3xaDFsHP4A3HO5OD/SSbX93qKAeijCQYH2RXvUhWAaWXC71NZ7reQiI9NS3tU
         +3AcEWBxb48dKfy8z+7AsMv5J8zfcbSpiegesbE2cooSQ4kqF54/wE8R2MQIRUY2Qd/M
         5RBaEGd6K0ww2RBcu3a2g6f1bh540L/PIUwgNwJU8ozSiI03onjIaJ7x96aKqTveOp5E
         w46A==
X-Gm-Message-State: AOAM530ZxsQY8wVM6MDVsRU4Nb4IUbyQQdjyafUu4+H4XBXxvbSjuSg2
        aW2yBBRlSjE1ydu51rnp7HZ6Zw==
X-Google-Smtp-Source: ABdhPJzzsbZGYE6cfmobsnMye8Mm3eEFlCTaH3tsKTN1SlioYor/Nrskvetii+ta73C88N23pAlU8g==
X-Received: by 2002:a37:e504:: with SMTP id e4mr1075940qkg.201.1610481037772;
        Tue, 12 Jan 2021 11:50:37 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o29sm1735522qtl.7.2021.01.12.11.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 11:50:36 -0800 (PST)
Subject: Re: [PATCH v11 39/40] btrfs: serialize log transaction on ZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <39b1c016d74422b9dcac01ba6e33d3ccd8000889.1608608848.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <255ec1ff-2f2b-14a8-1f0c-3ff7ffe61445@toxicpanda.com>
Date:   Tue, 12 Jan 2021 14:50:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <39b1c016d74422b9dcac01ba6e33d3ccd8000889.1608608848.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/21/20 10:49 PM, Naohiro Aota wrote:
> This is the 2/3 patch to enable tree-log on ZONED mode.
> 
> Since we can start more than one log transactions per subvolume
> simultaneously, nodes from multiple transactions can be allocated
> interleaved. Such mixed allocation results in non-sequential writes at the
> time of log transaction commit. The nodes of the global log root tree
> (fs_info->log_root_tree), also have the same mixed allocation problem.
> 
> This patch serializes log transactions by waiting for a committing
> transaction when someone tries to start a new transaction, to avoid the
> mixed allocation problem. We must also wait for running log transactions
> from another subvolume, but there is no easy way to detect which subvolume
> root is running a log transaction. So, this patch forbids starting a new
> log transaction when other subvolumes already allocated the global log root
> tree.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/tree-log.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 930e752686b4..d269c9ea8706 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -105,6 +105,7 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
>   				       struct btrfs_root *log,
>   				       struct btrfs_path *path,
>   				       u64 dirid, int del_all);
> +static void wait_log_commit(struct btrfs_root *root, int transid);
>   
>   /*
>    * tree logging is a special write ahead log used to make sure that
> @@ -140,6 +141,7 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
>   {
>   	struct btrfs_fs_info *fs_info = root->fs_info;
>   	struct btrfs_root *tree_root = fs_info->tree_root;
> +	const bool zoned = btrfs_is_zoned(fs_info);
>   	int ret = 0;
>   
>   	/*
> @@ -160,12 +162,20 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
>   
>   	mutex_lock(&root->log_mutex);
>   
> +again:
>   	if (root->log_root) {
> +		int index = (root->log_transid + 1) % 2;
> +
>   		if (btrfs_need_log_full_commit(trans)) {
>   			ret = -EAGAIN;
>   			goto out;
>   		}
>   
> +		if (zoned && atomic_read(&root->log_commit[index])) {
> +			wait_log_commit(root, root->log_transid - 1);
> +			goto again;
> +		}
> +
>   		if (!root->log_start_pid) {
>   			clear_bit(BTRFS_ROOT_MULTI_LOG_TASKS, &root->state);
>   			root->log_start_pid = current->pid;
> @@ -173,6 +183,15 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
>   			set_bit(BTRFS_ROOT_MULTI_LOG_TASKS, &root->state);
>   		}
>   	} else {
> +		mutex_lock(&fs_info->tree_log_mutex);
> +		if (zoned && fs_info->log_root_tree)
> +			ret = -EAGAIN;
> +		else if (!fs_info->log_root_tree)
> +			ret = btrfs_init_log_root_tree(trans, fs_info);
> +		mutex_unlock(&fs_info->tree_log_mutex);

You're adding lock contention here in the normal case, I'd rather this be

if (zoned) {
	mutex_lock(&fs_info->tree_log_mutex);
	if (fs_info->log_root_tree)
	etc...

Thanks,

Josef
