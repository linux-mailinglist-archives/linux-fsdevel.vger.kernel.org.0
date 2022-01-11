Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBAE48BB36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 00:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245141AbiAKXHs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 18:07:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37559 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245135AbiAKXHr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 18:07:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641942466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5z7Q3iUl9CUmYgLxEN1r7b6L+2Lg2woRef2MzxZscbo=;
        b=SgNmVpTuXet2EViJu8/0gCElRKJ6OiRMhUH43k7TSsHvLMM9IgzqgYbwLXvbNa7S5j3qxg
        79q0JoEYmpga3hoVVcoetg9vDynDDjUuZFNcG5SSKsKWX/H70Bke8fs5aHJ6D5ykpzZZPY
        NwvOfkH5Eewk9iWN5e3bD+97ggUCiO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-fk6zNdWaNje346g0zKmiFA-1; Tue, 11 Jan 2022 18:07:43 -0500
X-MC-Unique: fk6zNdWaNje346g0zKmiFA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0915E8042E1;
        Tue, 11 Jan 2022 23:07:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D46021042A90;
        Tue, 11 Jan 2022 23:07:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Daire Byrne <daire@dneg.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Marc Dionne <marc.dionne@auristor.com>,
        Matthew Wilcox <willy@infradead.org>,
        Omar Sandoval <osandov@osandov.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Steve French <sfrench@samba.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cachefs@redhat.com, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] fscache, cachefiles: Rewrite
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <510610.1641942444.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 11 Jan 2022 23:07:24 +0000
Message-ID: <510611.1641942444@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Could you pull this please?  It's a set of patches that rewrites the
fscache driver and the cachefiles driver, significantly simplifying the
code compared to what's upstream, removing the complex operation schedulin=
g
and object state machine in favour of something much smaller and simpler.

The patchset is structured such that the first few patches disable fscache
use by the network filesystems using it, remove the cachefiles driver
entirely and as much of the fscache driver as can be got away with without
causing build failures in the network filesystems.  The patches after that
recreate fscache and then cachefiles, attempting to add the pieces in a
logical order.  Finally, the filesystems are reenabled and then the very
last patch changes the documentation.

[!] Note: I have dropped the cifs patch for the moment, leaving local
    caching in cifs disabled.  I've been having trouble getting that
    working.  I think I have it done, but it needs more testing (there see=
m
    to be some test failures occurring with v5.16 also from xfstests), so =
I
    propose deferring that patch to the end of the merge window.

    I think also that a conflict[10] spotted by Stephen Rothwell between m=
y
    series and some changes that went in since the branching point
    shouldn't be an issue with this removed.


WHY REWRITE?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Fscache's operation scheduling API was intended to handle sequencing of
cache operations, which were all required (where possible) to run
asynchronously in parallel with the operations being done by the network
filesystem, whilst allowing the cache to be brought online and offline and
to interrupt service for invalidation.

With the advent of the tmpfile capacity in the VFS, however, an opportunit=
y
arises to do invalidation much more simply, without having to wait for I/O
that's actually in progress: Cachefiles can simply create a tmpfile, cut
over the file pointer for the backing object attached to a cookie and
abandon the in-progress I/O, dismissing it upon completion.

Future work here would involve using Omar Sandoval's vfs_link() with
AT_LINK_REPLACE[1] to allow an extant file to be displaced by a new hard
link from a tmpfile as currently I have to unlink the old file first.

These patches can also simplify the object state handling as I/O operation=
s
to the cache don't all have to be brought to a stop in order to invalidate
a file.  To that end, and with an eye on to writing a new backing cache
model in the future, I've taken the opportunity to simplify the indexing
structure.

I've separated the index cookie concept from the file cookie concept by C
type now.  The former is now called a "volume cookie" (struct
fscache_volume) and there is a container of file cookies.  There are then
just the two levels.  All the index cookie levels are collapsed into a
single volume cookie, and this has a single printable string as a key.  Fo=
r
instance, an AFS volume would have a key of something like
"afs,example.com,1000555", combining the filesystem name, cell name and
volume ID.  This is freeform, but must not have '/' chars in it.

I've also eliminated all pointers back from fscache into the network
filesystem.  This required the duplication of a little bit of data in the
cookie (cookie key, coherency data and file size), but it's not actually
that much.  This gets rid of problems with making sure we keep netfs data
structures around so that the cache can access them.

