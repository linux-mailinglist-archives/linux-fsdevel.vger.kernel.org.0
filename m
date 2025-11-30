Return-Path: <linux-fsdevel+bounces-70283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B12C95536
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Nov 2025 23:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4C83A2217
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Nov 2025 22:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19FE248880;
	Sun, 30 Nov 2025 22:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="hy5/vAJ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y272tXC1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3910C3B2A0;
	Sun, 30 Nov 2025 22:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764540402; cv=none; b=RGzH1OxeY6nbEXzPkR7hFcRZlqmnjmAdAZZIk/zPmaeKugglFqVw1mIX0LXUNIj5u7ORkDPOnOnfhwMprNwRM2S6wXzbs5mxrvtb6s6WfiumciEmXPG9xuXtPjyyc4/Qyl9eJFSsmYxN9VYq95teKLG90Fz1z7blXVRBYLHi5Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764540402; c=relaxed/simple;
	bh=H286xqveeebZVFlOJOqpEwPmE65EXLOG8U9NM8Xrtdo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=fwfqN3gFzr4Xu90ky6wvZw52VsseSGe4d290cNcfWsMnEs8Fm3/4Z7FPUD1Unv5JOdQ4OY1x72ed68j0ssGHEmoSIjA+ji/lWkOzrtzUKdjdLzsLTyo+dPzviyvc6Pz1PzTkUiJLQhNlmySI8/Cv4QHnSM/WnG43hm5oDJmY468=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=hy5/vAJ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y272tXC1; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailflow.phl.internal (Postfix) with ESMTP id 450E51380024;
	Sun, 30 Nov 2025 17:06:38 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sun, 30 Nov 2025 17:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1764540398; x=1764547598; bh=cUn5L4iU3G/E8nSDoCgXMFvcb9eqiqLJ+fQ
	AZ+yuHdY=; b=hy5/vAJ7VDnRhPu4NAEcVVv5VsCE99D675b1O637LQNqU1hryk/
	A/EwucRaao1fI6D4r6ZaOKqt2g6bmwWC4pZER7WFg+rFCQJU+ghwRrHn8QdyHh7U
	wWrBMhq2Gz88NaUam/Uq4qYHiRRHRS43Kz0SBZ7JqhyEsObMvhqjQEB18G2yKbv8
	yZo7Nck5pHkxnO0T5Eqt9hVBjZXdX2JWgv8T+9wL+ZEOTb7ZQl7RL2SWsVPnG30f
	k31TDgRK0oxDUB7RDk6Gn1QUd+OOIrsHKSLwbo2u8ivxkF5LYs296RGBl7CItxJS
	i7rfTNDNyp5c/ImAnGydvwA9he1U6kda60Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764540398; x=
	1764547598; bh=cUn5L4iU3G/E8nSDoCgXMFvcb9eqiqLJ+fQAZ+yuHdY=; b=y
	272tXC1TzhAQ6gKrWtHDyuZvjT0XwA6swylW6W+atTM93qeEOrbVAHzYzJLoqQeC
	4GAyjyJmLnqETLkstn0asGU2zEK6cBwQ75RawoX+ZjBG3onwhYv5SEaKOY3NEfJ/
	D/rjR4jx39PlpAy2UFJsDkDrb08XtOsIIdBZHG8UuB3/RKc56tcM/hqKQjkmP5z+
	y84WFGJ+dLJbBCHcjOJEFOiqpy2sCoU8Ex1CT+3+XVkc0fevdIyFWHPN4Kh5wI7/
	Tm4Rh0LpFY6U1lvMP5w4Cq5Lev0WWHd6eNXh//JI9Y07T14zV4IqrdwpubzOXJVu
	uBLOYqtxMytIs/omBPIBg==
X-ME-Sender: <xms:7L8saTWcEafKZ2FpjadU01KY8PuBlI8D2__CoFf7AH7DE8vVThGARA>
    <xme:7L8saS2Hg_Agw2b_UqsdZapIuyLwRvHe8PG9OhPVIF9JtTRGry871lIsum6vmo9Tm
    NmTP9dpkW6ErCDzE1FP_5HkWztCLYM1_0aFREAH-RdZyk9E>
