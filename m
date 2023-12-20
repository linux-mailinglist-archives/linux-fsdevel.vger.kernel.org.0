Return-Path: <linux-fsdevel+bounces-6552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F42819804
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 06:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9AE0B25070
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 05:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491A2101CC;
	Wed, 20 Dec 2023 05:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="F7vQCM3q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6BFFBE1
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 05:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C3eSDKiUv5sWs9ASgYM7qzaFLx45n/vgCwoB9oXDBEg=; b=F7vQCM3qeLrA69eSrMjLLzxPCu
	5pe5m0qJDJpj7P2azy7ToFkoqrqdLvnPtkgpUT2ObpsP4SgI+frOe7O5KxaGy+/a+/kjMcThkMcVk
	NF7Hqm6EyhSE7ZhJFRetEh+aT+Fp6TaacUX098Wed8vzYZ+47CrsRevuTQHJK5xi1hqhxJETZW5Vt
	wHX/PsJNDOPuKUoRxU27JCrVCAtJ6lErQxWXJNKOLTG4QoUzrttpRyszuEzsqvs3oIqMk9VcISEqV
	6RK6wcUgYFUb8K4XSUswRmuUheAMP3IZF+ST+BPq+vAvTK6NdNwIoCkeB1uM4XPgDxWPNqZi+SwFk
	xEnuPPng==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFoz5-00HIgQ-1Z;
	Wed, 20 Dec 2023 05:19:07 +0000
Date: Wed, 20 Dec 2023 05:19:07 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 05/22] affs: d_obtain_alias(ERR_PTR(...)) will do the right
 thing
Message-ID: <20231220051907.GD1674809@ZenIV>
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
 fs/affs/namei.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/affs/namei.c b/fs/affs/namei.c
index d6b9758ee23d..8c154490a2d6 100644
--- a/fs/affs/namei.c
+++ b/fs/affs/namei.c
@@ -532,9 +532,6 @@ static struct dentry *affs_get_parent(struct dentry *child)
 	parent = affs_iget(child->d_sb,
 			   be32_to_cpu(AFFS_TAIL(child->d_sb, bh)->parent));
 	brelse(bh);
-	if (IS_ERR(parent))
-		return ERR_CAST(parent);
-
 	return d_obtain_alias(parent);
 }
 
-- 
2.39.2