These patches mean that most of the code that was in the drivers before is
simply gone and those drivers are now almost entirely new code.  That bein=
g
the case, there doesn't seem any particular reason to try and maintain
bisectability across it.  Further, there has to be a point in the middle
where things are cut over as there's a single point everything has to go
through (ie. /dev/cachefiles) and it can't be in use by two drivers at
once.


ISSUES YET OUTSTANDING
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

There are some issues still outstanding, unaddressed by this patchset, tha=
t
will need fixing in future patchsets, but that don't stop this series from
being usable:

 (1) The cachefiles driver needs to stop using the backing filesystem's
     metadata to store information about what parts of the cache are
     populated.  This is not reliable with modern extent-based filesystems=
.

     Fixing this is deferred to a separate patchset as it involves
     negotiation with the network filesystem and the VM as to how much dat=
a
     to download to fulfil a read - which brings me on to (2)...

 (2) NFS (and CIFS with the dropped patch) do not take account of how the
     cache would like I/O to be structured to meet its granularity
     requirements.  Previously, the cache used page granularity, which was
     fine as the network filesystems also dealt in page granularity, and
     the backing filesystem (ext4, xfs or whatever) did whatever it did ou=
t
     of sight.  However, we now have folios to deal with and the cache wil=
l
     now have to store its own metadata to track its contents.

     The change I'm looking at making for cachefiles is to store content
     bitmaps in one or more xattrs and making a bit in the map correspond
     to something like a 256KiB block.  However, the size of an xattr and
     the fact that they have to be read/updated in one go means that I'm
     looking at covering 1GiB of data per 512-byte map and storing each ma=
p
     in an xattr.  Cachefiles has the potential to grow into a fully
     fledged filesystem of its very own if I'm not careful.

     However, I'm also looking at changing things even more radically and
     going to a different model of how the cache is arranged and managed -
     one that's more akin to the way, say, openafs does things - which
     brings me on to (3)...

 (3) The way cachefilesd does culling is very inefficient for large caches
     and it would be better to move it into the kernel if I can as
     cachefilesd has to keep asking the kernel if it can cull a file.
     Changing the way the backend works would allow this to be addressed.


BITS THAT MAY BE CONTROVERSIAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

There are some bits I've added that may be controversial:

 (1) I've provided a flag, S_KERNEL_FILE, that cachefiles uses to check if
     a files is already being used by some other kernel service (e.g. a
     duplicate cachefiles cache in the same directory) and reject it if it
     is.  This isn't entirely necessary, but it helps prevent accidental
     data corruption.

     I don't want to use S_SWAPFILE as that has other effects, but quite
     possibly swapon() should set S_KERNEL_FILE too.

     Note that it doesn't prevent userspace from interfering, though
     perhaps it should.  (I have made it prevent a marked directory from
     being rmdir-able).

 (2) Cachefiles wants to keep the backing file for a cookie open whilst we
     might need to write to it from network filesystem writeback.  The
     problem is that the network filesystem unuses its cookie when its fil=
e
     is closed, and so we have nothing pinning the cachefiles file open an=
d
     it will get closed automatically after a short time to avoid
     EMFILE/ENFILE problems.

     Reopening the cache file, however, is a problem if this is being done
     due to writeback triggered by exit().  Some filesystems will oops if
     we try to open a file in that context because they want to access
     current->fs or suchlike.

     To get around this, I added the following:

     (A) An inode flag, I_PINNING_FSCACHE_WB, to be set on a network
     	 filesystem inode to indicate that we have a usage count on the
     	 cookie caching that inode.

     (B) A flag in struct writeback_control, unpinned_fscache_wb, that is
     	 set when __writeback_single_inode() clears the last dirty page
     	 from i_pages - at which point it clears I_PINNING_FSCACHE_WB and
     	 sets this flag.

	 This has to be done here so that clearing I_PINNING_FSCACHE_WB can
	 be done atomically with the check of PAGECACHE_TAG_DIRTY that
	 clears I_DIRTY_PAGES.

     (C) A function, fscache_set_page_dirty(), which if it is not set, set=
s
     	 I_PINNING_FSCACHE_WB and calls fscache_use_cookie() to pin the
     	 cache resources.

     (D) A function, fscache_unpin_writeback(), to be called by
     	 ->write_inode() to unuse the cookie.

     (E) A function, fscache_clear_inode_writeback(), to be called when th=
