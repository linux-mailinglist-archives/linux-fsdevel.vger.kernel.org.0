Return-Path: <linux-fsdevel+bounces-45850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB13A7DA76
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 11:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BAD21776D0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 09:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E08233725;
	Mon,  7 Apr 2025 09:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+KLSyl4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EDA230BE3
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Apr 2025 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744019687; cv=none; b=f0Ic+QojGYMZf0YtFxteU/OiMciCl4brlxGHGoKpzAFnmHJr9ZxkntuSQXV5Y7yxl2OoFthc82AUk5I+3fiebruqmb1cqmLQTHsnC6B4XznRlmeKH6azlOeDmIyUgRNGc9542yjFPlQPRSU6AjaJHT1s+cAK9w+vha8+YQEJvIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744019687; c=relaxed/simple;
	bh=q4UifftWHMRvgDOR2Z7EcppRTDTM6ks/A3hEJ1YXT38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fljnmjh8VeIhgDtxUrYcYadqRlkeQqpEwvLRQFoYmoFr8cMdR+x2sbHB+waR5gYRMU2wfsLyQ1FQz+FXrtYKJ06XfY/4674TEgoUvy0OYX4eX/LPWoi3teMM0IDXSJHDi5pLXsly/CYhLXtwoHI08s168IP3ltA1NAg3ob+mWQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+KLSyl4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F79BC4CEEB;
	Mon,  7 Apr 2025 09:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744019686;
	bh=q4UifftWHMRvgDOR2Z7EcppRTDTM6ks/A3hEJ1YXT38=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m+KLSyl46OsKtVMQm40q+lHzm7OHN/uxVaK11YVdRpaJbET4Wtwq0eSyub7Am6/f9
	 VJudGf3+2B9gfPLd3IScfS23pJKywjY9U7mUPPNTxD2W961Eylr/WUHlHnRCV7EDIb
	 5Anr5gnV/Fy1NR7MHRTGbAI2wao1R8hASiMFXEoNWsbvhOQ8R7PYnnTElDajF8IIhn
	 Qo63+8svOkzHvRwHblbMxgc+o27leyFsSflUdCRnq3n/5UcClVytsppLBjLZ9Awtmo
	 G2WoRs8EGXL6f9ft7LndBihhVL+RRb+u35ptMz++DCncqfl+LqPQtYUNxQxK1BEY5F
	 MBrcM0qo66ecA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 07 Apr 2025 11:54:18 +0200
Subject: [PATCH 4/9] pidfs: use anon_inode_setattr()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-work-anon_inode-v1-4-53a44c20d44e@kernel.org>
References: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
In-Reply-To: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, 
 Mateusz Guzik <mjguzik@gmail.com>, Penglei Jiang <superman.xpt@gmail.com>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=749; i=brauner@kernel.org;
 h=from:subject:message-id; bh=q4UifftWHMRvgDOR2Z7EcppRTDTM6ks/A3hEJ1YXT38=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR/XnC9+WTlLkbpngjvmRwcSzN4BbNkxeao5qf2tmxP3
 zvRqOlKRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwER4nzMyzA6aHX5VWy3XR3fq
 56IzK8q/r/s8x8Xod1Ze+I1lv224LzP8s2jZLqudWLcm4dwG3vJJfUmfw4zvvL2Uf6PhXsVXqae
 pLAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

So far pidfs did use it's own version. Just use the generic version.
We use our own wrappers because we're going to be implementing
properties soon.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 809c3393b6a3..10b4ee454cca 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -569,7 +569,7 @@ static struct vfsmount *pidfs_mnt __ro_after_init;
 static int pidfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			 struct iattr *attr)
 {
-	return -EOPNOTSUPP;
+	return anon_inode_setattr(idmap, dentry, attr);
 }
 
 static int pidfs_getattr(struct mnt_idmap *idmap, const struct path *path,

-- 
2.47.2


