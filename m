Return-Path: <linux-fsdevel+bounces-71105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 288FBCB5D21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 13:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B88103094E3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 12:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F7D30C63E;
	Thu, 11 Dec 2025 12:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBW1xKel"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0423C2F99A3
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 12:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765455515; cv=none; b=gLxUGu2iUDBP41tNzKKYHuApbbXxQj6E22XXhyfwDk7DoMqYhWIq4RTAPGYXbNB7lsEAQFQeXhyV4L8PDkGIPUoxaK3L+iWVfzg08y1zO0gv+vtNsSu7VXqF9Z9wNgHNzlLIK18lwQRc5N9D6muf/kUkX3eLwTSt7YHepZBMrAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765455515; c=relaxed/simple;
	bh=V2FIfxbj6NUEd+Pb09ufbOelsQwMm6m90XXQ5nd29xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGSWBUdrmJPHYGeCWgB53UPwIPCxfG0U+FJoFcXKji8uawSHyhUJ8kWxqOv2zeViF7HftSqw63R+2M0y/r/6z+WLe4c5buJgmx4OJ9psmlRMom2KakKyg14Fwdp/hGm/g6WGhE6rbbvBiVVwna1dBC6qk45Qlz7un2LzGvZF8yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JBW1xKel; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765455508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hr2Frj82z7mY9fcOShwiQSfQlG9xZaviuZh/z2HfbTQ=;
	b=JBW1xKel7eUTS4IapYLbmdajg9byo5b7tz7MRJ8FnGfipoLalOI3ZroJFA0ju16gXwLvoJ
	6L7FmyCjkVh94CYJ1+u5wrSDWgzwOOsUhVcYdm7nYBTkepTAXcaT061zntfvQYYr9wgrMy
	Ct0cp2cpPgW4LLg+AqZbwCSGrqj0V70=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-QPiUMRVqNrC7sWecJh8CrQ-1; Thu,
 11 Dec 2025 07:18:25 -0500
X-MC-Unique: QPiUMRVqNrC7sWecJh8CrQ-1
X-Mimecast-MFC-AGG-ID: QPiUMRVqNrC7sWecJh8CrQ_1765455503
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B71C418011EE;
	Thu, 11 Dec 2025 12:18:23 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 06F0B1953986;
	Thu, 11 Dec 2025 12:18:21 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/18] cifs: Scripted clean up fs/smb/client/cifsglob.h
Date: Thu, 11 Dec 2025 12:17:03 +0000
Message-ID: <20251211121715.759074-11-dhowells@redhat.com>
In-Reply-To: <20251211121715.759074-2-dhowells@redhat.com>
References: <20251211121715.759074-2-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Remove externs, correct argument names and reformat declarations.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 fs/smb/client/cifsglob.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 3eca5bfb7030..9cff21fb7266 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1327,8 +1327,8 @@ struct tcon_link {
 	struct cifs_tcon	*tl_tcon;
 };
 
-extern struct tcon_link *cifs_sb_tlink(struct cifs_sb_info *cifs_sb);
-extern void smb3_free_compound_rqst(int num_rqst, struct smb_rqst *rqst);
+struct tcon_link *cifs_sb_tlink(struct cifs_sb_info *cifs_sb);
+void smb3_free_compound_rqst(int num_rqst, struct smb_rqst *rqst);
 
 static inline struct cifs_tcon *
 tlink_tcon(struct tcon_link *tlink)
@@ -1342,7 +1342,7 @@ cifs_sb_master_tlink(struct cifs_sb_info *cifs_sb)
 	return cifs_sb->master_tlink;
 }
 
-extern void cifs_put_tlink(struct tcon_link *tlink);
+void cifs_put_tlink(struct tcon_link *tlink);
 
 static inline struct tcon_link *
 cifs_get_tlink(struct tcon_link *tlink)
@@ -1353,7 +1353,7 @@ cifs_get_tlink(struct tcon_link *tlink)
 }
 
 /* This function is always expected to succeed */
-extern struct cifs_tcon *cifs_sb_master_tcon(struct cifs_sb_info *cifs_sb);
+struct cifs_tcon *cifs_sb_master_tcon(struct cifs_sb_info *cifs_sb);
 
 #define CIFS_OPLOCK_NO_CHANGE 0xfe
 
@@ -1526,8 +1526,8 @@ cifsFileInfo_get_locked(struct cifsFileInfo *cifs_file)
 }
 
 struct cifsFileInfo *cifsFileInfo_get(struct cifsFileInfo *cifs_file);
-void _cifsFileInfo_put(struct cifsFileInfo *cifs_file, bool wait_oplock_hdlr,
-		       bool offload);
+void _cifsFileInfo_put(struct cifsFileInfo *cifs_file,
+		       bool wait_oplock_handler, bool offload);
 void cifsFileInfo_put(struct cifsFileInfo *cifs_file);
 int cifs_file_flush(const unsigned int xid, struct inode *inode,
 		    struct cifsFileInfo *cfile);