e
     	 inode is evicted, before clear_inode() is called.  This cleans up
     	 any lingering I_PINNING_FSCACHE_WB.

     The network filesystem can then use these tools to make sure that
     fscache_write_to_cache() can write locally modified data to the cache
     as well as to the server.

     For the future, I'm working on write helpers for netfs lib that shoul=
d
     allow this facility to be removed by keeping track of the dirty
     regions separately - but that's incomplete at the moment and is also
     going to be affected by folios, one way or another, since it deals
     with pages.

Tested-by: Dominique Martinet <asmadeus@codewreck.org> # 9p
Tested-by: kafs-testing@auristor.com # afs
Tested-by: Jeff Layton <jlayton@kernel.org> # ceph
Tested-by: Dave Wysochanski <dwysocha@redhat.com> # nfs
Tested-by: Daire Byrne <daire@dneg.com> # nfs

David


Changes
=3D=3D=3D=3D=3D=3D=3D
ver #5:
 - Fixed three cookie handling bugs in cifs[9].
 - Dropped cifs support for the moment.

ver #4:
 - Dropped a pair of patches to try and cope with multipage folios in
   afs_write_begin/end() - it should really be done in the caller[7].
 - Fixed the use of sizeof with memset in cifs.
 - Removed an extraneous kdoc param.
 - Added a patch to add a tracepoint for fscache_use/unuse_cookie().
 - In cifs, tcon->vol_create_time is __le64 so doesn't need cpu_to_le64().
 - Add an expanded version of a patch to use current_is_kswapd() instead o=
f
   !gfpflags_allow_blocking()[8].
 - Removed a couple of debugging print statements.

ver #3:
 - Fixed a race in the cookie state machine between LRU discard and
   relinquishment[4].
 - Fixed up the hashing to make it portable[5].
 - Fixed up some netfs coherency data to make it portable.
 - Fixed some missing NFS_FSCACHE=3Dn fallback functions in nfs[6].
 - Added a patch to store volume coherency data in an xattr.
 - Added a check that the cookie is unhashed before being freed.
 - Fixed fscache to use remove_proc_subtree() to remove /proc/fs/fscache/.

ver #2:
 - Fix an unused-var warning due to CONFIG_9P_FSCACHE=3Dn.
 - Use gfpflags_allow_blocking() rather than using flag directly.
 - Fixed some error logging in a couple of cachefiles functions.
 - Fixed an error check in the fscache volume allocation.
 - Need to unmark an inode we've moved to the graveyard before unlocking.
 - Upgraded to -rc4 to allow for upstream changes to cifs.
 - Should only change to inval state if can get access to cache.
 - Don't hold n_accesses elevated whilst cache is bound to a cookie, but
   rather add a flag that prevents the state machine from being queued whe=
n
   n_accesses reaches 0.
 - Remove the unused cookie pointer field from the fscache_acquire
   tracepoint.
 - Added missing transition to LRU_DISCARDING state.
 - Added two ceph patches from Jeff Layton[2].
 - Remove NFS_INO_FSCACHE as it's no longer used.
 - In NFS, need to unuse a cookie on file-release, not inode-clear.
 - Filled in the NFS cache I/O routines, borrowing from the previously pos=
ted
   fallback I/O code[3].


Link: https://lore.kernel.org/r/cover.1580251857.git.osandov@fb.com/ [1]
Link: https://lore.kernel.org/r/20211207134451.66296-1-jlayton@kernel.org/=
 [2]
Link: https://lore.kernel.org/r/163189108292.2509237.12615909591150927232.=
stgit@warthog.procyon.org.uk/ [3]
Link: https://lore.kernel.org/r/599331.1639410068@warthog.procyon.org.uk/ =
[4]
Link: https://lore.kernel.org/r/CAHk-=3DwhtkzB446+hX0zdLsdcUJsJ=3D8_-0S1mE=
_R+YurThfUbLA@mail.gmail.com [5]
Link: https://lore.kernel.org/r/61b90f3d.H1IkoeQfEsGNhvq9%lkp@intel.com/ [=
6]
Link: https://lore.kernel.org/r/CAHk-=3Dwh2dr=3DNgVSVj0sw-gSuzhxhLRV5FymfP=
S146zGgF4kBjA@mail.gmail.com/ [7]
Link: https://lore.kernel.org/r/1638952658-20285-1-git-send-email-huangzha=
oyang@gmail.com/ [8]
Link: https://lore.kernel.org/r/3419813.1641592362@warthog.procyon.org.uk/=
 [9]
