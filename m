Return-Path: <linux-fsdevel+bounces-79453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDFQJ+raqGnGxwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 02:22:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0B8209C63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 02:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF16A3047BF6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 01:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A56231C9F;
	Thu,  5 Mar 2026 01:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="OjQYphkn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fHbQJOXH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F82232395
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Mar 2026 01:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772673765; cv=none; b=MY4ao5D+2hk3IMYZpjtCZcdIynzQbiOiXKUXS/WZgsEiXF4cKWUxhR0imMKux84ovPQw8SO+orgdQzG4tRP0iOj9xv6UU+4YH492wBs3fV0+n38L7sMGp9lonMudTIdbCJjFNp6T+96hEPhmAJ1XzlNljQXm401IKmdl1KzqYWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772673765; c=relaxed/simple;
	bh=E0/GdZU/L9szEuo5VptLR7RRlY7vBrasso/cQl8v6wo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=rkxi5csP+GMlpCEj0uX68mLNYqNNrKRvLca9YAV3R3tEK99TeCXXydFEMFQwCk1payk6Dbk1/n2mkI19UQnKvljprhmFOtYXdye4bEHeXnXg2gShbcJQ8lpKsPk2vBEVpkXSpUzHt7abLN/J4WVuC5oYs8OkP7uPbwG04ryk6oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=OjQYphkn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fHbQJOXH; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A8840EC008A;
	Wed,  4 Mar 2026 20:22:41 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 04 Mar 2026 20:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1772673761; x=1772760161; bh=ydnhdsy9b13CMSg/+9Ih5VQhCaX+KeXXZwr
	Q9OQAffw=; b=OjQYphknI33e/aEEqy1ZGGrCl0wGiKx1VYY7fZOA+v6FJugPtbp
	lBvB8ZKCitK87rHWzk5zjvpKVGI1dineafgrCA2FRZHiQKkrzzcN5Wbx7Br5r6be
	ZVMpdbbGay+jM5tbisVKlynds6g0r7vkNlY2FD4y9Wk4IzTtl2pzQVJjDaUrCdF9
	aXUEbdgDO4/jbtlTlHCgvC+iE1dHDLHKHt2swn+yBmVwHrhTTii9koLXUHZUjpXA
	pvvD90ksK6Qen8k+/5yzi2nFZ4gW/uM+I0do5ESncJhqRkxLB9JXtk7CKe48gwb0
	EsSjFARqM0H7sFbAiMdh/o4DQgeizehUlMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772673761; x=
	1772760161; bh=ydnhdsy9b13CMSg/+9Ih5VQhCaX+KeXXZwrQ9OQAffw=; b=f
	HbQJOXHSspjxfBm0xQg+5zpTVgHUm5AOlE3UL6yBrNTNyavXHi/uqiP8FSNgHB5X
	GINmntc8GISjtGDH+gs5kX5MzmE9ywE5erOtDsoXuD/gFn2ICg66P+9GR6F5ZhNz
	pOav90lFnuxyqIdFUqMuANwiodZZjoSCOZsqQwue5xDn9mxHYP1IPZWvVVWqLWlN
	jy1+hbygMxwhS+PRVFhZcC4HazPymCrtKG948x/C79bt+lgz/6WjAdmiLBeAlXqO
	mFiU32nYRBhRrK2NxQF5xqKSOuzwm74qf/yDXp5KADWUUoQkct62xFwdJLQ69k3w
	zJaGWP4bLwfFI2aW9UK1Q==
X-ME-Sender: <xms:4NqoaXxcHQKKpAPjRdX2cM67sBkx56d8L_SmS0mEDsd4vTmrgYtlnw>
    <xme:4Nqoaft-iSP4sf88hnAZQXRBhxgakhAXTZzHw1aS4lckEjJUzEvqtZzz-ieMo4gMO
    b5jTA4WWFMxPw7aNpdqKoqySY_jzpI0N8S_06l5wcSJEQe0Hw>
