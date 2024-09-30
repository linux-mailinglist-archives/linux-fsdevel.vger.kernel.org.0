Return-Path: <linux-fsdevel+bounces-30322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6B4989918
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 04:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2306D2835BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 02:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C95748A;
	Mon, 30 Sep 2024 02:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oMQaTf3i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44ED3C39
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 02:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727662063; cv=none; b=OlVwe8dA90ZU7aHdcra9PJceOEoLZqc6Z4S4vTjl038I32OoE1C6vJWCfYkniclYRtUrCFZ7AofDWTY2a20tExDWbx8idO74UkZg7gjLCVmBXoOItserzXHp8iuBlrryNQq0H/q7VRC2V+4XiMnKaxztCmETVPjnRUquoo1tqiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727662063; c=relaxed/simple;
	bh=pPTJSgUlI24z7CYUY9r/cExRWMY2OVH/cPi4xsuzPoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kCyGTXA+OlR6a5pgVCGPiZzcvl0yOimSJI3veCdthTLJ1seBvyaCyoGkQgxSfIcNMFmJxkPCW5YP8DOoY5FG8lxHwzi0u4oNvUBIe1LoxbZf6luXRdcYBmAeAfslNKa33Zfk5FwGWZUXUh3Mh1xgaWaPpi0oNZolrqvcvRrnEs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oMQaTf3i; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727662052; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ldefraz5rFyL/LLYuTatQoVMo2Z9oXl/AKXIrt0zCQc=;
	b=oMQaTf3iorzqohDsxY7Fv7ZdrBPHgN6M8Jf4gxLI9TaP5eftyzYhHA5QtcnGTF0Y4qjjYwtafK9MibXaTEvu8g4dYtRgvp00BoMHMFIZsS0c3f5eeyDnSYa7lg4ubB8GfRDpyrH205of7Tu4lSlPNx/CyruG0ZYMSMp2CBrFe5I=
Received: from 30.74.144.111(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WFxLnGU_1727661733)
          by smtp.aliyun-inc.com;
          Mon, 30 Sep 2024 10:02:13 +0800
Message-ID: <1e5357de-3356-4ae7-bc69-b50edca3852b@linux.alibaba.com>
Date: Mon, 30 Sep 2024 10:02:11 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tmpfs: fault in smaller chunks if large folio
 allocation not allowed
To: Matthew Wilcox <willy@infradead.org>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Anna Schumaker <Anna.Schumaker@netapp.com>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240914140613.2334139-1-wangkefeng.wang@huawei.com>
 <20240920143654.1008756-1-wangkefeng.wang@huawei.com>
 <Zu9mbBHzI-MyRoHa@casper.infradead.org>
 <1d4f98aa-f57d-4801-8510-5c44e027c4e4@huawei.com>
 <nhnpbkyxbbvjl2wg77x2f7gx3b3wj7jujfkucc33tih3d4jnpx@5dg757r4go64>
 <ZvVnO777wfXcfjYX@casper.infradead.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ZvVnO777wfXcfjYX@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



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
>          switch (mode & S_IFMT) {
>          default:

IMHO, we no longer need the the 'sbinfo->huge' validation after adding 
support for large folios in the tmpfs write and fallocate paths [1].

Kefeng, can you try if the following RFC patch [1] can solve your 
problem? Thanks.
(PS: I will revise the patch according to Matthew's suggestion)

[1] 
https://lore.kernel.org/all/c03ec1cb1392332726ab265a3d826fe1c408c7e7.1727338549.git.baolin.wang@linux.alibaba.com/

