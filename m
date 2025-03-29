Return-Path: <linux-fsdevel+bounces-45258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A26F5A75531
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 09:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42BB63B0329
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 08:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8261B6CE9;
	Sat, 29 Mar 2025 08:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b96694e7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453DA149C55;
	Sat, 29 Mar 2025 08:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743237814; cv=none; b=QLB1HyetvRNbzeitdxiUT1pdNgu4saj7S1f7oOsMTRGTrPzcUFiM+ld9rkJKZLPH/TEwoaYVa8Ki2SJriQAWz5mGf+nk1wlKxBlhIn8NjbRrIgDs/oCyPiy2DQvWkM+xYjWBgydWr2M0gH9o9UDooFEWfq350cb37FIKOsI3Fq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743237814; c=relaxed/simple;
	bh=VP5XAT1jJt6izLv0u8XXhMb9Lleyzfaa/ssDFxRDreY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=afB5iGsxGC8G+D2pLvs9hlQ1E8WpsBmKjHvxTdU8I+WOpgbr+/h3rAVka+ztEEdKpbHqfPXXa9J8iiPnD75kOKpRhgqrJNu24vtg1EnGqakJrRqBSwKRndeGUC5iUE1uTM5LvQM8PeaVChSA6d/avNLaJht1HyW2Mpwm4rDViMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b96694e7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7A7C4CEEA;
	Sat, 29 Mar 2025 08:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743237814;
	bh=VP5XAT1jJt6izLv0u8XXhMb9Lleyzfaa/ssDFxRDreY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b96694e7RmSxfy7fvdgNraBCu+M7g340i+aaskTJWpzwcRC+5uSgiWxlt5iLy248e
	 THqBa6TdnC3rWiPki4kTEkGMd7VzPRqqlTAL6LQaF36xv8spjBze/CTSkOjW+n9vw0
	 /PGJipVT/WvvkVUYqTp4JcT7iOOi79OIrHhwdtC6dXDEzX+9pQn1d/k2yRxKhrqJi8
	 mHMYKPdcT9plF08GdgkCT4U0iCxi1JEib7uMCeBEMfepqSrm1gDNUBAIj/Ihfz/n/+
	 Pw7zNVbObme5OaIMiaISQ1QBPM2OUpUYrjstDujE+NC7iz+wrE+wlYCh0/BtIPqmoq
	 K3Ljobtz4mLew==
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
Subject: [PATCH v2 3/6] super: skip dying superblocks early
Date: Sat, 29 Mar 2025 09:42:16 +0100
Message-ID: <20250329-work-freeze-v2-3-a47af37ecc3d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=870; i=brauner@kernel.org; h=from:subject:message-id; bh=VP5XAT1jJt6izLv0u8XXhMb9Lleyzfaa/ssDFxRDreY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ/31QhkH//5oT7BptfVQrn1Ja5+u6JSE5aufXAwy117 nuvs7p5dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkzwFGhmlnXH9z1pRO1pgn cWq7ry6reMCK0/NStBdV/uJs3av1bSYjQ3trpfhq6/+O7FJdGhNnv+w/cWFyPcOnkhl7zjSX3Hr 9ghcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Make all iterators uniform by performing an early check whether the
superblock is dying.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index b1acfc38ba0c..c67ea3cdda41 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -925,6 +925,9 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
 	list_for_each_entry(sb, &super_blocks, s_list) {
 		bool locked;
 
+		if (super_flags(sb, SB_DYING))
+			continue;
+
 		sb->s_count++;
 		spin_unlock(&sb_lock);
 
@@ -962,6 +965,9 @@ void iterate_supers_type(struct file_system_type *type,
 	hlist_for_each_entry(sb, &type->fs_supers, s_instances) {
 		bool locked;
 
+		if (super_flags(sb, SB_DYING))
+			continue;
+
 		sb->s_count++;
 		spin_unlock(&sb_lock);
 

-- 
2.47.2


