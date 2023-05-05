Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2767D6F7E6F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 10:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjEEINc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 04:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjEEINa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 04:13:30 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710981634D;
        Fri,  5 May 2023 01:13:29 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QCNgb2Bb0zsR53;
        Fri,  5 May 2023 16:11:39 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 16:13:26 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <dhowells@redhat.com>, <code@tyhicks.com>,
        <hirofumi@mail.parknet.co.jp>, <linkinjeon@kernel.org>,
        <sfrench@samba.org>, <senozhatsky@chromium.org>, <tom@talpey.com>,
        <chuck.lever@oracle.com>, <jlayton@kernel.org>,
        <miklos@szeredi.hu>, <paul@paul-moore.com>, <jmorris@namei.org>,
        <serge@hallyn.com>, <stephen.smalley.work@gmail.com>,
        <eparis@parisplace.org>, <casey@schaufler-ca.com>,
        <dchinner@redhat.com>, <john.johansen@canonical.com>,
        <mcgrof@kernel.org>, <mortonm@chromium.org>, <fred@cloudflare.com>,
        <mic@digikod.net>, <mpe@ellerman.id.au>, <nathanl@linux.ibm.com>,
        <gnoack3000@gmail.com>, <roberto.sassu@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-cachefs@redhat.com>, <ecryptfs@vger.kernel.org>,
        <linux-cifs@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
        <linux-unionfs@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <selinux@vger.kernel.org>,
        <wangweiyang2@huawei.com>
Subject: [PATCH -next 0/2] lsm: Change inode_setattr() to take struct
Date:   Fri, 5 May 2023 16:11:58 +0800
Message-ID: <20230505081200.254449-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I am working on adding xattr/attr support for landlock [1], so we can
control fs accesses such as chmod, chown, uptimes, setxattr, etc.. inside
landlock sandbox. the LSM hooks as following are invoved:
1.inode_setattr
2.inode_setxattr
3.inode_removexattr
4.inode_set_acl
5.inode_remove_acl
which are controlled by LANDLOCK_ACCESS_FS_WRITE_METADATA.

and
1.inode_getattr
2.inode_get_acl
3.inode_getxattr
4.inode_listxattr
which are controlled by LANDLOCK_ACCESS_FS_READ_METADATA

Some of these hooks only take struct dentry as a argument, However, for
path-based LSMs such Landlock, Apparmor and Tomoyo, struct path instead
of struct dentry required to make sense of attr/xattr accesses. So we
need to refactor these hooks to take a struct path argument.

This patchset only refators inode_setattr hook as part of whole work.

Also, I have a problem about file_dentry() in __file_remove_privs() of the
first patch, before changes in commit c1892c37769cf ("vfs: fix deadlock in
file_remove_privs() on overlayfs"), it gets dentry and inode as belows:

struct dentry *dentry = file->f_path.dentry;
struct inode *inode = d_inode(dentry);

That would be clear to change it to pass &file->f_path to
__remove_privs()->notify_change()->inode_setattr().
After that commit, it has been changed to:

struct dentry *dentry = file_dentry(file);
struct inode *inode = file_inode(file);

If I understand correctly, the dentry from file_dentry() maybe the upper
or the lower, it can be different from file->f_path.dentry. It can't just
go back to use &file->f_path otherwise the bug will come back for
overlayfs. So for such scenario, how to get a path from file if the file
maybe or not from overlayfs, and which kind of overlayfs path is ok for
Landlock?

Xiu Jianfeng (2):
  fs: Change notify_change() to take struct path argument
  lsm: Change inode_setattr hook to take struct path argument

 drivers/base/devtmpfs.c       |  5 +++--
 fs/attr.c                     |  7 ++++---
 fs/cachefiles/interface.c     |  4 ++--
 fs/coredump.c                 |  2 +-
 fs/ecryptfs/inode.c           | 18 +++++++++---------
 fs/fat/file.c                 |  2 +-
 fs/inode.c                    |  8 +++++---
 fs/ksmbd/smb2pdu.c            |  6 +++---
 fs/ksmbd/smbacl.c             |  2 +-
 fs/namei.c                    |  2 +-
 fs/nfsd/vfs.c                 | 12 ++++++++----
 fs/open.c                     | 19 ++++++++++---------
 fs/overlayfs/overlayfs.h      |  4 +++-
 fs/utimes.c                   |  2 +-
 include/linux/fs.h            |  4 ++--
 include/linux/lsm_hook_defs.h |  2 +-
 include/linux/security.h      |  4 ++--
 security/security.c           | 10 +++++-----
 security/selinux/hooks.c      |  3 ++-
 security/smack/smack_lsm.c    |  5 +++--
 20 files changed, 67 insertions(+), 54 deletions(-)

-- 
2.17.1

