Return-Path: <linux-fsdevel+bounces-42627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1402A452DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 03:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8181D17D145
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 02:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B165F215F4B;
	Wed, 26 Feb 2025 02:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u0yVGzYi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eet465dc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XtO52lJP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k0wvKTl8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101C32153FF
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 02:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535775; cv=none; b=T/xy/uO0L4Tq9mxJ7tVFqfcI4feaJFS3wVnStIIjhwPLBmf3ycv+UoPPOcWcwMKBDWtaYVJ/tSYp1V58vYpXNxt/LuSELz16YqF0c1C+U4HyKYV3vO1TtP9LmAt4bKZIkwKXT3UhRrT0R4Q1hODGeIsna29WxQbvUDvfgolLLeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535775; c=relaxed/simple;
	bh=NSHYMvLkdyKWlrJ8TUrBFvBlFGqXUq8fzgDW+/N42tQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=cDep9GQ60oVxnM0O194ZL/ZpsJrFcdl/PCelL5j2NWOV9sVQi95/B1TEZC7erW+ce/99GYrz/+sLKcH/gVehboYQ3bJ00rKBkPZNYrrIVL9GRBTlCf+nN77uO7byL8VN0XuXm8P7mTBIkUO9eqgu1ctDlKDW4Hgt55a0hzdlpSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u0yVGzYi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eet465dc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XtO52lJP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k0wvKTl8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EA1BB1F387;
	Wed, 26 Feb 2025 02:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740535771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSHYMvLkdyKWlrJ8TUrBFvBlFGqXUq8fzgDW+/N42tQ=;
	b=u0yVGzYiNkzoEPIVHZee60sXFj3ne+Wb8tPzwZ/NcZWX1ofnfNRGRJwIXcAb9D/IDMGyb/
	usUaRMHuPkFExNna4bYaKzoK+yUhpgWHHy3u+WOTuKI/FFaPgHGWzE79KiJGQruftUWdpU
	x83Pz3gK8Sl5gqJalcZ0usKWFh24ZfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740535771;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSHYMvLkdyKWlrJ8TUrBFvBlFGqXUq8fzgDW+/N42tQ=;
	b=eet465dcLupY2TpMQbmmQdvX+TDfghJ8aIFuG7/Cr1OyR05t8xUbytdq1Ic3lU5zNdpoai
	tKqVPW+naUF6X/Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XtO52lJP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=k0wvKTl8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740535770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSHYMvLkdyKWlrJ8TUrBFvBlFGqXUq8fzgDW+/N42tQ=;
	b=XtO52lJPWuBEyOccT4EnXjjeFJ8fOtInDyKUUA+yznmb22nEwsuDzq0wTYEAhVOWZ4Ej4n
	c81NWXZ7ui/GzQeXRfXCxgGwwyVF1wx9qjPBVvVe7ThQ7GrTCxaP31V4kPpim4xu6ClB1C
	fST4cM1wVZ+Udh/RiZIS+H0sLKady7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740535770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSHYMvLkdyKWlrJ8TUrBFvBlFGqXUq8fzgDW+/N42tQ=;
	b=k0wvKTl8JYtMrGy37fuIOg7D7oNXeJY52zKjSvtUfDhxeGoKL9/5A72/9kHcQIhk4UAB76
	Ioq34eDDLVWaC1AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0BC213404;
	Wed, 26 Feb 2025 02:09:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C85nJNJ3vmdDXgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 26 Feb 2025 02:09:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Trond Myklebust" <trondmy@hammerspace.com>
Cc: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "brauner@kernel.org" <brauner@kernel.org>,
 "xiubli@redhat.com" <xiubli@redhat.com>,
 "idryomov@gmail.com" <idryomov@gmail.com>,
 "okorniev@redhat.com" <okorniev@redhat.com>,
 "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
 "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
 "jlayton@kernel.org" <jlayton@kernel.org>,
 "anna@kernel.org" <anna@kernel.org>, "miklos@szeredi.hu" <miklos@szeredi.hu>,
 "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
 "jack@suse.cz" <jack@suse.cz>, "tom@talpey.com" <tom@talpey.com>,
 "richard@nod.at" <richard@nod.at>,
 "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "netfs@lists.linux.dev" <netfs@lists.linux.dev>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
 "senozhatsky@chromium.org" <senozhatsky@chromium.org>
Subject:
 Re: [PATCH 1/6] Change inode_operations.mkdir to return struct dentry *
In-reply-to: <d4aaba8c09f68d8a8264474ce81b9e818eaa60d7.camel@hammerspace.com>
References:
 <>, <d4aaba8c09f68d8a8264474ce81b9e818eaa60d7.camel@hammerspace.com>
