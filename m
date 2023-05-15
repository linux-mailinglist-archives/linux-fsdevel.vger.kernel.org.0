Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B02703D19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 20:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243053AbjEOS6K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 14:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236441AbjEOS6I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 14:58:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBF1176CD;
        Mon, 15 May 2023 11:58:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5228563166;
        Mon, 15 May 2023 18:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38351C433D2;
        Mon, 15 May 2023 18:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684177085;
        bh=8gCXow9WMahAx42HevgNCo2nu7BNhWnDpAKvsxktiwE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RD7hFxsKjRebIrloduwVkSOMJNrCsJhH+iX/zeAT2AUJ/7kBzrrwrBwJ1UHxCMbVT
         bfF0lA6A0iNWXqIxLJOa8U/QYbj53zudi2+lGhsC4hWnFkEUKk7ZpowM8CsASurCvU
         wdN78qO1aJ55WPeGsdyMRj0gEaDpvU5uGjDDaUgfQtPoWb5rWW454Z2IjsX7jGIEGt
         zIxWW99kJmN+4wrAfnWOAQWyUXAy+KsBGa5jvTsIkZTCkKbrUrr50ERMM01ngcPAwU
         eZRkBnQOzNz3vUh+dv0Ro7komHv2pRn/YvUTB3yBXsA2nNc9FmOE0HHynYeU8Qq/Nh
         sTcPejPkc3BeA==
Message-ID: <5318a050cbe6e89ae0949c654545ae8998ff7795.camel@kernel.org>
Subject: Re: [PATCH v2 4/4] NFSD: handle GETATTR conflict with write
 delegation
From:   Jeff Layton <jlayton@kernel.org>
To:     dai.ngo@oracle.com, Olga Kornievskaia <aglo@umich.edu>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Mon, 15 May 2023 14:58:03 -0400
In-Reply-To: <392379f7-4e28-fae5-a799-00b4e35fe6fd@oracle.com>
References: <1684110038-11266-1-git-send-email-dai.ngo@oracle.com>
         <1684110038-11266-5-git-send-email-dai.ngo@oracle.com>
         <CAN-5tyH0GM8xOnLVDMQMn-tmoE-w_7N9ARmcwHq6ocySeoA1MQ@mail.gmail.com>
         <392379f7-4e28-fae5-a799-00b4e35fe6fd@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-05-15 at 11:26 -0700, dai.ngo@oracle.com wrote:
> On 5/15/23 11:14 AM, Olga Kornievskaia wrote:
> > On Sun, May 14, 2023 at 8:56=E2=80=AFPM Dai Ngo <dai.ngo@oracle.com> wr=
ote:
> > > If the GETATTR request on a file that has write delegation in effect
> > > and the request attributes include the change info and size attribute
> > > then the request is handled as below:
> > >=20
> > > Server sends CB_GETATTR to client to get the latest change info and f=
ile
> > > size. If these values are the same as the server's cached values then
> > > the GETATTR proceeds as normal.
> > >=20
> > > If either the change info or file size is different from the server's
> > > cached values, or the file was already marked as modified, then:
> > >=20
> > >     . update time_modify and time_metadata into file's metadata
> > >       with current time
> > >=20
> > >     . encode GETATTR as normal except the file size is encoded with
> > >       the value returned from CB_GETATTR
> > >=20
> > >     . mark the file as modified
> > >=20
> > > If the CB_GETATTR fails for any reasons, the delegation is recalled
> > > and NFS4ERR_DELAY is returned for the GETATTR.
> > Hi Dai,
> >=20
> > I'm curious what does the server gain by implementing handling of
> > GETATTR with delegations? As far as I can tell it is not strictly
> > required by the RFC(s). When the file is being written any attempt at
> > querying its attribute is immediately stale.
>=20
> Yes, you're right that handling of GETATTR with delegations is not
> required by the spec. The only benefit I see is that the server
> provides a more accurate state of the file as whether the file has
> been changed/updated since the client's last GETATTR. This allows
> the app on the client to take appropriate action (whatever that
> might be) when sharing files among multiple clients.
>=20



From RFC 8881 10.4.3:

"It should be noted that the server is under no obligation to use
CB_GETATTR, and therefore the server MAY simply recall the delegation to
avoid its use."

