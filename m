Return-Path: <linux-fsdevel+bounces-79616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ib9NyjhqmlqXwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 15:14:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB16222647
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 15:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02E5530A0A59
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 14:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857793A9DBA;
	Fri,  6 Mar 2026 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fitQoMJd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AD73A0B34;
	Fri,  6 Mar 2026 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772806207; cv=none; b=bh4SrXcOUt6r9sW0omVLdYLrFhNIm58vED+uiX9jtcX5+bmK7glNCmm9nTO0gXFDooCZg3QMh/PYoZc/zAWqGp1gpybgCQ6fABJFZWc13hQ1mHYvGLdnVLCmwRqbpkxseBV3KGFRz+nzrqDYbBciAbCIHUgpPpI/gnSyais3KCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772806207; c=relaxed/simple;
	bh=iDiphLB3+LroTxRf8iD8d+0ZJp+9+0ekiUYFbxVK2IE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RzRNEYwfaFsc6H/uva0DDEHPTfnw0VbZ5nYYbUzP+MTGE4MoP6eKBkK6q5mYL7vFXLfrsxMLU3lH42eKtjGoyRU0C0XVp8zEWyQsWqEUzDvTJcnurrG6u9Uy9t/Z50nj8t3193CCiXaJqmQjQGmwev1Tw+DX7l/3HSRm8LBYolc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fitQoMJd; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772806201; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XcLU/i8K5pO9ggTTWOdofqXY7gkO3uQw71BHBsiPbTU=;
	b=fitQoMJdiJ5iFfgWWI4XFg2viJ8pGo6VaOf8v54+7dz+GWbZak276WVXKAkt6uK0LIYAX3D5xxGdn89nfj035VWBHxHeyXDVX6LO3BcHc4ZMjf3AUj6Mtr40RYv4CeQBZ0r+3RcSdxA9X6gyKjlq2V0XqLTEb6l+bfDAtk0kIlE=
Received: from 30.171.201.59(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0X-NRVWS_1772806200 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Mar 2026 22:10:01 +0800
Message-ID: <084f9ce5-3532-4455-834e-c4a096e5ecd7@linux.alibaba.com>
Date: Fri, 6 Mar 2026 22:10:00 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: move page cache invalidation after AIO to workqueue
To: Cheng Ding <cding@ddn.com>, Bernd Schubert <bschubert@ddn.com>,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260303-async-dio-aio-cache-invalidation-v1-1-fba0fd0426c3@ddn.com>
 <8e322296-52c7-4826-adb3-7fb476cdf35b@linux.alibaba.com>
 <LV1PR19MB88707F9B1F84DC199F99BF25BC7AA@LV1PR19MB8870.namprd19.prod.outlook.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <LV1PR19MB88707F9B1F84DC199F99BF25BC7AA@LV1PR19MB8870.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5AB16222647
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-79616-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jefflexu@linux.alibaba.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Action: no action



On 3/6/26 6:11 PM, Cheng Ding wrote:
> 
>> After reverting my previous patch, I think it would be cleaner by:
>>
>>
>> "The page cache invalidation for FOPEN_DIRECT_IO write in
>> fuse_direct_io() is moved to fuse_direct_write_iter() (with any progress
>> in write), to keep consistent with generic_file_direct_write().  This
>> covers the scenarios of both synchronous FOPEN_DIRECT_IO write
>> (regardless FUSE_ASYNC_DIO) and asynchronous FOPEN_DIRECT_IO write
>> without FUSE_ASYNC_DIO.
> 
> This suggestion sounds good to me.
> 
>>
>>
>>>
>>> +int sb_init_dio_done_wq(struct super_block *sb);
>>> +
>>
>> #include "../internal.h” ?
> 
> We prefer to keep FUSE independent from other parts of the kernel. This way, we can create DKMS packages for the FUSE kernel module.
> 
>>> +                     if (!inode->i_sb->s_dio_done_wq)
>>> +                             res = sb_init_dio_done_wq(inode->i_sb);
>>
>> Better to call sb_init_dio_done_wq() from fuse_direct_IO(), and fail the
>> IO directly if sb_init_dio_done_wq() fails.
>>
>>> +                     if (res >= 0) {
>>> +                             INIT_WORK(&io->work, fuse_aio_invalidate_worker);
>>> +                             queue_work(inode->i_sb->s_dio_done_wq, &io->work);
>> +                             return;
>>                        }
>>
>> Otherwise, the page cache invalidation would be missed if the previous
>> sb_init_dio_done_wq() fails.
> 
> If sb_init_dio_done_wq() fails, res contains the error code, which will be passed to iocb->ki_complete(). However, I can change this if you still prefer to do that in fuse_direct_IO().
> 

Yes I still prefer initializing sb->s_dio_done_wq in advance in
fuse_direct_IO().  Otherwise even you fail the direct IO on failure of
sb_init_dio_done_wq(), the data has been written to the file.


-- 
Thanks,
Jingbo


