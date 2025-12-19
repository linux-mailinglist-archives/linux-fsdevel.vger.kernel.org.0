Return-Path: <linux-fsdevel+bounces-71756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71849CD0E48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 17:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F19E3072AE3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 16:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E1F36C0A7;
	Fri, 19 Dec 2025 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="ckuTSi2O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845CE36BCD0
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766159947; cv=none; b=BtJ0/9C+6D6rRhkx/IHvNWhLJQVZatotrNX7GN8jrDmp5j5iqJS4W/cZKy7Rd9q+h+32kV+3knlfKLXrRKSHpyOvLoBxbNJpCnpvvkMRUixQCX5TZSbIWkBFr9or0ynuqNARvY9+oY1jBBFaFqLdNA5ji/2It2JKnC8nDTo/yq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766159947; c=relaxed/simple;
	bh=1E7MmYDGWMOe+l2ttMwLxR4y6eJzpT2TAo5nFuApT8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sukUDOXwpseiw501j+QctzQY60AJsIHHJ3iE0KZnGlrPQnAJ+gyMTwbKXPi9QBUfQGM9Bv85jVyg6hRK4n+AbcSt4W5H2lq3GVjT12nooncQLt3ViDhi8a8PLHuOF65IE3y4pMqRuiQXHcvF+hLg+ykC1Bch6KrjSnXXPxoXvro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=ckuTSi2O; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-37a2dced861so28544581fa.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 07:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1766159943; x=1766764743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrh7jHERpec8/lw/IMy3jFvFCgQEpQfa0gIi+oTxJ/E=;
        b=ckuTSi2O2X7BR6ZwSl39ecY0UUnvC+GATdBpUsixxn72VMQYa8eV17KvA7UoweAV/0
         5ybvqE7cc+sTASgxxetAEWTuRLM11lKHIoY7rwyaLNzOdeyO04Y2Tqe0qEGSuMKE9HNR
         0nA5aon9QcVk+jOHvSgEVwDR8GMK5YvGy1f7eNO1yvYYZjv1wsd4gyKbo0OZhMuTSpDC
         G9KSLgvKgyvCdpVnp9A7qkDHj9qs/2AHSPzHAFy2ZHgZwr4tPExwK4Jyl7Z3G+4DtZQc
         tXThzfAtDxxUJpL3s/7ZnNswKUzoxE3YyBotD1dj0yC0eiLkZ0/CEnRAWDnx/mZePXuH
         mz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766159943; x=1766764743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rrh7jHERpec8/lw/IMy3jFvFCgQEpQfa0gIi+oTxJ/E=;
        b=JhcUCYHoERmL1ex6K4xpxp9CMKFjCZR80EPBtTPP0rnJSgjJuYPebEHtQQs5Sljwsf
         kNHBSvhSaP35Sp00HwuwLACkbkoQhjC9TWRDJqkizwCOpGPBy8RH/bGm039qWL6bNGw8
         TrSojKqZH3g08gTfgS6bffhoTlamVYlyPvvgaRu2nz7+JRBYplpKJN7UdvgtCRy/eI48
         lVstFsHD/wZ4BEEqHpQHrWjHA8j9wPkLYwKLAH8Mo9uZ2iyH12ya7gTWHB8RbevFIUTv
         wnd8vX5UCD2Mro0R+c35r7a22fXzMwNmEmOJ4I6C1YcZ0+JoTukOmvFt3qo7tB4JzewZ
         JFHA==
X-Forwarded-Encrypted: i=1; AJvYcCWtP+7mPDzuAmLL8i4SvIiPEMnXrQS+1XMEfBQ6CVaF9rBrBTkbZZ12BAL5OeSJlfV6UliTBNghpIzsePHT@vger.kernel.org
X-Gm-Message-State: AOJu0YwNzFvu9AhlE5C98cU16z8Wi97cOrHMlvEF9oFvzJdcxj0PnvfK
	Gq9cInIiy7+xiCgjYXB6/HNaQoT0XVu0jTBT6zgdt+o4wSz+qIbbfCdh30KfqNb/TJkfQImfELC
	5iJyEPnonv2/CwPFo5nH8o2u3fSGH8og=
