Return-Path: <linux-fsdevel+bounces-37473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8A49F2AA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 08:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1727216822C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 07:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC3F1CEE9B;
	Mon, 16 Dec 2024 07:05:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8981BB6BC;
	Mon, 16 Dec 2024 07:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734332736; cv=none; b=eX7zANb+7JuIOyRUzgDv1u202PbkrgWzZNcAeuDqSK6KeR33SW9REw0xIyPfSwaDM5+BCWmbcRkjGmSN0yyFsxag3WFln1wqL2eOwMvXjRBAqTcchAyBBnmcFDmyG6nIVZv1TtWyRv9QqBpcHZkpH/AT3aB28dSChkI0umpKhPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734332736; c=relaxed/simple;
	bh=cLZo+IZieljrwnvYZwR7i8aX+4qeOLytTkDuH3TQlxg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=n+yaG1ynv9XzLo9qdXs5+r63SMPmkdCfhvC9F9uLkDqDjkdp/Pk13uZdwHpY81PzfTR07xc2dOkjAf5fffBLb/TOaarRT5wIxTMY/iDrfFwWsri258QkBSvR/aFHXPQPszhBjVsgyZbYywBGu6Oov5AycTMu/Xs01B8Z+u0bzvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YBWD52PWLz4f3jdL;
	Mon, 16 Dec 2024 15:05:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B9A5C1A0197;
	Mon, 16 Dec 2024 15:05:28 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP4 (Coremail) with SMTP id gCh0CgDHoYU30V9nL9r5Eg--.39298S2;
	Mon, 16 Dec 2024 15:05:28 +0800 (CST)
Subject: Re: [PATCH v3 1/5] Xarray: Do not return sibling entries from
 xas_find_marked()
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 willy@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-nfs@vger.kernel.org
References: <20241213122523.12764-1-shikemeng@huaweicloud.com>
 <20241213122523.12764-2-shikemeng@huaweicloud.com>
 <1f8b523e-d68f-4382-8b1e-2475eb47ae81@linux.alibaba.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <5d89f26a-8ac9-9768-5fc7-af155473f396@huaweicloud.com>
Date: Mon, 16 Dec 2024 15:05:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1f8b523e-d68f-4382-8b1e-2475eb47ae81@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHoYU30V9nL9r5Eg--.39298S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFyfJw18CrW3KFW7Zr1kKrg_yoWrKF15pF
	Z5KryDKry0yr1kJrnrJ3WUXryUG34UXanrJrWrWa42vF15Ar1jgF4jqr1jgF1DJrWkJF4x
	JF4UA347ZF1UAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2N
	tUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 12/13/2024 2:12 PM, Baolin Wang wrote:
