Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FE26E8CE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 10:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbjDTIfq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 04:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbjDTIfp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:35:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCBB3C31;
        Thu, 20 Apr 2023 01:35:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 683A460EFE;
        Thu, 20 Apr 2023 08:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96937C433EF;
        Thu, 20 Apr 2023 08:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681979742;
        bh=Y4j7IF7cCoXO6FT5Vh2T3yfPGAaX4YyQhrHeBzavQfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gxWPeaPaDMkESOpb8oRfhVEN1mZzLuWTOBMIoSqOoPuoagxBkqU4sviyrWfny1L+U
         5Sn6+T8C1LjvrxnSyyxDRBBLKTuVUwCIhD/fgeSY5dicJjwgeyTTmrZT9yNfQBpd8c
         VJ7LttX9T7jmDRT87FMwSH0XsghxAD/ECAjK71s7s3W+Mo/jUEs4zSpvqB9NgyJu9R
         tQCVsEBKUEUNWbVU1labculVhGIAjhoo7rvBVhQkKq0qAk85pw6czrgsmBOfjvi8fD
         2O5uLgG4LwMD5JoNCYXWQojRmv9SIsLgC41ldSkgo2NMEaQcBB5UCOeZ54fRCko9Sf
         K6/TUvU9G7JXQ==
Date:   Thu, 20 Apr 2023 10:35:28 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Hugh Dickins <hughd@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Pankaj Gupta <pankaj.gupta@amd.com>,
        linux-arch@vger.kernel.org, arnd@arndb.de, linmiaohe@huawei.com,
        naoya.horiguchi@nec.com, tabba@google.com, wei.w.wang@intel.com
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <20230420-lahmlegen-schule-586f6c19cf8f@brauner>
References: <20220818132421.6xmjqduempmxnnu2@box>
 <diqzlej60z57.fsf@ackerleytng-cloudtop.c.googlers.com>
 <20221202061347.1070246-2-chao.p.peng@linux.intel.com>
 <20230413-anlegen-ergibt-cbefffe0b3de@brauner>
 <ZDiCG/7OgDI0SwMR@google.com>
 <20230418-anfallen-irdisch-6993a61be10b@brauner>
 <ZECMM9bjgGRdyXRy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZECMM9bjgGRdyXRy@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 19, 2023 at 05:49:55PM -0700, Sean Christopherson wrote:
> On Wed, Apr 19, 2023, Christian Brauner wrote:
> > On Thu, Apr 13, 2023 at 03:28:43PM -0700, Sean Christopherson wrote:
> > > > But if you want to preserve the inode number and device number of the
> > > > relevant tmpfs instance but still report memfd restricted as your
> > > > filesystem type
> > > 
> > > Unless I missed something along the way, reporting memfd_restricted as a distinct
> > > filesystem is very much a non-goal.  AFAIK it's purely a side effect of the
> > > proposed implementation.
> > 
> > In the current implementation you would have to put in effort to fake
> > this. For example, you would need to also implement ->statfs
> > super_operation where you'd need to fill in the details of the tmpfs
> > instance. At that point all that memfd_restricted fs code that you've
> > written is nothing but deadweight, I would reckon.
> 
> After digging a bit, I suspect the main reason Kirill implemented an overlay to
> inode_operations was to prevent modifying the file size via ->setattr().  Relying
> on shmem_setattr() to unmap entries in KVM's MMU wouldn't work because, by design,
> the memory can't be mmap()'d into host userspace. 
> 
> 	if (attr->ia_valid & ATTR_SIZE) {
> 		if (memfd->f_inode->i_size)
> 			return -EPERM;
> 
> 		if (!PAGE_ALIGNED(attr->ia_size))
> 			return -EINVAL;	
> 	}
> 
> But I think we can solve this particular problem by using F_SEAL_{GROW,SHRINK} or
> SHMEM_LONGPIN.  For a variety of reasons, I'm leaning more and more toward making
> this a KVM ioctl() instead of a dedicated syscall, at which point we can be both
> more flexible and more draconian, e.g. let userspace provide the file size at the
> time of creation, but make the size immutable, at least by default.
> 
> > > After giving myself a bit of a crash course in file systems, would something like
> > > the below have any chance of (a) working, (b) getting merged, and (c) being
> > > maintainable?
> > > 
> > > The idea is similar to a stacking filesystem, but instead of stacking, restrictedmem
> > > hijacks a f_ops and a_ops to create a lightweight shim around tmpfs.  There are
> > > undoubtedly issues and edge cases, I'm just looking for a quick "yes, this might
> > > be doable" or a "no, that's absolutely bonkers, don't try it".
> > 
> > Maybe, but I think it's weird.
> 
> Yeah, agreed.
> 
> > _Replacing_ f_ops isn't something that's unprecedented. It happens everytime
> > a character device is opened (see fs/char_dev.c:chrdev_open()). And debugfs
> > does a similar (much more involved) thing where it replaces it's proxy f_ops
> > with the relevant subsystem's f_ops. The difference is that in both cases the
> > replace happens at ->open() time; and the replace is done once. Afterwards
> > only the newly added f_ops are relevant.
> > 
> > In your case you'd be keeping two sets of {f,a}_ops; one usable by
> > userspace and another only usable by in-kernel consumers. And there are
> > some concerns (non-exhaustive list), I think:
> > 
> > * {f,a}_ops weren't designed for this. IOW, one set of {f,a}_ops is
> >   authoritative per @file and it is left to the individual subsystems to
> >   maintain driver specific ops (see the sunrpc stuff or sockets).
> > * lifetime management for the two sets of {f,a}_ops: If the ops belong
> >   to a module then you need to make sure that the module can't get
> >   unloaded while you're using the fops. Might not be a concern in this
> >   case.
> 
> Ah, whereas I assume the owner of inode_operations is pinned by ??? (dentry?)
> holding a reference to the inode?

