Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91669703C46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 20:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245164AbjEOSRY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 14:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245153AbjEOSQz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 14:16:55 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF6E1A3B4;
        Mon, 15 May 2023 11:15:07 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ac786d12f7so22290861fa.0;
        Mon, 15 May 2023 11:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1684174505; x=1686766505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWVz+ZJC51NFWrUr03eqnPxsTi1eEaUoYbhtmR4OYfU=;
        b=MBiglAsz860Xzbblmd5kMZqPSJB4dH7BVn/mMXUHpHpK9B5DFzMTHrd80NYwxuyusZ
         dxFaM2gJ+tteU0dtx3vq0bZ3Or0hGzRMVDffTLqE8T2AKkGM+Lpa44f/5cZkIG4rCKy+
         tLCitUFto84hC4rMsGKprnzMhQmyJAJ81ihV/7zYep0qbGK0ohvDx5Rupx2UBcq01yoO
         PBXfm1UhzYzbYzuA3ULPTCGefPGLLFcL44tU20TEBXMC560vegCJVw8q1YCEUjoKnFBo
         4LUkeen8FPcRtTBBOQxruRbGesj7GEcqEl+NDHA68sOBTMtyJQ9IuK+dnKO06I1v95eT
         bMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684174505; x=1686766505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWVz+ZJC51NFWrUr03eqnPxsTi1eEaUoYbhtmR4OYfU=;
        b=Vz3J3o+FRPLvyXh7UZuxxgVNZY6lMzKJZYDVxEfSa/QRzMivcCzcFNdB2L2AwFGc+I
         FhalGbunPvMlLD1q+QG4nJ+cY2D9+vk3muL6laUoZPydBFcqnhLK0cbIravWuWm4Cq/k
         i+HUlfUoq5FMB8pVH8gowiZz/tcn5B/A38D0IR70sHMkK7IrgOalS+NDVQQJsMHlXeHi
         u5yvu6hkldva3LYDoyY8alSoR52guolOp/U+IuAvHtkbnGXoGXryhgzSF7uxaYS9Q+bv
         1Jg/LltC3YU5orZs46InadVLIC3V4NKOtG+Dzvh3kG0SjPq8Bx548KfDS4fPqQ04tTuH
         /Gdw==
X-Gm-Message-State: AC+VfDxdLUWNqqvxjVYZx4OODH237w4M/WgpVXvdw6HxWIwCK/a9lmFd
        24nezJ/KFGWl0pnY5pBnPd9WRuKHfm1tcPGZ/Ho=
X-Google-Smtp-Source: ACHHUZ64p8hAAIjN2UbxFzShxzGuEvBHD7GqUz66V5GgIQISbdU8kKEXUR076mvnYkw/kfdmPq6eQut+pR7wydU5tg4=
X-Received: by 2002:a2e:a4d3:0:b0:2ad:b513:35a1 with SMTP id
 p19-20020a2ea4d3000000b002adb51335a1mr62133ljm.2.1684174504849; Mon, 15 May
 2023 11:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <1684110038-11266-1-git-send-email-dai.ngo@oracle.com> <1684110038-11266-5-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1684110038-11266-5-git-send-email-dai.ngo@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 15 May 2023 14:14:53 -0400
Message-ID: <CAN-5tyH0GM8xOnLVDMQMn-tmoE-w_7N9ARmcwHq6ocySeoA1MQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] NFSD: handle GETATTR conflict with write delegation
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 14, 2023 at 8:56=E2=80=AFPM Dai Ngo <dai.ngo@oracle.com> wrote:
>
> If the GETATTR request on a file that has write delegation in effect
> and the request attributes include the change info and size attribute
> then the request is handled as below:
>
> Server sends CB_GETATTR to client to get the latest change info and file
> size. If these values are the same as the server's cached values then
> the GETATTR proceeds as normal.
>
> If either the change info or file size is different from the server's
> cached values, or the file was already marked as modified, then:
>
>    . update time_modify and time_metadata into file's metadata
>      with current time
>
>    . encode GETATTR as normal except the file size is encoded with
>      the value returned from CB_GETATTR
>
>    . mark the file as modified
>
> If the CB_GETATTR fails for any reasons, the delegation is recalled
> and NFS4ERR_DELAY is returned for the GETATTR.

Hi Dai,

I'm curious what does the server gain by implementing handling of
GETATTR with delegations? As far as I can tell it is not strictly
required by the RFC(s). When the file is being written any attempt at
querying its attribute is immediately stale.

