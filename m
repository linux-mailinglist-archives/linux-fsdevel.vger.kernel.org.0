Return-Path: <linux-fsdevel+bounces-43579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F00A58FF8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 10:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597BB164BE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 09:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDF5226CF6;
	Mon, 10 Mar 2025 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPUFwYCt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B973E226885
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 09:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599760; cv=none; b=Qq2UXFPQ3t8YNsh5hWyBK8h+UDOdBa8hghqPJWbbf8gjb7bfnK9rpT7dLwULdZJ8XHcz0xJT+zJ4lzj+QrH4AVCvEUgd4d1ANtLQtHuVon84XHG9he5FSk6srXkQFQc4PfANKk56b97COFlV9ioS8FpL0y47PcdmnZUmbBXv66s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599760; c=relaxed/simple;
	bh=/htZgUzt8knAr+hiRacdqz5GeDl5/4xYQD4/ZC7eRD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJKDsleZNkm1CqwjVVPLd7OjCjCKxbc1SLK5legcefhq9T8tPpH+sZneLrGMq82vrS9as+A1cYyRHxa3bjDoGhK9gLI6c/ugcM1IuK3YpH42SuCeOUdhofR1NREtvJUSGMocp1V94OX5rdDpu4Uge7ZX4Pyt54DPlCPbF1hOsoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPUFwYCt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741599756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=16o31y5LryjLyHYuo1OhSgUhMY7/YxydWgak/ianHBU=;
	b=UPUFwYCtphDk8OC4BeXoTZni7xiIeVuwH/K6LOJl7Z/IwjaRKiAjAsXNr2n+ZsLWtIssn8
	Z+srzmnXuvOJ2jNUM4JAnqlKaPydEMIrsuBWGGX/SJ0TcYtX0lK5QUECbkU/fcAf0gut71
	KK1ziEmoHPsLDEZH0/xVOQt49URKZ1A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-4W0z7l4xPNuYI2Te3AP8GA-1; Mon,
 10 Mar 2025 05:42:33 -0400
X-MC-Unique: 4W0z7l4xPNuYI2Te3AP8GA-1
X-Mimecast-MFC-AGG-ID: 4W0z7l4xPNuYI2Te3AP8GA_1741599752
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23822180025A;
	Mon, 10 Mar 2025 09:42:31 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7555719560AB;
	Mon, 10 Mar 2025 09:42:29 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/11] afs: Improve afs_volume tracing to display a debug ID
Date: Mon, 10 Mar 2025 09:41:57 +0000
Message-ID: <20250310094206.801057-5-dhowells@redhat.com>
In-Reply-To: <20250310094206.801057-1-dhowells@redhat.com>
References: <20250310094206.801057-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Improve the tracing of afs_volume objects to include displaying a debug ID
so that different instances of volumes with the same "vid" can be
distinguished.

