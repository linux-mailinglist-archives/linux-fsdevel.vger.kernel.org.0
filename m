Return-Path: <linux-fsdevel+bounces-65134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6323EBFD085
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CD4418C2E72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BE229B783;
	Wed, 22 Oct 2025 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsorfsuM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2D929993A;
	Wed, 22 Oct 2025 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149197; cv=none; b=LoejxZ/BBb3TiqZEjyUywdQ1wzaXGFvonAbjhTbHZdEadCNuDWsuebowlqWUV6xGaN9kC1MEGZV3wb8bhqGZAZr5vZqj3uaTqIS3mOtFsvepB3O7qOH/GDPMsjqHZG7IBB+2capdmShxZ8OiJxMp9Phyx4XNaT5TCXBZfNF9QME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149197; c=relaxed/simple;
	bh=74AZcYyOqxtykIDy/RGdL2vrgfuHMaAEm8WcGrCjYG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nowQFhRTyPfsE0oz/zCXpUxQ4R9w4EwJfprXUuuLqaRED8KW027Gdcg2DLucUTUNcmgCI/5QjQywK2pYX7mte6QJDmdIlOJ3aZUcylhHJZVnrsd9JX2bb6EAF+jv+r9t6MGFOnWXpI+S+zdOeY8ChDzPrNLvrnZ0qVwRXHwb/D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsorfsuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A08C4CEF7;
	Wed, 22 Oct 2025 16:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149197;
	bh=74AZcYyOqxtykIDy/RGdL2vrgfuHMaAEm8WcGrCjYG4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GsorfsuMaDIbFLNgdihZm04ueS3KjYr/ga6yYj4Zfg24+ohkDKwX86q+33D1/Vuvb
	 aoccV/kAOgePvPxCn70d5jg3agm1COKNt+uhWnLVuthdG9tNKa4jNv67AMq/Wcn3LK
	 MlVQaKArHievEQkGdNGEjUithrWeAtY9C5mmQ/uBaWRJ9PHYlM5ECSGwZ0/1FcBiBW
	 yK8IOTbrUkZQiG3zg9kz9+/lcvtCdiQI4eU0e82Hg/PNciWjIGLEXottZfdN15HOYf
	 MsEEi1kXM7+hkQKxccs0dlkUcXwXQfGul3DOAJ5zFBbGq7j3U9MXuquh4jwUcgVvFZ
	 3MN3Hi+V5AGJA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:05:44 +0200
Subject: [PATCH v2 06/63] cgroup: add cgroup namespace to tree after owner
 is set
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-6-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=835; i=brauner@kernel.org;
 h=from:subject:message-id; bh=74AZcYyOqxtykIDy/RGdL2vrgfuHMaAEm8WcGrCjYG4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHjyPsfJZhGzwsvKjjj1BbqCWzuf7Clg3mV96bj9Z
 iV1KZYrHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPx8GT4X55lvP7WLFt5jz3i
 Lr/ett9ZXbPyu6zKOSnV24VC+2fzP2NkmG/xJ+31w8QYzTkBj9ku7PLxEVvkUa0X3TrnwvLyNVy
 tTAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Otherwise we trip VFS_WARN_ON_ONC() in __ns_tree_add_raw().

Fixes: 7c6059398533 ("cgroup: support ns lookup")
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/cgroup/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
index fdbe57578e68..db9617556dd7 100644
--- a/kernel/cgroup/namespace.c
+++ b/kernel/cgroup/namespace.c
@@ -30,7 +30,6 @@ static struct cgroup_namespace *alloc_cgroup_ns(void)
 	ret = ns_common_init(new_ns);
 	if (ret)
 		return ERR_PTR(ret);
-	ns_tree_add(new_ns);
 	return no_free_ptr(new_ns);
 }
 
@@ -86,6 +85,7 @@ struct cgroup_namespace *copy_cgroup_ns(u64 flags,
 	new_ns->ucounts = ucounts;
 	new_ns->root_cset = cset;
 
+	ns_tree_add(new_ns);
 	return new_ns;
 }
 

-- 
2.47.3


