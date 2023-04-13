Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3FA6E110B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 17:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjDMP0T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 11:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjDMP0N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:26:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73962B475;
        Thu, 13 Apr 2023 08:25:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C57B660AE8;
        Thu, 13 Apr 2023 15:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62C6C433D2;
        Thu, 13 Apr 2023 15:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681399556;
        bh=zMMSz7UxmBs4ks0bwKlKnG9T7p0SUxOiLyGNhAIhB5M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=W3/kjaO8SiHj6VmofMfSh1UTsiI3K9oS9hlYBrhqKI6ARFzNWEjw0InjaqHgx/DGp
         N7B/g5pEYn6IsMw9ymOSYFZW2e8FvywPPM1LD3l5yCmWCXBH9Ypyy1eg2F+WMBN5FP
         25m+A9nAzr4Zg1pE0tYWRaZhpDL0AKMgBTe08ZGLJkLTG5fIK4byV4mX3BDld08db1
         lbCLRjYLR5XZ5+aEaoefm8DJBbiT3PoZeaELPCEuO3xygtijXIskdy/h0IRlYCI1yf
         u3cC7BPxKxn9DFNgxmjGNAVHOCzkyje2W8sXJ4Y+PKHTBxDXHsZj/Q/HaEnksFXLdp
         SJsPZpJZlx/9w==
Date:   Thu, 13 Apr 2023 17:25:42 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Hugh Dickins <hughd@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>, linux-arch@vger.kernel.org,
        arnd@arndb.de, linmiaohe@huawei.com, naoya.horiguchi@nec.com,
        tabba@google.com, wei.w.wang@intel.com
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <20230413-anlegen-ergibt-cbefffe0b3de@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220818132421.6xmjqduempmxnnu2@box>
 <diqzlej60z57.fsf@ackerleytng-cloudtop.c.googlers.com>
 <20221202061347.1070246-2-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 18, 2022 at 04:24:21PM +0300, Kirill A . Shutemov wrote:
> On Wed, Aug 17, 2022 at 10:40:12PM -0700, Hugh Dickins wrote:
> > On Wed, 6 Jul 2022, Chao Peng wrote:
> > > This is the v7 of this series which tries to implement the fd-based KVM
> > > guest private memory.
> > 
> > Here at last are my reluctant thoughts on this patchset.
> > 
> > fd-based approach for supporting KVM guest private memory: fine.
> > 
> > Use or abuse of memfd and shmem.c: mistaken.
> > 
> > memfd_create() was an excellent way to put together the initial prototype.
> > 
> > But since then, TDX in particular has forced an effort into preventing
> > (by flags, seals, notifiers) almost everything that makes it shmem/tmpfs.
> > 
> > Are any of the shmem.c mods useful to existing users of shmem.c? No.
> > Is MFD_INACCESSIBLE useful or comprehensible to memfd_create() users? No.
> > 
> > What use do you have for a filesystem here?  Almost none.
> > IIUC, what you want is an fd through which QEMU can allocate kernel
> > memory, selectively free that memory, and communicate fd+offset+length
> > to KVM.  And perhaps an interface to initialize a little of that memory
> > from a template (presumably copied from a real file on disk somewhere).
> > 
> > You don't need shmem.c or a filesystem for that!
> > 
> > If your memory could be swapped, that would be enough of a good reason
> > to make use of shmem.c: but it cannot be swapped; and although there
> > are some references in the mailthreads to it perhaps being swappable
> > in future, I get the impression that will not happen soon if ever.
> > 
> > If your memory could be migrated, that would be some reason to use
> > filesystem page cache (because page migration happens to understand
> > that type of memory): but it cannot be migrated.
> 
> Migration support is in pipeline. It is part of TDX 1.5 [1]. And swapping
> theoretically possible, but I'm not aware of any plans as of now.
> 
> [1] https://www.intel.com/content/www/us/en/developer/articles/technical/intel-trust-domain-extensions.html
> 
> > Some of these impressions may come from earlier iterations of the
> > patchset (v7 looks better in several ways than v5).  I am probably
> > underestimating the extent to which you have taken on board other
> > usages beyond TDX and SEV private memory, and rightly want to serve
> > them all with similar interfaces: perhaps there is enough justification
> > for shmem there, but I don't see it.  There was mention of userfaultfd
> > in one link: does that provide the justification for using shmem?
> > 
> > I'm afraid of the special demands you may make of memory allocation
> > later on - surprised that huge pages are not mentioned already;
> > gigantic contiguous extents? secretmem removed from direct map?
> 
> The design allows for extension to hugetlbfs if needed. Combination of
> MFD_INACCESSIBLE | MFD_HUGETLB should route this way. There should be zero
> implications for shmem. It is going to be separate struct memfile_backing_store.
> 
> I'm not sure secretmem is a fit here as we want to extend MFD_INACCESSIBLE
> to be movable if platform supports it and secretmem is not migratable by
> design (without direct mapping fragmentations).
> 
> > Here's what I would prefer, and imagine much easier for you to maintain;
> > but I'm no system designer, and may be misunderstanding throughout.
> > 
> > QEMU gets fd from opening /dev/kvm_something, uses ioctls (or perhaps
> > the fallocate syscall interface itself) to allocate and free the memory,
> > ioctl for initializing some of it too.  KVM in control of whether that
> > fd can be read or written or mmap'ed or whatever, no need to prevent it
> > in shmem.c, no need for flags, seals, notifications to and fro because
> > KVM is already in control and knows the history.  If shmem actually has
> > value, call into it underneath - somewhat like SysV SHM, and /dev/zero
> > mmap, and i915/gem make use of it underneath.  If shmem has nothing to
> > add, just allocate and free kernel memory directly, recorded in your
> > own xarray.
> 
> I guess shim layer on top of shmem *can* work. I don't see immediately why
> it would not. But I'm not sure it is right direction. We risk creating yet
> another parallel VM with own rules/locking/accounting that opaque to
> core-mm.

