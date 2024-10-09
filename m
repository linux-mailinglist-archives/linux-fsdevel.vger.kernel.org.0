Return-Path: <linux-fsdevel+bounces-31421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC85996101
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 09:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E06C2853E5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 07:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B6517E472;
	Wed,  9 Oct 2024 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LA2tVKZf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C680C84E18;
	Wed,  9 Oct 2024 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728459432; cv=none; b=cB30QcHrKCiwgb8f1peNV5pLNtzrAoB49+xqOpYOwVxBxieAw2omppRHGG3q+KJw3271Sej0+gBbZR2a/3VgN74IC6SxtwrKWquh+HJxE9GgdKRMNvKk13yZPGV5fwPA6N/CxLsXsP568IQFjChFG7EKhakoTT2I7J4dzE3uW+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728459432; c=relaxed/simple;
	bh=XfUZQFMztASPlyPT5UK5gQ+Ig3GZ13AHRgWR7MM5PTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQXoVqu+9Wmqx/T/OP4WyFdHu3orCNJWKGBAG74pX5i0T6MdTbp/Uo6V0yC9OwKOke51E6W/Qk/Y+tarJS1ueKwFmwHX0K4urAe1Ob8GSb10cx5h7nAPlJCSuL/63HnT+uwzBpyKD51MtnaoNhJlkfjW3FgCIZGbCJI6D5qgTv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LA2tVKZf; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728459426; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=oSl+cGwvm5m4G+tPjkLAH90RmfdMCPQYjH5YWNkUFLo=;
	b=LA2tVKZfFHa1T88orzn/hdDjxibCIYwedW+SbnmsDjoSUXvyUELyuyAT4Nl0sh3fu57KglVeazBXX5eBjQbk8bsyfS8PmYXjQlJqTHKFOIAuvXLsV8flSgRrNqn7BeXcBc5qzLQEoroafq87eSAlUhd0OLs50DqXvu3QoUDc1X0=
Received: from 30.221.130.172(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGi.FKl_1728459424)
          by smtp.aliyun-inc.com;
          Wed, 09 Oct 2024 15:37:05 +0800
Message-ID: <8a40d27c-28f1-467b-9a9e-359b36ee5e33@linux.alibaba.com>
Date: Wed, 9 Oct 2024 15:37:04 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] erofs: use get_tree_bdev_flags() to avoid
 misleading messages
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Allison Karlitskaya <allison.karlitskaya@redhat.com>,
 Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
References: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
 <20241009033151.2334888-2-hsiangkao@linux.alibaba.com>
 <ZwYxVcvyjJR_FM0U@infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ZwYxVcvyjJR_FM0U@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christoph,

On 2024/10/9 15:31, Christoph Hellwig wrote:
> On Wed, Oct 09, 2024 at 11:31:51AM +0800, Gao Xiang wrote:
>> Users can pass in an arbitrary source path for the proper type of
>> a mount then without "Can't lookup blockdev" error message.
>>
>> Reported-by: Allison Karlitskaya <allison.karlitskaya@redhat.com>
>> Closes: https://lore.kernel.org/r/CAOYeF9VQ8jKVmpy5Zy9DNhO6xmWSKMB-DO8yvBB0XvBE7=3Ugg@mail.gmail.com
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>> changes since v1:
>>   - use new get_tree_bdev_flags().
>>
>>   fs/erofs/super.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 666873f745da..b89836a8760d 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -705,7 +705,9 @@ static int erofs_fc_get_tree(struct fs_context *fc)
>>   	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
>>   		return get_tree_nodev(fc, erofs_fc_fill_super);
>>   
>> -	ret = get_tree_bdev(fc, erofs_fc_fill_super);
>> +	ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
>> +		IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
>> +			GET_TREE_BDEV_QUIET_LOOKUP : 0);
> 
> Why not pass it unconditionally and provide your own more useful
> error message at the end of the function if you could not find any
> source?

My own (potential) concern is that if CONFIG_EROFS_FS_BACKED_BY_FILE
is off, EROFS should just behave as other pure bdev fses since I'm
not sure if some userspace program really relies on
"Can't lookup blockdev" behavior.

.. Yet that is just my own potential worry anyway.

Thanks,
Gao Xiang


