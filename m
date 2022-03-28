Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84154E9BC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Mar 2022 18:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240726AbiC1QCb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Mar 2022 12:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240660AbiC1QCa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:02:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1ABD726ADF
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Mar 2022 09:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648483246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oxOO4gJbn0ydaUcqbE+9zc/rIqqndD63o24mIhA8iJM=;
        b=NJHEz2Ks11IJZQnbceggTwR2UCMqJWvUG2weR/50dPeU/O0qV5++MC/Rkqf3CBzMRJt6kv
        U/OPJ7kYxJQK9E21k4fA+u4kHOELjpSqSKIwRvFaPU+Zsfm7XKaKN9M/f6i9wUNL2WwuV9
        cEYWcPEu5BVV7jF7mmDgpjtbxBozyA4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-7W1Y8D9BPTyYlCdSe46Ysg-1; Mon, 28 Mar 2022 12:00:43 -0400
X-MC-Unique: 7W1Y8D9BPTyYlCdSe46Ysg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2068A18A6581;
        Mon, 28 Mar 2022 16:00:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A61AC080A5;
        Mon, 28 Mar 2022 16:00:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Steve French <sfrench@samba.org>, ceph-devel@vger.kernel.org,
        dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-cachefs@redhat.com, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [GIT PULL] netfs: Prep for write helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2181379.1648196143.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
From:   David Howells <dhowells@redhat.com>
Date:   Mon, 28 Mar 2022 17:00:25 +0100
Message-ID: <2639515.1648483225@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_QP_LONG_LINE,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Here's my next batch of netfs changes, if you could pull them?  Note that
this has dependencies on ceph changes in Ilya's pull request and there are
some minor conflicts with Willy's folio patches that you've already pulled
for which Stephen Rothwell has posted adjustments for linux-next[9][10].

Having had a go at implementing write helpers and content encryption
support in netfslib, it seems that the netfs_read_{,sub}request structs and
the equivalent write request structs were almost the same and so should be
merged, thereby requiring only one set of alloc/get/put functions and a
common set of tracepoints.

Merging the structs also has the advantage that if a bounce buffer is added
to the request struct, a read operation can be performed to fill the bounce
buffer, the contents of the buffer can be modified and then a write
operation can be performed on it to send the data wherever it needs to go
using the same request structure all the way through.  The I/O handlers
would then transparently perform any required crypto.  This should make it
easier to perform RMW cycles if needed.

The potentially common functions and structs, however, by their names all
proclaim themselves to be associated with the read side of things.  The
bulk of these changes alter this in the following ways:

 (1) Rename struct netfs_read_{,sub}request to netfs_io_{,sub}request.

 (2) Rename some enums, members and flags to make them more appropriate.

 (3) Adjust some comments to match.

 (4) Drop "read"/"rreq" from the names of common functions.  For instance,
     netfs_get_read_request() becomes netfs_get_request().

 (5) The ->init_rreq() and ->issue_op() methods become ->init_request() and
     ->issue_read().  I've kept the latter as a read-specific function and
     in another branch added an ->issue_write() method.

The driver source is then reorganised into a number of files:

	fs/netfs/buffered_read.c	Create read reqs to the pagecache
	fs/netfs/io.c			Dispatchers for read and write reqs
	fs/netfs/main.c			Some general miscellaneous bits
	fs/netfs/objects.c		Alloc, get and put functions
	fs/netfs/stats.c		Optional procfs statistics.

and future development can be fitted into this scheme, e.g.:

	fs/netfs/buffered_write.c	Modify the pagecache
	fs/netfs/buffered_flush.c	Writeback from the pagecache
	fs/netfs/direct_read.c		DIO read support
	fs/netfs/direct_write.c		DIO write support
	fs/netfs/unbuffered_write.c	Write modifications directly back

