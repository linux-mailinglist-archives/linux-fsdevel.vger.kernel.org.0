Return-Path: <linux-fsdevel+bounces-19023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD568BF680
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 08:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70511C21768
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 06:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FA42BB1E;
	Wed,  8 May 2024 06:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="p6vZGQ/l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCBD1A2C15
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 06:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150698; cv=none; b=MTvftP/RWeUVfyrTZ/1chQkBVvkoCgYF1jAzOB31ejGbzilAiovPUMSQung7FWrtcEX5NLrUIPxZliFAHAfRmdmpJMz/PeQrTT4DIOZhpBn6TkY5aBrWEplctv9RmzPFwe+VIoQ7qsUQmK6wyVXtXNfe4kIftFFv+xG0MMXpVjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150698; c=relaxed/simple;
	bh=MbFGJZsoUie09ejtQdOaQOLMs9sVL9/MHn4KDAkOlXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XZMmL4Q6YHWLAi6S5YPzmtseCDIm7XtXZlmwEd7PkF1NjYII0t2+cZnr5nFczNF/R15O6YvehPS7B8rm32UzBA8EsjrymxCkRPQvT0claqIDY8bzFNDnVRT+lFRbHRWnF5liP9zu5mzEzNyiE8eN99ru6KeT/eO8zP/yC8pGvck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=p6vZGQ/l; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JiVzcE8aitJvb1A5Jhb079v0Gu3QjxFcqqU12TZlZeE=; b=p6vZGQ/lMHdoTmeEURsur2umJc
	/2lBEkudaogtzDF+AApT8JXLb7+3hSRA0z/sWVkVR/no390OvPydxJej85QUHgBOyoinzXzYm1rvh
	hCUSoXY/eOYN9PJ6qlBdsD/KeMIII2tqAMbQGrfnmsyaWLH9/5JoBpDt8Jz4UCdTfw0He5ngvWHpo
	xHMZKEG/yNc2QdMJbo1tBps2PB86YpCRXmWqVAtlJsGqKyUBC1Kmx5So/ejDqafMdCevUAcJZ/2fu
	4etwONvkK3JxN47BThVubcpI0kbOFNFTLJ0FVLOIMZ383wjFNmRBR2+O4r8gttNkvuObEsNYQui03
	7Xs1cU8w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s4b2r-00Fvzx-2h;
	Wed, 08 May 2024 06:44:53 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk,
	brauner@kernel.org,
	hch@lst.de
Subject: [PATCHES part 2 08/10] nilfs_attach_log_writer(): use ->bd_mapping->host instead of ->bd_inode
Date: Wed,  8 May 2024 07:44:50 +0100
Message-Id: <20240508064452.3797817-8-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240508064452.3797817-1-viro@zeniv.linux.org.uk>
References: <20240508063522.GO2118490@ZenIV>
 <20240508064452.3797817-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

I suspect that inode_attach_wb() use is rather unidiomatic, but
that's a separate story - in any case, its use is a few times
per mount *and* the route by which we access that inode is
"the host of address_space a page belongs to".

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nilfs2/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index aa5290cb7467..15188e799580 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2790,7 +2790,7 @@ int nilfs_attach_log_writer(struct super_block *sb, struct nilfs_root *root)
 	if (!nilfs->ns_writer)
 		return -ENOMEM;
 
-	inode_attach_wb(nilfs->ns_bdev->bd_inode, NULL);
+	inode_attach_wb(nilfs->ns_bdev->bd_mapping->host, NULL);
 
 	err = nilfs_segctor_start_thread(nilfs->ns_writer);
 	if (unlikely(err))
-- 
2.39.2


