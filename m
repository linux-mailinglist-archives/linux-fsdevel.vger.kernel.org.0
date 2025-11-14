Return-Path: <linux-fsdevel+bounces-68552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26813C5F87C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 23:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0968A4E12D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 22:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4373330C374;
	Fri, 14 Nov 2025 22:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTxBAOQX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E839261393;
	Fri, 14 Nov 2025 22:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763160337; cv=none; b=WG2wAPBB3aFJDdWCmSXmIoVBLcpWFdbm7i/xI5nEnviNUuoxkvXT4m2E7i/3ed014rAj/sEYZgMr1wYw67+HpCluGRw09zISfYwBtEkojKjGMa2ahSSB/Pyt82rtexIh2MlHsGKfwxK1nNfWXxKupiZQlZChmpJl9EZ4oY1a5tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763160337; c=relaxed/simple;
	bh=wOBrryumpV+jzVgpVOqBPg+fW6SNfel+JBJOtcf66aY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KCM10Yel/ccSA94K+qzg0MnBiQDmNX0QCUTIJjrjTBka8YmmxKjblbNmrl9OEkD2VAdZraJxsMbntVY//9b1HEw6mkTi6AQW/OFjj1jZVTqshwMU2fsJ8scFgMByRKjvw3aupNej0djNK27w16GqzYefruXe95a1GISe/pH11qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTxBAOQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B4EC116D0;
	Fri, 14 Nov 2025 22:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763160337;
	bh=wOBrryumpV+jzVgpVOqBPg+fW6SNfel+JBJOtcf66aY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OTxBAOQX/mMQUScFbVJpoM5Ujo9hW1wCJtWM1S/y3IA+7byAJ6C4+yxrs9FS0jgiw
	 IbJgVGvVPqviZp9OQKQp5lEJJtCyn5JfTbxFx5h4qTbHSJ9b0SSaPDgpuEHfmTV49n
	 9FiStp2/xu1Ghv4Vr1b/sRw78YuWj6P/uP9jAWNT8jmX0uOBRti1qhE7Jxf71fygxU
	 ZCWIIVqi2noHMKGq7K2ij/RhLI7uX9ml7uJy4eyDtpGTvz/B2i0EFCp09a0vq1HQ+0
	 J5Rd2Sq/IoRdWwnoR+QjVEsFQ/uCergPIQ8paI863NwvWO7UxtfewpgSGafZu0QvsE
	 geIwCU3/khueQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 14 Nov 2025 23:45:25 +0100
Subject: [PATCH 4/5] ovl: port ovl_copy_up_tmpfile() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-work-ovl-cred-guard-copyup-v1-4-ea3fb15cf427@kernel.org>
References: <20251114-work-ovl-cred-guard-copyup-v1-0-ea3fb15cf427@kernel.org>
In-Reply-To: <20251114-work-ovl-cred-guard-copyup-v1-0-ea3fb15cf427@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1062; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wOBrryumpV+jzVgpVOqBPg+fW6SNfel+JBJOtcf66aY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKb+RQPtQ/+1VtYenHAPOOLf/DTdb8N/ytoH9Q9blzI
 PP2eMPKjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImszGT4X/+7RYV1ZrT1BnXN
 ZcX7lxo1fV03SYLNfpf1AYHrE0Jv8TMyrLgzs+9zUNscueays5Gv//eeyPTXW+r6vXI1Y1R5p3E
 GCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Remove the complicated struct ovl_cu_creds dance and use our new copy up
cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/copy_up.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 9acc1549d46d..2176903d4538 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -892,17 +892,17 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 	struct inode *udir = d_inode(c->destdir);
 	struct dentry *temp, *upper;
 	struct file *tmpfile;
-	struct ovl_cu_creds cc;
 	int err;
 
-	err = ovl_prep_cu_creds(c->dentry, &cc);
-	if (err)
-		return err;
+	scoped_class(copy_up_creds, copy_up_creds, c->dentry) {
+		if (IS_ERR(copy_up_creds))
+			return PTR_ERR(copy_up_creds);
 
 		ovl_start_write(c->dentry);
 		tmpfile = ovl_do_tmpfile(ofs, c->workdir, c->stat.mode);
 		ovl_end_write(c->dentry);
-	ovl_revert_cu_creds(&cc);
+	}
+
 	if (IS_ERR(tmpfile))
 		return PTR_ERR(tmpfile);
 

-- 
2.47.3


