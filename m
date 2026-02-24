Return-Path: <linux-fsdevel+bounces-78213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFU6F2z/nGnhMQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 02:31:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F311807C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 02:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11269306815C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 01:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D541DB356;
	Tue, 24 Feb 2026 01:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FOwP6hge"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5E81F92E;
	Tue, 24 Feb 2026 01:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771896643; cv=none; b=Dtj6sc0bSrnEyYJ5o8sn0YdCQlSToCvtCzLJCMQLSrDAAu9msrcM8OsiwGKe5gFOvmf1ZsgwqpULaFcKGjYEJR+FlixwoZI4PzP4OfCf7FNU72GJKsy4P4hlXANqUbIVHRlo2Pl6w89TnNGxWGpNWgF1XwjSwuPSBlKbefpNk9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771896643; c=relaxed/simple;
	bh=ZGpbjO+WU5On/I75If00vo6Wru1h2W4dyUxA+CMV3og=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=P4xla6erKy7NZbsg27Q03NQNsmnHGGoztykhMqQdICDB6OKp2bONe55qPkMejDDsw0XH6M4BjeOy0DJAM44OrDNjAZKxNMoTrtAgSBxa7I/9MKpa0RF70xqm+USKIgVZXUlGygIzl1klnwN+jDLZebtI7ID+CF2MmpjstOwiCRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FOwP6hge; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YxJR66oPaQm74nkXfQW8ipWh/0NdzqGNUh8ajE84pzs=;
	b=FOwP6hge41wJG6n0sf1CamOp0/PL7Nic/Vn/CJF3FgzfmmGQYgLTaPk56vsKG3m5BhyBWQXjv
	c3nmbOf1ksl8bV31nLV5mMFL+kCnaOUM++4Vdgh4Jb7rgVIyn8p5QpwqpK9bn1GypqZ9N9dNWBk
	4v9XghGNub5hRIc89yCUh98=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fKg5n72sMznTVV;
	Tue, 24 Feb 2026 09:25:49 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 72532402AB;
	Tue, 24 Feb 2026 09:30:31 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Feb 2026 09:30:30 +0800
Subject: Re: [PATCH] dcache: Limit the minimal number of bucket to two
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jan Kara
	<jack@suse.cz>, Christoph Hellwig <hch@lst.de>
References: <20260130034853.215819-1-chengzhihao1@huawei.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <ddd544aa-3d31-00f4-abc2-4da8376f81ff@huawei.com>
Date: Tue, 24 Feb 2026 09:30:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260130034853.215819-1-chengzhihao1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500005.china.huawei.com (7.202.194.90)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-78213-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chengzhihao1@huawei.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim,huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8F311807C8
X-Rspamd-Action: no action

ÔÚ 2026/1/30 11:48, Zhihao Cheng Ð´µÀ:
friendly ping...
> There is an OOB read problem on dentry_hashtable when user sets
> 'dhash_entries=1':
>    BUG: unable to handle page fault for address: ffff888b30b774b0
>    #PF: supervisor read access in kernel mode
>    #PF: error_code(0x0000) - not-present page
>    Oops: Oops: 0000 [#1] SMP PTI
>    RIP: 0010:__d_lookup+0x56/0x120
>     Call Trace:
>      d_lookup.cold+0x16/0x5d
>      lookup_dcache+0x27/0xf0
>      lookup_one_qstr_excl+0x2a/0x180
>      start_dirop+0x55/0xa0
>      simple_start_creating+0x8d/0xa0
>      debugfs_start_creating+0x8c/0x180
>      debugfs_create_dir+0x1d/0x1c0
>      pinctrl_init+0x6d/0x140
>      do_one_initcall+0x6d/0x3d0
>      kernel_init_freeable+0x39f/0x460
>      kernel_init+0x2a/0x260
> 
> There will be only one bucket in dentry_hashtable when dhash_entries is
> set as one, and d_hash_shift is calculated as 32 by dcache_init(). Then,
> following process will access more than one buckets(which memory region
> is not allocated) in dentry_hashtable:
>   d_lookup
>    b = d_hash(hash)
>      dentry_hashtable + ((u32)hashlen >> d_hash_shift)
>      // The C standard defines the behavior of right shift amounts
>      // exceeding the bit width of the operand as undefined. The
>      // result of '(u32)hashlen >> d_hash_shift' becomes 'hashlen',
>      // so 'b' will point to an unallocated memory region.
>    hlist_bl_for_each_entry_rcu(b)
>     hlist_bl_first_rcu(head)
>      h->first  // read OOB!
> 
> Fix it by limiting the minimal number of dentry_hashtable bucket to two,
> so that 'd_hash_shift' won't exceeds the bit width of type u32.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>   fs/dcache.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 66dd1bb830d1..957a44d2c44a 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -3260,7 +3260,7 @@ static void __init dcache_init_early(void)
>   					HASH_EARLY | HASH_ZERO,
>   					&d_hash_shift,
>   					NULL,
> -					0,
> +					2,
>   					0);
>   	d_hash_shift = 32 - d_hash_shift;
>   
> @@ -3292,7 +3292,7 @@ static void __init dcache_init(void)
>   					HASH_ZERO,
>   					&d_hash_shift,
>   					NULL,
> -					0,
> +					2,
>   					0);
>   	d_hash_shift = 32 - d_hash_shift;
>   
> 


