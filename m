Return-Path: <linux-fsdevel+bounces-59584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE287B3AE36
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1BB583FA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BD12FC86B;
	Thu, 28 Aug 2025 23:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Co0dw19T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3712F3C0E
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422499; cv=none; b=HgFCqpVd1CXgkwkL7zjtdNEEhGsY0rhvEWgaLxQEzHmw/cV5qeOkPH7rGcXthHnfGJZQiEatL68YB9ZiugToQER5SEIKjP39WIJQYOGI3oXSxtuEN9bL2bedfhyYoYuQQpOjkewx3xbFNtY3kfe71iWaGRYMlb3EKlzvHDk6I3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422499; c=relaxed/simple;
	bh=AjVeoBdLmkD9+TURXtWATV29zyTwhukqUTTEwCO1/RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkkB92fCzBep0QHKiA0dNCUrQRjhwUhQc4NR8SXDhMWYx9xX7TqfWQ1mkxXOUjPqwHlOC8qcVz8ERJkJLHI/79IhJ+nHIy8mP6YGZXTOBuvRIOTfBaKDQCNu0Vqn6lmHj3t1aM5vvGCfebz0ildHjBmRFPHUJmuwNjTqN8iioMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Co0dw19T; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hcW2+ZkpUNXHa//jzUf98RzmEsM5GtIPK9Nt4xuTHbU=; b=Co0dw19TVt1Yr86xP8I3mJ8dm7
	qYLsdeZqJmlb5IoLj33Q4kZvN5vAvyFhi64lAjYvDPnDTGwn1P6ZYE5h/TkOB8L+nvXPAEOJH5yjU
	Fvl5efCKKgm0bvJL3b0/aIyJ23XaYbXjc6BVSfDVjhjT+X1VYFQq40f82d0XGGL3PNreldJMHLqdd
	c1ubQQC0RMY4YIXYuPO7NqIK2T28BtsoevpmQanNdN3lH9kiKnKeES8hqam7ueWAagqBXnxyeDTnA
	5lWZyO8MBWFg1frpmpSZ9ho9wZCveVItTAih//GieeKH/8+QtSFCM+hIhyAQ4Ms3268nP4YIwCFLa
	ahTZCHyw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj4-0000000F2AY-3cPW;
	Thu, 28 Aug 2025 23:08:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 57/63] copy_mnt_ns(): use the regular mechanism for freeing empty mnt_ns on failure
Date: Fri, 29 Aug 2025 00:08:00 +0100
Message-ID: <20250828230806.3582485-57-viro@zeniv.linux.org.uk>
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

Now that free_mnt_ns() works prior to mnt_ns_tree_add(), there's no need for
an open-coded analogue free_mnt_ns() there - yes, we do avoid one call_rcu()
use per failing call of clone() or unshare(), if they fail due to OOM in that
particular spot, but it's not really worth bothering.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index daa72292ea58..a418555586ef 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4190,10 +4190,8 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 		copy_flags |= CL_SLAVE;
 	new = copy_tree(old, old->mnt.mnt_root, copy_flags);
 	if (IS_ERR(new)) {
+		emptied_ns = new_ns;
 		namespace_unlock();
-		ns_free_inum(&new_ns->ns);
-		dec_mnt_namespaces(new_ns->ucounts);
-		mnt_ns_release(new_ns);
 		return ERR_CAST(new);
 	}
 	if (user_ns != ns->user_ns) {
-- 
2.47.2


