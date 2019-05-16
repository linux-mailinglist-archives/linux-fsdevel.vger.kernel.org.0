Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCB34206DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 14:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfEPMZJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 08:25:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:45678 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726955AbfEPMZI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 08:25:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0BEB5ABF3;
        Thu, 16 May 2019 12:25:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9C47F1E3ED6; Thu, 16 May 2019 14:25:06 +0200 (CEST)
Date:   Thu, 16 May 2019 14:25:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/14] Sort out fsnotify_nameremove() mess
Message-ID: <20190516122506.GF13274@quack2.suse.cz>
References: <20190516102641.6574-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516102641.6574-1-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Thu 16-05-19 13:26:27, Amir Goldstein wrote:
> What do you think will be the best merge strategy for this patch series?
> 
> How about sending first 3 prep patches to Linus for applying at the end
> of v5.2 merge window, so individual maintainers can pick up per fs
> patches for the v5.3 development cycle?

I don't think we'll make it for rc1. But those three cleanup patches would
be OK for rc2 as well. But overall patches are not very intrusive so I'm
also OK with pushing the patches myself once we get acks from respective
maintainers if Al will be too busy and won't react.

> The following d_delete() call sites have been audited and will no longer
> generate fsnotify event after this series:
> 
> drivers/usb/gadget/function/f_fs.c:ffs_epfiles_destroy() - cleanup? (*)

Not really but creation events are not generated either.

> fs/ceph/dir.c:ceph_unlink() - from vfs_unlink()
> fs/ceph/inode.c:ceph_fill_trace() - invalidate (**)

There's one more 'invalidate' case in fs/ceph/inode.c.

> fs/configfs/dir.c:detach_groups() - cleanup (*)

Why is this a cleanup? detach_groups() is used also from
configfs_detach_group() which gets called from configfs_rmdir() which is
real deletion.

> fs/configfs/dir.c:configfs_attach_item() - cleanup (*)
> fs/configfs/dir.c:configfs_attach_group() - cleanup (*)
> fs/efivarfs/file.c:efivarfs_file_write() - invalidate (**)
> fs/fuse/dir.c:fuse_reverse_inval_entry() - invalidate (**)
> fs/nfs/dir.c:nfs_dentry_handle_enoent() - invalidate (**)
> fs/nsfs.c:__ns_get_path() - invalidate (**)

More a cleanup case I'd say...

> fs/ocfs2/dlmglue.c:ocfs2_dentry_convert_worker() - invalidate? (**)

This is really invalidate.

> fs/reiserfs/xattr.c:xattr_{unlink,rmdir}() - hidden xattr inode
> 
> (*) There are 2 "cleanup" use cases:
>   - Create;init;delte if init failed
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

Thanks. Maybe for other reviewers it would be more convincing to take
sanitized output of 'git grep "[^a-z_]d_delete("' and annotate how each
callsite is handled - i.e., "cleanup, invalidate, simple_remove, vfs,
manual - patch X". But I'm now reasonably convinced we didn't forget
anything :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
