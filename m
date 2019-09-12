Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B82DB13E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfILRp5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:45:57 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:27357 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfILRp5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568310356; x=1599846356;
  h=message-id:from:date:subject:to:mime-version;
  bh=axxPPTgmB/OsmmjWoxP+U1wcmfhgLDORkaB6I0qcGlk=;
  b=cs2YDMlHNenzthVNXpcAwc3zeAYzNzZ2O016H+a+rq9AQTt/D4N8OHvA
   j+rATA4fTn74tpKDR13Xqisf2LoEcPFa+e52Mj0ZdAifOJHhhCoynN6Ml
   Yr3FtEwuZp3bHmTHieSfcjiClUqeb6jDaA1sx1WLxtntvGfHtBU9X24MR
   k=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="831156429"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 12 Sep 2019 17:28:51 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id 551EEA1BE9;
        Thu, 12 Sep 2019 17:28:50 +0000 (UTC)
Received: from EX13D19UEA002.ant.amazon.com (10.43.61.226) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:50 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D19UEA002.ant.amazon.com (10.43.61.226) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:50 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:50 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id A8D35C056E; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Thu, 12 Sep 2019 17:25:19 +0000
Subject: [RFC PATCH 00/35] user xattr support (RFC8276)
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This RFC patch series implements both client and server side support
for RFC8276 user extended attributes.

The server side should be complete (except for modifications made
after comments, of course). The client side lacks caching. I am
working on that, but am not happy with my current implementation.
So I'm sending this out for input. Having a reviewed base to work
from will make adding client-side caching support easier to add,
in any case.

Thanks for any input!

Some notable issues:

* RFC8276 explicitly only concerns itself with the user xattr namespace.
  Linux is the only OS that encodes the namespace in the attribute name,
  adding "user." for the user namespace. Others, like FreeBSD and MacOS,
  pass the namespace as a system call argument. Since the "user." prefix
  is specific to Linux, it is stripped off on the client side, and added
  back on the server side.

* Extended attributes tend to be small in size, but they may be somewhat
  large. The Linux-imposed limit is 64k. The sunrpc XDR interfaces only
  allow sizes > PAGE_SIZE to be encoded using pages. That works out
  great for reads/writes, but since there are no page-based xattr
  FS interfaces, it means some extra explicit copying.

* A quirk of the Linux xattr implementation is that you can create
  more extended attributes per file than listxattr can handle in
  its maximum size, meaning that you get E2BIG back. There is no
  1-1 translation for that error to the LISTXATTR op. I chose to
  return NFS4ERR_TOOSMALL (which is a valid error for the operation),
  and have the client code check for it and return E2BIG. Not
  great, but it seemed to be the best option.

* The LISTXATTR op uses cookies to support multiple calls to retrieve
  the complete list, like READDDIR. This means that there's the old
  "how to deal with non-0 cookies" issue.

  In the vast majority of cases, LISTXATTR should not need multiple
  calls. However, you never know what a client will do. READDIR
  uses the cookie as a seek offset in to the directory. It's not
  quite as simple with LISTXATTR. First, there is no seperate
  FS interface to list only user xattrs. Which means that, based
  on permissions, the buffer returned by vfs_listxattr might turn
  out differently (e.g. if you have no permission to read some
  system. attributes). That means that using just a hard offset
  in to the buffer (with verifications) can't work, as its a
  context-specific value, and the client couldn't cache it if
  it wanted to.

  My code returns the attribute count as a cookie. The server
  always asks vfs_listxattr for a XATTR_LIST_MAX buffer (see
  below), and then starts XDR encoding at the Nth user xattr
  attribute, where N is the cookie value. There are bounds
  checks of course.

  This isn't great, but probably the best you can do.

* There is no FS interface to only read user extended attributes,
  and the server code needs to strip off the "user." prefix.
  Additionally, the RFC specifies that the max length field for the
  LISTXATTR op refers to the total XDR-encoded length. Given all
  this, it is not possible to know what the length is it should pass
  to vfs_listxattr. So it just passes an XATTR_LIST_MAX sized buffer
  to vfs_listxattr, and then encodes as many user xattrs as it can
  from the returned buffer.

* Given that this is an extension to v4.2, it is only supported
  if 4.2 is used (even though it has no dependencies on 4.2
  specific features).

* There is a new mount option, already known for other filesystems,
  "user_xattr", which must be passed explicitly as it stands
  right now, together with vers=4.2

* There is a new export option to turn off extended attributes for
  a filesystem.

* Modifications outside of the NFS(D) code were minor. They were
  all in the xattr code, to export versions of vfs_setxattr and
  vfs_removexattr that the NFS code should use (inode rwsem taken
  because of atomic change info), and to have them break delegations,
  as specified by RFC8276.

