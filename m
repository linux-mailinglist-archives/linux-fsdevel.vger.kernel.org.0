Return-Path: <linux-fsdevel+bounces-75234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNI6JWUmc2kAswAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:42:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8F271E97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D0FF3016ECC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 07:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB0B33DEF6;
	Fri, 23 Jan 2026 07:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VqZBBVRl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5A933ADAC;
	Fri, 23 Jan 2026 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769154141; cv=none; b=VjohzIbgej3qATgekRtqzVbvp72GCFaHcwnKofQOJz1nxGrs47yA8gqRhVo7lwziIUSrKYGVB5X9R2VOIsCTlC/u9FiHLAELeprsOpfWHijDrfJb3nIye0Dk9RyjtOiq3dg7dH8yRHqkI8tpzcrBfL6OG9iXH36nZ73k59wXYzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769154141; c=relaxed/simple;
	bh=Bggp12pKZabV9i+EARZqD0KmyF1ktmDH8j000pCLm3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+xgBdYqlDgpbU1ocW5IDJa0bRYe4fQ/4FOdaMgPfiGMsY5y0B8FGZQnIHHu5SxmuOw5+sS8VvU9UC60Rtwl+46uCsP33rsjr+ro0+xIecfuEUkhC4OKFdhzWRRlxqec8Y3L+S66zsKy8/dTk5vvzKc0EKYNMIozWu22nOOpr7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VqZBBVRl; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769154136; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WdcxlWt6tlFFJCr6TlsKyX2Fw2k1tpZaSSFEJHukB3A=;
	b=VqZBBVRl67KCApzQfjQ7/o1s5cVso75O/1pGf1MkGEWYu70r0S2gnsQdIe8DwO0lPWB+SsRoYs1xSS7sJYoKh/BFduv0gLRm94F4UvvUIiVpdhEpVSihw3JbN/sRawL7BH245hP4/8e/y73RYuhCQlgGcfa7mUcMCM0OSKPqrOc=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wxf-YOt_1769154134 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 Jan 2026 15:42:15 +0800
Message-ID: <e0b170ec-253e-49ed-be62-9a90e9eb9053@linux.alibaba.com>
Date: Fri, 23 Jan 2026 15:42:14 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 04/10] erofs: add erofs_inode_set_aops helper to set
 the aops.
To: Christoph Hellwig <hch@lst.de>, Hongbo Li <lihongbo22@huawei.com>
Cc: chao@kernel.org, brauner@kernel.org, djwong@kernel.org,
 amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260122133718.658056-1-lihongbo22@huawei.com>
 <20260122133718.658056-5-lihongbo22@huawei.com>
 <b20b263d-132b-464e-8314-d3f795e5e582@linux.alibaba.com>
 <20260123061825.GA25722@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260123061825.GA25722@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75234-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC8F271E97
X-Rspamd-Action: no action



On 2026/1/23 14:18, Christoph Hellwig wrote:
> On Thu, Jan 22, 2026 at 09:54:15PM +0800, Gao Xiang wrote:
>>> @@ -455,6 +455,29 @@ static inline void *erofs_vm_map_ram(struct page **pages, unsigned int count)
>>>    	return NULL;
>>>    }
>>>    +static inline int erofs_inode_set_aops(struct inode *inode,
>>> +				       struct inode *realinode, bool no_fscache)
>>> +{
>>> +	if (erofs_inode_is_data_compressed(EROFS_I(realinode)->datalayout)) {
>>> +		if (!IS_ENABLED(CONFIG_EROFS_FS_ZIP))
>>> +			return -EOPNOTSUPP;
>>> +		DO_ONCE_LITE_IF(realinode->i_blkbits != PAGE_SHIFT,
>>> +			  erofs_info, realinode->i_sb,
>>> +			  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
>>> +		inode->i_mapping->a_ops = &z_erofs_aops;
>>
>> Is that available if CONFIG_EROFS_FS_ZIP is undefined?
> 
> z_erofs_aops is declared unconditionally, and the IS_ENABLED above
> ensures the compiler will never generate a reference to it.
> 
> So this is fine, and a very usualy trick to make the code more
> readable.

Yeah, I get your point, that is really helpful and I haven't
used that trick.

The other problem was the else part is incorrect, Hongbo,
how about applying the following code and resend the next
version, I will apply all patches later:

static inline int erofs_inode_set_aops(struct inode *inode,
                                        struct inode *realinode, bool no_fscache)
{
         if (erofs_inode_is_data_compressed(EROFS_I(realinode)->datalayout)) {
                 if (!IS_ENABLED(CONFIG_EROFS_FS_ZIP))
                         return -EOPNOTSUPP;
                 DO_ONCE_LITE_IF(realinode->i_blkbits != PAGE_SHIFT,
                           erofs_info, realinode->i_sb,
                           "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
                 inode->i_mapping->a_ops = &z_erofs_aops;
                 return 0;
         }
         inode->i_mapping->a_ops = &erofs_aops;
         if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && !no_fscache &&
             erofs_is_fscache_mode(realinode->i_sb))
                 inode->i_mapping->a_ops = &erofs_fscache_access_aops;
         if (IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) &&
             erofs_is_fileio_mode(EROFS_SB(realinode->i_sb)))
                 inode->i_mapping->a_ops = &erofs_fileio_aops;
         return 0;
}

Thanks,
Gao Xiang

