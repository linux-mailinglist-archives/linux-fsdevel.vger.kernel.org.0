Return-Path: <linux-fsdevel+bounces-16390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8BE89D006
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 03:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACEFBB21770
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 01:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAE04EB44;
	Tue,  9 Apr 2024 01:48:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4934E1BE;
	Tue,  9 Apr 2024 01:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712627307; cv=none; b=Z6wBeJubztPrwvFobNelA95x0/552vjtUln8fzqk1E49Pkx4jVeKFa9CicGUxkpXBwnwnD49e+kE4Lp3Armf+t7onDfRXdeQG3i+a2oj5THFunfe20sLdec1+sGg3xKw7Qbuoe3pvVf4SOyPm4XVN2TIKPOSo90Iijhljh8Gt8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712627307; c=relaxed/simple;
	bh=9HFrFIth3R0zd7PPhTEec3H/FKVeAX/QIKtgfQNhbE4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bjZ5IgaPA9QgK2Y+EtLW+rORSEY2Jp3gYgfu5Qh0q8qEjbljvI55h4vs62vj4sjyeOVr75/IYqtW3ajcTGptsL+vLfyXuhwC386FiyHvH14FQOCZaX55YEq2vcDgY3lESBAeLyL1hJWA9/MoZreIyblskWPFqz6PVo8ZUs3Oqb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VD8496jQNz4f3jkL;
	Tue,  9 Apr 2024 09:48:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 524C81A0BD5;
	Tue,  9 Apr 2024 09:48:14 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgA3955YnhRmd5ZhJQ--.9921S2;
	Tue, 09 Apr 2024 09:48:12 +0800 (CST)
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
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <413bd868-a16b-f024-0098-3c70f7808d3c@huaweicloud.com>
Date: Tue, 9 Apr 2024 09:48:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240408034514-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgA3955YnhRmd5ZhJQ--.9921S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFW7tw17Jw13WF4DAF43Wrg_yoW5tFyxpr
	Wftan0grsxXFy7Arnay3Z5Cr9akws3JF17WrZ3Xw1rCFW3X3WI9r1jkF4YgFy7Ary8AF18
	tr1Fqas29ryqv37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 4/8/2024 3:45 PM, Michael S. Tsirkin wrote:
> On Wed, Feb 28, 2024 at 10:41:20PM +0800, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Hi,
>>
>> The patch set aims to fix the warning related to an abnormal size
>> parameter of kmalloc() in virtiofs. The warning occurred when attempting
>> to insert a 10MB sized kernel module kept in a virtiofs with cache
>> disabled. As analyzed in patch #1, the root cause is that the length of
>> the read buffer is no limited, and the read buffer is passed directly to
>> virtiofs through out_args[0].value. Therefore patch #1 limits the
>> length of the read buffer passed to virtiofs by using max_pages. However
>> it is not enough, because now the maximal value of max_pages is 256.
>> Consequently, when reading a 10MB-sized kernel module, the length of the
>> bounce buffer in virtiofs will be 40 + (256 * 4096), and kmalloc will
>> try to allocate 2MB from memory subsystem. The request for 2MB of
>> physically contiguous memory significantly stress the memory subsystem
>> and may fail indefinitely on hosts with fragmented memory. To address
>> this, patch #2~#5 use scattered pages in a bio_vec to replace the
>> kmalloc-allocated bounce buffer when the length of the bounce buffer for
>> KVEC_ITER dio is larger than PAGE_SIZE. The final issue with the
>> allocation of the bounce buffer and sg array in virtiofs is that
>> GFP_ATOMIC is used even when the allocation occurs in a kworker context.
>> Therefore the last patch uses GFP_NOFS for the allocation of both sg
>> array and bounce buffer when initiated by the kworker. For more details,
>> please check the individual patches.
>>
>> As usual, comments are always welcome.
>>
>> Change Log:
> Bernd should I just merge the patchset as is?
> It seems to fix a real problem and no one has the
> time to work on a better fix .... WDYT?

Sorry for the long delay. I am just start to prepare for v3. In v3, I
plan to avoid the unnecessary memory copy between fuse args and bio_vec.
Will post it before next week.
>
>
>> v2:
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
>> Hou Tao (6):
>>   fuse: limit the length of ITER_KVEC dio by max_pages
>>   virtiofs: move alloc/free of argbuf into separated helpers
>>   virtiofs: factor out more common methods for argbuf
>>   virtiofs: support bounce buffer backed by scattered pages
>>   virtiofs: use scattered bounce buffer for ITER_KVEC dio
>>   virtiofs: use GFP_NOFS when enqueuing request through kworker
>>
>>  fs/fuse/file.c      |  12 +-
>>  fs/fuse/virtio_fs.c | 336 +++++++++++++++++++++++++++++++++++++-------
>>  2 files changed, 296 insertions(+), 52 deletions(-)
>>
>> -- 
>> 2.29.2


