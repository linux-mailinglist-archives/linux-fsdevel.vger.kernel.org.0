Return-Path: <linux-fsdevel+bounces-42632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC83A453E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 04:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9196188B771
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 03:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18632512CF;
	Wed, 26 Feb 2025 03:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zEhuAFTf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E1+pozVj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tU6jn1Vc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uSu6mEyJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EF224BC1D
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 03:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740539901; cv=none; b=c6BpNsxbMJuAtep70T13pRwjrkhne5zUfOZFRNng+R/UsN/au2tZ6TtAE90GMSlTOTb/ZKDC73sE015q1ADXqEzMsXOcTQkK1US5EIWt5bl5RrMdGJWXyasj/ymkcvAnwB0rZuSVG4F5d3DsSq71BU6M8Y4MQnkpuA6paakgMg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740539901; c=relaxed/simple;
	bh=bLoqe3iWK2rHJMWZK3S1g1ZUAkxrMh2WccF3afuhLgM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=L/DkN0tfhg7beK72gGiJ+UUCeiM0i7Xn8p9ij5jQlOB+57gWF1ACe/lQBiQFvvWbzrUA8+hX8i/InnatQt2o+E66h1LdRJWtd+9uAZhsSx85N6LllSgnICzCKmaCy4fWaMbcjSGM11q/V3gy5feuYpHOPqIzDpbA7VOWUw5bPnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zEhuAFTf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E1+pozVj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tU6jn1Vc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uSu6mEyJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DECD921185;
	Wed, 26 Feb 2025 03:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740539897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hi2lTyABX6F+Zk3VP84YZcYJcPAqNVeDNsTUYCj+h2E=;
	b=zEhuAFTfm6IsEpNDNJO5Xc6cZVW0QiFbDHnBLr5VGWBbUXXJvhGp3wbd7V3zsUUbN1qVXu
	q3+qo4z7iDXaODumFWhNwKWXWXjILwySTbGzkJj8E8fepbmX+wFwS6NjlL9sJ0H/ELtAMw
	Q352GtSO7Rts7C31MWlPIXD2LAzQsYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740539897;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hi2lTyABX6F+Zk3VP84YZcYJcPAqNVeDNsTUYCj+h2E=;
	b=E1+pozVjwSpODLNi6k/C/UGijOjJ62EqcPQYuabXGiu7p9SbLDtEvFqYZPm9IsQBQJpzJ7
	c1TbLOiIjXr5oUAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tU6jn1Vc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uSu6mEyJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740539896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hi2lTyABX6F+Zk3VP84YZcYJcPAqNVeDNsTUYCj+h2E=;
	b=tU6jn1Vc/w9SxfcdTk9W0KPhwzFtRkstbWKw33r4giZ8UqAGBhbuLK7cf1l4cHzRopo5uz
	lVK5VR3uWx48Fwlz6WqHDLdnkwOUIB9vNI9D3GaGqyviA1Ukb2qobmV758a10khWtB0zjJ
	B2MSUbrJ2SEJkjxOb+UqPxZAQ4JCGA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740539896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hi2lTyABX6F+Zk3VP84YZcYJcPAqNVeDNsTUYCj+h2E=;
	b=uSu6mEyJStRTu5JWG6fW8zpu+ADnh0C1nN2rbqrQuxPLjI050eHP/t3WY/o7ZUxt9e5nPQ
	rM6O40yxt9DEoDBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEEEF13404;
	Wed, 26 Feb 2025 03:18:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x4+RH/CHvmfcbwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 26 Feb 2025 03:18:08 +0000
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
Cc: "xiubli@redhat.com" <xiubli@redhat.com>,
 "brauner@kernel.org" <brauner@kernel.org>,
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
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
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
In-reply-to: <50e6b21c644b050a29e159c9484a5e01061434f6.camel@hammerspace.com>
References:
 <>, <50e6b21c644b050a29e159c9484a5e01061434f6.camel@hammerspace.com>
