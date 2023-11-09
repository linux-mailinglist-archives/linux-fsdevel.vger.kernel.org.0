Return-Path: <linux-fsdevel+bounces-2548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86EF7E6D95
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFD93B2120F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8410208BC;
	Thu,  9 Nov 2023 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iApU+8g2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9F020332
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 15:40:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07983358C
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 07:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699544434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EsdaavxzQFrCmF0h4nEsVxw66N+/bYbfxItJ2VZRPVw=;
	b=iApU+8g2mZ5+94iYorfZhytrmBljaGC3waegzgX7VsF0ZbdmsH2OjqOCw1iPH45XbTGzFS
	jUl6wFBYwqL1xWKtyqN+BGUL5E09FMuKLXcsl6WebmLahanYb0w6CL3Q64snTVZxuHD3nf
	N+RsDt26pr78UUZIQxNiKwOTvjAc0f0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-SI2N2WcWOviWEg6U-p1gFw-1; Thu,
 09 Nov 2023 10:40:27 -0500
X-MC-Unique: SI2N2WcWOviWEg6U-p1gFw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C53342810D52;
	Thu,  9 Nov 2023 15:40:22 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E15CF1C060AE;
	Thu,  9 Nov 2023 15:40:21 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeffrey E Altman <jaltman@auristor.com>
Subject: [PATCH 08/41] afs: Add comments on abort handling
Date: Thu,  9 Nov 2023 15:39:31 +0000
Message-ID: <20231109154004.3317227-9-dhowells@redhat.com>
In-Reply-To: <20231109154004.3317227-1-dhowells@redhat.com>
References: <20231109154004.3317227-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Add some comments on AFS abort code handling in the rotation algorithm and
adjust the errors produced to match.

Reported-by: Jeffrey E Altman <jaltman@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/rotate.c | 100 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 89 insertions(+), 11 deletions(-)

diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index a840c3588ebb..180bcad081dd 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -13,6 +13,7 @@
 #include <linux/sched/signal.h>
 #include "internal.h"
 #include "afs_fs.h"
