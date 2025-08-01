Return-Path: <linux-fsdevel+bounces-56497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCE6B17AC8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 03:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3D36268B2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 01:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E6D13B58D;
	Fri,  1 Aug 2025 01:20:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D597D4207F;
	Fri,  1 Aug 2025 01:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754011208; cv=none; b=nyJIknov3teUxspCpnPmKdFDEd8YYIc6XrekvyL0frTs+9Qk5fYm5LlbqCQTpBkYKuGjSge80O9D10Oc33OIJ27bKotle9B2NTsaP0Qm/j0JGSqn8A4q1veOHOs77aUjvwYfdr/Jry8DMK7m2zXNsbjI1CplS93v/slRlHFJT1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754011208; c=relaxed/simple;
	bh=qhtL3kaBwtwXJpYb7s2yew2UqErPiOBEzMW6cuZJSF8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Xmre/7NB6uiCdYLLe2eydF0W084q9CeTyTw68Wkd/pjNSJMq+Bx+CQY28eyqv+9hJd8RRu6QDKV+yyuQ/if3KqboiH0se+PITekH2LWqI+14UEvDPJV1bMXjiEEVstbAoqID/Z1kPzIqH9fmdeNjeJBEOffy/TRh9AuQ0nkk3Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uheR3-0047RW-Uz;
	Fri, 01 Aug 2025 01:19:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@hammerspace.com>,
 "Anna Schumaker" <anna@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH v4 8/8] nfsd: freeze c/mtime updates with outstanding
 WRITE_ATTRS delegation
In-reply-to: <20250730-nfsd-testing-v4-8-7f5730570a52@kernel.org>
References: <20250730-nfsd-testing-v4-0-7f5730570a52@kernel.org>,
 <20250730-nfsd-testing-v4-8-7f5730570a52@kernel.org>
Date: Fri, 01 Aug 2025 11:19:51 +1000
Message-id: <175401119116.2234665.1029066014854377072@noble.neil.brown.name>

On Wed, 30 Jul 2025, Jeff Layton wrote:
> Instead of allowing the ctime to roll backward with a WRITE_ATTRS
> delegation, set FMODE_NOCMTIME on the file and have it skip mtime and
> ctime updates.
>=20
> It is possible that the client will never send a SETATTR to set the
> times before returning the delegation. Add two new bools to struct
> nfs4_delegation:
>=20
> dl_written: tracks whether the file has been written since the
> delegation was granted. This is set in the WRITE and LAYOUTCOMMIT
> handlers.
>=20
> dl_setattr: tracks whether the client has sent at least one valid
> mtime that can also update the ctime in a SETATTR.

Do we really need both of these?
Could we set dl_written on a write and clear it on a setattr that sets
mtime/ctime?=20
Then on close, if it is still set we force an mtime update.

I would be inclined to put this bit in ->f_mode setting it precisely when
FMODE_NOCMTIME is uses to skip the update.  (There are 4 spare fmode bits).

