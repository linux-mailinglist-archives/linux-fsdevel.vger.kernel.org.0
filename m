Return-Path: <linux-fsdevel+bounces-71103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9C9CB5CD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 13:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F10EB3043F4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 12:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9BB30C622;
	Thu, 11 Dec 2025 12:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjGtYTLU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A342DEA79
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 12:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765455505; cv=none; b=i+IFnljpSiAPl53hGA5HgAUHPM4SMM2hmefxj8mXJ5NCPnXgEOvze7s2EPbNHNZ1S94OUfa/pSa+sLXGZpSVEkNWHVpW061YjYSg59P7TqWKJSAtqiODhVnLokI+4IKAWUexzHZwAAX8FO6iRT3nMpsuZymHXLorL4hZoVguvdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765455505; c=relaxed/simple;
	bh=oMNuP5eMo7QZMktDt0t9C7WFXYZ0Qqbx4FwV3y0/MjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EhrS8YZ1j9RPBNkWwLfe0enFALpVbEpTri/EOHtX+ghY57CrhXvVXDHADPDH8kAttsBG55rqFBudA0Z0saPFwr4aCXqML8m8IBc6lhfXL4TRkmCWnc/Niihg0nHVuQng3V6jR+sUcNYpwOJE0WxspgxqbiWRYDZk4xRUayX1WZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TjGtYTLU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765455502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YfsFPnOcbltfq8I/LYPyEFBTp8hIt6U9UoZ8nzClcJE=;
	b=TjGtYTLU/Q2YOHZ6hpDwoBH6ee1yxQfi+LoWmF8E/Ycr0AWv5Svv7E+oGehD7lEP5rmAdY
	K1G1QKZWrREUWInfS9O7uqJDXTm/r4Fx1JATJjsynJtXwlTBba6mzA6C/vNgW0qIR8GQdV
	GwDqI0xITc1ccIa0d7sM70D056KXHbg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-Yq83xA6FM12da0kERHhmJw-1; Thu,
 11 Dec 2025 07:18:18 -0500
X-MC-Unique: Yq83xA6FM12da0kERHhmJw-1
X-Mimecast-MFC-AGG-ID: Yq83xA6FM12da0kERHhmJw_1765455497
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C5A3195DE49;
	Thu, 11 Dec 2025 12:18:17 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7631E180045B;
	Thu, 11 Dec 2025 12:18:15 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/18] cifs: Scripted clean up fs/smb/client/dfs_cache.h
Date: Thu, 11 Dec 2025 12:17:01 +0000
Message-ID: <20251211121715.759074-9-dhowells@redhat.com>
In-Reply-To: <20251211121715.759074-2-dhowells@redhat.com>
References: <20251211121715.759074-2-dhowells@redhat.com>
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
 fs/smb/client/dfs_cache.h | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/smb/client/dfs_cache.h b/fs/smb/client/dfs_cache.h
index 18a08a2ca93b..c99dc3546c70 100644
--- a/fs/smb/client/dfs_cache.h
+++ b/fs/smb/client/dfs_cache.h
@@ -37,17 +37,22 @@ int dfs_cache_init(void);
 void dfs_cache_destroy(void);
 extern const struct proc_ops dfscache_proc_ops;
 
-int dfs_cache_find(const unsigned int xid, struct cifs_ses *ses, const struct nls_table *cp,
-		   int remap, const char *path, struct dfs_info3_param *ref,
+int dfs_cache_find(const unsigned int xid, struct cifs_ses *ses,
+		   const struct nls_table *cp, int remap, const char *path,
+		   struct dfs_info3_param *ref,
 		   struct dfs_cache_tgt_list *tgt_list);
 int dfs_cache_noreq_find(const char *path, struct dfs_info3_param *ref,
 			 struct dfs_cache_tgt_list *tgt_list);
-void dfs_cache_noreq_update_tgthint(const char *path, const struct dfs_cache_tgt_iterator *it);
-int dfs_cache_get_tgt_referral(const char *path, const struct dfs_cache_tgt_iterator *it,
+void dfs_cache_noreq_update_tgthint(const char *path,
+				    const struct dfs_cache_tgt_iterator *it);
+int dfs_cache_get_tgt_referral(const char *path,
+			       const struct dfs_cache_tgt_iterator *it,
 			       struct dfs_info3_param *ref);
-int dfs_cache_get_tgt_share(char *path, const struct dfs_cache_tgt_iterator *it, char **share,
-			    char **prefix);
-char *dfs_cache_canonical_path(const char *path, const struct nls_table *cp, int remap);
+int dfs_cache_get_tgt_share(char *path,
+			    const struct dfs_cache_tgt_iterator *it,
+			    char **share, char **prefix);
+char *dfs_cache_canonical_path(const char *path, const struct nls_table *cp,
+			       int remap);
 int dfs_cache_remount_fs(struct cifs_sb_info *cifs_sb);
 void dfs_cache_refresh(struct work_struct *work);
 


