Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF1464E48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 00:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfGJWCi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 18:02:38 -0400
Received: from fieldses.org ([173.255.197.46]:53594 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfGJWCh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 18:02:37 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id C5D761E19; Wed, 10 Jul 2019 18:02:36 -0400 (EDT)
Date:   Wed, 10 Jul 2019 18:02:36 -0400
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: [GIT PULL] nfsd changes for 5.3
Message-ID: <20190710220236.GA11923@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Please pull nfsd changes for 5.3:

  git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.3

Note there's a conflict with a mount API patch in the vfs tree; Stephen
Rothwell's resolution in linux-next looks good.

Highlights:

- Add a new /proc/fs/nfsd/clients/ directory which exposes some
  long-requested information about NFSv4 clients (like open files) and
  allows forced revocation of client state.

- Replace the global duplicate reply cache by a cache per network
  namespace; previously, a request in one network namespace could
  incorrectly match an entry from another, though we haven't seen this
  in production.  This is the last remaining container bug that I'm
  aware of; at this point you should be able to run separate nfsd's in
  each network namespace, each with their own set of exports, and
  everything should work.

- Cleanup and modify lock code to show the pid of lockd as the owner of
  NLM locks.  This is the correct version of the bugfix originally
  attempted in b8eee0e90f97 "lockd: Show pid of lockd for remote locks".

--b.

----------------------------------------------------------------
Benjamin Coddington (5):
      lockd: prepare nlm_lockowner for use by the server
      lockd: Convert NLM service fl_owner to nlm_lockowner
      lockd: Remove lm_compare_owner and lm_owner_key
      lockd: Show pid of lockd for remote locks
      locks: Cleanup lm_compare_owner and lm_owner_key

Denis Efremov (1):
      sunrpc/cache: remove the exporting of cache_seq_next

Geert Uytterhoeven (1):
      nfsd: Spelling s/EACCESS/EACCES/

J. Bruce Fields (23):
      nfsd: don't call nfsd_reply_cache_shutdown twice
      nfsd4: drc containerization
      nfsd: note inadequate stats locking
      nfsd: use 64-bit seconds fields in nfsd v4 code
      nfsd4: remove outdated nfsd4_decode_time comment
      nfsd: fix cleanup of nfsd_reply_cache_init on failure
      nfs: fix out-of-date connectathon talk URL
      nfsd: persist nfsd filesystem across mounts
      nfsd: rename cl_refcount
      nfsd4: use reference count to free client
      nfsd: add nfsd/clients directory
      nfsd: make client/ directory names small ints
      nfsd4: add a client info file
      nfsd: copy client's address including port number to cl_addr
      nfsd: escape high characters in binary data
      nfsd: add more information to client info file
      nfsd4: add file to display list of client's opens
      nfsd: show lock and deleg stateids
      nfsd4: show layout stateids
      nfsd: create get_nfsdfs_clp helper
      nfsd: allow forced expiration of NFSv4 clients
      nfsd: create xdr_netobj_dup helper
      nfsd: decode implementation id

Joe Perches (1):
      nfsd: Fix misuse of strlcpy

YueHaibing (3):
      lockd: Make two symbols static
      nfsd: Make two functions static
      nfsd: Make __get_nfsdfs_client() static

 Documentation/filesystems/Locking |  14 --
 fs/lockd/clntproc.c               |  21 +-
 fs/lockd/svc4proc.c               |  14 +-
 fs/lockd/svclock.c                | 118 ++++++++--
 fs/lockd/svcproc.c                |  14 +-
 fs/lockd/svcsubs.c                |   2 +-
 fs/lockd/xdr.c                    |   3 -
 fs/lockd/xdr4.c                   |   3 -
 fs/locks.c                        |   5 -
 fs/nfsd/blocklayout.c             |   8 +-
 fs/nfsd/cache.h                   |   5 +-
 fs/nfsd/netns.h                   |  44 ++++
 fs/nfsd/nfs4idmap.c               |   2 +-
 fs/nfsd/nfs4state.c               | 453 +++++++++++++++++++++++++++++++++++---
 fs/nfsd/nfs4xdr.c                 |  38 ++--
 fs/nfsd/nfscache.c                | 236 ++++++++++----------
 fs/nfsd/nfsctl.c                  | 233 +++++++++++++++++++-
 fs/nfsd/nfsd.h                    |  11 +
 fs/nfsd/state.h                   |  11 +-
 fs/nfsd/vfs.c                     |   2 +-
 fs/nfsd/xdr4.h                    |   5 +-
 fs/seq_file.c                     |  11 +
 include/linux/fs.h                |   2 -
 include/linux/lockd/lockd.h       |   2 +
 include/linux/seq_file.h          |   1 +
 include/linux/string_helpers.h    |   3 +
 include/linux/sunrpc/xdr.h        |   7 +
 lib/string_helpers.c              |  19 ++
 net/sunrpc/cache.c                |   1 -
 net/sunrpc/svc_xprt.c             |   2 +-
 30 files changed, 1034 insertions(+), 256 deletions(-)
