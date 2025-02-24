Return-Path: <linux-fsdevel+bounces-42379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71D8A41388
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 03:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5759173724
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 02:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37901A23BA;
	Mon, 24 Feb 2025 02:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JQqRICK5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AFxW1Jzk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JQqRICK5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AFxW1Jzk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9A219F40A
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 02:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740363994; cv=none; b=EjuiLP8X2n7P+nJrbjNhGF+FvP8PLHuSYsILTnTmq50mEsObhwK21YyMW+ZKUAikCPosR8BKEU8vZq4eipE3dm/SmItll5G9e+weoRCvw+Bas0bD9LCpl2pGdWBrQznE6RXmwPiK1CKOqW7qcKSLGMIA3t5RMWwyOICOCxiV4Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740363994; c=relaxed/simple;
	bh=bQ9fGXw/SUdQRAj2gEZ/sSZ2+P1GNi51Pb8meP3bFMc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=e53rFllXP4VnxYQehaC/2l/6MlVxfBYVcj5XYei9ZveksCqmoHqycBrbuFBk65nji5e9hTywiZIw5Afsotl+GImA0+MPawxeeh7qA0H8qFV+1I3oMCmAUfgup1tHBZxDPYP3uDXGVmuNA8SivY0N/pFX2i/Zpc59TiH3G1ahbNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JQqRICK5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AFxW1Jzk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JQqRICK5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AFxW1Jzk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AEC2621163;
	Mon, 24 Feb 2025 02:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740363989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hK0cbAMRfKN3dq7LyiWJIm5jqsIOUyoe9i5tRacJZsE=;
	b=JQqRICK5438lY9PLn1wxE4IZQxKModcl6anXKNMSLmbJGy7BRJ2Rm6nQaOs6jQU5yVoQp4
	D+AIxraGSalG/F1T7YYEvdIB3QwCr6dkBHxdOFWMLLCO8FxJq7sRx2q9eoQP+kF6T/LnCg
	COi99TOeMS9mWRm4t1Lo1+yE6rT1sQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740363989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hK0cbAMRfKN3dq7LyiWJIm5jqsIOUyoe9i5tRacJZsE=;
	b=AFxW1Jzk0D6JeLybFeiTN4mDgWvEWNF548W7RhanejsWpbWHP8N+YnLTCRQ+YB1m/xIFIK
	RFOLtms9t32rgVCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740363989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hK0cbAMRfKN3dq7LyiWJIm5jqsIOUyoe9i5tRacJZsE=;
	b=JQqRICK5438lY9PLn1wxE4IZQxKModcl6anXKNMSLmbJGy7BRJ2Rm6nQaOs6jQU5yVoQp4
	D+AIxraGSalG/F1T7YYEvdIB3QwCr6dkBHxdOFWMLLCO8FxJq7sRx2q9eoQP+kF6T/LnCg
	COi99TOeMS9mWRm4t1Lo1+yE6rT1sQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740363989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hK0cbAMRfKN3dq7LyiWJIm5jqsIOUyoe9i5tRacJZsE=;
	b=AFxW1Jzk0D6JeLybFeiTN4mDgWvEWNF548W7RhanejsWpbWHP8N+YnLTCRQ+YB1m/xIFIK
	RFOLtms9t32rgVCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03C29136B3;
	Mon, 24 Feb 2025 02:26:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6DpUHM3Yu2e1dgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 24 Feb 2025 02:26:21 +0000
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
Subject: Re: [PATCH 4/6] fuse: return correct dentry for ->mkdir
In-reply-to: <20250222042402.GN1977892@ZenIV>
References: <>, <20250222042402.GN1977892@ZenIV>
Date: Mon, 24 Feb 2025 13:26:18 +1100
Message-id: <174036397835.74271.9038146946135155196@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,szeredi.hu,redhat.com,gmail.com,nod.at,cambridgegreys.com,sipsolutions.net,oracle.com,talpey.com,chromium.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,noble.neil.brown.name:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Sat, 22 Feb 2025, Al Viro wrote:
> On Fri, Feb 21, 2025 at 10:36:33AM +1100, NeilBrown wrote:
>=20
> > @@ -871,7 +870,12 @@ static int fuse_mknod(struct mnt_idmap *idmap, struc=
t inode *dir,
> >  	args.in_args[0].value =3D &inarg;
> >  	args.in_args[1].size =3D entry->d_name.len + 1;
> >  	args.in_args[1].value =3D entry->d_name.name;
> > -	return create_new_entry(idmap, fm, &args, dir, entry, mode);
> > +	de =3D create_new_entry(idmap, fm, &args, dir, entry, mode);
> > +	if (IS_ERR(de))
> > +		return PTR_ERR(de);
> > +	if (de)
> > +		dput(de);
> > +	return 0;
>=20
> Can that really happen?

Probably now.  It would require S_IFDIR to be passed in the mode to
vfs_mknod().  I don't think any current callers do that, but I don't see
any code in vfs_mknod() to prevent it.

>=20
> > @@ -934,7 +939,12 @@ static int fuse_symlink(struct mnt_idmap *idmap, str=
uct inode *dir,
> >  	args.in_args[1].value =3D entry->d_name.name;
> >  	args.in_args[2].size =3D len;
> >  	args.in_args[2].value =3D link;
> > -	return create_new_entry(idmap, fm, &args, dir, entry, S_IFLNK);
> > +	de =3D create_new_entry(idmap, fm, &args, dir, entry, S_IFLNK);
> > +	if (IS_ERR(de))
> > +		return PTR_ERR(de);
> > +	if (de)
> > +		dput(de);
> > +	return 0;
>=20
> Same question.

That definitely cannot happen. - because we *know* that d_splice_alias()
never returns a dentry for any but an S_IFDIR inode (how might we
explain that to the rust type system I wonder :-).

I was going for "obviously correct" without try to optimise, but you are
correct that testing for a non-NULL non-ERR dentry should be optimsed
away as impossible in all cases except mkdir.

Thanks,
NeilBrown


>=20
> > +	de =3D create_new_entry(&invalid_mnt_idmap, fm, &args, newdir, newent, =
inode->i_mode);
> > +	if (!IS_ERR(de)) {
> > +		if (de)
> > +			dput(de);
> > +		de =3D NULL;
>=20
> Whoa...  Details, please.  What's going on here?
>=20


