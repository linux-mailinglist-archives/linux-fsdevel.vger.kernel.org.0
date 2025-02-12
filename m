Return-Path: <linux-fsdevel+bounces-41584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D17A32699
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 14:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26484167302
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 13:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F388620E033;
	Wed, 12 Feb 2025 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Dvdbv2Iz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC4120E02B
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739365694; cv=none; b=lu+EErEWPj3oUHRn7a6+Nfg9QX9X+SfyR3BBH9brSZf/uiZGnzUe1lL0Ixjz8rU0AGropRRqP8eYOsF0mSJ/Gpkd0A0GnUcRW2MyHPVO9rH3Y1VjTL4BIHhrJC48y8emigigX5uDpJirR9dZ8U4SRcwVXe8wdXGdC2H6q/A64Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739365694; c=relaxed/simple;
	bh=x9K8wQWcgb3UzNoz7yptTroZnUnpoGhEnw7SRndxql0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=TVUIxqO7JQV/nK7waAsk/c5HHschZpnP9C0OJDDb3CJkNtEtVfgN+POSmP1nwUbb69GCU7JLshcfDo/2GsotIqmIOANCn0HbxpaYv8jXVIHKkmIMYAYOSX0yjVRIYRQ9U8aK1hsg7cnRaPIRP2MB3Cpm+Tf1PlK4UxgfgbMA+3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Dvdbv2Iz; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250212130809epoutp012a63ed4b9946de4c4b2bbef0ea713568~jd_EM_SeH0744007440epoutp01W
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 13:08:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250212130809epoutp012a63ed4b9946de4c4b2bbef0ea713568~jd_EM_SeH0744007440epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739365689;
	bh=QHSnwKEqa65cn5MVlaQSjV3Q2tlGruHr+768Q6dM8Ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dvdbv2IzQBc74FBXp1enZjRTL9piNNu/gS2jDvJE14NLzo+KYlMaYlTq0jpG4mHqB
	 ad9E5fK7NyupKQ0cRKrJYYO86my7KopNd8Uz6O12PMHfqGP5zZk4cfulQjobL6fjX0
	 B3L5qnIYg8wcUqOJV87/Gw3XZDXZnSKWKI4WaYsk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250212130808epcas5p4f37e2a66beb093a30cb771526e6454a1~jd_Dma2gp0312403124epcas5p4T;
	Wed, 12 Feb 2025 13:08:08 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4YtJX72QG9z4x9Pw; Wed, 12 Feb
	2025 13:08:07 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BF.04.19710.73D9CA76; Wed, 12 Feb 2025 22:08:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250212104515epcas5p38e8c9bee03f92be1bda53cbf8f84e0fd~jcBSmwi3u3080630806epcas5p3w;
	Wed, 12 Feb 2025 10:45:15 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250212104515epsmtrp1d826fc79272d2aaf7620af513e718a2c~jcBSli7vj0677206772epsmtrp1E;
	Wed, 12 Feb 2025 10:45:15 +0000 (GMT)
X-AuditID: b6c32a44-363dc70000004cfe-69-67ac9d37db1d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DA.36.18949.ABB7CA76; Wed, 12 Feb 2025 19:45:14 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250212104512epsmtip2a89e03e0562da4df2a2e1b3b0f398877~jcBQexvEI1784617846epsmtip2a;
	Wed, 12 Feb 2025 10:45:12 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: david@fromorbit.com, mcgrof@kernel.org, jack@suse.cz, hch@lst.de
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	anuj20.g@samsung.com, axboe@kernel.dk, clm@meta.com, willy@infradead.org,
	gost.dev@samsung.com, vishak.g@samsung.com, amir73il@gmail.com,
	brauner@kernel.org, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [RFC 3/3] xfs: use the parallel writeback infra per AG
