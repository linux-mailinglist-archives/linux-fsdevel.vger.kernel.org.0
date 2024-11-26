Return-Path: <linux-fsdevel+bounces-35911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEE49D99EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 15:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0A8166BEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 14:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019891D5CF8;
	Tue, 26 Nov 2024 14:49:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FCF28F5;
	Tue, 26 Nov 2024 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732632568; cv=none; b=L7YwLZpfGmdvIxhSvuPBr4kPhqbx54GhYgN8piTGlqv87BbHZREti2L4ewLFl4EBo8o7r8qFxXDu5Tyo72kXcNqVEIYcsSHPvODQF444T9NectSOPeVdSCgBQ9DYKsKjGt8LmouPGmuy4ae1x6cWJLW+fHCwQklfEi8KSkA4Mr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732632568; c=relaxed/simple;
	bh=rOkU4urKTvq6d1TPmzqp6af5+SfUyHhLzdJ+qqUA7WA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cKQizKQ97f//Ta1gZBrmMWmCx5/jclOvfq1HJmylMRUvoG8DNEHvDczs1mEtuQrYY54oZZRdhfn+CQX1v5iRET7zgL2eXQLAAJGiZVC7fZZ73dkY1SexTieT6X37hZlbL/Q9nykOXw4BpX/8blQwv/CDYpozuBiR6MoA81h5iS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XyQQN2NW4z1T4gY;
	Tue, 26 Nov 2024 22:47:08 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id C1DE6140109;
	Tue, 26 Nov 2024 22:49:15 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 26 Nov
 2024 22:49:14 +0800
Message-ID: <cc2fcc33-9024-4ce8-bd52-cdcd23f6b455@huawei.com>
Date: Tue, 26 Nov 2024 22:49:14 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ext4: protect ext4_release_dquot against freezing
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, <linux-ext4@vger.kernel.org>, Jan
 Kara <jack@suse.com>
CC: Ritesh Harjani <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>, Yang Erkun
	<yangerkun@huawei.com>
References: <20241121123855.645335-1-ojaswin@linux.ibm.com>
 <20241121123855.645335-3-ojaswin@linux.ibm.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20241121123855.645335-3-ojaswin@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2024/11/21 20:38, Ojaswin Mujoo wrote:
> Protect ext4_release_dquot against freezing so that we
> don't try to start a transaction when FS is frozen, leading
> to warnings.
>
> Further, avoid taking the freeze protection if a transaction
> is already running so that we don't need end up in a deadlock
> as described in
>
>    46e294efc355 ext4: fix deadlock with fs freezing and EA inodes
>
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>   fs/ext4/super.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 16a4ce704460..f7437a592359 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -6887,12 +6887,25 @@ static int ext4_release_dquot(struct dquot *dquot)
>   {
>   	int ret, err;
>   	handle_t *handle;
> +	bool freeze_protected = false;
> +
> +	/*
> +	 * Trying to sb_start_intwrite() in a running transaction
> +	 * can result in a deadlock. Further, running transactions
> +	 * are already protected from freezing.
> +	 */
> +	if (!ext4_journal_current_handle()) {
> +		sb_start_intwrite(dquot->dq_sb);
> +		freeze_protected = true;
> +	}
>   
>   	handle = ext4_journal_start(dquot_to_inode(dquot), EXT4_HT_QUOTA,
>   				    EXT4_QUOTA_DEL_BLOCKS(dquot->dq_sb));
>   	if (IS_ERR(handle)) {
>   		/* Release dquot anyway to avoid endless cycle in dqput() */
>   		dquot_release(dquot);
> +		if (freeze_protected)
> +			sb_end_intwrite(dquot->dq_sb);
>   		return PTR_ERR(handle);
>   	}
>   	ret = dquot_release(dquot);
> @@ -6903,6 +6916,10 @@ static int ext4_release_dquot(struct dquot *dquot)
The `git am` command looks for the following context code from line 6903
to apply the changes. But there are many functions in fs/ext4/super.c that
have similar code, such as ext4_write_dquot() and ext4_acquire_dquot().

So when the code before ext4_release_dquot() is added, the first matching
context found could be in ext4_write_dquot() or ext4_acquire_dquot().
>   	err = ext4_journal_stop(handle);
>   	if (!ret)
>   		ret = err;
> +
> +	if (freeze_protected)
> +		sb_end_intwrite(dquot->dq_sb);
> +
>   	return ret;
>   }
>   

Thus this is actually a bug in `git am`, which can be avoided by increasing
the number of context lines with `git format-patch -U8 -1`.

Otherwise it looks good. Feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>


