Return-Path: <linux-fsdevel+bounces-73185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAD6D10A3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 06:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6EE2303EB83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 05:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFC930F7F7;
	Mon, 12 Jan 2026 05:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ha7qoWJc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out199-10.us.a.mail.aliyun.com (out199-10.us.a.mail.aliyun.com [47.90.199.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A518D30E858;
	Mon, 12 Jan 2026 05:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768196248; cv=none; b=bAkmQVAjc8IBOdcYh60z2Ja2Hk950lJ58pFNO3LdPrAojsqlen1WQgeDuarSzMcmnMFAq4QEo7I3hk42zMmEyXPvgU0UZI4idbWb6JqeJN04kA7o7A2guzYgk6MgcCQPD6PwdCGXcC/BPtSF10yEggCsJg/+y/HO9GnKKaJYgn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768196248; c=relaxed/simple;
	bh=G10CJ/Rm0wCunDiKP0+ATuRlyrGc8OJMqhTJxpAIh9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VLmQATZ7oQPGe5dI7P+gb9gpLJYKZK6S2a3vpWfXUbCZWXOTbn25iwbITyFh/gK7vCM38X5pzblKw1A4/xCqdn2oXKShqZnYD15aMFnWZsK91LC0k3Rp3ICwZgl5HRnhoXQP/tPXbOXkmGqP4ZaP1Y8ad2wWR50r+YxoAmUJbUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ha7qoWJc; arc=none smtp.client-ip=47.90.199.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768196233; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=AXBSKDHZeHbsdANJOu+pjeED3VTgQreQe91U9uiqOEg=;
	b=Ha7qoWJczCAYhhckTUrNFzvZPdEEF4zdqms9yMnIT4x3EM2kpc1tRuCyVMH183vraIbq6876Cpt8MNab1+JrW8LsY+YdLTA6FyvdMfnVYKFc0D9q1YLYPV6YO/ZN9UI5cjMklkEdJ/AOYF7xKHt1IF5iOsLs0+3AE7YFoAKpIt0=
Received: from 30.221.149.62(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WwoLcyY_1768196232 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 12 Jan 2026 13:37:13 +0800
Message-ID: <19757b9e-1193-42cb-8d11-33c4e92336cf@linux.alibaba.com>
Date: Mon, 12 Jan 2026 13:37:12 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fuse: invalidate the page cache after direct write
To: Markus Elfring <Markus.Elfring@web.de>, linux-fsdevel@vger.kernel.org,
 Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260111073701.6071-1-jefflexu@linux.alibaba.com>
 <abb96eb3-49fe-42bf-aae1-a1bf5e7a3827@web.de>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <abb96eb3-49fe-42bf-aae1-a1bf5e7a3827@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/11/26 4:18 PM, Markus Elfring wrote:
> …
>> +++ b/fs/fuse/file.c
>> @@ -667,6 +667,18 @@ static void fuse_aio_complete(struct fuse_io_priv *io, int err, ssize_t pos)
>>  			struct inode *inode = file_inode(io->iocb->ki_filp);
>>  			struct fuse_conn *fc = get_fuse_conn(inode);
>>  			struct fuse_inode *fi = get_fuse_inode(inode);
>> +			struct address_space *mapping = io->iocb->ki_filp->f_mapping;
>> +
>> +			/*
>> +			 * As in generic_file_direct_write(), invalidate after the
>> +			 * write, to invalidate read-ahead cache that may have competed
>> +			 * with the write.
>> +			 */
>> +			if (io->write && res && mapping->nrpages) {
>> +				invalidate_inode_pages2_range(mapping,
>> +						io->offset >> PAGE_SHIFT,
>> +						(io->offset + res - 1) >> PAGE_SHIFT);
>> +			}
>>  
>>  			spin_lock(&fi->lock);
> …
>> @@ -1160,10 +1174,26 @@ static ssize_t fuse_send_write(struct fuse_io_args *ia, loff_t pos,
> …
> -	return err ?: ia->write.out.size;
>> +	/*
>> +	 * Without FOPEN_DIRECT_IO, generic_file_direct_write() does the
>> +	 * invalidation for us.
>> +	 */
>> +	if (!err && written && mapping->nrpages &&
>> +	    (ff->open_flags & FOPEN_DIRECT_IO)) {
>> +		/*
>> +		 * As in generic_file_direct_write(), invalidate after the
>> +		 * write, to invalidate read-ahead cache that may have competed
>> +		 * with the write.
>> +		 */
>> +		invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT,
>> +					(pos + written - 1) >> PAGE_SHIFT);
>> +	}
>> +
>> +	return err ?: written;
> …
> 
> You may omit curly brackets at selected source code places.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v6.19-rc4#n197
> 

It's generally true for **simple** single statement.  I would prefer
adding the braces as it's a multi-line statement with a comment block.


-- 
Thanks,
Jingbo


