Return-Path: <linux-fsdevel+bounces-42383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCD6A413E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 04:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B9E3B2FE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 03:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8AB1A3176;
	Mon, 24 Feb 2025 03:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="loDVWSzz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QjRw1lx7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qQPje3YQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qCHfTd4G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED7319DFA5
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 03:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740366606; cv=none; b=uoY/LbtKb5Ws39zx1hlTic0Be+KsrNrvffMFFeMM2DQocEGaYPupEZ8WYOHYtFmizrZoFcjSEdSrdJPj9vrYdTGfTrFYbNwNjACP3b4Zm3wczy+mPkTSTYf52DckJs/yvWMRiDVrXBtWjZGsI8FKCYuo6tR4dG4nruX+iVq6NQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740366606; c=relaxed/simple;
	bh=9r5+q8DHKX788ZEFFhiVUo26VVjWFeDu05g9DDwaDMs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=j3Se+O4f3viuxoit6J3OVxEYQMy/7+lTjveDljMGXkAEOXf/EKznQwAPg2qRpcq94cjLyf2elkb7YkuWHdWdIKliBahQfsakceD/Wb7J9/I7PawRpwZpXjHSYTd/kqvjN3HQXFOAy7jgAoJv5DCn8f83rgN1VdkDlrTWXQNAtmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=loDVWSzz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QjRw1lx7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qQPje3YQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qCHfTd4G; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 025F32116D;
	Mon, 24 Feb 2025 03:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740366601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wmhavDDqxnU6LOWYcidWK7vEHgKnUEjbsfTBIBD39OU=;
	b=loDVWSzzfX7dRCGS9w4Q2v36XewRGh5YTGpWLQBGc51FHhgtpXjGBVSUth1WTHbT2HOLpw
	MmoD+EUp4ECa+PV4IVZ8iE7dzwOoYN+0t1z8w2wVXObQNT6dRom2PBwnYFY9kqvf73k+tz
	WuN01rM8TL6kSU/CzQCYJ3pe9JSf3mQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740366601;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wmhavDDqxnU6LOWYcidWK7vEHgKnUEjbsfTBIBD39OU=;
	b=QjRw1lx7o9Ya+y6S1+Lq31txEDEF+cG9AoYWSq4bk170sL8QVbcDL34FWJXle+ELQJHdWE
	HynNG48KqNrXn0AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qQPje3YQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qCHfTd4G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740366600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wmhavDDqxnU6LOWYcidWK7vEHgKnUEjbsfTBIBD39OU=;
	b=qQPje3YQS7d0p/XHpgNeHHpc2X/VLCetqDr7a8pXsJ5aPSR3SAF3VazYjEHp1KxQ/mYnML
	qGvz80h71rw5AmtPtlpWNrtYTfRbfGevDfOslAHGKWrFpfL303WDxl95ZVzwXdUofl+qQZ
	exeV/QkhyeJEtpiylFG4/p1A4Su/RLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740366600;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wmhavDDqxnU6LOWYcidWK7vEHgKnUEjbsfTBIBD39OU=;
	b=qCHfTd4GoP23Op2upORnBqfwGNEOp2Ym1GxccogurCW6unEhk5lX89noOIDRQFZ0ko/HiU
	Ycctm5os4cezrhCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F013613332;
	Mon, 24 Feb 2025 03:09:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xSMDKP/iu2cKAgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 24 Feb 2025 03:09:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Al Viro" <viro@zeniv.linux.org.uk>, Trond Myklebust <trondmy@kernel.org>
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
Subject:
 Re: [PATCH 1/6] Change inode_operations.mkdir to return struct dentry *
In-reply-to: <20250224020933.GV1977892@ZenIV>
References: <>, <20250224020933.GV1977892@ZenIV>
Date: Mon, 24 Feb 2025 14:09:48 +1100
Message-id: <174036658872.74271.7972364767583388815@noble.neil.brown.name>
X-Rspamd-Queue-Id: 025F32116D
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
	RCPT_COUNT_TWELVE(0.00)[25];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,uio.no:email,noble.neil.brown.name:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 24 Feb 2025, Al Viro wrote:
> On Mon, Feb 24, 2025 at 12:34:06PM +1100, NeilBrown wrote:
> > On Sat, 22 Feb 2025, Al Viro wrote:
> > > On Fri, Feb 21, 2025 at 10:36:30AM +1100, NeilBrown wrote:
> > >=20
> > > > +In general, filesystems which use d_instantiate_new() to install the=
 new
> > > > +inode can safely return NULL.  Filesystems which may not have an I_N=
EW inode
> > > > +should use d_drop();d_splice_alias() and return the result of the la=
tter.
> > >=20
> > > IMO that's a bad pattern, _especially_ if you want to go for "in-update"
> > > kind of stuff later.
> >=20
> > Agreed.  I have a draft patch to change d_splice_alias() and
> > d_exact_alias() to work on hashed dentrys.  I thought it should go after
> > these mkdir patches rather than before.
>=20
> Could you give a braindump on the things d_exact_alias() is needed for?
> It's a recurring headache when doing ->d_name/->d_parent audits; see e.g.
> https://lore.kernel.org/all/20241213080023.GI3387508@ZenIV/ for related
> mini-rant from the latest iteration.
>=20
> Proof of correctness is bloody awful; it feels like the primitive itself
> is wrong, but I'd never been able to write anything concise regarding
> the things we really want there ;-/
>=20

As I understand it, it is needed (or wanted) to handle the possibility
of an inode becoming "stale" and then recovering.  This could happen,
for example, with a temporarily misconfigured NFS server.

If ->d_revalidate gets a NFSERR_STALE from the server it will return '0'
so lookup_fast() and others will call d_invalidate() which will d_drop()
the dentry.  There are other paths on which -ESTALE can result in d_drop().

If a subsequent attempt to "open" the name successfully finds the same
inode we want to reuse the old dentry rather than create a new one.

I don't really understand why.  This code was added 20 years ago before
git.
It was introduced by

commit 89a45174b6b32596ea98fa3f89a243e2c1188a01
Author: Trond Myklebust <trond.myklebust@fys.uio.no>
Date:   Tue Jan 4 21:41:37 2005 +0100

     VFS: Avoid dentry aliasing problems in filesystems like NFS, where
          inodes may be marked as stale in one instance (causing the dentry
          to be dropped) then re-enabled in the next instance.
   =20
     Signed-off-by: Trond Myklebust <trond.myklebust@fys.uio.no>

in history.git

Trond: do you have any memory of this?  Can you explain what the symptom
was that you wanted to fix?

The original patch used d_add_unique() for lookup and atomic_open and
readdir prime-dcache.  We now only use it for v4 atomic_open.  Maybe we
don't need it at all?  Or maybe we need to restore it to those other
callers?=20


Thanks,
NeilBrown

