Return-Path: <linux-fsdevel+bounces-25885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AEE9514B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 08:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 789D4282053
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 06:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A926131E2D;
	Wed, 14 Aug 2024 06:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Bi7UGi/2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ABF1F94D;
	Wed, 14 Aug 2024 06:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723617262; cv=none; b=JkL3LIv1wbvGwreAbHQoILfYqByoUb2y7m1ehNfFjF5qDkv3HzrO9vKCbiglqTk7YoliO30v7UkL/FW3v0yWNpxHJsic2Eu1U09I2bxgEVxt6ATRq7mkcC00fKHST99j1XjGu0F8//djqeIMDVwPE9EjxWM1Jps8q9Bl9Rz0Neo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723617262; c=relaxed/simple;
	bh=SvN65VjKhuXKd6CKLzEt4RIsg4fOL4Wc6gAnyXw2OcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfJo24Zr/GfD22aC1GHO+Vii8qEAQ1RKmS00kbht19MzwsS91FrRSYu+7i1g7+ot3rcHfltkmQtT5X0EODOIE3GyGwFoWhCPzj0AUGKtosgh2IEZQailOvv52FH0kOre0ppjvFeq5W88fp4+D3Ep3ug6AbY/KDyPuABxielOneA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Bi7UGi/2; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723617256; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=nSEfCzq3QVSYVGN/VRTP0Jf/ksFbu5uVwNghY3Ohau4=;
	b=Bi7UGi/2jU/7xC3rmXPIgG/pwldRjF+ubOjSEZG2i0kVEiYb4BvIX4i3FfwR47tSlWWOgY/h2+2a8n6qgjqxbYxl6s9V78BEFnKki99S38HW+WEVYpZy7tlARbxPUX05EcaNnIdCmuEcnmlRXof7xp32m6tcKzzLj9AnP+wcFms=
Received: from 30.221.146.67(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WCrEqfU_1723617255)
          by smtp.aliyun-inc.com;
          Wed, 14 Aug 2024 14:34:16 +0800
Message-ID: <5d809485-7e29-41ce-b683-7d19b829f86c@linux.alibaba.com>
Date: Wed, 14 Aug 2024 14:34:14 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] virtiofs: fix the warning for kernel direct IO
To: Hou Tao <houtao@huaweicloud.com>, linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Bernd Schubert <bernd.schubert@fastmail.fm>,
 "Michael S . Tsirkin" <mst@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, Benjamin Coddington <bcodding@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 houtao1@huawei.com
References: <20240426143903.1305919-1-houtao@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240426143903.1305919-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Tao,

On 4/26/24 10:39 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The patch set aims to fix the warning related to an abnormal size
> parameter of kmalloc() in virtiofs. Patch #1 fixes it by introducing
> use_pages_for_kvec_io option in fuse_conn and enabling it in virtiofs.
> Beside the abnormal size parameter for kmalloc, the gfp parameter is
> also questionable: GFP_ATOMIC is used even when the allocation occurs
> in a kworker context. Patch #2 fixes it by using GFP_NOFS when the
> allocation is initiated by the kworker. For more details, please check
> the individual patches.
> 
> As usual, comments are always welcome.
> 
> Change Log:
> 
> v3:
>  * introduce use_pages_for_kvec_io for virtiofs. When the option is
>    enabled, fuse will use iov_iter_extract_pages() to construct a page
>    array and pass the pages array instead of a pointer to virtiofs.
>    The benefit is twofold: the length of the data passed to virtiofs is
>    limited by max_pages, and there is no memory copy compared with v2.
> 
> v2: https://lore.kernel.org/linux-fsdevel/20240228144126.2864064-1-houtao@huaweicloud.com/
>   * limit the length of ITER_KVEC dio by max_pages instead of the
>     newly-introduced max_nopage_rw. Using max_pages make the ITER_KVEC
>     dio being consistent with other rw operations.
>   * replace kmalloc-allocated bounce buffer by using a bounce buffer
>     backed by scattered pages when the length of the bounce buffer for
>     KVEC_ITER dio is larger than PAG_SIZE, so even on hosts with
>     fragmented memory, the KVEC_ITER dio can be handled normally by
>     virtiofs. (Bernd Schubert)
>   * merge the GFP_NOFS patch [1] into this patch-set and use
>     memalloc_nofs_{save|restore}+GFP_KERNEL instead of GFP_NOFS
>     (Benjamin Coddington)
> 
> v1: https://lore.kernel.org/linux-fsdevel/20240103105929.1902658-1-houtao@huaweicloud.com/
> 
> [1]: https://lore.kernel.org/linux-fsdevel/20240105105305.4052672-1-houtao@huaweicloud.com/
> 
> Hou Tao (2):
>   virtiofs: use pages instead of pointer for kernel direct IO
>   virtiofs: use GFP_NOFS when enqueuing request through kworker
> 
>  fs/fuse/file.c      | 12 ++++++++----
>  fs/fuse/fuse_i.h    |  3 +++
>  fs/fuse/virtio_fs.c | 25 ++++++++++++++++---------
>  3 files changed, 27 insertions(+), 13 deletions(-)
> 

We also encountered the same issue as [1] these days when attempting to
insmod a module with ~6MB size, which is upon a virtiofs filesystem.

It would be much helpful if this issue has a standard fix in the
upstream.  I see there will be v4 when reading through the mailing
thread.  Glad to know if there's any update to this series.

[1]
https://lore.kernel.org/linux-fsdevel/20240103105929.1902658-1-houtao@huaweicloud.com/

-- 
Thanks,
Jingbo

