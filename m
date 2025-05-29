Return-Path: <linux-fsdevel+bounces-50058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B987FAC7D35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 13:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727F24E646C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 11:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280AD291899;
	Thu, 29 May 2025 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Jwv30oxJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D510A28F538
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748518447; cv=none; b=OLSRWZxj/82RIhe4/7WujiH4CYjXKDSsoEaA/zVIZHB9rIbNQdoJQec9Cy8BNyv4qNLwuvmcHGp1ym9Mt+SimSVyhIulo731WJy+9xOH/a9+NGgnQeNC+IH4PU3ZUsSTa1aneFnmAs+trWzj6s6RiVQB9KGd4jnINMJ9upUNNgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748518447; c=relaxed/simple;
	bh=Xb/J1iAui5g4N9rXo6pak1XQG8uN8N6xTsmezi7DNRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=M/OcZbafpqxt9RPhstL8BAE9jjpEqxi4UPcQj5jC/27ejELC0m7EAWljvmVdX8GSfI9qfVOVnm6euZgy4lQbEBFV9jJBxmY8MlMw4Pkh8JADRFcWer0YfkD5dJ3k1iZmQIQAqIMKGuu7fr+6EV46C+SYCu+gvLe36pxG2AR2ySU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Jwv30oxJ; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250529113403epoutp0111539dd3ecbc15449508645709c89716~D-EK8QA_r2906129061epoutp01Q
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 11:34:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250529113403epoutp0111539dd3ecbc15449508645709c89716~D-EK8QA_r2906129061epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748518443;
	bh=csRq9EOkjvotqyaMSnen4p9GhG5ZXIfAgw7tJJltvyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jwv30oxJUTrMEulLh9JHduU96MUNim4Lc334qXNvAIy81vfUt8xJr4L/0pMwaYHmI
	 LPP15/RPWOZ8eZN5vRljK7MgWM3jGUWXbD+ZtMl0L4RliI6vyxWYecueQBk9R+y1LS
	 JOTHNjAjTZ1r2XCPhoKJZYaQwDkX6MV0U7MP/jQI=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250529113403epcas5p3ecde97960ffa8d7d4d4b45c1779f89fc~D-EKN0Qi20520305203epcas5p37;
	Thu, 29 May 2025 11:34:03 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.183]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4b7PQd68wvz6B9m6; Thu, 29 May
	2025 11:34:01 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250529113245epcas5p2978b77ce5ccf2d620f2a9ee5e796bee3~D-DBs3Xno1680116801epcas5p2Z;
	Thu, 29 May 2025 11:32:45 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250529113245epsmtrp147f2be7878fb2129e7ffc9db6335a65c~D-DBrXzPI2108121081epsmtrp1N;
	Thu, 29 May 2025 11:32:45 +0000 (GMT)
X-AuditID: b6c32a28-46cef70000001e8a-40-683845dd0a77
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1D.41.07818.DD548386; Thu, 29 May 2025 20:32:45 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250529113241epsmtip22d74af2e3aeb73a5e3c829e676ca9719~D-C9x9Brt2194921949epsmtip20;
	Thu, 29 May 2025 11:32:40 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	djwong@kernel.org, dave@stgolabs.net, p.raghav@samsung.com,
	da.gomez@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [PATCH 07/13] writeback: modify sync related functions to iterate
 over all writeback contexts