+#include "protocol_uae.h"
 
 /*
  * Begin iteration through a server list, starting with the vnode's last used
@@ -143,6 +144,11 @@ bool afs_select_fileserver(struct afs_operation *op)
 	case -ECONNABORTED:
 		/* The far side rejected the operation on some grounds.  This
 		 * might involve the server being busy or the volume having been moved.
+		 *
+		 * Note that various V* errors should not be sent to a cache manager
+		 * by a fileserver as they should be translated to more modern UAE*
+		 * errors instead.  IBM AFS and OpenAFS fileservers, however, do leak
+		 * these abort codes.
 		 */
 		switch (op->ac.abort_code) {
 		case VNOVOL:
@@ -150,6 +156,11 @@ bool afs_select_fileserver(struct afs_operation *op)
 			 * - May indicate that the VL is wrong - retry once and compare
 			 *   the results.
 			 * - May indicate that the fileserver couldn't attach to the vol.
+			 * - The volume might have been temporarily removed so that it can
+			 *   be replaced by a volume restore.  "vos" might have ended one
+			 *   transaction and has yet to create the next.
+			 * - The volume might not be blessed or might not be in-service
+			 *   (administrative action).
 			 */
 			if (op->flags & AFS_OPERATION_VNOVOL) {
 				op->error = -EREMOTEIO;
@@ -183,16 +194,56 @@ bool afs_select_fileserver(struct afs_operation *op)
 			_leave(" = t [vnovol]");
 			return true;
 
-		case VSALVAGE: /* TODO: Should this return an error or iterate? */
 		case VVOLEXISTS:
-		case VNOSERVICE:
 		case VONLINE:
-		case VDISKFULL:
-		case VOVERQUOTA:
-			op->error = afs_abort_to_error(op->ac.abort_code);
+			/* These should not be returned from the fileserver. */
+			pr_warn("Fileserver returned unexpected abort %d\n",
+				op->ac.abort_code);
+			op->error = -EREMOTEIO;
+			goto next_server;
+
+		case VNOSERVICE:
+			/* Prior to AFS 3.2 VNOSERVICE was returned from the fileserver
+			 * if the volume was neither in-service nor administratively
+			 * blessed.  All usage was replaced by VNOVOL because AFS 3.1 and
+			 * earlier cache managers did not handle VNOSERVICE and assumed
+			 * it was the client OSes errno 105.
+			 *
+			 * Starting with OpenAFS 1.4.8 VNOSERVICE was repurposed as the
+			 * fileserver idle dead time error which was sent in place of
+			 * RX_CALL_TIMEOUT (-3).  The error was intended to be sent if the
+			 * fileserver took too long to send a reply to the client.
+			 * RX_CALL_TIMEOUT would have caused the cache manager to mark the
+			 * server down whereas VNOSERVICE since AFS 3.2 would cause cache
+			 * manager to temporarily (up to 15 minutes) mark the volume
+			 * instance as unusable.
+			 *
+			 * The idle dead logic resulted in cache inconsistency since a
+			 * state changing call that the cache manager assumed was dead
+			 * could still be processed to completion by the fileserver.  This
+			 * logic was removed in OpenAFS 1.8.0 and VNOSERVICE is no longer
+			 * returned.  However, many 1.4.8 through 1.6.24 fileservers are
+			 * still in existence.
+			 *
+			 * AuriStorFS fileservers have never returned VNOSERVICE.
+			 *
+			 * VNOSERVICE should be treated as an alias for RX_CALL_TIMEOUT..
+			 */
+		case RX_CALL_TIMEOUT:
+			op->error = -ETIMEDOUT;
 			goto next_server;
 
+		case VSALVAGING: /* This error should not be leaked to cache managers
+				  * but is from OpenAFS demand attach fileservers.
+				  * It should be treated as an alias for VOFFLINE.
+				  */
+		case VSALVAGE: /* VSALVAGE should be treated as a synonym of VOFFLINE */
 		case VOFFLINE:
+			/* The volume is in use by the volserver or another volume utility
+			 * for an operation that might alter the contents.  The volume is
+			 * expected to come back but it might take a long time (could be
+			 * days).
+			 */
 			if (!test_and_set_bit(AFS_VOLUME_OFFLINE, &op->volume->flags)) {
 				afs_busy(op->volume, op->ac.abort_code);
 				clear_bit(AFS_VOLUME_BUSY, &op->volume->flags);
@@ -207,11 +258,19 @@ bool afs_select_fileserver(struct afs_operation *op)
 			}
 			goto busy;
 
-		case VSALVAGING:
-		case VRESTARTING:
+		case VRESTARTING: /* The fileserver is either shutting down or starting up. */
 		case VBUSY:
-			/* Retry after going round all the servers unless we
-			 * have a file lock we need to maintain.
+			/* The volume is in use by the volserver or another volume utility
+			 * for an operation that is not expected to alter the contents of
+			 * the volume.  VBUSY should not be returned for a ROVOL or
+			 * BACKVOL (but many OpenAFS fileserver versions are broken).  The
+			 * fileserver is supposed to continue serving content from ROVOLs
+			 * and BACKVOLs during an ITBusy transaction because the content
+			 * cannot change.  The volume is expected to come back but it
+			 * might take awhile.
+			 *
+			 * Retry after going round all the servers unless we have a file
+			 * lock we need to maintain.
 			 */
 			if (op->flags & AFS_OPERATION_NO_VSLEEP) {
 				op->error = -EBUSY;
@@ -226,7 +285,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 				if (!afs_sleep_and_retry(op))
 					goto failed;
 
-				 /* Retry with same server & address */
+				/* Retry with same server & address */
 				_leave(" = t [vbusy]");
 				return true;
 			}
@@ -270,10 +329,29 @@ bool afs_select_fileserver(struct afs_operation *op)
 
 			goto restart_from_beginning;
 
+		case VDISKFULL:
+		case UAENOSPC:
+			/* The partition is full.  Only applies to RWVOLs.
+			 * Translate locally and return ENOSPC.
+			 * No replicas to failover to.
+			 */
+			op->error = -ENOSPC;
+			goto failed_but_online;
+
+		case VOVERQUOTA:
+		case UAEDQUOT:
+			/* Volume is full.  Only applies to RWVOLs.
+			 * Translate locally and return EDQUOT.
+			 * No replicas to failover to.
+			 */
+			op->error = -EDQUOT;
+			goto failed_but_online;
+
 		default:
+			op->error = afs_abort_to_error(op->ac.abort_code);
+		failed_but_online:
 			clear_bit(AFS_VOLUME_OFFLINE, &op->volume->flags);
 			clear_bit(AFS_VOLUME_BUSY, &op->volume->flags);
-			op->error = afs_abort_to_error(op->ac.abort_code);
 			goto failed;
 		}
 