> 
> 
> On 2024/12/13 20:25, Kemeng Shi wrote:
>> Similar to issue fixed in commit cbc02854331ed ("XArray: Do not return
>> sibling entries from xa_load()"), we may return sibling entries from
>> xas_find_marked as following:
>>      Thread A:               Thread B:
>>                              xa_store_range(xa, entry, 6, 7, gfp);
>>                 xa_set_mark(xa, 6, mark)
>>      XA_STATE(xas, xa, 6);
>>      xas_find_marked(&xas, 7, mark);
>>      offset = xas_find_chunk(xas, advance, mark);
>>      [offset is 6 which points to a valid entry]
>>                              xa_store_range(xa, entry, 4, 7, gfp);
>>      entry = xa_entry(xa, node, 6);
>>      [entry is a sibling of 4]
>>      if (!xa_is_node(entry))
>>          return entry;
>>
>> Skip sibling entry like xas_find() does to protect caller from seeing
>> sibling entry from xas_find_marked() or caller may use sibling entry
>> as a valid entry and crash the kernel.
>>
>> Besides, load_race() test is modified to catch mentioned issue and modified
>> load_race() only passes after this fix is merged.
>>
>> Here is an example how this bug could be triggerred in tmpfs which
>> enables large folio in mapping:
>> Let's take a look at involved racer:
>> 1. How pages could be created and dirtied in shmem file.
>> write
>>   ksys_write
>>    vfs_write
>>     new_sync_write
>>      shmem_file_write_iter
>>       generic_perform_write
>>        shmem_write_begin
>>         shmem_get_folio
>>          shmem_allowable_huge_orders
>>          shmem_alloc_and_add_folios
>>          shmem_alloc_folio
>>          __folio_set_locked
>>          shmem_add_to_page_cache
>>           XA_STATE_ORDER(..., index, order)
>>           xax_store()
>>        shmem_write_end
>>         folio_mark_dirty()
>>
>> 2. How dirty pages could be deleted in shmem file.
>> ioctl
>>   do_vfs_ioctl
>>    file_ioctl
>>     ioctl_preallocate
>>      vfs_fallocate
>>       shmem_fallocate
>>        shmem_truncate_range
>>         shmem_undo_range
>>          truncate_inode_folio
>>           filemap_remove_folio
>>            page_cache_delete
>>             xas_store(&xas, NULL);
>>
>> 3. How dirty pages could be lockless searched
>> sync_file_range
>>   ksys_sync_file_range
>>    __filemap_fdatawrite_range
>>     filemap_fdatawrite_wbc
> 
> Seems not a good example, IIUC, tmpfs doesn't support writeback (mapping_can_writeback() will return false), right?
> 
Ahhh, right. Thank you for correcting me. Then I would like to use nfs as low-level
 filesystem in example and the potential crash could be triggered in the same steps.

Invovled racers:
1. How pages could be created and dirtied in nfs.
write
 ksys_write
  vfs_write
   new_sync_write
    nfs_file_write
     generic_perform_write
      nfs_write_begin
	   fgf_set_order
	   __filemap_get_folio
      nfs_write_end
       nfs_update_folio
	    nfs_writepage_setup
		 nfs_mark_request_dirty
		  filemap_dirty_folio
		   __folio_mark_dirty
		    __xa_set_mark

2. How dirty pages could be deleted in nfs.
ioctl
 do_vfs_ioctl
  file_ioctl
   ioctl_preallocate
    vfs_fallocate
     nfs42_fallocate
      nfs42_proc_deallocate
       truncate_pagecache_range
        truncate_inode_pages_range
         truncate_inode_folio
	  filemap_remove_folio
	   page_cache_delete
	    xas_store(&xas, NULL);


3. How dirty pages could be lockless searched
sync_file_range
 ksys_sync_file_range
  __filemap_fdatawrite_range
   filemap_fdatawrite_wbc
    do_writepages
     writeback_use_writepage
      writeback_iter
       writeback_get_folio
        filemap_get_folios_tag
         find_get_entry
          folio = xas_find_marked()
          folio_try_get(folio)

Steps to crash kernel:
1.Create               2.Search             3.Delete
/* write page 2,3 */
write
 ...
  nfs_write_begin
   fgf_set_order
   __filemap_get_folio
    ...
     xa_store(&xas, folio)
  nfs_write_end
   ...
    __folio_mark_dirty

                       /* sync page 2 and page 3 */
                       sync_file_range
                        ...
                         find_get_entry
                          folio = xas_find_marked()
                          /* offset will be 2 */
                          offset = xas_find_chunk()

                                             /* delete page 2 and page 3 */
                                             ioctl
                                              ...
                                               xas_store(&xas, NULL);

/* write page 0-3 */
write
 ...
  nfs_write_begin
   fgf_set_order
   __filemap_get_folio
    ...
     xa_store(&xas, folio)
  nfs_write_end
   ...
    __folio_mark_dirty

                          /* get sibling entry from offset 2 */
                          entry = xa_entry(.., 2)
                          /* use sibling entry as folio and crash kernel */
                          folio_try_get(folio)