Date: Thu, 29 May 2025 16:44:58 +0530
Message-Id: <20250529111504.89912-8-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250529111504.89912-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsWy7bCSvO5dV4sMg/s3OSy2rdvNbjFn/Ro2
	iwvrVjNatO78z2LRNOEvs8Xqu/1sFq8Pf2K0OD31LJPFlkv2Fu8vb2OyWH1zDaPFlmP3GC0u
	P+Gz2D39H6vFzQM7mSxWrj7KZDF7ejOTxZP1s5gttn75ympxaZG7xZ69J1ks7q35z2px4cBp
	VosbE54yWjzbvZHZ4vPSFnaLg6c62C0+zQUacv7vcVaL3z/msDnIeZxaJOGxc9Zddo/NK7Q8
	Lp8t9di0qpPNY9OnSeweJ2b8ZvF4sXkmo8fuBZ+ZPHbfbGDzOHexwuP9vqtsHn1bVjF6TJ1d
	73FmwRF2jxXTLjIFCEVx2aSk5mSWpRbp2yVwZTT/TC6YrFBx8qtKA+NVqS5GDg4JAROJtdfY
	uhi5OIQEdjNKzFh4maWLkRMoLiOx++5OVghbWGLlv+fsEEUfGSWWnpjKBtLMJqAr8aMpFCQu
	InCTWeLc2TNgDcwC/xgldr/SAbGFBdIk2jZtZASxWQRUJd5PaGIHsXkFbCX+/73NBLFAXmLm
	pe9gcU4BO4lFS76C1QsB1Sy9uZYFol5Q4uTMJywQ8+UlmrfOZp7AKDALSWoWktQCRqZVjJKp
	BcW56bnJhgWGeanlesWJucWleel6yfm5mxjBaUFLYwfju29N+ocYmTgYDzFKcDArifA22Ztl
	CPGmJFZWpRblxxeV5qQWH2KU5mBREuddaRiRLiSQnliSmp2aWpBaBJNl4uCUamBS+HWY92pP
	kj7fZNNTixVfGfFfW8V6K+RWY02TqsTxeeETA++/kXiw5/Puo3qfvs3xF9Fbejoq3eSZumDN
	zBO23IYebYIMX3lul3r93NDvkvBsyYTHn2pPZgXwmE9XmRjhIiwqN83t6a+fPkuKuf8fCGVb
	trzgyvrHCgtfcOckm8/6edkkzePLEnabza48H7yO6CQzbpx8QLIzJOyNjvCPKaFPD+fc2Lzr
	84Hb9T4rxCJT4nbpaed6lAuFJkUcvcR7Mvrh2q829nrf91wyz+B83Osan3C8RsHJc/2l2943
	GO9HTrvpI9P7tOjzvsdO837qVa6x6O//s4OFm3sX45StMS8nrK3g/BWamTir51ycEktxRqKh
	FnNRcSIAprgQRnoDAAA=
X-CMS-MailID: 20250529113245epcas5p2978b77ce5ccf2d620f2a9ee5e796bee3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250529113245epcas5p2978b77ce5ccf2d620f2a9ee5e796bee3
References: <20250529111504.89912-1-kundan.kumar@samsung.com>
	<CGME20250529113245epcas5p2978b77ce5ccf2d620f2a9ee5e796bee3@epcas5p2.samsung.com>

Modify sync related functions to iterate over all writeback contexts.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/fs-writeback.c | 66 +++++++++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 22 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 9b0940a6fe78..7558b8a33fe0 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2752,11 +2752,13 @@ static void wait_sb_inodes(struct super_block *sb)
 	mutex_unlock(&sb->s_sync_lock);
 }
 
