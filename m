Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98EF51F9F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 20:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfEOS07 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 14:26:59 -0400
Received: from fieldses.org ([173.255.197.46]:32774 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbfEOS07 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 14:26:59 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 9AF7C1E3A; Wed, 15 May 2019 14:26:58 -0400 (EDT)
Date:   Wed, 15 May 2019 14:26:58 -0400
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] nfsd changes for 5.2
Message-ID: <20190515182658.GA11614@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Please pull:

  git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.2

This pull consists mostly of nfsd container work:

Scott Mayhew revived an old api that communicates with a userspace
daemon to manage some on-disk state that's used to track clients across
server reboots.  We've been using a usermode_helper upcall for that, but
it's tough to run those with the right namespaces, so a daemon is much
friendlier to container use cases.

Trond fixed nfsd's handling of user credentials in user namespaces.  He
also contributed patches that allow containers to support different sets
of NFS protocol versions.

The only remaining container bug I'm aware of is that the NFS reply
cache is shared between all containers.  If anyone's aware of other gaps
in our container support, let me know.

The rest of this is miscellaneous bugfixes.

--b.

Arnd Bergmann (1):
      nfsd: avoid uninitialized variable warning

J. Bruce Fields (2):
      nfsd: allow fh_want_write to be called twice
      nfsd: fh_drop_write in nfsd_unlink

NeilBrown (2):
      sunrpc/cache: handle missing listeners better.
      locks: move checks from locks_free_lock() to locks_release_private()

Scott Mayhew (6):
      nfsd: make nfs4_client_reclaim use an xdr_netobj instead of a fixed char array
      nfsd: un-deprecate nfsdcld
      nfsd: keep a tally of RECLAIM_COMPLETE operations when using nfsdcld
      nfsd: re-order client tracking method selection
      nfsd: handle legacy client tracking records sent by nfsdcld
      nfsd: update callback done processing

Trond Myklebust (12):
      SUNRPC/nfs: Fix return value for nfs4_callback_compound()
      SUNRPC: Add a callback to initialise server requests
      SUNRPC: Clean up generic dispatcher code
      SUNRPC: Allow further customisation of RPC program registration
      nfsd: Add custom rpcbind callbacks for knfsd
      nfsd: Allow containers to set supported nfs versions
      SUNRPC: Cache the process user cred in the RPC server listener
      SUNRPC: Temporary sockets should inherit the cred from their parent
      lockd: Pass the user cred from knfsd when starting the lockd server
      SUNRPC: Fix the server AUTH_UNIX userspace mappings
      SUNRPC: rsi_parse() should use the current user namespace
      nfsd: knfsd must use the container user namespace

 fs/lockd/clntlock.c               |   4 +-
 fs/lockd/svc.c                    |  33 +--
 fs/locks.c                        |  12 +-
 fs/nfs/callback.c                 |   9 +-
 fs/nfs/callback_xdr.c             |   2 +-
 fs/nfs/client.c                   |   1 +
 fs/nfsd/export.c                  |  18 +-
 fs/nfsd/netns.h                   |  11 +
 fs/nfsd/nfs3xdr.c                 |  21 +-
 fs/nfsd/nfs4callback.c            |   9 +-
 fs/nfsd/nfs4idmap.c               |   8 +-
 fs/nfsd/nfs4layouts.c             |   2 +-
 fs/nfsd/nfs4proc.c                |   3 +-
 fs/nfsd/nfs4recover.c             | 436 +++++++++++++++++++++++++++++++++++---
 fs/nfsd/nfs4state.c               |  68 ++++--
 fs/nfsd/nfs4xdr.c                 |   9 +-
 fs/nfsd/nfsctl.c                  |  42 ++--
 fs/nfsd/nfsd.h                    |  17 +-
 fs/nfsd/nfssvc.c                  | 271 ++++++++++++++++++-----
 fs/nfsd/nfsxdr.c                  |  17 +-
 fs/nfsd/state.h                   |   8 +-
 fs/nfsd/vfs.c                     |   8 +-
 fs/nfsd/vfs.h                     |   5 +-
 include/linux/lockd/bind.h        |   3 +-
 include/linux/sunrpc/svc.h        |  33 +++
 include/linux/sunrpc/svc_xprt.h   |   4 +-
 include/linux/sunrpc/svcsock.h    |   3 +-
 include/uapi/linux/nfsd/cld.h     |   1 +
 net/sunrpc/auth_gss/svcauth_gss.c |   6 +-
 net/sunrpc/cache.c                |   4 +-
 net/sunrpc/svc.c                  | 298 +++++++++++++++++---------
 net/sunrpc/svc_xprt.c             |  17 +-
 net/sunrpc/svcauth_unix.c         |  15 +-
 net/sunrpc/svcsock.c              |   4 +-
 34 files changed, 1086 insertions(+), 316 deletions(-)
