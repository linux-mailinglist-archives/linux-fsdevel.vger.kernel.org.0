Return-Path: <linux-fsdevel+bounces-46432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47B5A895AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 09:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF1EB1895B17
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 07:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7D92798FA;
	Tue, 15 Apr 2025 07:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDhncvfE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B371FA85A;
	Tue, 15 Apr 2025 07:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744703518; cv=none; b=i8QRcaJfxlxUZF7NMv0ZcSKPhKXoYSyFdMLzqMygdnf+j+CFJwamqXGVfOqoH8PK6kGrSrwgUUfqhIC/zg6D5dm/fSp/BHd2TJt7xSdn1Msn0Md5m2/BQcwYdyb7vmh6CcQ0WUs6Yo457CNipOi8agx5CvE3w60GuJwzichtl8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744703518; c=relaxed/simple;
	bh=Fno2NHX5KShUIfXw+iyuKE1mn5wmdQf+cfhOcyeOjlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ifOi7wYUwNH4o7DfpMXIP0yL8iI8AbundXTIeqJLeEpz8903yAfDmVz8DkFw70rbtzMjDzOyzuDcg8zuvJNobctEs/s4YfIIzIQrtZoIiIvcAQNhDIW30jvG/G+NrdzzPvHGO9xP0+OCsE/Gw5fHNfH7x4SI734iLmTlHkKDFcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDhncvfE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1165C4CEDD;
	Tue, 15 Apr 2025 07:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744703518;
	bh=Fno2NHX5KShUIfXw+iyuKE1mn5wmdQf+cfhOcyeOjlc=;
	h=From:To:Cc:Subject:Date:From;
	b=tDhncvfEiXN8JFjpy8hkD0kP/9Ai38y/8aM8BiDwlBzhLm6s+Dztk/4U2/44FABf4
	 tvNWXJk4RZoUy8mQFxLetYG9Mnh5oiNVRv4yr6H40ZFblj6cGKWNFj9fqISU6JejjZ
	 ttrXGbw/QS7hhuF45AFtOjPpHXuAL/yRAinzCp8GnCmAKY79dKn/BMkPuXVCaSUNNQ
	 YSD4ABf9BDuFuoNmvfCD+A6I1QG1wHnpzRJ5dEnpuiKmBEoMzPJPsjyp3M/mHbwzg1
	 iFqTFchu7Vpz9lsiPOiaGWoUNX+NDbMZW7mfdA6N0mpDU+59KUwUB7c67jdT+paY2z
	 ypErbadFPDnJQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	David Sterba <dsterba@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Josef Bacik <josef@toxicpanda.com>,
	Sandeen <sandeen@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] hfs{plus}: add deprecation warning
Date: Tue, 15 Apr 2025 09:51:37 +0200
Message-ID: <20250415-orchester-robben-2be52e119ee4@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1301; i=brauner@kernel.org; h=from:subject:message-id; bh=Fno2NHX5KShUIfXw+iyuKE1mn5wmdQf+cfhOcyeOjlc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/ExBwjBT6/K9nx9P4jMexSbNfC84v53d9kp3Ud3Gre Mc+piM3O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyV43hr9QRleTtS+OefXru ozGr9x+vcxTXZOPqmuZKzuq/NyZ0PWL4nyfYOf+HVE/S/RD2ilvVT13WraiLlNR3ZJYVvKY7myO BGwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Both the hfs and hfsplus filesystem have been orphaned since at least
2014, i.e., over 10 years. It's time to remove them from the kernel as
they're exhibiting more and more issues and no one is stepping up to
fixing them.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/hfs/super.c     | 2 ++
 fs/hfsplus/super.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index fe09c2093a93..4413cd8feb9e 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -404,6 +404,8 @@ static int hfs_init_fs_context(struct fs_context *fc)
 {
 	struct hfs_sb_info *hsb;
 
+	pr_warn("The hfs filesystem is deprecated and scheduled to be removed from the kernel in 2025\n");
+
 	hsb = kzalloc(sizeof(struct hfs_sb_info), GFP_KERNEL);
 	if (!hsb)
 		return -ENOMEM;
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 948b8aaee33e..58cff4b2a3b4 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -656,6 +656,8 @@ static int hfsplus_init_fs_context(struct fs_context *fc)
 {
 	struct hfsplus_sb_info *sbi;
 
+	pr_warn("The hfsplus filesystem is deprecated and scheduled to be removed from the kernel in 2025\n");
+
 	sbi = kzalloc(sizeof(struct hfsplus_sb_info), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
-- 
2.47.2


