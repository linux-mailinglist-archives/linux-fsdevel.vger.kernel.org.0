Return-Path: <linux-fsdevel+bounces-43566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2FBA58C27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 07:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206E43AB2FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 06:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F81A1CCEE2;
	Mon, 10 Mar 2025 06:40:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD411B87F0;
	Mon, 10 Mar 2025 06:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741588843; cv=none; b=RIloyZiT+9/xreODNnSQSuw+OKsjTHFijh/wMGwyKEV6yplj34LPZ0wHRTKmTI1B299oW9frjg9Zrw12KFthnU1auo8nGGe8LHqlXSVfaDvH8+Ck4yb9bKvjENeUduMXSZiLurO4O+oFjrhQvVdtAf1hL24G6Kcddi1sNNzKgy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741588843; c=relaxed/simple;
	bh=CUmqUmoeYlmVdTS9pZtB70jnngGbrZtKj9eGtdxEDsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IZ+1R5xfghXB2+UCwNhOWF90njdayrkp6eQ58SzBCAPC1ylMFT8JyzCvNAh319YVN27QDuj7enOY3e2170Chy9nCfSJTKRWXRIq575FiM8Jn9xJ7AuZ6bBWlY7GqlX+S35snXvmCWsIqRUxyzchqj30bvOuerSOFBKbZP5ngSGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZB6c1755bz2SSkG;
	Mon, 10 Mar 2025 14:36:17 +0800 (CST)
Received: from kwepemo200002.china.huawei.com (unknown [7.202.195.209])
	by mail.maildlp.com (Postfix) with ESMTPS id C31841A0188;
	Mon, 10 Mar 2025 14:40:36 +0800 (CST)
Received: from [10.174.179.13] (10.174.179.13) by
 kwepemo200002.china.huawei.com (7.202.195.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Mar 2025 14:40:35 +0800
Message-ID: <bb6eb768-2e3b-0419-6a7d-9ed9165a2024@huawei.com>
Date: Mon, 10 Mar 2025 14:40:35 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Using userfaultfd with KVM's async page fault handling causes
 processes to hung waiting for mmap_lock to be released
To: Peter Xu <peterx@redhat.com>, jimsiak <jimsiak@cslab.ece.ntua.gr>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<viro@zeniv.linux.org.uk>, <linux-mm@kvack.org>, <wangkefeng.wang@huawei.com>
References: <79375b71-db2e-3e66-346b-254c90d915e2@cslab.ece.ntua.gr>
 <20250307072133.3522652-1-tujinjiang@huawei.com>
 <46ac83f7-d3e0-b667-7352-d853938c9fc9@huawei.com>
 <dee238e365f3727ab16d6685e186c53c@cslab.ece.ntua.gr>
 <Z8t2Np8fOM9jWmuu@x1.local>
From: Jinjiang Tu <tujinjiang@huawei.com>
In-Reply-To: <Z8t2Np8fOM9jWmuu@x1.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemo200002.china.huawei.com (7.202.195.209)


在 2025/3/8 6:41, Peter Xu 写道:
> On Fri, Mar 07, 2025 at 03:11:09PM +0200, jimsiak wrote:
>> Hi,
>>
>>  From my side, I managed to avoid the freezing of processes with the
>> following change in function userfaultfd_release() in file fs/userfaultfd.c
>> (https://elixir.bootlin.com/linux/v5.13/source/fs/userfaultfd.c#L842):
>>
>> I moved the following command from line 851:
>> WRITE_ONCE(ctx->released, true);
>> (https://elixir.bootlin.com/linux/v5.13/source/fs/userfaultfd.c#L851)
>>
>> to line 905, that is exactly before the functions returns 0.
>>
>> That simple workaround worked for my use case but I am far from sure that is
>> a correct/sufficient fix for the problem at hand.
> Updating the field after userfaultfd_ctx_put() might mean UAF, afaict.
>
> Maybe it's possible to remove ctx->released but only rely on the mmap write
> lock.  However that'll need some closer look and more thoughts.
>
> To me, the more straightforward way to fix it is to use the patch I
> mentioned in the other email:
>
> https://lore.kernel.org/all/ZLmT3BfcmltfFvbq@x1n/
>
> Or does it mean it didn't work at all?

This patch works for me. mlock() syscall calls GUP with FOLL_UNLOCKABLE and
allows to release mmap lock and retry.

But other GUP call without FOLL_UNLOCKABLE will return VM_FAULT_SIGBUS,
is it a regression for the below commit？

commit 656710a60e3693911bee3a355d2f2bbae3faba33
Author: Andrea Arcangeli <aarcange@redhat.com>
Date:   Fri Sep 8 16:12:42 2017 -0700

     userfaultfd: non-cooperative: closing the uffd without triggering SIGBUS

>
> Thanks,
>