-static void __writeback_inodes_sb_nr(struct super_block *sb, unsigned long nr,
-				     enum wb_reason reason, bool skip_if_busy)
+static void __writeback_inodes_sb_nr_ctx(struct super_block *sb,
+					 unsigned long nr,
+					 enum wb_reason reason,
+					 bool skip_if_busy,
+					 struct bdi_writeback_ctx *bdi_wb_ctx)
 {
-	struct backing_dev_info *bdi = sb->s_bdi;
-	DEFINE_WB_COMPLETION(done, bdi->wb_ctx_arr[0]);
+	DEFINE_WB_COMPLETION(done, bdi_wb_ctx);
 	struct wb_writeback_work work = {
 		.sb			= sb,
 		.sync_mode		= WB_SYNC_NONE,
@@ -2766,13 +2768,23 @@ static void __writeback_inodes_sb_nr(struct super_block *sb, unsigned long nr,
 		.reason			= reason,
 	};
 
+	bdi_split_work_to_wbs(sb->s_bdi, bdi_wb_ctx, &work, skip_if_busy);
+	wb_wait_for_completion(&done);
+}
+
+static void __writeback_inodes_sb_nr(struct super_block *sb, unsigned long nr,
+				     enum wb_reason reason, bool skip_if_busy)
+{
+	struct backing_dev_info *bdi = sb->s_bdi;
+	struct bdi_writeback_ctx *bdi_wb_ctx;
+
 	if (!bdi_has_dirty_io(bdi) || bdi == &noop_backing_dev_info)
 		return;
 	WARN_ON(!rwsem_is_locked(&sb->s_umount));
 
-	bdi_split_work_to_wbs(sb->s_bdi, bdi->wb_ctx_arr[0], &work,
-			      skip_if_busy);
-	wb_wait_for_completion(&done);
+	for_each_bdi_wb_ctx(bdi, bdi_wb_ctx)
+		__writeback_inodes_sb_nr_ctx(sb, nr, reason, skip_if_busy,
+					     bdi_wb_ctx);
 }
 
 /**
@@ -2825,17 +2837,11 @@ void try_to_writeback_inodes_sb(struct super_block *sb, enum wb_reason reason)
 }
 EXPORT_SYMBOL(try_to_writeback_inodes_sb);
 
-/**
- * sync_inodes_sb	-	sync sb inode pages
- * @sb: the superblock
- *
- * This function writes and waits on any dirty inode belonging to this
- * super_block.
- */
-void sync_inodes_sb(struct super_block *sb)
+static void sync_inodes_bdi_wb_ctx(struct super_block *sb,
+				   struct backing_dev_info *bdi,
+				   struct bdi_writeback_ctx *bdi_wb_ctx)
 {
-	struct backing_dev_info *bdi = sb->s_bdi;
-	DEFINE_WB_COMPLETION(done, bdi->wb_ctx_arr[0]);
+	DEFINE_WB_COMPLETION(done, bdi_wb_ctx);
 	struct wb_writeback_work work = {
 		.sb		= sb,
 		.sync_mode	= WB_SYNC_ALL,
@@ -2846,6 +2852,25 @@ void sync_inodes_sb(struct super_block *sb)
 		.for_sync	= 1,
 	};
 
+	/* protect against inode wb switch, see inode_switch_wbs_work_fn() */
+	bdi_down_write_wb_ctx_switch_rwsem(bdi_wb_ctx);
+	bdi_split_work_to_wbs(bdi, bdi_wb_ctx, &work, false);
+	wb_wait_for_completion(&done);
+	bdi_up_write_wb_ctx_switch_rwsem(bdi_wb_ctx);
+}
+
+/**
+ * sync_inodes_sb	-	sync sb inode pages
+ * @sb: the superblock
+ *
+ * This function writes and waits on any dirty inode belonging to this
+ * super_block.
+ */
+void sync_inodes_sb(struct super_block *sb)
+{
+	struct backing_dev_info *bdi = sb->s_bdi;
+	struct bdi_writeback_ctx *bdi_wb_ctx;
+
 	/*
 	 * Can't skip on !bdi_has_dirty() because we should wait for !dirty
 	 * inodes under writeback and I_DIRTY_TIME inodes ignored by
@@ -2855,11 +2880,8 @@ void sync_inodes_sb(struct super_block *sb)
 		return;
 	WARN_ON(!rwsem_is_locked(&sb->s_umount));
 
-	/* protect against inode wb switch, see inode_switch_wbs_work_fn() */
-	bdi_down_write_wb_ctx_switch_rwsem(bdi->wb_ctx_arr[0]);
-	bdi_split_work_to_wbs(bdi, bdi->wb_ctx_arr[0], &work, false);
-	wb_wait_for_completion(&done);
-	bdi_up_write_wb_ctx_switch_rwsem(bdi->wb_ctx_arr[0]);
+	for_each_bdi_wb_ctx(bdi, bdi_wb_ctx)
+		sync_inodes_bdi_wb_ctx(sb, bdi, bdi_wb_ctx);
 
 	wait_sb_inodes(sb);
 }
-- 
2.25.1