Beyond the above changes, there are also some changes that affect how
things work:

 (1) Make fscache_end_operation() generally available.

 (2) In the netfs tracing header, generate enums from the symbol -> string
     mapping tables rather than manually coding them.

 (3) Add a struct for filesystems that uses netfslib to put into their
     inode wrapper structs to hold extra state that netfslib is interested
     in, such as the fscache cookie.  This allows netfslib functions to be
     set in filesystem operation tables and jumped to directly without
     having to have a filesystem wrapper.

 (4) Add a member to the struct added in (3) to track the remote inode
     length as that may differ if local modifications are buffered.  We may
     need to supply an appropriate EOF pointer when storing data (in AFS
     for example).

 (5) Pass extra information to netfs_alloc_request() so that the
     ->init_request() hook can access it and retain information to indicate
     the origin of the operation.

 (6) Make the ->init_request() hook return an error, thereby allowing a
     filesystem that isn't allowed to cache an inode (ceph or cifs, for
     example) to skip readahead.

 (7) Switch to using refcount_t for subrequests and add tracepoints to log
     refcount changes for the request and subrequest structs.

 (8) Add a function to consolidate dispatching a read request.  Similar
     code is used in three places and another couple are likely to be added
     in the future.

Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Dominique Martinet <asmadeus@codewreck.org> # 9p
Tested-by: Marc Dionne <marc.dionne@auristor.com> # afs

---

Changes
=======
ver #4)
 - Move the check for NETFS_READAHEAD up in ceph_init_request()[7].
 - Fix netfs_is_cache_enabled() to check cookie->cache_priv to see if a
   cache is present[8].
 - Fix netfs_skip_folio_read() to zero out all of the page, not just some
   of it[8].

ver #3)
 - Rebased one patch back on the ceph tree as the top patch got removed[4].
 - Split out the bit to move ceph cap-getting on readahead out from the
   patch adding an inode context[5].
 - Made ceph_init_request() store the caps got in rreq->netfs_priv for
   later freeing.
 - Comment the need to keep the netfs inode context contiguous with the VFS
   inode struct[6].
 - Altered the traces to use 'R=' consistently to denote a request debug ID.
 
ver #2)
 - Changed kdoc references to renamed files[1].
 - Switched the begin-read-function patch and the prepare-to-split patch as
   fewer functions then need unstatic'ing.
 - Fixed an uninitialised var in netfs_begin_read()[2][3].
 - Fixed a refleak caused by an unremoved line when netfs_begin_read() was
   introduced.
 - Used "#if IS_ENABLED()" in netfs_i_cookie(), not "#ifdef".
 - Implemented missing bit of ceph readahead through netfs_readahead().
 - Rearranged the patch order to make the ceph readahead possible.

Link: https://lore.kernel.org/r/20220303202811.6a1d53a1@canb.auug.org.au/ [1]
Link: https://lore.kernel.org/r/20220303163826.1120936-1-nathan@kernel.org/ [2]
Link: https://lore.kernel.org/r/20220303235647.1297171-1-colin.i.king@gmail.com/ [3]
Link: https://lore.kernel.org/r/527234d849b0de18b326d6db0d59070b70d19b7e.camel@kernel.org/ [4]
Link: https://lore.kernel.org/r/8af0d47f17d89c06bbf602496dd845f2b0bf25b3.camel@kernel.org/ [5]
Link: https://lore.kernel.org/r/beaf4f6a6c2575ed489adb14b257253c868f9a5c.camel@kernel.org/ [6]
Link: https://lore.kernel.org/r/dd054c962818716e718bd9b446ee5322ca097675.camel@redhat.com/ [7]
Link: https://lore.kernel.org/r/3536452.1647421585@warthog.procyon.org.uk/ [8]
Link: https://lore.kernel.org/r/20220324105317.67a81b0e@canb.auug.org.au/ [9]
Link: https://lore.kernel.org/r/20220324105426.5250396a@canb.auug.org.au/ [10]
Link: https://lore.kernel.org/r/164622970143.3564931.3656393397237724303.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/164692883658.2099075.5745824552116419504.stgit@warthog.procyon.org.uk/ # v3

