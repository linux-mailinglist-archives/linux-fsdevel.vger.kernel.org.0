Return-Path: <linux-fsdevel+bounces-5861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C28811366
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0880E1C210D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EE12E63B;
	Wed, 13 Dec 2023 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cFupBEKG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0E310C
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 05:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702475415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T1V5XWZwi8Si/Pu2Wz1ewFIvsN/YxVBeWmgh8/pdp+g=;
	b=cFupBEKGJtHyIoqqQxqQfLzPpYrrbCAsYWZJcK8frD77UXiWFLoWrH2/1aKAmruA6GzP5k
	yxO4N2MarifMji2hXIF/ZDBBPSHHSQqO56dvrVLIVWwxlt8YIQRfHy6K5QurAZxTH4NRI4
	n6a055yQe24iCQO54E2R3PKNf9AwNls=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-mdSN0jaCN_qTHYeXXvf08A-1; Wed, 13 Dec 2023 08:50:12 -0500
X-MC-Unique: mdSN0jaCN_qTHYeXXvf08A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE063185A785;
	Wed, 13 Dec 2023 13:50:11 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BF75B2166B31;
	Wed, 13 Dec 2023 13:50:10 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v2 03/40] afs: use read_seqbegin() in afs_check_validity() and afs_getattr()
Date: Wed, 13 Dec 2023 13:49:25 +0000
Message-ID: <20231213135003.367397-4-dhowells@redhat.com>
In-Reply-To: <20231213135003.367397-1-dhowells@redhat.com>
References: <20231213135003.367397-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

From: Oleg Nesterov <oleg@redhat.com>

David Howells says:

 (3) afs_check_validity().
 (4) afs_getattr().

     These are both pretty short, so your solution is probably good for them.
     That said, afs_vnode_commit_status() can spend a long time under the
     write lock - and pretty much every file RPC op returns a status update.

Change these functions to use read_seqbegin(). This simplifies the code
and doesn't change the current behaviour, the "seq" counter is always even
so read_seqbegin_or_lock() can never take the lock.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/20231130115617.GA21584@redhat.com/
---
 fs/afs/inode.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 78efc9719349..a6ae74d5b698 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -629,10 +629,10 @@ bool afs_check_validity(struct afs_vnode *vnode)
 	enum afs_cb_break_reason need_clear = afs_cb_break_no_break;
 	time64_t now = ktime_get_real_seconds();
 	unsigned int cb_break;
-	int seq = 0;
+	int seq;
 
 	do {
-		read_seqbegin_or_lock(&vnode->cb_lock, &seq);
+		seq = read_seqbegin(&vnode->cb_lock);
 		cb_break = vnode->cb_break;
 
 		if (test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
@@ -650,9 +650,7 @@ bool afs_check_validity(struct afs_vnode *vnode)
 			need_clear = afs_cb_break_no_promise;
 		}
 
-	} while (need_seqretry(&vnode->cb_lock, seq));
-
-	done_seqretry(&vnode->cb_lock, seq);
+	} while (read_seqretry(&vnode->cb_lock, seq));
 
 	if (need_clear == afs_cb_break_no_break)
 		return true;
@@ -755,7 +753,7 @@ int afs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	struct inode *inode = d_inode(path->dentry);
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 	struct key *key;
-	int ret, seq = 0;
+	int ret, seq;
 
 	_enter("{ ino=%lu v=%u }", inode->i_ino, inode->i_generation);
 
@@ -772,7 +770,7 @@ int afs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	}
 
 	do {
-		read_seqbegin_or_lock(&vnode->cb_lock, &seq);
+		seq = read_seqbegin(&vnode->cb_lock);
 		generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
 		if (test_bit(AFS_VNODE_SILLY_DELETED, &vnode->flags) &&
 		    stat->nlink > 0)
@@ -784,9 +782,8 @@ int afs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		 */
 		if (S_ISDIR(inode->i_mode))
 			stat->size = vnode->netfs.remote_i_size;
-	} while (need_seqretry(&vnode->cb_lock, seq));
+	} while (read_seqretry(&vnode->cb_lock, seq));
 
-	done_seqretry(&vnode->cb_lock, seq);
 	return 0;
 }
 


