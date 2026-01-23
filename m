Return-Path: <linux-fsdevel+bounces-75211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJW8KhYOc2ntrwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 06:58:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BFF70A80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 06:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7767C30089AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 05:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1EC3A0EA3;
	Fri, 23 Jan 2026 05:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HLI9Gd2S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA2838B989;
	Fri, 23 Jan 2026 05:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769147906; cv=none; b=hf/ufevu4mQ38bhFfT+PJBWgCE4HZmD6zgTkTnIxP/PNQtPy5v8VkTVqQC9ahlXDJ9+uH8+APOdl8xUKrKc7o2JbrKsDUdYvd3jMsle+/OK1KdOGTx6xAsyhQ/S6o6XjBW4tfeynM5Q2asBZgrLOxsZY/7O3MQwuH9+e0mQZ59I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769147906; c=relaxed/simple;
	bh=soj8YrIn/LujH0KJTTyfUsIMzMl4TBpTSTHKib+lIdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bxPES0BpEPBN0BFyG3sJRZmLLiP8WTsEgXFCm8bL7lDiP8lDCDR+gMk4Eh28LrJ9FGz51va/bzonSqR1/VyNspRLAZM2wMY2qIec6TJ3Wmiio6hTl1HeSijrCR4HN5DU1zhPpX3mtnktLdX887CVc+dnQrRBVLZmJsiPnDUmbyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HLI9Gd2S; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769147893; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qgiEgvnwbNmHMoJ9+JISig9U0fmQoZ1zNWWDsz5ZOb4=;
	b=HLI9Gd2SVtOOz7EQCQwve9FXfpm+98VEIAv5E7yB7ltfRrRtOu9fNllRFzd9Z8qC5BXjgpQHUSMhGb9WVxR/+qCR2o8bBSs48/1zYk+FkR2GcFZ9YRl5WcphB75TYeoxQlYW6XNxcJFHpbnHguZROYPAp/sG4HbOZbDEw+Bc3AE=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wxehcdl_1769147891 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 Jan 2026 13:58:12 +0800
Message-ID: <aa71c034-abf1-4861-8440-e327e535ed7e@linux.alibaba.com>
Date: Fri, 23 Jan 2026 13:58:11 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
To: Christoph Hellwig <hch@lst.de>
Cc: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, djwong@kernel.org,
 amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>, oliver.yang@linux.alibaba.com
References: <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com>
 <20260119083251.GA5257@lst.de>
 <b29b112e-5fe1-414b-9912-06dcd7d7d204@linux.alibaba.com>
 <20260119092220.GA9140@lst.de>
 <73f2c243-e029-4f95-aa8e-285c7affacac@linux.alibaba.com>
 <50db56b8-4cf9-4d62-b242-c982a260a330@linux.alibaba.com>
 <20260120065242.GA3436@lst.de>
 <5892c7bb-f06e-45d7-ad84-99837788e5ab@linux.alibaba.com>
 <20260122083310.GA27928@lst.de>
 <abb1f8f4-c5cd-416b-b346-046d3fa8408c@linux.alibaba.com>
 <20260123053936.GA24828@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260123053936.GA24828@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[huawei.com,kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org,linux-foundation.org,linux.alibaba.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75211-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72BFF70A80
X-Rspamd-Action: no action



On 2026/1/23 13:39, Christoph Hellwig wrote:
> On Thu, Jan 22, 2026 at 04:40:56PM +0800, Gao Xiang wrote:
>>> Having multiple folios for the same piece of memory can't work,
>>> at we'd have unsynchronized state.
>>
>> Why not just left unsynchronized state in a unique way,
>> but just left mapping + indexing seperated.
> 
> That would not just require allocating the folios dynamically, but most
> importantly splitting it up.  We'd then also need to find a way to chain
> the folio_link structures from the main folio.  I'm not going to see this
> might not happen, but it feels very far out there and might have all
> kinds of issues.

I can see the way, but at least I don't have any resource,
and I'm even not sure it will happen in the foresee future,
so that is why we will not wait for per-folio sharing
anymore (memory is already becoming $$$$$$..).

> 
>>>>> I think the concept of using a backing file of some sort for the shared
>>>>> pagecache (which I have no problem with at all), vs the imprecise
>>>>
>>>> In that way (actually Jingbo worked that approach in 2023),
>>>> we have to keep the shared data physically contiguous and
>>>> even uncompressed, which cannot work for most cases.
>>>
>>> Why does that matter?
>>
>> Sorry then, I think I don't get the point, but we really
>> need this for the complete page cache sharing on the
>> single physical machine.
> 
> Why do you need physically contigous space to share it that way?

Yes, it won't be necessary, but the main goal is to share
various different filesystem images with consensus per-inode
content-addressable IDs, either secure hashs or per-inode UUIDs.

I still think it's very useful considering finer-grain page
cache sharing can only exist in our heads so I will go on use
this way for everyone to save memory (considering AI needs
too much memory and memory becomes more expensive.)

> 
>>>
>>>> On the other side, I do think `fingerprint` from design
>>>> is much like persistent NFS file handles in some aspect
>>>> (but I don't want to equal to that concept, but very
>>>> similar) for a single trusted domain, we should have to
>>>> deal with multiple filesystem sources and mark in a
>>>> unique way in a domain.
>>>
>>> I don't really thing they are similar in any way.
>>
>> Why they are not similiar, you still need persistent IDs
>> in inodes for multiple fses, if there are a
>> content-addressable immutable filesystems working in
>> inodes, they could just use inode hashs as file handles
>> instead of inode numbers + generations.
> 
> Sure, if they are well defined, cryptographically secure hashes.  But

EROFS is a golden image filesystem generated purely in
userspace, vendors will use secure hashs or
per-vendor-generated per-inode UUID.

> that's different from file handles, which don't address content at all,
> but are just a handle to given file that bypasses the path lookup.

I agree, so I once said _somewhat_ similar.  Considering
content-addressable filesystems, of course they could use
simplifed secure hashs as file handles in some form.

Thanks,
Gao Xiang

> 
>>
>> Thanks,
>> Gao Xiang
> ---end quoted text---