X-ME-Received: <xmr:4NqoaSCPCyz8JdX5dG67f_x1ek5wF7JLxfOzLUl25Aar8V5PYy4bG8QqGjFPh9SnSVjXO7g-HiRHjqqMkHhHnYQByD8SB8RSIzPBCZp2TU_m>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieehtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdeuteelkeejkeevteetvedtkeegleduieeftdeftefgtddtleejgfelgfevffeinecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehvihhrohesii
    gvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheplhhinhhugidqfhhsuggv
    vhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrggtkhesshhush
    gvrdgtiidprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprh
    gtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgr
    uhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohhsthgvughtsehgohhoug
    hmihhsrdhorhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:4NqoaZGXzkyzo3IL9PVdXpVctFcLvXeuvoOVicmNpGQgSKi3PWkihw>
    <xmx:4NqoaaAHdTtJhV-yWs4SNd0v3SYu6FfdawNWOckZKgJJIwLjGw6luA>
    <xmx:4NqoaXkAo229hHhei86iWBmT_wcLuzlbi4nyKxlvFtn-Js0hvZ_a1w>
    <xmx:4NqoaYPBfdouG5bwFsmr3DPUma0knJFKDdsfiico6lUZ2ZInpc6P9g>
    <xmx:4dqoaZ3hWlb2NZ8HqJeb_Fphw4PyXuu6QlvzeXwZ8X40Js3LV0PgyC2t>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 20:22:37 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jan Kara" <jack@suse.cz>,
 "Christian Brauner" <brauner@kernel.org>, "Al Viro" <viro@zeniv.linux.org.uk>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Steven Rostedt" <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: use simple_end_creating helper to consolidate
 fsnotify hooks
In-reply-to:
 <CAOQ4uxj1P6snjRq3Z9qiks2LjdzsAg1d8m5LetrJ1yJ+ibeVGg@mail.gmail.com>
References: <20260302183741.1308767-1-amir73il@gmail.com>,
 <20260302183741.1308767-3-amir73il@gmail.com>,
 <fc9c776f-bc8b-4081-ad9e-b4ebc40b9974@oracle.com>,
 <CAOQ4uxjHeUBfFLwahmaHj+ZKq=CxQGShi1-m_HQuWSjMa=f1-A@mail.gmail.com>,
 <177253370359.7472.12148587434874484168@noble.neil.brown.name>,
 <CAOQ4uxj1P6snjRq3Z9qiks2LjdzsAg1d8m5LetrJ1yJ+ibeVGg@mail.gmail.com>