X-ME-Received: <xmr:7L8saX9eeiVROyJDWFcHpO0l-SnDtbn3IMZ8yovZ9u11OJLcVhVEVwx3pE40OdgljGfKwHLnp8Z34cVEftMbygtc7KphNEIDVeVZ9U-Me9Og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheehleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdeuteelkeejkeevteetvedtkeegleduieeftdeftefgtddtleejgfelgfevffeinecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeeguddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhirhhose
    iivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehsvghlihhnuhigsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqgihfshesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgvtghurhhith
    ihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdgtihhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:7L8sabv1hwad4uB-c2PQ4ZcwG4YZgTowtFHZGh4S1mV2rmjavl4Jow>
    <xmx:7L8saVp4ytL8p8tJltTf_fg3sJ9L92UyFGAW_-zyaFMYURI9cMq0oQ>
    <xmx:7L8saTBNO0Qq7t2Rk4de2_ZalprfLHw8QVmBaPJTovyRZMtUqf011w>
    <xmx:7L8saf__QCw4QViuhSyQmGZsduckUhwXnncrojwu0fWg0rrtz3NkxQ>
    <xmx:7r8saVuqvLl2cKFnnBlIg06ge-4Sz-lh_rIp7ez61MtsKGFAbg0Db5GS>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Nov 2025 17:06:26 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Val Packett" <val@packett.cool>
Cc: "Amir Goldstein" <amir73il@gmail.com>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Chris Mason" <clm@fb.com>, "David Sterba" <dsterba@suse.com>,
 "David Howells" <dhowells@redhat.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>, "Tyler Hicks" <code@tyhicks.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Namjae Jeon" <linkinjeon@kernel.org>,
 "Steve French" <smfrench@gmail.com>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Carlos Maiolino" <cem@kernel.org>,
 "John Johansen" <john.johansen@canonical.com>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Stephen Smalley" <stephen.smalley.work@gmail.com>,
 "Ondrej Mosnacek" <omosnace@redhat.com>,
 "Mateusz Guzik" <mjguzik@gmail.com>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Stefan Berger" <stefanb@linux.ibm.com>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org,
 netfs@lists.linux.dev, ecryptfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: [PATCH] fuse: fix conversion of fuse_reverse_inval_entry() to
 start_removing()
In-reply-to: <6713ea38-b583-4c86-b74a-bea55652851d@packett.cool>
References: <20251113002050.676694-1-neilb@ownmail.net>,
 <20251113002050.676694-7-neilb@ownmail.net>,
 <6713ea38-b583-4c86-b74a-bea55652851d@packett.cool>
Date: Mon, 01 Dec 2025 09:06:18 +1100
Message-id: <176454037897.634289.3566631742434963788@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>


From: NeilBrown <neil@brown.name>

The recent conversion of fuse_reverse_inval_entry() to use
start_removing() was wrong.
As Val Packett points out the original code did not call ->lookup
while the new code does.  This can lead to a deadlock.

Rather than using full_name_hash() and d_lookup() as the old code
did, we can use try_lookup_noperm() which combines these.  Then
the result can be given to start_removing_dentry() to get the required
locks for removal.  We then double check that the name hasn't
changed.

As 'dir' needs to be used several times now, we load the dput() until
the end, and initialise to NULL so dput() is always safe.

Reported-by: Val Packett <val@packett.cool>
Closes: https://lore.kernel.org/all/6713ea38-b583-4c86-b74a-bea55652851d@pack=
ett.cool
Fixes: c9ba789dad15 ("VFS: introduce start_creating_noperm() and start_removi=
ng_noperm()")
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/fuse/dir.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index a0d5b302bcc2..8384fa96cf53 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1390,8 +1390,8 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 =
parent_nodeid,
 {
 	int err =3D -ENOTDIR;
 	struct inode *parent;
-	struct dentry *dir;
-	struct dentry *entry;
+	struct dentry *dir =3D NULL;
+	struct dentry *entry =3D NULL;
=20
 	parent =3D fuse_ilookup(fc, parent_nodeid, NULL);
 	if (!parent)
@@ -1404,11 +1404,19 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u6=
4 parent_nodeid,
 	dir =3D d_find_alias(parent);
 	if (!dir)
 		goto put_parent;
-
-	entry =3D start_removing_noperm(dir, name);
-	dput(dir);
-	if (IS_ERR(entry))
-		goto put_parent;
+	while (!entry) {
+		struct dentry *child =3D try_lookup_noperm(name, dir);
+		if (!child || IS_ERR(child))
+			goto put_parent;
+		entry =3D start_removing_dentry(dir, child);
+		dput(child);
+		if (IS_ERR(entry))
+			goto put_parent;
+		if (!d_same_name(entry, dir, name)) {
+			end_removing(entry);
+			entry =3D NULL;
+		}
+	}
=20
 	fuse_dir_changed(parent);
 	if (!(flags & FUSE_EXPIRE_ONLY))
@@ -1446,6 +1454,7 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 =
parent_nodeid,
=20
 	end_removing(entry);
  put_parent:
+	dput(dir);
 	iput(parent);
 	return err;
 }
--=20
2.50.0.107.gf914562f5916.dirty


