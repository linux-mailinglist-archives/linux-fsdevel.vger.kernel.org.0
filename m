Return-Path: <linux-fsdevel+bounces-71097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2460CB5C8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 13:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33A99304FEA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 12:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF172F1FE2;
	Thu, 11 Dec 2025 12:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KASwb4gA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AE42D73BC
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765455484; cv=none; b=KQLOl41OzqfHFkIcAt0i0Atc9ZXp3Zt/Kbj2um1cYiIpA12nf+tHI896ZszHOC9tB90cotQm4YTcnV46T4SbAVoLnG4lMsNKd+/hRgozBE9Bda65coXYHiSIdSFvbTSg1hHmqkejB+v4tOsSM6WdAcf5bis2zERqhlQJEGgah7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765455484; c=relaxed/simple;
	bh=6HT4bpIkmylfTxujLc2RbKpDqRo8DLvgdweiK6y3ANA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srJV+U5kyKRYsy50d1tuwhijwAWPAPzynH3T2G8SzovC1nn2H0XPMhp2OJYmGcdiRwvi4k0+wOrd7V6yohaSL3/pQlFreMpoRBCDvLMF751V3ZGo/TpAgouKG6YbNwkYZhVQ+UwMJ6uhoDFtv7WR0dAdDECXw+Dikj3IoxJ1plM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KASwb4gA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765455481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vp6OX7uL6m79SkKOoGXJJCHtSD5Ariw4GExCJNzZvKg=;
	b=KASwb4gA20aylIExkmmZc9d4tIK3Grc7JvmCSDOyw3z77BaHLtzVN8UMqfK1BjTbUKO2qO
	7PYdpHVGLKYm4qqWUYKYlL46mlFu2n87f1+MoQYZA6Tb92ymvEMkjIbEnE5SpPNHuLopz+
	qGQj7JawWXNQqOq5e3eR3w+G3NLOFRE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-GyHwX4R2Mf-SWDxgC82YlQ-1; Thu,
 11 Dec 2025 07:17:58 -0500
X-MC-Unique: GyHwX4R2Mf-SWDxgC82YlQ-1
X-Mimecast-MFC-AGG-ID: GyHwX4R2Mf-SWDxgC82YlQ_1765455477
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DA1A1800675;
	Thu, 11 Dec 2025 12:17:57 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4D84930001A2;
	Thu, 11 Dec 2025 12:17:55 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/18] cifs: Scripted clean up fs/smb/client/cached_dir.h
Date: Thu, 11 Dec 2025 12:16:55 +0000
Message-ID: <20251211121715.759074-3-dhowells@redhat.com>
In-Reply-To: <20251211121715.759074-2-dhowells@redhat.com>
References: <20251211121715.759074-2-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Remove externs, correct argument names and reformat declarations.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 fs/smb/client/cached_dir.h | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/fs/smb/client/cached_dir.h b/fs/smb/client/cached_dir.h
index 1e383db7c337..f0837bb2161a 100644
--- a/fs/smb/client/cached_dir.h
+++ b/fs/smb/client/cached_dir.h
@@ -77,22 +77,18 @@ is_valid_cached_dir(struct cached_fid *cfid)
 	return cfid->time && cfid->has_lease;
 }
 
-extern struct cached_fids *init_cached_dirs(void);
-extern void free_cached_dirs(struct cached_fids *cfids);
-extern int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
-			   const char *path,
-			   struct cifs_sb_info *cifs_sb,
-			   bool lookup_only, struct cached_fid **cfid);
-extern int open_cached_dir_by_dentry(struct cifs_tcon *tcon,
-				     struct dentry *dentry,
-				     struct cached_fid **cfid);
-extern void close_cached_dir(struct cached_fid *cfid);
-extern void drop_cached_dir_by_name(const unsigned int xid,
-				    struct cifs_tcon *tcon,
-				    const char *name,
-				    struct cifs_sb_info *cifs_sb);
-extern void close_all_cached_dirs(struct cifs_sb_info *cifs_sb);
-extern void invalidate_all_cached_dirs(struct cifs_tcon *tcon);
-extern bool cached_dir_lease_break(struct cifs_tcon *tcon, __u8 lease_key[16]);
+struct cached_fids *init_cached_dirs(void);
+void free_cached_dirs(struct cached_fids *cfids);
+int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon, const char *path,
+		    struct cifs_sb_info *cifs_sb, bool lookup_only,
+		    struct cached_fid **ret_cfid);
+int open_cached_dir_by_dentry(struct cifs_tcon *tcon, struct dentry *dentry,
+			      struct cached_fid **ret_cfid);
+void close_cached_dir(struct cached_fid *cfid);
+void drop_cached_dir_by_name(const unsigned int xid, struct cifs_tcon *tcon,
+			     const char *name, struct cifs_sb_info *cifs_sb);
+void close_all_cached_dirs(struct cifs_sb_info *cifs_sb);
+void invalidate_all_cached_dirs(struct cifs_tcon *tcon);
+bool cached_dir_lease_break(struct cifs_tcon *tcon, __u8 lease_key[16]);
 
 #endif			/* _CACHED_DIR_H */


