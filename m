Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B180130468
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2020 21:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgADUkI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jan 2020 15:40:08 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48108 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726118AbgADUkH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jan 2020 15:40:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BD31F8EE0CE;
        Sat,  4 Jan 2020 12:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1578170406;
        bh=KHDsJqFu40CMbKCPiOUzv5iPnDdd1fMDH1mGeefbPvI=;
        h=From:To:Cc:Subject:Date:From;
        b=MG9Q5mhA75rma962htcOkWUMZCTIK00FOJf0enIXtQkQNcb7LBLV9Yk8oAwIuq9bG
         pXUJJ9LozTDBvDhnTy94r1EU8zXE92/vWlBHP+dm2VffcUiOr1TOnzQyWMohSxjqdk
         +FI+LwPoygAYZbuJmBDE39QJxPOT0OrMXTkwtV+g=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 51-kfvigumKl; Sat,  4 Jan 2020 12:40:06 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 009838EE079;
        Sat,  4 Jan 2020 12:40:05 -0800 (PST)
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
        containers@lists.linux-foundation.org
Subject: [PATCH v2 0/3] introduce a uid/gid shifting bind mount
Date:   Sat,  4 Jan 2020 12:39:43 -0800
Message-Id: <20200104203946.27914-1-James.Bottomley@HansenPartnership.com>
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

The only real change from v1 is that the notify_change patch is
updated to fix the issues pointed out by Amir Goldstein.  And I've
combined the precursor patch to rethread notify_changes into the
series.

James

---

James Bottomley (3):
  fs: rethread notify_change to take a path instead of a dentry
  fs: introduce uid/gid shifting bind mount
  fs: expose shifting bind mount to userspace

 drivers/base/devtmpfs.c   |   8 +++-
 fs/attr.c                 |  91 ++++++++++++++++++++++++++++----------
 fs/bind.c                 |  35 +++++++++++++++
 fs/cachefiles/interface.c |   6 ++-
 fs/coredump.c             |   4 +-
 fs/ecryptfs/inode.c       |   9 ++--
 fs/exec.c                 |   7 ++-
 fs/inode.c                |  16 ++++---
 fs/internal.h             |   2 +
 fs/mount.h                |   2 +
 fs/namei.c                | 110 ++++++++++++++++++++++++++++++++++++++--------
 fs/namespace.c            |   1 +
 fs/nfsd/vfs.c             |  13 +++---
 fs/open.c                 |  44 ++++++++++++++-----
 fs/overlayfs/copy_up.c    |  40 ++++++++++-------
 fs/overlayfs/dir.c        |  10 ++++-
 fs/overlayfs/inode.c      |   6 ++-
 fs/overlayfs/overlayfs.h  |   2 +-
 fs/overlayfs/super.c      |   3 +-
 fs/posix_acl.c            |   4 +-
 fs/proc_namespace.c       |   4 ++
 fs/stat.c                 |  31 +++++++++++--
 fs/utimes.c               |   2 +-
 include/linux/cred.h      |  10 +++++
 include/linux/fs.h        |   6 +--
 include/linux/mount.h     |   4 +-
 include/linux/sched.h     |   5 +++
 kernel/capability.c       |  14 +++++-
 kernel/cred.c             |  20 +++++++++
 kernel/groups.c           |   7 +++
 30 files changed, 408 insertions(+), 108 deletions(-)

-- 
2.16.4

