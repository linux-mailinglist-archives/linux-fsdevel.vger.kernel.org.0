Return-Path: <linux-fsdevel+bounces-77696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CE8DCpTjlmlbqgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 11:19:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DFF15DB95
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 11:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EDFE3300D0FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 10:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5135531BCB7;
	Thu, 19 Feb 2026 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="AhXCo6ys"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F2D2FFDF7;
	Thu, 19 Feb 2026 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771496330; cv=none; b=awFOwhmvOKAf7JpSDCi+AYPpFSkctt7p8mB/cuC1rTB1ETH0spQXTKD6QDOFrJVaVb1fPYPzkGIa7ORSk3ygVyk6uczWOiBJUQ3kO1oU4xsteGAILky+cUL07qQIRaGzEeOvOxT43heyFWANhMZ+urdJ8rx2xS3r1qTPiVlXtMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771496330; c=relaxed/simple;
	bh=AqKfMlzVUHFx9EfDo1H1HYkJjiBYnjW4O4AxWjx5a7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nvR8owOsgeHSszVTGzm70WaSE68ofKLj3QxXVWp75RvBfxabQZkETeMYka9hudadPe0DI4va0U4NOH89Hci4nslI48Cl3Ov2Eb1IhpK/JxIcUE2AAbCVKDJ9TqMNCvuU44JQO+RNFCt3MIo4iggsvh0VqzvrFnQtE8rqGEF3Jn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=AhXCo6ys; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=C/azCgonTTjryPatWu0vVS7QfE6juRqJ+ClDF7fu1Ts=; b=AhXCo6ysufl+5wr+elfE+Il1DG
	zCE2r8IJZnjoEsvBtm8poV0KyhT+lxPzdLiGaTRJB3dds1TcTgre7rbmfwVmKxNPREcSPK/x5gqgW
	BGe+FsQLaLETYeF3PxPEV/wE/Ug5iaEAYXkrPOgCFL3p8gdkzPzXV8risJzKd/L+8cDmowdff8B8G
	XkctgUl/03PYarnVYGuqjR7vOgbKCdACTCFN2AQPisv4LSy9eo/ZW5hsZ279S2Ao7V0PV7qKmalZ1
	mzp+rOjvqCVU0a/Liec2Mk0FNhW3RVVYdV4YzFXRtY3j3hR/hRCoggBKBuWFVOOO3rnIoETOZh1DF
	Qzwvj5J6r6xcQTL/wyqcaTAzY8p5mc1DlbDpFeBhXthEZmfRyNhfjAMdXACH94P9zuc9RnqSIkoNU
	SKP3Aj4Ohuok8TMyCEOp66HOvNaiFCy7HGSvgzUd7Rjz7nTkF6TSWkyNymN7fHZNohbOTHWZEVWWe
	dAhCUIPbVeKiHEMUMZZB0ZwoCdj7SmhZUbeO0WK1bsb4lk2QBP3cffVFRO+9CviSVbieiKOvFjfhK
	Ae+oz6VB1feDjtTALFVUnUVKYM6g+9S0MwJ6pcZOO5OJrvLgyzgOCMsV5TtuKMbyXUlcFEvuLRetY
	HuOMoigN2lVnwSQcPEivERL9SoIeSkCAS0P5mqQk8=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Remi Pommarel <repk@triplefau.lt>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [PATCH v2 3/3] 9p: Enable symlink caching in page cache
