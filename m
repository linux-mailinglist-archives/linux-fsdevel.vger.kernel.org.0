Return-Path: <linux-fsdevel+bounces-60105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA4AB41400
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D03C540E89
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8402D542A;
	Wed,  3 Sep 2025 04:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uDtAX7k4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08BA2DC332
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875354; cv=none; b=cfhH5DdOGuNr4xzYBNk/uNHfaC+HORUQFu7ALpBK7naWbXnii2w3pIo/IVl3wxSNSN06FeCczDlFVwj/+XSDEAWNNAWC7yuyLxsttAOYfTJzvR4MTn6XL9Cd2Fwb+sW9F9JVRCFG2uOCl4IzlM4+IQaG48i2JtSE930Sx4L4E30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875354; c=relaxed/simple;
	bh=/u64uN2jropst5u50C9x5gMZrn5QoY5XVDy4ggWgKJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVKroIc+qaGfv24eT4iGfrDIfMQz77GsDakfqyPR1XSR3D2/QVlSbAkUo+B7+nwxEgzVHnoac7F0IluV4SHik35Lzq4oKJPEdt4qTdL5XZHbwF6m2YcBU/tek8/H1B+hcsWw6LjpWaMBBTX4GUZpOIYizawq5ntbbAmVY/7Gx+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uDtAX7k4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=eAuMcHPKPaSonNByZ1seRdv32NF7VU3jfKrh3PEtWO0=; b=uDtAX7k4Wbv2F0OHXWEWvT2cAH
	ogs84CNKrr8422yUKco0pnvqQKxmWed0koWwRL2E/D24KGvHoScoJuh83RQJ4B5XjNHcOdODMUnO1
	8Z1j6dPz/DHoQ82kvD5URyWq6QS4FVk4HfLxgNp8hhhwFCXGzJcLrppXnLdvcCaFM4Eq3bma4jgAO
	wokYVUoei0lxu4IShWwqGpVKF28bAT59oE8MKvvjKcwxRotpIEusXw2luePxcJyh/Ms9HOlufqCqR
	+IMA7dC7BNXkd1gGTnPvSkt1q7bAmGV2oB50pEr6e3wS/GrSn6ApFZ9dpjqL6b6Mk3TBJfKvSxHcc
	VS7iNaWQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfXD-0000000ApIa-0gZL;
	Wed, 03 Sep 2025 04:55:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 57/65] mnt_ns_tree_remove(): DTRT if mnt_ns had never been added to mnt_ns_list
Date: Wed,  3 Sep 2025 05:55:23 +0100
Message-ID: <20250903045537.2579614-62-viro@zeniv.linux.org.uk>
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
the lockless list_empty() is safe - either that namespace had never
been added to mnt_ns_tree, in which case the list will stay empty, or
whoever had allocated it has called mnt_ns_tree_add() and it has already
run to completion.  After that point list_empty() will become false and
will remain false, no matter what we do with the neighbors in mnt_ns_list.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 5b802cd33058..c175536cc7b5 100644
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


