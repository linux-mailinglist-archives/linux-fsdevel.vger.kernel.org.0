Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9187208B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 15:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfEPN4d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 09:56:33 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37840 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfEPN4c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 09:56:32 -0400
Received: by mail-yw1-f67.google.com with SMTP id 186so1387710ywo.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 06:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q5Y8+wpE7JtsH9CqWjfoEfP3kf3jl1ZIZBWX0Kpy9mQ=;
        b=m5Gz40HvxkODN/c3NALN1CyUHONjGLsIJEKnWM0RZoyvYsSBYwDrUb4dE3ZnPRfef0
         7D+KDVF+TK0IYGtg4bJzCK7BP+aOzf5GFdoqyv/hC9GGAht28N12kScAzEYlrN8YhyT9
         +60AuKhLvelTGUWsYezMto0B0k7IXe/iyuYHwpT+K2Ou6djORUg9IS42SY/VIfHsWM8l
         1ZvZLxLy+2Mb3EwPwUvm3X3M6RPoheuuv4zMnfjS+GAYbhh7geqFg/HaFYrRIJIcRLVz
         dxCj3CcxQV8M4J3ij9WcG6WYWK/lYuH5ClmgvNNNY25nG4sVnwcQXkihx2A3dIKOrzGM
         +6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q5Y8+wpE7JtsH9CqWjfoEfP3kf3jl1ZIZBWX0Kpy9mQ=;
        b=EA1ZFFtIbs9l/m+F+s2D6PastJQLDhEpN4OycDqgQKLw5GIZG/UXbrN73R8og3nk2f
         uf0i6xNFTVLvfDt2nA1yenVlzU/W+KPnhjsgJcXsWXpP5/1lwx9XWgqI7OlhFhg6JS8n
         OTva2MguIWUNm1HhDVLYSHttpkno1BW5wdxYeWXe/wHxmRtlB1By6l/MpMrYBIB1zi6j
         sWRlY0fofxe+DethxeryXH0MUZfMiW45jeYQcDYTDBnRtOcwGDID/Lq9Kl9UDP5vcaY3
         NiH47FntBAV/A0w+WjZq5oONuXDA4LlDNaaQQs0D8ylvINi6ROSmMp2YTed5C5uTxsF0
         y7uw==
X-Gm-Message-State: APjAAAXh6+kvN1li/WE52FRKGh4GGt2ThsY6DQiy12X90Sl8Y25NXGUW
        IgafjXzPw9XzRkPGwAyS7+8M3S7nDn0Xe2tqZJQ=
X-Google-Smtp-Source: APXvYqzMFzHIUUANeBwJRGHMxb3uoVK0yWKVvQ0cLYjTjSgXKYjTLe5eUjKX3OYErfo1Y9W9P+JPYShcw0Pnej3GmXs=
X-Received: by 2002:a81:63c3:: with SMTP id x186mr23339894ywb.248.1558014991905;
 Thu, 16 May 2019 06:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190516102641.6574-1-amir73il@gmail.com> <20190516122506.GF13274@quack2.suse.cz>
In-Reply-To: <20190516122506.GF13274@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 16 May 2019 16:56:20 +0300
Message-ID: <CAOQ4uxjiHuN7dcciucaRXvhj6g9wgz4k313NV3c_XbUrC8+sug@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] Sort out fsnotify_nameremove() mess
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Joel Becker <jlbec@evilplan.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 16, 2019 at 3:25 PM Jan Kara <jack@suse.cz> wrote:
>
> Hi,
>
> On Thu 16-05-19 13:26:27, Amir Goldstein wrote:
> > What do you think will be the best merge strategy for this patch series?
> >
> > How about sending first 3 prep patches to Linus for applying at the end
> > of v5.2 merge window, so individual maintainers can pick up per fs
> > patches for the v5.3 development cycle?
>
> I don't think we'll make it for rc1. But those three cleanup patches would
> be OK for rc2 as well. But overall patches are not very intrusive so I'm
> also OK with pushing the patches myself once we get acks from respective
> maintainers if Al will be too busy and won't react.
>
> > The following d_delete() call sites have been audited and will no longer
> > generate fsnotify event after this series:
> >
> > drivers/usb/gadget/function/f_fs.c:ffs_epfiles_destroy() - cleanup? (*)
>
> Not really but creation events are not generated either.
>
> > fs/ceph/dir.c:ceph_unlink() - from vfs_unlink()
> > fs/ceph/inode.c:ceph_fill_trace() - invalidate (**)
>
> There's one more 'invalidate' case in fs/ceph/inode.c.
>
> > fs/configfs/dir.c:detach_groups() - cleanup (*)
>
> Why is this a cleanup? detach_groups() is used also from
> configfs_detach_group() which gets called from configfs_rmdir() which is
> real deletion.

True, configfs is a special case where both cleanup and real deletion
use the same helper. configfs_detach_group() is either called for cleanup
or from vfs_rmdir->configfs_rmdir()/configfs_unregister_{group,subsystem}()
the latter 3 cases have new fsnotify hooks.

>
> > fs/configfs/dir.c:configfs_attach_item() - cleanup (*)
> > fs/configfs/dir.c:configfs_attach_group() - cleanup (*)
> > fs/efivarfs/file.c:efivarfs_file_write() - invalidate (**)
> > fs/fuse/dir.c:fuse_reverse_inval_entry() - invalidate (**)
> > fs/nfs/dir.c:nfs_dentry_handle_enoent() - invalidate (**)
> > fs/nsfs.c:__ns_get_path() - invalidate (**)
>
> More a cleanup case I'd say...
>
> > fs/ocfs2/dlmglue.c:ocfs2_dentry_convert_worker() - invalidate? (**)
>
> This is really invalidate.
>
> > fs/reiserfs/xattr.c:xattr_{unlink,rmdir}() - hidden xattr inode
> >
> > (*) There are 2 "cleanup" use cases:
> >   - Create;init;delte if init failed
> >   - Batch delete of files within dir before removing dir
> >   Both those cases are not interesting for users that wish to observe
> >   configuration changes on pseudo filesystems.  Often, there is already
> >   an fsnotify event generated on the directory removal which is what
> >   users should find interesting, for example:
> >   configfs_unregister_{group,subsystem}().
> >
> > (**) The different "invalidate" use cases differ, but they all share
> >   one thing in common - user is not guarantied to get an event with
> >   current kernel.  For example, when a file is deleted remotely on
> >   nfs server, nfs client is not guarantied to get an fsnotify delete
> >   event.  On current kernel, nfs client could generate an fsnotify
> >   delete event if the local entry happens to be in cache and client
> >   finds out that entry is deleted on server during another user
> >   operation.  Incidentally, this group of use cases is where most of
> >   the call sites are with "unstable" d_name, which is the reason for
> >   this patch series to begin with.
>
> Thanks. Maybe for other reviewers it would be more convincing to take
> sanitized output of 'git grep "[^a-z_]d_delete("' and annotate how each
> callsite is handled - i.e., "cleanup, invalidate, simple_remove, vfs,
> manual - patch X". But I'm now reasonably convinced we didn't forget
> anything :).
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
