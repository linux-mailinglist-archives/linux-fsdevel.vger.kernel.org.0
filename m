Return-Path: <linux-fsdevel+bounces-53167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C784EAEB2EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 11:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 372BD4A1E7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 09:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9B5298994;
	Fri, 27 Jun 2025 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcG10En4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4201294A15;
	Fri, 27 Jun 2025 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751016590; cv=none; b=QFlkkvqweOjrC6VEH0hEG06hQ9YsR8QYO790yNnbgAnGXUon/17qXExGw11F5n4O1usCtrhK3ycJd94UVHhnvkTJP+z7r5TKh1Ye2qHIxZyzdqzwTf8j04MDbTfSG0BL6QFAw9oB2ddVXY9Yhg4SLsqfNbU3crz+w6mF35Ohayc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751016590; c=relaxed/simple;
	bh=d4f+GZZnhp9tckE2m7jLPOTS9D1ocVue3qS/xZNyyjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C6X00KvCKxYwOs9uTlvwhNBZTBogJA3wbs4tOdSCfW5CVmJlpw0CSpDJuaFCFErYAtKZg0EAfaSlje3ZRgCjnTCLXGuBepYNmC9yygpdht6ZUxAaEFT72TlxzCqaqy4SpzvpYSbGpH6v9HpPs9Yi/l3eyUDFEw3j2ASRYt4jl5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcG10En4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FECBC4CEF8;
	Fri, 27 Jun 2025 09:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751016589;
	bh=d4f+GZZnhp9tckE2m7jLPOTS9D1ocVue3qS/xZNyyjU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NcG10En4/836ZBMejRMxm99cEoSUMjpofJuFTDcpuqzEK/rIBA/ph6YX1EByj3iQd
	 JlFf4P+pSRb45PZkPY6gWy6QsS29kZMVIRwwlDKvQKcix4A7QLQ35/+RscCfZ0+fn5
	 7EwNkKoYOxWHaFuzJHiD9nnxdGUcX/uNdzGNDMPa5seZ7WuBLOvcZfq7FWguYq6X8w
	 NkC5q56kqLi1YhaHf0Gd8PiifQICaQCKoTbUYa8OYD7CR3PFrKcZKzoXZJiFLia+hZ
	 E4ms4N4s/OmKx3XRlSVoJu643n+It5lQi9yJjnauXXRUO/8uG39rBjJSU6IdP8MKzl
	 7N6oW3a0VzAEg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E22C83010;
	Fri, 27 Jun 2025 09:29:49 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 27 Jun 2025 11:27:28 +0200
Subject: [PATCH 4/5] kernel/sys.c: Move overflow{uid,gid} sysctl into
 kernel/sys.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-jag-sysctl-v1-4-20dd9801420b@kernel.org>
References: <20250627-jag-sysctl-v1-0-20dd9801420b@kernel.org>
In-Reply-To: <20250627-jag-sysctl-v1-0-20dd9801420b@kernel.org>
To: Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2495;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=d4f+GZZnhp9tckE2m7jLPOTS9D1ocVue3qS/xZNyyjU=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGheZIuy7IYp/NYoQ0F4Y1Sbfl0C0VMKXwA/n
 6a/S49z66DfoYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJoXmSLAAoJELqXzVK3
 lkFPhDUMAIAgHoQkjO5401S0OP+G118xWa+XDYveVdPCJb5Z+6xXdERrXwDCjQCZ+5Z+RSWCKaA
 X6BKed8rjDHIR6uQODGH88koTbpOqpBo7d2vYNxItk7WE0OC/cBjIulurqjsEO3135Gz7toWdO0
 76AnPLdwQ9npTwKjMdIVsWrYDi6I2Mpw//nSBTVq429AOvFwP4DaY96RNjMs/T+leTzpVE39kou
 veIIC0Wcg1p8Af7XBlwfkEefiuWwPGg0trnaehEmxGBhgI/B0klzjjvfZtvBqigVpMqUVV1LB8z
 TuaC2+BDED8kC8C3LMiI5l8spLrp819I1W1gXngmxHZZMgXqmp9ojO6Omn/c4Mj6bF/b+1Bnorb
 2u31hDPJaAPJHhYdSVwMn6TjsPeCh9u0nvDd5wxp8kUfWi8dlAsKVe+sLkr/xlStFbD/Aoa0Sce
 R9+c2ybUOfSLQgSLZ4niwj1x5PS40RBwn0ArobBfdMJRb4Q424OIu7y6GLo1BOReuaAonxaE2f5
 Hk=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Moved ctl_tables elements for overflowuid and overflowgid into in
kernel/sys.c. Create a register function that keeps them under "kernel"
and run it after core with postcore_initcall.

This is part of a greater effort to move ctl tables into their
respective subsystems which will reduce the merge conflicts in
kernel/sysctl.c.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/sys.c    | 30 ++++++++++++++++++++++++++++++
 kernel/sysctl.c | 18 ------------------
 2 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index adc0de0aa364aebb23999f621717a5d32599921c..bbeee62f9abcdf18cdf5cdb06271476b048357ae 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -181,6 +181,36 @@ int fs_overflowgid = DEFAULT_FS_OVERFLOWGID;
 EXPORT_SYMBOL(fs_overflowuid);
 EXPORT_SYMBOL(fs_overflowgid);
 
+static const struct ctl_table overflow_sysctl_table[] = {
+	{
+		.procname	= "overflowuid",
+		.data		= &overflowuid,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_MAXOLDUID,
+	},
+	{
+		.procname	= "overflowgid",
+		.data		= &overflowgid,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_MAXOLDUID,
+	},
+};
+
+static int __init init_overflow_sysctl(void)
+{
+	register_sysctl_init("kernel", overflow_sysctl_table);
+	return 0;
+}
+
+postcore_initcall(init_overflow_sysctl);
+
+
 /*
  * Returns true if current's euid is same as p's uid or euid,
  * or has CAP_SYS_NICE to p's user_ns.
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 2df63b69edf6fd21a58584d670e75e6f26a6e5cc..21b70443aea75ae3212f70e5ce7efbfdf8a4f75b 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1475,24 +1475,6 @@ static const struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
-	{
-		.procname	= "overflowuid",
-		.data		= &overflowuid,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_MAXOLDUID,
-	},
-	{
-		.procname	= "overflowgid",
-		.data		= &overflowgid,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_MAXOLDUID,
-	},
 	{
 		.procname	= "ngroups_max",
 		.data		= (void *)&ngroups_max,

-- 
2.47.2