Date: Wed, 26 Feb 2025 13:09:19 +1100
Message-id: <174053575968.102979.1033896985966452059@noble.neil.brown.name>
X-Rspamd-Queue-Id: EA1BB1F387
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,redhat.com,gmail.com,vger.kernel.org,oracle.com,sipsolutions.net,szeredi.hu,cambridgegreys.com,suse.cz,talpey.com,nod.at,lists.infradead.org,lists.linux.dev,chromium.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Tue, 25 Feb 2025, Trond Myklebust wrote:
> On Mon, 2025-02-24 at 14:09 +1100, NeilBrown wrote:
> > On Mon, 24 Feb 2025, Al Viro wrote:
> > > On Mon, Feb 24, 2025 at 12:34:06PM +1100, NeilBrown wrote:
> > > > On Sat, 22 Feb 2025, Al Viro wrote:
> > > > > On Fri, Feb 21, 2025 at 10:36:30AM +1100, NeilBrown wrote:
> > > > >=20
> > > > > > +In general, filesystems which use d_instantiate_new() to
> > > > > > install the new
> > > > > > +inode can safely return NULL.=C2=A0 Filesystems which may not
> > > > > > have an I_NEW inode
> > > > > > +should use d_drop();d_splice_alias() and return the result
> > > > > > of the latter.
> > > > >=20
> > > > > IMO that's a bad pattern, _especially_ if you want to go for
> > > > > "in-update"
> > > > > kind of stuff later.
> > > >=20
> > > > Agreed.=C2=A0 I have a draft patch to change d_splice_alias() and
> > > > d_exact_alias() to work on hashed dentrys.=C2=A0 I thought it should
> > > > go after
> > > > these mkdir patches rather than before.
> > >=20
> > > Could you give a braindump on the things d_exact_alias() is needed
> > > for?
> > > It's a recurring headache when doing ->d_name/->d_parent audits;
> > > see e.g.
> > > https://lore.kernel.org/all/20241213080023.GI3387508@ZenIV/=C2=A0for
> > > related
> > > mini-rant from the latest iteration.
> > >=20
> > > Proof of correctness is bloody awful; it feels like the primitive
> > > itself
> > > is wrong, but I'd never been able to write anything concise
> > > regarding
> > > the things we really want there ;-/
> > >=20
> >=20
> > As I understand it, it is needed (or wanted) to handle the
> > possibility
> > of an inode becoming "stale" and then recovering.=C2=A0 This could happen,
> > for example, with a temporarily misconfigured NFS server.
> >=20
> > If ->d_revalidate gets a NFSERR_STALE from the server it will return
> > '0'
> > so lookup_fast() and others will call d_invalidate() which will
> > d_drop()
> > the dentry.=C2=A0 There are other paths on which -ESTALE can result in
> > d_drop().
> >=20
> > If a subsequent attempt to "open" the name successfully finds the
> > same
> > inode we want to reuse the old dentry rather than create a new one.
> >=20
> > I don't really understand why.=C2=A0 This code was added 20 years ago
> > before
> > git.
> > It was introduced by
> >=20
> > commit 89a45174b6b32596ea98fa3f89a243e2c1188a01
> > Author: Trond Myklebust <trond.myklebust@fys.uio.no>
> > Date:=C2=A0=C2=A0 Tue Jan 4 21:41:37 2005 +0100
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 VFS: Avoid dentry aliasing problems in filesyste=
ms like NFS,
> > where
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inodes may be mark=
ed as stale in one instance (causing the
> > dentry
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to be dropped) the=
n re-enabled in the next instance.
> > =C2=A0=C2=A0=C2=A0=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 Signed-off-by: Trond Myklebust <trond.myklebust@=
fys.uio.no>
> >=20
> > in history.git
> >=20
> > Trond: do you have any memory of this?=C2=A0 Can you explain what the
> > symptom
> > was that you wanted to fix?
> >=20
> > The original patch used d_add_unique() for lookup and atomic_open and
> > readdir prime-dcache.=C2=A0 We now only use it for v4 atomic_open.=C2=A0 =
Maybe
> > we
> > don't need it at all?=C2=A0 Or maybe we need to restore it to those other
> > callers?=20
> >=20
>=20
> 2005? That looks like it was trying to deal with the userspace NFS
> server. I can't remember when it was given the ability to use the inode
> generation counter, but I'm pretty sure that in 2005 there were plenty
> of setups out there that had the older version that reused filehandles
> (due to inode number reuse). So you would get spurious ESTALE errors
> sometimes due to inode number reuse, sometimes because the filehandle
> fell out of the userspace NFS server's cache.

So this was likely done to work-around known weaknesses in NFS servers
at the time.

The original d_add_unique() was used in nfs_lookup() nfs_atomic_lookup()
and nfs_readdir_lookup() but the current descendent d_exact_alias() is
only used in _nfs4_open_and_get_state() called only by nfs4_do_open()
which is only used in nfs4_atomic_open() and nfs4_proc_create().

So the usage in 'lookup' and 'readdir' have fallen by the wayside with
no apparent negative consequences. =20
The old NFS servers have probably been fixed.

So do you have any concerns with us discarding d_exact_alias() and only
using d_splice_alias() in _nfs4_open_get_state() ??

Thanks,
NeilBrown


