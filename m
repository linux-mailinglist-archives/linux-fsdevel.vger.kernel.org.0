Return-Path: <linux-fsdevel+bounces-65131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A370BFD082
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1037C4FE63D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AF228032D;
	Wed, 22 Oct 2025 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NR+WrNWo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE05270EC3;
	Wed, 22 Oct 2025 16:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149182; cv=none; b=i73Fkcdme4WoJL3FYwyFwwruiT9OA/cih35GzUKy38tMVg8paXOiwtVVvR1iMNMSgoOOIz19ISvzYi6CpMYuSQ1W+bVsbuQJeaBB+nfvR8w/DcFrouxuGy5+EyUWsr7U/jpNCreiZffAZpaZf5p8SzMDeJstDCZx6z1ulStoqGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149182; c=relaxed/simple;
	bh=VMCLQ5Neu+JsCPfFhnjTC4pvJzkr6RMBoSrPUgoYfJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZBsr5rLcfr4zXTu4aZMvdx1NiAI1J4jiks6ZB6Lf7o0es7PdSwal2J2tsRYqbnRXLcKTTTQN2fbVBVhbmiCd8YD8bRXVsZgiEoJ2ga9IoKKXxJizeTljQ7oySafTOKXV2hy/PgTJvrA22bvw/jCvsB6qHeYUBfuDtVDTOH4K2i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NR+WrNWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63054C4CEF7;
	Wed, 22 Oct 2025 16:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149181;
	bh=VMCLQ5Neu+JsCPfFhnjTC4pvJzkr6RMBoSrPUgoYfJM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NR+WrNWooGSxhYhX+4Y4dXMJyX2ApwVxDL2xaZIilFKfV+ePSZOnMgYgzU5YeA3nL
	 uCkhC7+xpm6Qudw5gcuTLDX9HZOP/K90y0O4TqfB0HWOOGjokjyhIRSXXw+hl0cGQL
	 KaMIdd7hHbcHCw4XmzCJgQdpltPsoIclt02opbccCF0jkiG7z2DQ8LVGlkgQ4dJhnn
	 2oQ0PgjcSslF8M33VQ5VtsfqpQQh4UASeSdqb2oWvoCD+I5qjD/lGkyIBVKY7V/K3O
	 SZ8DvCgZobrbB3djOt9GWbjOhv3wOt4TTj8MA6StlbJUXYRv0Vobi3Sy0MLxlynLZ8
	 SZIyjsxCXvogw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:05:41 +0200
Subject: [PATCH v2 03/63] nsfs: raise DCACHE_DONTCACHE explicitly
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-3-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=840; i=brauner@kernel.org;
 h=from:subject:message-id; bh=VMCLQ5Neu+JsCPfFhnjTC4pvJzkr6RMBoSrPUgoYfJM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHgSdo/x+VKp3F7T7cFPSlOfdtYdeVsf5nwgrfHh5
 mx+9ZrejlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlcP8bwVyrdiaOr3675i9Hx
 u72aRxma3URUJdJfbuZf9nWj2U7FrQz/k27UW3OVLXbKWjzrufaF5btltonsenNto4DYmdUspSn
 z+AA=
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