Link: https://lore.kernel.org/r/20211220104610.5f074aec@canb.auug.org.au/ =
[10]


References
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

These patches have been published for review before, firstly as part of a
larger set:

Link: https://lore.kernel.org/r/158861203563.340223.7585359869938129395.st=
git@warthog.procyon.org.uk/

Link: https://lore.kernel.org/r/159465766378.1376105.11619976251039287525.=
stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/159465784033.1376674.18106463693989811037.=
stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/159465821598.1377938.2046362270225008168.s=
tgit@warthog.procyon.org.uk/

Link: https://lore.kernel.org/r/160588455242.3465195.3214733858273019178.s=
tgit@warthog.procyon.org.uk/

Then as a cut-down set:

Link: https://lore.kernel.org/r/161118128472.1232039.11746799833066425131.=
stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/161161025063.2537118.2009249444682241405.s=
tgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/161340385320.1303470.2392622971006879777.s=
tgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/161539526152.286939.8589700175877370401.st=
git@warthog.procyon.org.uk/ # v4
Link: https://lore.kernel.org/r/161653784755.2770958.11820491619308713741.=
stgit@warthog.procyon.org.uk/ # v5

I split out a set to just restructure the I/O, which got merged back in to
this one:

Link: https://lore.kernel.org/r/163363935000.1980952.15279841414072653108.=
stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/163189104510.2509237.10805032055807259087.=
stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/163363935000.1980952.15279841414072653108.=
stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/163551653404.1877519.12363794970541005441.=
stgit@warthog.procyon.org.uk/ # v4

... and a larger set to do the conversion, also merged back into this one:

Link: https://lore.kernel.org/r/163456861570.2614702.14754548462706508617.=
stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/163492911924.1038219.13107463173777870713.=
stgit@warthog.procyon.org.uk/ # v2

Older versions of this one:

Link: https://lore.kernel.org/r/163819575444.215744.318477214576928110.stg=
it@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/163906878733.143852.5604115678965006622.st=
git@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/163967073889.1823006.12237147297060239168.=
stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/164021479106.640689.17404516570194656552.s=
tgit@warthog.procyon.org.uk/ # v4

Proposals/information about the design have been published here:

Link: https://lore.kernel.org/r/24942.1573667720@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/2758811.1610621106@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/1441311.1598547738@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/160655.1611012999@warthog.procyon.org.uk/

And requests for information:

Link: https://lore.kernel.org/r/3326.1579019665@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/4467.1579020509@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/3577430.1579705075@warthog.procyon.org.uk/

I've posted partial patches to try and help 9p and cifs along:

