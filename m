Return-Path: <linux-fsdevel+bounces-62385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC71B9068B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 13:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175694207DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 11:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0350C3074A0;
	Mon, 22 Sep 2025 11:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QHAjxROX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DED306B32
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758540719; cv=none; b=cmQkh+PzY60ENUhCnXasamClKTEW5IUWfIpOigib9tDEb5rTxsDCzr/EbXZr+tfuig5I2cYWBI+Ldu+rFJGPcM8TZhPCB6T52UIlP+6GxhdsqHSmMy4bUCSjCCZWeZSYYylXrkIycht37ilUu5VAVoho7k3RAT/WEBHCgA/kVIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758540719; c=relaxed/simple;
	bh=q6bAgu+vulTA9LgiunEaoamykuiyQ1IQkyXbIcFXJDY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=S+Unv38+G2t5Hb5/RyjAUweofJXSl2Gx36nlRe6TbI0rGs1plx1FtUwnrRbOTFFL5iDyDeLRw9qTg7CwXACA6AHQG8i+QyYkiNkpenJRIQyO8W1W9dMmLBMBXx/2cKXp+Khn9J16Tq9cT1Q+AC4q1j8grN5F/Vd2gBtFkRF2Bcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QHAjxROX; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250922113154epoutp02f4eeee92ca28051356ceeaadf8e1b0f9~nl3aFanDz0142201422epoutp02W
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 11:31:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250922113154epoutp02f4eeee92ca28051356ceeaadf8e1b0f9~nl3aFanDz0142201422epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758540714;
	bh=pIlFZR5+Y/pUPAgxGdwLlUoifw65ZzOod/X1VLbs1LE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=QHAjxROXyKhjZXomyB3OFJT/sx7J7Pr79GPMv5a8q2uG5I+Xh30OgfU/U7LEPnWYV
	 +VJuyg8n/8IRnfgF6dWZ0tn9vXfZFrN23AOHkYMTPRYFTg2wfugAUwQOLMUMZ/OF1S
	 rMDsXcm0K4DAWdDBaCYWdTiaOd9n7EAcOXjuu1+o=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250922113154epcas5p4093fcd46bb6be1e258ec227dc29a1740~nl3Zt-3h10315303153epcas5p4B;
	Mon, 22 Sep 2025 11:31:54 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.90]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cVgtd3Cyhz2SSKX; Mon, 22 Sep
	2025 11:31:53 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250922113152epcas5p2d3aa052da211b541e0182c94b1ba510f~nl3X0EccP2350523505epcas5p2U;
	Mon, 22 Sep 2025 11:31:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250922113149epsmtip11106dcf9f4bf2cfde24ac106972c46e0~nl3U6SvPs1942119421epsmtip1G;
	Mon, 22 Sep 2025 11:31:48 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, jack@suse.cz, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH] fcntl: trim arguments
Date: Mon, 22 Sep 2025 17:00:46 +0530
Message-Id: <20250922113046.1037921-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250922113152epcas5p2d3aa052da211b541e0182c94b1ba510f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250922113152epcas5p2d3aa052da211b541e0182c94b1ba510f
References: <CGME20250922113152epcas5p2d3aa052da211b541e0182c94b1ba510f@epcas5p2.samsung.com>

Remove superfluous argument from fcntl_{get/set}_rw_hint.
No functional change.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 fs/fcntl.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 5598e4d57422..72f8433d9109 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -355,8 +355,7 @@ static bool rw_hint_valid(u64 hint)
 	}
 }
 
-static long fcntl_get_rw_hint(struct file *file, unsigned int cmd,
-			      unsigned long arg)
+static long fcntl_get_rw_hint(struct file *file, unsigned long arg)
 {
 	struct inode *inode = file_inode(file);
 	u64 __user *argp = (u64 __user *)arg;
@@ -367,8 +366,7 @@ static long fcntl_get_rw_hint(struct file *file, unsigned int cmd,
 	return 0;
 }
 
-static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
-			      unsigned long arg)
+static long fcntl_set_rw_hint(struct file *file, unsigned long arg)
 {
 	struct inode *inode = file_inode(file);
 	u64 __user *argp = (u64 __user *)arg;
@@ -547,10 +545,10 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		err = memfd_fcntl(filp, cmd, argi);
 		break;
 	case F_GET_RW_HINT:
-		err = fcntl_get_rw_hint(filp, cmd, arg);
+		err = fcntl_get_rw_hint(filp, arg);
 		break;
 	case F_SET_RW_HINT:
-		err = fcntl_set_rw_hint(filp, cmd, arg);
+		err = fcntl_set_rw_hint(filp, arg);
 		break;
 	default:
 		break;
-- 
2.25.1