X-Gm-Gg: AY/fxX6pXVHfC+zNX4lFLmtwM4TJLMMSEoUKOec2hXlPxbPFG7vGpDB3qXfEO/VJ8Dc
	cCf77aWNef6OsxBc2VAPxOXhVGV+3w92atZY5M2Klv7AK6b3shwOmbdn5Ss13omFHMh8JH+N6/S
	m/oE4i8qKYxIY+n5KHAZ5aJ+Bt5wQAZ1iJIfDumd2v0GjDBDCW+o5M4mA5RCVDjqblW3tiroj3B
	a8C/bWYfhjPtTCTVoFBWtJFkIld06wBt/w48ishldBBkztQR5lqwpEfDL8Wdjstv06tjhPkNnm8
	5oFKwxWFar23N2ozHRgbIOw7GjdKVA==
X-Google-Smtp-Source: AGHT+IF1hdJMju8LoxAJpnCi39hZ3gi9AWJtDM753Wh1aRc/UZqyoAzCON2d7640WhenuuLr6vzwD1Ot507SaGLqvvQ=
X-Received: by 2002:a05:651c:3050:b0:376:3792:1a9b with SMTP id
 38308e7fff4ca-38113295431mr21296221fa.21.1766159943229; Fri, 19 Dec 2025
 07:59:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730-nfsd-testing-v4-0-7f5730570a52@kernel.org> <20250730-nfsd-testing-v4-8-7f5730570a52@kernel.org>
In-Reply-To: <20250730-nfsd-testing-v4-8-7f5730570a52@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 19 Dec 2025 10:58:51 -0500
X-Gm-Features: AQt7F2rtPaUaHKhG8VG2lFt-mPN-yzelYal5wYAHVQ-QLjtFmZxg9X3LrdZkiSM
Message-ID: <CAN-5tyEjYRFrJ7Gc4S8KwAZUuF-uz6ovPa4-_ynt+GGVqJHN_A@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] nfsd: freeze c/mtime updates with outstanding
 WRITE_ATTRS delegation
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Chuck Lever <chuck.lever@oracle.com>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@hammerspace.com>, 
	Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

I narrowed down the upstream failure for generic/215 and generic/407
to this commit.

Let's consider first where the kernel is compiled with delegated
attributes off (but it also fails just the same if the delegated
attributes are compiled in).

I don't understand why the code unconditionally changed to call
nfsd4_finalize_deleg_timestamps() which I think the main driver behind
the failure.

Running generic/407 there is an OPEN (which gives out a write
delegation) and returns a change id, then on this filehandle there is
a SETATTR (with a getattr) which returns a new changeid. Then there is
a CLONE where the filehandle is the destination filehandle on which
there is a getattr which returns unchanged changeid/modify time (bad).
Then there is a DELEGRETURN (with a getattr) which again returns same
change id. Test fails.

Prior to this commit. The changeid/modify time is different in CLONE
and DELEGRETURN -- test passes.

