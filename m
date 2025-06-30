Return-Path: <linux-fsdevel+bounces-53246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358D4AED28D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7B23B5122
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761561B412A;
	Mon, 30 Jun 2025 02:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gAr+yfA9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E02417A30B
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251979; cv=none; b=GKrGYgOGhPqj/gjK1anMohy1qUNOSQnzOXGFbs1XQJnQvxC+eRViY5svEsyTEnj3H8REnCPryTwNtSvSPbQESJ2sZsMhl61+ec1huiS8b/nvrJC7gIyljap3AVhyQQ8PSOgbNvBvQKl4s9Dw7M24nA161PYNd97kZLPr4KmS93M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251979; c=relaxed/simple;
	bh=v1T1IOh4wkJRp9oc2k3e7VE3Lcq9afvwXVeUpJ/yoVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHLo5OFAO3GmIMfb8DZSHjcedtGaWf/LSxf2Ij2rhFbjQaJWZxajJxgmsyjZ2PRy6GFeFoapOdh6zizWCd1b0iQVBKgo9yTBVLxYgC9NJt2vpIVR3mp86hqJsyAfF7IU6wU5SqeuifmzHDO0TTC4yZpNjJ1xJMAtanoBgYlZuV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gAr+yfA9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=TrmwYul+R7YZ6Y1I5yaiSBOEn4I41xC3rxTKhWFETzw=; b=gAr+yfA9J/shDbruyhGfS/bsp2
	m4s2r6/zOC2XEDz9fbobXK4safmDN8bRkLA3XDxfdp3XXV06uv4+NpC/w3yMkXlvgduMv7f4+2VBO
	QKxFfgfEXauha+ZWEM1tlFxQ4FaLrR+SG96koERkPbrzSa+iU/kv1HrxUS4a1N8l8+utOY2M1tCLn
	w0wSwhnxkpXoawPgivhupTZBqxvSDMQXsY4HmIWmAbi7daQHdxOhSbcI3uoorGb7SoBLJXWJfjq62
	m7ihOzQeljerMsvEMIdJhVBsF/IzKigLRCKOZLB0NfQF75yn9RvUV6jas4DEYm4FZFW3PMFQLgNHJ
	PlUssJag==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4db-00000005ow6-3WMI;
	Mon, 30 Jun 2025 02:52:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 04/48] copy_tree(): don't set ->mnt_mountpoint on the root of copy
Date: Mon, 30 Jun 2025 03:52:11 +0100
Message-ID: <20250630025255.1387419-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
References: <20250630025148.GA1383774@ZenIV>
 <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

It never made any sense - neither when copy_tree() had been introduced
(2.4.11-pre5), nor at any point afterwards.  Mountpoint is meaningless
without parent mount and the root of copied tree has no parent until we get
around to attaching it somewhere.  At that time we'll have mountpoint set;
before that we have no idea which dentry will be used as mountpoint.
IOW, copy_tree() should just leave the default value.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 9b732d74c2cc..f0a56dbceff9 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2222,7 +2222,6 @@ struct mount *copy_tree(struct mount *src_root, struct dentry *dentry,
 		return dst_mnt;
 
 	src_parent = src_root;
-	dst_mnt->mnt_mountpoint = src_root->mnt_mountpoint;
 
 	list_for_each_entry(src_root_child, &src_root->mnt_mounts, mnt_child) {
 		if (!is_subdir(src_root_child->mnt_mountpoint, dentry))
-- 
2.39.5


