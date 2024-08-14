Return-Path: <linux-fsdevel+bounces-25891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C919515C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 09:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78BB1C20F7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 07:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD92513C8E2;
	Wed, 14 Aug 2024 07:46:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDE54C62B;
	Wed, 14 Aug 2024 07:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723621619; cv=none; b=co+YPd4FivoPkaxTP3lD6fxfAKYo7ew6rYBxvl9vCkrLHzXeMleQWQpQpdmMnqwoS2uXACQgbu0/m+/CtOLg4a2cJ5pRHPzCcf/O5Ph5AJ943FSD4Yt8dkV56GfoAudLdj40OSNxmfxgGBp2ZvZCZHPgeHlhwfY0XAWQ7DW5paY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723621619; c=relaxed/simple;
	bh=Ipzj0sSXoWYnXcb1649fej8UVGQS6iweSmsx+0AT6+s=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=o8LMdBEao36B+qd4IDepEILd72AeNU7SZ+RjkExkDGdBlisEdEdcfaWSB7yGlLCtM6du0KBVBsjbtqOMQcniDYkrS91v+EGRm/dq/nv5g8oTGFsSJSt60MK8VNd0fwfzliyl1ziuck4ffeXZdJp+bWbe5aIgUH7gnRBnK8aI0iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WkL1C0htwz4f3jMP;
	Wed, 14 Aug 2024 15:46:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D1FF51A058E;
	Wed, 14 Aug 2024 15:46:52 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgAneUvnYLxmv5JoBg--.58949S2;
	Wed, 14 Aug 2024 15:46:51 +0800 (CST)
Subject: Re: [PATCH v3 0/2] virtiofs: fix the warning for kernel direct IO
To: Jingbo Xu <jefflexu@linux.alibaba.com>, linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Bernd Schubert <bernd.schubert@fastmail.fm>,
 "Michael S . Tsirkin" <mst@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, Benjamin Coddington <bcodding@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 houtao1@huawei.com
References: <20240426143903.1305919-1-houtao@huaweicloud.com>
 <5d809485-7e29-41ce-b683-7d19b829f86c@linux.alibaba.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <dbd4499a-8359-6d59-83f6-50f8dba84747@huaweicloud.com>
Date: Wed, 14 Aug 2024 15:46:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5d809485-7e29-41ce-b683-7d19b829f86c@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgAneUvnYLxmv5JoBg--.58949S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXry8CF43Zr1fWrW3uF45ZFb_yoW5ArWrpF
	WrGa1Y9rsrJryxAr9ak3WkuryFkws5GF17t3s3Ww1rCrZxZF1I9rnFkF4YgFy7ArW8CF4j
	qr4Iva4qgr9Fv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 8/14/2024 2:34 PM, Jingbo Xu wrote:
> Hi, Tao,
>
> On 4/26/24 10:39 PM, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Hi,
>>
>> The patch set aims to fix the warning related to an abnormal size
>> parameter of kmalloc() in virtiofs. Patch #1 fixes it by introducing
>> use_pages_for_kvec_io option in fuse_conn and enabling it in virtiofs.
>> Beside the abnormal size parameter for kmalloc, the gfp parameter is
>> also questionable: GFP_ATOMIC is used even when the allocation occurs
>> in a kworker context. Patch #2 fixes it by using GFP_NOFS when the
>> allocation is initiated by the kworker. For more details, please check
>> the individual patches.
>>
>> As usual, comments are always welcome.
>>
>> Change Log:
>>
>> v3:
>>  * introduce use_pages_for_kvec_io for virtiofs. When the option is
>>    enabled, fuse will use iov_iter_extract_pages() to construct a page
>>    array and pass the pages array instead of a pointer to virtiofs.
>>    The benefit is twofold: the length of the data passed to virtiofs is
>>    limited by max_pages, and there is no memory copy compared with v2.
>>
>> v2: https://lore.kernel.org/linux-fsdevel/20240228144126.2864064-1-houtao@huaweicloud.com/
>>   * limit the length of ITER_KVEC dio by max_pages instead of the
>>     newly-introduced max_nopage_rw. Using max_pages make the ITER_KVEC
>>     dio being consistent with other rw operations.
>>   * replace kmalloc-allocated bounce buffer by using a bounce buffer
>>     backed by scattered pages when the length of the bounce buffer for
>>     KVEC_ITER dio is larger than PAG_SIZE, so even on hosts with
>>     fragmented memory, the KVEC_ITER dio can be handled normally by
>>     virtiofs. (Bernd Schubert)
>>   * merge the GFP_NOFS patch [1] into this patch-set and use
>>     memalloc_nofs_{save|restore}+GFP_KERNEL instead of GFP_NOFS
>>     (Benjamin Coddington)
>>
>> v1: https://lore.kernel.org/linux-fsdevel/20240103105929.1902658-1-houtao@huaweicloud.com/
>>
>> [1]: https://lore.kernel.org/linux-fsdevel/20240105105305.4052672-1-houtao@huaweicloud.com/
>>
>> Hou Tao (2):
>>   virtiofs: use pages instead of pointer for kernel direct IO
>>   virtiofs: use GFP_NOFS when enqueuing request through kworker
>>
>>  fs/fuse/file.c      | 12 ++++++++----
>>  fs/fuse/fuse_i.h    |  3 +++
>>  fs/fuse/virtio_fs.c | 25 ++++++++++++++++---------
>>  3 files changed, 27 insertions(+), 13 deletions(-)
>>
> We also encountered the same issue as [1] these days when attempting to
> insmod a module with ~6MB size, which is upon a virtiofs filesystem.
>
> It would be much helpful if this issue has a standard fix in the
> upstream.  I see there will be v4 when reading through the mailing
> thread.  Glad to know if there's any update to this series.

Being busy with other stuff these days. I hope to send v4 before next
weekend.
>
> [1]
> https://lore.kernel.org/linux-fsdevel/20240103105929.1902658-1-houtao@huaweicloud.com/
>


