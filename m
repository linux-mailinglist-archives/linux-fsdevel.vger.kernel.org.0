Return-Path: <linux-fsdevel+bounces-14605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5307A87DE9D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE861B212F9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A491F5221;
	Sun, 17 Mar 2024 16:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQuZiE64"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E99936D;
	Sun, 17 Mar 2024 16:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693043; cv=none; b=q+Am6D9OlvlEtSucH9nizV+2vrcX0VsNN9lk1TVqYxt18TAFSPkzkSXvxt6HFzGcqPpB9bjUZBDbc3dnTm/9X6C/gJrc0tr8I5yQ6Vcs8ogX2xsz+HfKXgPrzxaCv1PFZWwF3wDlXNOogmfyQwkW621dyIZWFZD+IUTbUtZocuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693043; c=relaxed/simple;
	bh=HPg0uHo7j99EGWluJBAWme7C4oDdlQfOoK1M8qa1lUg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rz66KAMz+/gVs5XMQL1cpaA0pmh842HK76amfuOTssdzcPtk3RkLM/Lr1fMIhhOnd/rloY7vP923oi57c73oHwlDhqu/18Ip1Z/+drHLgIbgs87aP03eNMglHYVHezHB2oTRu8HaZNezyFREZKR7j+gbeAvYp8jTr3mo2gnuZ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQuZiE64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C4AC433C7;
	Sun, 17 Mar 2024 16:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693042;
	bh=HPg0uHo7j99EGWluJBAWme7C4oDdlQfOoK1M8qa1lUg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=aQuZiE64hpUJaeYbSvPSSYL2P86HDa21Y32xKq2vM4TdZE7zcyZSJzKyV+7xw6ODK
	 AEHllHl3A9ACeCxaLZ+cPd8pfJEZShmh3WDLTB++1mcI5o1Idk+cDISSl1r1C5AeC9
	 iPxDwskHgZ99tyGycLipCYd72oQhzJveiq/b/yKe9x11Au7CohiVw8a7TZ5BILlY3l
	 MZdQNRyBDKsRks/OLU8GRBDdR4Dvuuk06g+lMWEoLPjplG2dpDBgialTf5BV3qPBF/
	 Cs1D01AbYaxYtfKidLnTExRMQ2pFQdFY3wUq5qXCGnfCsb+xoDPJgS37eRlaJrLqwJ
	 QLInjLex8jlfQ==
Date: Sun, 17 Mar 2024 09:30:42 -0700
Subject: [PATCH 28/40] xfs: create an icache tag for files with cached merkle
 tree blocks
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171069246360.2684506.17126297394323595908.stgit@frogsfrogsfrogs>
In-Reply-To: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
References: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create a radix tree tag for the inode cache so that merkle tree block
shrinkers can find verity inodes quickly.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_icache.c |   81 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_icache.h |    8 +++++
 fs/xfs/xfs_trace.h  |   23 ++++++++++++++
 fs/xfs/xfs_verity.c |   30 ++++++++++++++++++-
 fs/xfs/xfs_verity.h |    4 +++
 5 files changed, 145 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index fef77938c718..ad02af0da843 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -35,6 +35,8 @@
 #define XFS_ICI_RECLAIM_TAG	0
 /* Inode has speculative preallocations (posteof or cow) to clean. */
 #define XFS_ICI_BLOCKGC_TAG	1
+/* Inode has incore merkle tree blocks */
+#define XFS_ICI_VERITY_TAG	2
 
 /*
  * The goal for walking incore inodes.  These can correspond with incore inode
@@ -44,6 +46,7 @@ enum xfs_icwalk_goal {
 	/* Goals directly associated with tagged inodes. */
 	XFS_ICWALK_BLOCKGC	= XFS_ICI_BLOCKGC_TAG,
 	XFS_ICWALK_RECLAIM	= XFS_ICI_RECLAIM_TAG,
