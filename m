Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5151A6E2C81
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 00:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjDNWjA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 18:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjDNWi4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 18:38:56 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AC259C5
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 15:38:52 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6333cb4eb42so1353144b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 15:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681511932; x=1684103932;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u72sfQIiyGI9PZMMR7INhqrdPHz4ajYrG9ug2XxrGf8=;
        b=TG08T9NZG0CLWe1smiq+G82+zjG4ivS+2/5AUpjYtmMeYTrPyItyeL+X/ABmmyxxg6
         5DNvyZvSNnUA7gnmX7N8NSV96NVmPNMmgdlCfAnx+qpcI8Lxxv7MPBmunlT9h/m6RB8C
         lHl0patDn5k9JyZs98mQl2Z4pXKqyKOo4wuWklvJJodWC5RJQnUjSN0YMKfwW+EddL4s
         6b4eQE0r4YNmJjZTXzqrWU8Dwj5bcp4HInO/BtHI9ZyaUccavdtexl26VYXAlI50khXw
         /B8JeA/yal7iZj4xRS2ni5cY7zuXea8f8krJ44eJ+OFsJH205ATqc3zpBQn1tqBomxzj
         dmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681511932; x=1684103932;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u72sfQIiyGI9PZMMR7INhqrdPHz4ajYrG9ug2XxrGf8=;
        b=Tb7sgieez04bi2GqK6wSWOPEg+ADDD4syIWuGq1PY2XXBNWUBmOoGt7+r6Mf69Fnms
         ABzWf0fVSn06yagDXipSLq3wzTN8UjJ1ofqzCAdYw8h/bYSJmADgudsP21DmHDK/frnh
         aimLs+MVqbeY599vOs4C1O9M2/z4fNmyWN4b5tBOeTkxTxMh+5XBmxjgmBxv0oAg96lb
         cdoC5ZkDInWkFa+CNKhPktqTiftDeo4nVTHBa0e3h9SmBjjnZiNmtDjONRVSHlWwhllb
         oxIG8kjQn26zetaqa6Vl3RW/ZugIbYB8DsSgtEBTTIZmqdjzva3Xssx1Vc5nHqUqaTcS
         AXsQ==
X-Gm-Message-State: AAQBX9efmNz0+3SNTWd+aXWRMeUXKcoFiDSQjcPL6XX28ibT2xGHEsib
        zyduRR4NyhEteLUfmfw2PNdkpgfqpMXpfPQJrg==
X-Google-Smtp-Source: AKy350bhY70y/H5pYwAAElLi8bkRyIjTNrLHAHE97EktBNTsHgOY0g7JPn/ip/1olC+XB2+RmfbP50U61gXx7ivQaQ==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a05:6a00:2387:b0:625:5949:6dc0 with
 SMTP id f7-20020a056a00238700b0062559496dc0mr3928559pfc.4.1681511931841; Fri,
 14 Apr 2023 15:38:51 -0700 (PDT)
Date:   Fri, 14 Apr 2023 22:38:50 +0000
In-Reply-To: <ZDiCG/7OgDI0SwMR@google.com> (message from Sean Christopherson
 on Thu, 13 Apr 2023 15:28:43 -0700)
Mime-Version: 1.0
Message-ID: <diqzbkjqnl6t.fsf@ackerleytng-cloudtop.c.googlers.com>
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
From:   Ackerley Tng <ackerleytng@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     brauner@kernel.org, kirill.shutemov@linux.intel.com,
        chao.p.peng@linux.intel.com, hughd@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        corbet@lwn.net, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, shuah@kernel.org, rppt@kernel.org,
        steven.price@arm.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        vannapurve@google.com, yu.c.zhang@linux.intel.com, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, qperret@google.com, michael.roth@amd.com,
        mhocko@suse.com, songmuchun@bytedance.com, pankaj.gupta@amd.com,
        linux-arch@vger.kernel.org, arnd@arndb.de, linmiaohe@huawei.com,
        naoya.horiguchi@nec.com, tabba@google.com, wei.w.wang@intel.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Apr 13, 2023, Christian Brauner wrote:
>> On Thu, Aug 18, 2022 at 04:24:21PM +0300, Kirill A . Shutemov wrote:
>> > On Wed, Aug 17, 2022 at 10:40:12PM -0700, Hugh Dickins wrote:
>> > > Here's what I would prefer, and imagine much easier for you to  
>> maintain;
>> > > but I'm no system designer, and may be misunderstanding throughout.
>> > >
>> > > QEMU gets fd from opening /dev/kvm_something, uses ioctls (or perhaps
>> > > the fallocate syscall interface itself) to allocate and free the  
>> memory,
>> > > ioctl for initializing some of it too.  KVM in control of whether  
>> that
>> > > fd can be read or written or mmap'ed or whatever, no need to prevent  
>> it
>> > > in shmem.c, no need for flags, seals, notifications to and fro  
>> because
>> > > KVM is already in control and knows the history.  If shmem actually  
>> has
>> > > value, call into it underneath - somewhat like SysV SHM, and  
>> /dev/zero
>> > > mmap, and i915/gem make use of it underneath.  If shmem has nothing  
>> to
>> > > add, just allocate and free kernel memory directly, recorded in your
>> > > own xarray.
>> >
>> > I guess shim layer on top of shmem *can* work. I don't see immediately  
>> why
>> > it would not. But I'm not sure it is right direction. We risk creating  
>> yet
>> > another parallel VM with own rules/locking/accounting that opaque to
>> > core-mm.

