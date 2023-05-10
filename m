Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4916FD363
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 02:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbjEJA6Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 20:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjEJA6W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 20:58:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A375E44AB;
        Tue,  9 May 2023 17:58:20 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QGGjw6xnszTkTS;
        Wed, 10 May 2023 08:53:40 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 10 May 2023 08:58:18 +0800
Message-ID: <c6e84076-9134-8c27-75bb-9191da6c23c3@huawei.com>
Date:   Wed, 10 May 2023 08:58:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next 0/2] lsm: Change inode_setattr() to take struct
Content-Language: en-US
From:   xiujianfeng <xiujianfeng@huawei.com>
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
References: <20230505081200.254449-1-xiujianfeng@huawei.com>
In-Reply-To: <20230505081200.254449-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

sorry, I forgot to add the link to preview discussion:

https://lore.kernel.org/all/20220827111215.131442-1-xiujianfeng@huawei.com/

On 2023/5/5 16:11, Xiu Jianfeng wrote:
> Hi,
> 
> I am working on adding xattr/attr support for landlock [1], so we can
> control fs accesses such as chmod, chown, uptimes, setxattr, etc.. inside
> landlock sandbox. the LSM hooks as following are invoved:
> 1.inode_setattr
> 2.inode_setxattr
> 3.inode_removexattr
> 4.inode_set_acl
> 5.inode_remove_acl
> which are controlled by LANDLOCK_ACCESS_FS_WRITE_METADATA.
> 
> and
> 1.inode_getattr
> 2.inode_get_acl
> 3.inode_getxattr
> 4.inode_listxattr
> which are controlled by LANDLOCK_ACCESS_FS_READ_METADATA
> 
> Some of these hooks only take struct dentry as a argument, However, for
> path-based LSMs such Landlock, Apparmor and Tomoyo, struct path instead
> of struct dentry required to make sense of attr/xattr accesses. So we
> need to refactor these hooks to take a struct path argument.
> 
> This patchset only refators inode_setattr hook as part of whole work.
> 
> Also, I have a problem about file_dentry() in __file_remove_privs() of the
> first patch, before changes in commit c1892c37769cf ("vfs: fix deadlock in
> file_remove_privs() on overlayfs"), it gets dentry and inode as belows:
> 
> struct dentry *dentry = file->f_path.dentry;
> struct inode *inode = d_inode(dentry);
> 
> That would be clear to change it to pass &file->f_path to
> __remove_privs()->notify_change()->inode_setattr().
> After that commit, it has been changed to:
> 
> struct dentry *dentry = file_dentry(file);
> struct inode *inode = file_inode(file);
> 
> If I understand correctly, the dentry from file_dentry() maybe the upper
> or the lower, it can be different from file->f_path.dentry. It can't just
> go back to use &file->f_path otherwise the bug will come back for
> overlayfs. So for such scenario, how to get a path from file if the file
> maybe or not from overlayfs, and which kind of overlayfs path is ok for
> Landlock?
> 
> Xiu Jianfeng (2):
>   fs: Change notify_change() to take struct path argument
>   lsm: Change inode_setattr hook to take struct path argument
> 
>  drivers/base/devtmpfs.c       |  5 +++--
>  fs/attr.c                     |  7 ++++---
>  fs/cachefiles/interface.c     |  4 ++--
>  fs/coredump.c                 |  2 +-
>  fs/ecryptfs/inode.c           | 18 +++++++++---------
>  fs/fat/file.c                 |  2 +-
>  fs/inode.c                    |  8 +++++---
>  fs/ksmbd/smb2pdu.c            |  6 +++---
>  fs/ksmbd/smbacl.c             |  2 +-
>  fs/namei.c                    |  2 +-
>  fs/nfsd/vfs.c                 | 12 ++++++++----
>  fs/open.c                     | 19 ++++++++++---------
>  fs/overlayfs/overlayfs.h      |  4 +++-
>  fs/utimes.c                   |  2 +-
>  include/linux/fs.h            |  4 ++--
>  include/linux/lsm_hook_defs.h |  2 +-
>  include/linux/security.h      |  4 ++--
>  security/security.c           | 10 +++++-----
>  security/selinux/hooks.c      |  3 ++-
>  security/smack/smack_lsm.c    |  5 +++--
>  20 files changed, 67 insertions(+), 54 deletions(-)
> 
