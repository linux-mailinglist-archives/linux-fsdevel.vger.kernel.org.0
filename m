Return-Path: <linux-fsdevel+bounces-6556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23A081980C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 06:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF14288350
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 05:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC6FFC07;
	Wed, 20 Dec 2023 05:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="GBoQlPm+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018B4FBE1
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 05:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XIFKQZ720lRS+CHD+TPF/10UZvfKVPTa9e6d2p8Kb0U=; b=GBoQlPm+n5KhHXvtBcR85+SszF
	NnIyVbGbTE4DEmUUs1+MxQLOqiiT/jtLW/hXO+aWiAPzo7CSs7JePw555Q+vx1wqMvCc33uOOhSiv
	WqnYG4Ywi3sMnLjYDSbndcD2mTzFDfPVt2O1waazK+0LF4tcRCVD3RCChYnBPaLKPYPwuz9SlMf60
	qyLRs3n3FmCiJXPt1a9On2tdFw4F7Ph4W2IzLIUrvgbQygf+Kfieuu07AthP6MtwoAIMMWxSzIO+r
	JmGqPPx1Ls5MgIth/3j2Y+845PGkGj0jBHXIB9af4BIUNS9C9xat0kOWjlrWAtHnp1szj0bIBjYp2
	Nz+lFGBA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFp2L-00HIth-2H;
	Wed, 20 Dec 2023 05:22:29 +0000
Date: Wed, 20 Dec 2023 05:22:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 09/22] kernfs: d_obtain_alias(NULL) will do the right thing...
Message-ID: <20231220052229.GH1674809@ZenIV>
References: <20231220051348.GY1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220051348.GY1674809@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/kernfs/mount.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 4628edde2e7e..0c93cad0f0ac 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -125,9 +125,6 @@ static struct dentry *__kernfs_fh_to_dentry(struct super_block *sb,
 
 	inode = kernfs_get_inode(sb, kn);
 	kernfs_put(kn);
-	if (!inode)
-		return ERR_PTR(-ESTALE);
-
 	return d_obtain_alias(inode);
 }
 
-- 
2.39.2


