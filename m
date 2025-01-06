Return-Path: <linux-fsdevel+bounces-38451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D83C3A02DAC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 17:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4540E1888A36
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 16:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD9F165F1F;
	Mon,  6 Jan 2025 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7TEvbcN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E82146D40
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736180473; cv=none; b=t4vCYRe/NhaJtbl2wnzuTlkgvqUb9Yj5dEQTsR0lNm6mHWTSy3ZXbpnEcekxJOEu4g/vHWT7ZhshBcsNb/Z2j0NtNfZhuBcENFjzFT7Ibbaag//wOCzBBbqpe1NkynsoWjGjEuAsT1j8k1+FEcOe/TijaAqRrOs7u1UO/z92jr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736180473; c=relaxed/simple;
	bh=27xZFrTjPhujZkL5cSY6iX5OT3UACobCEFOhceKCEpg=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=KXHiiXbJv49mA1/JXUDfqiWTwZ+vM6ecIUcl+EQOrzyBmWWs0buo37rqWM0+6TVIuhvPmXT3o3/IdUrFAa9Aa1IYTirIjiXiyOc/ggYXJA0Y3Vv2hH95evx11t/Su7aqQhRrR772mjhaK+j8UcO117M7zX3Wx6fOY+XMDqpgr+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X7TEvbcN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736180468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/MIweyE8QzeGVfBbPE75lvw7yX09jVlfJuNkuLyuodY=;
	b=X7TEvbcNedc0Nvf/wCq/oTaniQK29gFPKSemI0UTEEfbSFKCdKH6ixiUNg6AETzIMzNGI1
	m9hK9Rn0S9I+QqMEJL3WAHYiZqPCe9DAZ2YW6iQZiMqKG7VNXJyFt1xAmQrC4xX43hHypO
	+yVV6NxN7LiMWB0MajApJ05nkeAK67c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-oOJ9EKG5P7WrMjEyTqjyZQ-1; Mon,
 06 Jan 2025 11:21:05 -0500
X-MC-Unique: oOJ9EKG5P7WrMjEyTqjyZQ-1
X-Mimecast-MFC-AGG-ID: oOJ9EKG5P7WrMjEyTqjyZQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A4AE19560A1;
	Mon,  6 Jan 2025 16:21:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.12])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 522B61956088;
	Mon,  6 Jan 2025 16:21:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com,
    syzbot <syzbot+7848fee1f1e5c53f912b@syzkaller.appspotmail.com>,
    marc.dionne@auristor.com, linux-afs@lists.infradead.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    syzkaller-bugs@googlegroups.com
Subject: [PATCH] afs: Fix the maximum cell name length 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <376235.1736180460.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jan 2025 16:21:00 +0000
Message-ID: <376236.1736180460@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The kafs filesystem limits the maximum length of a cell to 256 bytes, but =
a
problem occurs if someone actually does that: kafs tries to create a
directory under /proc/net/afs/ with the name of the cell, but that fails
with a warning:

        WARNING: CPU: 0 PID: 9 at fs/proc/generic.c:405

because procfs limits the maximum filename length to 255.

However, the DNS limits the maximum lookup length and, by extension, the
maximum cell name, to 255 less two (length count and trailing NUL).

Fix this by limiting the maximum acceptable cellname length to 253.  This
also allows us to be sure we can create the "/afs/.<cell>/" mountpoint too=
.

Further, split the YFS VL record cell name maximum to be the 256 allowed b=
y
the protocol and ignore the record retrieved by YFSVL.GetCellName if it
exceeds 253.

Fixes: c3e9f888263b ("afs: Implement client support for the YFSVL.GetCellN=
ame RPC op")
Reported-by: syzbot+7848fee1f1e5c53f912b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/6776d25d.050a0220.3a8527.0048.GAE@google=
.com/
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: syzbot+7848fee1f1e5c53f912b@syzkaller.appspotmail.com
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/afs.h      |    2 +-
 fs/afs/afs_vl.h   |    1 +
 fs/afs/vl_alias.c |    8 ++++++--
 fs/afs/vlclient.c |    2 +-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/afs/afs.h b/fs/afs/afs.h
index b488072aee87..ec3db00bd081 100644
--- a/fs/afs/afs.h
+++ b/fs/afs/afs.h
@@ -10,7 +10,7 @@
 =

 #include <linux/in.h>
 =

-#define AFS_MAXCELLNAME		256  	/* Maximum length of a cell name */
+#define AFS_MAXCELLNAME		253  	/* Maximum length of a cell name (DNS limi=
ted) */
 #define AFS_MAXVOLNAME		64  	/* Maximum length of a volume name */
 #define AFS_MAXNSERVERS		8   	/* Maximum servers in a basic volume record=
 */
 #define AFS_NMAXNSERVERS	13  	/* Maximum servers in a N/U-class volume re=
cord */
diff --git a/fs/afs/afs_vl.h b/fs/afs/afs_vl.h
index a06296c8827d..b835e25a2c02 100644
--- a/fs/afs/afs_vl.h
+++ b/fs/afs/afs_vl.h
@@ -13,6 +13,7 @@
 #define AFS_VL_PORT		7003	/* volume location service port */
 #define VL_SERVICE		52	/* RxRPC service ID for the Volume Location servic=
e */
 #define YFS_VL_SERVICE		2503	/* Service ID for AuriStor upgraded VL servi=
ce */
+#define YFS_VL_MAXCELLNAME	256  	/* Maximum length of a cell name in YFS =
protocol */
 =

 enum AFSVL_Operations {
 	VLGETENTRYBYID		=3D 503,	/* AFS Get VLDB entry by ID */
diff --git a/fs/afs/vl_alias.c b/fs/afs/vl_alias.c
index 9f36e14f1c2d..f9e76b604f31 100644
--- a/fs/afs/vl_alias.c
+++ b/fs/afs/vl_alias.c
@@ -253,6 +253,7 @@ static char *afs_vl_get_cell_name(struct afs_cell *cel=
l, struct key *key)
 static int yfs_check_canonical_cell_name(struct afs_cell *cell, struct ke=
y *key)
 {
 	struct afs_cell *master;
+	size_t name_len;
 	char *cell_name;
 =

 	cell_name =3D afs_vl_get_cell_name(cell, key);
@@ -264,8 +265,11 @@ static int yfs_check_canonical_cell_name(struct afs_c=
ell *cell, struct key *key)
 		return 0;
 	}
 =

-	master =3D afs_lookup_cell(cell->net, cell_name, strlen(cell_name),
-				 NULL, false);
+	name_len =3D strlen(cell_name);
+	if (!name_len || name_len > AFS_MAXCELLNAME)
+		master =3D ERR_PTR(-EOPNOTSUPP);
+	else
+		master =3D afs_lookup_cell(cell->net, cell_name, name_len, NULL, false)=
;
 	kfree(cell_name);
 	if (IS_ERR(master))
 		return PTR_ERR(master);
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index cac75f89b64a..55dd0fc5aad7 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -697,7 +697,7 @@ static int afs_deliver_yfsvl_get_cell_name(struct afs_=
call *call)
 			return ret;
 =

 		namesz =3D ntohl(call->tmp);
-		if (namesz > AFS_MAXCELLNAME)
+		if (namesz > YFS_VL_MAXCELLNAME)
 			return afs_protocol_error(call, afs_eproto_cellname_len);
 		paddedsz =3D (namesz + 3) & ~3;
 		call->count =3D namesz;


