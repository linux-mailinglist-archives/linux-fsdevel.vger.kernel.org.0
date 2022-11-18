Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F49062F4D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 13:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241449AbiKRMd1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 07:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbiKRMdD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:33:03 -0500
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fa8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2638F38D
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 04:33:02 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NDGQh4vjczMpnpq;
        Fri, 18 Nov 2022 13:33:00 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4NDGQg6Qvkzxl;
        Fri, 18 Nov 2022 13:32:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1668774780;
        bh=CFYmjkAvWi62WPgxaIl/0kh2OI+R++JZUJxQqondiZM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rXqeWXOGKm7I9JDpXZ6rl5ExIhj8/05bb4IpegsuJvtqla9oNc0uZB0sXmvQe8i0R
         tAmVTU7rVelsRDIYEmkU6f3pA79xJ+L4ppM6CDlApiBLIuMjhXJXaMe2GIuazVVVUe
         FZyyKkzXGyIBudYnKLlI6Hqhlxjtr3lwQJs74fjQ=
Message-ID: <7dc782cb-88f8-8519-cd8a-9f89847a3134@digikod.net>
Date:   Fri, 18 Nov 2022 13:32:59 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v5 02/30] fs: pass dentry to set acl method
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        xiujianfeng <xiujianfeng@huawei.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
References: <20221018115700.166010-1-brauner@kernel.org>
 <20221018115700.166010-3-brauner@kernel.org>
 <42f5923d-5e47-68d5-20a6-4b5342a9bd19@digikod.net>
 <20221118103346.xvnf5tejbahogfe4@wittgenstein>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20221118103346.xvnf5tejbahogfe4@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 18/11/2022 11:33, Christian Brauner wrote:
> On Fri, Nov 18, 2022 at 11:09:20AM +0100, Mickaël Salaün wrote:
>> Hi Christian,
>>
>> We are working on updating the security_inode_*attr LSM hooks to use path
>> instead of inode [1]. Indeed, this is required for path-based LSMs such as
>> Landlock, AppArmor and Tomoyo to make sense of attr/xattr accesses. Could
>> you please update this new ACL API to use struct path instead of struct
>> dentry?
> 
> Hey Michael,
> 
> These patches have been sitting in -next since -rc1 and we are at -rc6
> this weekend so this request is too late for the coming merge window. We
> can't do a fundamental change this late. I would ask you to please do
> these changes in a separate series next cycle. And this will need a
> separate discussion among the LSM people and VFS reviews anyway.

Of course, I didn't realize this series was in -next. Please take a look 
at my proposal in the other thread. Thanks.

