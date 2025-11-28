Return-Path: <linux-fsdevel+bounces-70129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ECAC9198C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 11:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23FFB4E1809
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 10:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8914530B521;
	Fri, 28 Nov 2025 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0ZwJqf0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24BF3054D0
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 10:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764325162; cv=none; b=kHamLUBCU8MmQne7B4/P2fkM80tj89f/iEeQXqfLWuGywNo8kPLBHjCQkwg3oEICM285BsEUEAG0vfBOAwTD9uczFxDF/P9hB/RVV4PTxUapG8AmW0BDcKGxk3ldcLr1AKAPa670jEsR43Yz3pMQGjrYI+1T0T3VnXCfO+hNwL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764325162; c=relaxed/simple;
	bh=2e/mz9hWihgcZCXhOMQc0oIxaZiboXX8ZtttBgFa1Mw=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=NBhkJS4WijusJxWsh1TMH5egvnhoXW5LQ4idYYVy1Ryu0u9G2bAxeLfcHWTb9lu5OEuoaVuGLImJkMZoua5gGEc6wgjGLWteaooe54UifqizXHrPu/YNmVM2S2KRp6LH/n/XYgLbErcL9P+t2UVChteeQV+QdqqiG1owgW2eXqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f0ZwJqf0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764325156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2fGtcgC7L/4zeQhv/UijC1VyqdSGwSQbXxRUFqOBbvA=;
	b=f0ZwJqf0pEXJIfIThERj8xFhfpoZ38pFUbmXbGqRyaQRtWc3s3GWjnr2DquMw/wOCmDGH0
	gn7Ov5UWEFobjKr8ylfH3NaU4tYqL52RM+mVDQSVUrdMd66wlhMmTFs8uBRnKbrm7sPn4E
	sTUkTdn3bMID/u5iStqNGGaQf+GhnG0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-dtIZIuGQPdymdxhlwXh_NQ-1; Fri,
 28 Nov 2025 05:19:11 -0500
X-MC-Unique: dtIZIuGQPdymdxhlwXh_NQ-1
X-Mimecast-MFC-AGG-ID: dtIZIuGQPdymdxhlwXh_NQ_1764325149
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B1FA1800473;
	Fri, 28 Nov 2025 10:19:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 652A819560B0;
	Fri, 28 Nov 2025 10:19:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com,
    syzbot+41c68824eefb67cdf00c@syzkaller.appspotmail.com,
    Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH v3] afs: Fix delayed allocation of a cell's anonymous key
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <800327.1764325144.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Nov 2025 10:19:05 +0000
Message-ID: <800328.1764325145@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The allocation of a cell's anonymous key is done in a background thread
along with other cell setup such as doing a DNS upcall.  In the reported
bug, this is triggered by afs_parse_source() parsing the device name given
to mount() and calling afs_lookup_cell() with the name of the cell.

The normal key lookup then tries to use the key description on the
anonymous authentication key as the reference for request_key() - but it
may not yet be set and so an oops can happen.

This has been made more likely to happen by the fix for dynamic lookup
failure.

Fix this by firstly allocating a reference name and attaching it to the
afs_cell record when the record is created.  It can share the memory
allocation with the cell name (unfortunately it can't just overlap the cel=
l
name by prepending it with "afs@" as the cell name already has a '.'
prepended for other purposes).  This reference name is then passed to
request_key().

Secondly, the anon key is now allocated on demand at the point a key is
requested in afs_request_key() if it is not already allocated.  A mutex is
used to prevent multiple allocation for a cell.

Thirdly, make afs_request_key_rcu() return NULL if the anonymous key isn't
yet allocated (if we need it) and then the caller can return -ECHILD to
drop out of RCU-mode and afs_request_key() can be called.

Note that the anonymous key is kind of necessary to make the key lookup
cache work as that doesn't currently cache a negative lookup, but it's
probably worth some investigation to see if NULL can be used instead.

