Return-Path: <linux-fsdevel+bounces-23101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 584A8927288
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 11:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC5D28D836
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 09:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBC91ACE84;
	Thu,  4 Jul 2024 08:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5OSN1cs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D47C1AAE33
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jul 2024 08:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083531; cv=none; b=njExvldEVm/FXjHsqvYDyaQO/Hp5GSLKLCDrS5yagm7DM8ptPCTN9FC525lThuNU9locwhoZZA9lnNsnsLIQeHBwJBCX6U5QZnFQUgajAQIvw0hC7NAQHhHm6QUURiv7xUyF85lYYAnwwK0pXmrIugTIKBuQ3f+7P1R0Do9JcpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083531; c=relaxed/simple;
	bh=url1KUdmMYN0advTwPvcHDOuuwv8P8fvS+v/nIBoq5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dQaRIsHWGPakWKyT1vU/3rhzsk7UC2nQEmCD0hT6bbeKo1CM7lPU2tl7uHlM5ZbQwt7jk/vmjEiddvwdMjq6uIgA5lT3Z1NibHVF7ehpmWxnhOq1+o8u6ci88iLuxsWJXCNEP7BDIsrpWk4qDeJoUoxm+5B+vWoYlnjouiSqMEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5OSN1cs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BABBC4AF0A;
	Thu,  4 Jul 2024 08:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720083530;
	bh=url1KUdmMYN0advTwPvcHDOuuwv8P8fvS+v/nIBoq5Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L5OSN1csQXT6vhu6lzLkZGoEyNJxquDPLLrzNX5buO3RPs3O9sK9nw3D4y/V/pJJy
	 CHsxg1iqEUJDdqvTMo5NIYjn8qeKXuU8UggShURq0NUd7waoDCpPrNrULoH0Ejswfq
	 yeKFuAhE/2sQoGx1zmt/ZmxzdG4eDFmw8pTVEBXZImAZXfo49utfYVXsqnwGfSIxQD
	 22KuRN0DhhfqtaOFUXmjp4DaPcPLxZtcytpwzHl0uOxr99jjbSaaRhoxZlRKoN9uIW
	 lqcj8yVgbnwKBehnGbXnEYeobd8YTqYyrCWylf9rEucPXNOFzlOICz/jm6t9WqGuFK
	 CnX/if7eqMTSg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 04 Jul 2024 10:58:35 +0200
Subject: [PATCH 2/2] fs: reject invalid last mount id early
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240704-work-mount-fixes-v1-2-d007c990de5f@kernel.org>
References: <20240704-work-mount-fixes-v1-0-d007c990de5f@kernel.org>
In-Reply-To: <20240704-work-mount-fixes-v1-0-d007c990de5f@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Jeff Layton <jlayton@kernel.org>, Karel Zak <kzak@redhat.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-13183
X-Developer-Signature: v=1; a=openpgp-sha256; l=1548; i=brauner@kernel.org;
 h=from:subject:message-id; bh=url1KUdmMYN0advTwPvcHDOuuwv8P8fvS+v/nIBoq5Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS1pbgazmpM3acgk6zqKsjdI3B2m+9Jo80x70/cOL+Zt
 yVgY+eLjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInU2jEynDyqO/ejquJeprnf
 J+5n3b/kxeqNonmrxe5WvfE12lv+6zLDH84rdxe/XP7rc6gU766GLs9f0x6fOKR92jL2lI1b0vq
 oHQwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Unique mount ids start past the last valid old mount id value to not
confuse the two. If a last mount id has been specified, reject any
invalid values early.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a0266a8389d0..e474a2292337 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5369,6 +5369,7 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 	const size_t maxcount = 1000000;
 	struct mnt_namespace *ns __free(mnt_ns_release) = NULL;
 	struct mnt_id_req kreq;
+	u64 last_mnt_id;
 	ssize_t ret;
 
 	if (flags & ~LISTMOUNT_REVERSE)
@@ -5389,6 +5390,11 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 	if (ret)
 		return ret;
 
+	last_mnt_id = kreq.param;
+	/* The first valid unique mount id is MNT_UNIQUE_ID_OFFSET + 1. */
+	if (last_mnt_id != 0 && last_mnt_id <= MNT_UNIQUE_ID_OFFSET)
+		return -EINVAL;
+
 	kmnt_ids = kvmalloc_array(nr_mnt_ids, sizeof(*kmnt_ids),
 				  GFP_KERNEL_ACCOUNT);
 	if (!kmnt_ids)
@@ -5403,7 +5409,7 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 		return -ENOENT;
 
 	scoped_guard(rwsem_read, &namespace_sem)
-		ret = do_listmount(ns, kreq.mnt_id, kreq.param, kmnt_ids,
+		ret = do_listmount(ns, kreq.mnt_id, last_mnt_id, kmnt_ids,
 				   nr_mnt_ids, (flags & LISTMOUNT_REVERSE));
 
 	if (copy_to_user(mnt_ids, kmnt_ids, ret * sizeof(*mnt_ids)))

-- 
2.43.0


