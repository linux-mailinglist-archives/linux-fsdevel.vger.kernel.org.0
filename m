Return-Path: <linux-fsdevel+bounces-74764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yG7uKhEscGniWwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 02:29:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A604F1A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 02:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3F6A5CC9A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 01:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBF9309DCB;
	Wed, 21 Jan 2026 01:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FXRJFSGm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3012882C5;
	Wed, 21 Jan 2026 01:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768958973; cv=none; b=R3moMfIXogN3Hk1uAMZxWSdwJbXsZWHoAl3zEwXSSCerk7RsrPRVnOmwfuFT9rD+WN98Nmi4Ra7NLGWSbAdQTko1u/778YrOsXRd8kqX+RIDv6mjWfmtyXQEoYHClSRNG0mk6F45IfNz5YO1j39bOgqbmfMiZIWuAw1SL+jLy0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768958973; c=relaxed/simple;
	bh=not0Im7NTduRYbKmfzZO5yfOy1+fkYiTmZzeg1NMnOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QwfxI40ZJT80R0SNWUvRX3qpmnmZ1OtVZl3VKjmI00Vg2iTz7l+Sw7Wva/iQuCcf+5suCS7cnhlEggpv6BnI509itjyWxPtfgcd2XSFWLGqfubWptPVsR5nadn7rUwsMm7wiDSeAv9PmqIofUH3/XGOl0lV03o8KRFblVnQqTkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FXRJFSGm; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4tq8UHj7aVk7k1iPD/wf4mLlV9TgYl5jy5aGiJC9N7M=;
	b=FXRJFSGmcLcnGjPztrRgauytaQSjWoUYFoweipDZ4ER/5Dl409paUqvCBR2iKRaBGH3As6Ofa
	bo09ujyT/kibiCLP+9l6zLZtd+1aFjXbSHt3jPwHfIiwwnAtttDee1dpVGTS1k/b38WpHmj43EI
	6gZHuNF55UKAt341smYucgg=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dwmjK1PB8zpStY;
	Wed, 21 Jan 2026 09:25:41 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A1E740567;
	Wed, 21 Jan 2026 09:29:26 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 21 Jan 2026 09:29:25 +0800
Message-ID: <45c45182-e0f3-4b69-869f-5a0a90d543f5@huawei.com>
Date: Wed, 21 Jan 2026 09:29:25 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <chao@kernel.org>,
	<brauner@kernel.org>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
References: <20260116095550.627082-1-lihongbo22@huawei.com>
 <20260116095550.627082-6-lihongbo22@huawei.com>
 <3ae9078a-ba5c-460d-89ea-8fdbdf190a10@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <3ae9078a-ba5c-460d-89ea-8fdbdf190a10@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[huawei.com,quarantine];
	DKIM_TRACE(0.00)[huawei.com:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lst.de,vger.kernel.org,lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74764-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-fsdevel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,huawei.com:email,huawei.com:dkim,huawei.com:mid]
X-Rspamd-Queue-Id: 22A604F1A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/1/20 22:19, Gao Xiang wrote:
> 
> 
> On 2026/1/16 17:55, Hongbo Li wrote:
>> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>
>> Currently, reading files with different paths (or names) but the same
>> content will consume multiple copies of the page cache, even if the
>> content of these page caches is the same. For example, reading
>> identical files (e.g., *.so files) from two different minor versions of
>> container images will cost multiple copies of the same page cache,
>> since different containers have different mount points. Therefore,
>> sharing the page cache for files with the same content can save memory.
>>
>> This introduces the page cache share feature in erofs. It allocate a
>> deduplicated inode and use its page cache as shared. Reads for files
>> with identical content will ultimately be routed to the page cache of
>> the deduplicated inode. In this way, a single page cache satisfies
>> multiple read requests for different files with the same contents.
>>
>> We introduce inode_share mount option to enable the page sharing mode
>> during mounting.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>>   Documentation/filesystems/erofs.rst |   5 +
>>   fs/erofs/Makefile                   |   1 +
>>   fs/erofs/inode.c                    |  24 +----
>>   fs/erofs/internal.h                 |  57 ++++++++++
>>   fs/erofs/ishare.c                   | 161 ++++++++++++++++++++++++++++
>>   fs/erofs/super.c                    |  56 +++++++++-
>>   fs/erofs/xattr.c                    |  34 ++++++
>>   fs/erofs/xattr.h                    |   3 +
>>   8 files changed, 316 insertions(+), 25 deletions(-)
>>   create mode 100644 fs/erofs/ishare.c
>>
>> diff --git a/Documentation/filesystems/erofs.rst 
>> b/Documentation/filesystems/erofs.rst
>> index 08194f194b94..27d3caa3c73c 100644
>> --- a/Documentation/filesystems/erofs.rst
>> +++ b/Documentation/filesystems/erofs.rst
>> @@ -128,7 +128,12 @@ device=%s              Specify a path to an extra 
>> device to be used together.
>>   fsid=%s                Specify a filesystem image ID for Fscache 
>> back-end.
>>   domain_id=%s           Specify a domain ID in fscache mode so that 
>> different images
>>                          with the same blobs under a given domain ID 
>> can share storage.
>> +                       Also used for inode page sharing mode which 
>> defines a sharing
>> +                       domain.
> 
> I think either the existing or the page cache sharing
> here, `domain_id` should be protected as sensitive
> information, so it'd be helpful to protect it as a
> separate patch.
> 
> And change the description as below:
>                             Specify a trusted domain ID for fscache mode 
> so that
>                             different images with the same blobs, 
> identified by blob IDs,
>                             can share storage within the same trusted 
> domain.
>                             Also used for different filesystems with 
> inode page sharing
>                             enabled to share page cache within the 
> trusted domain.
> 
> 
>>   fsoffset=%llu          Specify block-aligned filesystem offset for 
>> the primary device.
>> +inode_share            Enable inode page sharing for this 
>> filesystem.  Inodes with
>> +                       identical content within the same domain ID 
>> can share the
>> +                       page cache.
>>   ===================    
>> =========================================================
> 
> ...
> 
> 
>>       erofs_exit_shrinker();
>> @@ -1062,6 +1111,8 @@ static int erofs_show_options(struct seq_file 
>> *seq, struct dentry *root)
>>           seq_printf(seq, ",domain_id=%s", sbi->domain_id);
> 
> I think we shouldn't show `domain_id` to the userspace
> entirely.
> 
> Also, let's use kfree_sentitive() and no_free_ptr() to
> replace the following snippet:
> 
>           case Opt_domain_id:
>                  kfree(sbi->domain_id); -> kfree_sentitive

Ok, kfree_sensitive/no_free_ptr looks good, this way makes domain_id 
more reliable.

Thanks,
Hongbo

>                  sbi->domain_id = kstrdup(param->string, GFP_KERNEL);
>                       -> sbi->domain_id = no_free_ptr(param->string);
>                  if (!sbi->domain_id)
>                          return -ENOMEM;
>                  break;
> 
> And replace with kfree_sentitive() for domain_id everywhere.
> 
> Thanks,
> Gao Xiang