Fixes: 330e2c514823 ("afs: Fix dynamic lookup to fail on cell lookup failu=
re")
Reported-by: syzbot+41c68824eefb67cdf00c@syzkaller.appspotmail.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 Changes
 =3D=3D=3D=3D=3D=3D=3D
 ver #3)
 - Deactivated debugging statement.
 ver #2)
 - Allocated the anon key on demand to avoid race.

 fs/afs/cell.c     |   43 ++++++++-----------------------------------
 fs/afs/internal.h |    1 +
 fs/afs/security.c |   48 ++++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 49 insertions(+), 43 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index d9b6fa1088b7..71c10a05cebe 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -140,7 +140,9 @@ static struct afs_cell *afs_alloc_cell(struct afs_net =
*net,
 		return ERR_PTR(-ENOMEM);
 	}
 =

-	cell->name =3D kmalloc(1 + namelen + 1, GFP_KERNEL);
+	/* Allocate the cell name and the key name in one go. */
+	cell->name =3D kmalloc(1 + namelen + 1 +
+			     4 + namelen + 1, GFP_KERNEL);
 	if (!cell->name) {
 		kfree(cell);
 		return ERR_PTR(-ENOMEM);
@@ -151,7 +153,11 @@ static struct afs_cell *afs_alloc_cell(struct afs_net=
 *net,
 	cell->name_len =3D namelen;
 	for (i =3D 0; i < namelen; i++)
 		cell->name[i] =3D tolower(name[i]);
-	cell->name[i] =3D 0;
+	cell->name[i++] =3D 0;
+
+	cell->key_desc =3D cell->name + i;
+	memcpy(cell->key_desc, "afs@", 4);
+	memcpy(cell->key_desc + 4, cell->name, cell->name_len + 1);
 =

 	cell->net =3D net;
 	refcount_set(&cell->ref, 1);
@@ -710,33 +716,6 @@ void afs_set_cell_timer(struct afs_cell *cell, unsign=
ed int delay_secs)
 	timer_reduce(&cell->management_timer, jiffies + delay_secs * HZ);
 }
 =

-/*
- * Allocate a key to use as a placeholder for anonymous user security.
- */
-static int afs_alloc_anon_key(struct afs_cell *cell)
-{
-	struct key *key;
-	char keyname[4 + AFS_MAXCELLNAME + 1], *cp, *dp;
-
-	/* Create a key to represent an anonymous user. */
-	memcpy(keyname, "afs@", 4);
-	dp =3D keyname + 4;
-	cp =3D cell->name;
-	do {
-		*dp++ =3D tolower(*cp);
-	} while (*cp++);
-
-	key =3D rxrpc_get_null_key(keyname);
-	if (IS_ERR(key))
-		return PTR_ERR(key);
-
-	cell->anonymous_key =3D key;
-
-	_debug("anon key %p{%x}",
-	       cell->anonymous_key, key_serial(cell->anonymous_key));
-	return 0;
-}
-
 /*
  * Activate a cell.
  */
@@ -746,12 +725,6 @@ static int afs_activate_cell(struct afs_net *net, str=
uct afs_cell *cell)
 	struct afs_cell *pcell;
 	int ret;
 =

-	if (!cell->anonymous_key) {
-		ret =3D afs_alloc_anon_key(cell);
-		if (ret < 0)
-			return ret;
-	}
-
 	ret =3D afs_proc_cell_setup(cell);
 	if (ret < 0)
 		return ret;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index b92f96f56767..009064b8d661 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -413,6 +413,7 @@ struct afs_cell {
 =

 	u8			name_len;	/* Length of name */
 	char			*name;		/* Cell name, case-flattened and NUL-padded */
+	char			*key_desc;	/* Authentication key description */
 };
 =

 /*
diff --git a/fs/afs/security.c b/fs/afs/security.c
index 6a7744c9e2a2..ff8830e6982f 100644
--- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@ -16,6 +16,30 @@
 =

 static DEFINE_HASHTABLE(afs_permits_cache, 10);
 static DEFINE_SPINLOCK(afs_permits_lock);
+static DEFINE_MUTEX(afs_key_lock);
+
+/*
+ * Allocate a key to use as a placeholder for anonymous user security.
+ */
+static int afs_alloc_anon_key(struct afs_cell *cell)
+{
+	struct key *key;
+
+	mutex_lock(&afs_key_lock);
+	if (!cell->anonymous_key) {
+		key =3D rxrpc_get_null_key(cell->key_desc);
+		if (!IS_ERR(key))
+			cell->anonymous_key =3D key;
+	}
+	mutex_unlock(&afs_key_lock);
+
+	if (IS_ERR(key))
+		return PTR_ERR(key);
+
+	_debug("anon key %p{%x}",
+	       cell->anonymous_key, key_serial(cell->anonymous_key));
+	return 0;
+}
 =

 /*
  * get a key
@@ -23,11 +47,12 @@ static DEFINE_SPINLOCK(afs_permits_lock);
 struct key *afs_request_key(struct afs_cell *cell)
 {
 	struct key *key;
+	int ret;
 =

-	_enter("{%x}", key_serial(cell->anonymous_key));
+	_enter("{%s}", cell->key_desc);
 =

-	_debug("key %s", cell->anonymous_key->description);
-	key =3D request_key_net(&key_type_rxrpc, cell->anonymous_key->descriptio=
n,
+	_debug("key %s", cell->key_desc);
+	key =3D request_key_net(&key_type_rxrpc, cell->key_desc,
 			      cell->net->net, NULL);
 	if (IS_ERR(key)) {
 		if (PTR_ERR(key) !=3D -ENOKEY) {
@@ -35,6 +60,12 @@ struct key *afs_request_key(struct afs_cell *cell)
 			return key;
 		}
 =

+		if (!cell->anonymous_key) {
+			ret =3D afs_alloc_anon_key(cell);
+			if (ret < 0)
+				return ERR_PTR(ret);
+		}
+
 		/* act as anonymous user */
 		_leave(" =3D {%x} [anon]", key_serial(cell->anonymous_key));
 		return key_get(cell->anonymous_key);
@@ -52,11 +83,10 @@ struct key *afs_request_key_rcu(struct afs_cell *cell)
 {
 	struct key *key;
 =

-	_enter("{%x}", key_serial(cell->anonymous_key));
+	_enter("{%s}", cell->key_desc);
 =

-	_debug("key %s", cell->anonymous_key->description);
-	key =3D request_key_net_rcu(&key_type_rxrpc,
-				  cell->anonymous_key->description,
+	_debug("key %s", cell->key_desc);
+	key =3D request_key_net_rcu(&key_type_rxrpc, cell->key_desc,
 				  cell->net->net);
 	if (IS_ERR(key)) {
 		if (PTR_ERR(key) !=3D -ENOKEY) {
@@ -65,6 +95,8 @@ struct key *afs_request_key_rcu(struct afs_cell *cell)
 		}
 =

 		/* act as anonymous user */
+		if (!cell->anonymous_key)
+			return NULL; /* Need to allocate */
 		_leave(" =3D {%x} [anon]", key_serial(cell->anonymous_key));
 		return key_get(cell->anonymous_key);
 	} else {
@@ -408,7 +440,7 @@ int afs_permission(struct mnt_idmap *idmap, struct ino=
de *inode,
 =

 	if (mask & MAY_NOT_BLOCK) {
 		key =3D afs_request_key_rcu(vnode->volume->cell);
-		if (IS_ERR(key))
+		if (IS_ERR_OR_NULL(key))
 			return -ECHILD;
 =

 		ret =3D -ECHILD;