Link: https://lore.kernel.org/r/1514086.1605697347@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/1794123.1605713481@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/241017.1612263863@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/270998.1612265397@warthog.procyon.org.uk/
---
The following changes since commit 3cfef1b612e15a0c2f5b1c9d3f3f31ad72d56fc=
d:

  netfs: fix parameter of cleanup() (2021-12-07 15:47:09 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/fscache-rewrite-20220111

for you to fetch changes up to d7bdba1c81f7e7bad12c7c7ce55afa3c7b0821ef:

  9p, afs, ceph, nfs: Use current_is_kswapd() rather than gfpflags_allow_b=
locking() (2022-01-11 22:27:42 +0000)

----------------------------------------------------------------
fscache rewrite

----------------------------------------------------------------
Dave Wysochanski (1):
      nfs: Convert to new fscache volume/cookie API

David Howells (64):
      fscache, cachefiles: Disable configuration
      cachefiles: Delete the cachefiles driver pending rewrite
      fscache: Remove the contents of the fscache driver, pending rewrite
      netfs: Display the netfs inode number in the netfs_read tracepoint
      netfs: Pass a flag to ->prepare_write() to say if there's no alloc'd=
 space
      fscache: Introduce new driver
      fscache: Implement a hash function
      fscache: Implement cache registration
      fscache: Implement volume registration
      fscache: Implement cookie registration
      fscache: Implement cache-level access helpers
      fscache: Implement volume-level access helpers
      fscache: Implement cookie-level access helpers
      fscache: Implement functions add/remove a cache
      fscache: Provide and use cache methods to lookup/create/free a volum=
e
      fscache: Add a function for a cache backend to note an I/O error
      fscache: Implement simple cookie state machine
      fscache: Implement cookie user counting and resource pinning
      fscache: Implement cookie invalidation
      fscache: Provide a means to begin an operation
      fscache: Count data storage objects in a cache
      fscache: Provide read/write stat counters for the cache
      fscache: Provide a function to let the netfs update its coherency da=
ta
      netfs: Pass more information on how to deal with a hole in the cache
      fscache: Implement raw I/O interface
      fscache: Implement higher-level write I/O interface
      vfs, fscache: Implement pinning of cache usage for writeback
      fscache: Provide a function to note the release of a page
      fscache: Provide a function to resize a cookie
      cachefiles: Introduce rewritten driver
      cachefiles: Define structs
      cachefiles: Add some error injection support
      cachefiles: Add a couple of tracepoints for logging errors
      cachefiles: Add cache error reporting macro
      cachefiles: Add security derivation
      cachefiles: Register a miscdev and parse commands over it
      cachefiles: Provide a function to check how much space there is
      vfs, cachefiles: Mark a backing file in use with an inode flag
      cachefiles: Implement a function to get/create a directory in the ca=
che
      cachefiles: Implement cache registration and withdrawal
      cachefiles: Implement volume support
      cachefiles: Add tracepoints for calls to the VFS
      cachefiles: Implement object lifecycle funcs
      cachefiles: Implement key to filename encoding
      cachefiles: Implement metadata/coherency data storage in xattrs
      cachefiles: Mark a backing file in use with an inode flag
      cachefiles: Implement culling daemon commands
      cachefiles: Implement backing file wrangling
      cachefiles: Implement begin and end I/O operation
      cachefiles: Implement cookie resize for truncate
      cachefiles: Implement the I/O routines
      fscache, cachefiles: Store the volume coherency data
      cachefiles: Allow cachefiles to actually function
      fscache, cachefiles: Display stats of no-space events
      fscache, cachefiles: Display stat of culling events
      afs: Convert afs to use the new fscache API
      afs: Copy local writes to the cache when writing to the server
      afs: Skip truncation on the server of data we haven't written yet
      9p: Use fscache indexing rewrite and reenable caching
      9p: Copy local writes to the cache when writing to the server
      nfs: Implement cache I/O by accessing the cache directly
      fscache: Rewrite documentation
      fscache: Add a tracepoint for cookie use/unuse
      9p, afs, ceph, nfs: Use current_is_kswapd() rather than gfpflags_all=
ow_blocking()

Jeff Layton (2):
      ceph: conversion to new fscache API
      ceph: add fscache writeback support

 Documentation/filesystems/caching/backend-api.rst |  850 +++++-------
 Documentation/filesystems/caching/cachefiles.rst  |    6 +-
 Documentation/filesystems/caching/fscache.rst     |  525 +++-----
 Documentation/filesystems/caching/index.rst       |    4 +-
 Documentation/filesystems/caching/netfs-api.rst   | 1136 +++++-----------
 Documentation/filesystems/caching/object.rst      |  313 -----
 Documentation/filesystems/caching/operations.rst  |  210 ---
 Documentation/filesystems/netfs_library.rst       |   16 +-
 fs/9p/cache.c                                     |  195 +--
 fs/9p/cache.h                                     |   25 +-
 fs/9p/v9fs.c                                      |   17 +-
 fs/9p/v9fs.h                                      |   13 +-
 fs/9p/vfs_addr.c                                  |   57 +-
 fs/9p/vfs_dir.c                                   |   13 +
 fs/9p/vfs_file.c                                  |    3 +-
 fs/9p/vfs_inode.c                                 |   26 +-
 fs/9p/vfs_inode_dotl.c                            |    3 +-
 fs/9p/vfs_super.c                                 |    3 +
 fs/afs/Makefile                                   |    3 -
 fs/afs/cache.c                                    |   68 -
 fs/afs/cell.c                                     |   12 -
 fs/afs/file.c                                     |   38 +-
 fs/afs/inode.c                                    |  101 +-
 fs/afs/internal.h                                 |   37 +-
 fs/afs/main.c                                     |   14 -
 fs/afs/super.c                                    |    1 +
 fs/afs/volume.c                                   |   29 +-
 fs/afs/write.c                                    |   88 +-
 fs/cachefiles/Kconfig                             |    7 +
 fs/cachefiles/Makefile                            |    6 +-
 fs/cachefiles/bind.c                              |  278 ----
 fs/cachefiles/cache.c                             |  378 ++++++
 fs/cachefiles/daemon.c                            |  180 ++-
 fs/cachefiles/error_inject.c                      |   46 +
 fs/cachefiles/interface.c                         |  747 +++++------
 fs/cachefiles/internal.h                          |  270 ++--
 fs/cachefiles/io.c                                |  330 +++--
 fs/cachefiles/key.c                               |  201 ++-
 fs/cachefiles/main.c                              |   22 +-
 fs/cachefiles/namei.c                             | 1223 ++++++++--------=
-
 fs/cachefiles/rdwr.c                              |  972 --------------
 fs/cachefiles/security.c                          |    2 +-
 fs/cachefiles/volume.c                            |  139 ++
 fs/cachefiles/xattr.c                             |  421 +++---
 fs/ceph/addr.c                                    |  102 +-
 fs/ceph/cache.c                                   |  218 +---
 fs/ceph/cache.h                                   |   97 +-
 fs/ceph/caps.c                                    |    3 +-
 fs/ceph/file.c                                    |   13 +-
 fs/ceph/inode.c                                   |   22 +-
 fs/ceph/super.c                                   |   10 +-
 fs/ceph/super.h                                   |    3 +-
 fs/cifs/Kconfig                                   |    2 +-
 fs/fs-writeback.c                                 |    8 +
 fs/fscache/Kconfig                                |    3 +
 fs/fscache/Makefile                               |    6 +-
 fs/fscache/cache.c                                |  618 ++++-----
 fs/fscache/cookie.c                               | 1448 +++++++++++-----=
-----
 fs/fscache/fsdef.c                                |   98 --
 fs/fscache/internal.h                             |  317 +----
 fs/fscache/io.c                                   |  376 ++++--
 fs/fscache/main.c                                 |  147 +--
 fs/fscache/netfs.c                                |   74 --
 fs/fscache/object.c                               | 1125 ----------------
 fs/fscache/operation.c                            |  633 ---------
 fs/fscache/page.c                                 | 1242 ----------------=
--
 fs/fscache/proc.c                                 |   47 +-
 fs/fscache/stats.c                                |  293 +----
 fs/fscache/volume.c                               |  517 ++++++++
 fs/namei.c                                        |    3 +-
 fs/netfs/read_helper.c                            |   10 +-
 fs/nfs/Makefile                                   |    2 +-
 fs/nfs/client.c                                   |    4 -
 fs/nfs/direct.c                                   |    2 +
 fs/nfs/file.c                                     |   13 +-
 fs/nfs/fscache-index.c                            |  140 --
 fs/nfs/fscache.c                                  |  490 +++----
 fs/nfs/fscache.h                                  |  180 +--
 fs/nfs/inode.c                                    |   11 +-
 fs/nfs/nfstrace.h                                 |    1 -
 fs/nfs/read.c                                     |   25 +-
 fs/nfs/super.c                                    |   28 +-
 fs/nfs/write.c                                    |    8 +-
 include/linux/fs.h                                |    4 +
 include/linux/fscache-cache.h                     |  614 ++-------
 include/linux/fscache.h                           | 1021 ++++++---------
 include/linux/netfs.h                             |   15 +-
 include/linux/nfs_fs.h                            |    1 -
 include/linux/nfs_fs_sb.h                         |    9 +-
 include/linux/writeback.h                         |    1 +
 include/trace/events/cachefiles.h                 |  527 ++++++--
 include/trace/events/fscache.h                    |  642 +++++----
 include/trace/events/netfs.h                      |    5 +-
 93 files changed, 7205 insertions(+), 13001 deletions(-)
 delete mode 100644 Documentation/filesystems/caching/object.rst
 delete mode 100644 Documentation/filesystems/caching/operations.rst
 delete mode 100644 fs/afs/cache.c
 delete mode 100644 fs/cachefiles/bind.c
 create mode 100644 fs/cachefiles/cache.c
 create mode 100644 fs/cachefiles/error_inject.c
 delete mode 100644 fs/cachefiles/rdwr.c
 create mode 100644 fs/cachefiles/volume.c
 delete mode 100644 fs/fscache/fsdef.c
 delete mode 100644 fs/fscache/netfs.c
 delete mode 100644 fs/fscache/object.c
 delete mode 100644 fs/fscache/operation.c
 delete mode 100644 fs/fscache/page.c
 create mode 100644 fs/fscache/volume.c
 delete mode 100644 fs/nfs/fscache-index.c

