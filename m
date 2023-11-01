Return-Path: <linux-fsdevel+bounces-1700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EACF7DDC89
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 07:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53A4281A51
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 06:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055DF6FDC;
	Wed,  1 Nov 2023 06:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QQi1QDIA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35CE5691
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 06:21:21 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1753011A
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 23:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=lXzU4kGM9Zq1fG+oyulDDSAjEI0h3w6xOu+7dOr/nFo=; b=QQi1QDIAY8J6WnoAM9tJydU0QS
	J+teJA4fTDlzSSPYJLwfnWCkBJtqpZix/XdTq43jJHFSiEMSi/VurI9Y6GI9Ba11Ch2K/RP95kBfB
	VS+LfqK4l77VK/9T+J+JfMUQZ3KXPZeWi305wKAgIYcLFesY6Vdo8kSSrE6qg9x8owCeXfUPu4RYg
	evvPCho4YjAhUSqiv+HuTR8iOqRfWNgo/8WRRCPS7YcwfKKm+7WlgJfkogrr6sRhGDIFkJr5hWH3V
	1BK3CLZ3FRTzHKiW/RChNYecuh2ImAwSVOcFP4dsxkMgBuae2X2HGJpIeJqUg4i56QfTBAn5UPEC9
	fs5/Gk3w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qy4bC-008pc5-27;
	Wed, 01 Nov 2023 06:21:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 15/15] switch select_collect{,2}() to use of to_shrink_list()
Date: Wed,  1 Nov 2023 06:21:04 +0000
Message-Id: <20231101062104.2104951-15-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 7c763a8c916b..c47d08da390f 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1491,13 +1491,9 @@ static enum d_walk_ret select_collect(void *_data, struct dentry *dentry)
 
 	if (dentry->d_flags & DCACHE_SHRINK_LIST) {
 		data->found++;
-	} else {
-		if (dentry->d_flags & DCACHE_LRU_LIST)
-			d_lru_del(dentry);
-		if (!dentry->d_lockref.count) {
-			d_shrink_add(dentry, &data->dispose);
-			data->found++;
-		}
+	} else if (!dentry->d_lockref.count) {
+		to_shrink_list(dentry, &data->dispose);
+		data->found++;
 	}
 	/*
 	 * We can return to the caller if we have found some (this
@@ -1518,17 +1514,13 @@ static enum d_walk_ret select_collect2(void *_data, struct dentry *dentry)
 	if (data->start == dentry)
 		goto out;
 
-	if (dentry->d_flags & DCACHE_SHRINK_LIST) {
-		if (!dentry->d_lockref.count) {
+	if (!dentry->d_lockref.count) {
+		if (dentry->d_flags & DCACHE_SHRINK_LIST) {
 			rcu_read_lock();
 			data->victim = dentry;
 			return D_WALK_QUIT;
 		}
-	} else {
-		if (dentry->d_flags & DCACHE_LRU_LIST)
-			d_lru_del(dentry);
-		if (!dentry->d_lockref.count)
-			d_shrink_add(dentry, &data->dispose);
+		to_shrink_list(dentry, &data->dispose);
 	}
 	/*
 	 * We can return to the caller if we have found some (this
-- 
2.39.2


