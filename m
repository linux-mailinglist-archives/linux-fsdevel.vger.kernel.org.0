Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 176542AA3F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2019 16:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfEZOeX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 May 2019 10:34:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34682 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbfEZOeX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 May 2019 10:34:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id f8so14344247wrt.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 May 2019 07:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QCqLUEqmBt5yL1ztx19FzOehF6EwgHnPNx//SH8OfWg=;
        b=j79iHjU/Be1qUU7wRnEGMj2k5KEFUzJBdMSXdyRBpX/2Ddbthba/EBtb1Z1Y1vYtD9
         ZhN7AaE8BgY4Q/PgvsU+ZGdxNtT7hGs28hSTGc+g4kzAVW1Ttg8dYVD9NQZWj7/JEV73
         4COCkJ3NfebhnvZzwewHW7vgJuAd4fjCEG1iktqkWHvD3mZtOVuYqcUTIhbDKveDaqrD
         US3ujT7056VIjsV4VYE7IWLBAJn2KIUi/lximJY0CCk1Olw/P/FNiEM+1FBaTGguPmfE
         6Ee7Bsz7vDTv2wxBdfVURFG411BAURwSKcnFufiRIkMK8/R3VPDoRLn0wvAOGTeMBqOw
         eCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QCqLUEqmBt5yL1ztx19FzOehF6EwgHnPNx//SH8OfWg=;
        b=U8lAiRX2/KaRC1mfbxGtfjVekGSvOkuMzipNrkim3H/wspdq4vIsmFDCGPUL3yVjJ9
         dnMY+m8EZ2d0ry2rwUjrIwGENpI6UjjBN7idXNFBqVS8iQns2co2GXgSmutgulHLTrZE
         gG6Hc/S4loLT7iF6WaNKkqZw6F67+/fOcMVQz01XslANR+XOzPjbHyVO+ThT2Va8MThy
         HAMRr5/EtuHnsS5v3IHQBlDJlA31aYpHGVAYLs6rcA52MJbybZr3nvHwPbOUUGyMI7S1
         4gt5Zc49F+xU1Yug0ctQrJ5EWORyqRGCmQDrTJWIyqc7Cd8a9/qxnTA/6N72uklRFgHZ
         9DiQ==
X-Gm-Message-State: APjAAAVcEr6Y6dFXRpmDvP3/nPcPHv1AQPMrmZhB8vkzeUKkt/8JWpw2
        +rViKKNH3L2Cbjaz1KHI2pg=
X-Google-Smtp-Source: APXvYqyaKzTAW6zj4XvNwdY3DuiisQEoEjZc4oa5Wp13Iz/MJxntNs703dfAvmlAQxV1BApzoaHAfg==
X-Received: by 2002:adf:d84e:: with SMTP id k14mr5444742wrl.76.1558881260872;
        Sun, 26 May 2019 07:34:20 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id t13sm21144146wra.81.2019.05.26.07.34.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 07:34:20 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     David Sterba <dsterba@suse.com>, Christoph Hellwig <hch@lst.de>,
        Joel Becker <jlbec@evilplan.org>,
        John Johansen <john.johansen@canonical.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 00/10] Sort out fsnotify_nameremove() mess
Date:   Sun, 26 May 2019 17:34:01 +0300
Message-Id: <20190526143411.11244-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan,

For v3 I went with a straight forward approach.
Filesystems that have fsnotify_{create,mkdir} hooks also get
explicit fsnotify_{unlink,rmdir} hooks.

Hopefully, this approach is orthogonal to whatever changes Al is
planning for recursive tree remove code, because in many of the
cases, the hooks are added at the entry point for the recursive
tree remove.

After looking closer at all the filesystems that were converted to
simple_remove in v2, I decided to exempt another 3 filesystems from
the fsnotify delete hooks: hypfs,qibfs and aafs.
hypfs is pure cleanup (*). qibfs and aafs can remove dentry on user
configuration change, but they do not generate create events, so it
is less likely that users depend on the delete events.

That leaves configfs the only filesystem that gets the new delete hooks
even though it does not have create hooks.

The following d_delete() call sites have been audited and will no longer
generate fsnotify event after this series:

arch/s390/hypfs/inode.c:hypfs_remove() - cleanup (*)
.../usb/gadget/function/f_fs.c:ffs_epfiles_destroy() - no create events
.../infiniband/hw/qib/qib_fs.c:remove_device_files() - no create events
fs/ceph/dir.c:ceph_unlink() - from vfs_unlink()
fs/ceph/inode.c:ceph_fill_trace() - invalidate (**)
fs/ceph/inode.c:ceph_readdir_prepopulate() - invalidate (**)
fs/configfs/dir.c:detach_groups() - hooks added, from vfs or cleanup (*)
fs/configfs/dir.c:configfs_attach_item() - cleanup (*)
fs/configfs/dir.c:configfs_attach_group() - cleanup (*)
fs/efivarfs/file.c:efivarfs_file_write() - invalidate (**)
fs/fuse/dir.c:fuse_reverse_inval_entry() - invalidate (**)
fs/nfs/dir.c:nfs_dentry_handle_enoent() - invalidate (**)
fs/nsfs.c:__ns_get_path() - cleanup (*)
fs/ocfs2/dlmglue.c:ocfs2_dentry_convert_worker() - invalidate (**)
fs/reiserfs/xattr.c:xattr_{unlink,rmdir}() - hidden xattr inode
security/apparmor/apparmorfs.c:aafs_remove() - no create events

(*) There are 2 "cleanup" use cases:
  - Create;init;delete if init failed
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

Changes since v2:
- Drop simple_rename() conversions (add explicit hooks instead)
- Drop hooks from hypfs/qibfs/aafs
- Split out debugfs re-factoring patch

Changes since v1:
- Split up per filesystem patches
- New hook names fsnotify_{unlink,rmdir}()
- Simplify fsnotify code in separate final patch

Amir Goldstein (10):
  fsnotify: add empty fsnotify_{unlink,rmdir}() hooks
  btrfs: call fsnotify_rmdir() hook
  rpc_pipefs: call fsnotify_{unlink,rmdir}() hooks
  tracefs: call fsnotify_{unlink,rmdir}() hooks
  devpts: call fsnotify_unlink() hook
  debugfs: simplify __debugfs_remove_file()
  debugfs: call fsnotify_{unlink,rmdir}() hooks
  configfs: call fsnotify_rmdir() hook
  fsnotify: move fsnotify_nameremove() hook out of d_delete()
  fsnotify: get rid of fsnotify_nameremove()

 fs/afs/dir_silly.c               |  5 ----
 fs/btrfs/ioctl.c                 |  4 +++-
 fs/configfs/dir.c                |  3 +++
 fs/dcache.c                      |  2 --
 fs/debugfs/inode.c               | 21 ++++++++--------
 fs/devpts/inode.c                |  1 +
 fs/namei.c                       |  2 ++
 fs/nfs/unlink.c                  |  6 -----
 fs/notify/fsnotify.c             | 41 --------------------------------
 fs/tracefs/inode.c               |  3 +++
 include/linux/fsnotify.h         | 26 ++++++++++++++++++++
 include/linux/fsnotify_backend.h |  4 ----
 net/sunrpc/rpc_pipe.c            |  4 ++++
 13 files changed, 52 insertions(+), 70 deletions(-)

-- 
2.17.1