Sorry for necrobumping this thread but I've been reviewing the
memfd_restricted() extension that Ackerley is currently working on. I
was pointed to this thread as this is what the extension is building
on but I'll reply to both threads here.

From a glance at v10, memfd_restricted() is currently implemented as an
in-kernel stacking filesystem. A call to memfd_restricted() creates a
new restricted memfd file and a new unlinked tmpfs file and stashes the
tmpfs file into the memfd file's private data member. It then uses the
tmpfs file's f_ops and i_ops to perform the relevant file and inode
operations. So it has the same callstack as a general stacking
filesystem like overlayfs in some cases:

        memfd_restricted->getattr()
        -> tmpfs->getattr()
        
The extension that Ackerley is now proposing is to allow passing in a
tmpfs file descriptor explicitly to identify the tmpfs instance in which
to allocate the tmpfs file which is stashed in the memfd secret file.

So in the ->getattr() callstack I mentioned above this patchset
currently does:

        static int restrictedmem_getattr(struct user_namespace *mnt_userns,
                                        const struct path *path, struct kstat stat,
                                        u32 request_mask, unsigned int uery_flags)
        {
               struct inode *inode = d_inode(path->dentry);
               struct restrictedmem_data *data = node->i_mapping->private_data;
               struct file *memfd = data->memfd;
        
               return memfd->f_inode->i_op->getattr(mnt_userns, path, stat,
                                                    request_mask, query_flags);
        }

There's a bug in here that I mentioned in another thread and I see that
Ackerley has mentioned as well in
https://lore.kernel.org/lkml/diqzzga0fv96.fsf@ackerleytng-cloudtop-sg.c.googlers.com
namely that this is passing a restricted memfd struct path to a tmpfs
inode operation which is very wrong.

But also in the current implementation - I mentioned this in the other
thread as well - when you call stat() on a restricted memfd file
descriptor you get all the information about the underlying tmpfs inode.
Specifically this includes the device number and inode number.

But when you call statfs() then you get a report that this is a memfd
restricted filesystem which somehow shares the device number with a
tmpfs instance. That's messy.

Since you're effectively acting like a stacking filesystem you should
really use the device number of your memfd restricted filesystem. IOW,
sm like:

        stat->dev = memfd_restricted_dentry->d_sb->s_dev;

But then you run into trouble if you want to go forward with Ackerley's
extension that allows to explicitly pass in tmpfs fds to
memfd_restricted(). Afaict, two tmpfs instances might allocate the same
inode number. So now the inode and device number pair isn't unique
anymore.

So you might best be served by allocating and reporting your own inode
numbers as well.

But if you want to preserve the inode number and device number of the
relevant tmpfs instance but still report memfd restricted as your
filesystem type then I think it's reasonable to ask whether a stacking
implementation really makes sense here.

If you extend memfd_restricted() or even consider extending it in the
future to take tmpfs file descriptors as arguments to identify the tmpfs
instance in which to allocate the underlying tmpfs file for the new
restricted memfd file you should really consider a tmpfs based
implementation.

Because at that point it just feels like a pointless wrapper to get
custom f_ops and i_ops. Plus it's wasteful because you allocate dentries
and inodes that you don't really care about at all.

Just off the top of my hat you might be better served:
* by a new ioctl() on tmpfs instances that
  yield regular tmpfs file descriptors with restricted f_ops and i_ops.
  That's not that different from btrfs subvolumes which effectively are
  directories but are created through an ioctl().
* by a mount option to tmpfs that makes it act
  in this restricted manner then you don't need an ioctl() and can get
  away with regular open calls. Such a tmpfs instance would only create
  regular, restricted memfds.

I think especially with the possibility of an extension that allows you
to inherit tmpfs properties by allocating the memfd restriced file in a
specific tmpfs instance the argument that you're not really making use
of tmpfs things has gone out of the window.

> 
> Note that on machines that run TDX guests such memory would likely be the
> bulk of memory use. Treating it as a fringe case may bite us one day.
> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov

