Return-Path: <linux-fsdevel+bounces-8451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87675836C66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 18:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F1ECB29B82
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 16:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65865C8F5;
	Mon, 22 Jan 2024 15:27:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD245C8E3;
	Mon, 22 Jan 2024 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937263; cv=none; b=K/9PLb51Bxecw/UfQ3bwV0p82WepfT7J3E4pqa/Gi5TiEhTcr2cuUte/NWzJ4abZeuXcJnoJClUWGgw4pHxvf9vKPl3hZrxMVp7nEDM77RMb6XhQKpW3Pyssv6pf8ChIUFQNIcF5JmV8IJmehhsH5IRZakU9IQ0/qYyIiO+OzgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937263; c=relaxed/simple;
	bh=n0sygoysHkJeewjl7YHXtgQqFiQVHIy6bAuEeFqcArM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NTBuUQ5Oy9JluPiH0LJZuo3vDfXGxI7AgTQJOoZhxdGb1XHc6hHNBuZvgqVO3QNsn+QXrciYUuK9jAqmme5d1O2zRe8dGO+RIxWKyRxVItCv2LJrpY8pMVKigfYX/M701LCytsUegZys9g8uAYd+RNhzG9hWLIbzUXu7nqEYnpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W.9olfy_1705937254;
Received: from 30.25.251.50(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W.9olfy_1705937254)
          by smtp.aliyun-inc.com;
          Mon, 22 Jan 2024 23:27:37 +0800
Message-ID: <c3ef2de0-e33c-4ccb-afe6-4a46ffa49529@linux.alibaba.com>
Date: Mon, 22 Jan 2024 23:27:34 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] cachefiles, erofs: Fix NULL deref in when
 cachefiles is not doing ondemand-mode
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>
Cc: Jeff Layton <jlayton@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 netfs@lists.linux.dev, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Marc Dionne <marc.dionne@auristor.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20240122123845.3822570-1-dhowells@redhat.com>
 <20240122123845.3822570-7-dhowells@redhat.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240122123845.3822570-7-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/1/22 20:38, David Howells wrote:
> cachefiles_ondemand_init_object() as called from cachefiles_open_file() and
> cachefiles_create_tmpfile() does not check if object->ondemand is set
> before dereferencing it, leading to an oops something like:
> 
> 	RIP: 0010:cachefiles_ondemand_init_object+0x9/0x41
> 	...
> 	Call Trace:
> 	 <TASK>
> 	 cachefiles_open_file+0xc9/0x187
> 	 cachefiles_lookup_cookie+0x122/0x2be
> 	 fscache_cookie_state_machine+0xbe/0x32b
> 	 fscache_cookie_worker+0x1f/0x2d
> 	 process_one_work+0x136/0x208
> 	 process_scheduled_works+0x3a/0x41
> 	 worker_thread+0x1a2/0x1f6
> 	 kthread+0xca/0xd2
> 	 ret_from_fork+0x21/0x33
> 
> Fix this by making the calls to cachefiles_ondemand_init_object()
> conditional.
> 
> Fixes: 3c5ecfe16e76 ("cachefiles: extract ondemand info field from cachefiles_object")
> Reported-by: Marc Dionne <marc.dionne@auristor.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Gao Xiang <xiang@kernel.org>
> cc: Chao Yu <chao@kernel.org>
> cc: Yue Hu <huyue2@coolpad.com>
> cc: Jeffle Xu <jefflexu@linux.alibaba.com>
> cc: linux-erofs@lists.ozlabs.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org

Looks good to me, thanks for fixing this:

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

