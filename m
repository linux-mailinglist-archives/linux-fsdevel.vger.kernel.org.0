Return-Path: <linux-fsdevel+bounces-79138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kG1XFAm4pmk7TAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:29:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBAE1ECAB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54963308F8FB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A7F39D6DF;
	Tue,  3 Mar 2026 10:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="VIGbJSW1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aL6HYt4o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9540394784
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772533715; cv=none; b=Ntw6FkZzFAbLMQgyEdP3ajkQetr6HHoxnn7ObHv4ZZHEpxU5sMqWeWIf3lcgDhu1Ei+2/C5wEHl7wQCvz9iGT0FixiCBRQeD90ZBV1cUTa1VFH3d706rhhU59aYUhc8UcvwCQEOnNBDAhj7+sb+GWoIds1RYolVIpn4wYYt0YOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772533715; c=relaxed/simple;
	bh=gvz/8x7Tf2rbhIatR3v0P6bGPCOYGHh4sU9EkiwuiN0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=tiEwJJ1YF92qx3NXuU5RVVLdfRvuuZeGtVLgEUb7sACo7eBk05H1ytRU6crCZGz+G9O6TdMPA3ovKXjqqL/Z3XZ58XdQF4Vg90o0jkbh+yvB8IujU/D4hWqM0j09JmmUj7P3hSY7bwdP75cRGNpjI6bfvp6K0DzYobEEbMXcHg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=VIGbJSW1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aL6HYt4o; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 28261EC05A4;
	Tue,  3 Mar 2026 05:28:32 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 03 Mar 2026 05:28:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1772533712; x=1772620112; bh=GDp+I2LdiRG8B32IgsU1Nfb1ljxEM2CAWWU
	+Pns+apY=; b=VIGbJSW1Q+zSXXu4oBJXA7lgtO8qkApdUxwLeUR9hsvhJXTUAIH
	LEKt8Qi1Wbdmm9XDABMZl7BVWCQWnKr4x4Vgr9po4MqsIUrVhA+CbD+vxO/6XW/F
	UVk+dwYeZ+XVX3kcGe4a25imRzBY3s10Flj3HMP7tpVIXCQZRj/NLw/LWUnCCk02
	WX3Fh87Yci9dZn0AJEDLFR0eGDaKoxwCyzdENjaZvw/ku1MNav6LkWg4Kt0+fKXF
	HycoJrpM+hGrOab5jH7sfBoEfIyNetaQzTNrOEi8ftUlBo71U/8XZokCJCGAcu6i
	wk9nt49lUngkVmho+lqJ8HCYF0A+IObKskA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772533712; x=
	1772620112; bh=GDp+I2LdiRG8B32IgsU1Nfb1ljxEM2CAWWU+Pns+apY=; b=a
	L6HYt4oZtF+6dF6RavGkRBJ4HPXPJKw+RT0LR4B7d2/4I7qFPlg8wvpelC7LFh1Z
	3i1VQyVJYd+BAic8Uo5ckCdE+BPSP/z7iILi6f8BaBumY4lhugNp1Ayqlcqom9IU
	DKjVJsND9fL/h2dUMr1mobgx/0TkkvM9bs35O9Kmfb1CKdVo+8wJZV9wMyc+NAn5
	0Ai1xXbHPCmFsAYUgL0jzX54NNtYPCyBqL8jH34pPWSje9zZHUhwG0lstX831oZE
	XPxsIzJW5O/qSBpz335QJSy2YWko1OxaF5pFmULk+EOGKP++S+MhIIq3IoEGJ7jF
	3BEcge3cYPjUjtc9TDe+w==
X-ME-Sender: <xms:z7emaah2R0aoDGVjY9IVLYq_Xjlcs_ZMgD6IjpboS3f7CHssAvAd4w>
    <xme:z7emabcrikWGK1sBHR03R6UukcSluUtkFOdV-1t7NVhLKW6feUYFRpvqL1WOdoPw0
    ayRba_S00alOM4jWY0Yg8zcGDTMECuu7bE-b-kg-_GaLStdTg>
X-ME-Received: <xmr:z7emaSwD1obnYfgK5vt08p1usLu0kHg5r1B3PGxU_z9c2UhAYWD_w79WJ36smVQ_HI-cmBy4ENFOqURitklbvG6I_YFrQ3xUHrzkMOHMhFh8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtfeegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:z7emaa3IVDwjnDdhMrGu_zrrHGNde5reM4TbT_0fltLKqgF_qi70Xg>
    <xmx:z7emaYwYh1V_8GiWMQRDf-2Jtu9uY81Oyacw7QGwgzkWSrSPxhBbkw>
    <xmx:z7emafU8GATRztJBBmT5-3J4CA7Wd5SOzdWipFbOshgCOPbEXyAcIA>
    <xmx:z7emaU_qD4kfV4mZdZrNdcov9hydRtlXAKMvOPGJQtHZlk9kHnLR7g>
    <xmx:0LemadmoczgGJ_OHcB-9aQnG-yIZSK_B6qQ1gKv1Q-btlYX7cPHUYhZM>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 05:28:28 -0500 (EST)
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
 <CAOQ4uxjHeUBfFLwahmaHj+ZKq=CxQGShi1-m_HQuWSjMa=f1-A@mail.gmail.com>
