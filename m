Return-Path: <linux-fsdevel+bounces-36142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E8D9DE6E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 14:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07696165824
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 13:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1191A08C2;
	Fri, 29 Nov 2024 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjhtfZk0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A381A0706;
	Fri, 29 Nov 2024 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732885368; cv=none; b=E8iBz4HKMq2ac/fPvQIuYQ3OL9c8rY7N48zYA07pW7FqiPWh7v3NXDgqJgEIGxsKvQYiJ8sa6iaIDBMUSt1oOIVeFLiu8NGQXheC6UmcF8hCQbr+BUDglwqZGDebHOWT6s3lw/B2heuvtfLIl7a9txLtG/SThF3Jye0bNMXYels=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732885368; c=relaxed/simple;
	bh=XhmuC7UVdeZQ/uhtuvNv/UVaqirRNFdh/oaaipVsfRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ksNrrKaVRLg4+dMsk1gZyGO60BUAXwDBUCLldgVBQx+6ZF14Alwtn8KpmM2eaRNDLjiR4oajF8CRvcYTIyKOcXxRtVQpP1KTTwIpO/cAiJgAbsqmwAnt8fopPj3vbKcOYHvsGxVOrssh3f3mMCax2BRkYGmiDVQewWvC0JYxjYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjhtfZk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822C2C4CED3;
	Fri, 29 Nov 2024 13:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732885368;
	bh=XhmuC7UVdeZQ/uhtuvNv/UVaqirRNFdh/oaaipVsfRc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PjhtfZk0ennq7ZEBI3+NGUEphXnemG+VidNwx9FE+hkrKfDt9MTutasl3vul6HEH+
	 KJv05nzfWr60w5OSpPjxse9GAzTWTj5dqP8HoJYsw82W4HyRIF/YGG7djNLFsMqVrT
	 bLeMX+VQClxY+c4Q3zzIvF0f0X9VP6VlBDauUyvlIeAHM0ei/8mOd5hW3LgGlnh7iY
	 rWgAnHs9RXMFuvc8mLO5qNdU7nATeRaOpO/sWFRwTRuOwtIhL/WjIWdccBdyApKycO
	 L569FAsPY8L5UeEPZLklnRDtghKVfHSwMSvTDyxYQdNjQJweuRycg+KS5NlxywLiNh
	 xvRYqlZ6XU+zw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 29 Nov 2024 14:02:25 +0100
Subject: [PATCH RFC v2 3/3] pidfs: support FS_IOC_GETVERSION
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-work-pidfs-v2-3-61043d66fbce@kernel.org>
References: <20241129-work-pidfs-v2-0-61043d66fbce@kernel.org>
In-Reply-To: <20241129-work-pidfs-v2-0-61043d66fbce@kernel.org>
To: Erin Shepherd <erin.shepherd@e43.eu>, 
 Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=871; i=brauner@kernel.org;
 h=from:subject:message-id; bh=XhmuC7UVdeZQ/uhtuvNv/UVaqirRNFdh/oaaipVsfRc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR77s5tbp6xN6bja/mff2rpykf3G+xxPrP468e6h6FFz
 U8ZDrNyd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEx4SRobv80VcDX2+mpFiH
 go2/N7OecnU4pVh0YLGJc11JV+MHTYb/XsG5bF0ML/+o582x3Z6z9Fvi7K9d6SHdM+d+W+vjqH2
 ZEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This will allow 32 bit userspace to detect when a given inode number has
been recycled and also to construct a unique 64 bit identifier.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index ff4f25078f3d983bce630e597adbb12262e5d727..f73a47e1d8379df886a90a044fb887f8d06f7c0b 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -262,6 +262,15 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	if (arg)
 		return -EINVAL;
 
+	switch (cmd) {
+	case FS_IOC32_GETVERSION:
+		fallthrough;
+	case FS_IOC_GETVERSION: {
+		__u32 __user *argp = (__u32 __user *)arg;
+		return put_user(file_inode(file)->i_generation, argp);
+	}
+	}
+
 	scoped_guard(task_lock, task) {
 		nsp = task->nsproxy;
 		if (nsp)

-- 
2.45.2


