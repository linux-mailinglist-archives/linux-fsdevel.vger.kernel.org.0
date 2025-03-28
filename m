Return-Path: <linux-fsdevel+bounces-45225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1A1A74E65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 17:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFE84179B2C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 16:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAAF1DE3BD;
	Fri, 28 Mar 2025 16:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lm31kvul"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3752E1DE2C0;
	Fri, 28 Mar 2025 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743178582; cv=none; b=ibj7p8Jg8FJOCuOEux3UFxz73+ZSyBWhTBaE4NHvtzh4iNlrJq4FacB7gDAFNp6PUBgwX6ACIclExzvEFucSkv2P+glqkdIuLw3RJytMuKLa3B7d+Q3LCl8i1zW0osLlE/CNpTjTwzq2Ip0bkJ/IOGhricnAIe4mYpHQM9akIws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743178582; c=relaxed/simple;
	bh=kQuw8pGOEj2HTHUntYvMH05/2F/1BJUoN/04q2b6wh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IhGIbSWX0ZpoxXrl6FTllCxLkMjRGJaBuBfSEX8W14xrLyvRbtEyi3urBTJrgtVYH+3CJXxL5cp1Ei7ztGioKNBB4T5/RME9k3AydwOJGnwS8nLQgxg2y5f1Axy5NyoRUIyo93JKmw+rNoFD3Wpe2PpqXbu51ift2xpQAkIJgSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lm31kvul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AAEC4CEE4;
	Fri, 28 Mar 2025 16:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743178581;
	bh=kQuw8pGOEj2HTHUntYvMH05/2F/1BJUoN/04q2b6wh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lm31kvul7AwKcTDG+YwF4v5co9neROI5sp5Bv1GFESi2g9jxkw4vgGfc6cRo7jhXF
	 oNUXP/dMZbABXaHvlixOfZIABgJMa5z2jrF6p4v2NbZSgs/+s6n5JKqfamgoKq8rje
	 Ugv9/V20Bdv531dPwui1rS3jWu2GfsB+tz2xm6YMOmvCHO6HwVjje6TXlZPsvbiehb
	 NTvCELgl9ZcKK5dLGaGGcy62ixX6RhZfq1OGDjCVtVQmoZ3cveq9Y7yMghK+ubVB65
	 S/JCQlnw8nNo+Sfj1ObUmbC7zM8lGow5YkQ/FLg+rnEQaqohORcHQuVCZSHYLGWyWA
	 zVC6zL3U4/V7Q==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	jack@suse.cz
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	mcgrof@kernel.org,
	hch@infradead.org,
	david@fromorbit.com,
	rafael@kernel.org,
	djwong@kernel.org,
	pavel@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com
Subject: [PATCH 2/6] super: simplify user_get_super()
Date: Fri, 28 Mar 2025 17:15:54 +0100
Message-ID: <20250328-work-freeze-v1-2-a2c3a6b0e7a6@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250328-work-freeze-v1-0-a2c3a6b0e7a6@kernel.org>
References: <20250328-work-freeze-v1-0-a2c3a6b0e7a6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1111; i=brauner@kernel.org; h=from:subject:message-id; bh=kQuw8pGOEj2HTHUntYvMH05/2F/1BJUoN/04q2b6wh8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ/O+0014vH+bvWSfkOnz6BrL22ZhUXV3CKX75wdkL3R qMKfdW4jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInsWczI8HbtRaM8JqXAvPv3 TSdvzbl03Mlqp/6ukidxItNWP3d+K8XI8OWx8XFt9+KnATxibw9u2su3OK+t6ZuE36aZUYdCXRY EsAIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Make it easier to read and remove one level of identation.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index dc14f4bf73a6..b1acfc38ba0c 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -987,20 +987,21 @@ struct super_block *user_get_super(dev_t dev, bool excl)
 
 	spin_lock(&sb_lock);
 	list_for_each_entry(sb, &super_blocks, s_list) {
-		if (sb->s_dev == dev) {
-			bool locked;
-
-			sb->s_count++;
-			spin_unlock(&sb_lock);
-			/* still alive? */
-			locked = super_lock(sb, excl);
-			if (locked)
-				return sb; /* caller will drop */
-			/* nope, got unmounted */
-			spin_lock(&sb_lock);
-			__put_super(sb);
-			break;
-		}
+		bool locked;
+
+		if (sb->s_dev != dev)
+			continue;
+
+		sb->s_count++;
+		spin_unlock(&sb_lock);
+
+		locked = super_lock(sb, excl);
+		if (locked)
+			return sb;
+
+		spin_lock(&sb_lock);
+		__put_super(sb);
+		break;
 	}
 	spin_unlock(&sb_lock);
 	return NULL;

-- 
2.47.2


