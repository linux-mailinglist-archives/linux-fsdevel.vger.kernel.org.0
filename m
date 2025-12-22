Return-Path: <linux-fsdevel+bounces-71847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E014BCD74B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F02230213CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 22:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B5D30EF98;
	Mon, 22 Dec 2025 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHHBi9Lr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CDF30FF3A
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442623; cv=none; b=Tkxp5us8r6GRb+Mc6uuHSlckXG48GIUbLyvANa3wvXkrW0hqWuVCopzDMpvaIHV5rsiFoN9Zu8+n+PG5QUtbaffCVIQSm8xIFZQSYUipeM1dIEfgmcgWaf1hXymLwBywY8fVU01eJk6Lv0pmd4Vp32vpcEWipmSCYD6IY7hle3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442623; c=relaxed/simple;
	bh=6HT4bpIkmylfTxujLc2RbKpDqRo8DLvgdweiK6y3ANA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bC6pic7feq0vlPk0wge04d62fBGG4YF2efCATVUeO/ig9rAIYpFei5SsjTnssIihXpkyObM3aedvU/ey3TfE9hm16bQ7E+zrQyn1sbEh9lruRy2VK8VH0gCBsP/1bDA+d1B52vpWTct/AxSf1eoep7A9p8+plamUqDkakp7OQS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHHBi9Lr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766442620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vp6OX7uL6m79SkKOoGXJJCHtSD5Ariw4GExCJNzZvKg=;
	b=bHHBi9LrTpob7wMF7zQ0dOIilDa3SSCwza0YmBrj/V5yJBbQyXVF1ooLrBKyXkNP9o6jEY
	ZxvnPPlLkcR3IazqnkhHyqECIucdKiwurK+QMDrJ7CJn4/eCmUBS13W/PqcfTiVL//W0ju
	Unm5vZBzmwMJ7+W/W4Tbk5GEBS5OP0w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-dh-HiZw9Pg2pM_5WyLkEzg-1; Mon,
 22 Dec 2025 17:30:16 -0500
X-MC-Unique: dh-HiZw9Pg2pM_5WyLkEzg-1
X-Mimecast-MFC-AGG-ID: dh-HiZw9Pg2pM_5WyLkEzg_1766442615
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2714618002DE;
	Mon, 22 Dec 2025 22:30:15 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5148619560B4;
	Mon, 22 Dec 2025 22:30:13 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/37] cifs: Scripted clean up fs/smb/client/cached_dir.h
Date: Mon, 22 Dec 2025 22:29:26 +0000
Message-ID: <20251222223006.1075635-2-dhowells@redhat.com>
In-Reply-To: <20251222223006.1075635-1-dhowells@redhat.com>
References: <20251222223006.1075635-1-dhowells@redhat.com>
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