---
The following changes since commit ad5255c1ea9c64b350efe732c90e63063b2bbbe0:

  ceph: misc fix for code style and logs (2022-03-01 18:26:37 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/netfs-prep-20220318

for you to fetch changes up to ab487a4cdfca3d1ef12795a49eafe1144967e617:

  afs: Maintain netfs_i_context::remote_i_size (2022-03-18 09:29:05 +0000)

----------------------------------------------------------------
Netfs prep for write helpers

----------------------------------------------------------------
David Howells (19):
      netfs: Generate enums from trace symbol mapping lists
      netfs: Rename netfs_read_*request to netfs_io_*request
      netfs: Finish off rename of netfs_read_request to netfs_io_request
      netfs: Split netfs_io_* object handling out
      netfs: Adjust the netfs_rreq tracepoint slightly
      netfs: Trace refcounting on the netfs_io_request struct
      netfs: Trace refcounting on the netfs_io_subrequest struct
      netfs: Adjust the netfs_failure tracepoint to indicate non-subreq lines
      netfs: Refactor arguments for netfs_alloc_read_request
      netfs: Change ->init_request() to return an error code
      ceph: Make ceph_init_request() check caps on readahead
      netfs: Add a netfs inode context
      netfs: Add a function to consolidate beginning a read
      netfs: Prepare to split read_helper.c
      netfs: Rename read_helper.c to io.c
      netfs: Split fs/netfs/read_helper.c
      netfs: Split some core bits out into their own file
      netfs: Keep track of the actual remote file size
      afs: Maintain netfs_i_context::remote_i_size

Jeffle Xu (1):
      fscache: export fscache_end_operation()

 Documentation/filesystems/netfs_library.rst |  140 ++--
 fs/9p/cache.c                               |   10 +-
 fs/9p/v9fs.c                                |    4 +-
 fs/9p/v9fs.h                                |   13 +-
 fs/9p/vfs_addr.c                            |   62 +-
 fs/9p/vfs_inode.c                           |   13 +-
 fs/afs/dynroot.c                            |    1 +
 fs/afs/file.c                               |   41 +-
 fs/afs/inode.c                              |   32 +-
 fs/afs/internal.h                           |   23 +-
 fs/afs/super.c                              |    4 +-
 fs/afs/write.c                              |   10 +-
 fs/cachefiles/io.c                          |   10 +-
 fs/ceph/addr.c                              |  116 ++-
 fs/ceph/cache.c                             |   28 +-
 fs/ceph/cache.h                             |   15 +-
 fs/ceph/inode.c                             |    6 +-
 fs/ceph/super.h                             |   17 +-
 fs/cifs/cifsglob.h                          |   10 +-
 fs/cifs/fscache.c                           |   19 +-
 fs/cifs/fscache.h                           |    2 +-
 fs/fscache/internal.h                       |   11 -
 fs/netfs/Makefile                           |    8 +-
 fs/netfs/buffered_read.c                    |  428 ++++++++++
 fs/netfs/internal.h                         |   50 +-
 fs/netfs/io.c                               |  657 +++++++++++++++
 fs/netfs/main.c                             |   20 +
 fs/netfs/objects.c                          |  160 ++++
 fs/netfs/read_helper.c                      | 1205 ---------------------------
 fs/netfs/stats.c                            |    1 -
 fs/nfs/fscache.c                            |    8 -
 include/linux/fscache.h                     |   14 +
 include/linux/netfs.h                       |  162 +++-
 include/trace/events/cachefiles.h           |    6 +-
 include/trace/events/netfs.h                |  190 +++--
 35 files changed, 1868 insertions(+), 1628 deletions(-)
 create mode 100644 fs/netfs/buffered_read.c
 create mode 100644 fs/netfs/io.c
 create mode 100644 fs/netfs/main.c
 create mode 100644 fs/netfs/objects.c
 delete mode 100644 fs/netfs/read_helper.c

