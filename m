Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D611161C85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 21:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgBQU4i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 15:56:38 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37720 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727332AbgBQU4i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 15:56:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 380FF8EE34A;
        Mon, 17 Feb 2020 12:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581972997;
        bh=gbw1NsmQki3RTMqYz4DXbtFgXdTnldljtyqEXrpO7YY=;
        h=From:To:Cc:Subject:Date:From;
        b=iJRSRmkaUKgpgcW8k84qMh8fRhhKO27eZ6p1mbC/x7QUNPmwtEkuJLG52uEkaPTdt
         dUjGGsgCvX8wj3SZCIXCLXNxLNd5ikqZN6dEDO8k94+43IMFAgF7gF+v9bTsUr4dZ/
         YZbHg+ZPznKlw6Ttn3MWhezmHOAYXj4JXiKnIFK4=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 66YD1Rp0BFZj; Mon, 17 Feb 2020 12:56:37 -0800 (PST)
Received: from jarvis.lan (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 633CE8EE0F5;
        Mon, 17 Feb 2020 12:56:36 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        linux-unionfs@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tycho Andersen <tycho@tycho.ws>,
        containers@lists.linux-foundation.org
Subject: [PATCH v3 0/3] introduce a uid/gid shifting bind mount
Date:   Mon, 17 Feb 2020 12:53:04 -0800
Message-Id: <20200217205307.32256-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The object of this series is to replace shiftfs with a proper uid/gid
shifting bind mount instead of the shiftfs hack of introducing
something that looks similar to an overlay filesystem to do it.

The VFS still has the problem that in order to tell what vfsmount a
dentry belongs to, struct path would have to be threaded everywhere
struct dentry currently is.  However, this patch is structured only to
require a rethreading of notify_change.  The rest of the knowledge
that a shift is in operation is carried in the task structure by
caching the unshifted credentials.

Note that although it is currently dependent on the new configfd
interface for bind mounts, only patch 3/3 relies on this, and the
whole thing could be redone as a syscall or any other mechanism
(depending on how people eventually want to fix the problem with the
new fsconfig mechanism being unable to reconfigure bind mounts).

The changes from v2 are I've added Amir's reviewed-by for the
notify_change rethreading and I've implemented Serge's request for a
base offset shift for the image.  It turned out to be much harder to
implement a simple linear shift than simply to do it through a
different userns, so that's how I've done it.  The userns you need to
set up for the offset shifted image is one where the interior uid
would see the shifted image as fake root.  I've introduced an
additional "ns" config parameter, which must be specified when
building the allow shift mount point (so it's done by the admin, not
by the unprivileged user).  I've also taken care that the image
shifted to zero (real root) is never visible in the filesystem.  Patch
3/3 explains how to use the additional "ns" parameter.

James

---

James Bottomley (3):
  fs: rethread notify_change to take a path instead of a dentry
  fs: introduce uid/gid shifting bind mount
  fs: expose shifting bind mount to userspace

 drivers/base/devtmpfs.c   |   8 ++-
 fs/attr.c                 | 131 ++++++++++++++++++++++++++++++++++++++--------
 fs/bind.c                 | 105 +++++++++++++++++++++++++++++++++----
 fs/cachefiles/interface.c |   6 ++-
 fs/coredump.c             |   4 +-
 fs/ecryptfs/inode.c       |   9 ++--
 fs/exec.c                 |   3 +-
 fs/inode.c                |  17 +++---
 fs/internal.h             |   2 +
 fs/mount.h                |   3 ++
 fs/namei.c                | 114 +++++++++++++++++++++++++++++++++-------
 fs/namespace.c            |   6 +++
 fs/nfsd/vfs.c             |  13 +++--
 fs/open.c                 |  44 ++++++++++++----
 fs/overlayfs/copy_up.c    |  40 ++++++++------
 fs/overlayfs/dir.c        |  10 +++-
 fs/overlayfs/inode.c      |   6 ++-
 fs/overlayfs/overlayfs.h  |   2 +-
 fs/overlayfs/super.c      |   3 +-
 fs/posix_acl.c            |   4 +-
 fs/proc_namespace.c       |   4 ++
 fs/stat.c                 |  32 +++++++++--
 fs/utimes.c               |   2 +-
 include/linux/cred.h      |  12 +++++
 include/linux/fs.h        |   7 ++-
 include/linux/mount.h     |   4 +-
 include/linux/sched.h     |   5 ++
 kernel/capability.c       |   9 +++-
 kernel/cred.c             |  20 +++++++
 29 files changed, 507 insertions(+), 118 deletions(-)

-- 
2.16.4

