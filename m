Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D5736E9E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 14:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbhD2MBl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 08:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbhD2MBj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 08:01:39 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0EFC06138B;
        Thu, 29 Apr 2021 05:00:51 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h15so14395879wre.11;
        Thu, 29 Apr 2021 05:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eL7kzrQuQQqjx9marUBLtMFHaHO1ZN6rfrvAhnpX8HE=;
        b=pL3rSfZfiYa/AAXPA4mQPKPXTA1R8bmrJ9ja4YL/7fclS8/puO8retk+ccDhlr8/R3
         wlHfDCSBmiQ0MSkZs3EhBLDCpa4qUAy4baFAWVbdrDOXIoyZWO78YUuRKSGr0QPlGF/N
         1xKnOV+3IYn3OsW7iAprn4tE8EF3PfGMPCYvPrgUq4fWQoLtoVQ870Z36JvVzWhoSlNz
         OoI8wrQYjggcs6iRBZgeJElBbTDwuoA/COBlKkGo466dRZuzg2uWnHMzW9fo8re8YNR8
         EjemtUPja6QsFZNpGdLUrecF2mHIretVYaqdQGAcESP5T51nhymqzlPjs9b2fEpXt+k2
         aboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eL7kzrQuQQqjx9marUBLtMFHaHO1ZN6rfrvAhnpX8HE=;
        b=umDxerFAUX7UlsebHeHxBaHwqrIiQYVi0IRL5lGGXXo50NWFHqSK8vOwaGzhqx6ebW
         BwBSbBfj0+igCiH7H8xZ0c4ilMWQLYwvFoExcJ6KzAp6qICIB95RVBjGrEBzYT/U2UV0
         9jJr2NAoKn25j8JNyLIxIgAH5tDdWDo3ySESv8pSoBORYfAozvWVU44CgzXN+cRaWOTs
         LNCZ8doKlztwq9lNWRIlIWAHK67VWTY7mszGWX5pRZr/gpC4M5t7DAicvqYo4TiVJR4g
         K220G+9In1DdPIrOavOcdF+/OMqK/DCF6qZCfqx1XK6z6RFcv+aM5glguO1h7iYzXQcZ
         WtqA==
X-Gm-Message-State: AOAM532tCGmK8Yz7gK65HBZYUaV2uqshTOrV5vn2OyxodsOE3HV2lNb6
        Xwnuw6jhIYvtjjnURz3uh9WrWRzh4ZL3FXnYHA8=
X-Google-Smtp-Source: ABdhPJys5fLcsFOTfbWkCMLTvilRbno5eHK/GA3+o5yiwDbOz6bayC2JBT8z2yunv9DoF6sZF3VFcCbkbX/nfN6Ie6U=
X-Received: by 2002:a5d:58e1:: with SMTP id f1mr17018329wrd.375.1619697650366;
 Thu, 29 Apr 2021 05:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <161961335926.39335.2552653972195467566.stgit@warthog.procyon.org.uk>