Also be consistent about displaying the volume's refcount (and not the
cell's).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20250224234154.2014840-9-dhowells@redhat.com/ # v1
---
 fs/afs/internal.h          |  1 +
 fs/afs/volume.c            | 15 +++++++++------
 include/trace/events/afs.h | 18 +++++++++++-------
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 47e98a78f59f..97045e2a455d 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -623,6 +623,7 @@ struct afs_volume {
 	afs_volid_t		vid;		/* The volume ID of this volume */
 	afs_volid_t		vids[AFS_MAXTYPES]; /* All associated volume IDs */
 	refcount_t		ref;
+	unsigned int		debug_id;	/* Debugging ID for traces */
 	time64_t		update_at;	/* Time at which to next update */
 	struct afs_cell		*cell;		/* Cell to which belongs (pins ref) */
 	struct rb_node		cell_node;	/* Link in cell->volumes */
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index af3a3f57c1b3..0efff3d25133 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -10,6 +10,7 @@
 #include "internal.h"
 
 static unsigned __read_mostly afs_volume_record_life = 60 * 60;
+static atomic_t afs_volume_debug_id;
 
 static void afs_destroy_volume(struct work_struct *work);
 
@@ -59,7 +60,7 @@ static void afs_remove_volume_from_cell(struct afs_volume *volume)
 	struct afs_cell *cell = volume->cell;
 
 	if (!hlist_unhashed(&volume->proc_link)) {
-		trace_afs_volume(volume->vid, refcount_read(&cell->ref),
+		trace_afs_volume(volume->debug_id, volume->vid, refcount_read(&volume->ref),
 				 afs_volume_trace_remove);
 		write_seqlock(&cell->volume_lock);
 		hlist_del_rcu(&volume->proc_link);
@@ -84,6 +85,7 @@ static struct afs_volume *afs_alloc_volume(struct afs_fs_context *params,
 	if (!volume)
 		goto error_0;
 
+	volume->debug_id	= atomic_inc_return(&afs_volume_debug_id);
 	volume->vid		= vldb->vid[params->type];
 	volume->update_at	= ktime_get_real_seconds() + afs_volume_record_life;
 	volume->cell		= afs_get_cell(params->cell, afs_cell_trace_get_vol);
@@ -115,7 +117,7 @@ static struct afs_volume *afs_alloc_volume(struct afs_fs_context *params,
 
 	*_slist = slist;
 	rcu_assign_pointer(volume->servers, slist);
-	trace_afs_volume(volume->vid, 1, afs_volume_trace_alloc);
+	trace_afs_volume(volume->debug_id, volume->vid, 1, afs_volume_trace_alloc);
 	return volume;
 
 error_1:
@@ -247,7 +249,7 @@ static void afs_destroy_volume(struct work_struct *work)
 	afs_remove_volume_from_cell(volume);
 	afs_put_serverlist(volume->cell->net, slist);
 	afs_put_cell(volume->cell, afs_cell_trace_put_vol);
-	trace_afs_volume(volume->vid, refcount_read(&volume->ref),
+	trace_afs_volume(volume->debug_id, volume->vid, refcount_read(&volume->ref),
 			 afs_volume_trace_free);
 	kfree_rcu(volume, rcu);
 
@@ -262,7 +264,7 @@ bool afs_try_get_volume(struct afs_volume *volume, enum afs_volume_trace reason)
 	int r;
 
 	if (__refcount_inc_not_zero(&volume->ref, &r)) {
-		trace_afs_volume(volume->vid, r + 1, reason);
+		trace_afs_volume(volume->debug_id, volume->vid, r + 1, reason);
 		return true;
 	}
 	return false;
@@ -278,7 +280,7 @@ struct afs_volume *afs_get_volume(struct afs_volume *volume,
 		int r;
 
 		__refcount_inc(&volume->ref, &r);
-		trace_afs_volume(volume->vid, r + 1, reason);
+		trace_afs_volume(volume->debug_id, volume->vid, r + 1, reason);
 	}
 	return volume;
 }
@@ -290,12 +292,13 @@ struct afs_volume *afs_get_volume(struct afs_volume *volume,
 void afs_put_volume(struct afs_volume *volume, enum afs_volume_trace reason)
 {
 	if (volume) {
+		unsigned int debug_id = volume->debug_id;
 		afs_volid_t vid = volume->vid;
 		bool zero;
 		int r;
 
 		zero = __refcount_dec_and_test(&volume->ref, &r);
-		trace_afs_volume(vid, r - 1, reason);
+		trace_afs_volume(debug_id, vid, r - 1, reason);
 		if (zero)
 			schedule_work(&volume->destructor);
 	}
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index c19132605f41..cf94bf1e8286 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -1539,25 +1539,29 @@ TRACE_EVENT(afs_server,
 	    );
 
 TRACE_EVENT(afs_volume,
-	    TP_PROTO(afs_volid_t vid, int ref, enum afs_volume_trace reason),
+	    TP_PROTO(unsigned int debug_id, afs_volid_t vid, int ref,
+		     enum afs_volume_trace reason),
 
-	    TP_ARGS(vid, ref, reason),
+	    TP_ARGS(debug_id, vid, ref, reason),
 
 	    TP_STRUCT__entry(
+		    __field(unsigned int,		debug_id)
 		    __field(afs_volid_t,		vid)
 		    __field(int,			ref)
 		    __field(enum afs_volume_trace,	reason)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->vid = vid;
-		    __entry->ref = ref;
-		    __entry->reason = reason;
+		    __entry->debug_id	= debug_id;
+		    __entry->vid	= vid;
+		    __entry->ref	= ref;
+		    __entry->reason	= reason;
 			   ),
 
-	    TP_printk("V=%llx %s ur=%d",
-		      __entry->vid,
+	    TP_printk("V=%08x %s vid=%llx r=%d",
+		      __entry->debug_id,
 		      __print_symbolic(__entry->reason, afs_volume_traces),
+		      __entry->vid,
 		      __entry->ref)
 	    );
 


