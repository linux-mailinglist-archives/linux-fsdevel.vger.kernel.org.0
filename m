Return-Path: <linux-fsdevel+bounces-30173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C186987558
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 16:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B14761F2242B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 14:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81954D8CB;
	Thu, 26 Sep 2024 14:21:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC11E374EA
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727360462; cv=none; b=PiolALPfpu+UmRe2PmP2qQ88DVsF5d/041MB+xmpuFLtRhY6KD1pgLcs00/8wbF2shTKLynQnEmlQ2ifVPHxdrkhe0pDYqjuE+62/XW9wQPZMj4S66vjHY/QuSiIESmCSRZBXiPDJ2l+H2wV8eNUsbw0MBgb4kaSQRVJH84XN/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727360462; c=relaxed/simple;
	bh=fSAMVvoTZtNnhaor2feuczQlVuar/Udo3ruxN6itJms=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Rf5OkO/w42rANJ7zJvDHCcWIKCmg51c3/LGUiET6X6b0U6OkT/1PQrJukcDGMPfxsPUSl2l2hoQ+oeTI9bKaB6BZevWtbx3wFFGEQJ9cchuigOppwBSphZ0XR0lS9qNuGHlOUMfkdN6qMRCWInRSRUFuhSudeIifKCTFFURxguw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XDwgd6kJGzfcf0;
	Thu, 26 Sep 2024 22:18:37 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id A3A73180087;
	Thu, 26 Sep 2024 22:20:55 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Sep 2024 22:20:55 +0800
Message-ID: <9a420cea-b0c0-4c25-8c31-0eb2e2f33549@huawei.com>
Date: Thu, 26 Sep 2024 22:20:54 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tmpfs: fault in smaller chunks if large folio
 allocation not allowed
To: Matthew Wilcox <willy@infradead.org>, "Pankaj Raghav (Samsung)"
	<kernel@pankajraghav.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
	<hughd@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Anna Schumaker
	<Anna.Schumaker@netapp.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, Baolin Wang <baolin.wang@linux.alibaba.com>
References: <20240914140613.2334139-1-wangkefeng.wang@huawei.com>
 <20240920143654.1008756-1-wangkefeng.wang@huawei.com>
 <Zu9mbBHzI-MyRoHa@casper.infradead.org>
 <1d4f98aa-f57d-4801-8510-5c44e027c4e4@huawei.com>
 <nhnpbkyxbbvjl2wg77x2f7gx3b3wj7jujfkucc33tih3d4jnpx@5dg757r4go64>
 <ZvVnO777wfXcfjYX@casper.infradead.org>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZvVnO777wfXcfjYX@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/9/26 21:52, Matthew Wilcox wrote:
> On Thu, Sep 26, 2024 at 10:38:34AM +0200, Pankaj Raghav (Samsung) wrote:
>>> So this is why I don't use mapping_set_folio_order_range() here, but
>>> correct me if I am wrong.
>>
>> Yeah, the inode is active here as the max folio size is decided based on
>> the write size, so probably mapping_set_folio_order_range() will not be
>> a safe option.
> 
> You really are all making too much of this.  Here's the patch I think we
> need:
> 
> +++ b/mm/shmem.c
> @@ -2831,7 +2831,8 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
>          cache_no_acl(inode);
>          if (sbinfo->noswap)
>                  mapping_set_unevictable(inode->i_mapping);
> -       mapping_set_large_folios(inode->i_mapping);
> +       if (sbinfo->huge)
> +               mapping_set_large_folios(inode->i_mapping);
> 

But it can't solve all issue, eg,
   mount with huge = SHMEM_HUGE_WITHIN_SIZE, or
   mount with SHMEM_HUGE_ALWAYS  +  runtime SHMEM_HUGE_DENY

and the above change will break
   mount with SHMEM_HUGE_NEVER + runtime SHMEM_HUGE_FORCE



