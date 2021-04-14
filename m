Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3583235F3FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 14:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbhDNMi4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 08:38:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231415AbhDNMiz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:38:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E73D461153;
        Wed, 14 Apr 2021 12:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618403914;
        bh=1TD9/TCQYmZzBhGw1jfEw20UU1RbacQnuSHoHjJfJ3w=;
        h=From:To:Cc:Subject:Date:From;
        b=XokrYGrMP+N+PSiDGMIAAxF50Jsk0f4AmpdeCIOrENRU0OckjJrpOmNql9PSMGeIp
         mT2KzWJ4a8N5uZacwGcqWpUGVFmjflaLeafJ4OeSPsuCWbLS/jLFxLLouM646fkkw1
         u/ChWI4DfdzqS1ZHRmQ73wN9T+VXXQ+7tfh/aanvU/HBW347k144vv4kXVwBAnhDXS
         QyNSH6Q1wAr08CNVsfhXCfBHBJLTYXVAahPP3YLhEM8NRX0T+5Bn03c5i/Ob0LFKE4
         z4tiBBdUOjQSEnz5LcEqPbH4AozDv2NgFe2aPDEM4rkGP+QytbLVePqylUfgSMDx2s
         qUbVGNXZmJZxw==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Tyler Hicks <code@tyhicks.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org,
        linux-cachefs@redhat.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 0/7] fs: tweak and switch more fses to private mounts
Date:   Wed, 14 Apr 2021 14:37:44 +0200
Message-Id: <20210414123750.2110159-1-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Hey,

Since [1] we support creating private mounts from a given path's
vfsmount. This makes them very suitable for any filesystem or
filesystem functionality that piggybacks on paths of another filesystem.
Overlayfs, cachefiles, and ecryptfs are three prime examples.

Since private mounts aren't attached in the filesystem they aren't
affected by mount property changes after the respective fs makes use of
them. This seems a rather desirable property as the underlying path
can't e.g. suddenly go from read-write to read-only and in general it
means that the fs is always in full control of the underlying mount
after the user has allowed it to be used (apart from operations that
affect the superblock of course).

Besides that it also makes things simpler for a variety of other vfs
features. One concrete example is fanotify. When the path->mnt of the
path that is used as a cache has been marked with FAN_MARK_MOUNT the
semantics get tricky as it isn't clear whether the watchers of path->mnt
should get notified about fsnotify events when files are created by
ecryptfs via path->mnt. Using a private mount lets us handle this case
too and aligns the behavior of stacks created by overlayfs.

Thanks!
Christian

[1]: c771d683a62e ("vfs: introduce clone_private_mount()")

Christian Brauner (7):
  namespace: fix clone_private_mount() kernel doc
  namespace: add kernel doc for mnt_clone_internal()
  namespace: move unbindable check out of clone_private_mount()
  cachefiles: switch to using a private mount
  cachefiles: extend ro check to private mount
  ecryptfs: switch to using a private mount
  ecryptfs: extend ro check to private mount

 fs/cachefiles/bind.c          | 41 +++++++++++++++++++++++++----------
 fs/ecryptfs/dentry.c          |  6 ++++-
 fs/ecryptfs/ecryptfs_kernel.h |  9 ++++++++
 fs/ecryptfs/inode.c           |  5 ++++-
 fs/ecryptfs/main.c            | 31 +++++++++++++++++++++-----
 fs/namespace.c                | 36 ++++++++++++++++++++++++------
 fs/overlayfs/super.c          | 13 +++++++++--
 7 files changed, 113 insertions(+), 28 deletions(-)


base-commit: e49d033bddf5b565044e2abe4241353959bc9120
-- 
2.27.0

