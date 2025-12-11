Return-Path: <linux-fsdevel+bounces-71107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC99CB5D6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 13:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4BD43020142
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 12:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F3230F94F;
	Thu, 11 Dec 2025 12:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4qv3Ram"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E00030C62C
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 12:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765455522; cv=none; b=A8/XgYNEUAqueWxzvcRnAOiiI0JBNhIO7auvzhKH0JGdk5akH9Gp823NM0A/LCcZqbrrW13PLD4Aef4/p3exEjPcIX/YDJF/koefUSJwrCXefgfBPDzS0eKNUhOABAZB2fEX3J+tTus/GQTGXj3svSkbaZfVKfN2nJ+Ns+5P15k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765455522; c=relaxed/simple;
	bh=P7JBn444xdvhLpCQepzLQ+EcWrX8dc4C1cRuQSo75Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CA9KesAc9dx5BegsT5vVa491aTCjHGSyF5UyXWsvbztOxHp/rzSQFakglDyHzM6+UgHWr5Avr7Uu7IjV2K7XXKZO7oWL7e/hK6z43jPHmOSoWIzNu32bOfQiYFnIi1DK78enZLJ3so6lbkfSSvrhh19fjAlFzhznAYVxz5SJsWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z4qv3Ram; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765455515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nDJcnSsXmlBuQK4V1fLhj7UXW9svjBHPVo02fbrc/2w=;
	b=Z4qv3RamvK6sjxD4p4KGGiwpdv144caoOfLh8RcczR89cwJeAn6Em4MAveusR5ol8rC0D5
	BcQ3Jowf2T22nbqjAHuuJBQv8sx27QwutJi9bL+u3+gTijNr/q6AIV4KPLYIuQTiP12YQw
	bOVnQvuUWvj1hRdI35eXSwFWY3NINdk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-5y5qNSzAPN2YLCsX7VSBpw-1; Thu,
 11 Dec 2025 07:18:30 -0500
X-MC-Unique: 5y5qNSzAPN2YLCsX7VSBpw-1
X-Mimecast-MFC-AGG-ID: 5y5qNSzAPN2YLCsX7VSBpw_1765455509
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B9EC1956096;
	Thu, 11 Dec 2025 12:18:29 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D2AA8180049F;
	Thu, 11 Dec 2025 12:18:27 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/18] cifs: Scripted clean up fs/smb/client/fs_context.h
Date: Thu, 11 Dec 2025 12:17:05 +0000
Message-ID: <20251211121715.759074-13-dhowells@redhat.com>
In-Reply-To: <20251211121715.759074-2-dhowells@redhat.com>
References: <20251211121715.759074-2-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Remove externs, correct argument names and reformat declarations.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 fs/smb/client/fs_context.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/smb/client/fs_context.h b/fs/smb/client/fs_context.h
index 7af7cbbe4208..49b2a6f09ca2 100644
--- a/fs/smb/client/fs_context.h
+++ b/fs/smb/client/fs_context.h
@@ -361,18 +361,20 @@ static inline enum cifs_symlink_type cifs_symlink_type(struct cifs_sb_info *cifs
 	return CIFS_SYMLINK_TYPE_NONE;
 }
 
-extern int smb3_init_fs_context(struct fs_context *fc);
-extern void smb3_cleanup_fs_context_contents(struct smb3_fs_context *ctx);
-extern void smb3_cleanup_fs_context(struct smb3_fs_context *ctx);
+int smb3_init_fs_context(struct fs_context *fc);
+void smb3_cleanup_fs_context_contents(struct smb3_fs_context *ctx);
+void smb3_cleanup_fs_context(struct smb3_fs_context *ctx);
 
 static inline struct smb3_fs_context *smb3_fc2context(const struct fs_context *fc)
 {
 	return fc->fs_private;
 }
 
-extern int smb3_fs_context_dup(struct smb3_fs_context *new_ctx, struct smb3_fs_context *ctx);
-extern int smb3_sync_session_ctx_passwords(struct cifs_sb_info *cifs_sb, struct cifs_ses *ses);
-extern void smb3_update_mnt_flags(struct cifs_sb_info *cifs_sb);
+int smb3_fs_context_dup(struct smb3_fs_context *new_ctx,
+			struct smb3_fs_context *ctx);
+int smb3_sync_session_ctx_passwords(struct cifs_sb_info *cifs_sb,
+				    struct cifs_ses *ses);
+void smb3_update_mnt_flags(struct cifs_sb_info *cifs_sb);
 
 /*
  * max deferred close timeout (jiffies) - 2^30
@@ -380,7 +382,7 @@ extern void smb3_update_mnt_flags(struct cifs_sb_info *cifs_sb);
 #define SMB3_MAX_DCLOSETIMEO (1 << 30)
 #define SMB3_DEF_DCLOSETIMEO (1 * HZ) /* even 1 sec enough to help eg open/write/close/open/read */
 #define MAX_CACHED_FIDS 16
-extern char *cifs_sanitize_prepath(char *prepath, gfp_t gfp);
+char *cifs_sanitize_prepath(char *prepath, gfp_t gfp);
 
 extern struct mutex cifs_mount_mutex;
 


