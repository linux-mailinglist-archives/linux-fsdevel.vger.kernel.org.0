Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C42EC1FD51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 03:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfEPBq0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 21:46:26 -0400
Received: from fieldses.org ([173.255.197.46]:33066 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbfEPBUY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 21:20:24 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 469B61D39; Wed, 15 May 2019 21:20:23 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 00/12] exposing knfsd state to userspace
Date:   Wed, 15 May 2019 21:20:05 -0400
Message-Id: <1557969619-17157-1-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

This is still a little rough, but maybe closer.  Changes since last
time:
	- renamed the "opens" file to "states" and added some (minimal)
	  information about lock, delegation, and layout stateids as
	  well as opens.
	- converted the states file to a YAML-like format.
	- added the ability to remove a client's state by writing
	  "expire\n" into a new nfsd/client/#/ctl file.

Recapping discussion from last time:

The following patches expose information about NFSv4 state held by knfsd
on behalf of NFSv4 clients.  This especially important for opens, which
are currently invisible to userspace on the server, unlike locks
(/proc/locks) and local processes' opens (under /proc/<pid>/).

The approach is to add a new directory /proc/fs/nfsd/clients/ with
subdirectories for each active NFSv4 client.  Each subdirectory has an
"info" file with some basic information to help identify the client and
a "states" directory that lists the open state held by that client.

Currently these pseudofiles look like:

  # find /proc/fs/nfsd/clients -type f|xargs tail 
  ==> /proc/fs/nfsd/clients/3/opens <==
 - 0x020000006a5fdc5c4ad09d9e01000000: { type: open, access: rw, deny: --, superblock: "fd:10:13649", owner: "open id:\x00\x00\x00&\x00\x00\x00\x00\x00\x0046��QH " }
 - 0x010000006a5fdc5c4ad09d9e03000000: { type: open, access: r-, deny: --, superblock: "fd:10:13650", owner: "open id:\x00\x00\x00&\x00\x00\x00\x00\x00\x0046��QH" }
 - 0x010000006a5fdc5c4ad09d9e04000000: { type: deleg, access: r, superblock: "fd:10:13650" }
 - 0x010000006a5fdc5c4ad09d9e06000000: { type: lock, superblock: "fd:10:13649", owner: "lock id:\x00\x00\x00&\x00\x00\x00\x00\x00\x00\x00\x00" }


  ==> /proc/fs/nfsd/clients/3/info <==
  clientid: 6debfb505cc0cd36
  address: 192.168.122.36:907
  name: "Linux NFSv4.2 test2.fieldses.org"
  minor version: 2

I'm conflicted about how I'm representing stateowners and client names,
both opaque byte-streams in the protocol but that often include
human-readable ascii.

Possibly also todo:
	- add some information about krb5 principals to the clients
	  file.
	- add information about the stateids used to represent
	  asynchronous copies.  They're a little different from the
	  other stateids and might end up in a separate "copies" file,
	- this duplicates some functionality of the little-used fault
	  injection code; could we replace it entirely?
	- some of the bits of filesystem code could probably be shared
	  with rpc_pipefs and libfs.

--b.

J. Bruce Fields (10):
  nfsd: persist nfsd filesystem across mounts
  nfsd: rename cl_refcount
  nfsd4: use reference count to free client
  nfsd: add nfsd/clients directory
  nfsd: make client/ directory names small ints
  rpc: replace rpc_filelist by tree_descr
  nfsd4: add a client info file
  nfsd4: add file to display list of client's opens
  nfsd: expose some more information about NFSv4 opens
  nfsd: add more information to client info file

 fs/nfsd/netns.h                |   6 +
 fs/nfsd/nfs4state.c            | 228 ++++++++++++++++++++++++++++++---
 fs/nfsd/nfsctl.c               | 225 +++++++++++++++++++++++++++++++-
 fs/nfsd/nfsd.h                 |  11 ++
 fs/nfsd/state.h                |   9 +-
 fs/seq_file.c                  |  17 +++
 include/linux/seq_file.h       |   2 +
 include/linux/string_helpers.h |   1 +
 lib/string_helpers.c           |   5 +-
 net/sunrpc/rpc_pipe.c          |  37 ++----
 10 files changed, 491 insertions(+), 50 deletions(-)

-- 
2.20.1


J. Bruce Fields (12):
  nfsd: persist nfsd filesystem across mounts
  nfsd: rename cl_refcount
  nfsd4: use reference count to free client
  nfsd: add nfsd/clients directory
  nfsd: make client/ directory names small ints
  nfsd4: add a client info file
  nfsd: copy client's address including port number to cl_addr
  nfsd: add more information to client info file
  nfsd4: add file to display list of client's opens
  nfsd: show lock and deleg stateids
  nfsd4: show layout stateids
  nfsd: allow forced expiration of NFSv4 clients

 fs/nfsd/netns.h          |   6 +
 fs/nfsd/nfs4state.c      | 418 ++++++++++++++++++++++++++++++++++++---
 fs/nfsd/nfsctl.c         | 225 ++++++++++++++++++++-
 fs/nfsd/nfsd.h           |  11 ++
 fs/nfsd/state.h          |   7 +-
 fs/seq_file.c            |  17 ++
 include/linux/seq_file.h |   2 +
 7 files changed, 661 insertions(+), 25 deletions(-)

-- 
2.21.0