>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 58 ++++++++++++++++++++++++++++++++++++
>  fs/nfsd/nfs4xdr.c   | 84 +++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  fs/nfsd/state.h     |  7 +++++
>  3 files changed, 148 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 09a9e16407f9..fb305b28a090 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -127,6 +127,7 @@ static void free_session(struct nfsd4_session *);
>
>  static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
>  static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
> +static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops;
>
>  static struct workqueue_struct *laundry_wq;
>
> @@ -1175,6 +1176,10 @@ alloc_init_deleg(struct nfs4_client *clp, struct n=
fs4_file *fp,
>         dp->dl_recalled =3D false;
>         nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
>                       &nfsd4_cb_recall_ops, NFSPROC4_CLNT_CB_RECALL);
> +       nfsd4_init_cb(&dp->dl_cb_fattr.ncf_getattr, dp->dl_stid.sc_client=
,
> +                       &nfsd4_cb_getattr_ops, NFSPROC4_CLNT_CB_GETATTR);
> +       dp->dl_cb_fattr.ncf_file_modified =3D false;
> +       dp->dl_cb_fattr.ncf_cb_bmap[0] =3D FATTR4_WORD0_CHANGE | FATTR4_W=
ORD0_SIZE;
>         get_nfs4_file(fp);
>         dp->dl_stid.sc_file =3D fp;
>         return dp;
> @@ -2882,11 +2887,49 @@ nfsd4_cb_recall_any_release(struct nfsd4_callback=
 *cb)