On Wed, Apr 05, 2023 at 09:58:44PM +0000, Ackerley Tng wrote:
> 
> Thanks again for your review!
> 
> Christian Brauner <brauner@kernel.org> writes:
> > On Tue, Apr 04, 2023 at 03:53:13PM +0200, Christian Brauner wrote:
> > > On Fri, Mar 31, 2023 at 11:50:39PM +0000, Ackerley Tng wrote:
> > > >
> > > > ...
> > > >
> > > > -SYSCALL_DEFINE1(memfd_restricted, unsigned int, flags)
> > > > +static int restrictedmem_create(struct vfsmount *mount)
> > > >  {
> > > >  	struct file *file, *restricted_file;
> > > >  	int fd, err;
> > > >
> > > > -	if (flags)
> > > > -		return -EINVAL;
> > > > -
> > > >  	fd = get_unused_fd_flags(0);
> 
> > > Any reasons the file descriptors aren't O_CLOEXEC by default? I don't
> > > see any reasons why we should introduce new fdtypes that aren't
> > > O_CLOEXEC by default. The "don't mix-and-match" train has already left
> > > the station anyway as we do have seccomp noitifer fds and pidfds both of
> > > which are O_CLOEXEC by default.
> 
> 
> Thanks for pointing this out. I agree with using O_CLOEXEC, but didn’t
> notice this before. Let us discuss this under the original series at
> [1].
> 
> > > >  	if (fd < 0)
> > > >  		return fd;
> > > >
> > > > -	file = shmem_file_setup("memfd:restrictedmem", 0, VM_NORESERVE);
> > > > +	if (mount)
> > > > +		file = shmem_file_setup_with_mnt(mount, "memfd:restrictedmem",
> > > 0, VM_NORESERVE);
> > > > +	else
> > > > +		file = shmem_file_setup("memfd:restrictedmem", 0, VM_NORESERVE);
> > > > +
> > > >  	if (IS_ERR(file)) {
> > > >  		err = PTR_ERR(file);
> > > >  		goto err_fd;
> > > > @@ -223,6 +225,66 @@ SYSCALL_DEFINE1(memfd_restricted, unsigned
> > > int, flags)
> > > >  	return err;
> > > >  }
> > > >
> > > > +static bool is_shmem_mount(struct vfsmount *mnt)
> > > > +{
> > > > +	return mnt && mnt->mnt_sb && mnt->mnt_sb->s_magic == TMPFS_MAGIC;
> 
> > > This can just be if (mnt->mnt_sb->s_magic == TMPFS_MAGIC).
> 
> 
> Will simplify this in the next revision.
> 
> > > > +}
> > > > +
> > > > +static bool is_mount_root(struct file *file)
> > > > +{
> > > > +	return file->f_path.dentry == file->f_path.mnt->mnt_root;
> 
> > > mount -t tmpfs tmpfs /mnt
> > > touch /mnt/bla
> > > touch /mnt/ble
> > > mount --bind /mnt/bla /mnt/ble
> > > fd = open("/mnt/ble")
> > > fd_restricted = memfd_restricted(fd)
> 
> > > IOW, this doesn't restrict it to the tmpfs root. It only restricts it to
> > > paths that refer to the root of any tmpfs mount. To exclude bind-mounts
> > > that aren't bind-mounts of the whole filesystem you want:
> 
> > > path->dentry == path->mnt->mnt_root &&
> > > path->mnt->mnt_root == path->mnt->mnt_sb->s_root
> 
> 
> Will adopt this in the next revision and add a selftest to check
> this. Thanks for pointing this out!
> 
> > > > +}
> > > > +
> > > > +static int restrictedmem_create_on_user_mount(int mount_fd)
> > > > +{
> > > > +	int ret;
> > > > +	struct fd f;
> > > > +	struct vfsmount *mnt;
> > > > +
> > > > +	f = fdget_raw(mount_fd);
> > > > +	if (!f.file)
> > > > +		return -EBADF;
> > > > +
> > > > +	ret = -EINVAL;
> > > > +	if (!is_mount_root(f.file))
> > > > +		goto out;
> > > > +
> > > > +	mnt = f.file->f_path.mnt;
> > > > +	if (!is_shmem_mount(mnt))
> > > > +		goto out;
> > > > +
> > > > +	ret = file_permission(f.file, MAY_WRITE | MAY_EXEC);
> 
> > > With the current semantics you're asking whether you have write
> > > permissions on the /mnt/ble file in order to get answer to the question
> > > whether you're allowed to create an unlinked restricted memory file.
> > > That doesn't make much sense afaict.
> 
> 
> That's true. Since mnt_want_write() already checks for write permissions
> and this syscall creates an unlinked file on the mount, we don't have to
> check permissions on the file then. Will remove this in the next
> revision!
> 
> > > > +	if (ret)
> > > > +		goto out;
> > > > +
> > > > +	ret = mnt_want_write(mnt);
> > > > +	if (unlikely(ret))
> > > > +		goto out;
> > > > +
> > > > +	ret = restrictedmem_create(mnt);
> > > > +
> > > > +	mnt_drop_write(mnt);
> > > > +out:
> > > > +	fdput(f);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +SYSCALL_DEFINE2(memfd_restricted, unsigned int, flags, int, mount_fd)
> > > > +{
> > > > +	if (flags & ~RMFD_USERMNT)
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (flags == RMFD_USERMNT) {
> 
> > > Why do you even need this flag? It seems that @mount_fd being < 0 is
> > > sufficient to indicate that a new restricted memory fd is supposed to be
> > > created in the system instance.
> 
> 
> I'm hoping to have this patch series merged after Chao's patch series
> introduces the memfd_restricted() syscall [1].
> 
> This flag is necessary to indicate the validity of the second argument.
> 
> With this flag, we can definitively return an error if the fd is
> invalid, which I think is a better experience for the userspace
> programmer than if we just silently default to the kernel mount when the
> fd provided is invalid.
> 
> > > > +		if (mount_fd < 0)
> > > > +			return -EINVAL;
> > > > +
> > > > +		return restrictedmem_create_on_user_mount(mount_fd);
> > > > +	} else {
> > > > +		return restrictedmem_create(NULL);
> > > > +	}
> > > > +}
> 
> > > I have to say that I'm very confused by all of this the more I look
> > > at it.
> 
> > > Effectively memfd restricted functions as a wrapper filesystem around
> > > the tmpfs filesystem. This is basically a weird overlay filesystem.
> > > You're allocating tmpfs files that you stash in restrictedmem files.
> > > I have to say that this seems very hacky. I didn't get this at all at
> > > first.
> 
> > > So what does the caller get if they call statx() on a restricted memfd?
> > > Do they get the device number of the tmpfs mount and the inode numbers
> > > of the tmpfs mount? Because it looks like they would:
> 
> > > static int restrictedmem_getattr(struct user_namespace *mnt_userns,
> > > 				 const struct path *path, struct kstat *stat,
> > > 				 u32 request_mask, unsigned int query_flags)
> > > {
> > > 	struct inode *inode = d_inode(path->dentry);
> > > 	struct restrictedmem *rm = inode->i_mapping->private_data;
> > > 	struct file *memfd = rm->memfd;
> 
> > > 	return memfd->f_inode->i_op->getattr(mnt_userns, path, stat,
> 
> > This is pretty broken btw, because @path refers to a restrictedmem path
> > which you're passing to a tmpfs iop...
> 
> > I see that in
> 
> > 	return memfd->f_inode->i_op->getattr(mnt_userns, &memfd->f_path, stat,
> > 					     request_mask, query_flags);
> 
> > this if fixed but still, this is... not great.
> 
> 
> Thanks, this will be fixed in the next revision by rebasing on Chao's
> latest code.
> 
> > > 					     request_mask, query_flags);
> 
> > > That @memfd would be a struct file allocated in a tmpfs instance, no? So
> > > you'd be calling the inode operation of the tmpfs file meaning that
> > > struct kstat will be filled up with the info from the tmpfs instance.
> 
> > > But then if I call statfs() and check the fstype I would get
> > > RESTRICTEDMEM_MAGIC, no? This is... unorthodox?
> 
> > > I'm honestly puzzled and this sounds really strange. There must be a
> > > better way to implement all of this.
> 
> > > Shouldn't you try and make this a part of tmpfs proper? Make a really
> > > separate filesystem and add a memfs library that both tmpfs and
> > > restrictedmemfs can use? Add a mount option to tmpfs that makes it a
> > > restricted tmpfs?
> 
> This was discussed earlier in the patch series introducing
> memfd_restricted and this approach was taken to better manage ownership
> of required functionalities between two subsystems. Please see
> discussion beginning [2]
> 
> [1] -> https://lore.kernel.org/lkml/20221202061347.1070246-1-chao.p.peng@linux.intel.com/T/.
> [2] ->
> https://lore.kernel.org/lkml/ff5c5b97-acdf-9745-ebe5-c6609dd6322e@google.com/

On Fri, Dec 02, 2022 at 02:13:39PM +0800, Chao Peng wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Introduce 'memfd_restricted' system call with the ability to create
> memory areas that are restricted from userspace access through ordinary
> MMU operations (e.g. read/write/mmap). The memory content is expected to
> be used through the new in-kernel interface by a third kernel module.
> 
> memfd_restricted() is useful for scenarios where a file descriptor(fd)
> can be used as an interface into mm but want to restrict userspace's
> ability on the fd. Initially it is designed to provide protections for
> KVM encrypted guest memory.
> 
> Normally KVM uses memfd memory via mmapping the memfd into KVM userspace
> (e.g. QEMU) and then using the mmaped virtual address to setup the
> mapping in the KVM secondary page table (e.g. EPT). With confidential
> computing technologies like Intel TDX, the memfd memory may be encrypted
> with special key for special software domain (e.g. KVM guest) and is not
> expected to be directly accessed by userspace. Precisely, userspace
> access to such encrypted memory may lead to host crash so should be
> prevented.
> 
> memfd_restricted() provides semantics required for KVM guest encrypted
> memory support that a fd created with memfd_restricted() is going to be
> used as the source of guest memory in confidential computing environment
> and KVM can directly interact with core-mm without the need to expose
> the memoy content into KVM userspace.
> 
> KVM userspace is still in charge of the lifecycle of the fd. It should
> pass the created fd to KVM. KVM uses the new restrictedmem_get_page() to
> obtain the physical memory page and then uses it to populate the KVM
> secondary page table entries.
> 
> The userspace restricted memfd can be fallocate-ed or hole-punched
> from userspace. When hole-punched, KVM can get notified through
> invalidate_start/invalidate_end() callbacks, KVM then gets chance to
> remove any mapped entries of the range in the secondary page tables.
> 
> Machine check can happen for memory pages in the restricted memfd,
> instead of routing this directly to userspace, we call the error()
> callback that KVM registered. KVM then gets chance to handle it
> correctly.
> 
> memfd_restricted() itself is implemented as a shim layer on top of real
> memory file systems (currently tmpfs). Pages in restrictedmem are marked
> as unmovable and unevictable, this is required for current confidential
> usage. But in future this might be changed.
> 
> By default memfd_restricted() prevents userspace read, write and mmap.
> By defining new bit in the 'flags', it can be extended to support other
> restricted semantics in the future.
> 
> The system call is currently wired up for x86 arch.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  arch/x86/entry/syscalls/syscall_32.tbl |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
>  include/linux/restrictedmem.h          |  71 ++++++
>  include/linux/syscalls.h               |   1 +
>  include/uapi/asm-generic/unistd.h      |   5 +-
>  include/uapi/linux/magic.h             |   1 +
>  kernel/sys_ni.c                        |   3 +
>  mm/Kconfig                             |   4 +
>  mm/Makefile                            |   1 +
>  mm/memory-failure.c                    |   3 +
>  mm/restrictedmem.c                     | 318 +++++++++++++++++++++++++
>  11 files changed, 408 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/restrictedmem.h
>  create mode 100644 mm/restrictedmem.c
> 
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index 320480a8db4f..dc70ba90247e 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -455,3 +455,4 @@
>  448	i386	process_mrelease	sys_process_mrelease
>  449	i386	futex_waitv		sys_futex_waitv
>  450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
> +451	i386	memfd_restricted	sys_memfd_restricted
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index c84d12608cd2..06516abc8318 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -372,6 +372,7 @@
>  448	common	process_mrelease	sys_process_mrelease
>  449	common	futex_waitv		sys_futex_waitv
>  450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
> +451	common	memfd_restricted	sys_memfd_restricted
>  
>  #
>  # Due to a historical design error, certain syscalls are numbered differently
> diff --git a/include/linux/restrictedmem.h b/include/linux/restrictedmem.h
> new file mode 100644
> index 000000000000..c2700c5daa43
> --- /dev/null
> +++ b/include/linux/restrictedmem.h
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _LINUX_RESTRICTEDMEM_H
> +
> +#include <linux/file.h>
> +#include <linux/magic.h>
> +#include <linux/pfn_t.h>
> +
> +struct restrictedmem_notifier;
> +
> +struct restrictedmem_notifier_ops {
> +	void (*invalidate_start)(struct restrictedmem_notifier *notifier,
> +				 pgoff_t start, pgoff_t end);
> +	void (*invalidate_end)(struct restrictedmem_notifier *notifier,
> +			       pgoff_t start, pgoff_t end);
> +	void (*error)(struct restrictedmem_notifier *notifier,
> +			       pgoff_t start, pgoff_t end);
> +};
> +
> +struct restrictedmem_notifier {
> +	struct list_head list;
> +	const struct restrictedmem_notifier_ops *ops;
> +};
> +
> +#ifdef CONFIG_RESTRICTEDMEM
> +
> +void restrictedmem_register_notifier(struct file *file,
> +				     struct restrictedmem_notifier *notifier);
> +void restrictedmem_unregister_notifier(struct file *file,
> +				       struct restrictedmem_notifier *notifier);
> +
> +int restrictedmem_get_page(struct file *file, pgoff_t offset,
> +			   struct page **pagep, int *order);
> +
> +static inline bool file_is_restrictedmem(struct file *file)
> +{
> +	return file->f_inode->i_sb->s_magic == RESTRICTEDMEM_MAGIC;
> +}
> +
> +void restrictedmem_error_page(struct page *page, struct address_space *mapping);
> +
> +#else
> +
> +static inline void restrictedmem_register_notifier(struct file *file,
> +				     struct restrictedmem_notifier *notifier)
> +{
> +}
> +
> +static inline void restrictedmem_unregister_notifier(struct file *file,
> +				       struct restrictedmem_notifier *notifier)
> +{
> +}
> +
> +static inline int restrictedmem_get_page(struct file *file, pgoff_t offset,
> +					 struct page **pagep, int *order)
> +{
> +	return -1;
> +}
> +
> +static inline bool file_is_restrictedmem(struct file *file)
> +{
> +	return false;
> +}
> +
> +static inline void restrictedmem_error_page(struct page *page,
> +					    struct address_space *mapping)
> +{
> +}
> +
> +#endif /* CONFIG_RESTRICTEDMEM */
> +
> +#endif /* _LINUX_RESTRICTEDMEM_H */
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index a34b0f9a9972..f9e9e0c820c5 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1056,6 +1056,7 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
>  asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
>  					    unsigned long home_node,
>  					    unsigned long flags);
> +asmlinkage long sys_memfd_restricted(unsigned int flags);
>  
>  /*
>   * Architecture-specific system calls
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 45fa180cc56a..e93cd35e46d0 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -886,8 +886,11 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
>  #define __NR_set_mempolicy_home_node 450
>  __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
>  
> +#define __NR_memfd_restricted 451
> +__SYSCALL(__NR_memfd_restricted, sys_memfd_restricted)
> +
>  #undef __NR_syscalls
> -#define __NR_syscalls 451
> +#define __NR_syscalls 452
>  
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> index 6325d1d0e90f..8aa38324b90a 100644
> --- a/include/uapi/linux/magic.h
> +++ b/include/uapi/linux/magic.h
> @@ -101,5 +101,6 @@
>  #define DMA_BUF_MAGIC		0x444d4142	/* "DMAB" */
>  #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
>  #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
> +#define RESTRICTEDMEM_MAGIC	0x5245534d	/* "RESM" */
>  
>  #endif /* __LINUX_MAGIC_H__ */
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index 860b2dcf3ac4..7c4a32cbd2e7 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -360,6 +360,9 @@ COND_SYSCALL(pkey_free);
>  /* memfd_secret */
>  COND_SYSCALL(memfd_secret);
>  
> +/* memfd_restricted */
> +COND_SYSCALL(memfd_restricted);
> +
>  /*
>   * Architecture specific weak syscall entries.
>   */
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 57e1d8c5b505..06b0e1d6b8c1 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1076,6 +1076,10 @@ config IO_MAPPING
>  config SECRETMEM
>  	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
>  
> +config RESTRICTEDMEM
> +	bool
> +	depends on TMPFS
> +
>  config ANON_VMA_NAME
>  	bool "Anonymous VMA name support"
>  	depends on PROC_FS && ADVISE_SYSCALLS && MMU
> diff --git a/mm/Makefile b/mm/Makefile
> index 8e105e5b3e29..bcbb0edf9ba1 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -121,6 +121,7 @@ obj-$(CONFIG_PAGE_EXTENSION) += page_ext.o
>  obj-$(CONFIG_PAGE_TABLE_CHECK) += page_table_check.o
>  obj-$(CONFIG_CMA_DEBUGFS) += cma_debug.o
>  obj-$(CONFIG_SECRETMEM) += secretmem.o
> +obj-$(CONFIG_RESTRICTEDMEM) += restrictedmem.o
>  obj-$(CONFIG_CMA_SYSFS) += cma_sysfs.o
>  obj-$(CONFIG_USERFAULTFD) += userfaultfd.o
>  obj-$(CONFIG_IDLE_PAGE_TRACKING) += page_idle.o
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 145bb561ddb3..f91b444e471e 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -62,6 +62,7 @@
>  #include <linux/page-isolation.h>
>  #include <linux/pagewalk.h>
>  #include <linux/shmem_fs.h>
> +#include <linux/restrictedmem.h>
>  #include "swap.h"
>  #include "internal.h"
>  #include "ras/ras_event.h"
> @@ -940,6 +941,8 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
>  		goto out;
>  	}
>  
> +	restrictedmem_error_page(p, mapping);
> +
>  	/*
>  	 * The shmem page is kept in page cache instead of truncating
>  	 * so is expected to have an extra refcount after error-handling.
> diff --git a/mm/restrictedmem.c b/mm/restrictedmem.c
> new file mode 100644
> index 000000000000..56953c204e5c
> --- /dev/null
> +++ b/mm/restrictedmem.c
> @@ -0,0 +1,318 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "linux/sbitmap.h"
> +#include <linux/pagemap.h>
> +#include <linux/pseudo_fs.h>
> +#include <linux/shmem_fs.h>
> +#include <linux/syscalls.h>
> +#include <uapi/linux/falloc.h>
> +#include <uapi/linux/magic.h>
> +#include <linux/restrictedmem.h>
> +
> +struct restrictedmem_data {
> +	struct mutex lock;
> +	struct file *memfd;
> +	struct list_head notifiers;
> +};
> +
> +static void restrictedmem_invalidate_start(struct restrictedmem_data *data,
> +					   pgoff_t start, pgoff_t end)
> +{
> +	struct restrictedmem_notifier *notifier;
> +
> +	mutex_lock(&data->lock);
> +	list_for_each_entry(notifier, &data->notifiers, list) {
> +		notifier->ops->invalidate_start(notifier, start, end);
> +	}
> +	mutex_unlock(&data->lock);
> +}
> +
> +static void restrictedmem_invalidate_end(struct restrictedmem_data *data,
> +					 pgoff_t start, pgoff_t end)
> +{
> +	struct restrictedmem_notifier *notifier;
> +
> +	mutex_lock(&data->lock);
> +	list_for_each_entry(notifier, &data->notifiers, list) {
> +		notifier->ops->invalidate_end(notifier, start, end);
> +	}
> +	mutex_unlock(&data->lock);
> +}
> +
> +static void restrictedmem_notifier_error(struct restrictedmem_data *data,
> +					 pgoff_t start, pgoff_t end)
> +{
> +	struct restrictedmem_notifier *notifier;
> +
> +	mutex_lock(&data->lock);
> +	list_for_each_entry(notifier, &data->notifiers, list) {
> +		notifier->ops->error(notifier, start, end);
> +	}
> +	mutex_unlock(&data->lock);
> +}
> +
> +static int restrictedmem_release(struct inode *inode, struct file *file)
> +{
> +	struct restrictedmem_data *data = inode->i_mapping->private_data;
> +
> +	fput(data->memfd);
> +	kfree(data);
> +	return 0;
> +}
> +
> +static long restrictedmem_punch_hole(struct restrictedmem_data *data, int mode,
> +				     loff_t offset, loff_t len)
> +{
> +	int ret;
> +	pgoff_t start, end;
> +	struct file *memfd = data->memfd;
> +
> +	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
> +		return -EINVAL;
> +
> +	start = offset >> PAGE_SHIFT;
> +	end = (offset + len) >> PAGE_SHIFT;
> +
> +	restrictedmem_invalidate_start(data, start, end);
> +	ret = memfd->f_op->fallocate(memfd, mode, offset, len);
> +	restrictedmem_invalidate_end(data, start, end);
> +
> +	return ret;
> +}
> +
> +static long restrictedmem_fallocate(struct file *file, int mode,
> +				    loff_t offset, loff_t len)
> +{
> +	struct restrictedmem_data *data = file->f_mapping->private_data;
> +	struct file *memfd = data->memfd;
> +
> +	if (mode & FALLOC_FL_PUNCH_HOLE)
> +		return restrictedmem_punch_hole(data, mode, offset, len);
> +
> +	return memfd->f_op->fallocate(memfd, mode, offset, len);
> +}
> +
> +static const struct file_operations restrictedmem_fops = {
> +	.release = restrictedmem_release,
> +	.fallocate = restrictedmem_fallocate,
> +};
> +
> +static int restrictedmem_getattr(struct user_namespace *mnt_userns,
> +				 const struct path *path, struct kstat *stat,
> +				 u32 request_mask, unsigned int query_flags)
> +{
> +	struct inode *inode = d_inode(path->dentry);
> +	struct restrictedmem_data *data = inode->i_mapping->private_data;
> +	struct file *memfd = data->memfd;
> +
> +	return memfd->f_inode->i_op->getattr(mnt_userns, path, stat,
> +					     request_mask, query_flags);
> +}
> +
> +static int restrictedmem_setattr(struct user_namespace *mnt_userns,
> +				 struct dentry *dentry, struct iattr *attr)
> +{
> +	struct inode *inode = d_inode(dentry);
> +	struct restrictedmem_data *data = inode->i_mapping->private_data;
> +	struct file *memfd = data->memfd;
> +	int ret;
> +
> +	if (attr->ia_valid & ATTR_SIZE) {
> +		if (memfd->f_inode->i_size)
> +			return -EPERM;
> +
> +		if (!PAGE_ALIGNED(attr->ia_size))
> +			return -EINVAL;
> +	}
> +
> +	ret = memfd->f_inode->i_op->setattr(mnt_userns,
> +					    file_dentry(memfd), attr);
> +	return ret;
> +}
> +
> +static const struct inode_operations restrictedmem_iops = {
> +	.getattr = restrictedmem_getattr,
> +	.setattr = restrictedmem_setattr,
> +};
> +
> +static int restrictedmem_init_fs_context(struct fs_context *fc)
> +{
> +	if (!init_pseudo(fc, RESTRICTEDMEM_MAGIC))
> +		return -ENOMEM;
> +
> +	fc->s_iflags |= SB_I_NOEXEC;
> +	return 0;
> +}
> +
> +static struct file_system_type restrictedmem_fs = {
> +	.owner		= THIS_MODULE,
> +	.name		= "memfd:restrictedmem",
> +	.init_fs_context = restrictedmem_init_fs_context,
> +	.kill_sb	= kill_anon_super,
> +};
> +
> +static struct vfsmount *restrictedmem_mnt;
> +
> +static __init int restrictedmem_init(void)
> +{
> +	restrictedmem_mnt = kern_mount(&restrictedmem_fs);
> +	if (IS_ERR(restrictedmem_mnt))
> +		return PTR_ERR(restrictedmem_mnt);
> +	return 0;
> +}
> +fs_initcall(restrictedmem_init);
> +
> +static struct file *restrictedmem_file_create(struct file *memfd)
> +{
> +	struct restrictedmem_data *data;
> +	struct address_space *mapping;
> +	struct inode *inode;
> +	struct file *file;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return ERR_PTR(-ENOMEM);
> +
> +	data->memfd = memfd;
> +	mutex_init(&data->lock);
> +	INIT_LIST_HEAD(&data->notifiers);
> +
> +	inode = alloc_anon_inode(restrictedmem_mnt->mnt_sb);
> +	if (IS_ERR(inode)) {
> +		kfree(data);
> +		return ERR_CAST(inode);
> +	}
> +
> +	inode->i_mode |= S_IFREG;
> +	inode->i_op = &restrictedmem_iops;
> +	inode->i_mapping->private_data = data;
> +
> +	file = alloc_file_pseudo(inode, restrictedmem_mnt,
> +				 "restrictedmem", O_RDWR,
> +				 &restrictedmem_fops);
> +	if (IS_ERR(file)) {
> +		iput(inode);
> +		kfree(data);
> +		return ERR_CAST(file);
> +	}
> +
> +	file->f_flags |= O_LARGEFILE;
> +
> +	/*
> +	 * These pages are currently unmovable so don't place them into movable
> +	 * pageblocks (e.g. CMA and ZONE_MOVABLE).
> +	 */
> +	mapping = memfd->f_mapping;
> +	mapping_set_unevictable(mapping);
> +	mapping_set_gfp_mask(mapping,
> +			     mapping_gfp_mask(mapping) & ~__GFP_MOVABLE);
> +
> +	return file;
> +}
> +
> +SYSCALL_DEFINE1(memfd_restricted, unsigned int, flags)
> +{
> +	struct file *file, *restricted_file;
> +	int fd, err;
> +
> +	if (flags)
> +		return -EINVAL;
> +
> +	fd = get_unused_fd_flags(0);
> +	if (fd < 0)
> +		return fd;
> +
> +	file = shmem_file_setup("memfd:restrictedmem", 0, VM_NORESERVE);
> +	if (IS_ERR(file)) {
> +		err = PTR_ERR(file);
> +		goto err_fd;
> +	}
> +	file->f_mode |= FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
> +	file->f_flags |= O_LARGEFILE;
> +
> +	restricted_file = restrictedmem_file_create(file);
> +	if (IS_ERR(restricted_file)) {
> +		err = PTR_ERR(restricted_file);
> +		fput(file);
> +		goto err_fd;
> +	}
> +
> +	fd_install(fd, restricted_file);
> +	return fd;
> +err_fd:
> +	put_unused_fd(fd);
> +	return err;
> +}
> +
> +void restrictedmem_register_notifier(struct file *file,
> +				     struct restrictedmem_notifier *notifier)
> +{
> +	struct restrictedmem_data *data = file->f_mapping->private_data;
> +
> +	mutex_lock(&data->lock);
> +	list_add(&notifier->list, &data->notifiers);
> +	mutex_unlock(&data->lock);
> +}
> +EXPORT_SYMBOL_GPL(restrictedmem_register_notifier);
> +
> +void restrictedmem_unregister_notifier(struct file *file,
> +				       struct restrictedmem_notifier *notifier)
> +{
> +	struct restrictedmem_data *data = file->f_mapping->private_data;
> +
> +	mutex_lock(&data->lock);
> +	list_del(&notifier->list);
> +	mutex_unlock(&data->lock);
> +}
> +EXPORT_SYMBOL_GPL(restrictedmem_unregister_notifier);
> +
> +int restrictedmem_get_page(struct file *file, pgoff_t offset,
> +			   struct page **pagep, int *order)
> +{
> +	struct restrictedmem_data *data = file->f_mapping->private_data;
> +	struct file *memfd = data->memfd;
> +	struct folio *folio;
> +	struct page *page;
> +	int ret;
> +
> +	ret = shmem_get_folio(file_inode(memfd), offset, &folio, SGP_WRITE);
> +	if (ret)
> +		return ret;
> +
> +	page = folio_file_page(folio, offset);
> +	*pagep = page;
> +	if (order)
> +		*order = thp_order(compound_head(page));
> +
> +	SetPageUptodate(page);
> +	unlock_page(page);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(restrictedmem_get_page);
> +
> +void restrictedmem_error_page(struct page *page, struct address_space *mapping)
> +{
> +	struct super_block *sb = restrictedmem_mnt->mnt_sb;
> +	struct inode *inode, *next;
> +
> +	if (!shmem_mapping(mapping))
> +		return;
> +
> +	spin_lock(&sb->s_inode_list_lock);
> +	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list) {
> +		struct restrictedmem_data *data = inode->i_mapping->private_data;
> +		struct file *memfd = data->memfd;
> +
> +		if (memfd->f_mapping == mapping) {
> +			pgoff_t start, end;
> +
> +			spin_unlock(&sb->s_inode_list_lock);
> +
> +			start = page->index;
> +			end = start + thp_nr_pages(page);
> +			restrictedmem_notifier_error(data, start, end);
> +			return;
> +		}
> +	}
> +	spin_unlock(&sb->s_inode_list_lock);
> +}
> -- 
> 2.25.1
> 
