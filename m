Return-Path: <linux-fsdevel+bounces-16121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA71898B54
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 17:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1938DB2EEA7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 15:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E9A129A6D;
	Thu,  4 Apr 2024 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8RWcxYq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3281CD03
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Apr 2024 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244075; cv=none; b=eVjWb1Eiq1oAsnMnAfnk4Ww5vaPfh0Y9wzuslpVRUHKT6cOMD3Np1mAz4hJkWUn6ZwFZnNb0PwY6CnEC8JVpv+11mg1BnEiBcy0Z6htcinvYXRli8mrnMyPvlx3dXSfB6bEhaLKGLvbH1y8Aosh57EMYN/H6Ifobk1qKm8cX2yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244075; c=relaxed/simple;
	bh=V8Htf3FxArXZOjpT7JaiPa+T9xMOduzC+ht79Ajtu3s=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=fzInBhqhZD/E4MnsDUlLjYC/XGsFyKLFeo3//9XMsNUoW53x+NwpTUqYiCYVk88XwzpzTaIq4XvxOvVKzzVrYobGXx90n79f2BBOHCThaFPfFcwnqvNgniiE0tpj3TD7im3fgSOtuNUalFWwQmavc7kefYdTzeUN/240ND+qjpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c8RWcxYq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712244072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=GrzFxXEztjRZhV/WohseGdRBSkdmNtFDgS7pFsyJXMk=;
	b=c8RWcxYqyUWV1kl2JvW7B5zTrip+LMXiy+I2yVDV4OPSQCQz8XMfX3RaAEieHU4JaszEwp
	MXf91UGMLlQ0UDGDGgFtKYmNCB6o5SXDgZWJg8+/wdzK3tP2Ma1PLD0NAei43r3wG26Htr
	uN+td5qbIZXQjR06gsQZ+0Q5e6whsCg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-PWOhkXh4M9-exNQIcB98wA-1; Thu, 04 Apr 2024 11:21:10 -0400
X-MC-Unique: PWOhkXh4M9-exNQIcB98wA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42F178DC66F;
	Thu,  4 Apr 2024 15:21:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 44866C04120;
	Thu,  4 Apr 2024 15:21:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Fix reacquisition of volume cookie on still-live connection
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3756405.1712244064.1@warthog.procyon.org.uk>
Date: Thu, 04 Apr 2024 16:21:04 +0100
Message-ID: <3756406.1712244064@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

During mount, cifs_mount_get_tcon() gets a tcon resource connection record
and then attaches an fscache volume cookie to it.  However, it does this
irrespective of whether or not the tcon returned from cifs_get_tcon() is a
new record or one that's already in use.  This leads to a warning about a
volume cookie collision and a leaked volume cookie because tcon->fscache
gets reset.

Fix this be adding a mutex and a "we've already tried this" flag and only
doing it once for the lifetime of the tcon.

[!] Note: Looking at cifs_mount_get_tcon(), a more general solution may
actually be required.  Reacquiring the volume cookie isn't the only thing
that function does: it also partially reinitialises the tcon record without
any locking - which may cause live filesystem ops already using the tcon
through a previous mount to malfunction.

This can be reproduced simply by something like:

    mount //example.com/test /xfstest.test -o user=shares,pass=xxx,fsc
    mount //example.com/test /mnt -o user=shares,pass=xxx,fsc

Fixes: 70431bfd825d ("cifs: Support fscache indexing rewrite")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifsglob.h |    2 ++
 fs/smb/client/fscache.c  |   13 +++++++++++++
 fs/smb/client/misc.c     |    3 +++
 3 files changed, 18 insertions(+)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 7ed9d05f6890..43319288b4e3 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1275,7 +1275,9 @@ struct cifs_tcon {
 	__u32 max_cached_dirs;
 #ifdef CONFIG_CIFS_FSCACHE
 	u64 resource_id;		/* server resource id */
+	bool fscache_acquired;		/* T if we've tried acquiring a cookie */
 	struct fscache_volume *fscache;	/* cookie for share */
+	struct mutex fscache_lock;	/* Prevent regetting a cookie */
 #endif
 	struct list_head pending_opens;	/* list of incomplete opens */
 	struct cached_fids *cfids;
diff --git a/fs/smb/client/fscache.c b/fs/smb/client/fscache.c
index 340efce8f052..113bde8f1e61 100644
--- a/fs/smb/client/fscache.c
+++ b/fs/smb/client/fscache.c
@@ -43,12 +43,23 @@ int cifs_fscache_get_super_cookie(struct cifs_tcon *tcon)
 	char *key;
 	int ret = -ENOMEM;
 
+	if (tcon->fscache_acquired)
+		return 0;
+
+	mutex_lock(&tcon->fscache_lock);
+	if (tcon->fscache_acquired) {
+		mutex_unlock(&tcon->fscache_lock);
+		return 0;
+	}
+	tcon->fscache_acquired = true;
+
 	tcon->fscache = NULL;
 	switch (sa->sa_family) {
 	case AF_INET:
 	case AF_INET6:
 		break;
 	default:
+		mutex_unlock(&tcon->fscache_lock);
 		cifs_dbg(VFS, "Unknown network family '%d'\n", sa->sa_family);
 		return -EINVAL;
 	}
@@ -57,6 +68,7 @@ int cifs_fscache_get_super_cookie(struct cifs_tcon *tcon)
 
 	sharename = extract_sharename(tcon->tree_name);
 	if (IS_ERR(sharename)) {
+		mutex_unlock(&tcon->fscache_lock);
 		cifs_dbg(FYI, "%s: couldn't extract sharename\n", __func__);
 		return PTR_ERR(sharename);
 	}
@@ -90,6 +102,7 @@ int cifs_fscache_get_super_cookie(struct cifs_tcon *tcon)
 	kfree(key);
 out:
 	kfree(sharename);
+	mutex_unlock(&tcon->fscache_lock);
 	return ret;
 }
 
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index c3771fc81328..b27fbb840539 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -141,6 +141,9 @@ tcon_info_alloc(bool dir_leases_enabled)
 #ifdef CONFIG_CIFS_DFS_UPCALL
 	INIT_LIST_HEAD(&ret_buf->dfs_ses_list);
 #endif
+#ifdef CONFIG_CIFS_FSCACHE
+	mutex_init(&ret_buf->fscache_lock);
+#endif
 
 	return ret_buf;
 }


