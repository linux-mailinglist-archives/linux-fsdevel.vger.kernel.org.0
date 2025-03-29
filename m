Return-Path: <linux-fsdevel+bounces-45257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4521A75530
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 09:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763663B1185
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 08:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81B21AF0D7;
	Sat, 29 Mar 2025 08:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQd3Vexi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22847149C55;
	Sat, 29 Mar 2025 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743237811; cv=none; b=nBF+669OZbBy7QvAXkRi5ClMGsPQOVU2gnyn+VAr5ABO19t/he9kLc+AR6ljfUIOkwq8SaEhYlHl2FJ1HAU2d6TNPD2hR0fsxCUOPIzKvSkZUmgBMzOG900ZbHwxLhz38iU+2BjydmKNhs+x1HxP8ede51od/1PMaNwGo9/k9M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743237811; c=relaxed/simple;
	bh=kQuw8pGOEj2HTHUntYvMH05/2F/1BJUoN/04q2b6wh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZqgB74JGG3qTuLJq5Es6oCTpnU7XpysbMbHd9ecO5WJ72fHnVqp+Wkcwvonh13+niG44mu89Oan9b8E+ourubm7f7DlFoiwUByqhSLZYw0KNxkcVmpgkAPEPJlXm6dj73KgQ7N1T3kDb77q2WX2+mWMPLSosX3DkrDYB5F6EHYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQd3Vexi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6635AC4CEE2;
	Sat, 29 Mar 2025 08:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743237810;
	bh=kQuw8pGOEj2HTHUntYvMH05/2F/1BJUoN/04q2b6wh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZQd3VexiVWW45/tPrzn4z53ICI/yI4hXlkvQWMGi9f7+TsCseipYM3bhpc87RC5Fl
	 N1kqpwdysJTtj5pfULoYdZ8AlHvDQcMD30Ei3GPWDTZPhIS1Y+V/li++1kTbvsbNga
	 ACztT2owrfeM4ps0AIxltTqShzELNOp4+Fv2+wwW0zYS8ZXCkjH8QG87HrcSh2n2I6
	 chQ/JBwWx2y2N9g7VCGSrurCSIb0NI00BnHNn9GRA10nh+N0SQCy8u262NFQMoxSka
	 oLnMGxkH02XGC/4ho0gP78sOrwjy77CVXLRvTWvkP8R3RcSMipsrcnX2CwI9kANRo0
	 cw+Lw2H30aTyw==
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
Subject: [PATCH v2 2/6] super: simplify user_get_super()
Date: Sat, 29 Mar 2025 09:42:15 +0100
Message-ID: <20250329-work-freeze-v2-2-a47af37ecc3d@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250329-work-freeze-v2-0-a47af37ecc3d@kernel.org>
References: <20250329-work-freeze-v2-0-a47af37ecc3d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1111; i=brauner@kernel.org; h=from:subject:message-id; bh=kQuw8pGOEj2HTHUntYvMH05/2F/1BJUoN/04q2b6wh8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ/31QxY+6rvZ5B5y0OxHG/dJkr/UHibIQuu9Lng0XLm 9WzXpes7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI02RGhtmMp+MWnpuZv5lp V7JMzYeLq2Nzvc2nzrjnVrOwr4e56xbDXxG3QHc1W8M3purfGZf/5QmYturhGWfRY10MDe75y13 fsQMA
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


