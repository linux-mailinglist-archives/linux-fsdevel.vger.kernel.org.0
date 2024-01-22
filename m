Return-Path: <linux-fsdevel+bounces-8420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2164B836337
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 13:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A579DB235EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 12:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300F73C08F;
	Mon, 22 Jan 2024 12:26:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2333BB22;
	Mon, 22 Jan 2024 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926378; cv=none; b=Kqy1wgKd83wiUbtP9I+NgPilu7Yp6gTyaip68lwv4LZ0KrJXzSY8mnYnpFRKJiYuBDb5hQqsu/R87cWmwDaPtiuuZUyrTVE4b+8hmTj5+J9WOkclWvzk6LwaV4+zBsNEhXlgWBNfwrc2p5lAGtXx4o1Q87R8a3FHwBmciRexp0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926378; c=relaxed/simple;
	bh=fOxUJ5uH3HMqlEd680OVHktiVcZYDr7XydXxCfRogLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pgKb5/Kugj6pPSksIQ5RXwVipjTbOYIwj8ghVB3q2EUq1C5qM75RGEJz+KKeqN9WWcsAn8aE2Ouitue3rUUd0KIr6O8pISdcrdiQ4zdxMkV0c8rgU/pRYjQ/WcSTbyaHFeNFpncsIWMsks8oQYRMtJeEzo6V3opxKRrnltxXk5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TJTvD1K39zsWKS;
	Mon, 22 Jan 2024 20:25:12 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 8550218007B;
	Mon, 22 Jan 2024 20:25:57 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 20:25:56 +0800
Message-ID: <d0d89b2b-dbb8-cb07-f5e6-bee9413c971a@huawei.com>
Date: Mon, 22 Jan 2024 20:25:56 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 0/2] fs: make the i_size_read/write helpers be
 smp_load_acquire/store_release()
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
CC: <torvalds@linux-foundation.org>, <viro@zeniv.linux.org.uk>,
	<jack@suse.cz>, <willy@infradead.org>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <yukuai3@huawei.com>,
	<linux-fsdevel@vger.kernel.org>, Baokun Li <libaokun1@huawei.com>
References: <20240122094536.198454-1-libaokun1@huawei.com>
 <20240122-gepokert-mitmachen-6d6ba8d2f0a8@brauner>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20240122-gepokert-mitmachen-6d6ba8d2f0a8@brauner>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/1/22 19:14, Christian Brauner wrote:
> On Mon, 22 Jan 2024 17:45:34 +0800, Baokun Li wrote:
>> This patchset follows the linus suggestion to make the i_size_read/write
>> helpers be smp_load_acquire/store_release(), after which the extra smp_rmb
>> in filemap_read() is no longer needed, so it is removed.
>>
>> Functional tests were performed and no new problems were found.
>>
>> Here are the results of unixbench tests based on 6.7.0-next-20240118 on
>> arm64, with some degradation in single-threading and some optimization in
>> multi-threading, but overall the impact is not significant.
>>
>> [...]
> Hm, we can certainly try but I wouldn't rule it out that someone will
> complain aobut the "non-significant" degradation in single-threading.
> We'll see. Let that performance bot chew on it for a bit as well.
>
> But I agree that the smp_load_acquire()/smp_store_release() is clearer
> than the open-coded smp_rmb().
Thank you very much for applying this patch!

Adding barriers where none existed does introduce some performance
degradation. But the multi-threaded test results here look pretty
good, it's just that the single-threaded test results have a bit too
much degradation for Shell Scripts (8 concurrent).  I've tracked
down this test item, which calls clone() and wait4() and then triggers
isize reads and writes frequently, so the degradation here is as
expected, just not sure if anyone cares about this scenario.
> ---
>
> Applied to the vfs.misc branch of the vfs/vfs.git tree.
> Patches in the vfs.misc branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.misc
>
> [1/2] fs: make the i_size_read/write helpers be smp_load_acquire/store_release()
>        https://git.kernel.org/vfs/vfs/c/7d7825fde8ba
> [2/2] Revert "mm/filemap: avoid buffered read/write race to read inconsistent data"
>        https://git.kernel.org/vfs/vfs/c/83dfed690b90
Thanks!
-- 
With Best Regards,
Baokun Li
.

