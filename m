Return-Path: <linux-fsdevel+bounces-10523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C63984BF20
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 22:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E806E287391
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 21:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491851B95D;
	Tue,  6 Feb 2024 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k1d3oCnY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F40f5fbh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k1d3oCnY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F40f5fbh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886911B949;
	Tue,  6 Feb 2024 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707254228; cv=none; b=FYPLWrT24Y+c/M4MqeM5jVPS3rtCz4TBPFr82/mBinhuc0O/9WE01yueNfjocADUybULNOrCQMcwW8TpO8KegwKGIBB5NkUTN3uuhxxrzTIX/geJ+zwRal8dRgtK2uhQEB9xroiYI6TOYYd6OEB6p85rPfTnadwyrZcya0F629A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707254228; c=relaxed/simple;
	bh=uwEMzGckHBO1KSpcMS2s/3KiVhfDWEZdmc5ffrHPtsA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=OXzg4OGsd7Byq9828VGHnvpkii+rv0HOjevp+iMBzDgDkUu2uZbPhPJXL8HbrptZN/X7tkKPWTVz1cdSaLycyWfbjbxJTthHSwkVDdAz7KHik9SGIcDrDR1VkI496Jdys60mrcyWqtIblUdAmrYfD+rrNP4Z0FhaGZMtwilRUqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k1d3oCnY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F40f5fbh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k1d3oCnY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F40f5fbh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AA6892219C;
	Tue,  6 Feb 2024 21:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707254224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=87Ylwb7RHQpUL7m4lvn75IdWsX8BWP7o6iatgAA8NTY=;
	b=k1d3oCnY6UIT9CwC8F8K19X7A3A4Of/jKOF8wToLJzXbMC3ZWVG84vjTLTGrFuXlxHwuHM
	m7QOgUBLj+tFMlhDXvM9Ax9zzDYBY6Hkb5KiL4t7LgPf7EVoNXHDRVDEPtAx0i7w09I8OM
	L/wneE8ke9Ovzr5gNfSk67CuzW/EnJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707254224;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=87Ylwb7RHQpUL7m4lvn75IdWsX8BWP7o6iatgAA8NTY=;
	b=F40f5fbh9qYm2ldnJ7NTe22HeXtso14MjztF9iw7eaVLJpc4MhXoLKnXkM8TLIjqqCu6R1
	/KjG2wSW+aeB94AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707254224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=87Ylwb7RHQpUL7m4lvn75IdWsX8BWP7o6iatgAA8NTY=;
	b=k1d3oCnY6UIT9CwC8F8K19X7A3A4Of/jKOF8wToLJzXbMC3ZWVG84vjTLTGrFuXlxHwuHM
	m7QOgUBLj+tFMlhDXvM9Ax9zzDYBY6Hkb5KiL4t7LgPf7EVoNXHDRVDEPtAx0i7w09I8OM
	L/wneE8ke9Ovzr5gNfSk67CuzW/EnJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707254224;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=87Ylwb7RHQpUL7m4lvn75IdWsX8BWP7o6iatgAA8NTY=;
	b=F40f5fbh9qYm2ldnJ7NTe22HeXtso14MjztF9iw7eaVLJpc4MhXoLKnXkM8TLIjqqCu6R1
	/KjG2wSW+aeB94AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E0B0132DD;
	Tue,  6 Feb 2024 21:17:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wfO8EMyhwmWLOQAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 06 Feb 2024 21:17:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 Ondrej =?utf-8?q?Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
 "Zdenek Pytela" <zpytela@redhat.com>
Subject: Re: [PATCH] filelock: don't do security checks on nfsd setlease calls
In-reply-to: <20240206-gewaschen-bauen-f7932047a1be@brauner>
References: <20240205-bz2248830-v1-1-d0ec0daecba1@kernel.org>,
 <170716318935.13976.13465352731929804157@noble.neil.brown.name>,
 <20240206-gewaschen-bauen-f7932047a1be@brauner>
Date: Wed, 07 Feb 2024 08:16:57 +1100
Message-id: <170725421733.13976.232570371514420308@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,oracle.com,netapp.com,talpey.com,vger.kernel.org,gmail.com,redhat.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Wed, 07 Feb 2024, Christian Brauner wrote:
> On Tue, Feb 06, 2024 at 06:59:49AM +1100, NeilBrown wrote:
> > On Mon, 05 Feb 2024, Jeff Layton wrote:
> > > Zdenek reported seeing some AVC denials due to nfsd trying to set
> > > delegations:
> > >=20
> > >     type=3DAVC msg=3Daudit(09.11.2023 09:03:46.411:496) : avc:  denied =
 { lease } for  pid=3D5127 comm=3Drpc.nfsd capability=3Dlease  scontext=3Dsys=
