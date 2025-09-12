Return-Path: <linux-fsdevel+bounces-61123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D305CB55689
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 20:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13D6CBA10BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 18:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B531132F77D;
	Fri, 12 Sep 2025 18:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EpVNHnT3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086F0226D1E
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757702761; cv=none; b=W9p9DS4jPiYU2RlOxkzldBFmLS5eRkWMFwusWv2jNGDtLTb50fR2zdFMp8H/GzgzJS6rWxljnCxzzJ0Fn6eC3slRbbi1MQyrIKNX8oIZBl7Vs80CcpCB3Ogv+/QwnI0YGLNIwo+Rdly/72pyW0Cei0asAt3o5Z5ljLyk7uXrCKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757702761; c=relaxed/simple;
	bh=A0HsV2MnP6iH/Do8brptMwjvhF5IwQj7K9mgvYYjuoI=;
	h=In-Reply-To:References:To:Cc:Subject:From:MIME-Version:
	 Content-Type:Date:Message-ID; b=ozxXHLkli6RGcGDxlnoQELDrOdNiTw4IXMb3eVadX+Koz2TZfox+2anjEPd6mV5aRmQuok6bRR5BAfXwNh2fldia5BGQcWScUiuKTHa0bQ96UatQZs5nUNJxTp8JzRlaPl704kDde4j/vO4m47laP2/+eR2udP7GXBHqR0LyjBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EpVNHnT3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757702758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+DjIekluZb6We44BXQBGQrj/DVYvNiyDYg9lRbD2GVE=;
	b=EpVNHnT3pQhoNkrQCwFcBCCGPzpnJp5WNAi6KtAJJwlakoiCry/N4dTwJ7Gaexa4/r7039
	bCXNOHznfg+Gd5R74LOHJsiq6MKTGVugpwygnUu8xAUXRThzEiKHsrCGhN+A9kCIyRwMcg
	5x/mgGAnvtYuQNC+V0dv9meTf+AgB7Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-4ejy5bkdPNGwn3KTVU0yvw-1; Fri,
 12 Sep 2025 14:45:56 -0400
X-MC-Unique: 4ejy5bkdPNGwn3KTVU0yvw-1
X-Mimecast-MFC-AGG-ID: 4ejy5bkdPNGwn3KTVU0yvw_1757702755
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 847541953946;
	Fri, 12 Sep 2025 18:45:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 306D5300021A;
	Fri, 12 Sep 2025 18:45:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <CAHk-=wju8XTW6MntZQ7HX2dCTtyrTb9oVCP3p60vtBhZebMA4g@mail.gmail.com>
References: <CAHk-=wju8XTW6MntZQ7HX2dCTtyrTb9oVCP3p60vtBhZebMA4g@mail.gmail.com> <20250828230806.3582485-1-viro@zeniv.linux.org.uk> <20250828230806.3582485-61-viro@zeniv.linux.org.uk> <CAHk-=wgZEkSNKFe_=W=OcoMTQiwq8j017mh+TUR4AV9GiMPQLA@mail.gmail.com> <20250829001109.GB39973@ZenIV> <CAHk-=wg+wHJ6G0hF75tqM4e951rm7v3-B5E4G=ctK0auib-Auw@mail.gmail.com> <20250829060306.GC39973@ZenIV> <20250829060522.GB659926@ZenIV> <20250829-achthundert-kollabieren-ee721905a753@brauner> <20250829163717.GD39973@ZenIV> <20250830043624.GE39973@ZenIV> <20250830073325.GF39973@ZenIV> <CAHk-=wiSNJ4yBYoLoMgF1M2VRrGfjqJZzem=RAjKhK8W=KohzQ@mail.gmail.com> <ed70bad5-c1a8-409f-981e-5ca7678a3f08@gotplt.org> <CAHk-=whb6Jpj-w4GKkY2XccG2DQ4a2thSH=bVNXhbTG8-V+FSQ@mail.gmail.com> <663880.1756835288@warthog.procyon.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, Siddhesh Poyarekar <siddhesh@gotplt.org>,
    Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
    jack@suse.cz, Ian Kent <raven@themaw.net>,
    Christian Brauner <brauner@kernel.org>,
    Jeffrey Altman <jaltman@auristor.com>, linux-afs@lists.infradead.org
Subject: Re: [RFC] does # really need to be escaped in devnames?
From: David Howells <dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2317244.1757702749.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Sep 2025 19:45:49 +0100
Message-ID: <2317245.1757702749@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

How about the attached?  I've changed the way the volume is displayed in
/proc/mounts to use the numeric volume ID, e.g.:

	openafs.org:536870922~root.doc on /afs/openafs.org/doc type afs (ro,relat=
ime,flock=3Dlocal)

but included the volume name as kind of a comment as it's easier for human=
 eye
to comprehend.  I've also altered the afs mount devname parser so that it =
can
handle this sort of devname and to discard the "comment".

