Return-Path: <linux-fsdevel+bounces-25893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029FB9515E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 09:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC6C5B2A6AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 07:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70E613DDB8;
	Wed, 14 Aug 2024 07:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pJtdTcKX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94C013CFB7;
	Wed, 14 Aug 2024 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723621801; cv=none; b=ToBMFPVhLEqEhN/X6u7D8i4Jh1cZqj6wLexOBo0DbsBoanyglQRowfLGWK99l3/7XzXhGulAwLaQDxpg8cMd2gZyay/jIEfeDxTFNuphP6xf0I7CDSsnPQGL32ez0YbVNGPmgpQkAMCddrl2MEo68QlwltEVvgwOz8/OTNJhWD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723621801; c=relaxed/simple;
	bh=qjFyWqGVssj1+G9jgMuIQV67hYnTfCZUr57iNzX3JuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCju+7nnO45rW9QM9BKUqZ33GOyIPrJh0QXp4KKFBlk9byKoiYyRZPicGbs2UlK+OcVWvE1TUzceoTyi3j1F6pGvAnXk8b3WKXITVGYopzuLOMoNbfGR97sECTuYWKhci4+H+0p7R/1egUa2d8xDENEfNH4W5WEpyjPy9OB3j+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pJtdTcKX; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723621795; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=I5pDPKJB+T80C8NVQjfj99TTYk+U6Sl12RWOlJDvLPA=;
	b=pJtdTcKXQktMWSUiqFrK3/tsPOkJnnPvBTD8wWT4DbuOqxXQ2K0alJbKgkV2PEg+imA5YJ3wEsE0tsiDXad5GfgPASbi6e+ZDTwiG2wKfG0SZwGhQU3pj8jR+bK5BtbkivVNwi9LK3urj1kwqVxu6RSLQV+J3wWoMSLCx4VHndU=
Received: from 30.221.146.67(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WCraOrA_1723621793)
          by smtp.aliyun-inc.com;
          Wed, 14 Aug 2024 15:49:54 +0800
Message-ID: <7444ba50-20ba-4908-9f46-0fda488f905b@linux.alibaba.com>
Date: Wed, 14 Aug 2024 15:49:52 +0800
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
 <5d809485-7e29-41ce-b683-7d19b829f86c@linux.alibaba.com>
 <dbd4499a-8359-6d59-83f6-50f8dba84747@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <dbd4499a-8359-6d59-83f6-50f8dba84747@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/14/24 3:46 PM, Hou Tao wrote:
> Hi,
> 
> On 8/14/2024 2:34 PM, Jingbo Xu wrote:
>> Hi, Tao,
>>
>> On 4/26/24 10:39 PM, Hou Tao wrote:
>>> From: Hou Tao <houtao1@huawei.com>
>>>
>>> Hi,
>>>
>>> The patch set aims to fix the warning related to an abnormal size
>>> parameter of kmalloc() in virtiofs. Patch #1 fixes it by introducing
>>> use_pages_for_kvec_io option in fuse_conn and enabling it in virtiofs.
>>> Beside the abnormal size parameter for kmalloc, the gfp parameter is
>>> also questionable: GFP_ATOMIC is used even when the allocation occurs
>>> in a kworker context. Patch #2 fixes it by using GFP_NOFS when the
>>> allocation is initiated by the kworker. For more details, please check
>>> the individual patches.
>>>
>>> As usual, comments are always welcome.
>>>
>>> Change Log:
>>>
>>> v3:
>>>  * introduce use_pages_for_kvec_io for virtiofs. When the option is
>>>    enabled, fuse will use iov_iter_extract_pages() to construct a page
>>>    array and pass the pages array instead of a pointer to virtiofs.
>>>    The benefit is twofold: the length of the data passed to virtiofs is
>>>    limited by max_pages, and there is no memory copy compared with v2.
>>>
>>> v2: https://lore.kernel.org/linux-fsdevel/20240228144126.2864064-1-houtao@huaweicloud.com/
>>>   * limit the length of ITER_KVEC dio by max_pages instead of the
>>>     newly-introduced max_nopage_rw. Using max_pages make the ITER_KVEC
>>>     dio being consistent with other rw operations.
>>>   * replace kmalloc-allocated bounce buffer by using a bounce buffer
>>>     backed by scattered pages when the length of the bounce buffer for
>>>     KVEC_ITER dio is larger than PAG_SIZE, so even on hosts with
>>>     fragmented memory, the KVEC_ITER dio can be handled normally by
>>>     virtiofs. (Bernd Schubert)
>>>   * merge the GFP_NOFS patch [1] into this patch-set and use
>>>     memalloc_nofs_{save|restore}+GFP_KERNEL instead of GFP_NOFS
>>>     (Benjamin Coddington)
>>>
>>> v1: https://lore.kernel.org/linux-fsdevel/20240103105929.1902658-1-houtao@huaweicloud.com/
>>>
>>> [1]: https://lore.kernel.org/linux-fsdevel/20240105105305.4052672-1-houtao@huaweicloud.com/
>>>
>>> Hou Tao (2):
>>>   virtiofs: use pages instead of pointer for kernel direct IO
>>>   virtiofs: use GFP_NOFS when enqueuing request through kworker
>>>
>>>  fs/fuse/file.c      | 12 ++++++++----
>>>  fs/fuse/fuse_i.h    |  3 +++
>>>  fs/fuse/virtio_fs.c | 25 ++++++++++++++++---------
>>>  3 files changed, 27 insertions(+), 13 deletions(-)
>>>
>> We also encountered the same issue as [1] these days when attempting to
>> insmod a module with ~6MB size, which is upon a virtiofs filesystem.
>>
>> It would be much helpful if this issue has a standard fix in the
>> upstream.  I see there will be v4 when reading through the mailing
>> thread.  Glad to know if there's any update to this series.
> 
> Being busy with other stuff these days. I hope to send v4 before next
> weekend.

Many thanks, Tao.


-- 
Thanks,
Jingbo

