Return-Path: <linux-fsdevel+bounces-21945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A132690FBA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 05:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F167F283D37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 03:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8FC2BAE2;
	Thu, 20 Jun 2024 03:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FpGmzYaK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37B32139C7
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2024 03:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718853842; cv=none; b=prNzyVAJWjtpZyPg4DJbcc5A32UJ4bjtgDAQN70+hkQaQQNFWBQxG8+7ooHXqj31Wk6YDWCSoOqQVlZBRPzYZy5Tmwh0yWkGBExE5Fn83cw/FlUwMPzTs4WcoAoKZ4fOJKu6FrXh6wHyelxYLRq0UczkdgsLekKt9JoB0CP/1kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718853842; c=relaxed/simple;
	bh=mEBCIXa5EJ2/Xre+pRcasNn+K2u0XmoKc4bUUj4NvhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qaqeY0wurXfymRc5e7K84GttIVid5gCLrwef5vFVCUNoIgJ1lRveU253GSpDjb51Khmm9/lT5H4SZ36wzgYso2xnEGntAwm4wX1SvSByvqFKWXPxiahLJW6J9oyhc/AC5fzXWW9IrjotAnpK1HtxMQkgss/GZAje1nJTboHcUi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FpGmzYaK; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: viro@zeniv.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718853839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SUmHFYVsSdRNn5kuyX1XQfBw/O2XJKBxeFC/8akhqcc=;
	b=FpGmzYaKBkuMDo7Iq/S0iQT3ZIiFEx5kW+x8bcs0MiYI57ry6AMOyq+TRv5jAD1kBs6EOP
	5wmZSNNZXohmoVrx/q4DXXHe7xJuJktrLHwXwAjdtfdih+WsCyZuBsGQTM3uQ7356ly02p
	sGXcDWAZ7Rmpvo91AFFeSa5dR4IyRLk=
X-Envelope-To: brauner@kernel.org
X-Envelope-To: jaegeuk@kernel.org
X-Envelope-To: chao@kernel.org
X-Envelope-To: miklos@szeredi.hu
X-Envelope-To: jack@suse.cz
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-f2fs-devel@lists.sourceforge.net
X-Envelope-To: youling.tang@linux.dev
X-Envelope-To: tangyouling@kylinos.cn
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH 2/3] f2fs: Use in_group_or_capable() helper
Date: Thu, 20 Jun 2024 11:23:34 +0800
Message-Id: <20240620032335.147136-2-youling.tang@linux.dev>
In-Reply-To: <20240620032335.147136-1-youling.tang@linux.dev>
References: <20240620032335.147136-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

Use the in_group_or_capable() helper function to simplify the code.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 fs/f2fs/acl.c  | 3 +--
 fs/f2fs/file.c | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index ec2aeccb69a3..8bffdeccdbc3 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -219,8 +219,7 @@ static int f2fs_acl_update_mode(struct mnt_idmap *idmap,
 		return error;
 	if (error == 0)
 		*acl = NULL;
-	if (!vfsgid_in_group_p(i_gid_into_vfsgid(idmap, inode)) &&
-	    !capable_wrt_inode_uidgid(idmap, inode, CAP_FSETID))
+	if (!in_group_or_capable(idmap, inode, i_gid_into_vfsgid(idmap, inode)))
 		mode &= ~S_ISGID;
 	*mode_p = mode;
 	return 0;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5c0b281a70f3..7a23434963d1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -923,10 +923,8 @@ static void __setattr_copy(struct mnt_idmap *idmap,
 		inode_set_ctime_to_ts(inode, attr->ia_ctime);
 	if (ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
-		vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
 
-		if (!vfsgid_in_group_p(vfsgid) &&
-		    !capable_wrt_inode_uidgid(idmap, inode, CAP_FSETID))
+		if (!in_group_or_capable(idmap, inode, i_gid_into_vfsgid(idmap, inode)))
 			mode &= ~S_ISGID;
 		set_acl_inode(inode, mode);
 	}
-- 
2.34.1