We don't actually need to display the [#%] preference marker or the
.readonly/.backup suffixes as they're only really relevant when resolving =
a
mountpoint.  See:

	https://docs.openafs.org/AdminGuide/HDRWQ208.html#HDRWQ209

(we only need to know what sort of mount we're on and if we're given an
explicit instruction).

David
---
afs: Fix devname used in /proc/mounts

There's an issue with the way kafs mounts are displayed in /proc/mounts an=
d
supplied in the mount device name: the devname may begin with either a '#'
or a '%'.  The former is a problem, however, as some tools interpret this
as a comment (e.g. getmntent(3)).

There is another pair of issues as well in that the volume name may be
changed whilst the volume is mounted and the volume name may be remapped t=
o
a different volume.  Really, the volume name should only be considered
during mount and the volume ID (which is part of the primary key to sget()=
)
should be used instead where possible.  That said, it's more user-friendly
to see the volume name in /proc/mounts.

Fix this by:

 (1) Change the kafs device name used in /proc/mounts such that it shows
     the cell and the volume number with the current volume name after a
     tilda, e.g.:

        openafs.org:536870922~root.doc on /afs/grand.central.org/doc type =
afs (ro,relatime,flock=3Dlocal)

 (2) Alter the mount name parsing so that it accepts:
        "[<cell>:]<volid>[~comment]"

     as the device name, thereby allowing stuff scraped from /proc/mounts
     to be fed back, e.g.:

        mount -t afs openafs.org:536870922~root.doc /mnt
        mount -t afs openafs.org:536870922 /mnt
        mount -t afs 536870922 /mnt

     The "comment" is ignored, allowing the current volume name (which is
     subject to third party changes) to also be displayed.

The parsing of the AFS mountpoint target format is retained both for
backward compatibility and to be able to handle automounting, e.g.:

        mount -t afs \#openafs.org:root.doc /mnt
        ls /afs/openafs.org/doc

Note that this may surprise any tools that expect to see the old forms of
kafs line in /proc/mounts.

Reported-by: Siddhesh Poyarekar <siddhesh@gotplt.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: Jan Kara <jack@suse.cz>
cc: Ian Kent <raven@themaw.net>
cc: Christian Brauner <brauner@kernel.org>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/internal.h |    1 =

 fs/afs/super.c    |  105 +++++++++++++++++++++++++++++++-----------------=
------
 2 files changed, 63 insertions(+), 43 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 1124ea4000cb..392c1df4651a 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -53,6 +53,7 @@ struct afs_fs_context {
 	bool			autocell;	/* T if set auto mount operation */
 	bool			dyn_root;	/* T if dynamic root */
 	bool			no_cell;	/* T if the source is "none" (for dynroot) */
+	bool			by_vid;		/* T if mount by volume ID */
 	enum afs_flock_mode	flock_mode;	/* Partial file-locking emulation mode *=
/
 	afs_voltype_t		type;		/* type of volume requested */
 	unsigned int		volnamesz;	/* size of volume name */
diff --git a/fs/afs/super.c b/fs/afs/super.c
index da407f2d6f0d..9b1d8ac39261 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -158,29 +158,13 @@ static int afs_show_devname(struct seq_file *m, stru=
ct dentry *root)
 	struct afs_super_info *as =3D AFS_FS_S(root->d_sb);
 	struct afs_volume *volume =3D as->volume;
 	struct afs_cell *cell =3D as->cell;
-	const char *suf =3D "";
-	char pref =3D '%';
 =

 	if (as->dyn_root) {
 		seq_puts(m, "none");
 		return 0;
 	}
 =

-	switch (volume->type) {
-	case AFSVL_RWVOL:
-		break;
-	case AFSVL_ROVOL:
-		pref =3D '#';
-		if (volume->type_force)
-			suf =3D ".readonly";
-		break;
-	case AFSVL_BACKVOL:
-		pref =3D '#';
-		suf =3D ".backup";
-		break;
-	}
-
-	seq_printf(m, "%c%s:%s%s", pref, cell->name, volume->name, suf);
+	seq_printf(m, "%s:%llu~%s", cell->name, volume->vid, volume->name);
 	return 0;
 }
 =

@@ -219,12 +203,16 @@ static int afs_show_options(struct seq_file *m, stru=
ct dentry *root)
  *	"#[cell:]volume.readonly"	R/O volume
  *	"%[cell:]volume.backup"		Backup volume
  *	"#[cell:]volume.backup"		Backup volume
