Return-Path: <linux-fsdevel+bounces-67713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F29BEC477C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 16:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FCCA3B7998
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 15:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88912329E57;
	Mon, 10 Nov 2025 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCzlJtXy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA4E31961B;
	Mon, 10 Nov 2025 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787399; cv=none; b=fSPO9DHBzSPeFiLoz6EJncU8wDAyVtzaSkAf/qMk2Hrzzgy0paPOb3NiwUA41SNz41UwXO9xIbMDGmGTYWzTI//yu86HM59OtDjH2MZUTfPF4ekVwbMjc1CF62S1DdOqxaUpQ2g0mez4IowQyZyZop2KlO2j5TGVQYj3OqBDeYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787399; c=relaxed/simple;
	bh=Zsh6/WXYz3+/XoOqrPruXtdUcrPqz71ls1JldX2KTL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fBdg+qnnktRg+rBTWYu9mpC/cU6B+Lw3I7HAx/Ycsj8X4ia5uSZsTWm/ScKhJn/L1qdR7eH+L/1TBXBeUjGAwncxwExLDSr3CZYCo41Xmvls5IJ4MLKh5Z1dI5ubJV/9L3hqrJ6wG4vjT3xSUfPSoIJzWVfdALJYijURJ5MiSiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCzlJtXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FADC113D0;
	Mon, 10 Nov 2025 15:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762787399;
	bh=Zsh6/WXYz3+/XoOqrPruXtdUcrPqz71ls1JldX2KTL8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bCzlJtXyRiewNdQqkswrjBbY4xcapLx5SCt7/b+HzIBOZi19O7wyp3f0u0A5J+m70
	 1MSo+S7jxfCskEAxEum9pIqj2Anh0kYfojtx929U8F6WEj5i549/kVBqux0dkAU+Ac
	 7Lva07fu80itrYmvZZRDvCSCd4oOG8F0wOGM9HrHq+sZP5T4i+8neCCiEgEj8f+eTv
	 3/t801QWX/P6v2DP6Q0v/9QFUGuQYBhq4KdKcPVL/RaBz1KoBDf25hKXZEQe9FZIiv
	 fjs7+UntoCdQcjkouBDFcxExukrdITOf/YM0oE7R305kpMDQRaxE+iBk+I7AZ2CGys
	 cacNA7f28XmYw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 10 Nov 2025 16:08:27 +0100
Subject: [PATCH 15/17] pid: rely on common reference count behavior
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-work-namespace-nstree-fixes-v1-15-e8a9264e0fb9@kernel.org>
References: <20251110-work-namespace-nstree-fixes-v1-0-e8a9264e0fb9@kernel.org>
In-Reply-To: <20251110-work-namespace-nstree-fixes-v1-0-e8a9264e0fb9@kernel.org>
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
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1278; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Zsh6/WXYz3+/XoOqrPruXtdUcrPqz71ls1JldX2KTL8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQK/v+iuslmvWkBwzy/BH9pFYuEG4+nJnw8UMCcO0XJK
 e0hU71qRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERq9jH8037UVd9/7t98Qd/y
 cKET89P1HgnvPf7/4k62o3f6p6w9YMnI8EuvoVF63pTnu66XGj02Wvb+XZC1pLOcH6NQmRdfto4
 IIwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Now that we changed the generic reference counting mechanism for all
namespaces to never manipulate reference counts of initial namespaces we
can drop the special handling for pid namespaces.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/pid_namespace.h | 3 +--
 kernel/pid_namespace.c        | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 445517a72ad0..0e7ae12c96d2 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -61,8 +61,7 @@ static inline struct pid_namespace *to_pid_ns(struct ns_common *ns)
 
 static inline struct pid_namespace *get_pid_ns(struct pid_namespace *ns)
 {
-	if (ns != &init_pid_ns)
-		ns_ref_inc(ns);
+	ns_ref_inc(ns);
 	return ns;
 }
 
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 650be58d8d18..e48f5de41361 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -184,7 +184,7 @@ struct pid_namespace *copy_pid_ns(u64 flags,
 
 void put_pid_ns(struct pid_namespace *ns)
 {
-	if (ns && ns != &init_pid_ns && ns_ref_put(ns))
+	if (ns && ns_ref_put(ns))
 		schedule_work(&ns->work);
 }
 EXPORT_SYMBOL_GPL(put_pid_ns);

-- 
2.47.3


