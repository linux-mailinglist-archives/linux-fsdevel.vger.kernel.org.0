Return-Path: <linux-fsdevel+bounces-20907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 312848FAAD7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 08:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C998128C19E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 06:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA321422B0;
	Tue,  4 Jun 2024 06:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pA4dmeog"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBB513F00B;
	Tue,  4 Jun 2024 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717482600; cv=none; b=CranHYsDU7Sku8pVk/5hUb91u6a38bu6UymyQLIeMDtBoJmG4kmxmHxtvQGROzV6Vd0S7H4nrDbozMJKGfQC1J7Suj9ZZYse0UkLgCO/qA527ytsiFjp/8q2V+oNeyM1OrSygK1XmdkupKeDLVR2MBajr7jlOFIDdxEHrRdpq2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717482600; c=relaxed/simple;
	bh=SiVUhtxONKQWX+BBZwI127KwpXG2Q3vZOfxEJQppcWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aTPjr08EU30OsYxEJaA8/kBvA7qYA24drM+cYqyagj+qklaIHwd7ASDWYTFwcK+xQUSnzuRMx1rSjg8JeksyIh7ev3hEmBjTdhpbZHIewkcxHFjd4r1HfEIrquA0BR99bDmZRfnqbejGoaJwR/t3aZ1+9i4LZL9u2dHB5D9V8iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pA4dmeog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEBC7C4AF09;
	Tue,  4 Jun 2024 06:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717482599;
	bh=SiVUhtxONKQWX+BBZwI127KwpXG2Q3vZOfxEJQppcWk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pA4dmeogTARSZfUZ/Gh9KHrzmf7wDP8GqwUGhu5YY1UfYSpIYx7Ne3usxtGqOwF2J
	 mA5x5+xvD0pZwhihYG1Ufi1aaFA8o2vmdw121w6VUTnpX7cM1CcG8/w9hdles60tLI
	 5sNqVzC6xqZol58Rt0b4wJcCTQLTqh5WaMaM1gJt8R8rFyUCTLy2e78mU5MjXxt9xv
	 3+j9/MOmODLqmTStj6lUdjNt3QeZfewviDek6mipvnJGN1KTs8WIU/WH4EyjcrQx5i
	 x+Sbm2GdzftBbBsodZq+OgHOAWOsgB5lDdMspCkESqr7WUTz24atJeZbtBMslDcz/A
	 Xah1DKevIQW2w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F52C27C55;
	Tue,  4 Jun 2024 06:29:59 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Tue, 04 Jun 2024 08:29:21 +0200
Subject: [PATCH 3/8] sysctl: Remove check for sentinel element in ctl_table
 arrays
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-jag-sysctl_remset-v1-3-2df7ecdba0bd@samsung.com>
References: <20240604-jag-sysctl_remset-v1-0-2df7ecdba0bd@samsung.com>
In-Reply-To: <20240604-jag-sysctl_remset-v1-0-2df7ecdba0bd@samsung.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
 Kent Overstreet <kent.overstreet@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Joel Granados <j.granados@samsung.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2348;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=mD4Ze/7MDPElpYuv5XGK8tVRov3P49zLBw+A3YRwezE=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGZetGMc5UA19wZYyokNq00ONpu/iFrRM3b3d
 ji21KMQyCufh4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmXrRjAAoJELqXzVK3
 lkFPjSkL/jbkTtKEHy2F4Zoay4bUyht8qYvmVrqYV35vhM08LmptpbTf9aDW49d1wvwom8i7zTo
 +bkTEJ+q5fEM8JibuQ4wBCwuyN55TQaiyynC6+P1sISJFiR+wNNKUkzoJZJuds9xIN3VHDBujmF
 hNT6GLin8xncVd6bXgjH1ukPvQamXDCmxcTzZ2ES5fPV4d063gEAAo0nfHkZRnPYcBfiPAf6E0W
 6G/lTK5uCzNa1ienyagjyYa/UhAA/5IR33bkyguc9SGsBIZ5T33xBdFUHEfNS3GwclPA2Yt2jZ1
 LYUI6YkfSftzj365NjA/UIsfGOdho/i4+CyV68VYXCQ0uQqSokz3ckRi9m/9JJOmT+qgzaSJbad
 kdWkSUcfn0vkojZPlpE8X3ed9U671GRAu0H/6f3Mv1yLfMoZEfspW68GFf+XV2mwWYYfmJl8rny
 mq0grO/Kf0H96o3+fcySffKJnyun8yE/Sil4YyRoh2AS4mwi23lOtffZxZJuyJcUTavw5iP4Pw6
 PI=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

From: Joel Granados <j.granados@samsung.com>

Use ARRAY_SIZE exclusively by removing the check to ->procname in the
stopping criteria of the loops traversing ctl_table arrays. This commit
finalizes the removal of the sentinel elements at the end of ctl_table
arrays which reduces the build time size and run time memory bloat by
~64 bytes per sentinel (further information Link :
https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)

Remove the entry->procname evaluation from the for loop stopping
criteria in sysctl and sysctl_net.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 fs/proc/proc_sysctl.c |  2 +-
 net/sysctl_net.c      | 11 ++---------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index b1c2c0b82116..d4ba7ad9dbe0 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -21,7 +21,7 @@
 
 #define list_for_each_table_entry(entry, header)	\
 	entry = header->ctl_table;			\
-	for (size_t i = 0 ; i < header->ctl_table_size && entry->procname; ++i, entry++)
+	for (size_t i = 0 ; i < header->ctl_table_size; ++i, entry++)
 
 static const struct dentry_operations proc_sys_dentry_operations;
 static const struct file_operations proc_sys_file_operations;
diff --git a/net/sysctl_net.c b/net/sysctl_net.c
index f5017012a049..19e8048241ba 100644
--- a/net/sysctl_net.c
+++ b/net/sysctl_net.c
@@ -127,7 +127,7 @@ static void ensure_safe_net_sysctl(struct net *net, const char *path,
 
 	pr_debug("Registering net sysctl (net %p): %s\n", net, path);
 	ent = table;
-	for (size_t i = 0; i < table_size && ent->procname; ent++, i++) {
+	for (size_t i = 0; i < table_size; ent++, i++) {
 		unsigned long addr;
 		const char *where;
 
@@ -165,17 +165,10 @@ struct ctl_table_header *register_net_sysctl_sz(struct net *net,
 						struct ctl_table *table,
 						size_t table_size)
 {
-	int count;
-	struct ctl_table *entry;
-
 	if (!net_eq(net, &init_net))
 		ensure_safe_net_sysctl(net, path, table, table_size);
 
-	entry = table;
-	for (count = 0 ; count < table_size && entry->procname; entry++, count++)
-		;
-
-	return __register_sysctl_table(&net->sysctls, path, table, count);
+	return __register_sysctl_table(&net->sysctls, path, table, table_size);
 }
 EXPORT_SYMBOL_GPL(register_net_sysctl_sz);
 

-- 
2.43.0



