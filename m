Return-Path: <linux-fsdevel+bounces-74997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLFAJnfkcWk+MgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 09:48:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C3C63681
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 09:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 401D15C5207
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 08:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D84133EAF3;
	Thu, 22 Jan 2026 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WFcaReBh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F782E414;
	Thu, 22 Jan 2026 08:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769071267; cv=none; b=MolxB9bRUrxOSrDJwNB6SCnhWjI2BVGaZ9NfRZzmDUy2VM25+2sTOL6A8AHKbZBjDOf3RTyAnUZdq7z0unAINL0beEn9CAUpHh2iv4UlygHpAeQOpVGwVP+UwDV2SpCKFNXQOPjLUZlW+MCuEYeWCbgoTNQkDPgbiZdTMyqx0ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769071267; c=relaxed/simple;
	bh=tP9is0/H7vqHiwvdJ5kbuXSDgP/FdiFh7Ii0X89G5BA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDuJtja00EhSmgeyBy9AWNX2BVG0mWun506FfGhrrdhYBcFG38W4QT392NoT8eD2Iz4qNUA8GxRDjFpc1qR8MM9nbQ69x3WUaQRqpDmKuf4tQAjWrKb8m9V8HRMXIr4QEgPgPqBRPTeoSLINPgnALIaucTiCKYGI7d5Gyy93b0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WFcaReBh; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769071259; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gJSzOWSqPre+2yZ8/cQcaEgo/1k5YiDdjzLGF45ntF8=;
	b=WFcaReBhDlm2rnq4OeLezvOIKLuIn2sVr+qaxj6AYFkxHip3wogyyghyTLZYU9cwylWwMmEtb9eQtg5BRne7zj7tg9yYeTjXEWs/HkBR2ZtkWoBkrkfvdi3p6MVNnP5ST1N3gj1/IFKDsToK2lHqV3I2gStAFzE+VspfFSOgOyw=
Received: from 30.221.131.199(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxbgvIV_1769071257 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 Jan 2026 16:40:58 +0800
Message-ID: <abb1f8f4-c5cd-416b-b346-046d3fa8408c@linux.alibaba.com>
Date: Thu, 22 Jan 2026 16:40:56 +0800
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
References: <af1f3ff6-a163-4515-92bf-44c9cf6c92f3@linux.alibaba.com>
 <20260119072932.GB2562@lst.de>
 <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com>
 <20260119083251.GA5257@lst.de>
 <b29b112e-5fe1-414b-9912-06dcd7d7d204@linux.alibaba.com>
 <20260119092220.GA9140@lst.de>
 <73f2c243-e029-4f95-aa8e-285c7affacac@linux.alibaba.com>
 <50db56b8-4cf9-4d62-b242-c982a260a330@linux.alibaba.com>
 <20260120065242.GA3436@lst.de>
 <5892c7bb-f06e-45d7-ad84-99837788e5ab@linux.alibaba.com>
 <20260122083310.GA27928@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260122083310.GA27928@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-8.96 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[huawei.com,kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org,linux-foundation.org,linux.alibaba.com];
	TAGGED_FROM(0.00)[bounces-74997-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.alibaba.com,none];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: 44C3C63681
X-Rspamd-Action: no action



On 2026/1/22 16:33, Christoph Hellwig wrote:
> On Tue, Jan 20, 2026 at 03:19:21PM +0800, Gao Xiang wrote:
>>> It will be very hard to change unless we move to physical indexing of
>>> the page cache, which has all kinds of downside.s
>>
>> I'm not sure if it's really needed: I think the final
>> folio adaption plan is that folio can be dynamic
>> allocated? then why not keep multiple folios for a
>> physical memory, since folios are not order-0 anymore.
> 
> Having multiple folios for the same piece of memory can't work,
> at we'd have unsynchronized state.

Why not just left unsynchronized state in a unique way,
but just left mapping + indexing seperated.

Anyway, that is just a wild thought, I will not dig
into that.

> 
>> Using physical indexing sounds really inflexible on my
>> side, and it can be even regarded as a regression for me.
> 
> I'm absolutely not arguing for that..
> 
>>>> So that let's face the reality: this feature introduces
>>>> on-disk xattrs called "fingerprints." --- Since they're
>>>> just xattrs, the EROFS on-disk format remains unchanged.
>>>
>>> I think the concept of using a backing file of some sort for the shared
>>> pagecache (which I have no problem with at all), vs the imprecise
>>
>> In that way (actually Jingbo worked that approach in 2023),
>> we have to keep the shared data physically contiguous and
>> even uncompressed, which cannot work for most cases.
> 
> Why does that matter?

Sorry then, I think I don't get the point, but we really
need this for the complete page cache sharing on the
single physical machine.

> 
>> On the other side, I do think `fingerprint` from design
>> is much like persistent NFS file handles in some aspect
>> (but I don't want to equal to that concept, but very
>> similar) for a single trusted domain, we should have to
>> deal with multiple filesystem sources and mark in a
>> unique way in a domain.
> 
> I don't really thing they are similar in any way.

Why they are not similiar, you still need persistent IDs
in inodes for multiple fses, if there are a
content-addressable immutable filesystems working in
inodes, they could just use inode hashs as file handles
instead of inode numbers + generations.

Thanks,
Gao Xiang


