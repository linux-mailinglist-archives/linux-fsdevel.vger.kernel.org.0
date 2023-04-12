Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDF56DF157
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 12:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjDLKAR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 06:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjDLKAP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:00:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DE572A3;
        Wed, 12 Apr 2023 03:00:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 044DD62D44;
        Wed, 12 Apr 2023 10:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00809C4339B;
        Wed, 12 Apr 2023 09:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681293606;
        bh=OUD03e+7Iy4QMxz3xJBYzLJlFWfJDEAkzkfLMPair6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=crNVkqcxHCCYL80wSlDenZejktN87UpM/8LK4etPla1ppaaBuuLGirFySD+9BC8KA
         rok+vJxk0HE5dOvhmCScfvmfwOePw1RpVNIHWcNtjR8/OdKMSLM8epGate+sVgwibT
         5g+HJMDJAqTuD4tNXDMa0mdfzwpVYJP21+59Ok0BLQ7p83MVc5+U2FahQ/OrlB3E0c
         3+nXL8j94+wzyND696UMlIfan6ehWljHDgvm/lA3rvxTNr5GvpkPZqTGm9cngV+VsN
         CJD1pJXthpF+iTotF1i6mXyGtz8SKPgaEU1iVG4BxB/UHaVj28tiyTa6p0gZEsOF59
         p48RQwfvtj8oA==
Date:   Wed, 12 Apr 2023 11:59:52 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, qemu-devel@nongnu.org, aarcange@redhat.com,
        ak@linux.intel.com, akpm@linux-foundation.org, arnd@arndb.de,
        bfields@fieldses.org, bp@alien8.de, chao.p.peng@linux.intel.com,
        corbet@lwn.net, dave.hansen@intel.com, david@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com, hpa@zytor.com,
        hughd@google.com, jlayton@kernel.org, jmattson@google.com,
        joro@8bytes.org, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, linmiaohe@huawei.com,
        luto@kernel.org, mail@maciej.szmigiero.name, mhocko@suse.com,
        michael.roth@amd.com, mingo@redhat.com, naoya.horiguchi@nec.com,
        pbonzini@redhat.com, qperret@google.com, rppt@kernel.org,
        seanjc@google.com, shuah@kernel.org, steven.price@arm.com,
        tabba@google.com, tglx@linutronix.de, vannapurve@google.com,
        vbabka@suse.cz, vkuznets@redhat.com, wanpengli@tencent.com,
        wei.w.wang@intel.com, x86@kernel.org, yu.c.zhang@linux.intel.com
Subject: Re: [RFC PATCH v3 1/2] mm: restrictedmem: Allow userspace to specify
 mount for memfd_restricted
Message-ID: <20230412-kurzweilig-unsummen-3c1136f7f437@brauner>
References: <20230404-engraved-rumble-d871e0403f3b@brauner>
 <diqzlej60z57.fsf@ackerleytng-cloudtop.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <diqzlej60z57.fsf@ackerleytng-cloudtop.c.googlers.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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

I'm curious, is there an LSFMM session for this?