>         spin_unlock(&nn->client_lock);
>  }
>
> +static int
> +nfsd4_cb_getattr_done(struct nfsd4_callback *cb, struct rpc_task *task)
> +{
> +       struct nfs4_cb_fattr *ncf =3D
> +               container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
> +
> +       ncf->ncf_cb_status =3D task->tk_status;
> +       switch (task->tk_status) {
> +       case -NFS4ERR_DELAY:
> +               rpc_delay(task, 2 * HZ);
> +               return 0;
> +       default:
> +               return 1;
> +       }
> +}
> +
> +static void
> +nfsd4_cb_getattr_release(struct nfsd4_callback *cb)
> +{
> +       struct nfs4_cb_fattr *ncf =3D
> +               container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
> +
> +       clear_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags);
> +       wake_up_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY);
> +}
> +
>  static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops =3D {
>         .done           =3D nfsd4_cb_recall_any_done,
>         .release        =3D nfsd4_cb_recall_any_release,
>  };
>
> +static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops =3D {
> +       .done           =3D nfsd4_cb_getattr_done,
> +       .release        =3D nfsd4_cb_getattr_release,
> +};
> +
> +void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf)
> +{
> +       if (test_and_set_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags))
> +               return;
> +       nfsd4_run_cb(&ncf->ncf_getattr);
> +}
> +
>  static struct nfs4_client *create_client(struct xdr_netobj name,
>                 struct svc_rqst *rqstp, nfs4_verifier *verf)
>  {
> @@ -5591,6 +5634,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struc=
t nfs4_ol_stateid *stp,
>         int cb_up;
>         int status =3D 0;
>         u32 wdeleg =3D false;
> +       struct kstat stat;
> +       struct path path;
>
>         cb_up =3D nfsd4_cb_channel_good(oo->oo_owner.so_client);
>         open->op_recall =3D 0;
> @@ -5626,6 +5671,19 @@ nfs4_open_delegation(struct nfsd4_open *open, stru=
ct nfs4_ol_stateid *stp,
>         wdeleg =3D open->op_share_access & NFS4_SHARE_ACCESS_WRITE;
>         open->op_delegate_type =3D wdeleg ?
>                         NFS4_OPEN_DELEGATE_WRITE : NFS4_OPEN_DELEGATE_REA=
D;
> +       if (wdeleg) {
> +               path.mnt =3D currentfh->fh_export->ex_path.mnt;
> +               path.dentry =3D currentfh->fh_dentry;
> +               if (vfs_getattr(&path, &stat, STATX_BASIC_STATS,
> +                                               AT_STATX_SYNC_AS_STAT)) {
> +                       nfs4_put_stid(&dp->dl_stid);
> +                       destroy_delegation(dp);
> +                       goto out_no_deleg;
> +               }
> +               dp->dl_cb_fattr.ncf_cur_fsize =3D stat.size;
> +               dp->dl_cb_fattr.ncf_initial_cinfo =3D nfsd4_change_attrib=
ute(&stat,
> +                                                       d_inode(currentfh=
->fh_dentry));
> +       }
>         nfs4_put_stid(&dp->dl_stid);
>         return;
>  out_no_deleg:
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 76db2fe29624..5d7e11db8ccf 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2920,6 +2920,77 @@ nfsd4_encode_bitmap(struct xdr_stream *xdr, u32 bm=
val0, u32 bmval1, u32 bmval2)
>         return nfserr_resource;
>  }
>
> +static struct file_lock *
> +nfs4_wrdeleg_filelock(struct svc_rqst *rqstp, struct inode *inode)
> +{
> +       struct file_lock_context *ctx;
> +       struct file_lock *fl;
> +
> +       ctx =3D locks_inode_context(inode);
> +       if (!ctx)
> +               return NULL;
> +       spin_lock(&ctx->flc_lock);
> +       list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
> +               if (fl->fl_type =3D=3D F_WRLCK) {
> +                       spin_unlock(&ctx->flc_lock);
> +                       return fl;
> +               }
> +       }
> +       spin_unlock(&ctx->flc_lock);
> +       return NULL;
> +}
> +
> +static __be32
> +nfs4_handle_wrdeleg_conflict(struct svc_rqst *rqstp, struct inode *inode=
,
> +                       bool *modified, u64 *size)
> +{
> +       __be32 status;
> +       struct file_lock *fl;
> +       struct nfs4_delegation *dp;
> +       struct nfs4_cb_fattr *ncf;
> +       struct iattr attrs;
> +
> +       *modified =3D false;
> +       fl =3D nfs4_wrdeleg_filelock(rqstp, inode);
> +       if (!fl)
> +               return 0;
> +       dp =3D fl->fl_owner;
> +       ncf =3D &dp->dl_cb_fattr;
> +       if (dp->dl_recall.cb_clp =3D=3D *(rqstp->rq_lease_breaker))
> +               return 0;
> +
> +       refcount_inc(&dp->dl_stid.sc_count);
> +       nfs4_cb_getattr(&dp->dl_cb_fattr);
> +       wait_on_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY, TASK_INTERRUPTIB=
LE);
> +       if (ncf->ncf_cb_status) {
> +               status =3D nfserrno(nfsd_open_break_lease(inode, NFSD_MAY=
_READ));
> +               nfs4_put_stid(&dp->dl_stid);
> +               return status;
> +       }
> +       ncf->ncf_cur_fsize =3D ncf->ncf_cb_fsize;
> +       if (!ncf->ncf_file_modified &&
> +                       (ncf->ncf_initial_cinfo !=3D ncf->ncf_cb_change |=
|
> +                       ncf->ncf_cur_fsize !=3D ncf->ncf_cb_fsize)) {
> +               ncf->ncf_file_modified =3D true;
> +       }
> +
> +       if (ncf->ncf_file_modified) {
> +               /*
> +                * The server would not update the file's metadata
> +                * with the client's modified size.
> +                * nfsd4 change attribute is constructed from ctime.
> +                */
> +               attrs.ia_mtime =3D attrs.ia_ctime =3D current_time(inode)=
;
> +               attrs.ia_valid =3D ATTR_MTIME | ATTR_CTIME;
> +               setattr_copy(&nop_mnt_idmap, inode, &attrs);
> +               mark_inode_dirty(inode);
> +               *size =3D ncf->ncf_cur_fsize;
> +               *modified =3D true;
> +       }
> +       nfs4_put_stid(&dp->dl_stid);
> +       return 0;
> +}
> +
>  /*
>   * Note: @fhp can be NULL; in this case, we might have to compose the fi=
lehandle
>   * ourselves.
> @@ -2957,6 +3028,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct s=
vc_fh *fhp,
>                 .dentry =3D dentry,
>         };
>         struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
> +       bool file_modified;
> +       u64 size =3D 0;
>
>         BUG_ON(bmval1 & NFSD_WRITEONLY_ATTRS_WORD1);
>         BUG_ON(!nfsd_attrs_supported(minorversion, bmval));
> @@ -2966,6 +3039,12 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct =
svc_fh *fhp,
>                 if (status)
>                         goto out;
>         }
> +       if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
> +               status =3D nfs4_handle_wrdeleg_conflict(rqstp, d_inode(de=
ntry),
> +                                               &file_modified, &size);
> +               if (status)
> +                       goto out;
> +       }
>
>         err =3D vfs_getattr(&path, &stat,
>                           STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_=
COOKIE,
> @@ -3089,7 +3168,10 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct =
svc_fh *fhp,
>                 p =3D xdr_reserve_space(xdr, 8);
>                 if (!p)
>                         goto out_resource;
> -               p =3D xdr_encode_hyper(p, stat.size);
> +               if (file_modified)
> +                       p =3D xdr_encode_hyper(p, size);
> +               else
> +                       p =3D xdr_encode_hyper(p, stat.size);
>         }
>         if (bmval0 & FATTR4_WORD0_LINK_SUPPORT) {
>                 p =3D xdr_reserve_space(xdr, 4);
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 9fb69ed8ae80..b20b65fe89b4 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -121,6 +121,10 @@ struct nfs4_cb_fattr {
>         struct nfsd4_callback ncf_getattr;
>         u32 ncf_cb_status;
>         u32 ncf_cb_bmap[1];
> +       unsigned long ncf_cb_flags;
> +       bool ncf_file_modified;
> +       u64 ncf_initial_cinfo;
> +       u64 ncf_cur_fsize;
>
>         /* from CB_GETATTR reply */
>         u64 ncf_cb_change;
> @@ -744,6 +748,9 @@ extern void nfsd4_client_record_remove(struct nfs4_cl=
ient *clp);
>  extern int nfsd4_client_record_check(struct nfs4_client *clp);
>  extern void nfsd4_record_grace_done(struct nfsd_net *nn);
>
> +/* CB_GETTTAR */
> +extern void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf);
> +
>  static inline bool try_to_expire_client(struct nfs4_client *clp)
>  {
>         cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
> --
> 2.9.5
>
