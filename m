Return-Path: <linux-fsdevel+bounces-71857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C82CD7589
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 118913079A83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 22:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF9C32D44B;
	Mon, 22 Dec 2025 22:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T1fkD3yL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019F733BBA8
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 22:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442653; cv=none; b=Em4/kKYJuXCdRmnUdlgQxZziqcrb5n09i+E/Y7oKuVKvPOoKaxZBZZE9mYRZTi9qafhPah+0jb/2/wIoOc59fe9vAZ1qRvnat6ENtMmY29JfTnnKRTlEW4fFQUk3EsDv4kt7WziFr81aPvoZqBHftWXjFXfbypWjXR5fZtE7CfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442653; c=relaxed/simple;
	bh=P7JBn444xdvhLpCQepzLQ+EcWrX8dc4C1cRuQSo75Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTwtEbIHruyV3oApPus9j3erwBtJ3EYjDbfJRWjALAITmc5JO868BvCTXNy6CJQoTkhXL6nwZLyk5RwAKATBw/5YfF4HiwTQ1zeJohW0FUwcGjUKu0G/cfKsGj+7NI05gG0/qm762R9CZ8iiZFRHUYjnVSjdtaf39OAqFZsa8/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T1fkD3yL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766442650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nDJcnSsXmlBuQK4V1fLhj7UXW9svjBHPVo02fbrc/2w=;
	b=T1fkD3yLJJliLJTpJM7giqRuFQGG5X+YxEK/K01lNYtyCymu7py+mL54njnFZfkzx/PrLC
	zoZpQnGbV8vb9RmG21ZornYPcLFrDNCk8X2e7J7GrctEUn4MkLJ/c+QxfnXAXoQ6fZsRwm
	1PdPWN7ZaNZP+5eXeO3UF0BAlPINPU0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-6LRtMBdEOD2mk7aauDBB9Q-1; Mon,
 22 Dec 2025 17:30:47 -0500
X-MC-Unique: 6LRtMBdEOD2mk7aauDBB9Q-1
X-Mimecast-MFC-AGG-ID: 6LRtMBdEOD2mk7aauDBB9Q_1766442646
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3996018002C1;
	Mon, 22 Dec 2025 22:30:46 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8002C180035F;
	Mon, 22 Dec 2025 22:30:44 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/37] cifs: Scripted clean up fs/smb/client/fs_context.h
Date: Mon, 22 Dec 2025 22:29:36 +0000
Message-ID: <20251222223006.1075635-12-dhowells@redhat.com>
In-Reply-To: <20251222223006.1075635-1-dhowells@redhat.com>
References: <20251222223006.1075635-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
 


