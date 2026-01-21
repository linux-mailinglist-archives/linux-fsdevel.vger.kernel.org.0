Return-Path: <linux-fsdevel+bounces-74816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGlLJIiNcGkEYQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 09:25:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 031F5538A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 09:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C3BC4F0096
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 08:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8385B3A63FE;
	Wed, 21 Jan 2026 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="00lkPeLf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475543BBA05
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983604; cv=none; b=r3AjFbE1aDY/gVtdo4ymJ5DcvHwC8zqMKgJPsT5tF2D3EarHvavjFFVq1Nw3BxFdOc2ggjcj3ruBxnjsNwXdH3+NsZ13y3LTeQHzkKexyb4Ce4Scnvk6AAuOfTna56JPGLm1KDEDLgkTL0dU7YTalEDpdlo9ReOuZUMDv1XgE0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983604; c=relaxed/simple;
	bh=cfq46GPoNLHA/8zCcIQDJomG5BK9jjQ53l9unzkB0Kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jJnuDcwYTx+Lacvg1QaNlHLorq/I8qIMn0rbi2ZyP1G/m9m5rE79IzjhL/aPIjU6wRCzQvAnlM7XZ7uYqQiNzEuGIFwZJv4/xyktE0OF7wsSqYxAhC0GMTV3lLK/jrfDM161xPuqN/1dbz7rkV2ghoxEBKCbvQ33miunae/OJR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=00lkPeLf; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TSq6+yOT1HdiMWW0u9Yc+Zl3cqGQ3pgfZNbZ2cq5LD8=;
	b=00lkPeLfx/QR/Ly6HZWxS/zzaQW8FdmDJ2XbgT/4I7N3GVIJXKexwFU/cG+gyO1W9q4zcDfte
	fBhDGI9wOWeVL/NH1h7yhkltJcgP8S9DHFeyq/1Cs1u010nvL3P6BPEJRG1oj3j+U5vBLN696r8
	yopauiLXq/lmdwGknS/gdGY=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dwxpg43L2z1T4H4;
	Wed, 21 Jan 2026 16:15:55 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 2AE58405A8;
	Wed, 21 Jan 2026 16:19:58 +0800 (CST)
Received: from [10.174.179.179] (10.174.179.179) by
 kwepemr500001.china.huawei.com (7.202.194.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 21 Jan 2026 16:19:57 +0800
Message-ID: <baccc29c-a68d-40e3-9e0b-f172d32e3842@huawei.com>
Date: Wed, 21 Jan 2026 16:19:56 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm/khugepaged: free empty xa_nodes when rollbacks in
 collapse_file
To: Matthew Wilcox <willy@infradead.org>
CC: <akpm@linux-foundation.org>, <david@kernel.org>,
	<lorenzo.stoakes@oracle.com>, <ziy@nvidia.com>,
	<baolin.wang@linux.alibaba.com>, <Liam.Howlett@oracle.com>,
	<npache@redhat.com>, <ryan.roberts@arm.com>, <dev.jain@arm.com>,
	<baohua@kernel.org>, <lance.yang@linux.dev>, <shardul.b@mpiricsoftware.com>,
	<linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	<wangkefeng.wang@huawei.com>
References: <20260121062243.1893129-1-tujinjiang@huawei.com>
 <aXB0Zcu4bIEvSSuX@casper.infradead.org>
From: Jinjiang Tu <tujinjiang@huawei.com>
In-Reply-To: <aXB0Zcu4bIEvSSuX@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500001.china.huawei.com (7.202.194.229)
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74816-lists,linux-fsdevel=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[huawei.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tujinjiang@huawei.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 031F5538A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


在 2026/1/21 14:38, Matthew Wilcox 写道:
> On Wed, Jan 21, 2026 at 02:22:43PM +0800, Jinjiang Tu wrote:
>> collapse_file() calls xas_create_range() to pre-create all slots needed.
>> If collapse_file() finally fails, these pre-created slots are empty nodes
>> and aren't destroyed.
> try this instead
>
> diff --git a/fs/inode.c b/fs/inode.c
> index cff1d3af0d57..85886af1e7ab 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -744,22 +744,18 @@ void dump_mapping(const struct address_space *mapping)
>   
>   void clear_inode(struct inode *inode)
>   {
> -	/*
> -	 * We have to cycle the i_pages lock here because reclaim can be in the
> -	 * process of removing the last page (in __filemap_remove_folio())
> -	 * and we must not free the mapping under it.
> -	 */
> -	xa_lock_irq(&inode->i_data.i_pages);
> -	BUG_ON(inode->i_data.nrpages);
>   	/*
>   	 * Almost always, mapping_empty(&inode->i_data) here; but there are
>   	 * two known and long-standing ways in which nodes may get left behind
>   	 * (when deep radix-tree node allocation failed partway; or when THP
> -	 * collapse_file() failed). Until those two known cases are cleaned up,
> -	 * or a cleanup function is called here, do not BUG_ON(!mapping_empty),
> -	 * nor even WARN_ON(!mapping_empty).
> +	 * collapse_file() failed).
> +	 *
> +	 * xa_destroy() also cycles the lock for us, which is needed because
> +	 * reclaim can be in the process of removing the last folio (in
> +	 * __filemap_remove_folio()) and we must not free the mapping under it.
>   	 */
> -	xa_unlock_irq(&inode->i_data.i_pages);
> +	xa_destroy(&inode->i_data.i_pages);
> +	BUG_ON(inode->i_data.nrpages);
>   	BUG_ON(!list_empty(&inode->i_data.i_private_list));
>   	BUG_ON(!(inode->i_state & I_FREEING));
>   	BUG_ON(inode->i_state & I_CLEAR);

I tried it, and the memleak disappears.


