Return-Path: <linux-fsdevel+bounces-42380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9D8A413A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 03:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61AB16BBF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 02:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B03C1A262D;
	Mon, 24 Feb 2025 02:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PF1/A9db";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4W/SAG+f";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J7xr5LAV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2FUNoupm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4B2156C5E
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 02:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740364920; cv=none; b=HEhG2KS+ERGfEF0ampMg4OnNKU5ZXOr94TCEcEZM38wOkJqYiig2cNiHHPVbGo3a0gctanKRWbVFcVridfl2oobfwQtrFRe5KpTEEq9+sT1Xk0oWV170LkfhSc+pTeCvtnsDcVjhzLTPNoh4eLZWMDo7LZv21bC+E+jfxUnd2tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740364920; c=relaxed/simple;
	bh=GfXBhWrXc6OEGTVKWTPvQSlNsaOlNuIkwaMkb/7+ySI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=jaPpu3WvraNoJo6oTH09LjFfRofsn/ithSpv8p1mR/82vrnk11o4REpJ6m99s18sC/hWzV4st8WjK+V9UGgb7/DknUoPTK3J4f42OxSHB1KBeIIKvjXnHSJekl8QW0O3fj9zDnzQVEZyR+IZu82SuBcuECHxI7OrYY+5HgEvokI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PF1/A9db; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4W/SAG+f; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J7xr5LAV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2FUNoupm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E24EE1F383;
	Mon, 24 Feb 2025 02:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740364916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sokZcRi5Jle+fsK51aZ7tjNiImsvREKG7vGnUqDo1c4=;
	b=PF1/A9dbKEquPdrr+y+sOIJOOSf8woWxlVHOwGLWU8Dbhu1YxsLdDU/bC0u4Wqm+q5o+6D
	hNvr6eWdM+/bz/17A5Pp3pP3AeCkxJ1UGnS6YyTiQgt6AHodPSIAsAFyyxOZEw09DdKlj4
	C2TGaRGduVqP+MYYWWF1DG89EHrwh3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740364916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sokZcRi5Jle+fsK51aZ7tjNiImsvREKG7vGnUqDo1c4=;
	b=4W/SAG+fRUk7tp1wd1ozQxfjBIqxOqr4nqDIxvYnaLAQOnNOyiaOJI4CQvuUdeCjLGYj52
	lJS3rRsYKQLb1KAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=J7xr5LAV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2FUNoupm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740364915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sokZcRi5Jle+fsK51aZ7tjNiImsvREKG7vGnUqDo1c4=;
	b=J7xr5LAVZNN5Mh8sDgv6/hHinb6Iuf/Ln5E5/G3ELY1aOwfF54zp55MTeawr5BiI1Bk4uz
	FtVeccRBlZZxHc4tw69hJD5HJZfkhCrYT63OdzsL3iiwG0bsZwpcUBKObsr9q6bSDIw9gC
	STSzkXWsfKRb2MldZbU+uY3e+ib+2hU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740364915;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sokZcRi5Jle+fsK51aZ7tjNiImsvREKG7vGnUqDo1c4=;
	b=2FUNoupmwUKtO/g8AMP0aUFbysA9B7OVFNWZUTF5EcBMJ1OImqv8CcszVjdJvbnFACkwF/
	16e0OuJo856N4NBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBE2613332;
	Mon, 24 Feb 2025 02:41:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yOoRH2vcu2csegAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 24 Feb 2025 02:41:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Xiubo Li" <xiubli@redhat.com>,
 "Ilya Dryomov" <idryomov@gmail.com>, "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-um@lists.infradead.org, ceph-devel@vger.kernel.org,
 netfs@lists.linux.dev
Subject: Re: [PATCH 5/6] nfs: change mkdir inode_operation to return alternate
 dentry if needed.
