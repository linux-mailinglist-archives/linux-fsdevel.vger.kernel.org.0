Return-Path: <linux-fsdevel+bounces-18310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 748988B706A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 12:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F5DE285593
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 10:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9645812CDAE;
	Tue, 30 Apr 2024 10:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oU9XsoDl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB29712C46D;
	Tue, 30 Apr 2024 10:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473931; cv=none; b=kpwMvCat6eLC1gxsKpw78gMuqe9tkKIlU3zHMLdBcjvRRDnv11IsVbCmviNgTqUetUXEWo2K0apCCi2fsgfIrBacId6u+ByIqS/eOO4scxN1iABkS+bK1URxx2oLm83HPqu0VRWgn7KpQfSv8ZMPJu/EZMEk1Lg+I7y54cZ3grg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473931; c=relaxed/simple;
	bh=hC03OIiMJ2E4WTpiCERA8rGnU2TYGA64/c3TJ4UGlt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FN6GjTiW3BadvO6RXxMsJ6E7NvfiJjd5Wl03d1IS5RpeNlyS10SdkU/u5xugvKXs1RssH1cvNWeKjcqpDYJrO3E2aHWKK4nP7ymTiXi+YwBmN7VDQ+92YF4ZlP0ygTX+QpkpY63ssE3mL1rtdjeomDTbKIQx4O6JrD+tSWsp8VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oU9XsoDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6246AC2BBFC;
	Tue, 30 Apr 2024 10:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714473930;
	bh=hC03OIiMJ2E4WTpiCERA8rGnU2TYGA64/c3TJ4UGlt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oU9XsoDlh1RblRLeqiReO+FmlMLHrzABWziPnjGRYojNMD80fTZdRIs028EVzhHeF
	 gqCHR/3Pt7AXKBP+PlWY50IBKMRPfG9U7nZr2SMX9dUft74ZdYIkcLanJYuYNig1Jr
	 8C2nqj8Hamt/zRmzV91UIiDdnQie1uPbsTiIrb88=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 001/228] cifs: Fix reacquisition of volume cookie on still-live connection
Date: Tue, 30 Apr 2024 12:36:19 +0200
Message-ID: <20240430103103.852592498@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>
References: <20240430103103.806426847@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit dad80c6bff770d25f67ec25fe011730e4a463008 ]

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
Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h |  2 ++
 fs/smb/client/fscache.c  | 13 +++++++++++++
 fs/smb/client/misc.c     |  3 +++
 3 files changed, 18 insertions(+)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 844afda090d05..0c3311de5dc0a 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1261,7 +1261,9 @@ struct cifs_tcon {
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
index 340efce8f0529..113bde8f1e613 100644
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
index 74627d647818a..0d13db80e67c9 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -141,6 +141,9 @@ tcon_info_alloc(bool dir_leases_enabled)
 	atomic_set(&ret_buf->num_local_opens, 0);
 	atomic_set(&ret_buf->num_remote_opens, 0);
 	ret_buf->stats_from_time = ktime_get_real_seconds();
+#ifdef CONFIG_CIFS_FSCACHE
+	mutex_init(&ret_buf->fscache_lock);
+#endif
 
 	return ret_buf;
 }
-- 
2.43.0