Date: Wed, 12 Feb 2025 16:06:34 +0530
Message-Id: <20250212103634.448437-4-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250212103634.448437-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNJsWRmVeSWpSXmKPExsWy7bCmlq753DXpBo+f8VhcWLea0aJpwl9m
	i9V3+9ksXh/+xGix5ZK9xZZj9xgtbh7YyWSxcvVRJovZ05uZLLZ++cpqsWfvSRaLXX92sFvc
	mPCU0eL8rDnsFr9/zGFz4Pc4tUjCY+esu+wem1doeVw+W+qxaVUnm8fumw1sHucuVnj0bVnF
	6HFmwRF2j8+b5AK4orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22V
	XHwCdN0yc4BeUFIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevl
	pZZYGRoYGJkCFSZkZ1x5eIKp4IN2xdM1E5kbGGcodzFyckgImEgs3vuStYuRi0NIYDejRMPW
	01DOJ0aJZVv3sIFUCQl8A3LOB3YxcoB13GgQg6jZyyhxc2kPC4TzmVFie8d2dpAiNgFdiR9N
	oSC9IgIuEoeW94ENZRboZJJ4v3UH2FBhAXuJ/bfWsoPYLAKqEn39W8HivAJ2EmvaZrFAnCcv
	MfPSd7AaTqD6HW8ns0PUCEqcnPkErIYZqKZ562xmkAUSAgc4JDq3zWOHaHaReNn+FcoWlnh1
	fAuULSXxsr8Nys6WONS4gQnCLpHYeaQBKm4v0XqqnxnkGWYBTYn1u/QhwrISU0+tY4LYyyfR
	+/sJVCuvxI55MLaaxJx3U6Hul5FYeGkGVNxDYufaV4yQwJrEKPHj9jGmCYwKs5D8MwvJP7MQ
	Vi9gZF7FKJlaUJybnppsWmCYl1oOj+Tk/NxNjOBUreWyg/HG/H96hxiZOBgPMUpwMCuJ8EpM
	W5MuxJuSWFmVWpQfX1Sak1p8iNEUGOATmaVEk/OB2SKvJN7QxNLAxMzMzMTS2MxQSZy3eWdL
	upBAemJJanZqakFqEUwfEwenVANTjwtzs8ril8tXB+XPuqudt3l9T1CQxfqaaZOKXHiLN520
	fGUpn5j8elIB48mwSZzLJyW59E5UTnNwvSlQ/+S16qnn8v26pwtYuMVXmgUw7r609Kh2jENt
	YsKeJLHDZ2+q6V4pd+yw9zc4kGzWPrcsIzF+iXK4wqLbey2kzG/E+jQxrEt6vIpZwPDQlFUv
	Xpz5fatC1mX95YV2ms1ujc/duR4kfv6rsuVxs8sehRlPnAN+bPF5a9pRIfXj8Z9p83WLr+ap
	+2jMKL2+kG+934z9Wa6fG66rPz8gobXwsPm7yqdn5/HfmDTNnMfMMkVDQeuUdaGk+JXjVd5J
	9etzZZ/1e+hHG3KGqrcKuyzWC1NiKc5INNRiLipOBACbTSWgXgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42LZdlhJXndX9Zp0g6MnLS0urFvNaNE04S+z
	xeq7/WwWrw9/YrTYcsneYsuxe4wWNw/sZLJYufook8Xs6c1MFlu/fGW12LP3JIvFrj872C1u
	THjKaHF+1hx2i98/5rA58HucWiThsXPWXXaPzSu0PC6fLfXYtKqTzWP3zQY2j3MXKzz6tqxi
	9Diz4Ai7x+dNcgFcUVw2Kak5mWWpRfp2CVwZVx6eYCr4oF3xdM1E5gbGGcpdjBwcEgImEjca
	xLoYuTiEBHYzSizp3MTWxcgJFJeR2H13JyuELSyx8t9zdhBbSOAjo8T0Ix4gvWwCuhI/mkJB
	wiICXhIXN31gB5nDLDCdSWLKlvNg9cIC9hL7b60Fs1kEVCX6+reCzecVsJNY0zaLBWK+vMTM
	S9/BajiB6ne8nQy1y07iz7s77BD1ghInZz4Bq2cGqm/eOpt5AqPALCSpWUhSCxiZVjFKphYU
	56bnFhsWGOWllusVJ+YWl+al6yXn525iBMeSltYOxj2rPugdYmTiYDzEKMHBrCTCa7JwRboQ
	b0piZVVqUX58UWlOavEhRmkOFiVx3m+ve1OEBNITS1KzU1MLUotgskwcnFINTP3+3q5ZUvIM
	rE/dZ4h6beNrsp+j5/7G8eDPnq8x+yQvxGWE/L2v01mf/VD7XPD00o8+Pd8chU6p9K232Z33
	ZgKH1Fy7p/3KNibL2NvXKXvN/2hyoIL9SMOUvQ8X1PDyzo/U+83v4WR33DBTpmlmyY5tb7IU
	5k9W+p1zyWq7xHXR/d42KeaMk8oXOeZ6C8zeeEZPSu7D+VDfSe+WmAWsP7T5b1Ti/XO/dvsf
	1VGq0r/8e9Fq5SlMEx8cW/ejVTpa2Nzmp4Bx183nURxn1AymTN9oHS52Yr0vi3NMt3e3ukha
	gV6Js636tIv7T54ou9Wq76BwqVbotb/WPJv74dyy8zliUmpupjNaPz83x69ZiaU4I9FQi7mo
	OBEA9gk+kRQDAAA=
