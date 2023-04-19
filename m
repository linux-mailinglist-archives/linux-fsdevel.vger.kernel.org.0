Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5486E752F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 10:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjDSIav (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 04:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjDSIau (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:30:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FF012582;
        Wed, 19 Apr 2023 01:30:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23DFD63C81;
        Wed, 19 Apr 2023 08:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91AF2C433EF;
        Wed, 19 Apr 2023 08:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681893013;
        bh=jcrD/MAqpsfteSxcrKJQtY6pksCSFUz4k6hypV9cW7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GUlfmzAac1xNbniOW+9sTcn+D51raTUKPS47ZwRVE0bQSvC6ZMhwZyI4seWoAszOs
         dI8qjMwileJSg0S3nHgT7At7aZ2exrs23CjAt26gaSKvr6lK+7UyJ4DYH+cTStdCdv
         l+LJ2u8v//8RTDDiirAHC7MRuX7HNTijYtoxdRQ1UGU1utqpVcDw5PIHxqsDdqHIlC
         zFoDv1hARCjt0NHV+1a8aPm1ch7VvJq+rJfqvWmW5BYgK3OGJpuE++V+o3oeQemMcx
         dTkykrgRGHk1v8rIbaO0egj/zk3jR9uCB8kTaYySO+xQzHlO+iyVziqx7juWEimRjL
         9Jrf+qrir6/Ag==
Date:   Wed, 19 Apr 2023 10:29:59 +0200
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
Message-ID: <20230418-anfallen-irdisch-6993a61be10b@brauner>
References: <20220818132421.6xmjqduempmxnnu2@box>
 <diqzlej60z57.fsf@ackerleytng-cloudtop.c.googlers.com>
 <20221202061347.1070246-2-chao.p.peng@linux.intel.com>
 <20230413-anlegen-ergibt-cbefffe0b3de@brauner>
 <ZDiCG/7OgDI0SwMR@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZDiCG/7OgDI0SwMR@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 13, 2023 at 03:28:43PM -0700, Sean Christopherson wrote:
> On Thu, Apr 13, 2023, Christian Brauner wrote:
> > On Thu, Aug 18, 2022 at 04:24:21PM +0300, Kirill A . Shutemov wrote:
> > > On Wed, Aug 17, 2022 at 10:40:12PM -0700, Hugh Dickins wrote:
> > > > Here's what I would prefer, and imagine much easier for you to maintain;
> > > > but I'm no system designer, and may be misunderstanding throughout.
> > > > 
> > > > QEMU gets fd from opening /dev/kvm_something, uses ioctls (or perhaps
> > > > the fallocate syscall interface itself) to allocate and free the memory,
> > > > ioctl for initializing some of it too.  KVM in control of whether that
> > > > fd can be read or written or mmap'ed or whatever, no need to prevent it
> > > > in shmem.c, no need for flags, seals, notifications to and fro because
> > > > KVM is already in control and knows the history.  If shmem actually has
> > > > value, call into it underneath - somewhat like SysV SHM, and /dev/zero
> > > > mmap, and i915/gem make use of it underneath.  If shmem has nothing to
> > > > add, just allocate and free kernel memory directly, recorded in your
> > > > own xarray.
> > > 
> > > I guess shim layer on top of shmem *can* work. I don't see immediately why
> > > it would not. But I'm not sure it is right direction. We risk creating yet
> > > another parallel VM with own rules/locking/accounting that opaque to
> > > core-mm.
> > 
> > Sorry for necrobumping this thread but I've been reviewing the
> 
> No worries, I'm just stoked someone who actually knows what they're doing is
> chiming in :-)

It's a dangerous business, going out of your subsystem. You step into
code, and if you don't watch your hands, there is no knowing where you
might be swept off to.

That saying goes for me here specifically...

> 
> > memfd_restricted() extension that Ackerley is currently working on. I
> > was pointed to this thread as this is what the extension is building
> > on but I'll reply to both threads here.
> > 
> > From a glance at v10, memfd_restricted() is currently implemented as an
> > in-kernel stacking filesystem. A call to memfd_restricted() creates a
> > new restricted memfd file and a new unlinked tmpfs file and stashes the
> > tmpfs file into the memfd file's private data member. It then uses the
> > tmpfs file's f_ops and i_ops to perform the relevant file and inode
> > operations. So it has the same callstack as a general stacking
> > filesystem like overlayfs in some cases:
> > 
> >         memfd_restricted->getattr()
> >         -> tmpfs->getattr()
> 
> ...
> 
> > Since you're effectively acting like a stacking filesystem you should
> > really use the device number of your memfd restricted filesystem. IOW,
> > sm like:
> > 
> >         stat->dev = memfd_restricted_dentry->d_sb->s_dev;
> > 
> > But then you run into trouble if you want to go forward with Ackerley's
> > extension that allows to explicitly pass in tmpfs fds to
> > memfd_restricted(). Afaict, two tmpfs instances might allocate the same
> > inode number. So now the inode and device number pair isn't unique
> > anymore.
> > 
> > So you might best be served by allocating and reporting your own inode
> > numbers as well.
> > 
> > But if you want to preserve the inode number and device number of the
> > relevant tmpfs instance but still report memfd restricted as your
> > filesystem type
> 
> Unless I missed something along the way, reporting memfd_restricted as a distinct
> filesystem is very much a non-goal.  AFAIK it's purely a side effect of the
> proposed implementation.

In the current implementation you would have to put in effort to fake
this. For example, you would need to also implement ->statfs
super_operation where you'd need to fill in the details of the tmpfs
instance. At that point all that memfd_restricted fs code that you've
written is nothing but deadweight, I would reckon.

> 
> > then I think it's reasonable to ask whether a stacking implementation really
> > makes sense here.
> > 
> > If you extend memfd_restricted() or even consider extending it in the
> > future to take tmpfs file descriptors as arguments to identify the tmpfs
> > instance in which to allocate the underlying tmpfs file for the new
> > restricted memfd file you should really consider a tmpfs based
> > implementation.
> > 
> > Because at that point it just feels like a pointless wrapper to get
> > custom f_ops and i_ops. Plus it's wasteful because you allocate dentries
> > and inodes that you don't really care about at all.
> > 
> > Just off the top of my hat you might be better served:
> > * by a new ioctl() on tmpfs instances that
> >   yield regular tmpfs file descriptors with restricted f_ops and i_ops.
> >   That's not that different from btrfs subvolumes which effectively are
> >   directories but are created through an ioctl().
> 
> I think this is more or less what we want to do, except via a dedicated syscall
> instead of an ioctl() so that the primary interface isn't strictly tied to tmpfs,
> e.g. so that it can be extended to other backing types in the future.

Ok. But just to point this out, this would make memfd_restricted()
a multiplexer on types of memory. And my wild guess is that not all
memory types you might reasonably want to use will have a filesystem
like interface such. So in the future you might end up with multiple
ways of specifying the type of memory:

// use tmpfs backing
memfd_restricted(fd_tmpfs, 0);

// use hugetlbfs backing
memfd_restricted(fd_hugetlbfs, 0);

// use non-fs type memory backing
memfd_restricted(-EBADF, MEMFD_SUPER_FANCY_MEMORY_TYPE);

interface wise I find an unpleasant design. But that multi-memory-open
goal also makes it a bit hard to come up with a clean design (On
possibility would be to use an extensible struct - versioned by size -
similar to openat2() and clone3() such that you can specify all types of
options on the memory in the future.).

> 
> > * by a mount option to tmpfs that makes it act
> >   in this restricted manner then you don't need an ioctl() and can get
> >   away with regular open calls. Such a tmpfs instance would only create
> >   regular, restricted memfds.
> 
> I'd prefer to not go this route, becuase IIUC, it would require relatively invasive
> changes to shmem code, and IIUC would require similar changes to other support
> backings in the future, e.g. hugetlbfs?  And as above, I don't think any of the
> potential use cases need restrictedmem to be a uniquely identifiable mount.

Ok, see my comment above then.

> 
> One of the goals (hopefully not a pipe dream) is to design restrictmem in such a
> way that extending it to support other backing types isn't terribly difficult.

Not necessarily difficult, just difficult to do tastefully imho. But
it's not that has traditionally held people back. ;)

> In case it's not obvious, most of us working on this stuff aren't filesystems
> experts, and many of us aren't mm experts either.  The more we (KVM folks for the
> most part) can leverage existing code to do the heavy lifting, the better.