>> Sorry for necrobumping this thread but I've been reviewing the

> No worries, I'm just stoked someone who actually knows what they're doing  
> is
> chiming in :-)


+1, thanks Christian!

>> memfd_restricted() extension that Ackerley is currently working on. I
>> was pointed to this thread as this is what the extension is building
>> on but I'll reply to both threads here.

>>  From a glance at v10, memfd_restricted() is currently implemented as an
>> in-kernel stacking filesystem. A call to memfd_restricted() creates a
>> new restricted memfd file and a new unlinked tmpfs file and stashes the
>> tmpfs file into the memfd file's private data member. It then uses the
>> tmpfs file's f_ops and i_ops to perform the relevant file and inode
>> operations. So it has the same callstack as a general stacking
>> filesystem like overlayfs in some cases:

>>          memfd_restricted->getattr()
>>          -> tmpfs->getattr()

> ...

>> Since you're effectively acting like a stacking filesystem you should
>> really use the device number of your memfd restricted filesystem. IOW,
>> sm like:

>>          stat->dev = memfd_restricted_dentry->d_sb->s_dev;

>> But then you run into trouble if you want to go forward with Ackerley's
>> extension that allows to explicitly pass in tmpfs fds to
>> memfd_restricted(). Afaict, two tmpfs instances might allocate the same
>> inode number. So now the inode and device number pair isn't unique
>> anymore.

>> So you might best be served by allocating and reporting your own inode
>> numbers as well.

>> But if you want to preserve the inode number and device number of the
>> relevant tmpfs instance but still report memfd restricted as your
>> filesystem type

> Unless I missed something along the way, reporting memfd_restricted as a  
> distinct
> filesystem is very much a non-goal.  AFAIK it's purely a side effect of  
> the
> proposed implementation.

>> then I think it's reasonable to ask whether a stacking implementation  
>> really
>> makes sense here.

>> If you extend memfd_restricted() or even consider extending it in the
>> future to take tmpfs file descriptors as arguments to identify the tmpfs
>> instance in which to allocate the underlying tmpfs file for the new
>> restricted memfd file you should really consider a tmpfs based
>> implementation.

>> Because at that point it just feels like a pointless wrapper to get
>> custom f_ops and i_ops. Plus it's wasteful because you allocate dentries
>> and inodes that you don't really care about at all.

>> Just off the top of my hat you might be better served:
>> * by a new ioctl() on tmpfs instances that
>>    yield regular tmpfs file descriptors with restricted f_ops and i_ops.
>>    That's not that different from btrfs subvolumes which effectively are
>>    directories but are created through an ioctl().

> I think this is more or less what we want to do, except via a dedicated  
> syscall
> instead of an ioctl() so that the primary interface isn't strictly tied  
> to tmpfs,
> e.g. so that it can be extended to other backing types in the future.

>> * by a mount option to tmpfs that makes it act
>>    in this restricted manner then you don't need an ioctl() and can get
>>    away with regular open calls. Such a tmpfs instance would only create
>>    regular, restricted memfds.

> I'd prefer to not go this route, becuase IIUC, it would require  
> relatively invasive
> changes to shmem code, and IIUC would require similar changes to other  
> support
> backings in the future, e.g. hugetlbfs?  And as above, I don't think any  
> of the
> potential use cases need restrictedmem to be a uniquely identifiable
> mount.

FWIW, I'm starting to look at extending restrictedmem to hugetlbfs and
the separation that the current implementation has is very helpful. Also
helps that hugetlbfs and tmpfs are structured similarly, I guess.


> One of the goals (hopefully not a pipe dream) is to design restrictmem in  
> such a
> way that extending it to support other backing types isn't terribly  
> difficult.
> In case it's not obvious, most of us working on this stuff aren't  
> filesystems
> experts, and many of us aren't mm experts either.  The more we (KVM folks  
> for the
> most part) can leverage existing code to do the heavy lifting, the better.

> After giving myself a bit of a crash course in file systems, would  
> something like
> the below have any chance of (a) working, (b) getting merged, and (c)  
> being
> maintainable?

