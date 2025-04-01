Return-Path: <linux-fsdevel+bounces-45402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC310A771F8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 02:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930E5164690
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 00:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8ECE1BD9E3;
	Tue,  1 Apr 2025 00:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUzj7xFe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC7013C9C4;
	Tue,  1 Apr 2025 00:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743467627; cv=none; b=bElBNgR5uXIfFs7colUQoQxKhnLV6EUhMX80bn5u/kXO0yLUANbgatlBCewdEzYWydYQHa2JR4j9iJyagqh+dFuecIMbamIO3QQNWl1BhfIsCTa0bT/Yvw4ifIqV+OaahL/p8B9pO5SwJUXnPGf3GUhUEgMpoHOx/3aPzqwNKow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743467627; c=relaxed/simple;
	bh=VvL58nItWEHY6IVraVsEyEezYA4/drjDHy8bBXigLc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JKulsxw4CFv+wmM9r9PkJ7sm7aBnt3gx/JVlPfj1G8J7asG+qv+TjX3t6zLJ6vheMMiINIsyoxjBktMs70AP3yP/x56smNilZeeDjxENFLC6RLFlSZ+z3tTHMdv4lMvXfR6r0Eme37F9dS6EyUB2oMneQy9KClD9F5X408YWhUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUzj7xFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A40C4CEE3;
	Tue,  1 Apr 2025 00:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743467627;
	bh=VvL58nItWEHY6IVraVsEyEezYA4/drjDHy8bBXigLc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VUzj7xFeZYRm9TdE+rSHJKpL67o+RauEPjAPJsQkvE4OleSXC2vC2Eze/SGpfTC5i
	 07CeC6poBG7hQoO19an/r8zVBwgxbYD+69GPOi7FN1SINAWVXE7GPuNfGP9Bvq2eA4
	 3ZDdRCbvGGACdADnNNW4d/wtVrhDPB2XE2uD0SmEasS7DGPhFj3cgdkcGwSdRCuiD4
	 cCm1pIxmg+0gUyjUQqPYR6gZcvXbtAlmYGk2sE1l7eNOPC4Ckf2+TTtnDaoUEUDdzC
	 IseMuqqLhWI96zP8EFohiTiIpunWRvAM6uy07qWuXUEbtEVqnAf087MvfFriRGhixw
	 AcKV2Dhy59Lcg==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	jack@suse.cz
Cc: Christian Brauner <brauner@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org,
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
Subject: [PATCH 5/6] fs: allow pagefault based writers to be frozen
Date: Tue,  1 Apr 2025 02:32:50 +0200
Message-ID: <20250401-work-freeze-v1-5-d000611d4ab0@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>
References: <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=871; i=brauner@kernel.org; h=from:subject:message-id; bh=VvL58nItWEHY6IVraVsEyEezYA4/drjDHy8bBXigLc4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS/NrGdL29xpkQnZp9ExoTU6XfTLYRSHjQ68CRt++veo nDpvmZTRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwER+hDAyvDgrtzNtxyTr/ylJ x9fuq5hom/lGkq3O1qnrrP2pzKuFagz/g4+WrlxvyLVxiVxzmPHxRUfdwspndixdWvBJ7orjuwc d7AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Otherwise tasks such as systemd-journald that mmap a file and write to
it will not be frozen after we've frozen the filesystem.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/fs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index b379a46b5576..528e73f192ac 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1782,7 +1782,8 @@ static inline void __sb_end_write(struct super_block *sb, int level)
 static inline void __sb_start_write(struct super_block *sb, int level)
 {
 	percpu_down_read_freezable(sb->s_writers.rw_sem + level - 1,
-				   level == SB_FREEZE_WRITE);
+				   (level == SB_FREEZE_WRITE ||
+				    level == SB_FREEZE_PAGEFAULT));
 }
 
 static inline bool __sb_start_write_trylock(struct super_block *sb, int level)

-- 
2.47.2