Well, hopefully we can complement each other's knowledge here.

> 
> After giving myself a bit of a crash course in file systems, would something like
> the below have any chance of (a) working, (b) getting merged, and (c) being
> maintainable?
> 
> The idea is similar to a stacking filesystem, but instead of stacking, restrictedmem
> hijacks a f_ops and a_ops to create a lightweight shim around tmpfs.  There are
> undoubtedly issues and edge cases, I'm just looking for a quick "yes, this might
> be doable" or a "no, that's absolutely bonkers, don't try it".

Maybe, but I think it's weird. _Replacing_ f_ops isn't something that's
unprecedented. It happens everytime a character device is opened (see
fs/char_dev.c:chrdev_open()). And debugfs does a similar (much more
involved) thing where it replaces it's proxy f_ops with the relevant
subsystem's f_ops. The difference is that in both cases the replace
happens at ->open() time; and the replace is done once. Afterwards only
the newly added f_ops are relevant.

In your case you'd be keeping two sets of {f,a}_ops; one usable by
userspace and another only usable by in-kernel consumers. And there are
some concerns (non-exhaustive list), I think:

* {f,a}_ops weren't designed for this. IOW, one set of {f,a}_ops is
  authoritative per @file and it is left to the individual subsystems to
  maintain driver specific ops (see the sunrpc stuff or sockets).
* lifetime management for the two sets of {f,a}_ops: If the ops belong
  to a module then you need to make sure that the module can't get
  unloaded while you're using the fops. Might not be a concern in this
  case.
* brittleness: Not all f_ops for example deal with userspace
  functionality some deal with cleanup when the file is closed like
  ->release(). So it's delicate to override that functionality with
  custom f_ops. Restricted memfds could easily forget to cleanup
  resources.
* Potential for confusion why there's two sets of {f,a}_ops.
* f_ops specifically are generic across a vast amount of consumers and
  are subject to change. If memfd_restricted() has specific requirements
  because of this weird double-use they won't be taken into account.

I find this hard to navigate tbh and it feels like taking a shortcut to
avoid building a proper api. If you only care about a specific set of
operations specific to memfd restricte that needs to be available to
in-kernel consumers, I wonder if you shouldn't just go one step further
then your proposal below and build a dedicated minimal ops api. Idk,
sketching like a madman on a drawning board here with no claim to
feasibility from a mm perspective whatsoever:

struct restrictedmem_ops {
	// only contains very limited stuff you need or special stuff
	// you nee, similar to struct proto_ops (sockets) and so on
};

struct restrictedmem {
	const struct restrictedmem_ops ops;
};

This would avoid fuzzing with two different set of {f,a}_ops in this
brittle way. It would force you to clarify the semantics that you need
and the operations that you need or don't need implemented. And it would
get rid of the ambiguity inherent to using two sets of {f,a}_ops.
