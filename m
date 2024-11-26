Return-Path: <linux-fsdevel+bounces-35910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35009D99A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 15:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAEF4B23547
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 14:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C368B1D5ACF;
	Tue, 26 Nov 2024 14:28:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EA41CB32A;
	Tue, 26 Nov 2024 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732631292; cv=none; b=kgutK9NKI3v6TC/KVzKERpJH3OPn906fesbobifUkFYc/c2IEHvQqFqEFV5Xzcklis6tMlmn9n+FU5F0oMmo6W20wJzSc9yst0wpNylhCnfhTR/ola01ysCbDGe4n5TdyMWPxEiY3RFzoqC6ENdNHdTpd22A1KKHY2aGTaEFoaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732631292; c=relaxed/simple;
	bh=nJgUj2C7Bx2/O5pYEPQimeqI1Mlao1epQ38YJTiMDxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Iis7NIz1VW6iC2uOsAOQiMxB+D9Y0Q5t+QsS+sstQfXvQVIb7xg3StgxLDlFWcIa65fUvwsTB3J1aGjnQSitCerUEmx54KLG8wGVdxkQe2cxuTIRniK0xM7kA8G743mVGU5u5e3ANrAWMAmIExGGPH6yCKYf3Nq+/txTwbTMzFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XyPxC65xQzxSRv;
	Tue, 26 Nov 2024 22:25:19 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A394180105;
	Tue, 26 Nov 2024 22:28:06 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 26 Nov
 2024 22:28:05 +0800
Message-ID: <0bb10df6-1e4d-4765-86c8-3549d2b778a2@huawei.com>
Date: Tue, 26 Nov 2024 22:28:04 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] quota: flush quota_release_work upon quota
 writeback
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, <linux-ext4@vger.kernel.org>, Jan
 Kara <jack@suse.com>
CC: Ritesh Harjani <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, Disha Goel <disgoel@linux.ibm.com>, Yang
 Erkun <yangerkun@huawei.com>
References: <20241121123855.645335-1-ojaswin@linux.ibm.com>
 <20241121123855.645335-2-ojaswin@linux.ibm.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20241121123855.645335-2-ojaswin@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2024/11/21 20:38, Ojaswin Mujoo wrote:
> One of the paths quota writeback is called from is:
>
> freeze_super()
>    sync_filesystem()
>      ext4_sync_fs()
>        dquot_writeback_dquots()
>
> Since we currently don't always flush the quota_release_work queue in
> this path, we can end up with the following race:
>
>   1. dquot are added to releasing_dquots list during regular operations.
>   2. FS Freeze starts, however, this does not flush the quota_release_work queue.
>   3. Freeze completes.
>   4. Kernel eventually tries to flush the workqueue while FS is frozen which
>      hits a WARN_ON since transaction gets started during frozen state:
>
>    ext4_journal_check_start+0x28/0x110 [ext4] (unreliable)
>    __ext4_journal_start_sb+0x64/0x1c0 [ext4]
>    ext4_release_dquot+0x90/0x1d0 [ext4]
>    quota_release_workfn+0x43c/0x4d0
>
> Which is the following line:
>
>    WARN_ON(sb->s_writers.frozen == SB_FREEZE_COMPLETE);
>
> Which ultimately results in generic/390 failing due to dmesg
> noise. This was detected on powerpc machine 15 cores.
>
> To avoid this, make sure to flush the workqueue during
> dquot_writeback_dquots() so we dont have any pending workitems after
> freeze.
>
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Looks good, thanks for the patch!

Reviewed-by: Baokun Li <libaokun1@huawei.com>
> ---
>   fs/quota/dquot.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 3dd8d6f27725..f9578918cfb2 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -688,6 +688,8 @@ int dquot_writeback_dquots(struct super_block *sb, int type)
>   
>   	WARN_ON_ONCE(!rwsem_is_locked(&sb->s_umount));
>   
> +	flush_delayed_work(&quota_release_work);
> +
>   	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
>   		if (type != -1 && cnt != type)
>   			continue;



