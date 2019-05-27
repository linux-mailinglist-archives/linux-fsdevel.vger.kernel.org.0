Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3CD42B3C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2019 13:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfE0L7d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 May 2019 07:59:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:43168 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726063AbfE0L7d (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 May 2019 07:59:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5B207AF0A;
        Mon, 27 May 2019 11:59:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 124061E3C2F; Mon, 27 May 2019 13:59:30 +0200 (CEST)
Date:   Mon, 27 May 2019 13:59:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Joel Becker <jlbec@evilplan.org>,
        John Johansen <john.johansen@canonical.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 00/10] Sort out fsnotify_nameremove() mess
Message-ID: <20190527115930.GE20440@quack2.suse.cz>
References: <20190526143411.11244-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526143411.11244-1-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir!

On Sun 26-05-19 17:34:01, Amir Goldstein wrote:
> For v3 I went with a straight forward approach.
> Filesystems that have fsnotify_{create,mkdir} hooks also get
> explicit fsnotify_{unlink,rmdir} hooks.
> 
> Hopefully, this approach is orthogonal to whatever changes Al is
> planning for recursive tree remove code, because in many of the
> cases, the hooks are added at the entry point for the recursive
> tree remove.
> 
> After looking closer at all the filesystems that were converted to
> simple_remove in v2, I decided to exempt another 3 filesystems from
> the fsnotify delete hooks: hypfs,qibfs and aafs.
> hypfs is pure cleanup (*). qibfs and aafs can remove dentry on user
> configuration change, but they do not generate create events, so it
> is less likely that users depend on the delete events.
> 
> That leaves configfs the only filesystem that gets the new delete hooks
> even though it does not have create hooks.

OK, I went through the patches and they look OK to me. So once we get acks
from respective maintainers I think we can merge them.

								Honza

> 
> The following d_delete() call sites have been audited and will no longer
> generate fsnotify event after this series:
> 
> arch/s390/hypfs/inode.c:hypfs_remove() - cleanup (*)
> .../usb/gadget/function/f_fs.c:ffs_epfiles_destroy() - no create events
> .../infiniband/hw/qib/qib_fs.c:remove_device_files() - no create events
> fs/ceph/dir.c:ceph_unlink() - from vfs_unlink()
> fs/ceph/inode.c:ceph_fill_trace() - invalidate (**)
> fs/ceph/inode.c:ceph_readdir_prepopulate() - invalidate (**)
> fs/configfs/dir.c:detach_groups() - hooks added, from vfs or cleanup (*)
> fs/configfs/dir.c:configfs_attach_item() - cleanup (*)
> fs/configfs/dir.c:configfs_attach_group() - cleanup (*)
> fs/efivarfs/file.c:efivarfs_file_write() - invalidate (**)
> fs/fuse/dir.c:fuse_reverse_inval_entry() - invalidate (**)
> fs/nfs/dir.c:nfs_dentry_handle_enoent() - invalidate (**)
> fs/nsfs.c:__ns_get_path() - cleanup (*)
> fs/ocfs2/dlmglue.c:ocfs2_dentry_convert_worker() - invalidate (**)
> fs/reiserfs/xattr.c:xattr_{unlink,rmdir}() - hidden xattr inode
> security/apparmor/apparmorfs.c:aafs_remove() - no create events
> 
> (*) There are 2 "cleanup" use cases:
>   - Create;init;delete if init failed
>   - Batch delete of files within dir before removing dir
>   Both those cases are not interesting for users that wish to observe
>   configuration changes on pseudo filesystems.  Often, there is already
>   an fsnotify event generated on the directory removal which is what
>   users should find interesting, for example:
>   configfs_unregister_{group,subsystem}().
> 
> (**) The different "invalidate" use cases differ, but they all share
>   one thing in common - user is not guarantied to get an event with
>   current kernel.  For example, when a file is deleted remotely on
>   nfs server, nfs client is not guarantied to get an fsnotify delete
>   event.  On current kernel, nfs client could generate an fsnotify
>   delete event if the local entry happens to be in cache and client
>   finds out that entry is deleted on server during another user
>   operation.  Incidentally, this group of use cases is where most of
>   the call sites are with "unstable" d_name, which is the reason for
>   this patch series to begin with.
> 
> Thanks,
> Amir.
> 
> Changes since v2:
> - Drop simple_rename() conversions (add explicit hooks instead)
> - Drop hooks from hypfs/qibfs/aafs
> - Split out debugfs re-factoring patch
> 
> Changes since v1:
> - Split up per filesystem patches
> - New hook names fsnotify_{unlink,rmdir}()
> - Simplify fsnotify code in separate final patch
> 
> Amir Goldstein (10):
>   fsnotify: add empty fsnotify_{unlink,rmdir}() hooks
>   btrfs: call fsnotify_rmdir() hook
>   rpc_pipefs: call fsnotify_{unlink,rmdir}() hooks
>   tracefs: call fsnotify_{unlink,rmdir}() hooks
>   devpts: call fsnotify_unlink() hook
>   debugfs: simplify __debugfs_remove_file()
>   debugfs: call fsnotify_{unlink,rmdir}() hooks
>   configfs: call fsnotify_rmdir() hook
>   fsnotify: move fsnotify_nameremove() hook out of d_delete()
>   fsnotify: get rid of fsnotify_nameremove()
> 
>  fs/afs/dir_silly.c               |  5 ----
>  fs/btrfs/ioctl.c                 |  4 +++-
>  fs/configfs/dir.c                |  3 +++
>  fs/dcache.c                      |  2 --
>  fs/debugfs/inode.c               | 21 ++++++++--------
>  fs/devpts/inode.c                |  1 +
>  fs/namei.c                       |  2 ++
>  fs/nfs/unlink.c                  |  6 -----
>  fs/notify/fsnotify.c             | 41 --------------------------------
>  fs/tracefs/inode.c               |  3 +++
>  include/linux/fsnotify.h         | 26 ++++++++++++++++++++
>  include/linux/fsnotify_backend.h |  4 ----
>  net/sunrpc/rpc_pipe.c            |  4 ++++
>  13 files changed, 52 insertions(+), 70 deletions(-)
> 
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
