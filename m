Return-Path: <linux-fsdevel+bounces-65135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FCFBFD0CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A061C560C7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB3C2BE64C;
	Wed, 22 Oct 2025 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTlKbQnN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0424F2BCF54;
	Wed, 22 Oct 2025 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149203; cv=none; b=C8WjBCnriJJLdhJIMnqFJdvOCxadGCp2GFO0BL2DLM7EtMc7qSjsplb+PDhzww8sOjD4/DFx7DU29Nt9xfcvkjg0kgFaDaK4Ul1HGeAW7GHNKcfeWFTwws+1f78y6sS37Qse1X6WKw+259xyuRLH9OVIXpjn0SYAoyJGnbMix1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149203; c=relaxed/simple;
	bh=7aAHCcaecm2VZuosAD5WF6qVRIAZipjG6VYIR7g9o5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KzcoDnUYTxtsoek1lsAODMd+F+vDo9OFReJsUjg0gSFDfVsj51pQ98RQQWz/54hGtoI9GIDKdN7wgyYisfXUqfi05k3jAK/1Xb55r2wWXFA8ZjW+f+hgagCV85ogYB6amkha3EJZv4F4zaCqGlUhwX5O9ZwoWeaLlxw3IQRjZU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTlKbQnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734CFC4CEE7;
	Wed, 22 Oct 2025 16:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149202;
	bh=7aAHCcaecm2VZuosAD5WF6qVRIAZipjG6VYIR7g9o5A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qTlKbQnNBX56eFps9NI0xPLDJT3oBO3igFJsVI9sktB+ntfqY1HmUoegPAr9j/Iuf
	 uhoItu+5xSiNxtCcaE30Ry+LcEazHX244tvAQxADqJ58KH0pn+xTbv06iJqIx4o78r
	 pUMiR6xojD8IMOQnvyuRr5Y6cMLIDcT2cQNfffmlwdqnmKEqA8K/fRw5mUCnoHhwsg
	 aAilA+8luUhL+QT4xspKmuOBDwAefQKU9o4jX/hgJBvbblv2RYRGb1ITySdCMNl9sB
	 I43kmLHqfSLM1fm4eE36/nLoPRSn3jWPe2YzV8iShKtf2ORqoglBHBBMJ619UKpQI9
	 zs8LFmrwDl8Zg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:05:45 +0200
Subject: [PATCH v2 07/63] nstree: simplify return
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-7-71a588572371@kernel.org>
References: <20251022-work-namespace-nstree-listns-v2-0-71a588572371@kernel.org>
In-Reply-To: <20251022-work-namespace-nstree-listns-v2-0-71a588572371@kernel.org>
To: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=670; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7aAHCcaecm2VZuosAD5WF6qVRIAZipjG6VYIR7g9o5A=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHiiM3vbZKk7We4P+YJeTgh1tDzpJPdE5NSjSwvOM
 XEI6W7T7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIpXWMDLcYNTZFZsy2Uvj5
 uWH2/TdG2nFm+ly376mtmmH7e6mV+FaG/2XhoWv+yL/x/RJ/l89zkqHB1SublfgnaXUceri47Uu
 fJisA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

node_to_ns() checks for NULL and the assert isn't really helpful and
will have to be dropped later anyway.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/nstree.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/nstree.c b/kernel/nstree.c
index b24a320a11a6..369fd1675c6a 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -194,11 +194,6 @@ struct ns_common *ns_tree_lookup_rcu(u64 ns_id, int ns_type)
 			break;
 	} while (read_seqretry(&ns_tree->ns_tree_lock, seq));
 
-	if (!node)
-		return NULL;
-
-	VFS_WARN_ON_ONCE(node_to_ns(node)->ns_type != ns_type);
-
 	return node_to_ns(node);
 }
 

-- 
2.47.3