tem_u:system_r:nfsd_t:s0 tcontext=3Dsystem_u:system_r:nfsd_t:s0 tclass=3Dcapa=
bility permissive=3D0
> > >=20
> > > When setting delegations on behalf of nfsd, we don't want to do all of
> > > the normal capabilty and LSM checks. nfsd is a kernel thread and runs
> > > with CAP_LEASE set, so the uid checks end up being a no-op in most cases
> > > anyway.
> > >=20
> > > Some nfsd functions can end up running in normal process context when
> > > tearing down the server. At that point, the CAP_LEASE check can fail and
> > > cause the client to not tear down delegations when expected.
> > >=20
> > > Also, the way the per-fs ->setlease handlers work today is a little
> > > convoluted. The non-trivial ones are wrappers around generic_setlease,
> > > so when they fail due to permission problems they usually they end up
> > > doing a little extra work only to determine that they can't set the
> > > lease anyway. It would be more efficient to do those checks earlier.
> > >=20
> > > Transplant the permission checking from generic_setlease to
> > > vfs_setlease, which will make the permission checking happen earlier on
> > > filesystems that have a ->setlease operation. Add a new kernel_setlease
> > > function that bypasses these checks, and switch nfsd to use that instead
> > > of vfs_setlease.
> > >=20
> > > There is one behavioral change here: prior this patch the
> > > setlease_notifier would fire even if the lease attempt was going to fail
> > > the security checks later. With this change, it doesn't fire until the
> > > caller has passed them. I think this is a desirable change overall. nfsd
> > > is the only user of the setlease_notifier and it doesn't benefit from
> > > being notified about failed attempts.
> > >=20
> > > Cc: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> > > Reported-by: Zdenek Pytela <zpytela@redhat.com>
> > > Closes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2248830
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> >=20
> > Reviewed-by: NeilBrown <neilb@suse.de>
> >=20
> > It definitely nice to move all the security and sanity check early.
> > This patch allows a minor clean-up in cifs which could possibly be
> > included:
> > diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> > index 2a4a4e3a8751..0f142d1ec64f 100644
> >=20
> > --- a/fs/smb/client/cifsfs.c
> > +++ b/fs/smb/client/cifsfs.c
> > @@ -1094,9 +1094,6 @@ cifs_setlease(struct file *file, int arg, struct fi=
le_lock **lease, void **priv)
> >  	struct inode *inode =3D file_inode(file);
> >  	struct cifsFileInfo *cfile =3D file->private_data;
> > =20
> > -	if (!(S_ISREG(inode->i_mode)))
> > -		return -EINVAL;
> > -
> >  	/* Check if file is oplocked if this is request for new lease */
> >  	if (arg =3D=3D F_UNLCK ||
> >  	    ((arg =3D=3D F_RDLCK) && CIFS_CACHE_READ(CIFS_I(inode))) ||
> >=20
> >=20
> > as ->setlease() is now never called for non-ISREG files.
>=20
> I've added the following on top. I've made you author and added your
> SoB. Please tell me if you have any problems with this:

No problems at all - thanks for doing this!

NeilBrown


>=20
> From d30e52329760873bf0d7984a442cace3a4b5f39d Mon Sep 17 00:00:00 2001
> From: NeilBrown <neilb@suse.de>
> Date: Tue, 6 Feb 2024 14:08:57 +0100
> Subject: [PATCH] smb: remove redundant check
>=20
> ->setlease() is never called on non-regular files now. So remove the
> check from cifs_setlease().
>=20
> Link: https://lore.kernel.org/r/170716318935.13976.13465352731929804157@nob=
le.neil.brown.name
> Signed-off-by: NeilBrown <neilb@suse.de>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/smb/client/cifsfs.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> index 5eee5b00547f..cbcb98d5f2d7 100644
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> @@ -1094,9 +1094,6 @@ cifs_setlease(struct file *file, int arg, struct file=
_lease **lease, void **priv
>  	struct inode *inode =3D file_inode(file);
>  	struct cifsFileInfo *cfile =3D file->private_data;
> =20
> -	if (!(S_ISREG(inode->i_mode)))
> -		return -EINVAL;
> -
>  	/* Check if file is oplocked if this is request for new lease */
>  	if (arg =3D=3D F_UNLCK ||
>  	    ((arg =3D=3D F_RDLCK) && CIFS_CACHE_READ(CIFS_I(inode))) ||
> --=20
> 2.43.0
>=20
>=20


