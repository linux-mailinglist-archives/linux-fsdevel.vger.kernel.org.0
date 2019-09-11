Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15332B0121
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 18:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfIKQQX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 12:16:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728818AbfIKQQW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:16:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9AE8C10CC1E7;
        Wed, 11 Sep 2019 16:16:22 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-122-52.rdu2.redhat.com [10.10.122.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C7855DC18;
        Wed, 11 Sep 2019 16:16:22 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id F2E58209B9; Wed, 11 Sep 2019 12:16:21 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/26] nfs: Mount API conversion
Date:   Wed, 11 Sep 2019 12:15:55 -0400
Message-Id: <20190911161621.19832-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Wed, 11 Sep 2019 16:16:22 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Anna,

Here's a set of patches that converts NFS to use the mount API.  Note that
there are a lot of preliminary patches, some from David and some from Al.
The final patch (the one that does the actual conversion) from the David's
initial posting has been split into 4 separate patches, and the entire set
has been rebased on top of v5.3-rc6.

Changes since v2:
- fixed the conversion of the nconnect= option
- added '#if IS_ENABLED(CONFIG_NFS_V4)' around nfs4_parse_monolithic()
  to avoid unused-function warning when compiling with v4 disabled

-Scott

Al Viro (15):
  saner calling conventions for nfs_fs_mount_common()
  nfs: stash server into struct nfs_mount_info
  nfs: lift setting mount_info from nfs4_remote{,_referral}_mount
  nfs: fold nfs4_remote_fs_type and nfs4_remote_referral_fs_type
  nfs: don't bother setting/restoring export_path around
    do_nfs_root_mount()
  nfs4: fold nfs_do_root_mount/nfs_follow_remote_path
  nfs: lift setting mount_info from nfs_xdev_mount()
  nfs: stash nfs_subversion reference into nfs_mount_info
  nfs: don't bother passing nfs_subversion to ->try_mount() and
    nfs_fs_mount_common()
  nfs: merge xdev and remote file_system_type
  nfs: unexport nfs_fs_mount_common()
  nfs: don't pass nfs_subversion to ->create_server()
  nfs: get rid of mount_info ->fill_super()
  nfs_clone_sb_security(): simplify the check for server bogosity
  nfs: get rid of ->set_security()

David Howells (8):
  NFS: Move mount parameterisation bits into their own file
  NFS: Constify mount argument match tables
  NFS: Rename struct nfs_parsed_mount_data to struct nfs_fs_context
  NFS: Split nfs_parse_mount_options()
  NFS: Deindent nfs_fs_context_parse_option()
  NFS: Add a small buffer in nfs_fs_context to avoid string dup
  NFS: Do some tidying of the parsing code
  NFS: Add fs_context support.

Scott Mayhew (3):
  NFS: rename nfs_fs_context pointer arg in a few functions
  NFS: Convert mount option parsing to use functionality from
    fs_parser.h
  NFS: Attach supplementary error information to fs_context.

 fs/nfs/Makefile         |    2 +-
 fs/nfs/client.c         |   80 +-
 fs/nfs/fs_context.c     | 1425 ++++++++++++++++++++++++++++
 fs/nfs/fscache.c        |    2 +-
 fs/nfs/getroot.c        |   73 +-
 fs/nfs/internal.h       |  132 +--
 fs/nfs/namespace.c      |  144 +--
 fs/nfs/nfs3_fs.h        |    2 +-
 fs/nfs/nfs3client.c     |    6 +-
 fs/nfs/nfs3proc.c       |    2 +-
 fs/nfs/nfs4_fs.h        |    9 +-
 fs/nfs/nfs4client.c     |   99 +-
 fs/nfs/nfs4namespace.c  |  285 +++---
 fs/nfs/nfs4proc.c       |    2 +-
 fs/nfs/nfs4super.c      |  257 ++---
 fs/nfs/proc.c           |    2 +-
 fs/nfs/super.c          | 1962 ++++-----------------------------------
 include/linux/nfs_xdr.h |    9 +-
 18 files changed, 2156 insertions(+), 2337 deletions(-)
 create mode 100644 fs/nfs/fs_context.c

-- 
2.17.2

