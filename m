Return-Path: <linux-fsdevel+bounces-24990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5AE94789B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 11:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A401280BE7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 09:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E34D155730;
	Mon,  5 Aug 2024 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Djcyn6q8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F047214A609;
	Mon,  5 Aug 2024 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850831; cv=none; b=UNHv3Bi1P5QkAcHXrn2CJg6OqAhRRfdrbG6K90H6aJw2PvAoaPbd4jhYiDX07wCOC1UoniX8qxDtvnw6rLvV3wc9lAjS+8kJefDOurhV8SmYsdO2rA+k5IyrccXsbEuOe6fKMad+q+Ptx3DUPjnlqlNgFKCY/uuK8NmaLdpy3f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850831; c=relaxed/simple;
	bh=WtcLac89cqaa8TlTPPbJpfye9uK9JkL4Eft9RJam5x8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g+g1tBt1Zit0Ci1el9WZasooCn3N5XQDAXw0byOl1kvK9SXz76aKXG5noiEFQdGr2KkDKm9/JVdMAPKaJt8gMb1d9AsOHop7bTGr+1UY3fj7p5md++YxzECSKxgPJ8f2zcNemqTmbX4tWGJcLe8DlDU1inMsj1EonoOlLTy72ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Djcyn6q8; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722850825;
	bh=WtcLac89cqaa8TlTPPbJpfye9uK9JkL4Eft9RJam5x8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Djcyn6q8XdTIFGgERhT+8uTuVj/l+yw/59+KESKXb82ia2udUurLDLe58wOYJ815Z
	 ZAe/abUzoPIDAy2qETDiwgFZxDPAWq7lF65dhgBtqI1wb6zAhFRZPUTZUwYs18R0hx
	 4rHh4Pu3w3UAD+JOf9BpVmEUoG2OqwvUKa/QQafo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 05 Aug 2024 11:39:35 +0200
Subject: [PATCH v2 1/6] sysctl: avoid spurious permanent empty tables
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240805-sysctl-const-api-v2-1-52c85f02ee5e@weissschuh.net>
References: <20240805-sysctl-const-api-v2-0-52c85f02ee5e@weissschuh.net>
In-Reply-To: <20240805-sysctl-const-api-v2-0-52c85f02ee5e@weissschuh.net>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
 Kees Cook <kees@kernel.org>, Joel Granados <j.granados@samsung.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722850824; l=2410;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=WtcLac89cqaa8TlTPPbJpfye9uK9JkL4Eft9RJam5x8=;
 b=iFLyKCah+OT86AEz0GgKOzw6q1AHQmfYiAe3EpUPohFjZtfQRh9I94+yKIZy8ivyA9I/NdyIX
 xe2KWiFhpqQAQ3rPyK9Xj+NxSWFbdjDt3cH5CTpNzGYH9yiMbXSXNmO
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The test if a table is a permanently empty one, inspects the address of
the registered ctl_table argument.
However as sysctl_mount_point is an empty array and does not occupy and
space it can end up sharing an address with another object in memory.
If that other object itself is a "struct ctl_table" then registering
that table will fail as it's incorrectly recognized as permanently empty.

Avoid this issue by adding a dummy element to the array so that is not
empty anymore.
Explicitly register the table with zero elements as otherwise the dummy
element would be recognized as a sentinel element which would lead to a
runtime warning from the sysctl core.

While the issue seems not being encountered at this time, this seems
mostly to be due to luck.
Also a future change, constifying sysctl_mount_point and root_table, can
reliably trigger this issue on clang 18.

Given that empty arrays are non-standard in the first place it seems
prudent to avoid them if possible.

Fixes: 4a7b29f65094 ("sysctl: move sysctl type to ctl_table_header")
Fixes: a35dd3a786f5 ("sysctl: drop now unnecessary out-of-bounds check")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/proc/proc_sysctl.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 9553e77c9d31..d11ebc055ce0 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -29,8 +29,13 @@ static const struct inode_operations proc_sys_inode_operations;
 static const struct file_operations proc_sys_dir_file_operations;
 static const struct inode_operations proc_sys_dir_operations;
 
-/* Support for permanently empty directories */
-static struct ctl_table sysctl_mount_point[] = { };
+/*
+ * Support for permanently empty directories.
+ * Must be non-empty to avoid sharing an address with other tables.
+ */
+static struct ctl_table sysctl_mount_point[] = {
+	{ }
+};
 
 /**
  * register_sysctl_mount_point() - registers a sysctl mount point
@@ -42,7 +47,7 @@ static struct ctl_table sysctl_mount_point[] = { };
  */
 struct ctl_table_header *register_sysctl_mount_point(const char *path)
 {
-	return register_sysctl(path, sysctl_mount_point);
+	return register_sysctl_sz(path, sysctl_mount_point, 0);
 }
 EXPORT_SYMBOL(register_sysctl_mount_point);
 

-- 
2.46.0


