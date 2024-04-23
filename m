Return-Path: <linux-fsdevel+bounces-17508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B37CB8AE808
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 15:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6BB51C224E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 13:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C295135A65;
	Tue, 23 Apr 2024 13:25:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414D4135A40;
	Tue, 23 Apr 2024 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878744; cv=none; b=mObamySBxAgG/AGVKffpEueud4+Rvn1OakNPqtiI557jPbPBUyUS0lY0kA4gZn5DHCJ+t3xz2IIHwM8IKJKsOIeiOCcHmoAWIkb2F0dO27HaTjyd6SDh5QDYga3Trawjnu5zwUZCoA1Qd5ebItg79R2j6g6J9YhvBKXV+s4AevY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878744; c=relaxed/simple;
	bh=5a4bb9B//8XIDmTV7hGB8eIJiBmSaKE7suGLchtgKZU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=P+uacGBWZinr7gIC3vU5TG95OZVW0fjkUP7xiBmg6VCPibJWNdem4s35x0bY+d9kfogWWDqV5C9Uf5V1qeBHWx6DBAOgA1Gz+7HaagBR0WBZYswYrPd+6r/9++rl8YvepTNe5sYYUgo+eMmg1bDKiARfaIIFq1o0OIM4QegMEnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VP2tK4gz5z4f3nTY;
	Tue, 23 Apr 2024 21:25:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id CBA661A016E;
	Tue, 23 Apr 2024 21:25:38 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgCH6v3NtidmQDz9Kw--.51257S2;
	Tue, 23 Apr 2024 21:25:37 +0800 (CST)
Subject: Re: [PATCH v2 0/6] virtiofs: fix the warning for ITER_KVEC dio
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Bernd Schubert <bernd.schubert@fastmail.fm>,
 Matthew Wilcox <willy@infradead.org>,
 Benjamin Coddington <bcodding@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, houtao1@huawei.com
References: <20240228144126.2864064-1-houtao@huaweicloud.com>
 <20240408034514-mutt-send-email-mst@kernel.org>
 <413bd868-a16b-f024-0098-3c70f7808d3c@huaweicloud.com>
 <20240422160615-mutt-send-email-mst@kernel.org>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <3a287e9b-55ad-dda9-5f53-c12536bad31d@huaweicloud.com>
Date: Tue, 23 Apr 2024 21:25:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240422160615-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgCH6v3NtidmQDz9Kw--.51257S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGryfKrWUZFy7GFWDWFy5twb_yoWrXry5pr
	Wftan8trsrXFy3Arn2y3Z5urnakws3JFy7Wr9xXw1ruFZIq3Wxur47tFyY9Fy7Ary8AFy8
	tr1FqasF9r1qv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 4/23/2024 4:06 AM, Michael S. Tsirkin wrote:
> On Tue, Apr 09, 2024 at 09:48:08AM +0800, Hou Tao wrote:
>> Hi,
>>
>> On 4/8/2024 3:45 PM, Michael S. Tsirkin wrote:
>>> On Wed, Feb 28, 2024 at 10:41:20PM +0800, Hou Tao wrote:
>>>> From: Hou Tao <houtao1@huawei.com>
>>>>
>>>> Hi,
>>>>
>>>> The patch set aims to fix the warning related to an abnormal size
>>>> parameter of kmalloc() in virtiofs. The warning occurred when attempting
>>>> to insert a 10MB sized kernel module kept in a virtiofs with cache
>>>> disabled. As analyzed in patch #1, the root cause is that the length of
>>>> the read buffer is no limited, and the read buffer is passed directly to
>>>> virtiofs through out_args[0].value. Therefore patch #1 limits the
>>>> length of the read buffer passed to virtiofs by using max_pages. However
>>>> it is not enough, because now the maximal value of max_pages is 256.
>>>> Consequently, when reading a 10MB-sized kernel module, the length of the
>>>> bounce buffer in virtiofs will be 40 + (256 * 4096), and kmalloc will
>>>> try to allocate 2MB from memory subsystem. The request for 2MB of
>>>> physically contiguous memory significantly stress the memory subsystem
>>>> and may fail indefinitely on hosts with fragmented memory. To address
>>>> this, patch #2~#5 use scattered pages in a bio_vec to replace the
>>>> kmalloc-allocated bounce buffer when the length of the bounce buffer for
>>>> KVEC_ITER dio is larger than PAGE_SIZE. The final issue with the
>>>> allocation of the bounce buffer and sg array in virtiofs is that
>>>> GFP_ATOMIC is used even when the allocation occurs in a kworker context.
>>>> Therefore the last patch uses GFP_NOFS for the allocation of both sg
>>>> array and bounce buffer when initiated by the kworker. For more details,
>>>> please check the individual patches.
>>>>
>>>> As usual, comments are always welcome.
>>>>
>>>> Change Log:
>>> Bernd should I just merge the patchset as is?
>>> It seems to fix a real problem and no one has the
>>> time to work on a better fix .... WDYT?
>> Sorry for the long delay. I am just start to prepare for v3. In v3, I
>> plan to avoid the unnecessary memory copy between fuse args and bio_vec.
>> Will post it before next week.
> Didn't happen before this week apparently.

Sorry for failing to make it this week. Being busy these two weeks. Hope
to send v3 out before the end of April.
>
>>>
>>>> v2:
>>>>   * limit the length of ITER_KVEC dio by max_pages instead of the
>>>>     newly-introduced max_nopage_rw. Using max_pages make the ITER_KVEC
>>>>     dio being consistent with other rw operations.
>>>>   * replace kmalloc-allocated bounce buffer by using a bounce buffer
>>>>     backed by scattered pages when the length of the bounce buffer for
>>>>     KVEC_ITER dio is larger than PAG_SIZE, so even on hosts with
>>>>     fragmented memory, the KVEC_ITER dio can be handled normally by
>>>>     virtiofs. (Bernd Schubert)
>>>>   * merge the GFP_NOFS patch [1] into this patch-set and use
>>>>     memalloc_nofs_{save|restore}+GFP_KERNEL instead of GFP_NOFS
>>>>     (Benjamin Coddington)
>>>>
>>>> v1: https://lore.kernel.org/linux-fsdevel/20240103105929.1902658-1-houtao@huaweicloud.com/
>>>>
>>>> [1]: https://lore.kernel.org/linux-fsdevel/20240105105305.4052672-1-houtao@huaweicloud.com/
>>>>
>>>> Hou Tao (6):
>>>>   fuse: limit the length of ITER_KVEC dio by max_pages
>>>>   virtiofs: move alloc/free of argbuf into separated helpers
>>>>   virtiofs: factor out more common methods for argbuf
>>>>   virtiofs: support bounce buffer backed by scattered pages
>>>>   virtiofs: use scattered bounce buffer for ITER_KVEC dio
>>>>   virtiofs: use GFP_NOFS when enqueuing request through kworker
>>>>
>>>>  fs/fuse/file.c      |  12 +-
>>>>  fs/fuse/virtio_fs.c | 336 +++++++++++++++++++++++++++++++++++++-------
>>>>  2 files changed, 296 insertions(+), 52 deletions(-)
>>>>
>>>> -- 
>>>> 2.29.2