+	XFS_ICWALK_VERITY	= XFS_ICI_VERITY_TAG,
 };
 
 static int xfs_icwalk(struct xfs_mount *mp,
@@ -1606,6 +1609,7 @@ xfs_icwalk_igrab(
 {
 	switch (goal) {
 	case XFS_ICWALK_BLOCKGC:
+	case XFS_ICWALK_VERITY:
 		return xfs_blockgc_igrab(ip);
 	case XFS_ICWALK_RECLAIM:
 		return xfs_reclaim_igrab(ip, icw);
@@ -1634,6 +1638,9 @@ xfs_icwalk_process_inode(
 	case XFS_ICWALK_RECLAIM:
 		xfs_reclaim_inode(ip, pag);
 		break;
+	case XFS_ICWALK_VERITY:
+		error = xfs_verity_scan_inode(ip, icw);
+		break;
 	}
 	return error;
 }
@@ -1750,6 +1757,80 @@ xfs_icwalk_ag(
 	return last_error;
 }
 
+#ifdef CONFIG_FS_VERITY
+/* Mark this inode as having cached merkle tree blocks */
+void
+xfs_inode_set_verity_tag(
+	struct xfs_inode	*ip)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_perag	*pag;
+
+	pag = xfs_perag_get(mp, XFS_INO_TO_AGNO(mp, ip->i_ino));
+	if (!pag)
+		return;
+
+	spin_lock(&pag->pag_ici_lock);
+	xfs_perag_set_inode_tag(pag, XFS_INO_TO_AGINO(mp, ip->i_ino),
+			XFS_ICI_VERITY_TAG);
+	spin_unlock(&pag->pag_ici_lock);
+	xfs_perag_put(pag);
+}
+
+/* Mark this inode as not having cached merkle tree blocks */
+void
+xfs_inode_clear_verity_tag(
+	struct xfs_inode	*ip)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_perag	*pag;
+
+	pag = xfs_perag_get(mp, XFS_INO_TO_AGNO(mp, ip->i_ino));
+	if (!pag)
+		return;
+
+	spin_lock(&pag->pag_ici_lock);
+	xfs_perag_clear_inode_tag(pag, XFS_INO_TO_AGINO(mp, ip->i_ino),
+			XFS_ICI_VERITY_TAG);
+	spin_unlock(&pag->pag_ici_lock);
+	xfs_perag_put(pag);
+}
+
+/* Walk all the verity inodes in the filesystem. */
+int
+xfs_icwalk_verity(
+	struct xfs_mount	*mp,
+	struct xfs_icwalk	*icw)
+{
+	struct xfs_perag	*pag;
+	xfs_agnumber_t		agno = 0;
+	int			error = 0;
+
+	for_each_perag_tag(mp, agno, pag, XFS_ICWALK_VERITY) {
+		error = xfs_icwalk_ag(pag, XFS_ICWALK_VERITY, icw);
+		if (error)
+			break;
+
+		if ((icw->icw_flags & XFS_ICWALK_FLAG_SCAN_LIMIT) &&
+		    icw->icw_scan_limit <= 0) {
+			xfs_perag_rele(pag);
+			break;
+		}
+	}
+
+	return error;
+}
+
+/* Stop a verity incore walk scan. */
+void
+xfs_icwalk_verity_stop(
+	struct xfs_icwalk	*icw)
+{
+	icw->icw_flags |= XFS_ICWALK_FLAG_SCAN_LIMIT;
+	icw->icw_scan_limit = -1;
+}
+#endif /* CONFIG_FS_VERITY */
+
 /* Walk all incore inodes to achieve a given goal. */
 static int
 xfs_icwalk(
diff --git a/fs/xfs/xfs_icache.h b/fs/xfs/xfs_icache.h
index 905944dafbe5..621ce0078e08 100644
--- a/fs/xfs/xfs_icache.h
+++ b/fs/xfs/xfs_icache.h
@@ -81,4 +81,12 @@ void xfs_inodegc_stop(struct xfs_mount *mp);
 void xfs_inodegc_start(struct xfs_mount *mp);
 int xfs_inodegc_register_shrinker(struct xfs_mount *mp);
 
+#ifdef CONFIG_FS_VERITY
+int xfs_icwalk_verity(struct xfs_mount *mp, struct xfs_icwalk *icw);
+void xfs_icwalk_verity_stop(struct xfs_icwalk *icw);
+
+void xfs_inode_set_verity_tag(struct xfs_inode *ip);
+void xfs_inode_clear_verity_tag(struct xfs_inode *ip);
+#endif /* CONFIG_FS_VERITY */
+
 #endif
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index fa05122a7c4d..91a73399114e 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -4817,6 +4817,29 @@ TRACE_EVENT(xfs_verity_shrinker_count,
 		  __entry->count,
 		  __entry->caller_ip)
 )
+
+TRACE_EVENT(xfs_verity_shrinker_scan,
+	TP_PROTO(struct xfs_mount *mp, unsigned long scanned,
+		 unsigned long freed, unsigned long caller_ip),
+	TP_ARGS(mp, scanned, freed, caller_ip),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned long, scanned)
+		__field(unsigned long, freed)
+		__field(void *, caller_ip)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_super->s_dev;
+		__entry->scanned = scanned;
+		__entry->freed = freed;
+		__entry->caller_ip = (void *)caller_ip;
+	),
+	TP_printk("dev %d:%d scanned %lu freed %lu caller %pS",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->scanned,
+		  __entry->freed,
+		  __entry->caller_ip)
+)
 #endif /* CONFIG_XFS_VERITY */
 
 #endif /* _TRACE_XFS_H */
