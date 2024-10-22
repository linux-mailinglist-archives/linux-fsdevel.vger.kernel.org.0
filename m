Return-Path: <linux-fsdevel+bounces-32589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A259AB2B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 17:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A181C22671
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 15:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2811C3F2F;
	Tue, 22 Oct 2024 15:48:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1501C32F5;
	Tue, 22 Oct 2024 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612116; cv=none; b=t5VwRrXZRZ9WcQtUeShwpJeixA1QKCD/zIQgAkzvqID4u9yh/xhzQb6vsChoAvfldXdX1AspCrnvqNAIjklxH0hZmlpy4OLBghWFIYB37RUHmQqgHG38G8A1MfIRoN0ZTauIq8hisiCZ1Gv+IbxmjTbsCPTPD98ydInUwEvG/mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612116; c=relaxed/simple;
	bh=AdsxBL+HowTfQfp20uGO4M1QXogghGZmZa12oO1KsOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ratpN5BuYmkgVOIs3Nn4C430aLlkALeJWkHnfiPr+PYQ5ajiD8SBIXEuAEgfRefEed3vH2Ulmds89M3Zr09yMenMM4/78DURJMyfSk1t0jai6Ub2puKU9z6WOt+6/MB8y53x5qNG4cXUPIqHUu7A2X560V2QvbkbB9KdZFBQJZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99ebb390a5so1251033666b.1;
        Tue, 22 Oct 2024 08:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729612112; x=1730216912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6DzR1waiIbLIB43OdnODx0TO5r904Jk+JL2Jrn/w4o=;
        b=vAiunIfLPCu62om1DhVYi7Vk7iBXeG8RQ3DSCSOxk0l+3UQ7kdnalvnW85+VUAF7dD
         9be/ueidVKacyXgqU3bJYmu7H6fSOlAcOGwUjgpbeBMIdWf+4NDsQgT5q7pIJIzS8z9p
         o8NMDU29NpXCEO3Qpo+P8sbt/Qt7zMFGLvgJnDJ7xVX0tvz0lUrQgtidW4lZ6SIz+Ghp
         aWvAtPNPYZpheMNFcYhNA5wKfHwGmMMxUyiGCpbTbxVR2ExBsXjDx9hgIknlvPPQ1yTQ
         NySEVcZ2BU1eICviPrUasFwa0vOFwBGNrkc80yQDRHMhQXxLafT3eCk3ABhxzs5Cnpkw
         diUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9SqsbkNDqpq5AQdHMYsAoVg8DrW13CKEWeUcOvEcKnIkBCRbuLJQvOTVdLns2w/U/kifJL6PwDOYLSOjo@vger.kernel.org, AJvYcCWp/62oMVnIvHOoNuxYqKO2cE9NX+BtLeXt2bbYYnMgkG9HsUZWsCwYRq8x5K6YoyduakTvn4+s+9/ajeWv@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8LGgsqF7KlP3Q3CeiY2H/8uHc6guWQOPvusceo7CIyvOpFojk
	AsdZdBKin0Bt8BYBu/uemo7YoYaTE0g1niP3a+6an5n56WxDChOeoC+0JOQ6
X-Google-Smtp-Source: AGHT+IH6KE6hCkcgXGBT6Ek728JlwRZgFOUrDsEgNEpxlcXWIF+1DjSA/Zy8kmsTmMUGL6mUkiO2rQ==
X-Received: by 2002:a17:906:f585:b0:a9a:df:9e58 with SMTP id a640c23a62f3a-a9aaa540e82mr409910166b.16.1729612111421;
        Tue, 22 Oct 2024 08:48:31 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a9159a23csm353748366b.205.2024.10.22.08.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 08:48:31 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a99e3b3a411so1108264666b.0;
        Tue, 22 Oct 2024 08:48:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUS4plXPdZ0H8HYnIc0yWUYDg7n8sC/J9OJT+OmBzvgNr3pytqfVDTHTsgTBoe6FvIjlwtQIZ9LwM6rrp4t@vger.kernel.org, AJvYcCWfLCUuoNSW2mBkI+gzB1KD7vip/YAW3ssKSFHKxSkY12wznHW84+QXTaKYFqwlujWhIGHn1TS2kR8JIh3E@vger.kernel.org
