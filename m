Return-Path: <linux-fsdevel+bounces-74409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBEDD3A1BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 09:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE14930486AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DB633F394;
	Mon, 19 Jan 2026 08:34:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222DA270552;
	Mon, 19 Jan 2026 08:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768811698; cv=none; b=mzuAjYRCkZi0KgyFHDWc0dP6nIQx/u0UmR79ZEKa4jV8CoY5gwNvniG5+5SovSG7WgXNPW3UDMoLs/HDTAe5rLoqAODvjzSacMP1j4f58GXqYH/CHjH7U45deCWCShOMTTJnE922j0HM0fZUaWeo/WZbnqIIytHVqvbUm3+dc8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768811698; c=relaxed/simple;
	bh=DLeaQLvCFjWvrbwyy4XLA4MzKOYnsJm/2opOVAIpzfc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fUTRF8//PfHJHwCuDPkRACLMeUFnbhD8fo4ZorPpZNS4awT2q6gh2so5FRtXWL0x+QRte6k1wAk/IJJdLwQyXOpPAD6URoFKoyd3CZwH8eaAhzR7E4URkQ8smtdj0WsXS1G3fncPfKtiIiQaKphs0Niq4gO8LbxnzGR8HX12zlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from [10.26.132.114] (gy-adaptive-ssl-proxy-4-entmail-virt151.gy.ntes [61.151.228.151])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3122c80ad;
	Mon, 19 Jan 2026 16:34:49 +0800 (GMT+08:00)
Message-ID: <3f28825a-dc00-4a34-a9e5-d8d1ddb4184f@ustc.edu>
Date: Mon, 19 Jan 2026 16:34:49 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] fuse: use offset_in_folio() for large folio offset
 calculations
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: miklos@szeredi.hu
Cc: amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260119082327.2029-1-luochunsheng@ustc.edu>
In-Reply-To: <20260119082327.2029-1-luochunsheng@ustc.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9bd564770203a2kunm63ae03b8315ef1
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSB0ZVkoeSU9PTUsaGEtJSVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlNSlVKTkpVSUlDVUpOSllXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
	JLS1kG

Dear Community Members,

I sincerely apologize for the email that was mistakenly sent earlier due 
to an operational error on my part.

Please kindly ignore the previous message, and if possible, you may 
delete it from your inbox.

My deepest apologies for any inconvenience this may have caused.

Thanks
Chunsheng Luo


On 1/19/26 4:23 PM, Chunsheng Luo wrote:
> On 1/17/26 7:56 AM, Joanne Koong wrote:
>> Use offset_in_folio() instead of manually calculating the folio offset.
>>
>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>> ---
>>    fs/fuse/dev.c | 4 ++--
>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 698289b5539e..4dda4e24cc90 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -1812,7 +1812,7 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
>>            if (IS_ERR(folio))
>>                goto out_iput;
>>    -        folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
>> +        folio_offset = offset_in_folio(folio, outarg.offset);
> 
> offset is a loop variable, and later offset maybe set to 0. Replacing it
> with outarg.offset here would change the behavior. The same below.
> Will this cause any problems?
> 
> Thanks,
> Chunsheng Luo
> 
>>            nr_bytes = min_t(unsigned, num, folio_size(folio) - folio_offset);
>>            nr_pages = DIV_ROUND_UP(offset + nr_bytes, PAGE_SIZE);
>>    @@ -1916,7 +1916,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
>>            if (IS_ERR(folio))
>>                break;
>>    -        folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
>> +        folio_offset = offset_in_folio(folio, outarg->offset);
>>            nr_bytes = min(folio_size(folio) - folio_offset, num);
>>            nr_pages = DIV_ROUND_UP(offset + nr_bytes, PAGE_SIZE);
>>    
> 
> 
> 