+ *
+ * or:
+ *	[cell:]volumeid[~ignored-vol-name]
  */
 static int afs_parse_source(struct fs_context *fc, struct fs_parameter *p=
aram)
 {
 	struct afs_fs_context *ctx =3D fc->fs_private;
 	struct afs_cell *cell;
 	const char *cellname, *suffix, *name =3D param->string;
+	char qual =3D 0;
 	int cellnamesz;
 =

 	_enter(",%s", name);
@@ -232,33 +220,39 @@ static int afs_parse_source(struct fs_context *fc, s=
truct fs_parameter *param)
 	if (fc->source)
 		return invalf(fc, "kAFS: Multiple sources not supported");
 =

-	if (!name) {
+	if (!name || !name[0]) {
 		printk(KERN_ERR "kAFS: no volume name specified\n");
 		return -EINVAL;
 	}
 =

-	if ((name[0] !=3D '%' && name[0] !=3D '#') || !name[1]) {
-		/* To use dynroot, we don't want to have to provide a source */
-		if (strcmp(name, "none") =3D=3D 0) {
-			ctx->no_cell =3D true;
-			return 0;
-		}
-		printk(KERN_ERR "kAFS: unparsable volume name\n");
-		return -EINVAL;
+	/* To use dynroot, we don't want to have to provide a source */
+	if (strcmp(name, "none") =3D=3D 0) {
+		ctx->no_cell =3D true;
+		return 0;
 	}
 =

 	/* determine the type of volume we're looking for */
-	if (name[0] =3D=3D '%') {
+	switch (name[0]) {
+	case '%':
 		ctx->type =3D AFSVL_RWVOL;
 		ctx->force =3D true;
+		fallthrough;
+	case '#':
+		qual =3D *name++;
+		if (!*name)
+			goto unparseable;
+		break;
 	}
-	name++;
 =

 	/* split the cell name out if there is one */
 	ctx->volname =3D strchr(name, ':');
 	if (ctx->volname) {
 		cellname =3D name;
 		cellnamesz =3D ctx->volname - name;
+		if (!cellnamesz) {
+			printk(KERN_ERR "kAFS: Empty cell name specified\n");
+			return -EINVAL;
+		}
 		ctx->volname++;
 	} else {
 		ctx->volname =3D name;
@@ -266,24 +260,45 @@ static int afs_parse_source(struct fs_context *fc, s=
truct fs_parameter *param)
 		cellnamesz =3D 0;
 	}
 =

-	/* the volume type is further affected by a possible suffix */
-	suffix =3D strrchr(ctx->volname, '.');
-	if (suffix) {
-		if (strcmp(suffix, ".readonly") =3D=3D 0) {
-			ctx->type =3D AFSVL_ROVOL;
-			ctx->force =3D true;
-		} else if (strcmp(suffix, ".backup") =3D=3D 0) {
-			ctx->type =3D AFSVL_BACKVOL;
-			ctx->force =3D true;
-		} else if (suffix[1] =3D=3D 0) {
-		} else {
-			suffix =3D NULL;
+	if (!qual) {
+		const char *cp =3D ctx->volname;
+
+		while (isdigit(*cp))
+			cp++;
+		if (cp =3D=3D ctx->volname) {
+			printk(KERN_ERR "kAFS: Empty volume ID specified\n");
+			return -EINVAL;
+		}
+		if (*cp !=3D 0 && *cp !=3D '~') {
+			printk(KERN_ERR "kAFS: Expected decimal volume ID\n");
+			return -EINVAL;
 		}
-	}
 =

-	ctx->volnamesz =3D suffix ?
-		suffix - ctx->volname : strlen(ctx->volname);
+		ctx->by_vid	=3D true;
+		ctx->volnamesz	=3D cp - ctx->volname;
+	} else {
+		/* the volume type is further affected by a possible suffix */
+		suffix =3D strrchr(ctx->volname, '.');
+		if (suffix) {
+			if (strcmp(suffix, ".readonly") =3D=3D 0) {
+				ctx->type =3D AFSVL_ROVOL;
+				ctx->force =3D true;
+			} else if (strcmp(suffix, ".backup") =3D=3D 0) {
+				ctx->type =3D AFSVL_BACKVOL;
+				ctx->force =3D true;
+			} else if (suffix[1] =3D=3D 0) {
+			} else {
+				suffix =3D NULL;
+			}
+		}
 =

+		ctx->volnamesz =3D suffix ?
+			suffix - ctx->volname : strlen(ctx->volname);
+		if (!ctx->volnamesz) {
+			printk(KERN_ERR "kAFS: Empty volume name specified\n");
+			return -EINVAL;
+		}
+	}
 	_debug("cell %*.*s [%p]",
 	       cellnamesz, cellnamesz, cellname ?: "", ctx->cell);
 =

@@ -310,6 +325,10 @@ static int afs_parse_source(struct fs_context *fc, st=
ruct fs_parameter *param)
 	fc->source =3D param->string;
 	param->string =3D NULL;
 	return 0;
+
+unparseable:
+	printk(KERN_ERR "kAFS: unparsable volume name\n");
+	return -EINVAL;
 }
 =

 /*