But none of that need delay the current patchset which looks good to me
(though I haven't dug quite enough to give a Reviewed-by).

Thanks,
NeilBRown

>=20
> When unlocking the lease for the delegation, clear FMODE_NOCMTIME. If
> the file has been written, but no setattr for the delegated mtime and
> ctime has been done, update the timestamps to current_time().
>=20
> Suggested-by: NeilBrown <neil@brown.name>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4proc.c  | 26 ++++++++++++++++++++++++--
>  fs/nfsd/nfs4state.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/state.h     |  4 +++-
>  3 files changed, 69 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index aacd912a5fbe29ba5ccac206d13243308f36b7fa..bfebe6e25638a76d3607bb79a23=
9bdc92e42e7b5 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1151,7 +1151,9 @@ vet_deleg_attrs(struct nfsd4_setattr *setattr, struct=
 nfs4_delegation *dp)
>  	if (setattr->sa_bmval[2] & FATTR4_WORD2_TIME_DELEG_MODIFY) {
>  		if (nfsd4_vet_deleg_time(&iattr->ia_mtime, &dp->dl_mtime, &now)) {
>  			iattr->ia_ctime =3D iattr->ia_mtime;
> -			if (!nfsd4_vet_deleg_time(&iattr->ia_ctime, &dp->dl_ctime, &now))
> +			if (nfsd4_vet_deleg_time(&iattr->ia_ctime, &dp->dl_ctime, &now))
> +				dp->dl_setattr =3D true;
> +			else
>  				iattr->ia_valid &=3D ~(ATTR_CTIME | ATTR_CTIME_SET);
>  		} else {
>  			iattr->ia_valid &=3D ~(ATTR_CTIME | ATTR_CTIME_SET |
> @@ -1238,12 +1240,26 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_=
compound_state *cstate,
>  	return status;
>  }
> =20
> +static void nfsd4_file_mark_deleg_written(struct nfs4_file *fi)
> +{
> +	spin_lock(&fi->fi_lock);
> +	if (!list_empty(&fi->fi_delegations)) {
> +		struct nfs4_delegation *dp =3D list_first_entry(&fi->fi_delegations,
> +							      struct nfs4_delegation, dl_perfile);
> +
> +		if (dp->dl_type =3D=3D OPEN_DELEGATE_WRITE_ATTRS_DELEG)
> +			dp->dl_written =3D true;
> +	}
> +	spin_unlock(&fi->fi_lock);
> +}
> +
>  static __be32
>  nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	    union nfsd4_op_u *u)
>  {
>  	struct nfsd4_write *write =3D &u->write;
>  	stateid_t *stateid =3D &write->wr_stateid;
> +	struct nfs4_stid *stid =3D NULL;
>  	struct nfsd_file *nf =3D NULL;
>  	__be32 status =3D nfs_ok;
>  	unsigned long cnt;
> @@ -1256,10 +1272,15 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
>  	trace_nfsd_write_start(rqstp, &cstate->current_fh,
>  			       write->wr_offset, cnt);
>  	status =3D nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
> -						stateid, WR_STATE, &nf, NULL);
> +						stateid, WR_STATE, &nf, &stid);
>  	if (status)
>  		return status;
> =20
> +	if (stid) {
> +		nfsd4_file_mark_deleg_written(stid->sc_file);
> +		nfs4_put_stid(stid);
> +	}
> +
>  	write->wr_how_written =3D write->wr_stable_how;
>  	status =3D nfsd_vfs_write(rqstp, &cstate->current_fh, nf,
>  				write->wr_offset, &write->wr_payload,
> @@ -2550,6 +2571,7 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
>  	mutex_unlock(&ls->ls_mutex);
> =20
>  	nfserr =3D ops->proc_layoutcommit(inode, rqstp, lcp);
> +	nfsd4_file_mark_deleg_written(ls->ls_stid.sc_file);
>  	nfs4_put_stid(&ls->ls_stid);
>  out:
>  	return nfserr;
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 205ee8cc6fa2b9f74d08f7938b323d03bdf8286c..81fa7cc6c77b3cdc5ff22bc60ab=
0654f95dc258d 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1222,6 +1222,42 @@ static void put_deleg_file(struct nfs4_file *fp)
>  		nfs4_file_put_access(fp, NFS4_SHARE_ACCESS_READ);
>  }
> =20
> +static void nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, st=
ruct file *f)
> +{
> +	struct iattr ia =3D { .ia_valid =3D ATTR_ATIME | ATTR_CTIME | ATTR_MTIME =
};
> +	struct inode *inode =3D file_inode(f);
> +	int ret;
> +
> +	/* don't do anything if FMODE_NOCMTIME isn't set */
> +	if ((READ_ONCE(f->f_mode) & FMODE_NOCMTIME) =3D=3D 0)
> +		return;
> +
> +	spin_lock(&f->f_lock);
> +	f->f_mode &=3D ~FMODE_NOCMTIME;
> +	spin_unlock(&f->f_lock);
> +
> +	/* was it never written? */
> +	if (!dp->dl_written)
> +		return;
> +
> +	/* did it get a setattr for the timestamps at some point? */
> +	if (dp->dl_setattr)
> +		return;
> +
> +	/* Stamp everything to "now" */
> +	inode_lock(inode);
> +	ret =3D notify_change(&nop_mnt_idmap, f->f_path.dentry, &ia, NULL);
> +	inode_unlock(inode);
> +	if (ret) {
> +		struct inode *inode =3D file_inode(f);
> +
> +		pr_notice_ratelimited("Unable to update timestamps on inode %02x:%02x:%l=
u: %d\n",
> +					MAJOR(inode->i_sb->s_dev),
> +					MINOR(inode->i_sb->s_dev),
> +					inode->i_ino, ret);
> +	}
> +}
> +
>  static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
>  {
>  	struct nfs4_file *fp =3D dp->dl_stid.sc_file;
> @@ -1229,6 +1265,7 @@ static void nfs4_unlock_deleg_lease(struct nfs4_deleg=
ation *dp)
> =20
>  	WARN_ON_ONCE(!fp->fi_delegees);
> =20
> +	nfsd4_finalize_deleg_timestamps(dp, nf->nf_file);
>  	kernel_setlease(nf->nf_file, F_UNLCK, NULL, (void **)&dp);
>  	put_deleg_file(fp);
>  }
> @@ -6265,6 +6302,8 @@ nfs4_open_delegation(struct svc_rqst *rqstp, struct n=
fsd4_open *open,
>  	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl=
_stid.sc_stateid));
> =20
>  	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> +		struct file *f =3D dp->dl_stid.sc_file->fi_deleg_file->nf_file;
> +
>  		if (!nfsd4_add_rdaccess_to_wrdeleg(rqstp, open, fh, stp) ||
>  				!nfs4_delegation_stat(dp, currentfh, &stat)) {
>  			nfs4_put_stid(&dp->dl_stid);
> @@ -6278,6 +6317,9 @@ nfs4_open_delegation(struct svc_rqst *rqstp, struct n=
fsd4_open *open,
>  		dp->dl_atime =3D stat.atime;
>  		dp->dl_ctime =3D stat.ctime;
>  		dp->dl_mtime =3D stat.mtime;
> +		spin_lock(&f->f_lock);
> +		f->f_mode |=3D FMODE_NOCMTIME;
> +		spin_unlock(&f->f_lock);
>  		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
>  	} else {
>  		open->op_delegate_type =3D deleg_ts && nfs4_delegation_stat(dp, currentf=
h, &stat) ?
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index bf9436cdb93c5dd5502ecf83433ea311e3678711..b6ac0f37e9cdfcfddde5861c8c0=
c51bad60101b7 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -217,10 +217,12 @@ struct nfs4_delegation {
>  	struct nfs4_clnt_odstate *dl_clnt_odstate;
>  	time64_t		dl_time;
>  	u32			dl_type;
> -/* For recall: */
> +	/* For recall: */
>  	int			dl_retries;
>  	struct nfsd4_callback	dl_recall;
>  	bool			dl_recalled;
> +	bool			dl_written;
> +	bool			dl_setattr;
> =20
>  	/* for CB_GETATTR */
>  	struct nfs4_cb_fattr    dl_cb_fattr;
>=20
> --=20
> 2.50.1
>=20
>=20