In-Reply-To: <161961335926.39335.2552653972195467566.stgit@warthog.procyon.org.uk>
From:   Marc Dionne <marc.c.dionne@gmail.com>
Date:   Thu, 29 Apr 2021 09:00:39 -0300
Message-ID: <CAB9dFdvMCYNxxdmoiRF2qs9Z9qpd3Rg7qjBfG3Wg8=GzhygHGQ@mail.gmail.com>
Subject: Re: [PATCH] afs: Fix speculative status fetches
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 28, 2021 at 9:36 AM David Howells <dhowells@redhat.com> wrote:
>
> The generic/464 xfstest causes kAFS to emit occasional warnings of the
> form:
>
>         kAFS: vnode modified {100055:8a} 30->31 YFS.StoreData64 (c=6015)
>
> This indicates that the data version received back from the server did not
> match the expected value (the DV should be incremented monotonically for
> each individual modification op committed to a vnode).
>
> What is happening is that a lookup call is doing a bulk status fetch
> speculatively on a bunch of vnodes in a directory besides getting the
> status of the vnode it's actually interested in.  This is racing with a
> StoreData operation (though it could also occur with, say, a MakeDir op).
>
> On the client, a modification operation locks the vnode, but the bulk
> status fetch only locks the parent directory, so no ordering is imposed
> there (thereby avoiding an avenue to deadlock).
>
> On the server, the StoreData op handler doesn't lock the vnode until it's
> received all the request data, and downgrades the lock after committing the
> data until it has finished sending change notifications to other clients -
> which allows the status fetch to occur before it has finished.
>
> This means that:
>
>  - a status fetch can access the target vnode either side of the exclusive
>    section of the modification
>
>  - the status fetch could start before the modification, yet finish after,
>    and vice-versa.
>
>  - the status fetch and the modification RPCs can complete in either order.
>
>  - the status fetch can return either the before or the after DV from the
>    modification.
>
>  - the status fetch might regress the locally cached DV.
>
> Some of these are handled by the previous fix[1], but that's not sufficient
> because it checks the DV it received against the DV it cached at the start
> of the op, but the DV might've been updated in the meantime by a locally
> generated modification op.
>
> Fix this by the following means:
>
>  (1) Keep track of when we're performing a modification operation on a
>      vnode.  This is done by marking vnode parameters with a 'modification'
>      note that causes the AFS_VNODE_MODIFYING flag to be set on the vnode
>      for the duration.
>
>  (2) Altering the speculation race detection to ignore speculative status
>      fetches if either the vnode is marked as being modified or the data
>      version number is not what we expected.
>
> Note that whilst the "vnode modified" warning does get recovered from as it
> causes the client to refetch the status at the next opportunity, it will
> also invalidate the pagecache, so changes might get lost.
>
> Fixes: a9e5c87ca744 ("afs: Fix speculative status fetch going out of order wrt to modifications")
> Reported-by: Marc Dionne <marc.dionne@auristor.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-afs@lists.infradead.org
> Link: https://lore.kernel.org/r/160605082531.252452.14708077925602709042.stgit@warthog.procyon.org.uk/ [1]
> ---
>
>  fs/afs/dir.c          |    7 +++++++
>  fs/afs/dir_silly.c    |    3 +++
>  fs/afs/fs_operation.c |    6 ++++++
>  fs/afs/inode.c        |    6 ++++--
>  fs/afs/internal.h     |    2 ++
>  fs/afs/write.c        |    1 +
>  6 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index 117df15e5367..9fbe5a5ec9bd 100644
> --- a/fs/afs/dir.c
> +++ b/fs/afs/dir.c
> @@ -1419,6 +1419,7 @@ static int afs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>
>         afs_op_set_vnode(op, 0, dvnode);
>         op->file[0].dv_delta = 1;
> +       op->file[0].modification = true;
>         op->file[0].update_ctime = true;
>         op->dentry      = dentry;
>         op->create.mode = S_IFDIR | mode;
> @@ -1500,6 +1501,7 @@ static int afs_rmdir(struct inode *dir, struct dentry *dentry)
>
>         afs_op_set_vnode(op, 0, dvnode);
>         op->file[0].dv_delta = 1;
> +       op->file[0].modification = true;
>         op->file[0].update_ctime = true;
>
>         op->dentry      = dentry;
> @@ -1636,6 +1638,7 @@ static int afs_unlink(struct inode *dir, struct dentry *dentry)
>
>         afs_op_set_vnode(op, 0, dvnode);
>         op->file[0].dv_delta = 1;
> +       op->file[0].modification = true;
>         op->file[0].update_ctime = true;
>
>         /* Try to make sure we have a callback promise on the victim. */
> @@ -1718,6 +1721,7 @@ static int afs_create(struct user_namespace *mnt_userns, struct inode *dir,
>
>         afs_op_set_vnode(op, 0, dvnode);
>         op->file[0].dv_delta = 1;
> +       op->file[0].modification = true;
>         op->file[0].update_ctime = true;
>
>         op->dentry      = dentry;
> @@ -1792,6 +1796,7 @@ static int afs_link(struct dentry *from, struct inode *dir,
>         afs_op_set_vnode(op, 0, dvnode);
>         afs_op_set_vnode(op, 1, vnode);
>         op->file[0].dv_delta = 1;
> +       op->file[0].modification = true;
>         op->file[0].update_ctime = true;
>         op->file[1].update_ctime = true;
>
> @@ -1987,6 +1992,8 @@ static int afs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>         afs_op_set_vnode(op, 1, new_dvnode); /* May be same as orig_dvnode */
>         op->file[0].dv_delta = 1;
>         op->file[1].dv_delta = 1;
> +       op->file[0].modification = true;
> +       op->file[1].modification = true;
>         op->file[0].update_ctime = true;
>         op->file[1].update_ctime = true;
>
> diff --git a/fs/afs/dir_silly.c b/fs/afs/dir_silly.c
> index 04f75a44f243..dae9a57d7ec0 100644
> --- a/fs/afs/dir_silly.c
> +++ b/fs/afs/dir_silly.c
> @@ -73,6 +73,8 @@ static int afs_do_silly_rename(struct afs_vnode *dvnode, struct afs_vnode *vnode
>         afs_op_set_vnode(op, 1, dvnode);
>         op->file[0].dv_delta = 1;
>         op->file[1].dv_delta = 1;
> +       op->file[0].modification = true;
> +       op->file[1].modification = true;
>         op->file[0].update_ctime = true;
>         op->file[1].update_ctime = true;
>
> @@ -201,6 +203,7 @@ static int afs_do_silly_unlink(struct afs_vnode *dvnode, struct afs_vnode *vnode
>         afs_op_set_vnode(op, 0, dvnode);
>         afs_op_set_vnode(op, 1, vnode);
>         op->file[0].dv_delta = 1;
> +       op->file[0].modification = true;
>         op->file[0].update_ctime = true;
>         op->file[1].op_unlinked = true;
>         op->file[1].update_ctime = true;
> diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
> index 2cb0951acca6..d222dfbe976b 100644
> --- a/fs/afs/fs_operation.c
> +++ b/fs/afs/fs_operation.c
> @@ -118,6 +118,8 @@ static void afs_prepare_vnode(struct afs_operation *op, struct afs_vnode_param *
>                 vp->cb_break_before     = afs_calc_vnode_cb_break(vnode);
>                 if (vnode->lock_state != AFS_VNODE_LOCK_NONE)
>                         op->flags       |= AFS_OPERATION_CUR_ONLY;
> +               if (vp->modification)
> +                       set_bit(AFS_VNODE_MODIFYING, &vnode->flags);
>         }
>
>         if (vp->fid.vnode)
> @@ -225,6 +227,10 @@ int afs_put_operation(struct afs_operation *op)
>
>         if (op->ops && op->ops->put)
>                 op->ops->put(op);
> +       if (op->file[0].modification)
> +               clear_bit(AFS_VNODE_MODIFYING, &op->file[0].vnode->flags);
> +       if (op->file[1].modification && op->file[1].vnode != op->file[0].vnode)
> +               clear_bit(AFS_VNODE_MODIFYING, &op->file[1].vnode->flags);
>         if (op->file[0].put_vnode)
>                 iput(&op->file[0].vnode->vfs_inode);
>         if (op->file[1].put_vnode)
> diff --git a/fs/afs/inode.c b/fs/afs/inode.c
> index 3a129b9fd9b8..80b6c8d967d5 100644
> --- a/fs/afs/inode.c
> +++ b/fs/afs/inode.c
> @@ -294,8 +294,9 @@ void afs_vnode_commit_status(struct afs_operation *op, struct afs_vnode_param *v
>                         op->flags &= ~AFS_OPERATION_DIR_CONFLICT;
>                 }
>         } else if (vp->scb.have_status) {
> -               if (vp->dv_before + vp->dv_delta != vp->scb.status.data_version &&
> -                   vp->speculative)
> +               if (vp->speculative &&
> +                   (test_bit(AFS_VNODE_MODIFYING, &vnode->flags) ||
> +                    vp->dv_before != vnode->status.data_version))
>                         /* Ignore the result of a speculative bulk status fetch
>                          * if it splits around a modification op, thereby
>                          * appearing to regress the data version.
> @@ -911,6 +912,7 @@ int afs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>         }
>         op->ctime = attr->ia_ctime;
>         op->file[0].update_ctime = 1;
> +       op->file[0].modification = true;
>
>         op->ops = &afs_setattr_operation;
>         ret = afs_do_sync_operation(op);
> diff --git a/fs/afs/internal.h b/fs/afs/internal.h
> index 52157a05796a..5ed416f4ff33 100644
> --- a/fs/afs/internal.h
> +++ b/fs/afs/internal.h
> @@ -645,6 +645,7 @@ struct afs_vnode {
>  #define AFS_VNODE_PSEUDODIR    7               /* set if Vnode is a pseudo directory */
>  #define AFS_VNODE_NEW_CONTENT  8               /* Set if file has new content (create/trunc-0) */
>  #define AFS_VNODE_SILLY_DELETED        9               /* Set if file has been silly-deleted */
> +#define AFS_VNODE_MODIFYING    10              /* Set if we're performing a modification op */
>
>         struct list_head        wb_keys;        /* List of keys available for writeback */
>         struct list_head        pending_locks;  /* locks waiting to be granted */
> @@ -762,6 +763,7 @@ struct afs_vnode_param {
>         bool                    set_size:1;     /* Must update i_size */
>         bool                    op_unlinked:1;  /* True if file was unlinked by op */
>         bool                    speculative:1;  /* T if speculative status fetch (no vnode lock) */
> +       bool                    modification:1; /* Set if the content gets modified */
>  };
>
>  /*
> diff --git a/fs/afs/write.c b/fs/afs/write.c
> index dc66ff15dd16..3edb6204b937 100644
> --- a/fs/afs/write.c
> +++ b/fs/afs/write.c
> @@ -377,6 +377,7 @@ static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter, loff_t
>
>         afs_op_set_vnode(op, 0, vnode);
>         op->file[0].dv_delta = 1;
> +       op->file[0].modification = true;
>         op->store.write_iter = iter;
>         op->store.pos = pos;
>         op->store.size = size;
>
>
>
> _______________________________________________
> linux-afs mailing list
> http://lists.infradead.org/mailman/listinfo/linux-afs

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