> 
> Thanks!
> Christian
> 
>>
>> [1]
>> https://lore.kernel.org/all/1373bbe5-16b1-bf0e-5f92-14c31cb94897@huawei.com/
>>
>>
>> On 18/10/2022 13:56, Christian Brauner wrote:
>>> The current way of setting and getting posix acls through the generic
>>> xattr interface is error prone and type unsafe. The vfs needs to
>>> interpret and fixup posix acls before storing or reporting it to
>>> userspace. Various hacks exist to make this work. The code is hard to
>>> understand and difficult to maintain in it's current form. Instead of
>>> making this work by hacking posix acls through xattr handlers we are
>>> building a dedicated posix acl api around the get and set inode
>>> operations. This removes a lot of hackiness and makes the codepaths
>>> easier to maintain. A lot of background can be found in [1].
>>>
>>> Since some filesystem rely on the dentry being available to them when
>>> setting posix acls (e.g., 9p and cifs) they cannot rely on set acl inode
>>> operation. But since ->set_acl() is required in order to use the generic
>>> posix acl xattr handlers filesystems that do not implement this inode
>>> operation cannot use the handler and need to implement their own
>>> dedicated posix acl handlers.
>>>
>>> Update the ->set_acl() inode method to take a dentry argument. This
>>> allows all filesystems to rely on ->set_acl().
>>>
>>> As far as I can tell all codepaths can be switched to rely on the dentry
>>> instead of just the inode. Note that the original motivation for passing
>>> the dentry separate from the inode instead of just the dentry in the
>>> xattr handlers was because of security modules that call
>>> security_d_instantiate(). This hook is called during
>>> d_instantiate_new(), d_add(), __d_instantiate_anon(), and
>>> d_splice_alias() to initialize the inode's security context and possibly
>>> to set security.* xattrs. Since this only affects security.* xattrs this
>>> is completely irrelevant for posix acls.
>>>
>>> Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
>>> ---
>>>
>>> Notes:
>>>       /* v2 */
>>>       Christoph Hellwig <hch@lst.de>:
>>>       - Split orangefs into a preparatory patch.
>>>       /* v3 */
>>>       unchanged
>>>       /* v4 */
>>>       unchanged
>>>       /* v5 */
>>>       unchanged
>>>
>>>    Documentation/filesystems/vfs.rst |  2 +-
>>>    fs/bad_inode.c                    |  2 +-
>>>    fs/btrfs/acl.c                    |  3 ++-
>>>    fs/btrfs/ctree.h                  |  2 +-
>>>    fs/btrfs/inode.c                  |  2 +-
>>>    fs/ceph/acl.c                     |  3 ++-
>>>    fs/ceph/inode.c                   |  2 +-
>>>    fs/ceph/super.h                   |  2 +-
>>>    fs/ext2/acl.c                     |  3 ++-
>>>    fs/ext2/acl.h                     |  2 +-
>>>    fs/ext2/inode.c                   |  2 +-
>>>    fs/ext4/acl.c                     |  3 ++-
>>>    fs/ext4/acl.h                     |  2 +-
>>>    fs/ext4/inode.c                   |  2 +-
>>>    fs/f2fs/acl.c                     |  4 +++-
>>>    fs/f2fs/acl.h                     |  2 +-
>>>    fs/f2fs/file.c                    |  2 +-
>>>    fs/fuse/acl.c                     |  3 ++-
>>>    fs/fuse/fuse_i.h                  |  2 +-
>>>    fs/gfs2/acl.c                     |  3 ++-
>>>    fs/gfs2/acl.h                     |  2 +-
>>>    fs/gfs2/inode.c                   |  2 +-
>>>    fs/jffs2/acl.c                    |  3 ++-
>>>    fs/jffs2/acl.h                    |  2 +-
>>>    fs/jffs2/fs.c                     |  2 +-
>>>    fs/jfs/acl.c                      |  3 ++-
>>>    fs/jfs/file.c                     |  2 +-
>>>    fs/jfs/jfs_acl.h                  |  2 +-
>>>    fs/ksmbd/smb2pdu.c                |  4 ++--
>>>    fs/ksmbd/smbacl.c                 |  4 ++--
>>>    fs/ksmbd/vfs.c                    | 15 ++++++++-------
>>>    fs/ksmbd/vfs.h                    |  4 ++--
>>>    fs/nfs/nfs3_fs.h                  |  2 +-
>>>    fs/nfs/nfs3acl.c                  |  3 ++-
>>>    fs/nfsd/nfs2acl.c                 |  4 ++--
>>>    fs/nfsd/nfs3acl.c                 |  4 ++--
>>>    fs/nfsd/vfs.c                     |  4 ++--
>>>    fs/ntfs3/file.c                   |  2 +-
>>>    fs/ntfs3/ntfs_fs.h                |  4 ++--
>>>    fs/ntfs3/xattr.c                  |  9 +++++----
>>>    fs/ocfs2/acl.c                    |  3 ++-
>>>    fs/ocfs2/acl.h                    |  2 +-
>>>    fs/orangefs/acl.c                 |  5 +++--
>>>    fs/orangefs/inode.c               |  7 ++++---
>>>    fs/orangefs/orangefs-kernel.h     |  4 ++--
>>>    fs/posix_acl.c                    | 18 +++++++++++-------
>>>    fs/reiserfs/acl.h                 |  6 +++---
>>>    fs/reiserfs/inode.c               |  2 +-
>>>    fs/reiserfs/xattr_acl.c           |  9 ++++++---
>>>    fs/xfs/xfs_acl.c                  |  3 ++-
>>>    fs/xfs/xfs_acl.h                  |  2 +-
>>>    fs/xfs/xfs_iops.c                 | 10 ++++++----
>>>    include/linux/fs.h                |  2 +-
>>>    include/linux/posix_acl.h         | 12 ++++++------
>>>    mm/shmem.c                        |  2 +-
>>>    55 files changed, 119 insertions(+), 93 deletions(-)
