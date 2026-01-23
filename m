Return-Path: <linux-fsdevel+bounces-75219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJTLGHcac2mwsAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 07:51:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C66F571288
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 07:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F550300D46E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 06:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E871E326958;
	Fri, 23 Jan 2026 06:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="MQmvNUye"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C02B31B117
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 06:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769151089; cv=none; b=l0C+cL58DmNsIZzPdw2ptZ0lnMts/hTSYTYTcUymozvfSf7XIBsG8kv74UYHcd1QLlbexLpicofVrXYWidWuYqMzCmQqbXT6kmhEBaJCr5D1GAyJQmiqyWpWOAS4xEXX90rcvXcV+j7KBrGvS54VrlS8TXFPU3ZLwOqjIZncIYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769151089; c=relaxed/simple;
	bh=eqejNXVE9l3kOKW4J3rvhb9J6IdR3oiyVWsGG9+a3ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=amMBl/FNpkHTbnwIhk4LIGK+y0qHLSKpVmjkwQwNJR8rqDLF4gWYnjg4ZlR1w0IuAMEyKFW90+bfE1Ypz1RwzuCGQAbbL49FzKiRxRnAen9HNlCfLZ37rAuCOBQuWciU+/I24kvquNfVtH6CVOXRSiSenAG1Q01dwoQJC2NR2/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=MQmvNUye; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Dq315O0j93dLcFq1bZxcJRTGFPKJRchphpHfHVTtMQs=;
	b=MQmvNUyeyICeQ+LPKkgRlGKf0Tw5IELOxCwPeDuhrzdFigKfHtQdOaBFQIZp3TRHtU6sHWOfH
	ZB0w3K+9gJhOtvyuqGRPSQ43McUZxeh3b6sgr5E3TCQjCJPOCEIHdsHlZn1N+YX8EfDr4YexMR2
	cXQFN1gmVxqdJnvikc/6Tbo=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dy7mF2npkzKm5N;
	Fri, 23 Jan 2026 14:47:57 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id F302A40565;
	Fri, 23 Jan 2026 14:51:22 +0800 (CST)
Received: from [10.174.179.179] (10.174.179.179) by
 kwepemr500001.china.huawei.com (7.202.194.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 23 Jan 2026 14:51:22 +0800
Message-ID: <a1f97fe2-fa7c-4411-b2a0-d19257653863@huawei.com>
Date: Fri, 23 Jan 2026 14:51:21 +0800
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
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500001.china.huawei.com (7.202.194.229)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-75219-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tujinjiang@huawei.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C66F571288
X-Rspamd-Action: no action


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

Hi, Matthew

This appoach is much simpler. Could you please send a formal patch?


