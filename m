Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E12434498
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 07:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhJTFWX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 01:22:23 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:12205 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229920AbhJTFWX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 01:22:23 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AcfjU76PsRcMNKIXvrR3OlsFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdVPt0z8j0GMGmjceUTiCOPmJYWfzf48jaIWx9EpUu8TXm99gGjLY11k3ESsS9?=
 =?us-ascii?q?pCt6fd1j6vIF3rLaJWFFSqL1u1GAjX7BJ1yHiC0SiuFaOC79CAkjPDQG9IQNca?=
 =?us-ascii?q?fUsxPbV49IMseoUI78wIJqtYAbemRW2thi/uryyHsEAPNNwpPD44hw/nrRCWDE?=
 =?us-ascii?q?xjFkGhwUlQWPZintbJF/pUfJMp3yaqZdxMUTmTId9NWSdovzJnhlo/Y1xwrTN2?=
 =?us-ascii?q?4kLfnaVBMSbnXVeSMoiMOHfH83V4Z/Wpvuko4HKN0hUN/kSiAmctgjttLroCYR?=
 =?us-ascii?q?xorP7HXhaIWVBww/yRWZPQYoeKefCbm2SCU5wicG5f2+N1iBV83MaUW4OFyBnt?=
 =?us-ascii?q?E9OBeIzcIBjiDjOKewbS1UOBgi80vas7xM+s3tnhmizOfEvciRZHKRr7i5NlE0?=
 =?us-ascii?q?TN2jcdLdd7SZdUebzVHbxnaZRBLfFANB/oWmOaum2m6djhwq0ycrqlx5HLcpCR?=
 =?us-ascii?q?3zrTsNd/9ft2RWd4Tmkeeu3KA82nnajkYPdqSjzGF71qrnObEmS69U4UXfJW89?=
 =?us-ascii?q?/h3kBid3WAeFhASfUW0rOP/iUOkXd9bbUsO9UIGqak06VzuTdTnWRC8iGCLswR?=
 =?us-ascii?q?aWNdKFeA+rgaXxcL85wefG3hBXjBaQMIpudVwRjEw0FKN2dTzClRSXBe9IZ6G3?=
 =?us-ascii?q?u7M62rsZm5OdilfDRLohDAtu7HLyLzfRDqVJjq7LJOIsw=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AV6LDma8eKgKaF02ixTxuk+DkI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlFvBw8vrCoB1173HJYUkqMk3I9ergBEDiewK4yXcW2/hzAV7KZmCP11?=
 =?us-ascii?q?dAR7sSj7cKrQeBJwTOssZZ1YpFN5N1EcDMCzFB5vrS0U2VFMkBzbC8nJyVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,165,1631548800"; 
   d="scan'208";a="116151561"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 20 Oct 2021 13:20:06 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id C3ECC4D0DC72;
        Wed, 20 Oct 2021 13:20:00 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 20 Oct 2021 13:19:49 +0800
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 20 Oct 2021 13:19:49 +0800
Received: from [10.167.216.64] (10.167.216.64) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 20 Oct 2021 13:19:49 +0800
Subject: Re: [PATCH v7 1/8] dax: Use rwsem for dax_{read,write}_lock()
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
References: <20210924130959.2695749-1-ruansy.fnst@fujitsu.com>
 <20210924130959.2695749-2-ruansy.fnst@fujitsu.com>
 <20211014174808.GD24307@magnolia>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
