Return-Path: <linux-fsdevel+bounces-65199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9713BBFDEDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 20:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2636D351FB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DA321255A;
	Wed, 22 Oct 2025 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QNZQVxuT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F962EFD9E
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 18:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761158924; cv=none; b=QhUBy8W8pHXirFt32eIdP78jaVJUtPL0AbDMA007YTdCHL8lGu21jDs15PBIM/1EkSBh7Tm1++KhmWQEZYWG54jQxFUBvBjy8hv1/3FyQD5nVcD8o0NRvAHTfPQ9RSaEFo589j1AQTV9oHA2P0Ul5suLMQGR3LPOsPvOzseP1eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761158924; c=relaxed/simple;
	bh=cdBl1xEIMqlNBfy2uVsSJND+Re2CMtnzG7NUtIXa/AE=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=UfSKc2EgRoXLGNTXq4kyOCYqa9G8xdxC5onu2RgPSnUquweCw/ZxRRdw/mM5MkYEvQUoATh2yOxRB6+xcVl0FlTiM6D9D1Mn84jDmZQD5GIrRIiz/8aTrW34q0eYmz6Ve1HqoNYcBBsnnE7WQcV9orW1/BRDItZ1EVBIkizU6o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QNZQVxuT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761158921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ws+dg6WcLZHn5ajTW6zVPjTnFqJUpdezA5qyWZJs7EM=;
	b=QNZQVxuTCep1VyWm7rT0Snf6u/zoLurXUCKlxSzt+8GkDgxl5XXSUoZkYH5c9jN/ESVKPU
	FXGix8uEDIuCCnww298RQRUO7R/Xj0UfV9OG9Hq5IEvJugUO3xRkAIbfgzkRYCYhe+v2nY
	HHFRwu1qhtbvEKJuS7mx2ETkc8U29eA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-egFPZ-nsOsaXwi3I06gFzA-1; Wed,
 22 Oct 2025 14:48:38 -0400
X-MC-Unique: egFPZ-nsOsaXwi3I06gFzA-1
X-Mimecast-MFC-AGG-ID: egFPZ-nsOsaXwi3I06gFzA_1761158916
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50CA418002E4;
	Wed, 22 Oct 2025 18:48:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.57])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8CAAD1800353;
	Wed, 22 Oct 2025 18:48:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Markus Suvanto <markus.suvanto@gmail.com>
cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Christian Brauner <christian@brauner.io>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Fix dynamic lookup to fail on cell lookup failure
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1784746.1761158912.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Oct 2025 19:48:32 +0100
Message-ID: <1784747.1761158912@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

When a process tries to access an entry in /afs, normally what happens is
that an automount dentry is created by ->lookup() and then triggered, whic=
h
jumps through the ->d_automount() op.  Currently, afs_dynroot_lookup() doe=
s
not do cell DNS lookup, leaving that to afs_d_automount() to perform -
however, it is possible to use access() or stat() on the automount point,
which will always return successfully, have briefly created an afs_cell
record if one did not already exist.

This means that something like:

        test -d "/afs/.west" && echo Directory exists

will print "Directory exists" even though no such cell is configured.  Thi=
s
breaks the "west" python module available on PIP as it expects this access
to fail.

Now, it could be possible to make afs_dynroot_lookup() perform the DNS[*]
lookup, but that would make "ls --color /afs" do this for each cell in /af=
s
that is listed but not yet probed.  kafs-client, probably wrongly, preload=
s
the entire cell database and all the known cells are then listed in /afs -
and doing ls /afs would be very, very slow, especially if any cell supplie=
d
addresses but was wholly inaccessible.

 [*] When I say "DNS", actually read getaddrinfo(), which could use any on=
e
     of a host of mechanisms.  Could also use static configuration.

To fix this, make the following changes:

 (1) Create an enum to specify the origination point of a call to
     afs_lookup_cell() and pass this value into that function in place of
     the "excl" parameter (which can be derived from it).  There are six
     points of origination:

        - Cell preload through /proc/net/afs/cells
        - Root cell config through /proc/net/afs/rootcell
        - Lookup in dynamic root
        - Automount trigger
        - Direct mount with mount() syscall
        - Alias check where YFS tells us the cell name is different

 (2) Add an extra state into the afs_cell state machine to indicate a cell
     that's been initialised, but not yet looked up.  This is separate fro=
m
     one that can be considered active and has been looked up at least
     once.

 (3) Make afs_lookup_cell() vary its behaviour more, depending on where it
     was called from:

     If called from preload or root cell config, DNS lookup will not happe=