Date: Thu, 19 Feb 2026 11:18:44 +0100
Message-ID: <5050216.GXAFRqVoOG@weasel>
In-Reply-To: <aZG9skZzT_LaHB6O@codewreck.org>
References:
 <cover.1769013622.git.repk@triplefau.lt> <aY5JWgyHq5P17_jx@pilgrim>
 <aZG9skZzT_LaHB6O@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[crudebyte.com,quarantine];
	R_DKIM_ALLOW(-0.20)[crudebyte.com:s=kylie];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77696-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[crudebyte.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux_oss@crudebyte.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2DFF15DB95
X-Rspamd-Action: no action

On Sunday, 15 February 2026 13:36:02 CET Dominique Martinet wrote:
> Still haven't taken time to review, just replying since I'm looking at
> 9p mails tonight... (The IO accounting part was sent to Linus earlier,
> still intending to review and test soonish but feel free to send a v3
> with Christian comments for now)
>=20
> Remi Pommarel wrote on Thu, Feb 12, 2026 at 10:42:50PM +0100:
> > > > +	if (S_ISLNK(rreq->inode->i_mode)) {
> > > > +		err =3D p9_client_readlink(fid, &target);
> > >=20
> > > Treadlink request requires 9p2000.L. So this would break with legacy
> > > protocol versions 9p2000 and 9p2000.u I guess:
> > >=20
> > > https://wiki.qemu.org/Documentation/9p#9p_Protocol
> >=20
> > I'm having trouble seeing how v9fs_issue_read() could be called for
> > S_ISLNK inodes under 9p2000 or 9p2000.u.
> >=20
> > As I understand it, v9fs_issue_read() is only invoked through the page
> > cache operations via the inode=E2=80=99s a_ops. This seems to me that o=
nly
> > regular files and (now that I added a page_get_link() in
> > v9fs_symlink_inode_operations_dotl) symlinks using 9p2000.L can call
> > v9fs_issue_read(). But not symlinks using 9p2000 or 9p2000.u as I
> > haven't modified v9fs_symlink_inode_operations. But I may have missed
> > something here ?
>=20
> I think that's correct, but since it's not obvious perhaps a comment
> just above the p9_client_readlink() call might be useful?

And maybe adding a BUG_ON(!p9_is_proto_dotl(client)) in p9_client_readlink()
[net/9p/client.c].

> Also nitpick: please add brackets to the else as well because the if
> part had some (checkpatch doesn't complain either way, but I don't like
>   if (foo) {
>     ...
>   } else
>     bar
> formatting)
>=20
> > > > diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> > > > index a82a71be309b..e1b762f3e081 100644
> > > > --- a/fs/9p/vfs_inode.c
> > > > +++ b/fs/9p/vfs_inode.c
> > > > @@ -302,10 +302,12 @@ int v9fs_init_inode(struct v9fs_session_info
> > > > *v9ses,
> > > >=20
> > > >  			goto error;
> > > >  	=09
> > > >  		}
> > > >=20
> > > > -		if (v9fs_proto_dotl(v9ses))
> > > > +		if (v9fs_proto_dotl(v9ses)) {
> > > >=20
> > > >  			inode->i_op =3D &v9fs_symlink_inode_operations_dotl;
> > > >=20
> > > > -		else
> > > > +			inode_nohighmem(inode);
> > >=20
> > > What is that for?
> >=20
> > According to filesystems/porting.rst and commit 21fc61c73c39 ("don't put
> > symlink bodies in pagecache into highmem") all symlinks that need to use
> > page_follow_link_light() (which is now more or less page_get_link())
> > should not add highmem pages in pagecache or deadlocks could happen. The
> > inode_nohighmem() prevents that.
> >=20
> > Also from __page_get_link()
> >=20
> >   BUG_ON(mapping_gfp_mask(mapping) & __GFP_HIGHMEM);
> >=20
> > A BUG_ON() is supposed to punish us if inode_nohighmem() is not used
> > here.
> >=20
> > Of course this does not have any effect on 64bits platforms.
>=20
> That's how it should be but it marks memory as GFP_USER, I'm curious if
> it really has no other effect... Anyway, from what I've read I think it
> is likely to go away (highmem on 32bit platforms) soon enough, so this
> probably won't matter in the long run.
> (if we really care we could flag this only for S_ISLNK(mode), but I
> don't think it's worth the check)

Good point. Most other fs only call inode_nohighmem() for symlinks. IIUIC i=
t's
not a good idea to do this simply for all inodes, as it may lead to deadloc=
ks
for instance. So I think it is worth to add that check.

/Christian



