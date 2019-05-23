Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57EB728261
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 18:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731083AbfEWQPu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 12:15:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730790AbfEWQPu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 12:15:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3899AC0568FC;
        Thu, 23 May 2019 16:15:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-142.rdu2.redhat.com [10.10.121.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9423A17AC7;
        Thu, 23 May 2019 16:15:38 +0000 (UTC)
Subject: [PATCH 00/23] nfs: Mount API conversion
From:   David Howells <dhowells@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     Al Viro <viro@zeniv.linux.org.uk>, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 23 May 2019 17:15:37 +0100
Message-ID: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 23 May 2019 16:15:50 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Trond, Anna,

Here's a set of patches that converts NFS to use the mount API.  Note that
there are a lot of preliminary patches, some from me and some from Al.  The
actual conversion is done by the final patch.

I've rebased them on 5.2-rc1.  Do you want them basing on something else?

The patches can be found here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git

on branch:

	mount-api-nfs

David
---
Al Viro (15):
      saner calling conventions for nfs_fs_mount_common()
      nfs: stash server into struct nfs_mount_info
      nfs: lift setting mount_info from nfs4_remote{,_referral}_mount
      nfs: fold nfs4_remote_fs_type and nfs4_remote_referral_fs_type
      nfs: don't bother setting/restoring export_path around do_nfs_root_mount()
      nfs4: fold nfs_do_root_mount/nfs_follow_remote_path
      nfs: lift setting mount_info from nfs_xdev_mount()
      nfs: stash nfs_subversion reference into nfs_mount_info
      nfs: don't bother passing nfs_subversion to ->try_mount() and nfs_fs_mount_common()
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


 fs/nfs/Makefile         |    3 
 fs/nfs/client.c         |   78 +-
 fs/nfs/fs_context.c     | 1409 ++++++++++++++++++++++++++++++++++
 fs/nfs/fscache.c        |    2 
 fs/nfs/getroot.c        |   73 +-
 fs/nfs/internal.h       |  132 ++-
 fs/nfs/namespace.c      |  144 ++-
 fs/nfs/nfs3_fs.h        |    2 
 fs/nfs/nfs3client.c     |    6 
 fs/nfs/nfs3proc.c       |    2 
 fs/nfs/nfs4_fs.h        |    9 
 fs/nfs/nfs4client.c     |   97 +-
 fs/nfs/nfs4namespace.c  |  285 ++++---
 fs/nfs/nfs4proc.c       |    2 
 fs/nfs/nfs4super.c      |  257 ++----
 fs/nfs/proc.c           |    2 
 fs/nfs/super.c          | 1950 ++++-------------------------------------------
 include/linux/nfs_xdr.h |    9 
 18 files changed, 2138 insertions(+), 2324 deletions(-)
 create mode 100644 fs/nfs/fs_context.c