In-reply-to: <20250222044130.GO1977892@ZenIV>
References: <>, <20250222044130.GO1977892@ZenIV>
Date: Mon, 24 Feb 2025 13:41:44 +1100
Message-id: <174036490460.74271.3866837223419464073@noble.neil.brown.name>
X-Rspamd-Queue-Id: E24EE1F383
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,szeredi.hu,redhat.com,gmail.com,nod.at,cambridgegreys.com,sipsolutions.net,oracle.com,talpey.com,chromium.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 22 Feb 2025, Al Viro wrote:
> On Fri, Feb 21, 2025 at 10:36:34AM +1100, NeilBrown wrote:
>=20
> >  nfs3_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *=
sattr)
> >  {
> >  	struct posix_acl *default_acl, *acl;
> > @@ -612,15 +612,18 @@ nfs3_proc_mkdir(struct inode *dir, struct dentry *d=
entry, struct iattr *sattr)
> >  		dentry =3D d_alias;
> > =20
> >  	status =3D nfs3_proc_setacls(d_inode(dentry), acl, default_acl);
> > +	if (status && d_alias)
> > +		dput(d_alias);
> > =20
> > -	dput(d_alias);
> >  out_release_acls:
> >  	posix_acl_release(acl);
> >  	posix_acl_release(default_acl);
> >  out:
> >  	nfs3_free_createdata(data);
> >  	dprintk("NFS reply mkdir: %d\n", status);
> > -	return status;
> > +	if (status)
> > +		return ERR_PTR(status);
> > +	return d_alias;
>=20
> Ugh...  That's really hard to follow - you are leaving a dangling
> reference in d_alias textually upstream of using that variable.
> The only reason it's not a bug is that dput() is reachable only
> with status && d_alias and that guarantees that we'll
> actually go away on if (status) return ERR_PTR(status).
>=20
> Worse, you can reach 'out:' with d_alias uninitialized.  Yes,
> all such branches happen with status either still unmodified
> since it's initialization (which is non-zero) or under
> if (status), so again, that return d_alias; is unreachable.
>=20
> So the code is correct, but it's really asking for trouble down
> the road.
>=20
> BTW, dput(NULL) is guaranteed to be a no-op...
>=20

Thanks for that.  I've minimised the use of status and mostly
stored errors in d_alias - which I've renamed to 'ret'.
I think that answers your concerns.

Thanks,
NeilBrown

--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -578,13 +578,13 @@ nfs3_proc_symlink(struct inode *dir, struct dentry *den=
try, struct folio *folio,
 	return status;
 }
=20
-static int
+static struct dentry *
 nfs3_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *satt=
r)
 {
 	struct posix_acl *default_acl, *acl;
 	struct nfs3_createdata *data;
-	struct dentry *d_alias;
-	int status =3D -ENOMEM;
+	struct dentry *ret =3D ERR_PTR(-ENOMEM);
+	int status;
=20
 	dprintk("NFS call  mkdir %pd\n", dentry);
=20
@@ -592,8 +592,9 @@ nfs3_proc_mkdir(struct inode *dir, struct dentry *dentry,=
 struct iattr *sattr)
 	if (data =3D=3D NULL)
 		goto out;
=20
-	status =3D posix_acl_create(dir, &sattr->ia_mode, &default_acl, &acl);
-	if (status)
+	ret =3D ERR_PTR(posix_acl_create(dir, &sattr->ia_mode,
+				       &default_acl, &acl));
+	if (IS_ERR(ret))
 		goto out;
=20
 	data->msg.rpc_proc =3D &nfs3_procedures[NFS3PROC_MKDIR];
@@ -602,25 +603,27 @@ nfs3_proc_mkdir(struct inode *dir, struct dentry *dentr=
y, struct iattr *sattr)
 	data->arg.mkdir.len =3D dentry->d_name.len;
 	data->arg.mkdir.sattr =3D sattr;
=20
-	d_alias =3D nfs3_do_create(dir, dentry, data);
-	status =3D PTR_ERR_OR_ZERO(d_alias);
+	ret =3D nfs3_do_create(dir, dentry, data);
=20
-	if (status !=3D 0)
+	if (IS_ERR(ret))
 		goto out_release_acls;
=20
-	if (d_alias)
-		dentry =3D d_alias;
+	if (ret)
+		dentry =3D ret;
=20
 	status =3D nfs3_proc_setacls(d_inode(dentry), acl, default_acl);
+	if (status) {
+		dput(ret);
+		ret =3D ERR_PTR(status);
+	}
=20
-	dput(d_alias);
 out_release_acls:
 	posix_acl_release(acl);
 	posix_acl_release(default_acl);
 out:
 	nfs3_free_createdata(data);
-	dprintk("NFS reply mkdir: %d\n", status);
-	return status;
+	dprintk("NFS reply mkdir: %d\n", PTR_ERR_OR_ZERO(ret));
+	return ret;
 }
=20
 static int