n
     until we definitely want to use the cell (dynroot mount, automount,
     direct mount or alias check).  The cell will appear in /afs but stat(=
)
     won't trigger DNS lookup.

     If the cell already exists, dynroot will not wait for the DNS lookup
     to complete.  If the cell did not already exist, dynroot will wait.

     If called from automount, direct mount or alias check, it will wait
     for the DNS lookup to complete.

 (4) Make afs_lookup_cell() return an error if lookup failed in one way or
     another.  We try to return -ENOENT if the DNS says the cell does not
     exist and -EDESTADDRREQ if we couldn't access the DNS.

Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220685
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/cell.c     |   78 +++++++++++++++++++++++++++++++++++++++++++++---=
------
 fs/afs/dynroot.c  |    3 +-
 fs/afs/internal.h |   12 +++++++-
 fs/afs/mntpt.c    |    3 +-
 fs/afs/proc.c     |    3 +-
 fs/afs/super.c    |    2 -
 fs/afs/vl_alias.c |    3 +-
 7 files changed, 86 insertions(+), 18 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index f31359922e98..d9b6fa1088b7 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -229,7 +229,7 @@ static struct afs_cell *afs_alloc_cell(struct afs_net =
*net,
  * @name:	The name of the cell.
  * @namesz:	The strlen of the cell name.
  * @vllist:	A colon/comma separated list of numeric IP addresses or NULL.
- * @excl:	T if an error should be given if the cell name already exists.
+ * @reason:	The reason we're doing the lookup
  * @trace:	The reason to be logged if the lookup is successful.
  *
  * Look up a cell record by name and query the DNS for VL server addresse=
s if
@@ -239,7 +239,8 @@ static struct afs_cell *afs_alloc_cell(struct afs_net =
*net,
  */
 struct afs_cell *afs_lookup_cell(struct afs_net *net,
 				 const char *name, unsigned int namesz,
-				 const char *vllist, bool excl,
+				 const char *vllist,
+				 enum afs_lookup_cell_for reason,
 				 enum afs_cell_trace trace)
 {
 	struct afs_cell *cell, *candidate, *cursor;
@@ -247,12 +248,18 @@ struct afs_cell *afs_lookup_cell(struct afs_net *net=
,
 	enum afs_cell_state state;
 	int ret, n;
 =

-	_enter("%s,%s", name, vllist);
+	_enter("%s,%s,%u", name, vllist, reason);
 =

-	if (!excl) {
+	if (reason !=3D AFS_LOOKUP_CELL_PRELOAD) {
 		cell =3D afs_find_cell(net, name, namesz, trace);
-		if (!IS_ERR(cell))
+		if (!IS_ERR(cell)) {
+			if (reason =3D=3D AFS_LOOKUP_CELL_DYNROOT)
+				goto no_wait;
+			if (cell->state =3D=3D AFS_CELL_SETTING_UP ||
+			    cell->state =3D=3D AFS_CELL_UNLOOKED)
+				goto lookup_cell;
 			goto wait_for_cell;
+		}
 	}
 =

 	/* Assume we're probably going to create a cell and preallocate and
@@ -298,26 +305,69 @@ struct afs_cell *afs_lookup_cell(struct afs_net *net=
,
 	rb_insert_color(&cell->net_node, &net->cells);
 	up_write(&net->cells_lock);
 =

-	afs_queue_cell(cell, afs_cell_trace_queue_new);
+lookup_cell:
+	if (reason !=3D AFS_LOOKUP_CELL_PRELOAD &&
+	    reason !=3D AFS_LOOKUP_CELL_ROOTCELL) {
+		set_bit(AFS_CELL_FL_DO_LOOKUP, &cell->flags);
+		afs_queue_cell(cell, afs_cell_trace_queue_new);
+	}
 =

 wait_for_cell:
-	_debug("wait_for_cell");
 	state =3D smp_load_acquire(&cell->state); /* vs error */
-	if (state !=3D AFS_CELL_ACTIVE &&
-	    state !=3D AFS_CELL_DEAD) {
+	switch (state) {
+	case AFS_CELL_ACTIVE:
+	case AFS_CELL_DEAD:
+		break;
+	case AFS_CELL_UNLOOKED:
+	default:
+		if (reason =3D=3D AFS_LOOKUP_CELL_PRELOAD ||
+		    reason =3D=3D AFS_LOOKUP_CELL_ROOTCELL)
+			break;
+		_debug("wait_for_cell");
 		afs_see_cell(cell, afs_cell_trace_wait);
 		wait_var_event(&cell->state,
 			       ({
 				       state =3D smp_load_acquire(&cell->state); /* vs error */
 				       state =3D=3D AFS_CELL_ACTIVE || state =3D=3D AFS_CELL_DEAD;
 			       }));
+		_debug("waited_for_cell %d %d", cell->state, cell->error);
 	}
 =

+no_wait:
 	/* Check the state obtained from the wait check. */
+	state =3D smp_load_acquire(&cell->state); /* vs error */
 	if (state =3D=3D AFS_CELL_DEAD) {
 		ret =3D cell->error;
 		goto error;
 	}
+	if (state =3D=3D AFS_CELL_ACTIVE) {
+		switch (cell->dns_status) {
+		case DNS_LOOKUP_NOT_DONE:
+			if (cell->dns_source =3D=3D DNS_RECORD_FROM_CONFIG) {
+				ret =3D 0;
+				break;
+			}
+			fallthrough;
+		default:
+			ret =3D -EIO;
+			goto error;
+		case DNS_LOOKUP_GOOD:
+		case DNS_LOOKUP_GOOD_WITH_BAD:
+			ret =3D 0;
+			break;
+		case DNS_LOOKUP_GOT_NOT_FOUND:
+			ret =3D -ENOENT;
+			goto error;
+		case DNS_LOOKUP_BAD:
+			ret =3D -EREMOTEIO;
+			goto error;
+		case DNS_LOOKUP_GOT_LOCAL_FAILURE:
+		case DNS_LOOKUP_GOT_TEMP_FAILURE:
+		case DNS_LOOKUP_GOT_NS_FAILURE:
+			ret =3D -EDESTADDRREQ;
+			goto error;
+		}
+	}
 =

 	_leave(" =3D %p [cell]", cell);
 	return cell;
@@ -325,7 +375,7 @@ struct afs_cell *afs_lookup_cell(struct afs_net *net,
 cell_already_exists:
 	_debug("cell exists");
 	cell =3D cursor;
-	if (excl) {
+	if (reason =3D=3D AFS_LOOKUP_CELL_PRELOAD) {
 		ret =3D -EEXIST;
 	} else {
 		afs_use_cell(cursor, trace);
@@ -384,7 +434,8 @@ int afs_cell_init(struct afs_net *net, const char *roo=
tcell)
 		return -EINVAL;
 =

 	/* allocate a cell record for the root/workstation cell */
-	new_root =3D afs_lookup_cell(net, rootcell, len, vllist, false,
+	new_root =3D afs_lookup_cell(net, rootcell, len, vllist,
+				   AFS_LOOKUP_CELL_ROOTCELL,
 				   afs_cell_trace_use_lookup_ws);
 	if (IS_ERR(new_root)) {
 		_leave(" =3D %ld", PTR_ERR(new_root));
@@ -777,6 +828,7 @@ static bool afs_manage_cell(struct afs_cell *cell)
 	switch (cell->state) {
 	case AFS_CELL_SETTING_UP:
 		goto set_up_cell;
+	case AFS_CELL_UNLOOKED:
 	case AFS_CELL_ACTIVE:
 		goto cell_is_active;
 	case AFS_CELL_REMOVING:
@@ -797,7 +849,7 @@ static bool afs_manage_cell(struct afs_cell *cell)
 		goto remove_cell;
 	}
 =

-	afs_set_cell_state(cell, AFS_CELL_ACTIVE);
+	afs_set_cell_state(cell, AFS_CELL_UNLOOKED);
 =

 cell_is_active:
 	if (afs_has_cell_expired(cell, &next_manage))
@@ -807,6 +859,8 @@ static bool afs_manage_cell(struct afs_cell *cell)
 		ret =3D afs_update_cell(cell);
 		if (ret < 0)
 			cell->error =3D ret;
+		if (cell->state =3D=3D AFS_CELL_UNLOOKED)
+			afs_set_cell_state(cell, AFS_CELL_ACTIVE);
 	}
 =

 	if (next_manage < TIME64_MAX && cell->net->live) {
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 8c6130789fde..dc9d29e3739e 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -108,7 +108,8 @@ static struct dentry *afs_dynroot_lookup_cell(struct i=
node *dir, struct dentry *
 		dotted =3D true;
 	}
 =

-	cell =3D afs_lookup_cell(net, name, len, NULL, false,
+	cell =3D afs_lookup_cell(net, name, len, NULL,
+			       AFS_LOOKUP_CELL_DYNROOT,
 			       afs_cell_trace_use_lookup_dynroot);
 	if (IS_ERR(cell)) {
 		ret =3D PTR_ERR(cell);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index bcbf828ba31f..a90b8ac56844 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -344,6 +344,7 @@ extern const char afs_init_sysname[];
 =

 enum afs_cell_state {
 	AFS_CELL_SETTING_UP,
+	AFS_CELL_UNLOOKED,
 	AFS_CELL_ACTIVE,
 	AFS_CELL_REMOVING,
 	AFS_CELL_DEAD,
@@ -1050,9 +1051,18 @@ static inline bool afs_cb_is_broken(unsigned int cb=
_break,
 extern int afs_cell_init(struct afs_net *, const char *);
 extern struct afs_cell *afs_find_cell(struct afs_net *, const char *, uns=
igned,
 				      enum afs_cell_trace);
+enum afs_lookup_cell_for {
+	AFS_LOOKUP_CELL_DYNROOT,
+	AFS_LOOKUP_CELL_MOUNTPOINT,
+	AFS_LOOKUP_CELL_DIRECT_MOUNT,
+	AFS_LOOKUP_CELL_PRELOAD,
+	AFS_LOOKUP_CELL_ROOTCELL,
+	AFS_LOOKUP_CELL_ALIAS_CHECK,
+};
 struct afs_cell *afs_lookup_cell(struct afs_net *net,
 				 const char *name, unsigned int namesz,
-				 const char *vllist, bool excl,
+				 const char *vllist,
+				 enum afs_lookup_cell_for reason,
 				 enum afs_cell_trace trace);
 extern struct afs_cell *afs_use_cell(struct afs_cell *, enum afs_cell_tra=
ce);
 void afs_unuse_cell(struct afs_cell *cell, enum afs_cell_trace reason);
diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index 1ad048e6e164..57c204a3c04e 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -107,7 +107,8 @@ static int afs_mntpt_set_params(struct fs_context *fc,=
 struct dentry *mntpt)
 		if (size > AFS_MAXCELLNAME)
 			return -ENAMETOOLONG;
 =

-		cell =3D afs_lookup_cell(ctx->net, p, size, NULL, false,
+		cell =3D afs_lookup_cell(ctx->net, p, size, NULL,
+				       AFS_LOOKUP_CELL_MOUNTPOINT,
 				       afs_cell_trace_use_lookup_mntpt);
 		if (IS_ERR(cell)) {
 			pr_err("kAFS: unable to lookup cell '%pd'\n", mntpt);
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 40e879c8ca77..44520549b509 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -122,7 +122,8 @@ static int afs_proc_cells_write(struct file *file, cha=
r *buf, size_t size)
 	if (strcmp(buf, "add") =3D=3D 0) {
 		struct afs_cell *cell;
 =

-		cell =3D afs_lookup_cell(net, name, strlen(name), args, true,
+		cell =3D afs_lookup_cell(net, name, strlen(name), args,
+				       AFS_LOOKUP_CELL_PRELOAD,
 				       afs_cell_trace_use_lookup_add);
 		if (IS_ERR(cell)) {
 			ret =3D PTR_ERR(cell);
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 9b1d8ac39261..354090b3a7e7 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -305,7 +305,7 @@ static int afs_parse_source(struct fs_context *fc, str=
uct fs_parameter *param)
 	/* lookup the cell record */
 	if (cellname) {
 		cell =3D afs_lookup_cell(ctx->net, cellname, cellnamesz,
-				       NULL, false,
+				       NULL, AFS_LOOKUP_CELL_DIRECT_MOUNT,
 				       afs_cell_trace_use_lookup_mount);
 		if (IS_ERR(cell)) {
 			pr_err("kAFS: unable to lookup cell '%*.*s'\n",
diff --git a/fs/afs/vl_alias.c b/fs/afs/vl_alias.c
index 709b4cdb723e..fc9676abd252 100644
--- a/fs/afs/vl_alias.c
+++ b/fs/afs/vl_alias.c
@@ -269,7 +269,8 @@ static int yfs_check_canonical_cell_name(struct afs_ce=
ll *cell, struct key *key)
 	if (!name_len || name_len > AFS_MAXCELLNAME)
 		master =3D ERR_PTR(-EOPNOTSUPP);
 	else
-		master =3D afs_lookup_cell(cell->net, cell_name, name_len, NULL, false,
+		master =3D afs_lookup_cell(cell->net, cell_name, name_len, NULL,
+					 AFS_LOOKUP_CELL_ALIAS_CHECK,
 					 afs_cell_trace_use_lookup_canonical);
 	kfree(cell_name);
 	if (IS_ERR(master))