Date: Wed, 26 Feb 2025 14:18:01 +1100
Message-id: <174053988113.102979.18024415194793753569@noble.neil.brown.name>
X-Rspamd-Queue-Id: DECD921185
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,gmail.com,vger.kernel.org,oracle.com,sipsolutions.net,szeredi.hu,cambridgegreys.com,zeniv.linux.org.uk,suse.cz,talpey.com,nod.at,lists.infradead.org,lists.linux.dev,chromium.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 26 Feb 2025, Trond Myklebust wrote:
> On Wed, 2025-02-26 at 13:09 +1100, NeilBrown wrote:
> > On Tue, 25 Feb 2025, Trond Myklebust wrote:
> > > On Mon, 2025-02-24 at 14:09 +1100, NeilBrown wrote:
> > > > On Mon, 24 Feb 2025, Al Viro wrote:
> > > > > On Mon, Feb 24, 2025 at 12:34:06PM +1100, NeilBrown wrote:
> > > > > > On Sat, 22 Feb 2025, Al Viro wrote:
> > > > > > > On Fri, Feb 21, 2025 at 10:36:30AM +1100, NeilBrown wrote:
> > > > > > >=20
> > > > > > > > +In general, filesystems which use d_instantiate_new() to
> > > > > > > > install the new
> > > > > > > > +inode can safely return NULL.=C2=A0 Filesystems which may not
> > > > > > > > have an I_NEW inode
> > > > > > > > +should use d_drop();d_splice_alias() and return the
> > > > > > > > result
> > > > > > > > of the latter.
> > > > > > >=20
> > > > > > > IMO that's a bad pattern, _especially_ if you want to go
> > > > > > > for
> > > > > > > "in-update"
> > > > > > > kind of stuff later.
> > > > > >=20
> > > > > > Agreed.=C2=A0 I have a draft patch to change d_splice_alias() and
> > > > > > d_exact_alias() to work on hashed dentrys.=C2=A0 I thought it
> > > > > > should
> > > > > > go after
> > > > > > these mkdir patches rather than before.
> > > > >=20
> > > > > Could you give a braindump on the things d_exact_alias() is
> > > > > needed
> > > > > for?
> > > > > It's a recurring headache when doing ->d_name/->d_parent
> > > > > audits;
> > > > > see e.g.
> > > > > https://lore.kernel.org/all/20241213080023.GI3387508@ZenIV/=C2=A0for
> > > > > related
> > > > > mini-rant from the latest iteration.
> > > > >=20
> > > > > Proof of correctness is bloody awful; it feels like the
> > > > > primitive
> > > > > itself
> > > > > is wrong, but I'd never been able to write anything concise
> > > > > regarding
> > > > > the things we really want there ;-/
> > > > >=20
> > > >=20
> > > > As I understand it, it is needed (or wanted) to handle the
> > > > possibility
> > > > of an inode becoming "stale" and then recovering.=C2=A0 This could
> > > > happen,
> > > > for example, with a temporarily misconfigured NFS server.
> > > >=20
> > > > If ->d_revalidate gets a NFSERR_STALE from the server it will
> > > > return
> > > > '0'
> > > > so lookup_fast() and others will call d_invalidate() which will
> > > > d_drop()
> > > > the dentry.=C2=A0 There are other paths on which -ESTALE can result in
> > > > d_drop().
> > > >=20
> > > > If a subsequent attempt to "open" the name successfully finds the
> > > > same
> > > > inode we want to reuse the old dentry rather than create a new
> > > > one.
> > > >=20
> > > > I don't really understand why.=C2=A0 This code was added 20 years ago
> > > > before
> > > > git.
> > > > It was introduced by
> > > >=20
> > > > commit 89a45174b6b32596ea98fa3f89a243e2c1188a01
> > > > Author: Trond Myklebust <trond.myklebust@fys.uio.no>
> > > > Date:=C2=A0=C2=A0 Tue Jan 4 21:41:37 2005 +0100
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 VFS: Avoid dentry aliasing problems in files=
ystems like NFS,
> > > > where
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inodes may be =
marked as stale in one instance (causing
> > > > the
> > > > dentry
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to be dropped)=
 then re-enabled in the next instance.
> > > > =C2=A0=C2=A0=C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 Signed-off-by: Trond Myklebust <trond.mykleb=
ust@fys.uio.no>
> > > >=20
> > > > in history.git
> > > >=20
> > > > Trond: do you have any memory of this?=C2=A0 Can you explain what the
> > > > symptom
> > > > was that you wanted to fix?
> > > >=20
> > > > The original patch used d_add_unique() for lookup and atomic_open
> > > > and
> > > > readdir prime-dcache.=C2=A0 We now only use it for v4 atomic_open.=C2=
=A0
> > > > Maybe
> > > > we
> > > > don't need it at all?=C2=A0 Or maybe we need to restore it to those
> > > > other
> > > > callers?=20
> > > >=20
> > >=20
> > > 2005? That looks like it was trying to deal with the userspace NFS
> > > server. I can't remember when it was given the ability to use the
> > > inode
> > > generation counter, but I'm pretty sure that in 2005 there were
> > > plenty
> > > of setups out there that had the older version that reused
> > > filehandles
> > > (due to inode number reuse). So you would get spurious ESTALE
> > > errors
> > > sometimes due to inode number reuse, sometimes because the
> > > filehandle
> > > fell out of the userspace NFS server's cache.
> >=20
> > So this was likely done to work-around known weaknesses in NFS
> > servers
> > at the time.
> >=20
> > The original d_add_unique() was used in nfs_lookup()
> > nfs_atomic_lookup()
> > and nfs_readdir_lookup() but the current descendent d_exact_alias()
> > is
> > only used in _nfs4_open_and_get_state() called only by nfs4_do_open()
> > which is only used in nfs4_atomic_open() and nfs4_proc_create().
> >=20
> > So the usage in 'lookup' and 'readdir' have fallen by the wayside
> > with
> > no apparent negative consequences.=C2=A0=20
> > The old NFS servers have probably been fixed.
> >=20
> > So do you have any concerns with us discarding d_exact_alias() and
> > only
> > using d_splice_alias() in _nfs4_open_get_state() ??
> >=20
>=20
> AFAIK, there were never any NFSv4 servers in public use that mimicked
> the quirks of the userspace NFSv2/NFSv3 server. So I'm thinking it
> should be safe to retire d_exact_alias.

Thanks.  I'll submit a patch through the VFS tree as I have other VFS
patches in the works that will depend on that so having them together
would be good.

Thanks,
NeilBrown

