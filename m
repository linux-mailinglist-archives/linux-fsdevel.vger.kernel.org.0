Return-Path: <linux-fsdevel+bounces-1697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1524D7DDC86
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 07:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 461031C20DCF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 06:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFDE5231;
	Wed,  1 Nov 2023 06:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="PzjSPrlX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2DB567B
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 06:21:20 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A162D115
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 23:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9or3l6Cp/vSjabqxKVwqFh+NlAwQ4vZcxCP3EWANQAs=; b=PzjSPrlXxrkx8iw6JQa1B4ajo6
	BWIK3yAIxiaZRq9dvIKg2C5+mpsgQmQ0DIcDgVTNOPLPNNNQwnX5PZeTSpSu+FJ+CHdYTf/TBwp6S
	mteMCzK8Nh3ZAwVlhaKlkRIootALRquNMGrSd01670aAD9u2voZP7fjI5G0TVLPNR+MN8II4bN4e3
	Z+K73eYs++uIr6aSmc1et94qNPzc0R4Z49F+f1+mnuGjDOJb7icpOqu02DRh3otjYLATcP2b7BUW2
	yyVFcaiYV2uUIaiAeLlx8CP9Ja7qridHRWujzhTLWfZrJslCBm0ZZoWBZdxrOm/nUVTsZNsQHh8e4
	LLk50Ecw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qy4bC-008pbo-0f;
	Wed, 01 Nov 2023 06:21:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/15] get rid of __dget()
Date: Wed,  1 Nov 2023 06:21:01 +0000
Message-Id: <20231101062104.2104951-12-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231101062104.2104951-1-viro@zeniv.linux.org.uk>
References: <20231031061226.GC1957730@ZenIV>
 <20231101062104.2104951-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

fold into the sole remaining caller

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 5114514b13da..49b3fd27559f 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -938,11 +938,6 @@ static inline void __dget_dlock(struct dentry *dentry)
 	dentry->d_lockref.count++;
 }
 
-static inline void __dget(struct dentry *dentry)
-{
-	lockref_get(&dentry->d_lockref);
-}
-
 struct dentry *dget_parent(struct dentry *dentry)
 {
 	int gotref;
@@ -992,7 +987,7 @@ static struct dentry * __d_find_any_alias(struct inode *inode)
 	if (hlist_empty(&inode->i_dentry))
 		return NULL;
 	alias = hlist_entry(inode->i_dentry.first, struct dentry, d_u.d_alias);
-	__dget(alias);
+	lockref_get(&alias->d_lockref);
 	return alias;
 }
 
-- 
2.39.2


