Return-Path: <linux-fsdevel+bounces-20906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDD88FAAD6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 08:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8238328BF09
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 06:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC881422AC;
	Tue,  4 Jun 2024 06:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cypzoF8H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EEB13E888;
	Tue,  4 Jun 2024 06:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717482600; cv=none; b=d4Exzy+3gm2oe6n4sxie1aERh2Q+64DREsVn55GCcb2hkcRCg7kG+WIPaPWnebjxbwDma+k44HiXpIg/Bf3nvGuPloOeA+b2GwlYIL3xXU2ts6ojVa1r3W8Ua4KnXJ6d++Kff2ZvNWO8AuF5H6lT6NjO+b1b62pDLOu6J7r8dOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717482600; c=relaxed/simple;
	bh=+9m/xQlKsI8pqumJbCIgfUOr4dYZwdwxkZ7BbsD0p9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b3b05F5fiUZ9QKJhMpUR4f3pntiSFktJHpRDrMAg3pVdjOdSWxssua3r6+gWjWgM3uPJ1j0khSGprzmqn5u3zIk5GlXBeIkyBkqQ0zg2Peje867brjLvcFizfBZrGQzL5yIS2Dc44ZuOJwmeKueYkicbpTESF7GOlMBXSi+7VvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cypzoF8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6F46C4AF0E;
	Tue,  4 Jun 2024 06:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717482599;
	bh=+9m/xQlKsI8pqumJbCIgfUOr4dYZwdwxkZ7BbsD0p9w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cypzoF8HBNiKPC2nUW6/CDayI/9sb7tk1EtuIsF5LNkC/Vvb+lntmVYJEU2yPN3dA
	 Ywxo0gc6flAZv29VpNp3LTsFajnFwGDogaqn6kUhNBrkFgUN3kNw2mvICiomWHaW1o
	 N+5Gyr8ievMcOl/NAHnguvAJGOeRS/NOsViAWyNA+2fmH116RFJjF2A3licAft8U4L
	 WcJb4OJewURJ4scZFVIoFS4fPM5kEwyLzJJLmbsLKAa3s1isHrTUfrwnxbG43DDnxT
	 rsIt5LYSNnfJ5gvdtg0Bz7jZDaJltPCZITDdFXU3HuLeQl12etRnAYp0XrWrxis/B0
	 kvFEyjLzYCWdg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3D1C27C53;
	Tue,  4 Jun 2024 06:29:59 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Tue, 04 Jun 2024 08:29:23 +0200
Subject: [PATCH 5/8] sysctl: Remove superfluous empty allocations from
 sysctl internals
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-jag-sysctl_remset-v1-5-2df7ecdba0bd@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1905;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=dykX5g3MqGx15MATEKwwLa2ClmbIRatln9uC2eazckc=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGZetGR3E2qjUjAS4q9w+HjZ+miKQrmluWXXn
 C0vkfATqOvX1okBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmXrRkAAoJELqXzVK3
 lkFPwCwL/jqnIEcEWutsOWB1UQTKFkNA7cz4uGlz1RuXDsLJxTehHd+yxHkXH/uC4QSeWlaJMhI
 y/M6hBaSMqyknpSMeXjgwML0myqcwanvUI52qQez7GuzEmaMStbuewJp4fIOopCHSV3fAefx++0
 OYitv3k2B/txIQBpMqoHWgB9DejZcZzzB/KygVZrRs/vDrkWdIl5uMR3J/Ehw3MmcW+b2pU2os2
 pXUQCyBxpa+rOAvWTm7MXOBOHZJnXlIKajR4RLbfGSvkNXJfLmHwY4XuCv2N9BXGX0RgCoMEYSM
 C5UiFki4U0ojWqyKLxg5Lj8T0XgxNjRvgtXo/ao/vdejeY7STem/sCXWVka8SWuXRY2YAFfBlcr
 mU7T+yqjI8JVf6MTCkQYPk9ueo5YHbqWt+oGCXPDUfFfELnkSsWHAsH0S782t4zi4XrmyP3bUZ9
 KAkFDTj8PBaGvHxjxnIsU0ZxjNwxosVnynxuCAKNSU4szTgMzcl76Ck2/It8V8v3qnnHktCQJU7
 uE=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

From: Joel Granados <j.granados@samsung.com>

Now that the sentinels have been removed from ctl_table arrays, there is
no need to artificially append empty ctl_table elements at ctl_table
registration. Remove superfluous empty allocation from new_dir and
new_links.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 fs/proc/proc_sysctl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 1babb54347a4..29d40f0ff3ff 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -951,14 +951,14 @@ static struct ctl_dir *new_dir(struct ctl_table_set *set,
 	char *new_name;
 
 	new = kzalloc(sizeof(*new) + sizeof(struct ctl_node) +
-		      sizeof(struct ctl_table)*2 +  namelen + 1,
+		      sizeof(struct ctl_table) +  namelen + 1,
 		      GFP_KERNEL);
 	if (!new)
 		return NULL;
 
 	node = (struct ctl_node *)(new + 1);
 	table = (struct ctl_table *)(node + 1);
-	new_name = (char *)(table + 2);
+	new_name = (char *)(table + 1);
 	memcpy(new_name, name, namelen);
 	table[0].procname = new_name;
 	table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
@@ -1163,7 +1163,7 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_
 
 	links = kzalloc(sizeof(struct ctl_table_header) +
 			sizeof(struct ctl_node)*head->ctl_table_size +
-			sizeof(struct ctl_table)*(head->ctl_table_size + 1) +
+			sizeof(struct ctl_table)*head->ctl_table_size +
 			name_bytes,
 			GFP_KERNEL);
 
@@ -1172,7 +1172,7 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_
 
 	node = (struct ctl_node *)(links + 1);
 	link_table = (struct ctl_table *)(node + head->ctl_table_size);
-	link_name = (char *)&link_table[head->ctl_table_size + 1];
+	link_name = (char *)(link_table + head->ctl_table_size);
 	link = link_table;
 
 	list_for_each_table_entry(entry, head) {

-- 
2.43.0



