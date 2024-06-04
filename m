Return-Path: <linux-fsdevel+bounces-20902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72E08FAAC8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 08:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F5AFB236B0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 06:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC7D140396;
	Tue,  4 Jun 2024 06:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8sqn2UI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED88E13DDA6;
	Tue,  4 Jun 2024 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717482600; cv=none; b=rxVUJgSWpHcQCsXa2+cfxVuO23EEl7Dsjd3LoZTi1AH2JhEuelHUZuJwX6gXZjepv6XaITkBpTkZ/3BBUDffrfasPlHl1WefB+RnjWI67iIFoY5YeZ5SQs6h7Zx6z7CWGCAd+Whg3BVpbo5ZjV4zjbyQSEoCfCM++HNxE7lpfrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717482600; c=relaxed/simple;
	bh=qnk8lkgaR1ZcTBtK8DdwuXgNlEzaf3fm9+u2f6xPjbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CuZ4PxUdNaLb5PQXtzvZuZpVuRFB7WqcWc3zRyWtgKl323qAhmkm49jglDqyT2aFsw3EdNggi5qCOSZw47543GZhFaYs8QNs3w1WVkVVEVRm6B09KhKnsJmXMHmWzy5/UcCiuAA5YC6p88lDF8qPp1bRPYgDrkYHxocrXzZUmjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8sqn2UI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD22CC4AF0D;
	Tue,  4 Jun 2024 06:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717482599;
	bh=qnk8lkgaR1ZcTBtK8DdwuXgNlEzaf3fm9+u2f6xPjbg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=q8sqn2UING2yH+C0lcGQSy4ae0FcbWJrC/vs7mpC04KFg1OQJRvbK9zk+t5Fw/rIR
	 EXSXQVp55YTwcmYQApUkmuu2iBDhC8iLZ0bQAqn5D1BkK/WZr+UBT8CZVt6H8PxIjg
	 ZYTMUuFRe2XlLeU+UTju9SRDmbbt8ASi+Flu/QfnUo+d9b/v1GYlHruDAVJbdprcat
	 3tCLPSjEQ5pBzKJkGdHOWkbi9N6PHM1x1F5tWDqDHF9zPuM7Dadi3X/TJlDHqc4csl
	 t5+ByLcktT3kpOOhg2GCTRNVMD3F3FnIkWuDh54RMgQoxxdZf52k9L2Y2XUmYe+gc1
	 BdW6AX8HkNm8Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAEEC25B7E;
	Tue,  4 Jun 2024 06:29:59 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Tue, 04 Jun 2024 08:29:22 +0200
Subject: [PATCH 4/8] sysctl: Replace nr_entries with ctl_table_size in
 new_links
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-jag-sysctl_remset-v1-4-2df7ecdba0bd@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2054;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=qaxk3rDogN+ZQLc9uwmgCuRk4aqbCXJb1N+PNG5WkHU=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGZetGPmD7WlkmXC06LM/3KIlA0dRX7bMC7EC
 Mz6CbqNQM1cIokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmXrRjAAoJELqXzVK3
 lkFPAi8L/jtTQsXQjrugX/vUO+3ZfV6tbEgbfiD5VOWt6iknGkxcPfsh4zkeVU+8DtrCDQ0oTo0
 GK2pL+u7ZNsuK18g4OX5tQMQVfAa2WTYIAakatrnYIpkAvyS/IRkkCpJAggBFnIPbUoauOXuhtL
 vVb5HV0xe3NZMqFfuzg3sgsCCwtnTZ9jKMfXD/KSW2MGFqGP+hgjtkXwyzoAvgnsgQOqsKCG6+x
 MvS/OHonmHCHQPsZIeZVrK1DRP4wZyzDTW2YybRazjY24n+c+5JZ5PPbI8ll/f29f2zjq7k3bRO
 ckeQIGnXL4rCPhIB82vSKkxAmUeD/pUQvw120K7thSuG4GGl0vhrTYxH5QkC783QZN3lH+lGPMO
 StmLrdQkPtEG7L0BcxN1FSMQGG2dXI3KUR2Noy5QDAu4bAwnQge1FBEVa/4NNgBhFN4NHyejdNR
 yFpQcnPYKczW4mfyKjeQDHvC7T9RuoIqhNR2eW/3Zmhz/KXrysvomOq3G2E40T12Zu/PH9FuYL5
 l4=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

From: Joel Granados <j.granados@samsung.com>

The number of ctl_table entries (nr_entries) calculation was previously
based on the ctl_table_size and the sentinel element. Since the
sentinels have been removed, we remove the calculation and just use the
ctl_table_size from the ctl_table_header.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 fs/proc/proc_sysctl.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index d4ba7ad9dbe0..1babb54347a4 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1154,18 +1154,16 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_
 	struct ctl_table_header *links;
 	struct ctl_node *node;
 	char *link_name;
-	int nr_entries, name_bytes;
+	int name_bytes;
 
 	name_bytes = 0;
-	nr_entries = 0;
 	list_for_each_table_entry(entry, head) {
-		nr_entries++;
 		name_bytes += strlen(entry->procname) + 1;
 	}
 
 	links = kzalloc(sizeof(struct ctl_table_header) +
-			sizeof(struct ctl_node)*nr_entries +
-			sizeof(struct ctl_table)*(nr_entries + 1) +
+			sizeof(struct ctl_node)*head->ctl_table_size +
+			sizeof(struct ctl_table)*(head->ctl_table_size + 1) +
 			name_bytes,
 			GFP_KERNEL);
 
@@ -1173,8 +1171,8 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_
 		return NULL;
 
 	node = (struct ctl_node *)(links + 1);
-	link_table = (struct ctl_table *)(node + nr_entries);
-	link_name = (char *)&link_table[nr_entries + 1];
+	link_table = (struct ctl_table *)(node + head->ctl_table_size);
+	link_name = (char *)&link_table[head->ctl_table_size + 1];
 	link = link_table;
 
 	list_for_each_table_entry(entry, head) {
@@ -1188,7 +1186,7 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_
 	}
 	init_header(links, dir->header.root, dir->header.set, node, link_table,
 		    head->ctl_table_size);
-	links->nreg = nr_entries;
+	links->nreg = head->ctl_table_size;
 
 	return links;
 }

-- 
2.43.0