* As I mentioned, this has no client caching. I have one implementation,
  but I'm not that happy with it.

  The main issue with client caching is that, for virtually all expected
  cases, the number of user extended attributes per file will be small,
  and their data small. But, theoretically, you can, within current Linux
  limitations, create some 9000 user extended attributes per inode, each
  64k in size.

  My current implementation uses an inode LRU chain (much like the access
  cache), and an rhashtable per inode (I picked rhashtables because
  they automatically grow). This seems like overkill, though.

  If there are any suggestions on better implementations, I'll be happy
  to take them. The client caching I mention here is not in this series,
  as I need to clean it up a bit (and am not sure if I really want to use
  it). But I can share it if asked. It will be in the next iteration,
  in whatever shape or form it might take.

Frank van der Linden (35):
  nfsd: make sure the nfsd4_ops array has the right size
  nfs/nfsd: basic NFS4 extended attribute definitions
  NFSv4.2: query the server for extended attribute support
  nfs: parse the {no}user_xattr option
  NFSv4.2: define a function to compute the maximum XDR size for
    listxattr
  NFSv4.2: define and set initial limits for extended attributes
  NFSv4.2: define argument and response structures for xattr operations
  NFSv4.2: define the encode/decode sizes for the XATTR operations
  NFSv4.2: define and use extended attribute overhead sizes
  NFSv4.2: add client side XDR handling for extended attributes
  nfs: define nfs_access_get_cached function
  NFSv4.2: query the extended attribute access bits
  nfs: modify update_changeattr to deal with regular files
  nfs: define and use the NFS_INO_INVALID_XATTR flag
  nfs: make the buf_to_pages_noslab function available to the nfs code
  NFSv4.2: add the extended attribute proc functions.
  NFSv4.2: hook in the user extended attribute handlers
  NFSv4.2: add client side xattr caching functions
  NFSv4.2: call the xattr cache functions
  nfs: add the NFS_V4_XATTR config option
  xattr: modify vfs_{set,remove}xattr for NFS server use
  nfsd: split off the write decode code in to a seperate function
  nfsd: add defines for NFSv4.2 extended attribute support
  nfsd: define xattr functions to call in to their vfs counterparts
  nfsd: take xattr access bits in to account when checking
  nfsd: add structure definitions for xattr requests / responses
  nfsd: implement the xattr procedure functions.
  nfsd: define xattr reply size functions
  nfsd: add xattr XDR decode functions
  nfsd: add xattr XDR encode functions
  nfsd: add xattr operations to ops array
  xattr: add a function to check if a namespace is supported
  nfsd: add fattr support for user extended attributes
  nfsd: add export flag to disable user extended attributes
  nfsd: add NFSD_V4_XATTR config option

 fs/nfs/Kconfig                   |   9 +
 fs/nfs/Makefile                  |   1 +
 fs/nfs/client.c                  |  17 +-
 fs/nfs/dir.c                     |  24 +-
 fs/nfs/inode.c                   |   7 +-
 fs/nfs/internal.h                |  24 ++
 fs/nfs/nfs42.h                   |  29 ++
 fs/nfs/nfs42proc.c               | 242 ++++++++++++++
 fs/nfs/nfs42xattr.c              |  72 ++++
 fs/nfs/nfs42xdr.c                | 446 +++++++++++++++++++++++++
 fs/nfs/nfs4_fs.h                 |   5 +
 fs/nfs/nfs4client.c              |  31 ++
 fs/nfs/nfs4proc.c                | 246 ++++++++++++--
 fs/nfs/nfs4super.c               |   1 +
 fs/nfs/nfs4xdr.c                 |  35 ++
 fs/nfs/nfstrace.h                |   3 +-
 fs/nfs/super.c                   |  11 +
 fs/nfsd/Kconfig                  |  10 +
 fs/nfsd/export.c                 |   1 +
 fs/nfsd/nfs4proc.c               | 145 +++++++-
 fs/nfsd/nfs4xdr.c                | 548 +++++++++++++++++++++++++++++--
 fs/nfsd/nfsd.h                   |  13 +-
 fs/nfsd/vfs.c                    | 153 +++++++++
 fs/nfsd/vfs.h                    |  10 +
 fs/nfsd/xdr4.h                   |  31 ++
 fs/xattr.c                       |  90 ++++-
 include/linux/nfs4.h             |  27 +-
 include/linux/nfs_fs.h           |   6 +
 include/linux/nfs_fs_sb.h        |   7 +
 include/linux/nfs_xdr.h          |  62 +++-
 include/linux/xattr.h            |   4 +
 include/uapi/linux/nfs4.h        |   3 +
 include/uapi/linux/nfs_fs.h      |   1 +
 include/uapi/linux/nfsd/export.h |   3 +-
 34 files changed, 2233 insertions(+), 84 deletions(-)
 create mode 100644 fs/nfs/nfs42xattr.c

-- 
2.17.2

