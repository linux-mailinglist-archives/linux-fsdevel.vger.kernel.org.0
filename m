Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC84B356DF5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 15:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347948AbhDGN5o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 09:57:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344205AbhDGN5o (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:57:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4138C6128D;
        Wed,  7 Apr 2021 13:57:32 +0000 (UTC)
Date:   Wed, 7 Apr 2021 15:57:29 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Bharata B Rao <bharata@linux.ibm.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, aneesh.kumar@linux.ibm.com
Subject: Re: High kmalloc-32 slab cache consumption with 10k containers
Message-ID: <20210407135729.qgbj6shvmfuzo7r7@wittgenstein>
References: <20210405054848.GA1077931@in.ibm.com>
 <20210406222807.GD1990290@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210406222807.GD1990290@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 07, 2021 at 08:28:07AM +1000, Dave Chinner wrote:
> On Mon, Apr 05, 2021 at 11:18:48AM +0530, Bharata B Rao wrote:
> > Hi,
> > 
> > When running 10000 (more-or-less-empty-)containers on a bare-metal Power9
> > server(160 CPUs, 2 NUMA nodes, 256G memory), it is seen that memory
> > consumption increases quite a lot (around 172G) when the containers are
> > running. Most of it comes from slab (149G) and within slab, the majority of
> > it comes from kmalloc-32 cache (102G)
> > 
> > The major allocator of kmalloc-32 slab cache happens to be the list_head
> > allocations of list_lru_one list. These lists are created whenever a
> > FS mount happens. Specially two such lists are registered by alloc_super(),
> > one for dentry and another for inode shrinker list. And these lists
> > are created for all possible NUMA nodes and for all given memcgs
> > (memcg_nr_cache_ids to be particular)
> > 
> > If,
> > 
> > A = Nr allocation request per mount: 2 (one for dentry and inode list)
> > B = Nr NUMA possible nodes
> > C = memcg_nr_cache_ids
> > D = size of each kmalloc-32 object: 32 bytes,
> > 
> > then for every mount, the amount of memory consumed by kmalloc-32 slab
> > cache for list_lru creation is A*B*C*D bytes.
> > 
> > Following factors contribute to the excessive allocations:
> > 
> > - Lists are created for possible NUMA nodes.
> > - memcg_nr_cache_ids grows in bulk (see memcg_alloc_cache_id() and additional
> >   list_lrus are created when it grows. Thus we end up creating list_lru_one
> >   list_heads even for those memcgs which are yet to be created.
> >   For example, when 10000 memcgs are created, memcg_nr_cache_ids reach
> >   a value of 12286.
> 
> So, by your numbers, we have 2 * 2 * 12286 * 32 = 1.5MB per mount.
> 
> So for that to make up 100GB of RAM, you must have somewhere over
> 500,000 mounted superblocks on the machine?
> 
> That implies 50+ unique mounted superblocks per container, which
> seems like an awful lot.
> 
> > - When a memcg goes offline, the list elements are drained to the parent
> >   memcg, but the list_head entry remains.
> > - The lists are destroyed only when the FS is unmounted. So list_heads
> >   for non-existing memcgs remain and continue to contribute to the
> >   kmalloc-32 allocation. This is presumably done for performance
> >   reason as they get reused when new memcgs are created, but they end up
> >   consuming slab memory until then.
> > - In case of containers, a few file systems get mounted and are specific
> >   to the container namespace and hence to a particular memcg, but we
> >   end up creating lists for all the memcgs.
> >   As an example, if 7 FS mounts are done for every container and when
> >   10k containers are created, we end up creating 2*7*12286 list_lru_one
> >   lists for each NUMA node. It appears that no elements will get added
> >   to other than 2*7=14 of them in the case of containers.
> 
> Yeah, at first glance this doesn't strike me as a problem with the
> list_lru structure, it smells more like a problem resulting from a
> huge number of superblock instantiations on the machine. Which,
> probably, mostly have no significant need for anything other than a
> single memcg awareness?
> 
> Can you post a typical /proc/self/mounts output from one of these
> idle/empty containers so we can see exactly how many mounts and
> their type are being instantiated in each container?

Similar to Michal I wonder how much of that is really used in production
environments. From our experience it really depends on the type of
container we're talking about.
For a regular app container that essentially serves as an application
isolator the number of mounts could be fairly limited and essentially be
restricted to:

tmpfs
devptfs
sysfs
[cgroupfs]
and a few bind-mounts of standard devices such as
/dev/null
/dev/zero
/dev/full
.
.
.
from the host's devtmpfs into the container.

Then there are containers that behave like regular systems and are
managed like regular systems and those might have quite a bit more. For
example, here is the output of a regular unprivileged Fedora 33
container I created out of the box:

[root@f33 ~]# findmnt 
TARGET                                SOURCE                                                                       FSTYPE      OPTIONS
/                                     /dev/mapper/ubuntu--vg-ubuntu--lv[/var/lib/lxd/storage-pools/default/containers/f33/rootfs]
│                                                                                                                  xfs         rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota
├─/run                                tmpfs                                                                        tmpfs       rw,nosuid,nodev,size=3226884k,nr_inodes=819200,mode=755,uid=100000,gid=100000
│ └─/run/user/0                       tmpfs                                                                        tmpfs       rw,nosuid,nodev,relatime,size=1613440k,nr_inodes=403360,mode=700,uid=100000,gid=100000
├─/tmp                                tmpfs                                                                        tmpfs       rw,nosuid,nodev,nr_inodes=409600,uid=100000,gid=100000
├─/dev                                none                                                                         tmpfs       rw,relatime,size=492k,mode=755,uid=100000,gid=100000
│ ├─/dev/shm                          tmpfs                                                                        tmpfs       rw,nosuid,nodev,uid=100000,gid=100000
│ ├─/dev/fuse                         udev[/fuse]                                                                  devtmpfs    rw,nosuid,noexec,relatime,size=8019708k,nr_inodes=2004927,mode=755
│ ├─/dev/net/tun                      udev[/net/tun]                                                               devtmpfs    rw,nosuid,noexec,relatime,size=8019708k,nr_inodes=2004927,mode=755
│ ├─/dev/mqueue                       mqueue                                                                       mqueue      rw,nosuid,nodev,noexec,relatime
│ ├─/dev/lxd                          tmpfs                                                                        tmpfs       rw,relatime,size=100k,mode=755
│ ├─/dev/.lxd-mounts                  tmpfs[/f33]                                                                  tmpfs       rw,relatime,size=100k,mode=711
│ ├─/dev/full                         udev[/full]                                                                  devtmpfs    rw,nosuid,noexec,relatime,size=8019708k,nr_inodes=2004927,mode=755
│ ├─/dev/null                         udev[/null]                                                                  devtmpfs    rw,nosuid,noexec,relatime,size=8019708k,nr_inodes=2004927,mode=755
│ ├─/dev/random                       udev[/random]                                                                devtmpfs    rw,nosuid,noexec,relatime,size=8019708k,nr_inodes=2004927,mode=755
│ ├─/dev/tty                          udev[/tty]                                                                   devtmpfs    rw,nosuid,noexec,relatime,size=8019708k,nr_inodes=2004927,mode=755
│ ├─/dev/urandom                      udev[/urandom]                                                               devtmpfs    rw,nosuid,noexec,relatime,size=8019708k,nr_inodes=2004927,mode=755
│ ├─/dev/zero                         udev[/zero]                                                                  devtmpfs    rw,nosuid,noexec,relatime,size=8019708k,nr_inodes=2004927,mode=755
│ ├─/dev/console                      devpts[/40]                                                                  devpts      rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000
│ ├─/dev/pts                          devpts                                                                       devpts      rw,nosuid,noexec,relatime,gid=100005,mode=620,ptmxmode=666,max=1024
│ └─/dev/ptmx                         devpts[/ptmx]                                                                devpts      rw,nosuid,noexec,relatime,gid=100005,mode=620,ptmxmode=666,max=1024
├─/proc                               proc                                                                         proc        rw,nosuid,nodev,noexec,relatime
│ ├─/proc/sys/fs/binfmt_misc          binfmt_misc                                                                  binfmt_misc rw,nosuid,nodev,noexec,relatime
│ └─/proc/sys/kernel/random/boot_id   none[/.lxc-boot-id]                                                          tmpfs       ro,nosuid,nodev,noexec,relatime,size=492k,mode=755,uid=100000,gid=100000
└─/sys                                sysfs                                                                        sysfs       rw,relatime
  ├─/sys/fs/cgroup                    tmpfs                                                                        tmpfs       ro,nosuid,nodev,noexec,size=4096k,nr_inodes=1024,mode=755,uid=100000,gid=100000
  │ ├─/sys/fs/cgroup/unified          cgroup2                                                                      cgroup2     rw,nosuid,nodev,noexec,relatime
  │ ├─/sys/fs/cgroup/systemd          cgroup                                                                       cgroup      rw,nosuid,nodev,noexec,relatime,xattr,name=systemd
  │ ├─/sys/fs/cgroup/net_cls,net_prio cgroup                                                                       cgroup      rw,nosuid,nodev,noexec,relatime,net_cls,net_prio
  │ ├─/sys/fs/cgroup/hugetlb          cgroup                                                                       cgroup      rw,nosuid,nodev,noexec,relatime,hugetlb
  │ ├─/sys/fs/cgroup/cpu,cpuacct      cgroup                                                                       cgroup      rw,nosuid,nodev,noexec,relatime,cpu,cpuacct
  │ ├─/sys/fs/cgroup/blkio            cgroup                                                                       cgroup      rw,nosuid,nodev,noexec,relatime,blkio
  │ ├─/sys/fs/cgroup/cpuset           cgroup                                                                       cgroup      rw,nosuid,nodev,noexec,relatime,cpuset,clone_children
  │ ├─/sys/fs/cgroup/memory           cgroup                                                                       cgroup      rw,nosuid,nodev,noexec,relatime,memory
  │ ├─/sys/fs/cgroup/devices          cgroup                                                                       cgroup      rw,nosuid,nodev,noexec,relatime,devices
  │ ├─/sys/fs/cgroup/perf_event       cgroup                                                                       cgroup      rw,nosuid,nodev,noexec,relatime,perf_event
  │ ├─/sys/fs/cgroup/freezer          cgroup                                                                       cgroup      rw,nosuid,nodev,noexec,relatime,freezer
  │ ├─/sys/fs/cgroup/pids             cgroup                                                                       cgroup      rw,nosuid,nodev,noexec,relatime,pids
  │ └─/sys/fs/cgroup/rdma             cgroup                                                                       cgroup      rw,nosuid,nodev,noexec,relatime,rdma
  ├─/sys/firmware/efi/efivars         efivarfs                                                                     efivarfs    rw,nosuid,nodev,noexec,relatime
  ├─/sys/fs/fuse/connections          fusectl                                                                      fusectl     rw,nosuid,nodev,noexec,relatime
  ├─/sys/fs/pstore                    pstore                                                                       pstore      rw,nosuid,nodev,noexec,relatime
  ├─/sys/kernel/config                configfs                                                                     configfs    rw,nosuid,nodev,noexec,relatime
  ├─/sys/kernel/debug                 debugfs                                                                      debugfs     rw,nosuid,nodev,noexec,relatime
  ├─/sys/kernel/security              securityfs                                                                   securityfs  rw,nosuid,nodev,noexec,relatime
  ├─/sys/kernel/tracing               tracefs                                                                      tracefs     rw,nosuid,nodev,noexec,relatime

People that use those tend to also run systemd services in there and
newer systemd has a range of service isolation features that may also
create quite a few mounts. Those will again mostly be pseudo filesystems
(A service might have private proc, tmp etc.) and bind-mounts. The
number of actual separate superblocks for "real" filesystem such as xfs,
ext4 per container is usually quite low. (For one, most of them can't
even be mounted in a user namespace.). From experience it's rare to see
workloads that exceed 500 containers (of this type at least) on a single
machine. At least on x86_64 we have not yet had issues with memory
consumption.

We do run stress tests with thousands of such system containers. They
tend to boot busybox, not e.g. Fedora or Debian or Ubuntu and that
hasn't pushed us over the edge yet.

> 
> > One straight forward way to prevent this excessive list_lru_one
> > allocations is to limit the list_lru_one creation only to the
> > relevant memcg. However I don't see an easy way to figure out
> > that relevant memcg from FS mount path (alloc_super())
> 
> Superblocks have to support an unknown number of memcgs after they
> have been mounted. bind mounts, child memcgs, etc, all mean that we
> can't just have a static, single mount time memcg instantiation.
> 
> > As an alternative approach, I have this below hack that does lazy
> > list_lru creation. The memcg-specific list is created and initialized
> > only when there is a request to add an element to that particular
> > list. Though I am not sure about the full impact of this change
> > on the owners of the lists and also the performance impact of this,
> > the overall savings look good.
> 
> Avoiding memory allocation in list_lru_add() was one of the main
> reasons for up-front static allocation of memcg lists. We cannot do
> memory allocation while callers are holding multiple spinlocks in
> core system algorithms (e.g. dentry_kill -> retain_dentry ->
> d_lru_add -> list_lru_add), let alone while holding an internal
> spinlock.
> 
> Putting a GFP_ATOMIC allocation inside 3-4 nested spinlocks in a
> path we know might have memory demand in the *hundreds of GB* range
> gets an NACK from me. It's a great idea, but it's just not a
> feasible, robust solution as proposed. Work out how to put the
> memory allocation outside all the locks (including caller locks) and
> it might be ok, but that's messy.
> 
> Another approach may be to identify filesystem types that do not
> need memcg awareness and feed that into alloc_super() to set/clear
> the SHRINKER_MEMCG_AWARE flag. This could be based on fstype - most
> virtual filesystems that expose system information do not really

I think that might already help quite a bit as those tend to make up
most of the mounts and even unprivileged containers can create new
instances of such mounts and will do so when they e.g. run systemd and
thus also systemd services.

Christian