As I see it, the main benefit is that you avoid having to recall a write
delegation when someone does a drive-by stat() on the file (e.g. due to
a "ls -l" in its parent directory).

> >=20
> > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > ---
> > >   fs/nfsd/nfs4state.c | 58 ++++++++++++++++++++++++++++++++++++
> > >   fs/nfsd/nfs4xdr.c   | 84 ++++++++++++++++++++++++++++++++++++++++++=
++++++++++-
> > >   fs/nfsd/state.h     |  7 +++++
> > >   3 files changed, 148 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index 09a9e16407f9..fb305b28a090 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -127,6 +127,7 @@ static void free_session(struct nfsd4_session *);
> > >=20
> > >   static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
> > >   static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
> > > +static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops;
> > >=20
> > >   static struct workqueue_struct *laundry_wq;
> > >=20
> > > @@ -1175,6 +1176,10 @@ alloc_init_deleg(struct nfs4_client *clp, stru=
ct nfs4_file *fp,
> > >          dp->dl_recalled =3D false;
> > >          nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
> > >                        &nfsd4_cb_recall_ops, NFSPROC4_CLNT_CB_RECALL)=
;
> > > +       nfsd4_init_cb(&dp->dl_cb_fattr.ncf_getattr, dp->dl_stid.sc_cl=
ient,
> > > +                       &nfsd4_cb_getattr_ops, NFSPROC4_CLNT_CB_GETAT=
TR);
> > > +       dp->dl_cb_fattr.ncf_file_modified =3D false;
> > > +       dp->dl_cb_fattr.ncf_cb_bmap[0] =3D FATTR4_WORD0_CHANGE | FATT=
R4_WORD0_SIZE;
> > >          get_nfs4_file(fp);
> > >          dp->dl_stid.sc_file =3D fp;
> > >          return dp;
> > > @@ -2882,11 +2887,49 @@ nfsd4_cb_recall_any_release(struct nfsd4_call=
back *cb)
> > >          spin_unlock(&nn->client_lock);
> > >   }
> > >=20
> > > +static int
> > > +nfsd4_cb_getattr_done(struct nfsd4_callback *cb, struct rpc_task *ta=
sk)
> > > +{
> > > +       struct nfs4_cb_fattr *ncf =3D
> > > +               container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
> > > +
> > > +       ncf->ncf_cb_status =3D task->tk_status;
> > > +       switch (task->tk_status) {
> > > +       case -NFS4ERR_DELAY:
> > > +               rpc_delay(task, 2 * HZ);
> > > +               return 0;
> > > +       default:
> > > +               return 1;
> > > +       }
> > > +}
> > > +
> > > +static void
> > > +nfsd4_cb_getattr_release(struct nfsd4_callback *cb)
> > > +{
> > > +       struct nfs4_cb_fattr *ncf =3D
> > > +               container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
> > > +
> > > +       clear_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags);
> > > +       wake_up_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY);
> > > +}
> > > +
> > >   static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops =3D =
{
> > >          .done           =3D nfsd4_cb_recall_any_done,
> > >          .release        =3D nfsd4_cb_recall_any_release,
> > >   };
> > >=20
> > > +static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops =3D {
> > > +       .done           =3D nfsd4_cb_getattr_done,
> > > +       .release        =3D nfsd4_cb_getattr_release,
> > > +};
> > > +
> > > +void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf)
> > > +{
> > > +       if (test_and_set_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags))
> > > +               return;
> > > +       nfsd4_run_cb(&ncf->ncf_getattr);
> > > +}
> > > +
> > >   static struct nfs4_client *create_client(struct xdr_netobj name,
> > >                  struct svc_rqst *rqstp, nfs4_verifier *verf)
> > >   {
> > > @@ -5591,6 +5634,8 @@ nfs4_open_delegation(struct nfsd4_open *open, s=
truct nfs4_ol_stateid *stp,
> > >          int cb_up;
> > >          int status =3D 0;
> > >          u32 wdeleg =3D false;
> > > +       struct kstat stat;
> > > +       struct path path;
> > >=20
> > >          cb_up =3D nfsd4_cb_channel_good(oo->oo_owner.so_client);
> > >          open->op_recall =3D 0;
> > > @@ -5626,6 +5671,19 @@ nfs4_open_delegation(struct nfsd4_open *open, =
struct nfs4_ol_stateid *stp,
> > >          wdeleg =3D open->op_share_access & NFS4_SHARE_ACCESS_WRITE;
> > >          open->op_delegate_type =3D wdeleg ?
> > >                          NFS4_OPEN_DELEGATE_WRITE : NFS4_OPEN_DELEGAT=
E_READ;
> > > +       if (wdeleg) {
> > > +               path.mnt =3D currentfh->fh_export->ex_path.mnt;
> > > +               path.dentry =3D currentfh->fh_dentry;
> > > +               if (vfs_getattr(&path, &stat, STATX_BASIC_STATS,
> > > +                                               AT_STATX_SYNC_AS_STAT=
)) {
> > > +                       nfs4_put_stid(&dp->dl_stid);
> > > +                       destroy_delegation(dp);
> > > +                       goto out_no_deleg;
> > > +               }
> > > +               dp->dl_cb_fattr.ncf_cur_fsize =3D stat.size;
> > > +               dp->dl_cb_fattr.ncf_initial_cinfo =3D nfsd4_change_at=
tribute(&stat,
> > > +                                                       d_inode(curre=
ntfh->fh_dentry));
> > > +       }
> > >          nfs4_put_stid(&dp->dl_stid);
> > >          return;
> > >   out_no_deleg:
> > > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > > index 76db2fe29624..5d7e11db8ccf 100644
> > > --- a/fs/nfsd/nfs4xdr.c
> > > +++ b/fs/nfsd/nfs4xdr.c
> > > @@ -2920,6 +2920,77 @@ nfsd4_encode_bitmap(struct xdr_stream *xdr, u3=
2 bmval0, u32 bmval1, u32 bmval2)
> > >          return nfserr_resource;
> > >   }
> > >=20
> > > +static struct file_lock *
> > > +nfs4_wrdeleg_filelock(struct svc_rqst *rqstp, struct inode *inode)
> > > +{
> > > +       struct file_lock_context *ctx;
> > > +       struct file_lock *fl;
> > > +
> > > +       ctx =3D locks_inode_context(inode);
> > > +       if (!ctx)
> > > +               return NULL;
> > > +       spin_lock(&ctx->flc_lock);
> > > +       list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
> > > +               if (fl->fl_type =3D=3D F_WRLCK) {
> > > +                       spin_unlock(&ctx->flc_lock);
> > > +                       return fl;
> > > +               }
> > > +       }
> > > +       spin_unlock(&ctx->flc_lock);
> > > +       return NULL;
> > > +}
> > > +
> > > +static __be32
> > > +nfs4_handle_wrdeleg_conflict(struct svc_rqst *rqstp, struct inode *i=
node,
> > > +                       bool *modified, u64 *size)
> > > +{
> > > +       __be32 status;
> > > +       struct file_lock *fl;
> > > +       struct nfs4_delegation *dp;
> > > +       struct nfs4_cb_fattr *ncf;
> > > +       struct iattr attrs;
> > > +
> > > +       *modified =3D false;
> > > +       fl =3D nfs4_wrdeleg_filelock(rqstp, inode);
> > > +       if (!fl)
> > > +               return 0;
> > > +       dp =3D fl->fl_owner;
> > > +       ncf =3D &dp->dl_cb_fattr;
> > > +       if (dp->dl_recall.cb_clp =3D=3D *(rqstp->rq_lease_breaker))
> > > +               return 0;
> > > +
> > > +       refcount_inc(&dp->dl_stid.sc_count);
> > > +       nfs4_cb_getattr(&dp->dl_cb_fattr);
> > > +       wait_on_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY, TASK_INTERRU=
PTIBLE);
> > > +       if (ncf->ncf_cb_status) {
> > > +               status =3D nfserrno(nfsd_open_break_lease(inode, NFSD=
_MAY_READ));
> > > +               nfs4_put_stid(&dp->dl_stid);
> > > +               return status;
> > > +       }
> > > +       ncf->ncf_cur_fsize =3D ncf->ncf_cb_fsize;
> > > +       if (!ncf->ncf_file_modified &&
> > > +                       (ncf->ncf_initial_cinfo !=3D ncf->ncf_cb_chan=
ge ||
> > > +                       ncf->ncf_cur_fsize !=3D ncf->ncf_cb_fsize)) {
> > > +               ncf->ncf_file_modified =3D true;
> > > +       }
> > > +
> > > +       if (ncf->ncf_file_modified) {
> > > +               /*
> > > +                * The server would not update the file's metadata
> > > +                * with the client's modified size.
> > > +                * nfsd4 change attribute is constructed from ctime.
> > > +                */
> > > +               attrs.ia_mtime =3D attrs.ia_ctime =3D current_time(in=
ode);
> > > +               attrs.ia_valid =3D ATTR_MTIME | ATTR_CTIME;
> > > +               setattr_copy(&nop_mnt_idmap, inode, &attrs);
> > > +               mark_inode_dirty(inode);
> > > +               *size =3D ncf->ncf_cur_fsize;
> > > +               *modified =3D true;
> > > +       }
> > > +       nfs4_put_stid(&dp->dl_stid);
> > > +       return 0;
> > > +}
> > > +
> > >   /*
> > >    * Note: @fhp can be NULL; in this case, we might have to compose t=
he filehandle
> > >    * ourselves.
> > > @@ -2957,6 +3028,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, stru=
ct svc_fh *fhp,
> > >                  .dentry =3D dentry,
> > >          };
> > >          struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp), nfsd_net=
_id);
> > > +       bool file_modified;
> > > +       u64 size =3D 0;
> > >=20
> > >          BUG_ON(bmval1 & NFSD_WRITEONLY_ATTRS_WORD1);
> > >          BUG_ON(!nfsd_attrs_supported(minorversion, bmval));
> > > @@ -2966,6 +3039,12 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, str=
uct svc_fh *fhp,
> > >                  if (status)
> > >                          goto out;
> > >          }
> > > +       if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
> > > +               status =3D nfs4_handle_wrdeleg_conflict(rqstp, d_inod=
e(dentry),
> > > +                                               &file_modified, &size=
);
> > > +               if (status)
> > > +                       goto out;
> > > +       }
> > >=20
> > >          err =3D vfs_getattr(&path, &stat,
> > >                            STATX_BASIC_STATS | STATX_BTIME | STATX_CH=
ANGE_COOKIE,
> > > @@ -3089,7 +3168,10 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, str=
uct svc_fh *fhp,
> > >                  p =3D xdr_reserve_space(xdr, 8);
> > >                  if (!p)
> > >                          goto out_resource;
> > > -               p =3D xdr_encode_hyper(p, stat.size);
> > > +               if (file_modified)
> > > +                       p =3D xdr_encode_hyper(p, size);
> > > +               else
> > > +                       p =3D xdr_encode_hyper(p, stat.size);
> > >          }
> > >          if (bmval0 & FATTR4_WORD0_LINK_SUPPORT) {
> > >                  p =3D xdr_reserve_space(xdr, 4);
> > > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > > index 9fb69ed8ae80..b20b65fe89b4 100644
> > > --- a/fs/nfsd/state.h
> > > +++ b/fs/nfsd/state.h
> > > @@ -121,6 +121,10 @@ struct nfs4_cb_fattr {
> > >          struct nfsd4_callback ncf_getattr;
> > >          u32 ncf_cb_status;
> > >          u32 ncf_cb_bmap[1];
> > > +       unsigned long ncf_cb_flags;
> > > +       bool ncf_file_modified;
> > > +       u64 ncf_initial_cinfo;
> > > +       u64 ncf_cur_fsize;
> > >=20
> > >          /* from CB_GETATTR reply */
> > >          u64 ncf_cb_change;
> > > @@ -744,6 +748,9 @@ extern void nfsd4_client_record_remove(struct nfs=
4_client *clp);
> > >   extern int nfsd4_client_record_check(struct nfs4_client *clp);
> > >   extern void nfsd4_record_grace_done(struct nfsd_net *nn);
> > >=20
> > > +/* CB_GETTTAR */
> > > +extern void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf);
> > > +
> > >   static inline bool try_to_expire_client(struct nfs4_client *clp)
> > >   {
> > >          cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
> > > --
> > > 2.9.5
> > >=20

--=20
Jeff Layton <jlayton@kernel.org>