diff --git a/fs/xfs/xfs_verity.c b/fs/xfs/xfs_verity.c
index 46aa5002e4e1..8d1888353515 100644
--- a/fs/xfs/xfs_verity.c
+++ b/fs/xfs/xfs_verity.c
@@ -226,18 +226,46 @@ xfs_verity_shrinker_count(
 	return min_t(s64, ULONG_MAX, count);
 }
 
+struct xfs_verity_scan {
+	struct xfs_icwalk	icw;
+	struct shrink_control	*sc;
+
+	unsigned long		scanned;
+	unsigned long		freed;
+};
+
+/* Scan an inode as part of a verity scan. */
+int
+xfs_verity_scan_inode(
+	struct xfs_inode	*ip,
+	struct xfs_icwalk	*icw)
+{
+	xfs_irele(ip);
+	return 0;
+}
+
 /* Actually try to reclaim merkle tree blocks. */
 static unsigned long
 xfs_verity_shrinker_scan(
 	struct shrinker		*shrink,
 	struct shrink_control	*sc)
 {
+	struct xfs_verity_scan	vs = {
+		.sc		= sc,
+	};
 	struct xfs_mount	*mp = shrink->private_data;
+	int			error;
 
 	if (!xfs_has_verity(mp))
 		return SHRINK_STOP;
 
-	return 0;
+	error = xfs_icwalk_verity(mp, &vs.icw);
+	if (error)
+		xfs_alert(mp, "%s: verity scan failed, error %d", __func__,
+				error);
+
+	trace_xfs_verity_shrinker_scan(mp, vs.scanned, vs.freed, _RET_IP_);
+	return vs.freed;
 }
 
 /* Register a shrinker so we can release cached merkle tree blocks. */
diff --git a/fs/xfs/xfs_verity.h b/fs/xfs/xfs_verity.h
index 0ec0a61bee65..e1980fc1f149 100644
--- a/fs/xfs/xfs_verity.h
+++ b/fs/xfs/xfs_verity.h
@@ -13,6 +13,9 @@ void xfs_verity_cache_destroy(struct xfs_inode *ip);
 int xfs_verity_register_shrinker(struct xfs_mount *mp);
 void xfs_verity_unregister_shrinker(struct xfs_mount *mp);
 
+struct xfs_icwalk;
+int xfs_verity_scan_inode(struct xfs_inode *ip, struct xfs_icwalk *icw);
+
 extern const struct fsverity_operations xfs_verity_ops;
 #else
 # define xfs_verity_cache_init(ip)		((void)0)
@@ -20,6 +23,7 @@ extern const struct fsverity_operations xfs_verity_ops;
 # define xfs_verity_cache_destroy(ip)		((void)0)
 # define xfs_verity_register_shrinker(mp)	(0)
 # define xfs_verity_unregister_shrinker(mp)	((void)0)
+# define xfs_verity_scan_inode(ip, icw)		(0)
 #endif	/* CONFIG_FS_VERITY */
 
 #endif	/* __XFS_VERITY_H__ */


