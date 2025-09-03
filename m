Return-Path: <linux-fsdevel+bounces-60102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A96F2B413FF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F84F68101D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCA72DC34A;
	Wed,  3 Sep 2025 04:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RxvpWjUH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB38B2DAFD8
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875353; cv=none; b=n8N7YVBy4Ul/uYBnTzt7p85r041Oa7pfaas+b2tnAjW+acQDyCpRMIVYDqbOH49HQ1CRjOdZXFKHucapb8iv/JVoUbneKalOw+sztZLOFs0EZHEmYYCpQ992K5ujX5CO4R8noFlY82QW3d0asdkStOi5tfyEmzDTNIJ80LHnQDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875353; c=relaxed/simple;
	bh=irr438B6d6LbPu5jG1MCGBgvpDaMEq6g9y3MQJvpQKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W48Z0e46DCszYvpLgpLDewnWNP0ItLh+IlDWvmsP2K1wK7sjmurLXBZsBLfGDWtbZJTodNiehcYqjmQEjxGInZrBby0Gl9qinSb2nDCISWxAkD2GuScCZ6zeJT/JUV9DjppddQEGxda1Oa6PftD0yun4kCdX+wnHGKsIiQMOdyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RxvpWjUH; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=SvFOnbViJ/bv/qd+Raa0mPzyaNVrxXmXjTV8eZmd/EU=; b=RxvpWjUHBrYmwUa83SFDgZGPDg
	AsP/WceM1LuJoMlzdGKYdPnEdYY0z4uGbIlYeMtrrcrlc+yPo+xFvnti8W1CSop2N8J4XLKTgN2IC
	u9IGoQ49xYqKHDq2FfEsxnl2TEaLf0roKUL9zmXfRTlSnMJwVoKSHaBC5qSuXn9MoLw7Rm/KHuMXV
	unE4o4Fi7CiFegwHX/sAQ/sSA6+/prC5c9zciuCOpTZJpGccWKYQ895c8MXC+vn3FjLRGa1okksLE
	slLReulhTWvC+xWn53lA7iJ+YBNr2SmdSYh+j4E35ht6JGcq+LpoXIdZuy/1bkvyuIMsxSlNNS82C
	SLgUFlow==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfXC-0000000ApHc-1h5V;
	Wed, 03 Sep 2025 04:55:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 56/63] mnt_ns_tree_remove(): DTRT if mnt_ns had never been added to mnt_ns_list
Date: Wed,  3 Sep 2025 05:55:20 +0100
Message-ID: <20250903045537.2579614-59-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Actual removal is done under the lock, but for checking if need to bother
the lockless list_empty() is safe - either that namespace never had never
been added to mnt_ns_tree, in which case the list will stay empty, or
whoever had allocated it has called mnt_ns_tree_add() and it has already
run to completion.  After that point list_empty() will become false and
will remain false, no matter what we do with the neighbors in mnt_ns_list.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c324800e770c..daa72292ea58 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -195,7 +195,7 @@ static void mnt_ns_release_rcu(struct rcu_head *rcu)
 static void mnt_ns_tree_remove(struct mnt_namespace *ns)
 {
 	/* remove from global mount namespace list */
-	if (!is_anon_ns(ns)) {
+	if (!list_empty(&ns->mnt_ns_list)) {
 		mnt_ns_tree_write_lock();
 		rb_erase(&ns->mnt_ns_tree_node, &mnt_ns_tree);
 		list_bidir_del_rcu(&ns->mnt_ns_list);
-- 
2.47.2


