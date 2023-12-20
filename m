Return-Path: <linux-fsdevel+bounces-6562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AAE819816
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 06:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 014DC1C22144
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 05:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A59FC07;
	Wed, 20 Dec 2023 05:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Kydx1Amz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAA9DDC6;
	Wed, 20 Dec 2023 05:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MKbXRaLjiBc1kAHTStOXxlXCDpKMYpV44rac/unVwhM=; b=Kydx1AmzbnGZcl9uMOWlWoingO
	jTdF88DJvYRufhXaxmBMv5YFwuEwIlkWw2V9dAnRORk5XnWkM8vqS1lQi8cs1+JjwcTzVyMvj6jIH
	8zEcAB9mSwlQILmnpGCEs/PO4PtYgNAAwzJXpCzxpuuyDEYJzP1qcbQNJUyKe7VNEr6zTCeDkXBc2
	LLa7muC547oQm5e4RQd8XQqXieyZuUcibev02sYcoTPZRjDqnAXaIeWVnL0PFOImVfN3zaeBHFcJK
	aQmwXC3DAGSO9eKRatWt7yRAtQ3wFihXc/CtHw03Gy1FkcvGsOTkZal6F6wx6eSkFhlQd5eKcB3fY
	Bvu7Q7pg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFp7O-00HJJZ-1W;
	Wed, 20 Dec 2023 05:27:42 +0000
Date: Wed, 20 Dec 2023 05:27:42 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: reiserfs-devel@vger.kernel.org
Subject: [PATCH 15/22] reiserfs_add_entry(): get rid of pointless namelen
 checks
Message-ID: <20231220052742.GN1674809@ZenIV>
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

In all cases namelen is ->d_name.len of some dentry; moreover, a dentry
that has passed ->lookup() without triggering ENAMETOOLONG check there.
The comment next to these checks is either a rudiment of some other
check that used to be there once upon a time, or an attempt to come up
with the possible reason for that check (well, more like "why does
ext3 do it?")

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/reiserfs/namei.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index 994d6e6995ab..c5f233b4a27f 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -451,13 +451,6 @@ static int reiserfs_add_entry(struct reiserfs_transaction_handle *th,
 
 	BUG_ON(!th->t_trans_id);
 
-	/* cannot allow items to be added into a busy deleted directory */
-	if (!namelen)
-		return -EINVAL;
-
-	if (namelen > REISERFS_MAX_NAME(dir->i_sb->s_blocksize))
-		return -ENAMETOOLONG;
-
 	/* each entry has unique key. compose it */
 	make_cpu_key(&entry_key, dir,
 		     get_third_component(dir->i_sb, name, namelen),
-- 
2.39.2


