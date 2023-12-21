Return-Path: <linux-fsdevel+bounces-6746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE7481B930
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 15:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C683DB287F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 14:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903A258218;
	Thu, 21 Dec 2023 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHA9hnW+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D91F55E7F
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703167058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wzXIqq06sVA7ycfPhNS7D2yXU6a0uOf4G1W1CQ/WYbo=;
	b=RHA9hnW++lmdIhwv1l+n4ZXQgzIIq/MA26klZ6TnbW5ZGy/psxeZQ1TOSxkNcjQAi2l+B5
	BtRZI1RljQ1fckOawEsydAT2RASjh4N1od11yJs8wWT2X/AWIWQngHSR9AuZXPp6bMiCVk
	gkuhpeq+v+CM4e2WScgABnnwr2WM/r4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-Qe1ZmrDjPVW47Kkq7q9Fsw-1; Thu, 21 Dec 2023 08:57:33 -0500
X-MC-Unique: Qe1ZmrDjPVW47Kkq7q9Fsw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1402B101A555;
	Thu, 21 Dec 2023 13:57:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EC54E51E3;
	Thu, 21 Dec 2023 13:57:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
cc: dhowells@redhat.com, Jeffrey Altman <jaltman@auristor.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Fix use-after-free due to get/remove race in volume tree
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1659973.1703167051.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 Dec 2023 13:57:31 +0000
Message-ID: <1659974.1703167051@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Hi Linus,

Could you apply this fix please?

David
---
When an afs_volume struct is put, its refcount is reduced to 0 before the
cell->volume_lock is taken and the volume removed from the cell->volumes
tree.  Unfortunately, this means that the lookup code can race and see a
volume with a zero ref in the tree, resulting in a use-after-free:

        refcount_t: addition on 0; use-after-free.
        WARNING: CPU: 3 PID: 130782 at lib/refcount.c:25 refcount_warn_sat=
urate+0x7a/0xda
        ...
        RIP: 0010:refcount_warn_saturate+0x7a/0xda
        ...
        Call Trace:
         <TASK>
         ? __warn+0x8b/0xf5
         ? report_bug+0xbf/0x11b
         ? refcount_warn_saturate+0x7a/0xda
         ? handle_bug+0x3c/0x5b
         ? exc_invalid_op+0x13/0x59
         ? asm_exc_invalid_op+0x16/0x20
         ? refcount_warn_saturate+0x7a/0xda
         ? refcount_warn_saturate+0x7a/0xda
         afs_get_volume+0x3d/0x55
         afs_create_volume+0x126/0x1de
         afs_validate_fc+0xfe/0x130
         afs_get_tree+0x20/0x2e5
         vfs_get_tree+0x1d/0xc9
         do_new_mount+0x13b/0x22e
         do_mount+0x5d/0x8a
         __do_sys_mount+0x100/0x12a
         do_syscall_64+0x3a/0x94
         entry_SYSCALL_64_after_hwframe+0x62/0x6a

Fix this by:

 (1) When putting, use a flag to indicate if the volume has been removed
     from the tree and skip the rb_erase if it has.

 (2) When looking up, use a conditional ref increment and if it fails
     because the refcount is 0, replace the node in the tree and set the
     removal flag.

Fixes: 20325960f875 ("afs: Reorganise volume and server trees to be rooted=
 on the cell")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/internal.h |    2 ++
 fs/afs/volume.c   |   26 +++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index a812952be1c9..7385d62c8cf5 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -586,6 +586,7 @@ struct afs_volume {
 #define AFS_VOLUME_OFFLINE	4	/* - T if volume offline notice given */
 #define AFS_VOLUME_BUSY		5	/* - T if volume busy notice given */
 #define AFS_VOLUME_MAYBE_NO_IBULK 6	/* - T if some servers don't have Inl=
ineBulkStatus */
+#define AFS_VOLUME_RM_TREE	7	/* - Set if volume removed from cell->volume=
s */
 #ifdef CONFIG_AFS_FSCACHE
 	struct fscache_volume	*cache;		/* Caching cookie */
 #endif
@@ -1513,6 +1514,7 @@ extern struct afs_vlserver_list *afs_extract_vlserve=
r_list(struct afs_cell *,
 extern struct afs_volume *afs_create_volume(struct afs_fs_context *);
 extern int afs_activate_volume(struct afs_volume *);
 extern void afs_deactivate_volume(struct afs_volume *);
+bool afs_try_get_volume(struct afs_volume *volume, enum afs_volume_trace =
reason);
 extern struct afs_volume *afs_get_volume(struct afs_volume *, enum afs_vo=
lume_trace);
 extern void afs_put_volume(struct afs_net *, struct afs_volume *, enum af=
s_volume_trace);
 extern int afs_check_volume_status(struct afs_volume *, struct afs_operat=
ion *);
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 29d483c80281..115c081a8e2c 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -32,8 +32,13 @@ static struct afs_volume *afs_insert_volume_into_cell(s=
truct afs_cell *cell,
 		} else if (p->vid > volume->vid) {
 			pp =3D &(*pp)->rb_right;
 		} else {
-			volume =3D afs_get_volume(p, afs_volume_trace_get_cell_insert);
-			goto found;
+			if (afs_try_get_volume(p, afs_volume_trace_get_cell_insert)) {
+				volume =3D p;
+				goto found;
+			}
+
+			set_bit(AFS_VOLUME_RM_TREE, &volume->flags);
+			rb_replace_node_rcu(&p->cell_node, &volume->cell_node, &cell->volumes)=
;
 		}
 	}
 =

@@ -56,7 +61,8 @@ static void afs_remove_volume_from_cell(struct afs_volum=
e *volume)
 				 afs_volume_trace_remove);
 		write_seqlock(&cell->volume_lock);
 		hlist_del_rcu(&volume->proc_link);
-		rb_erase(&volume->cell_node, &cell->volumes);
+		if (!test_and_set_bit(AFS_VOLUME_RM_TREE, &volume->flags))
+			rb_erase(&volume->cell_node, &cell->volumes);
 		write_sequnlock(&cell->volume_lock);
 	}
 }
@@ -231,6 +237,20 @@ static void afs_destroy_volume(struct afs_net *net, s=
truct afs_volume *volume)
 	_leave(" [destroyed]");
 }
 =

+/*
+ * Try to get a reference on a volume record.
+ */
+bool afs_try_get_volume(struct afs_volume *volume, enum afs_volume_trace =
reason)
+{
+	int r;
+
+	if (__refcount_inc_not_zero(&volume->ref, &r)) {
+		trace_afs_volume(volume->vid, r + 1, reason);
+		return true;
+	}
+	return false;
+}
+
 /*
  * Get a reference on a volume record.
  */