Now let me describe what happens with delegated attributes enabled.
OPEN returns delegated attributes delegation, included getattr return
a changeid. Then CLONE is done, the included gettattr returns a
different (from open's) changeid (different time_modify). Then there
is SETATTR+GEATTR+DELEGRETURN compound from the client (which carries
a time_deleg_modify value different from above). Server in getattr
replies with changeid same as in clone and mtime with the value client
provided. So I'm not sure exactly why the test fails here but that's a
different problem as my focus is on "delegation attribute off option"
at the moment.

I don't know if this is the correct fix or not but perhaps we
shouldn't unconditionally be setting this mode? (note this fix only
fixes the delegattributes off. however i have no claims that this
patch is what broke 215/407 for delegated attributes on. Something
else is in play there). If this solution is acceptable, I can send a
patch.

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 81fa7cc6c77b..624cc6ab2802 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6318,7 +6318,8 @@ nfs4_open_delegation(struct svc_rqst *rqstp,
struct nfsd4_open *open,
                dp->dl_ctime =3D stat.ctime;
                dp->dl_mtime =3D stat.mtime;
                spin_lock(&f->f_lock);
-               f->f_mode |=3D FMODE_NOCMTIME;
+               if (deleg_ts)
+                       f->f_mode |=3D FMODE_NOCMTIME;
                spin_unlock(&f->f_lock);
                trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
        } else {


On Wed, Jul 30, 2025 at 9:27=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Instead of allowing the ctime to roll backward with a WRITE_ATTRS
> delegation, set FMODE_NOCMTIME on the file and have it skip mtime and
> ctime updates.
>
> It is possible that the client will never send a SETATTR to set the
> times before returning the delegation. Add two new bools to struct
> nfs4_delegation:
>
> dl_written: tracks whether the file has been written since the
> delegation was granted. This is set in the WRITE and LAYOUTCOMMIT
> handlers.
>
> dl_setattr: tracks whether the client has sent at least one valid
> mtime that can also update the ctime in a SETATTR.
>
> When unlocking the lease for the delegation, clear FMODE_NOCMTIME. If
> the file has been written, but no setattr for the delegated mtime and
> ctime has been done, update the timestamps to current_time().
>
> Suggested-by: NeilBrown <neil@brown.name>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4proc.c  | 26 ++++++++++++++++++++++++--
>  fs/nfsd/nfs4state.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/state.h     |  4 +++-
>  3 files changed, 69 insertions(+), 3 deletions(-)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index aacd912a5fbe29ba5ccac206d13243308f36b7fa..bfebe6e25638a76d3607bb79a=
239bdc92e42e7b5 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1151,7 +1151,9 @@ vet_deleg_attrs(struct nfsd4_setattr *setattr, stru=
ct nfs4_delegation *dp)
>         if (setattr->sa_bmval[2] & FATTR4_WORD2_TIME_DELEG_MODIFY) {
>                 if (nfsd4_vet_deleg_time(&iattr->ia_mtime, &dp->dl_mtime,=
 &now)) {
>                         iattr->ia_ctime =3D iattr->ia_mtime;
> -                       if (!nfsd4_vet_deleg_time(&iattr->ia_ctime, &dp->=
dl_ctime, &now))
> +                       if (nfsd4_vet_deleg_time(&iattr->ia_ctime, &dp->d=
l_ctime, &now))
> +                               dp->dl_setattr =3D true;
> +                       else
>                                 iattr->ia_valid &=3D ~(ATTR_CTIME | ATTR_=
CTIME_SET);
>                 } else {
>                         iattr->ia_valid &=3D ~(ATTR_CTIME | ATTR_CTIME_SE=
T |
> @@ -1238,12 +1240,26 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd=
4_compound_state *cstate,
>         return status;
>  }
>
> +static void nfsd4_file_mark_deleg_written(struct nfs4_file *fi)
> +{
> +       spin_lock(&fi->fi_lock);
> +       if (!list_empty(&fi->fi_delegations)) {
> +               struct nfs4_delegation *dp =3D list_first_entry(&fi->fi_d=
elegations,
> +                                                             struct nfs4=
_delegation, dl_perfile);
> +
> +               if (dp->dl_type =3D=3D OPEN_DELEGATE_WRITE_ATTRS_DELEG)
> +                       dp->dl_written =3D true;
> +       }
> +       spin_unlock(&fi->fi_lock);
> +}
> +
>  static __be32
>  nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>             union nfsd4_op_u *u)
>  {
>         struct nfsd4_write *write =3D &u->write;
>         stateid_t *stateid =3D &write->wr_stateid;
> +       struct nfs4_stid *stid =3D NULL;
>         struct nfsd_file *nf =3D NULL;
>         __be32 status =3D nfs_ok;
>         unsigned long cnt;
> @@ -1256,10 +1272,15 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_=
compound_state *cstate,
>         trace_nfsd_write_start(rqstp, &cstate->current_fh,
>                                write->wr_offset, cnt);
>         status =3D nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->cur=
rent_fh,
> -                                               stateid, WR_STATE, &nf, N=
ULL);
> +                                               stateid, WR_STATE, &nf, &=
stid);
>         if (status)
>                 return status;
>
> +       if (stid) {
> +               nfsd4_file_mark_deleg_written(stid->sc_file);
> +               nfs4_put_stid(stid);
> +       }
> +
>         write->wr_how_written =3D write->wr_stable_how;
>         status =3D nfsd_vfs_write(rqstp, &cstate->current_fh, nf,
>                                 write->wr_offset, &write->wr_payload,
> @@ -2550,6 +2571,7 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
>         mutex_unlock(&ls->ls_mutex);
>
>         nfserr =3D ops->proc_layoutcommit(inode, rqstp, lcp);
> +       nfsd4_file_mark_deleg_written(ls->ls_stid.sc_file);
>         nfs4_put_stid(&ls->ls_stid);
>  out:
>         return nfserr;
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 205ee8cc6fa2b9f74d08f7938b323d03bdf8286c..81fa7cc6c77b3cdc5ff22bc60=
ab0654f95dc258d 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1222,6 +1222,42 @@ static void put_deleg_file(struct nfs4_file *fp)
>                 nfs4_file_put_access(fp, NFS4_SHARE_ACCESS_READ);
>  }
>
> +static void nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, =
struct file *f)
> +{
> +       struct iattr ia =3D { .ia_valid =3D ATTR_ATIME | ATTR_CTIME | ATT=
R_MTIME };
> +       struct inode *inode =3D file_inode(f);
> +       int ret;
> +
> +       /* don't do anything if FMODE_NOCMTIME isn't set */
> +       if ((READ_ONCE(f->f_mode) & FMODE_NOCMTIME) =3D=3D 0)
> +               return;
> +
> +       spin_lock(&f->f_lock);
> +       f->f_mode &=3D ~FMODE_NOCMTIME;
> +       spin_unlock(&f->f_lock);
> +
> +       /* was it never written? */
> +       if (!dp->dl_written)
> +               return;
> +
> +       /* did it get a setattr for the timestamps at some point? */
> +       if (dp->dl_setattr)
> +               return;
> +
> +       /* Stamp everything to "now" */
> +       inode_lock(inode);
> +       ret =3D notify_change(&nop_mnt_idmap, f->f_path.dentry, &ia, NULL=
);
> +       inode_unlock(inode);
> +       if (ret) {
> +               struct inode *inode =3D file_inode(f);
> +
> +               pr_notice_ratelimited("Unable to update timestamps on ino=
de %02x:%02x:%lu: %d\n",
> +                                       MAJOR(inode->i_sb->s_dev),
> +                                       MINOR(inode->i_sb->s_dev),
> +                                       inode->i_ino, ret);
> +       }
> +}
> +
>  static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
>  {
>         struct nfs4_file *fp =3D dp->dl_stid.sc_file;
> @@ -1229,6 +1265,7 @@ static void nfs4_unlock_deleg_lease(struct nfs4_del=
egation *dp)
>
>         WARN_ON_ONCE(!fp->fi_delegees);
>
> +       nfsd4_finalize_deleg_timestamps(dp, nf->nf_file);
>         kernel_setlease(nf->nf_file, F_UNLCK, NULL, (void **)&dp);
>         put_deleg_file(fp);
>  }
> @@ -6265,6 +6302,8 @@ nfs4_open_delegation(struct svc_rqst *rqstp, struct=
 nfsd4_open *open,
>         memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeo=
f(dp->dl_stid.sc_stateid));
>
>         if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> +               struct file *f =3D dp->dl_stid.sc_file->fi_deleg_file->nf=
_file;
> +
>                 if (!nfsd4_add_rdaccess_to_wrdeleg(rqstp, open, fh, stp) =
||
>                                 !nfs4_delegation_stat(dp, currentfh, &sta=
t)) {
>                         nfs4_put_stid(&dp->dl_stid);
> @@ -6278,6 +6317,9 @@ nfs4_open_delegation(struct svc_rqst *rqstp, struct=
 nfsd4_open *open,
>                 dp->dl_atime =3D stat.atime;
>                 dp->dl_ctime =3D stat.ctime;
>                 dp->dl_mtime =3D stat.mtime;
> +               spin_lock(&f->f_lock);
> +               f->f_mode |=3D FMODE_NOCMTIME;
> +               spin_unlock(&f->f_lock);
>                 trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
>         } else {
>                 open->op_delegate_type =3D deleg_ts && nfs4_delegation_st=
at(dp, currentfh, &stat) ?
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index bf9436cdb93c5dd5502ecf83433ea311e3678711..b6ac0f37e9cdfcfddde5861c8=
c0c51bad60101b7 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -217,10 +217,12 @@ struct nfs4_delegation {
>         struct nfs4_clnt_odstate *dl_clnt_odstate;
>         time64_t                dl_time;
>         u32                     dl_type;
> -/* For recall: */
> +       /* For recall: */
>         int                     dl_retries;
>         struct nfsd4_callback   dl_recall;
>         bool                    dl_recalled;
> +       bool                    dl_written;
> +       bool                    dl_setattr;
>
>         /* for CB_GETATTR */
>         struct nfs4_cb_fattr    dl_cb_fattr;
>
> --
> 2.50.1
>
>

