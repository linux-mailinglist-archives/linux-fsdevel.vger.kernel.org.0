Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53B51118874
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 13:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfLJMd2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 07:33:28 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33368 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727407AbfLJMbX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:31:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575981081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6fYr/YcKzcP2lJn3q4ihsiLHTDwRl+UTgfXSrf1mhKc=;
        b=EofWhJy3gZ38PlMMq/xP+b2nMZ9oAzmN61F/yS+N8lcz7lmAWojLIdjdK4iFdmXcu4UyX+
        GZSdkWJRnI+JRSFMGwYXM6hi+TSqJfX1SdI8H6XzBnCWOOidn921KYYab4m9j0BvDTTqxO
        EJfDYY0d2HYNSk+QPAVjLubS+T/1k28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-ZBNHqDn8PB6I1ebKEiGXjA-1; Tue, 10 Dec 2019 07:31:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95B98100551A;
        Tue, 10 Dec 2019 12:31:16 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 204D45D72A;
        Tue, 10 Dec 2019 12:31:15 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 8CD41209AF; Tue, 10 Dec 2019 07:31:15 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v6 00/27] nfs: Mount API conversion
Date:   Tue, 10 Dec 2019 07:30:48 -0500
Message-Id: <20191210123115.1655-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: ZBNHqDn8PB6I1ebKEiGXjA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Anna, Trond,

Here's a set of patches that converts NFS to use the mount API.  Note that
there are a lot of preliminary patches, some from David and some from Al.
The final patch (the one that does the actual conversion) from the David's
initial posting has been split into 5 separate patches, and the entire set
has been rebased on top of v5.5-rc1.

Changes since v5:
- fixed possible derefence of error pointer in nfs4_validate_fspath()
  reported by Dan Carpenter
- rebased on top of v5.5-rc1
Changes since v4:
- further split the original "NFS: Add fs_context support" patch (new
  patch is about 25% smaller than the v4 patch)
- fixed NFSv4 referral mounts (broken in the original patch)
- fixed leak of nfs_fattr when fs_context is freed
Changes since v3:
- changed license and copyright text in fs/nfs/fs_context.c
Changes since v2:
- fixed the conversion of the nconnect=3D option
- added '#if IS_ENABLED(CONFIG_NFS_V4)' around nfs4_parse_monolithic()
  to avoid unused-function warning when compiling with v4 disabled
Chagnes since v1:
- split up patch 23 into 4 separate patches

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

Scott Mayhew (4):
  NFS: rename nfs_fs_context pointer arg in a few functions
  NFS: Convert mount option parsing to use functionality from
    fs_parser.h
  NFS: Additional refactoring for fs_context conversion
  NFS: Attach supplementary error information to fs_context.

 fs/nfs/Makefile         |    2 +-
 fs/nfs/client.c         |   80 +-
 fs/nfs/fs_context.c     | 1424 +++++++++++++++++++++++++
 fs/nfs/fscache.c        |    2 +-
 fs/nfs/getroot.c        |   73 +-
 fs/nfs/internal.h       |  132 +--
 fs/nfs/namespace.c      |  146 ++-
 fs/nfs/nfs3_fs.h        |    2 +-
 fs/nfs/nfs3client.c     |    6 +-
 fs/nfs/nfs3proc.c       |    2 +-
 fs/nfs/nfs4_fs.h        |    9 +-
 fs/nfs/nfs4client.c     |   99 +-
 fs/nfs/nfs4file.c       |    1 +
 fs/nfs/nfs4namespace.c  |  292 +++---
 fs/nfs/nfs4proc.c       |    2 +-
 fs/nfs/nfs4super.c      |  257 ++---
 fs/nfs/proc.c           |    2 +-
 fs/nfs/super.c          | 2217 +++++----------------------------------
 include/linux/nfs_xdr.h |    9 +-
 19 files changed, 2287 insertions(+), 2470 deletions(-)
 create mode 100644 fs/nfs/fs_context.c

--=20
2.17.2

