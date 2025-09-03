Return-Path: <linux-fsdevel+bounces-60060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF68B413D4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004481BA131D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC86A2D781F;
	Wed,  3 Sep 2025 04:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="dGrR+hcD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916772D4B5B
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875344; cv=none; b=ADAgrv2MTQcbUULqMJL/UXlWWfockZ19nHUlFAPeiyERaVTat+qvI/b7pF7ggy4dDuRS2Qu5/RQZyRo9MnfQrmTdakMi87P/tuIV5hpejzGQPBqTlZqWEdDholT4ZWRRW9hDE6YizhE8GJ1MePs0yrpnukDiQlb0J4Wi+6b9+2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875344; c=relaxed/simple;
	bh=0r+mqVfLFQf63EfLxjFqOFyLL9b5NyD0SoCGxhk5efE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PopXQVpsVGy7t5pkJwvJolXxYvMnhffuLQF53qqRaTJMRvcLZ6wH8a0FNvsfnqvVjwvadvAwZfOM89czi8MfVWj53bVhh/dZOBvDjqNnh1yG9RNqPCM1ITWsKgy6n8ekRvv7IuC/nHXIME+yzlnTgCIDrfdqzNP3z895lhiR9+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=dGrR+hcD; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=bfS8MbrTqhkcdjwqN5kbV9L1kEnF+VyoLU4fzit4rGw=; b=dGrR+hcDk0YLvpKC08jjgOXrOE
	xRNGdufcsYxic0+0NQH1LOMz6UW0NlhMLdweo/upbC0RTIQMimsG57j7bUj8OGCXSgkH7++bxX6Uo
	psHAcTkFt8z/gWjkNYIuKaDdURCXAF1R5EZH7iQQ6x/SZRfHIyz7B5JTNRHcaMauQCzAYDCR+2O2u
	/WSJ7TtXITcUl+/tUoN+wirw8qiBsrYtPfPKtNY/NKjwUtFHfoSJuB9FtoEto2yX1seVH9c+EHpQj
	pfIK1sJwKnhuPLm9NhVAgGAlPmsgpQtKpIOewfQA+p8foH8h0TXEcj6qplZycba+pvb5/5IWXbAMs
	FIRKzCEA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX2-0000000Ap6t-0LBs;
	Wed, 03 Sep 2025 04:55:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 10/65] mnt_already_visible(): use guards
Date: Wed,  3 Sep 2025 05:54:31 +0100
Message-ID: <20250903045537.2579614-10-viro@zeniv.linux.org.uk>
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

clean fit; namespace_shared due to iterating through ns->mounts.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 86a86be2b0ef..a5d37b97088f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6232,9 +6232,8 @@ static bool mnt_already_visible(struct mnt_namespace *ns,
 {
 	int new_flags = *new_mnt_flags;
 	struct mount *mnt, *n;
-	bool visible = false;
 
-	down_read(&namespace_sem);
+	guard(namespace_shared)();
 	rbtree_postorder_for_each_entry_safe(mnt, n, &ns->mounts, mnt_node) {
 		struct mount *child;
 		int mnt_flags;
@@ -6281,13 +6280,10 @@ static bool mnt_already_visible(struct mnt_namespace *ns,
 		/* Preserve the locked attributes */
 		*new_mnt_flags |= mnt_flags & (MNT_LOCK_READONLY | \
 					       MNT_LOCK_ATIME);
-		visible = true;
-		goto found;
+		return true;
 	next:	;
 	}
-found:
-	up_read(&namespace_sem);
-	return visible;
+	return false;
 }
 
 static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags)
-- 
2.47.2


