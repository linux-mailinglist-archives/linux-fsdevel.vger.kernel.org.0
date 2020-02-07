Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3287A156093
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 22:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgBGVM4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 16:12:56 -0500
Received: from fieldses.org ([173.255.197.46]:56698 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbgBGVM4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 16:12:56 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 04F4DC55; Fri,  7 Feb 2020 16:12:56 -0500 (EST)
Date:   Fri, 7 Feb 2020 16:12:55 -0500
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] nfsd changes for 5.6
Message-ID: <20200207211255.GA17715@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Please pull nfsd changes for 5.6 from:

  git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.6

Highlights:

	- Server-to-server copy code from Olga.  To use it, client and
	  both servers must have support, the target server must be able
	  to access the source server over NFSv4.2, and the target
	  server must have the inter_copy_offload_enable module
	  parameter set.
	- Improvements and bugfixes for the new filehandle cache,
	  especially in the container case, from Trond
	- Also from Trond, better reporting of write errors.
	- Y2038 work from Arnd.

--b.

Aditya Pakki (1):
      nfsd: remove unnecessary assertion in nfsd4_encode_replay

Arnd Bergmann (12):
      nfsd: use ktime_get_seconds() for timestamps
      nfsd: print 64-bit timestamps in client_info_show
      nfsd: handle nfs3 timestamps as unsigned
      nfsd: use timespec64 in encode_time_delta
      nfsd: make 'boot_time' 64-bit wide
      nfsd: pass a 64-bit guardtime to nfsd_setattr()
      nfsd: use time64_t in nfsd_proc_setattr() check
      nfsd: fix delay timer on 32-bit architectures
      nfsd: fix jiffies/time_t mixup in LRU list
      nfsd: use boottime for lease expiry calculation
      nfsd: use ktime_get_real_seconds() in nfs4_verifier
      nfsd: remove nfs4_reset_lease() declarations

Chen Zhou (1):
      nfsd: make nfsd_filecache_wq variable static

Dan Carpenter (2):
      nfsd: unlock on error in manage_cpntf_state()
      nfsd4: fix double free in nfsd4_do_async_copy()

J. Bruce Fields (1):
      nfsd4: avoid NULL deference on strange COPY compounds

Olga Kornievskaia (12):
      NFSD fill-in netloc4 structure
      NFSD add ca_source_server<> to COPY
      NFSD COPY_NOTIFY xdr
      NFSD add COPY_NOTIFY operation
      NFSD check stateids against copy stateids
      NFSD generalize nfsd4_compound_state flag names
      NFSD: allow inter server COPY to have a STALE source server fh
      NFSD add nfs4 inter ssc to nfsd4_copy
      NFSD fix mismatching type in nfsd4_set_netaddr
      NFSD: fix seqid in copy stateid
      NFSD fix nfserro errno mismatch
      NFSD fixing possible null pointer derefering in copy offload

Roberto Bergantinos Corpas (1):
      sunrpc: expiry_time should be seconds not timeval

Trond Myklebust (21):
      nfsd: Return the correct number of bytes written to the file
      nfsd: Clone should commit src file metadata too
      nfsd: fix filecache lookup
      nfsd: cleanup nfsd_file_lru_dispose()
      nfsd: Containerise filecache laundrette
      nfsd: Remove unused constant NFSD_FILE_LRU_RESCAN
      nfsd: Schedule the laundrette regularly irrespective of file errors
      nfsd: Reduce the number of calls to nfsd_file_gc()
      nfsd: Fix a soft lockup race in nfsd_file_mark_find_or_create()
      nfsd: Allow nfsd_vfs_write() to take the nfsd_file as an argument
      nfsd: Fix stable writes
      nfsd: Update the boot verifier on stable writes too.
      nfsd: Pass the nfsd_file as arguments to nfsd4_clone_file_range()
      nfsd: Ensure exclusion between CLONE and WRITE errors
      sunrpc: Fix potential leaks in sunrpc_cache_unhash()
      sunrpc: clean up cache entry add/remove from hashtable
      nfsd: Ensure sampling of the commit verifier is atomic with the commit
      nfsd: Ensure sampling of the write verifier is atomic with the write
      nfsd: Fix a perf warning
      nfsd: Define the file access mode enum for tracing
      nfsd: convert file cache to use over/underflow safe refcount

zhengbin (4):
      nfsd4: Remove unneeded semicolon
      nfsd: use true,false for bool variable in vfs.c
      nfsd: use true,false for bool variable in nfs4proc.c
      nfsd: use true,false for bool variable in nfssvc.c

 fs/nfsd/Kconfig                   |  10 +
 fs/nfsd/filecache.c               | 313 +++++++++++++++++++-------
 fs/nfsd/filecache.h               |   7 +-
 fs/nfsd/netns.h                   |   6 +-
 fs/nfsd/nfs3proc.c                |   5 +-
 fs/nfsd/nfs3xdr.c                 |  36 +--
 fs/nfsd/nfs4callback.c            |  11 +-
 fs/nfsd/nfs4layouts.c             |   2 +-
 fs/nfsd/nfs4proc.c                | 462 ++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfs4recover.c             |   8 +-
 fs/nfsd/nfs4state.c               | 262 ++++++++++++++++-----
 fs/nfsd/nfs4xdr.c                 | 161 ++++++++++++-
 fs/nfsd/nfsctl.c                  |   6 +-
 fs/nfsd/nfsd.h                    |  34 ++-
 fs/nfsd/nfsfh.h                   |   9 +-
 fs/nfsd/nfsproc.c                 |   8 +-
 fs/nfsd/nfssvc.c                  |  21 +-
 fs/nfsd/state.h                   |  44 +++-
 fs/nfsd/trace.h                   |  22 +-
 fs/nfsd/vfs.c                     | 109 ++++++---
 fs/nfsd/vfs.h                     |  18 +-
 fs/nfsd/xdr3.h                    |   4 +-
 fs/nfsd/xdr4.h                    |  39 +++-
 net/sunrpc/auth_gss/svcauth_gss.c |   4 +
 net/sunrpc/cache.c                |  48 ++--
 25 files changed, 1322 insertions(+), 327 deletions(-)