References: <20260302183741.1308767-1-amir73il@gmail.com>,
 <20260302183741.1308767-3-amir73il@gmail.com>,
 <fc9c776f-bc8b-4081-ad9e-b4ebc40b9974@oracle.com>,
 <CAOQ4uxjHeUBfFLwahmaHj+ZKq=CxQGShi1-m_HQuWSjMa=f1-A@mail.gmail.com>
Date: Tue, 03 Mar 2026 21:28:23 +1100
Message-id: <177253370359.7472.12148587434874484168@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Queue-Id: 9CBAE1ECAB4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79138-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:email,noble.neil.brown.name:mid,messagingengine.com:dkim]
X-Rspamd-Action: no action

On Tue, 03 Mar 2026, Amir Goldstein wrote:
> On Mon, Mar 2, 2026 at 11:28=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
> >
> > On 3/2/26 1:37 PM, Amir Goldstein wrote:
> > > Add simple_end_creating() helper which combines fsnotify_create/mkdir()
> > > hook and simple_done_creating().
> > >
> > > Use the new helper to consolidate this pattern in several pseudo fs
> > > which had open coded fsnotify_create/mkdir() hooks:
> > > binderfs, debugfs, nfsctl, tracefs, rpc_pipefs.
> > >
> > > For those filesystems, the paired fsnotify_delete() hook is already
> > > inside the library helper simple_recursive_removal().
> > >
> > > Note that in debugfs_create_symlink(), the fsnotify hook was missing,
> > > so the missing hook is fixed by this change.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > index e9acd2cd602cb..6e600d52b66d0 100644
> > > --- a/fs/nfsd/nfsctl.c
> > > +++ b/fs/nfsd/nfsctl.c
> > > @@ -17,7 +17,6 @@
> > >  #include <linux/sunrpc/rpc_pipe_fs.h>
> > >  #include <linux/sunrpc/svc.h>
> > >  #include <linux/module.h>
> > > -#include <linux/fsnotify.h>
> > >  #include <linux/nfslocalio.h>
> > >
> > >  #include "idmap.h"
> > > @@ -1146,8 +1145,7 @@ static struct dentry *nfsd_mkdir(struct dentry *p=
arent, struct nfsdfs_client *nc
> > >       }
> > >       d_make_persistent(dentry, inode);
> > >       inc_nlink(dir);
> > > -     fsnotify_mkdir(dir, dentry);
> > > -     simple_done_creating(dentry);
> > > +     simple_end_creating(dentry);
> > >       return dentry;  // borrowed
> > >  }
> > >
> > > @@ -1178,8 +1176,7 @@ static void _nfsd_symlink(struct dentry *parent, =
const char *name,
> > >       inode->i_size =3D strlen(content);
> > >
> > >       d_make_persistent(dentry, inode);
> > > -     fsnotify_create(dir, dentry);
> > > -     simple_done_creating(dentry);
> > > +     simple_end_creating(dentry);
> > >  }
> > >  #else
> > >  static inline void _nfsd_symlink(struct dentry *parent, const char *na=
me,
> > > @@ -1219,7 +1216,6 @@ static int nfsdfs_create_files(struct dentry *roo=
t,
> > >                               struct nfsdfs_client *ncl,
> > >                               struct dentry **fdentries)
> > >  {
> > > -     struct inode *dir =3D d_inode(root);
> > >       struct dentry *dentry;
> > >
> > >       for (int i =3D 0; files->name && files->name[0]; i++, files++) {
> > > @@ -1236,10 +1232,9 @@ static int nfsdfs_create_files(struct dentry *ro=
ot,
> > >               inode->i_fop =3D files->ops;
> > >               inode->i_private =3D ncl;
> > >               d_make_persistent(dentry, inode);
> > > -             fsnotify_create(dir, dentry);
> > >               if (fdentries)
> > >                       fdentries[i] =3D dentry; // borrowed
> > > -             simple_done_creating(dentry);
> > > +             simple_end_creating(dentry);
> > >       }
> > >       return 0;
> > >  }
> >
> > For the NFSD hunks:
> >
> > Acked-by: Chuck Lever <chuck.lever@oracle.com>
>=20
> FWIW, you are technically also CCed for the sunrpc hunk ;)
>=20
> BTW, forgot to CC Neil and mention this patch:
> https://lore.kernel.org/linux-fsdevel/20260224222542.3458677-5-neilb@ownmai=
l.net/
>=20
> Since simple_done_creating() starts using end_creating()
> so should simple_end_creating().
> I will change that in v2 after waiting for more feedback on v1.
>=20
> I don't want to get into naming discussion - I will just say that I wanted
> to avoid renaming simple_done_creating() to avoid unneeded churn.
>=20
> Thanks,
> Amir.
>=20

Thanks for the Cc.

Would there be a problem with doing the fs-notify for *every* caller of
simple_done_creating?
It does make sense to include the notify in the common code, but having
two different interfaces that only differ in the notification (and don't
contain some form of "notify" in their name) does seem like a recipe for
confusion.

Thanks,
NeilBrown