> The idea is similar to a stacking filesystem, but instead of stacking,  
> restrictedmem
> hijacks a f_ops and a_ops to create a lightweight shim around tmpfs.   
> There are
> undoubtedly issues and edge cases, I'm just looking for a quick "yes,  
> this might
> be doable" or a "no, that's absolutely bonkers, don't try it".

Not an FS expert by any means, but I did think of approaching it this
way as well!

"Hijacking" perhaps gives this approach a bit of a negative
connotation. I thought this is pretty close to subclassing (as in Object
Oriented Programming). When some methods (e.g. fallocate) are called,
restrictedmem does some work, and calls the same method in the
superclass.

The existing restrictedmem code is a more like instantiating an shmem
object and keeping that object as a field within the restrictedmem
object.

Some (maybe small) issues I can think of now:

(1)

One difficulty with this approach is that other functions may make
assumptions about private_data being of a certain type, or functions may
use private_data.

I checked and IIUC neither shmem nor hugetlbfs use the private_data
field in the inode's i_mapping (also file's f_mapping).

But there's fs/buffer.c which uses private_data, although those
functions seem to be used by FSes like ext4 and fat, not memory-backed
FSes.

We can probably fix this if any backing filesystems of restrictedmem,
like tmpfs and future ones use private_data.

Could the solution here be to store private_data of the superclass
instance in restrictedmem, and then override every method in the
superclass that uses private_data to first restore private_data before
making the superclass call? Perhaps we can take private_lock to change
private_data.

(2)

Perhaps there are other slightly hidden cases that might need cleaning up.

For example, one of the patches in this series amends the
shmem_mapping() function from

return mapping->a_ops == &shmem_aops;

to

return mapping->host->i_sb->s_magic == TMPFS_MAGIC;

The former/original is more accurate since it checks a property of the
mapping itself instead of checking a property of the mapping's host's
superblock.

The impact of changing this guard is more obvious if we now override
a_ops but keep the mapping's host's superblock's s_magic.

Specifically for this example, maybe we should handle restrictedmem in
the caller (me_pagecache_clean()) specially, in addition to shmem.


> Thanks!


> struct restrictedmem {
> 	struct rw_semaphore lock;
> 	struct file *file;
> 	const struct file_operations *backing_f_ops;
> 	const struct address_space_operations *backing_a_ops;
> 	struct xarray bindings;
> 	bool exclusive;
> };

> static int restrictedmem_release(struct inode *inode, struct file *file)
> {
> 	struct restrictedmem *rm = inode->i_mapping->private_data;

> 	xa_destroy(&rm->bindings);
> 	kfree(rm);

> 	WARN_ON_ONCE(rm->backing_f_ops->release);
> 	return 0;
> }

> static long restrictedmem_punch_hole(struct restrictedmem *rm, int mode,
> 				     loff_t offset, loff_t len)
> {
> 	struct restrictedmem_notifier *notifier;
> 	unsigned long index;
> 	pgoff_t start, end;
> 	int ret;

> 	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
> 		return -EINVAL;

> 	start = offset >> PAGE_SHIFT;
> 	end = (offset + len) >> PAGE_SHIFT;

> 	/*
> 	 * Bindings must be stable across invalidation to ensure the start+end
> 	 * are balanced.
> 	 */
> 	down_read(&rm->lock);

> 	xa_for_each_range(&rm->bindings, index, notifier, start, end - 1)
> 		notifier->ops->invalidate_start(notifier, start, end);

> 	ret = rm->backing_f_ops->fallocate(rm->file, mode, offset, len);

> 	xa_for_each_range(&rm->bindings, index, notifier, start, end - 1)
> 		notifier->ops->invalidate_end(notifier, start, end);

> 	up_read(&rm->lock);

> 	return ret;
> }

> static long restrictedmem_fallocate(struct file *file, int mode,
> 				    loff_t offset, loff_t len)
> {
> 	struct restrictedmem *rm = file->f_mapping->private_data;

> 	if (mode & FALLOC_FL_PUNCH_HOLE)
> 		return restrictedmem_punch_hole(rm, mode, offset, len);

> 	return rm->backing_f_ops->fallocate(file, mode, offset, len);
> }

> static int restrictedmem_migrate_folio(struct address_space *mapping,
> 				       struct folio *dst, struct folio *src,
> 				       enum migrate_mode)
> {
> 	WARN_ON_ONCE(1);
> 	return -EINVAL;
> }

> static int restrictedmem_error_page(struct address_space *mapping,
> 				    struct page *page)
> {
> 	struct restrictedmem *rm = mapping->private_data;
> 	struct restrictedmem_notifier *notifier;
> 	unsigned long index;
> 	pgoff_t start, end;

> 	start = page->index;
> 	end = start + thp_nr_pages(page);

> 	down_read(&rm->lock);

> 	xa_for_each_range(&rm->bindings, index, notifier, start, end - 1)
> 		notifier->ops->error(notifier, start, end);

> 	up_read(&rm->lock);

> 	return rm->backing_a_ops->error_remove_page(mapping, page);
> }

