Return-Path: <linux-fsdevel+bounces-23100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981D8927287
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 11:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17000B22C1C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 09:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001EE1ACE87;
	Thu,  4 Jul 2024 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ai2oXlLH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642B71AC45C
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jul 2024 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083529; cv=none; b=QCgnc2xFu0s+q9t5tV/LtJftLNjELV9U4g6UglZJYKmptkoD/sc6UvXv6fIDWGE+IY3f1Z0IApx4SP2wiEXDaNYObjK8f5SREutmGianUyc7sKrjceoKA/Z4i/GlrOaLUjAAouAfBZpupRa5ZRz4n0tJiXomxzC/JmeoMeTLinI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083529; c=relaxed/simple;
	bh=Kr2gsl0KWq16HAoswiQtFybIe5Ye2xCYwxaBRZGtR1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lQWMF8L9ADCklrVBBKe9f33foKor0zqHVVZ93CogG4KkyJyWL83eBNfPqqP2hHNVmavupyg4OT26HWHMdnRNfbw4Xf2XcUMNx9Fa//wbtxZOxfI26WndMLVzsrA3eaMAHlE12WKk3iTX+fBd/pAYDsaXJI2QoCnEwzjWTAeygH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ai2oXlLH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800B5C32786;
	Thu,  4 Jul 2024 08:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720083529;
	bh=Kr2gsl0KWq16HAoswiQtFybIe5Ye2xCYwxaBRZGtR1E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ai2oXlLHqOLJv4sSiw1yKhgbgW6bfHxpa6M8zDnfNOI2qLAeUjzGK1WG3FNapxWhE
	 FZEM/ja9MgEFLEtuIdTKxiqZfD9XHSgdBidMtvpAu8IliRyCDz4fUH+91t7gn/J73R
	 h0XAsvRuRV0mFfLECQG6J6/8QHy4tCzAZK/FaQff1ZQfEl6yTdE4ChSpXBS+9p8/VF
	 B6R0l5+VL+jaaYmTfZlIByOfDnCwZ/SPDi4cOnlPjhM+RXYb4SmIZVKJ7qZJPbaIvz
	 K40qQ/nhlrN7/zS8G9drzfmGGqkzqD3GtEJsa06//+WbeVf75SwPrryBlwDglrTWE+
	 WRngTt5RXXIxg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 04 Jul 2024 10:58:34 +0200
Subject: [PATCH 1/2] fs: refuse mnt id requests with invalid ids early
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240704-work-mount-fixes-v1-1-d007c990de5f@kernel.org>
References: <20240704-work-mount-fixes-v1-0-d007c990de5f@kernel.org>
In-Reply-To: <20240704-work-mount-fixes-v1-0-d007c990de5f@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Jeff Layton <jlayton@kernel.org>, Karel Zak <kzak@redhat.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-13183
X-Developer-Signature: v=1; a=openpgp-sha256; l=1177; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Kr2gsl0KWq16HAoswiQtFybIe5Ye2xCYwxaBRZGtR1E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS1pbjmhsayuyfJC7lIt97uTOx/vZlj1eyDPr5PNpSaL
 jDjnj6ro5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCK9XYwMjeV+GsWH1zL1NOzO
 cGNb15O06dqKe5w57ppsc5InrneexMhwvuqRF8MCXxnhzOAjNhdPOMdc+TAlveGAK5/qWQ+TqVr
 sAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Unique mount ids start past the last valid old mount id value to not
confuse the two so reject invalid values early in copy_mnt_id_req().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c53a0ee748c6..a0266a8389d0 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -70,7 +70,8 @@ static DEFINE_IDA(mnt_id_ida);
 static DEFINE_IDA(mnt_group_ida);
 
 /* Don't allow confusion with old 32bit mount ID */
-static atomic64_t mnt_id_ctr = ATOMIC64_INIT(1ULL << 32);
+#define MNT_UNIQUE_ID_OFFSET (1ULL << 32)
+static atomic64_t mnt_id_ctr = ATOMIC64_INIT(MNT_UNIQUE_ID_OFFSET);
 
 static struct hlist_head *mount_hashtable __ro_after_init;
 static struct hlist_head *mountpoint_hashtable __ro_after_init;
@@ -5235,6 +5236,9 @@ static int copy_mnt_id_req(const struct mnt_id_req __user *req,
 		return ret;
 	if (kreq->spare != 0)
 		return -EINVAL;
+	/* The first valid unique mount id is MNT_UNIQUE_ID_OFFSET + 1. */
+	if (kreq->mnt_id <= MNT_UNIQUE_ID_OFFSET)
+		return -EINVAL;
 	return 0;
 }
 

-- 
2.43.0