X-CMS-MailID: 20250212104515epcas5p38e8c9bee03f92be1bda53cbf8f84e0fd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250212104515epcas5p38e8c9bee03f92be1bda53cbf8f84e0fd
References: <20250212103634.448437-1-kundan.kumar@samsung.com>
	<CGME20250212104515epcas5p38e8c9bee03f92be1bda53cbf8f84e0fd@epcas5p3.samsung.com>

The bdi_writeback now provides NR_WB_CTX number of writeback contexts
stored in the wb_ctx_list. This allows each allocation group in xfs to
utilize a distinct writeback context. To implement this, the following
changes have been made:
- Adjust xfs to assign a unique writeback context to each allocation group.
- Include a super_operations function pointer within super_operations to
retrieve the writeback context associated with an inode. Currently it is
implemented by xfs. It can be extended to other FS in future.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/fs-writeback.c      | 34 ++++++++++++++++++++++------------
 fs/xfs/libxfs/xfs_ag.c | 16 ++++++++++++++++
 fs/xfs/libxfs/xfs_ag.h |  1 +
 fs/xfs/xfs_super.c     | 20 ++++++++++++++++++++
 include/linux/fs.h     |  1 +
 5 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 8f7dd5d10085..75a6f5c50ee7 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2712,7 +2712,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 		 */
 		if (!was_dirty) {
 			/* Schedule writeback on first wb_ctx */
-			struct wb_ctx *p_wb_ctx = ctx_wb_struct(wb, 0);
+			struct wb_ctx *p_wb_ctx;
 			struct list_head *dirty_list;
 			bool wakeup_bdi = false;
 
@@ -2720,17 +2720,27 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 			if (dirtytime)
 				inode->dirtied_time_when = jiffies;
 
-
-			if (inode->i_state & I_DIRTY)
-				dirty_list = ctx_b_dirty_list(wb, 0);
-			else
-				dirty_list = ctx_b_dirty_time_list(wb,
-								   0);
-
-			wakeup_bdi = inode_io_list_move_locked_ctx(inode, wb,
-								   dirty_list,
-								   p_wb_ctx);
-
+			if (!sb->s_op->get_wb_ctx) {
+				p_wb_ctx = ctx_wb_struct(wb, 0);
+
+				if (inode->i_state & I_DIRTY)
+					dirty_list = ctx_b_dirty_list(wb, 0);
+				else
+					dirty_list = ctx_b_dirty_time_list(wb,
+									   0);
+				wakeup_bdi = inode_io_list_move_locked_ctx(inode, wb,
+									   dirty_list,
+									   p_wb_ctx);
+			} else {
+				p_wb_ctx = sb->s_op->get_wb_ctx(inode);
+				if (inode->i_state & I_DIRTY)
+					dirty_list = &p_wb_ctx->pctx_b_dirty;
+				else
+					dirty_list = &p_wb_ctx->pctx_b_dirty_time;
+				wakeup_bdi = inode_io_list_move_locked_ctx(inode, wb,
+									   dirty_list,
+									   p_wb_ctx);
+			}
 			spin_unlock(&wb->list_lock);
 			spin_unlock(&inode->i_lock);
 			trace_writeback_dirty_inode_enqueue(inode);
diff --git a/fs/xfs/libxfs/xfs_ag.c b/fs/xfs/libxfs/xfs_ag.c
index b59cb461e096..5d6551e5522e 100644
--- a/fs/xfs/libxfs/xfs_ag.c
+++ b/fs/xfs/libxfs/xfs_ag.c
@@ -214,6 +214,11 @@ xfs_update_last_ag_size(
 	return 0;
 }
 
+static struct backing_dev_info *xfs_mp_to_bdi(struct xfs_mount *mp)
+{
+	return mp->m_super->s_bdi;
+}
+
 static int
 xfs_perag_alloc(
 	struct xfs_mount	*mp,
@@ -221,12 +226,22 @@ xfs_perag_alloc(
 	xfs_agnumber_t		agcount,
 	xfs_rfsblock_t		dblocks)
 {
+	struct backing_dev_info *bdi = xfs_mp_to_bdi(mp);
+	struct bdi_writeback *wb = &bdi->wb;
+	struct wb_ctx *p_wb_ctx;
 	struct xfs_perag	*pag;
 	int			error;
 
 	pag = kzalloc(sizeof(*pag), GFP_KERNEL);
 	if (!pag)
 		return -ENOMEM;
+	spin_lock(&wb->list_lock);
+	if (wb->wb_idx >= NR_WB_CTX)
+		wb->wb_idx = 0;
+	p_wb_ctx = &wb->wb_ctx_list[wb->wb_idx];
+	wb->wb_idx++;
+	spin_unlock(&wb->list_lock);
+	pag->pag_wb_ctx = p_wb_ctx;
 
 #ifdef __KERNEL__
 	/* Place kernel structure only init below this point. */
@@ -261,6 +276,7 @@ xfs_perag_alloc(
 	return error;
 }
 
+
 int
 xfs_initialize_perag(
 	struct xfs_mount	*mp,
diff --git a/fs/xfs/libxfs/xfs_ag.h b/fs/xfs/libxfs/xfs_ag.h
index 1f24cfa27321..5c25850e94dd 100644
--- a/fs/xfs/libxfs/xfs_ag.h
+++ b/fs/xfs/libxfs/xfs_ag.h
@@ -89,6 +89,7 @@ struct xfs_perag {
 
 	/* background prealloc block trimming */
 	struct delayed_work	pag_blockgc_work;
+	struct wb_ctx		*pag_wb_ctx;
 #endif /* __KERNEL__ */
 };
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index d92d7a07ea89..7416e1ad45e9 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1210,6 +1210,25 @@ xfs_fs_shutdown(
 	xfs_force_shutdown(XFS_M(sb), SHUTDOWN_DEVICE_REMOVED);
 }
 
+static struct wb_ctx *
+		xfs_get_wb_ctx(
+		struct inode *inode)
+{
+	struct xfs_inode *xfs_inode = XFS_I(inode);
+	struct xfs_perag *pag = xfs_perag_get(xfs_inode->i_mount,
+			XFS_INO_TO_AGNO(xfs_inode->i_mount, xfs_inode->i_ino));
+	struct wb_ctx *p_wb_ctx;
+
+	if (!pag) {
+		/* There had better still be a perag structure! */
+		ASSERT(0);
+		return NULL;
+	}
+	p_wb_ctx = pag->pag_wb_ctx;
+	xfs_perag_put(pag);
+	return p_wb_ctx;
+}
+
 static const struct super_operations xfs_super_operations = {
 	.alloc_inode		= xfs_fs_alloc_inode,
 	.destroy_inode		= xfs_fs_destroy_inode,
@@ -1224,6 +1243,7 @@ static const struct super_operations xfs_super_operations = {
 	.nr_cached_objects	= xfs_fs_nr_cached_objects,
 	.free_cached_objects	= xfs_fs_free_cached_objects,
 	.shutdown		= xfs_fs_shutdown,
+	.get_wb_ctx		= xfs_get_wb_ctx,
 };
 
 static int
diff --git a/include/linux/fs.h b/include/linux/fs.h
index be3ad155ec9f..4f655daeb97f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2307,6 +2307,7 @@ struct super_operations {
 	long (*free_cached_objects)(struct super_block *,
 				    struct shrink_control *);
 	void (*shutdown)(struct super_block *sb);
+	struct wb_ctx *(*get_wb_ctx)(struct inode *);
 };
 
 /*
-- 
2.25.1