When I was thinking of this I was stuck on handling error_remove_page,
because it was looking up the superblock to iterate over the inodes to
find the right mapping. Glad to see that the solution is simply to use
the given mapping from the arguments!


> static const struct file_operations restrictedmem_fops = {
> 	.release = restrictedmem_release,
> 	.fallocate = restrictedmem_fallocate,
> };

> static const struct address_space_operations restrictedmem_aops = {
> 	.dirty_folio = noop_dirty_folio,
> #ifdef CONFIG_MIGRATION
> 	.migrate_folio	= restrictedmem_migrate_folio,
> #endif
> 	.error_remove_page = restrictedmem_error_page,
> };

> static int restrictedmem_file_create(struct file *file)
> {
> 	struct address_space *mapping = file->f_mapping;
> 	struct restrictedmem *rm;

> 	rm = kzalloc(sizeof(*rm), GFP_KERNEL);
> 	if (!rm)
> 		return -ENOMEM;

> 	rm->backing_f_ops = file->f_op;
> 	rm->backing_a_ops = mapping->a_ops;
> 	rm->file = file;

We don't really need to do this, since rm->file is already the same as
file, we could just pass the file itself when it's needed

> 	init_rwsem(&rm->lock);
> 	xa_init(&rm->bindings);

> 	file->f_flags |= O_LARGEFILE;

> 	file->f_op = &restrictedmem_fops;
> 	mapping->a_ops = &restrictedmem_aops;

I think we probably have to override inode_operations as well, because
otherwise other methods would become available to a restrictedmem file
(like link, unlink, mkdir, tmpfile). Or maybe that's a feature instead
of a bug.


> 	mapping_set_unevictable(mapping);
> 	mapping_set_unmovable(mapping);
> 	mapping_set_gfp_mask(mapping,
> 			     mapping_gfp_mask(mapping) & ~__GFP_MOVABLE);
> 	return 0;
> }


> static int restrictedmem_create(struct vfsmount *mount)
> {
> 	struct file *file;
> 	int fd, err;

> 	fd = get_unused_fd_flags(0);
> 	if (fd < 0)
> 		return fd;

> 	file = shmem_file_setup_with_mnt(mount, "memfd:restrictedmem", 0,  
> VM_NORESERVE);
> 	if (IS_ERR(file)) {
> 		err = PTR_ERR(file);
> 		goto err_fd;
> 	}
> 	if (WARN_ON_ONCE(file->private_data)) {
> 		err = -EEXIST;
> 		goto err_fd;
> 	}

Did you intend this as a check that the backing filesystem isn't using
the private_data field in the mapping?

I think you meant file->f_mapping->private_data.

On this note, we will probably have to fix things whenever any backing
filesystems need the private_data field.


> 	file->f_mode |= FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
> 	file->f_flags |= O_LARGEFILE;

> 	err = restrictedmem_file_create(file);
> 	if (err) {
> 		fput(file);
> 		goto err_fd;
> 	}

> 	fd_install(fd, file);
> 	return fd;
> err_fd:
> 	put_unused_fd(fd);
> 	return err;
> }

> SYSCALL_DEFINE2(memfd_restricted, unsigned int, flags, int, mount_fd)
> {
> 	struct vfsmount *mnt;
> 	struct path *path;
> 	struct fd f;
> 	int ret;

> 	if (flags)
> 		return -EINVAL;

> 	f = fdget_raw(mount_fd);
> 	if (!f.file)
> 		return -EBADF;

> 	ret = -EINVAL;

> 	path = &f.file->f_path;
> 	if (path->dentry != path->mnt->mnt_root)
> 		goto out;


> 	/* Disallow bind-mounts that aren't bind-mounts of the whole filesystem.  
> */
> 	mnt = path->mnt;
> 	if (mnt->mnt_root != mnt->mnt_sb->s_root)
> 		goto out;

> 	/*
> 	 * The filesystem must be mounted no-execute, executing from guest
> 	 * private memory in the host is nonsensical and unsafe.
> 	 */
> 	if (!(mnt->mnt_sb->s_iflags & SB_I_NOEXEC))
> 		goto out;

> 	/* Currently only TMPFS is supported as underlying storage. */
> 	if (mnt->mnt_sb->s_magic != TMPFS_MAGIC)
> 		goto out;

> 	ret = mnt_want_write(mnt);
> 	if (ret)
> 		goto out;

> 	ret = restrictedmem_create(mnt);

> 	if (mnt)
> 		mnt_drop_write(mnt);
> out:
> 	if (f.file)
> 		fdput(f);

> 	return ret;
> }