Message-ID: <3c84a27a-1dc9-9ca8-d5c3-76f2618cfcdb@fujitsu.com>
Date:   Wed, 20 Oct 2021 13:19:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211014174808.GD24307@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: C3ECC4D0DC72.A3251
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2021/10/15 1:48, Darrick J. Wong 写道:
> On Fri, Sep 24, 2021 at 09:09:52PM +0800, Shiyang Ruan wrote:
>> In order to introduce dax holder registration, we need a write lock for
>> dax.  Because of the rarity of notification failures and the infrequency
>> of registration events, it would be better to be a global lock rather
>> than per-device.  So, change the current lock to rwsem and introduce a
>> write lock for registration.
> 
> Urgh, I totally thought dax_read_lock was a global lock on something
> relating to the global dax_device state until I noticed this comment
> above kill_dax():
> 
> /*
>   * Note, rcu is not protecting the liveness of dax_dev, rcu is ensuring
>   * that any fault handlers or operations that might have seen
>   * dax_alive(), have completed.  Any operations that start after
>   * synchronize_srcu() has run will abort upon seeing !dax_alive().
>   */
> 
> So dax_srcu ensures stability in the dax_device's ALIVE state while any
> code that relies on that aliveness runs.  As a side effect, it'll block
> kill_dax (and I guess run_dax) while those functions run.  It doesn't
> protect any global state at all... but this isn't made obvious in the
> API by (for example) passing the dax_device into dax_read_lock.
> 
> IOWs, It's not protecting against the dax_device getting freed or
> anything resembling global state.  So that's probably why you note above
> that this /could/ be a per-device synchronization primitive, right?
> 
> If that's the case, then why shouldn't this be a per-device item?  As
> written here, any code that takes dax_write_lock() will block every dax
> device in the system while it does some work on a single dax device.
> Being an rwsem, it  will also have to wait for every other dax device
> access to complete before it can begin.  That seems excessive,
> particularly if in the future we start hooking up lots of pmem to a
> single host.
> 
> I have more to say around kill_dax() below.
> 
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   drivers/dax/device.c       | 11 +++++-----
>>   drivers/dax/super.c        | 43 ++++++++++++++++++++++----------------
>>   drivers/md/dm-writecache.c |  7 +++----
>>   fs/dax.c                   | 26 +++++++++++------------
>>   include/linux/dax.h        |  9 ++++----
>>   5 files changed, 49 insertions(+), 47 deletions(-)
>>
>> diff --git a/drivers/dax/device.c b/drivers/dax/device.c
>> index dd8222a42808..cc7b835509f9 100644
>> --- a/drivers/dax/device.c
>> +++ b/drivers/dax/device.c
>> @@ -198,7 +198,6 @@ static vm_fault_t dev_dax_huge_fault(struct vm_fault *vmf,
>>   	struct file *filp = vmf->vma->vm_file;
>>   	unsigned long fault_size;
>>   	vm_fault_t rc = VM_FAULT_SIGBUS;
>> -	int id;
>>   	pfn_t pfn;
>>   	struct dev_dax *dev_dax = filp->private_data;
>>   
>> @@ -206,7 +205,7 @@ static vm_fault_t dev_dax_huge_fault(struct vm_fault *vmf,
>>   			(vmf->flags & FAULT_FLAG_WRITE) ? "write" : "read",
>>   			vmf->vma->vm_start, vmf->vma->vm_end, pe_size);
>>   
>> -	id = dax_read_lock();
>> +	dax_read_lock();
>>   	switch (pe_size) {
>>   	case PE_SIZE_PTE:
>>   		fault_size = PAGE_SIZE;
>> @@ -246,7 +245,7 @@ static vm_fault_t dev_dax_huge_fault(struct vm_fault *vmf,
>>   			page->index = pgoff + i;
>>   		}
>>   	}
>> -	dax_read_unlock(id);
>> +	dax_read_unlock();
>>   
>>   	return rc;
>>   }
>> @@ -284,7 +283,7 @@ static const struct vm_operations_struct dax_vm_ops = {
>>   static int dax_mmap(struct file *filp, struct vm_area_struct *vma)
>>   {
>>   	struct dev_dax *dev_dax = filp->private_data;
>> -	int rc, id;
>> +	int rc;
>>   
>>   	dev_dbg(&dev_dax->dev, "trace\n");
>>   
>> @@ -292,9 +291,9 @@ static int dax_mmap(struct file *filp, struct vm_area_struct *vma)
>>   	 * We lock to check dax_dev liveness and will re-check at
>>   	 * fault time.
>>   	 */
>> -	id = dax_read_lock();
>> +	dax_read_lock();
>>   	rc = check_vma(dev_dax, vma, __func__);
>> -	dax_read_unlock(id);
>> +	dax_read_unlock();
>>   	if (rc)
>>   		return rc;
>>   
>> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
>> index fc89e91beea7..48ce86501d93 100644
>> --- a/drivers/dax/super.c
>> +++ b/drivers/dax/super.c
>> @@ -36,7 +36,7 @@ struct dax_device {
>>   };
>>   
>>   static dev_t dax_devt;
>> -DEFINE_STATIC_SRCU(dax_srcu);
>> +static DECLARE_RWSEM(dax_rwsem);
>>   static struct vfsmount *dax_mnt;
>>   static DEFINE_IDA(dax_minor_ida);
>>   static struct kmem_cache *dax_cache __read_mostly;
>> @@ -46,18 +46,28 @@ static struct super_block *dax_superblock __read_mostly;
>>   static struct hlist_head dax_host_list[DAX_HASH_SIZE];
>>   static DEFINE_SPINLOCK(dax_host_lock);
>>   
>> -int dax_read_lock(void)
>> +void dax_read_lock(void)
>>   {
>> -	return srcu_read_lock(&dax_srcu);
>> +	down_read(&dax_rwsem);
>>   }
>>   EXPORT_SYMBOL_GPL(dax_read_lock);
>>   
>> -void dax_read_unlock(int id)
>> +void dax_read_unlock(void)
>>   {
>> -	srcu_read_unlock(&dax_srcu, id);
>> +	up_read(&dax_rwsem);
>>   }
>>   EXPORT_SYMBOL_GPL(dax_read_unlock);
>>   
>> +void dax_write_lock(void)
>> +{
>> +	down_write(&dax_rwsem);
>> +}
>> +
>> +void dax_write_unlock(void)
>> +{
>> +	up_write(&dax_rwsem);
>> +}
>> +
>>   static int dax_host_hash(const char *host)
>>   {
>>   	return hashlen_hash(hashlen_string("DAX", host)) % DAX_HASH_SIZE;
>> @@ -70,14 +80,14 @@ static int dax_host_hash(const char *host)
>>   static struct dax_device *dax_get_by_host(const char *host)
>>   {
>>   	struct dax_device *dax_dev, *found = NULL;
>> -	int hash, id;
>> +	int hash;
>>   
>>   	if (!host)
>>   		return NULL;
>>   
>>   	hash = dax_host_hash(host);
>>   
>> -	id = dax_read_lock();
>> +	dax_read_lock();
>>   	spin_lock(&dax_host_lock);
>>   	hlist_for_each_entry(dax_dev, &dax_host_list[hash], list) {
>>   		if (!dax_alive(dax_dev)
>> @@ -89,7 +99,7 @@ static struct dax_device *dax_get_by_host(const char *host)
>>   		break;
>>   	}
>>   	spin_unlock(&dax_host_lock);
>> -	dax_read_unlock(id);
>> +	dax_read_unlock();
>>   
>>   	return found;
>>   }
>> @@ -130,7 +140,7 @@ bool generic_fsdax_supported(struct dax_device *dax_dev,
>>   	pfn_t pfn, end_pfn;
>>   	sector_t last_page;
>>   	long len, len2;
>> -	int err, id;
>> +	int err;
>>   
>>   	if (blocksize != PAGE_SIZE) {
>>   		pr_info("%pg: error: unsupported blocksize for dax\n", bdev);
>> @@ -155,14 +165,14 @@ bool generic_fsdax_supported(struct dax_device *dax_dev,
>>   		return false;
>>   	}
>>   
>> -	id = dax_read_lock();
>> +	dax_read_lock();
>>   	len = dax_direct_access(dax_dev, pgoff, 1, &kaddr, &pfn);
>>   	len2 = dax_direct_access(dax_dev, pgoff_end, 1, &end_kaddr, &end_pfn);
>>   
>>   	if (len < 1 || len2 < 1) {
>>   		pr_info("%pg: error: dax access failed (%ld)\n",
>>   				bdev, len < 1 ? len : len2);
>> -		dax_read_unlock(id);
>> +		dax_read_unlock();
>>   		return false;
>>   	}
>>   
>> @@ -192,7 +202,7 @@ bool generic_fsdax_supported(struct dax_device *dax_dev,
>>   		put_dev_pagemap(end_pgmap);
>>   
>>   	}
>> -	dax_read_unlock(id);
>> +	dax_read_unlock();
>>   
>>   	if (!dax_enabled) {
>>   		pr_info("%pg: error: dax support not enabled\n", bdev);
>> @@ -206,16 +216,15 @@ bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
>>   		int blocksize, sector_t start, sector_t len)
>>   {
>>   	bool ret = false;
>> -	int id;
>>   
>>   	if (!dax_dev)
>>   		return false;
>>   
>> -	id = dax_read_lock();
>> +	dax_read_lock();
>>   	if (dax_alive(dax_dev) && dax_dev->ops->dax_supported)
>>   		ret = dax_dev->ops->dax_supported(dax_dev, bdev, blocksize,
>>   						  start, len);
>> -	dax_read_unlock(id);
>> +	dax_read_unlock();
>>   	return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(dax_supported);
>> @@ -410,7 +419,7 @@ EXPORT_SYMBOL_GPL(__set_dax_synchronous);
>>   
>>   bool dax_alive(struct dax_device *dax_dev)
>>   {
>> -	lockdep_assert_held(&dax_srcu);
>> +	lockdep_assert_held(&dax_rwsem);
>>   	return test_bit(DAXDEV_ALIVE, &dax_dev->flags);
>>   }
>>   EXPORT_SYMBOL_GPL(dax_alive);
>> @@ -428,8 +437,6 @@ void kill_dax(struct dax_device *dax_dev)
>>   
>>   	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
>>   
>> -	synchronize_srcu(&dax_srcu);
> 
> Shouldn't you take the dax_write_lock() around the clear_bit call to
> maintain the behavior that kill_dax can't proceed until all the
> functions that depend on DAXDEV_ALIVE state have finished?

Yes, I understood now.  I'll change it to a per-device 
percpu_rw_semaphore.  The global rw_sem is not so good.


--
Thanks,
Ruan

> 
> --D
> 
>> -
>>   	spin_lock(&dax_host_lock);
>>   	hlist_del_init(&dax_dev->list);
>>   	spin_unlock(&dax_host_lock);
>> diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
>> index 18320444fb0a..1067b3e98220 100644
>> --- a/drivers/md/dm-writecache.c
>> +++ b/drivers/md/dm-writecache.c
>> @@ -260,7 +260,6 @@ static int persistent_memory_claim(struct dm_writecache *wc)
>>   	loff_t s;
>>   	long p, da;
>>   	pfn_t pfn;
>> -	int id;
>>   	struct page **pages;
>>   	sector_t offset;
>>   
>> @@ -284,7 +283,7 @@ static int persistent_memory_claim(struct dm_writecache *wc)
>>   	}
>>   	offset >>= PAGE_SHIFT - 9;
>>   
>> -	id = dax_read_lock();
>> +	dax_read_lock();
>>   
>>   	da = dax_direct_access(wc->ssd_dev->dax_dev, offset, p, &wc->memory_map, &pfn);
>>   	if (da < 0) {
>> @@ -334,7 +333,7 @@ static int persistent_memory_claim(struct dm_writecache *wc)
>>   		wc->memory_vmapped = true;
>>   	}
>>   
>> -	dax_read_unlock(id);
>> +	dax_read_unlock();
>>   
>>   	wc->memory_map += (size_t)wc->start_sector << SECTOR_SHIFT;
>>   	wc->memory_map_size -= (size_t)wc->start_sector << SECTOR_SHIFT;
>> @@ -343,7 +342,7 @@ static int persistent_memory_claim(struct dm_writecache *wc)
>>   err3:
>>   	kvfree(pages);
>>   err2:
>> -	dax_read_unlock(id);
>> +	dax_read_unlock();
>>   err1:
>>   	return r;
>>   }
>> diff --git a/fs/dax.c b/fs/dax.c
>> index 4e3e5a283a91..798c43f09eee 100644
>> --- a/fs/dax.c
>> +++ b/fs/dax.c
>> @@ -715,22 +715,21 @@ static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
>>   	void *vto, *kaddr;
>>   	pgoff_t pgoff;
>>   	long rc;
>> -	int id;
>>   
>>   	rc = bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
>>   	if (rc)
>>   		return rc;
>>   
>> -	id = dax_read_lock();
>> +	dax_read_lock();
>>   	rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
>>   	if (rc < 0) {
>> -		dax_read_unlock(id);
>> +		dax_read_unlock();
>>   		return rc;
>>   	}
>>   	vto = kmap_atomic(to);
>>   	copy_user_page(vto, (void __force *)kaddr, vaddr, to);
>>   	kunmap_atomic(vto);
>> -	dax_read_unlock(id);
>> +	dax_read_unlock();
>>   	return 0;
>>   }
>>   
>> @@ -1015,13 +1014,13 @@ static int dax_iomap_pfn(const struct iomap *iomap, loff_t pos, size_t size,
>>   {
>>   	const sector_t sector = dax_iomap_sector(iomap, pos);
>>   	pgoff_t pgoff;
>> -	int id, rc;
>> +	int rc;
>>   	long length;
>>   
>>   	rc = bdev_dax_pgoff(iomap->bdev, sector, size, &pgoff);
>>   	if (rc)
>>   		return rc;
>> -	id = dax_read_lock();
>> +	dax_read_lock();
>>   	length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
>>   				   NULL, pfnp);
>>   	if (length < 0) {
>> @@ -1038,7 +1037,7 @@ static int dax_iomap_pfn(const struct iomap *iomap, loff_t pos, size_t size,
>>   		goto out;
>>   	rc = 0;
>>   out:
>> -	dax_read_unlock(id);
>> +	dax_read_unlock();
>>   	return rc;
>>   }
>>   
>> @@ -1130,7 +1129,7 @@ s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
>>   {
>>   	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
>>   	pgoff_t pgoff;
>> -	long rc, id;
>> +	long rc;
>>   	void *kaddr;
>>   	bool page_aligned = false;
>>   	unsigned offset = offset_in_page(pos);
>> @@ -1144,14 +1143,14 @@ s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
>>   	if (rc)
>>   		return rc;
>>   
>> -	id = dax_read_lock();
>> +	dax_read_lock();
>>   
>>   	if (page_aligned)
>>   		rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
>>   	else
>>   		rc = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);
>>   	if (rc < 0) {
>> -		dax_read_unlock(id);
>> +		dax_read_unlock();
>>   		return rc;
>>   	}
>>   
>> @@ -1159,7 +1158,7 @@ s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
>>   		memset(kaddr + offset, 0, size);
>>   		dax_flush(iomap->dax_dev, kaddr + offset, size);
>>   	}
>> -	dax_read_unlock(id);
>> +	dax_read_unlock();
>>   	return size;
>>   }
>>   
>> @@ -1174,7 +1173,6 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>>   	loff_t end = pos + length, done = 0;
>>   	ssize_t ret = 0;
>>   	size_t xfer;
>> -	int id;
>>   
>>   	if (iov_iter_rw(iter) == READ) {
>>   		end = min(end, i_size_read(iomi->inode));
>> @@ -1199,7 +1197,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>>   					      (end - 1) >> PAGE_SHIFT);
>>   	}
>>   
>> -	id = dax_read_lock();
>> +	dax_read_lock();
>>   	while (pos < end) {
>>   		unsigned offset = pos & (PAGE_SIZE - 1);
>>   		const size_t size = ALIGN(length + offset, PAGE_SIZE);
>> @@ -1251,7 +1249,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>>   		if (xfer < map_len)
>>   			break;
>>   	}
>> -	dax_read_unlock(id);
>> +	dax_read_unlock();
>>   
>>   	return done ? done : ret;
>>   }
>> diff --git a/include/linux/dax.h b/include/linux/dax.h
>> index 2619d94c308d..097b3304f9b9 100644
>> --- a/include/linux/dax.h
>> +++ b/include/linux/dax.h
>> @@ -177,15 +177,14 @@ static inline void dax_unlock_page(struct page *page, dax_entry_t cookie)
>>   #endif
>>   
>>   #if IS_ENABLED(CONFIG_DAX)
>> -int dax_read_lock(void);
>> -void dax_read_unlock(int id);
>> +void dax_read_lock(void);
>> +void dax_read_unlock(void);
>>   #else
>> -static inline int dax_read_lock(void)
>> +static inline void dax_read_lock(void)
>>   {
>> -	return 0;
>>   }
>>   
>> -static inline void dax_read_unlock(int id)
>> +static inline void dax_read_unlock(void)
>>   {
>>   }
>>   #endif /* CONFIG_DAX */
>> -- 
>> 2.33.0
>>
>>
>>


