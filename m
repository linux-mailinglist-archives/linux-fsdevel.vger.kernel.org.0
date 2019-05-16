Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0868B20359
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 12:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfEPK04 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 06:26:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52728 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfEPK0z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 06:26:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id y3so3042146wmm.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 03:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cPdn+EZbCmqzwXp1LeUmfoWXB+C+YJ65+q4Y4POd+Ic=;
        b=ghnyG4Qg7rIDNbljhthqXgVRiRbAnhhbIRFykieS4icq3nQ4YZdUdnGjzvk+bsw9fq
         8HdxkOFlPALHzW1m87CjHoGp1nF4CsGVsFPEHxF/45gyUQgbOUc9H8WkK23Pdjn1yRn7
         KJXDlRFKx6MGB/OXOi/Nw0ruo/pr8RXrYfWFP4d9WxRvKASRXqX3U2PXf5/fYoAiERBO
         szZOktWpL5uWkkhUfPjeCh+qnCjq/MKm7vM7+Jx2nhEPqOwpe/5d52I9v+2d7NdbJ5O+
         2L8CLVBVeWEM4g7EVFWj8W1QvbhEt4Od811P+uYhJZ3kW/JIUBXqD3O7+DY8EaCk4iUs
         Q1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cPdn+EZbCmqzwXp1LeUmfoWXB+C+YJ65+q4Y4POd+Ic=;
        b=gq8mJHo4hRMCe4BeNiZ2pBUGJkiVGAaac0ot/JiXXXxVDzhgB3EXy+9zBgeqHLMYfL
         1ZUe3vYkaDEKFb6yBOxCoIkcHuQJjwhMtWL+LpAwQfy6oBIztqQHIU7xmWD8EFSvjNfD
         ptlluVEovvi+6HJnlVtQtKhV834O3m2cF55mnV7tAX5cRgNXfjLMR8zkI/UV2XDsa7Bw
         vcWhMhO5myMZt7DJV7dPZn49htY/P0CGkpoGid7JJzdM1LsdW7mfkoR929LYxH6TCjjM
         6q6/GjDZgfvusni/uRtCtjEtCBwjngKSt4WVwQ2VnC5nNtq86RSkNgrifpQObYbPv5L7
         ZGpQ==
X-Gm-Message-State: APjAAAV7UwphhNh1lMSmim5fGinM/RsPkqQvkoh9UgtHFXxmTpwo1B1F
        gUwMVsOwKM4k+yL0H4kO+UDRMbWu
X-Google-Smtp-Source: APXvYqzjHCaUlE83syGTcAX7NMYMe/Uz9DFZsX4R6vfPvwf7VbvOmnneYPgEqfVTrfsi5izNGpvMFg==
X-Received: by 2002:a7b:cb48:: with SMTP id v8mr9092308wmj.108.1558002413324;
        Thu, 16 May 2019 03:26:53 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id d72sm4506299wmd.12.2019.05.16.03.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 03:26:52 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 00/14] Sort out fsnotify_nameremove() mess
Date:   Thu, 16 May 2019 13:26:27 +0300
Message-Id: <20190516102641.6574-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan,

What do you think will be the best merge strategy for this patch series?

How about sending first 3 prep patches to Linus for applying at the end
of v5.2 merge window, so individual maintainers can pick up per fs
patches for the v5.3 development cycle?

The following d_delete() call sites have been audited and will no longer
generate fsnotify event after this series:

drivers/usb/gadget/function/f_fs.c:ffs_epfiles_destroy() - cleanup? (*)
fs/ceph/dir.c:ceph_unlink() - from vfs_unlink()
fs/ceph/inode.c:ceph_fill_trace() - invalidate (**)
fs/configfs/dir.c:detach_groups() - cleanup (*)
fs/configfs/dir.c:configfs_attach_item() - cleanup (*)
fs/configfs/dir.c:configfs_attach_group() - cleanup (*)
fs/efivarfs/file.c:efivarfs_file_write() - invalidate (**)
fs/fuse/dir.c:fuse_reverse_inval_entry() - invalidate (**)
fs/nfs/dir.c:nfs_dentry_handle_enoent() - invalidate (**)
fs/nsfs.c:__ns_get_path() - invalidate (**)
fs/ocfs2/dlmglue.c:ocfs2_dentry_convert_worker() - invalidate? (**)
fs/reiserfs/xattr.c:xattr_{unlink,rmdir}() - hidden xattr inode

(*) There are 2 "cleanup" use cases:
  - Create;init;delte if init failed
  - Batch delete of files within dir before removing dir
  Both those cases are not interesting for users that wish to observe
  configuration changes on pseudo filesystems.  Often, there is already
  an fsnotify event generated on the directory removal which is what
  users should find interesting, for example:
  configfs_unregister_{group,subsystem}().

(**) The different "invalidate" use cases differ, but they all share
  one thing in common - user is not guarantied to get an event with
  current kernel.  For example, when a file is deleted remotely on
  nfs server, nfs client is not guarantied to get an fsnotify delete
  event.  On current kernel, nfs client could generate an fsnotify
  delete event if the local entry happens to be in cache and client
  finds out that entry is deleted on server during another user
  operation.  Incidentally, this group of use cases is where most of
  the call sites are with "unstable" d_name, which is the reason for
  this patch series to begin with.

Thanks,
Amir.

Changes since v1:
- Split up per filesystem patches
- New hook names fsnotify_{unlink,rmdir}()
- Simplify fsnotify code in separate final patch

Amir Goldstein (14):
  ASoC: rename functions that pollute the simple_xxx namespace
  fs: create simple_remove() helper
  fsnotify: add empty fsnotify_{unlink,rmdir}() hooks
  fs: convert hypfs to use simple_remove() helper
  fs: convert qibfs/ipathfs to use simple_remove() helper
  fs: convert debugfs to use simple_remove() helper
  fs: convert tracefs to use simple_remove() helper
  fs: convert rpc_pipefs to use simple_remove() helper
  fs: convert apparmorfs to use simple_remove() helper
  fsnotify: call fsnotify_rmdir() hook from btrfs
  fsnotify: call fsnotify_rmdir() hook from configfs
  fsnotify: call fsnotify_unlink() hook from devpts
  fsnotify: move fsnotify_nameremove() hook out of d_delete()
  fsnotify: get rid of fsnotify_nameremove()

 arch/s390/hypfs/inode.c            |  9 ++-----
 drivers/infiniband/hw/qib/qib_fs.c |  3 +--
 fs/afs/dir_silly.c                 |  5 ----
 fs/btrfs/ioctl.c                   |  4 ++-
 fs/configfs/dir.c                  |  3 +++
 fs/dcache.c                        |  2 --
 fs/debugfs/inode.c                 | 20 +++------------
 fs/devpts/inode.c                  |  1 +
 fs/libfs.c                         | 32 +++++++++++++++++++++++
 fs/namei.c                         |  2 ++
 fs/nfs/unlink.c                    |  6 -----
 fs/notify/fsnotify.c               | 41 ------------------------------
 fs/tracefs/inode.c                 | 23 +++--------------
 include/linux/fs.h                 |  1 +
 include/linux/fsnotify.h           | 26 +++++++++++++++++++
 include/linux/fsnotify_backend.h   |  4 ---
 net/sunrpc/rpc_pipe.c              | 16 ++----------
 security/apparmor/apparmorfs.c     |  6 +----
 sound/soc/generic/simple-card.c    |  8 +++---
 19 files changed, 86 insertions(+), 126 deletions(-)

-- 
2.17.1