Date: Thu, 05 Mar 2026 12:22:34 +1100
Message-id: <177267375453.7472.3166334291090560984@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Queue-Id: 1E0B8209C63
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79453-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 03 Mar 2026, Amir Goldstein wrote:
> On Tue, Mar 3, 2026 at 11:28=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
> >
> > On Tue, 03 Mar 2026, Amir Goldstein wrote:
> > > On Mon, Mar 2, 2026 at 11:28=E2=80=AFPM Chuck Lever <chuck.lever@oracle=
.com> wrote:
> > > >
> > > > On 3/2/26 1:37 PM, Amir Goldstein wrote:
> > > > > Add simple_end_creating() helper which combines fsnotify_create/mkd=
ir()
> > > > > hook and simple_done_creating().
> > > > >
> > > > > Use the new helper to consolidate this pattern in several pseudo fs
> > > > > which had open coded fsnotify_create/mkdir() hooks:
> > > > > binderfs, debugfs, nfsctl, tracefs, rpc_pipefs.
> > > > >
> > > > > For those filesystems, the paired fsnotify_delete() hook is already
> > > > > inside the library helper simple_recursive_removal().
> > > > >
> > > > > Note that in debugfs_create_symlink(), the fsnotify hook was missin=
g,
> > > > > so the missing hook is fixed by this change.
> > > > >
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > >
> > > > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > > > index e9acd2cd602cb..6e600d52b66d0 100644
> > > > > --- a/fs/nfsd/nfsctl.c
> > > > > +++ b/fs/nfsd/nfsctl.c
> > > > > @@ -17,7 +17,6 @@
> > > > >  #include <linux/sunrpc/rpc_pipe_fs.h>
> > > > >  #include <linux/sunrpc/svc.h>
> > > > >  #include <linux/module.h>
> > > > > -#include <linux/fsnotify.h>
> > > > >  #include <linux/nfslocalio.h>
> > > > >
> > > > >  #include "idmap.h"
> > > > > @@ -1146,8 +1145,7 @@ static struct dentry *nfsd_mkdir(struct dentr=
y *parent, struct nfsdfs_client *nc
> > > > >       }
> > > > >       d_make_persistent(dentry, inode);
> > > > >       inc_nlink(dir);
> > > > > -     fsnotify_mkdir(dir, dentry);
> > > > > -     simple_done_creating(dentry);
> > > > > +     simple_end_creating(dentry);
> > > > >       return dentry;  // borrowed
> > > > >  }
> > > > >
> > > > > @@ -1178,8 +1176,7 @@ static void _nfsd_symlink(struct dentry *pare=
nt, const char *name,
> > > > >       inode->i_size =3D strlen(content);
> > > > >
> > > > >       d_make_persistent(dentry, inode);
> > > > > -     fsnotify_create(dir, dentry);
> > > > > -     simple_done_creating(dentry);
> > > > > +     simple_end_creating(dentry);
> > > > >  }
> > > > >  #else
> > > > >  static inline void _nfsd_symlink(struct dentry *parent, const char=
 *name,
> > > > > @@ -1219,7 +1216,6 @@ static int nfsdfs_create_files(struct dentry =
*root,
> > > > >                               struct nfsdfs_client *ncl,
> > > > >                               struct dentry **fdentries)
> > > > >  {
> > > > > -     struct inode *dir =3D d_inode(root);
> > > > >       struct dentry *dentry;
> > > > >
> > > > >       for (int i =3D 0; files->name && files->name[0]; i++, files++=
) {
> > > > > @@ -1236,10 +1232,9 @@ static int nfsdfs_create_files(struct dentry=
 *root,
> > > > >               inode->i_fop =3D files->ops;
> > > > >               inode->i_private =3D ncl;
> > > > >               d_make_persistent(dentry, inode);
> > > > > -             fsnotify_create(dir, dentry);
> > > > >               if (fdentries)
> > > > >                       fdentries[i] =3D dentry; // borrowed
> > > > > -             simple_done_creating(dentry);
> > > > > +             simple_end_creating(dentry);
> > > > >       }
> > > > >       return 0;
> > > > >  }
> > > >
> > > > For the NFSD hunks:
> > > >
> > > > Acked-by: Chuck Lever <chuck.lever@oracle.com>
> > >
> > > FWIW, you are technically also CCed for the sunrpc hunk ;)
> > >
> > > BTW, forgot to CC Neil and mention this patch:
> > > https://lore.kernel.org/linux-fsdevel/20260224222542.3458677-5-neilb@ow=
nmail.net/
> > >
> > > Since simple_done_creating() starts using end_creating()
> > > so should simple_end_creating().
> > > I will change that in v2 after waiting for more feedback on v1.
> > >
> > > I don't want to get into naming discussion - I will just say that I wan=
ted
> > > to avoid renaming simple_done_creating() to avoid unneeded churn.
> > >
> > > Thanks,
> > > Amir.
> > >
> >
> > Thanks for the Cc.
> >
> > Would there be a problem with doing the fs-notify for *every* caller of
> > simple_done_creating?
>=20
> 1. simple_done_creating() is also called for the failed case, where the
> fsnotify hook is not desired. I am not sure if failure is always equivalent
> to negative child dentry.

If the dentry is still hashed and positive, then it is hard to see that
could represent a failure.  If it is unhashed or negative, then ...  it
could possibly be a success as some filesystems create the object but
leave it to a subsequent ->lookup to add it to the dcache.  I doubt such
filesystems would be using simple_* though.

>=20
> 2. I assume you meant the simple_done_creating() calls in other fs that
> do not have fsnotify hooks in current code. This is a valid point.
> I am hesitant to add the FS_CREATE events for *all* the pseudo fs
> dentry creations.
> Specifically, I think we need not send the events for init/populate of fs.

fsnotify_create hooks are effectively no-op if no "marks" have be
registered on sb or parent inode.  During init/populate there would be
no marks.

I think filesystems should have a good reason for opting out of
fsnotify, and it should be harder to opt-out than to opt-in.

> It's worth nothing that some of those fs do already send FS_DELETE
> events via simple_recursive_removal().
> =16
> > It does make sense to include the notify in the common code, but having
> > two different interfaces that only differ in the notification (and don't
> > contain some form of "notify" in their name) does seem like a recipe for
> > confusion.
>=20
> Right. I could make it simple_end_creating_notify().
>=20
> Now where does this sound familiar from?
>=20
> Oh yeah, my old fsnotify path hooks series [1] :)

Everything old is new again :-)

Thanks,
NeilBrown

>=20
> Cheers,
> Amir.
>=20
> [1]  https://lore.kernel.org/linux-fsdevel/CAOQ4uxi-UhF=3D6eaxhybvdBX-L5qYx=
_uEuu-eCiiUzJPvz2U8aw@mail.gmail.com/
>=20


