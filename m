Return-Path: <linux-fsdevel+bounces-36315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64CB9E1394
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 07:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9BF8161B5D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 06:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C48B1891A8;
	Tue,  3 Dec 2024 06:53:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E077126C13;
	Tue,  3 Dec 2024 06:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733208797; cv=none; b=HWCGRkOKWxecpkz9zbzTv28F/xvHnYMdDyn3KqK8J81U3C/DA1OSaqW/FMIqtKs8W6LCTdoh6HHVQ+sdmSaYP07fjtegla5bM0ozTHhNXzIDOSoApi6vtgpEeVksMRkq5KmPemqE7DGH626f0Mdof/Hi6LDRLXqD6DNDBp0524E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733208797; c=relaxed/simple;
	bh=SVR6ceyuva1gKBEJ2DGGfb0ng5PiG04dXwLjRpLuvDI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Fg7ODL+QjRadWMuigvpJy3BLB5PSDMkiadQJz5CEi3gklLEyaaVP1vUWsBuwGoLPue8yPPeeDGrkAm7eSKe/SkCfNXtiAhIVwAcjvIglAFIXlKih+Kei0IxAq5BOZmeAsVeQZkUY+0PtAGpMjx/USn92aBpVb5vpn9UIIIjLQYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Y2WYs5StCz4f3jR1;
	Tue,  3 Dec 2024 14:52:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B61661A0568;
	Tue,  3 Dec 2024 14:53:08 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgD3n7HTqk5nXGnBDQ--.6246S2;
	Tue, 03 Dec 2024 14:53:08 +0800 (CST)
Subject: Re: [PATCH 2/2] jbd2: flush filesystem device before updating tail
 sequence
To: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20241203014407.805916-1-yi.zhang@huaweicloud.com>
 <20241203014407.805916-3-yi.zhang@huaweicloud.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <ca1c680f-f3f4-40b5-13af-f8ee49d99dae@huaweicloud.com>
Date: Tue, 3 Dec 2024 14:53:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241203014407.805916-3-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgD3n7HTqk5nXGnBDQ--.6246S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF18Xw4ktry8Gw4xCw17Jrb_yoW8Ar1DpF
	yUA3W2yrWkCF4UCFn7XF4xXFWIqFWvyFykWFykuF93Wa1DJwn3KrW3t34agr1qyr1F9w4r
	Xr10gFyqg34jkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUOBMKDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 12/3/2024 9:44 AM, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When committing transaction in jbd2_journal_commit_transaction(), the
> disk caches for the filesystem device should be flushed before updating
> the journal tail sequence. However, this step is missed if the journal
> is not located on the filesystem device. As a result, the filesystem may
> become inconsistent following a power failure or system crash. Fix it by
> ensuring that the filesystem device is flushed appropriately.
> 
> Fixes: 3339578f0578 ("jbd2: cleanup journal tail after transaction commit")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/jbd2/commit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 4305a1ac808a..f95cf272a1b5 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -776,9 +776,9 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  	/*
>  	 * If the journal is not located on the file system device,
>  	 * then we must flush the file system device before we issue
> -	 * the commit record
> +	 * the commit record and update the journal tail sequence.
>  	 */
> -	if (commit_transaction->t_need_data_flush &&
> +	if ((commit_transaction->t_need_data_flush || update_tail) &&
>  	    (journal->j_fs_dev != journal->j_dev) &&
>  	    (journal->j_flags & JBD2_BARRIER))
>  		blkdev_issue_flush(journal->j_fs_dev);
> 
In journal_submit_commit_record(), we will submit commit block with REQ_PREFLUSH
which is supposed to ensure disk cache is flushed before writing commit block.
So I think the current code is fine.
Please correct me if I miss anything.

Thanks,
Kemeng


