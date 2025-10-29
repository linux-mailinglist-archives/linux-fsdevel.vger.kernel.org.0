Return-Path: <linux-fsdevel+bounces-66216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37005C1A2F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9817E500098
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADC6345736;
	Wed, 29 Oct 2025 12:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hf7NX1yJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E66E33C503;
	Wed, 29 Oct 2025 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740453; cv=none; b=DtVSkHfJm7sDHOVcXIH3RU+haxpYJSUavboYykv/OE6ypdDGh48k6H1SdihP//wi+QmKJmVJtT0OpaIxqIKKynCru5SbNa3HEWGGG3IOCxfnso/vyac1YzX3DHgtdjQA541KXY2FtRvXvANo1uqPj3T0gkd6+4JGoE600Jz3stQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740453; c=relaxed/simple;
	bh=VMCLQ5Neu+JsCPfFhnjTC4pvJzkr6RMBoSrPUgoYfJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uiZ4iP9bf9Xza+zH4XXAN4M1U0WrG3DucHp2RpxTFuXKONRmmdm3uS+bXjERPTRh9RIg86uLxL4lHmWYyqwA2b4+HCOAqgRr0Vt/vjvsjFbJnGlnD4kKvjscK04lJdEsxAwuVTf4+pBNO7PD1AaMWl4p4pGivKM6OCfUQJG5q0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hf7NX1yJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B38CC4CEFF;
	Wed, 29 Oct 2025 12:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740452;
	bh=VMCLQ5Neu+JsCPfFhnjTC4pvJzkr6RMBoSrPUgoYfJM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hf7NX1yJCma63j4SYnoVXZpjjvUouirA75Lxzaxq+Geqh64CAu9kfje9yZ13SF5Rp
	 wijgw38NTK43WoCt52H5YtDd3YT8Kbzy5bwnCRbjyPZy6ICJRDP8lBVlC4rmoN7QT6
	 7BUzjMCaj/9SCrZfNFmC/iWQgGT+6y4CJLVecb8+CncM4WX0C06b8w3zDldzhUPIc/
	 jz9pzMC7lnUG0JFj3u9oSk3bq/neP1FLt/mgviIwpPWiaTrnppaw/iErouram6fSrk
	 zHRK9eMo3y/jskjfADEQDNjjGujD2VK1qH7Egk81bX7jQGotsdz2IGmes8fhmGmIsl
	 Z68AHtBUygv3w==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:16 +0100
Subject: [PATCH v4 03/72] nsfs: raise DCACHE_DONTCACHE explicitly
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-3-2e6f823ebdc0@kernel.org>
References: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
In-Reply-To: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=840; i=brauner@kernel.org;
 h=from:subject:message-id; bh=VMCLQ5Neu+JsCPfFhnjTC4pvJzkr6RMBoSrPUgoYfJM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfUw98dyCkyXXhK7omlnfn1ev0ieX4G/1iHR5Xwv/
 /V5TCnrKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmMh+bYb/4csMD8zOm3gk65G7
 xmWDu3UH+H4lWigtarulu0g+89SzKEaG6yrR7bel2K0uHL8ZFzYlrKl4m8kcPslb4dPXWeX7Wte
 xAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

While nsfs dentries are never hashed and thus retain_dentry() will never
consider them for placing them on the LRU it isn't great to always have
to go and remember that. Raise DCACHE_DONTCACHE explicitly as a visual
marker that dentries aren't kept but freed immediately instead.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nsfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 4e77eba0c8fc..0e3fe8fda5bf 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -589,6 +589,7 @@ static int nsfs_init_fs_context(struct fs_context *fc)
 	struct pseudo_fs_context *ctx = init_pseudo(fc, NSFS_MAGIC);
 	if (!ctx)
 		return -ENOMEM;
+	ctx->s_d_flags |= DCACHE_DONTCACHE;
 	ctx->ops = &nsfs_ops;
 	ctx->eops = &nsfs_export_operations;
 	ctx->dops = &ns_dentry_operations;

-- 
2.47.3