X-Received: by 2002:a17:907:2cc5:b0:a99:5f65:fd9a with SMTP id
 a640c23a62f3a-a9aaa620d5cmr420810166b.21.1729612110989; Tue, 22 Oct 2024
 08:48:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2411941.1729552461@warthog.procyon.org.uk>
In-Reply-To: <2411941.1729552461@warthog.procyon.org.uk>
From: Marc Dionne <marc.dionne@auristor.com>
Date: Tue, 22 Oct 2024 12:48:19 -0300
X-Gmail-Original-Message-ID: <CAB9dFdvhZurKzcavW9-2gtkv+LcwVm_UZ=LaJc+vcBp0irf7cA@mail.gmail.com>
Message-ID: <CAB9dFdvhZurKzcavW9-2gtkv+LcwVm_UZ=LaJc+vcBp0irf7cA@mail.gmail.com>
Subject: Re: [PATCH] afs: Fix missing subdir edit when renamed between parent dirs
To: David Howells <dhowells@redhat.com>
Cc: linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 8:14=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> When rename moves an AFS subdirectory between parent directories, the
> subdir also needs a bit of editing: the ".." entry needs updating to poin=
t
> to the new parent (though I don't make use of the info) and the DV needs
> incrementing by 1 to reflect the change of content.  The server also send=
s
> a callback break notification on the subdirectory if we have one, but we
> can take care of recovering the promise next time we access the subdir.
>
> This can be triggered by something like:
>
>     mount -t afs %example.com:xfstest.test20 /xfstest.test/
>     mkdir /xfstest.test/{aaa,bbbb,aaa/ccc}
>     mv /xfstest.test/{aaa/ccc,bbbb/ccc}
>     touch /xfstest.test/bbbb/ccc/d
>
> When the pathwalk for the touch hits "ccc", kafs spots that the DV is
> incorrect and downloads it again unnecessarily.
>
> Fix this, if the rename target is a directory and the old and new
> parents are different, by:
>
>  (1) Incrementing the DV number of the target locally.
>
>  (2) Editing the ".." entry in the target to refer to its new parent's
>      vnode ID and uniquifier.
>
> cc: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> ---
>  fs/afs/dir.c               |   25 ++++++++++++
>  fs/afs/dir_edit.c          |   91 ++++++++++++++++++++++++++++++++++++++=
++++++-
>  fs/afs/internal.h          |    2
>  include/trace/events/afs.h |    7 ++-
>  4 files changed, 122 insertions(+), 3 deletions(-)
>
> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index f8622ed72e08..474062d22712 100644
> --- a/fs/afs/dir.c
> +++ b/fs/afs/dir.c
> @@ -12,6 +12,7 @@
>  #include <linux/swap.h>
>  #include <linux/ctype.h>
>  #include <linux/sched.h>
> +#include <linux/iversion.h>
>  #include <linux/task_io_accounting_ops.h>
>  #include "internal.h"
>  #include "afs_fs.h"
> @@ -1823,6 +1824,8 @@ static int afs_symlink(struct mnt_idmap *idmap, str=
uct inode *dir,
>
>  static void afs_rename_success(struct afs_operation *op)
>  {
> +       struct afs_vnode *vnode =3D AFS_FS_I(d_inode(op->dentry));
> +
>         _enter("op=3D%08x", op->debug_id);
>
>         op->ctime =3D op->file[0].scb.status.mtime_client;
> @@ -1832,6 +1835,22 @@ static void afs_rename_success(struct afs_operatio=
n *op)
>                 op->ctime =3D op->file[1].scb.status.mtime_client;
>                 afs_vnode_commit_status(op, &op->file[1]);
>         }
> +
> +       /* If we're moving a subdir between dirs, we need to update
> +        * its DV counter too as the ".." will be altered.
> +        */
> +       if (S_ISDIR(vnode->netfs.inode.i_mode) &&
> +           op->file[0].vnode !=3D op->file[1].vnode) {
> +               u64 new_dv;
> +
> +               write_seqlock(&vnode->cb_lock);
> +
> +               new_dv =3D vnode->status.data_version + 1;
> +               vnode->status.data_version =3D new_dv;
> +               inode_set_iversion_raw(&vnode->netfs.inode, new_dv);
> +
> +               write_sequnlock(&vnode->cb_lock);
> +       }
>  }
>
>  static void afs_rename_edit_dir(struct afs_operation *op)
> @@ -1873,6 +1892,12 @@ static void afs_rename_edit_dir(struct afs_operati=
on *op)
>                                  &vnode->fid, afs_edit_dir_for_rename_2);
>         }
>
> +       if (S_ISDIR(vnode->netfs.inode.i_mode) &&
> +           new_dvnode !=3D orig_dvnode &&
> +           test_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
> +               afs_edit_dir_update_dotdot(vnode, new_dvnode,
> +                                          afs_edit_dir_for_rename_sub);
> +

Empty line with some whitespace.

>         new_inode =3D d_inode(new_dentry);
>         if (new_inode) {
>                 spin_lock(&new_inode->i_lock);
> diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
> index a71bff10496b..fe223fb78111 100644
> --- a/fs/afs/dir_edit.c
> +++ b/fs/afs/dir_edit.c
> @@ -127,10 +127,10 @@ static struct folio *afs_dir_get_folio(struct afs_v=
node *vnode, pgoff_t index)
>  /*
>   * Scan a directory block looking for a dirent of the right name.
>   */
> -static int afs_dir_scan_block(union afs_xdr_dir_block *block, struct qst=
r *name,
> +static int afs_dir_scan_block(const union afs_xdr_dir_block *block, cons=
t struct qstr *name,
>                               unsigned int blocknum)
>  {
> -       union afs_xdr_dirent *de;
> +       const union afs_xdr_dirent *de;
>         u64 bitmap;
>         int d, len, n;
>
> @@ -492,3 +492,90 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
>         clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
>         goto out_unmap;
>  }
> +
> +/*
> + * Edit a subdirectory that has been moved between directories to update=
 the
> + * ".." entry.
> + */
> +void afs_edit_dir_update_dotdot(struct afs_vnode *vnode, struct afs_vnod=
e *new_dvnode,
> +                               enum afs_edit_dir_reason why)
> +{
> +       union afs_xdr_dir_block *block;
> +       union afs_xdr_dirent *de;
> +       struct folio *folio;
> +       unsigned int nr_blocks, b;
> +       pgoff_t index;
> +       loff_t i_size;
> +       int slot;
> +
> +       _enter("");
> +
> +       i_size =3D i_size_read(&vnode->netfs.inode);
> +       if (i_size < AFS_DIR_BLOCK_SIZE) {
> +               clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
> +               return;
> +       }
> +       nr_blocks =3D i_size / AFS_DIR_BLOCK_SIZE;
> +
> +       /* Find a block that has sufficient slots available.  Each folio
> +        * contains two or more directory blocks.
> +        */
> +       for (b =3D 0; b < nr_blocks; b++) {
> +               index =3D b / AFS_DIR_BLOCKS_PER_PAGE;
> +               folio =3D afs_dir_get_folio(vnode, index);
> +               if (!folio)
> +                       goto error;
> +
> +               block =3D kmap_local_folio(folio, b * AFS_DIR_BLOCK_SIZE =
- folio_pos(folio));
> +
> +               /* Abandon the edit if we got a callback break. */
> +               if (!test_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
> +                       goto invalidated;
> +
> +               slot =3D afs_dir_scan_block(block, &dotdot_name, b);
> +               if (slot >=3D 0)
> +                       goto found_dirent;
> +
> +               kunmap_local(block);
> +               folio_unlock(folio);
> +               folio_put(folio);
> +       }
> +
> +       /* Didn't find the dirent to clobber.  Download the directory aga=
in. */
> +       trace_afs_edit_dir(vnode, why, afs_edit_dir_update_nodd,
> +                          0, 0, 0, 0, "..");
> +       clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
> +       goto out;
> +
> +found_dirent:
> +       de =3D &block->dirents[slot];
> +       de->u.vnode  =3D htonl(new_dvnode->fid.vnode);
> +       de->u.unique =3D htonl(new_dvnode->fid.unique);
> +
> +       trace_afs_edit_dir(vnode, why, afs_edit_dir_update_dd, b, slot,
> +                          ntohl(de->u.vnode), ntohl(de->u.unique), "..")=
;
> +
> +       kunmap_local(block);
> +       folio_unlock(folio);
> +       folio_put(folio);
> +       inode_set_iversion_raw(&vnode->netfs.inode, vnode->status.data_ve=
rsion);
> +
> +out:
> +       _leave("");
> +       return;
> +
> +invalidated:
> +       kunmap_local(block);
> +       folio_unlock(folio);
> +       folio_put(folio);
> +       trace_afs_edit_dir(vnode, why, afs_edit_dir_update_inval,
> +                          0, 0, 0, 0, "..");
> +       clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
> +       goto out;
> +
> +error:
> +       trace_afs_edit_dir(vnode, why, afs_edit_dir_update_error,
> +                          0, 0, 0, 0, "..");
> +       clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
> +       goto out;
> +}
> diff --git a/fs/afs/internal.h b/fs/afs/internal.h
> index 52aab09a32a9..c9d620175e80 100644
> --- a/fs/afs/internal.h
> +++ b/fs/afs/internal.h
> @@ -1073,6 +1073,8 @@ extern void afs_check_for_remote_deletion(struct af=
s_operation *);
>  extern void afs_edit_dir_add(struct afs_vnode *, struct qstr *, struct a=
fs_fid *,
>                              enum afs_edit_dir_reason);
>  extern void afs_edit_dir_remove(struct afs_vnode *, struct qstr *, enum =
afs_edit_dir_reason);
> +void afs_edit_dir_update_dotdot(struct afs_vnode *vnode, struct afs_vnod=
e *new_dvnode,
> +                               enum afs_edit_dir_reason why);
>
>  /*
>   * dir_silly.c
> diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
> index 450c44c83a5d..a0aed1a428a1 100644
> --- a/include/trace/events/afs.h
> +++ b/include/trace/events/afs.h
> @@ -331,7 +331,11 @@ enum yfs_cm_operation {
>         EM(afs_edit_dir_delete,                 "delete") \
>         EM(afs_edit_dir_delete_error,           "d_err ") \
>         EM(afs_edit_dir_delete_inval,           "d_invl") \
> -       E_(afs_edit_dir_delete_noent,           "d_nent")
> +       EM(afs_edit_dir_delete_noent,           "d_nent") \
> +       EM(afs_edit_dir_update_dd,              "u_ddot") \
> +       EM(afs_edit_dir_update_error,           "u_fail") \
> +       EM(afs_edit_dir_update_inval,           "u_invl") \
> +       E_(afs_edit_dir_update_nodd,            "u_nodd")
>
>  #define afs_edit_dir_reasons                             \
>         EM(afs_edit_dir_for_create,             "Create") \
> @@ -340,6 +344,7 @@ enum yfs_cm_operation {
>         EM(afs_edit_dir_for_rename_0,           "Renam0") \
>         EM(afs_edit_dir_for_rename_1,           "Renam1") \
>         EM(afs_edit_dir_for_rename_2,           "Renam2") \
> +       EM(afs_edit_dir_for_rename_sub,         "RnmSub") \
>         EM(afs_edit_dir_for_rmdir,              "RmDir ") \
>         EM(afs_edit_dir_for_silly_0,            "S_Ren0") \
>         EM(afs_edit_dir_for_silly_1,            "S_Ren1") \

A few nits:
- There's an empty line with whitespace that I indicated above.
- I don't think your example in the commit message is quite sufficient
to show the problem; after a MakeDir the new directory will always get
fetched from the server, before or after the fix.  You need to modify
it before the rename so that the local dir data is valid, for instance
by creating an additional file in "ccc".

That said the fix looks good and does fix the issue.

Marc

