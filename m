Return-Path: <linux-fsdevel+bounces-45226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50B4A74E69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 17:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075743B95A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 16:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414381DE8A7;
	Fri, 28 Mar 2025 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDYpcEGa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA451DE880;
	Fri, 28 Mar 2025 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743178585; cv=none; b=q1ZU5e8wwnK4hnSenYgnzmSYk6aKxHUSfMeAnXFr/gearVYLbnqakXLOd0jZjbHtwspF0CfDCGF3o6190MfeGPoHBITTR6+JvW+oh/0OM2kDefnmBPv41d3hNKoFD5r5t0y4AMnAxTCRv2LQqu2eJNeEqXfppC2Ec0Qb1d10NeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743178585; c=relaxed/simple;
	bh=VP5XAT1jJt6izLv0u8XXhMb9Lleyzfaa/ssDFxRDreY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jCl8ZbIa5EX20LlUocYWknV12QFY4MGhShD/AGzGZUOCKd8VD4vkjHgaOu1wJJ53wv8FxtKInB6GSjy3iRP9wBxy/zwiLaSkJ9R0tFwuP5Rms0Dw2mTKMx1stuKP+v5FwRpz+Tla9uAVgpKVUGMmgFqsWV9hE1grZbNElSR7ErA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDYpcEGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25026C4CEE9;
	Fri, 28 Mar 2025 16:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743178585;
	bh=VP5XAT1jJt6izLv0u8XXhMb9Lleyzfaa/ssDFxRDreY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IDYpcEGa1GfZwLOMaP5X0GexBFrkaAgfBFPZgK/TDrfW/ySSG+wWHwbCf4Qsj93Dk
	 KodHubbCOZcTP8GFAaF0YKhkmSFGq549eowFWgKViPOBtV267dsWSIFJSa7VO2ePIt
	 xgPXsWjsSPGC9+ix9TjiWHxkkKlrfUap73bHIvktpFSRqzFsmBlXKi2dBVzSOI4cXJ
	 nD4n1Rp66CO9kontBgvKUkmJKqyiU6xFg3ORSKBAqUB4qIW5roCA4dd1eucUZ0Cx8h
	 PWZIXvoDs+BQEfK6XasD+mmgUkpQ+iHIzS4f0MOLChtc/zomSi4T7TWucJ5pOX2TVe
	 EBC0vH60BKRvw==
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
Subject: [PATCH 3/6] super: skip dying superblocks early
Date: Fri, 28 Mar 2025 17:15:55 +0100
Message-ID: <20250328-work-freeze-v1-3-a2c3a6b0e7a6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=870; i=brauner@kernel.org; h=from:subject:message-id; bh=VP5XAT1jJt6izLv0u8XXhMb9Lleyzfaa/ssDFxRDreY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ/O+0ko9E1857HZo/LQgW3jrzuXHk5M6BWyb5dpP7cT wFOz1k/OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZypJKR4bzQzc3SqwRtNjoX r6/+85t9XpIy47rfYRw/15W3epwuWsfIcOOjo7xiU7R5pu+XsIA3b+4m5y7T4fPzn/9aVXkjv7g uOwA=
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


