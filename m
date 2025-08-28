Return-Path: <linux-fsdevel+bounces-59586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D10B3AE37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23CE9583F43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D982FC01F;
	Thu, 28 Aug 2025 23:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RfmMwJhy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FFF2F3C0C
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422499; cv=none; b=ODb6p876NNOc9vPaV4u8AoKVf/cgjqE2ODa9NIIqJHbuwmcjMc74RDJY1zNnA3U1JRaPcNqhny+3XtPQLb7hdgIcJXZWiAZ9wjMQd6xA/QbKGLRMn2NbWfn5ApWcGfJG9qZ4EknBf6b6bFtzqVVI7s5mTMyNbUDoigtmZba++ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422499; c=relaxed/simple;
	bh=irr438B6d6LbPu5jG1MCGBgvpDaMEq6g9y3MQJvpQKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+v/6voCjtlk0eWspEK6eD7r7qYjkuKeoc5hELUqL95Sdyze61IvxP8CnHylOmKu6FP41nK3w2R9n3MWsEewZRh4oE5qKh4iZAsNEN9+Hg0jDTDDOVwLnw6PTDfVwxisIpFXlHZ6YlXg7WtiPoKaIhWIZRvvtQeX+1GlMMqbk/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RfmMwJhy; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=SvFOnbViJ/bv/qd+Raa0mPzyaNVrxXmXjTV8eZmd/EU=; b=RfmMwJhy2KlK3CRnwIhVCQOJDD
	H/G/KmzEgYF8xo4R690yK8iErYK906cSxVvIfX4m7bQ/ZRX9gtHlZYhAFx4zOrt0De9ixbBQ/oaKM
	gXti+eL7F3DdizrhStxjYFCKJuLGOW++P/j/sGu0SMSfHToUF9mDn6jZ5T7426Ub6dwLVIQ0kjFhr
	tNqBmM4AdO3mEAShxppmQ3meBzWQG8VRAf+bRCiUS9cgkRXvE+3qhg6tzAf80dJGrkmti2wl1Wtfm
	u9taShq1QcfFKilis1r6H+F1CiRe8hD1NUA+Y29JTpVe74koeHvqQMc5Bg/tdw5YHvrZTokMuhb7r
	0MhIpWpg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj4-0000000F2AQ-3Awz;
	Thu, 28 Aug 2025 23:08:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 56/63] mnt_ns_tree_remove(): DTRT if mnt_ns had never been added to mnt_ns_list
Date: Fri, 29 Aug 2025 00:07:59 +0100
Message-ID: <20250828230806.3582485-56-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
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