I don't think it would be possible to safely replace inode_operations
after the inode's been made visible in caches.

It works with file_operations because when a file is opened a new struct
file is allocated which isn't reachable anywhere before fd_install() is
called. So it is possible to replace f_ops in the default
f->f_op->open() method (which is what devices do as the inode is located
on e.g., ext4/xfs/tmpfs but the functionality of the device usually
provided by some driver/module through its file_operations). The default
f_ops are taken from i_fop of the inode.

The lifetime of the file_/inode_operations will be aligned with the
lifetime of the module they're originating from. If only
file_/inode_operations are used from within the same module then there
should never be any lifetime concerns.

So an inode doesn't explictly pin file_/inode_operations because there's
usually no need to do that and it be weird if each new inode would take
a reference on the f_ops/i_ops on the off-chance that someone _might_
open the file. Let alone the overhead of calling try_module_get()
everytime a new inode is added to the cache. There are various fs
objects - the superblock which is pinning the filesystem/module - that
exceed the lifetime of inodes and dentries. Both also may be dropped
from their respective caches and readded later.

Pinning of the module for f_ops is done because it is possible that some
filesystem/driver might want to use the file_operations of some other
filesystem/driver by default and they are in separate modules. So the
fops_get() in do_dentry_open is there because it's not guaranteed that
file_/inode_operations originate from the same module as the inode
that's opened. If the module is still alive during the open then a
reference to its f_ops is taken if not then the open will fail with
ENODEV.

That's to the best of my knowledge.

> 
> > * brittleness: Not all f_ops for example deal with userspace
> >   functionality some deal with cleanup when the file is closed like
> >   ->release(). So it's delicate to override that functionality with
> >   custom f_ops. Restricted memfds could easily forget to cleanup
> >   resources.
> > * Potential for confusion why there's two sets of {f,a}_ops.
> > * f_ops specifically are generic across a vast amount of consumers and
> >   are subject to change. If memfd_restricted() has specific requirements
> >   because of this weird double-use they won't be taken into account.
> > 
> > I find this hard to navigate tbh and it feels like taking a shortcut to
> > avoid building a proper api.
> 
> Agreed.  At the very least, it would be better to take an explicit dependency on
> whatever APIs are being used instead of somewhat blindly bouncing through ->fallocate().
> I think that gives us a clearer path to getting something merged too, as we'll
> need Acks on making specific functions visible, i.e. will give MM maintainers
> something concrete to react too.
> 
> > If you only care about a specific set of operations specific to memfd
> > restricte that needs to be available to in-kernel consumers, I wonder if you
> > shouldn't just go one step further then your proposal below and build a
> > dedicated minimal ops api.
> 
> This is actually very doable for shmem.  Unless I'm missing something, because
> our use case doesn't allow mmap(), swap, or migration, a good chunk of
> shmem_fallocate() is simply irrelevant.  The result is only ~100 lines of code,
> and quite straightforward.
> 
> My biggest concern, outside of missing a detail in shmem, is adding support for
> HugeTLBFS, which is likely going to be requested/needed sooner than later.  At a
> glance, hugetlbfs_fallocate() is quite a bit more complex, i.e. not something I'm
> keen to duplicate.  But that's also a future problem to some extent, as it's
> purely kernel internals; the uAPI side of things doesn't seem like it'll be messy
> at all.
> 
> Thanks again!

Sure thing.
