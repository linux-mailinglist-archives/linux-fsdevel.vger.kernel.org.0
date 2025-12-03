Return-Path: <linux-fsdevel+bounces-70576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E34FCA0197
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 17:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD77D3069E1D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 16:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC7032ED52;
	Wed,  3 Dec 2025 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2j48DCak"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D80F32ED3D;
	Wed,  3 Dec 2025 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777079; cv=none; b=oJ1LJBv1rX6qL8DlMHLKc1BzXHLAEfcxE0aEabJegMMChym2FN+/y56ioHnjx9/+z1l5UDwlmM1QMM6MJ9JiHH6HycuiyyMMMk/9cz0Xggg+X75rXddez7RW/Gx2N2yEpVrXjfxCdZ7HG6l6kyCeRaaLZgJbJsHug400Q9Z8kcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777079; c=relaxed/simple;
	bh=Yl5XeYdV3eN7Y2DQLTchrMk4rI1ml5pt28GEPcHEoY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mg6o8A43K2yAOH0V2t+pVxv5j/5XbJOgDr8QuFAkQsQOZf7oHebcx9ue2HFDVasOrZ2KzsLCd58AXdT9vOg37N+AEnqrQhxYr3jD5caeMV8KdzKZyRbKxO2VMh2OVU7MiFIHEM6f1/8Tc+hWL1jQT3oeQSrpBA5JpJDGqcdMoXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2j48DCak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C7BC4CEF5;
	Wed,  3 Dec 2025 15:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764777079;
	bh=Yl5XeYdV3eN7Y2DQLTchrMk4rI1ml5pt28GEPcHEoY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2j48DCak8AcJRi8P9T5yvCARXwr1t8N14zu2Qc4ex8ApRE6ZNl6lXugYm0Hpyj1jF
	 M/EjYdgux7Jjha+NPCGxHZkLc6jB9B7KnULbgrLSKGE+qlPCldeeuXrLaZGKfQ2tcI
	 35LZfnU4FDbfknIrMxT2PIwiGqAtlDv4B4lEKvSA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+41c68824eefb67cdf00c@syzkaller.appspotmail.com,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 042/146] afs: Fix delayed allocation of a cells anonymous key
Date: Wed,  3 Dec 2025 16:27:00 +0100
Message-ID: <20251203152348.014826110@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152346.456176474@linuxfoundation.org>
References: <20251203152346.456176474@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit d27c71257825dced46104eefe42e4d9964bd032e ]

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
allocation with the cell name (unfortunately it can't just overlap the cell
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

Fixes: 330e2c514823 ("afs: Fix dynamic lookup to fail on cell lookup failure")
Reported-by: syzbot+41c68824eefb67cdf00c@syzkaller.appspotmail.com
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://patch.msgid.link/800328.1764325145@warthog.procyon.org.uk
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/cell.c     | 43 ++++++++----------------------------------
 fs/afs/internal.h |  1 +
 fs/afs/security.c | 48 +++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 49 insertions(+), 43 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index d9b6fa1088b7b..71c10a05cebe5 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -140,7 +140,9 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	cell->name = kmalloc(1 + namelen + 1, GFP_KERNEL);
+	/* Allocate the cell name and the key name in one go. */
+	cell->name = kmalloc(1 + namelen + 1 +
+			     4 + namelen + 1, GFP_KERNEL);
 	if (!cell->name) {
 		kfree(cell);
 		return ERR_PTR(-ENOMEM);
@@ -151,7 +153,11 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 	cell->name_len = namelen;
 	for (i = 0; i < namelen; i++)
 		cell->name[i] = tolower(name[i]);
-	cell->name[i] = 0;
+	cell->name[i++] = 0;
+
+	cell->key_desc = cell->name + i;
+	memcpy(cell->key_desc, "afs@", 4);
+	memcpy(cell->key_desc + 4, cell->name, cell->name_len + 1);
 
 	cell->net = net;
 	refcount_set(&cell->ref, 1);
@@ -710,33 +716,6 @@ void afs_set_cell_timer(struct afs_cell *cell, unsigned int delay_secs)
 	timer_reduce(&cell->management_timer, jiffies + delay_secs * HZ);
 }
 
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
-	dp = keyname + 4;
-	cp = cell->name;
-	do {
-		*dp++ = tolower(*cp);
-	} while (*cp++);
-
-	key = rxrpc_get_null_key(keyname);
-	if (IS_ERR(key))
-		return PTR_ERR(key);
-
-	cell->anonymous_key = key;
-
-	_debug("anon key %p{%x}",
-	       cell->anonymous_key, key_serial(cell->anonymous_key));
-	return 0;
-}
-
 /*
  * Activate a cell.
  */
@@ -746,12 +725,6 @@ static int afs_activate_cell(struct afs_net *net, struct afs_cell *cell)
 	struct afs_cell *pcell;
 	int ret;
 
-	if (!cell->anonymous_key) {
-		ret = afs_alloc_anon_key(cell);
-		if (ret < 0)
-			return ret;
-	}
-
 	ret = afs_proc_cell_setup(cell);
 	if (ret < 0)
 		return ret;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 87828d685293f..470e6eef8bd49 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -413,6 +413,7 @@ struct afs_cell {
 
 	u8			name_len;	/* Length of name */
 	char			*name;		/* Cell name, case-flattened and NUL-padded */
+	char			*key_desc;	/* Authentication key description */
 };
 
 /*
diff --git a/fs/afs/security.c b/fs/afs/security.c
index 6a7744c9e2a2d..ff8830e6982fb 100644
--- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@ -16,6 +16,30 @@
 
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
+		key = rxrpc_get_null_key(cell->key_desc);
+		if (!IS_ERR(key))
+			cell->anonymous_key = key;
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
 
 /*
  * get a key
@@ -23,11 +47,12 @@ static DEFINE_SPINLOCK(afs_permits_lock);
 struct key *afs_request_key(struct afs_cell *cell)
 {
 	struct key *key;
+	int ret;
 
-	_enter("{%x}", key_serial(cell->anonymous_key));
+	_enter("{%s}", cell->key_desc);
 
-	_debug("key %s", cell->anonymous_key->description);
-	key = request_key_net(&key_type_rxrpc, cell->anonymous_key->description,
+	_debug("key %s", cell->key_desc);
+	key = request_key_net(&key_type_rxrpc, cell->key_desc,
 			      cell->net->net, NULL);
 	if (IS_ERR(key)) {
 		if (PTR_ERR(key) != -ENOKEY) {
@@ -35,6 +60,12 @@ struct key *afs_request_key(struct afs_cell *cell)
 			return key;
 		}
 
+		if (!cell->anonymous_key) {
+			ret = afs_alloc_anon_key(cell);
+			if (ret < 0)
+				return ERR_PTR(ret);
+		}
+
 		/* act as anonymous user */
 		_leave(" = {%x} [anon]", key_serial(cell->anonymous_key));
 		return key_get(cell->anonymous_key);
@@ -52,11 +83,10 @@ struct key *afs_request_key_rcu(struct afs_cell *cell)
 {
 	struct key *key;
 
-	_enter("{%x}", key_serial(cell->anonymous_key));
+	_enter("{%s}", cell->key_desc);
 
-	_debug("key %s", cell->anonymous_key->description);
-	key = request_key_net_rcu(&key_type_rxrpc,
-				  cell->anonymous_key->description,
+	_debug("key %s", cell->key_desc);
+	key = request_key_net_rcu(&key_type_rxrpc, cell->key_desc,
 				  cell->net->net);
 	if (IS_ERR(key)) {
 		if (PTR_ERR(key) != -ENOKEY) {
@@ -65,6 +95,8 @@ struct key *afs_request_key_rcu(struct afs_cell *cell)
 		}
 
 		/* act as anonymous user */
+		if (!cell->anonymous_key)
+			return NULL; /* Need to allocate */
 		_leave(" = {%x} [anon]", key_serial(cell->anonymous_key));
 		return key_get(cell->anonymous_key);
 	} else {
@@ -408,7 +440,7 @@ int afs_permission(struct mnt_idmap *idmap, struct inode *inode,
 
 	if (mask & MAY_NOT_BLOCK) {
 		key = afs_request_key_rcu(vnode->volume->cell);
-		if (IS_ERR(key))
+		if (IS_ERR_OR_NULL(key))
 			return -ECHILD;
 
 		ret = -ECHILD;
-- 
2.51.0




