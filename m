Return-Path: <linux-fsdevel+bounces-36203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7919DF5BD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 14:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A126B21B71
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 13:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C301CBEBF;
	Sun,  1 Dec 2024 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkGNjEKY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A051CBE8B;
	Sun,  1 Dec 2024 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733058789; cv=none; b=eoMTUSH9YRjbuv8QJOQssPzsd83YuEkBahD8afBD31W2eUwoLTQ2xv6pxhjjx7aIrvT52i2V/ojIy1KqQwjMz4mKD31/t/QDEp3Yx/scANeoKPcgtIaLgB6LpRbwwWGq4eemnnG2WZDi908+GP3otfwpCAwVJw2e0Vt2bS31Pz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733058789; c=relaxed/simple;
	bh=N6ELxN7yqBpBUb4zPoFR5SDo9lVcqXtWjzQrppLLRkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XxC3dafp6dhFPOY7w6lV70XVst9cxKYXC8DPzszPFw3o+iSVOQrijqIrihtnK85hl2Ze0i91qOcBoNjPGhg7w4umrFSjnPiJn2IwR3q9ypzg0GIoaVxqzkuz5zdB/WjIxYj876ccFcT1PnelIvyd1r+3/E7Dt75ed3KqiU2epIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkGNjEKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D185C4CEDC;
	Sun,  1 Dec 2024 13:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733058789;
	bh=N6ELxN7yqBpBUb4zPoFR5SDo9lVcqXtWjzQrppLLRkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VkGNjEKYseyrjvPxIZLc+ApoginC05F37JMUEQvSbYdnSEC+kf6NJ/TFkkq/EdrU7
	 JDdgetmCh4E7abwwMvXG0dpoW/KRKlxqshXn4XATq9dx9oOmqosJNaQb4XfBUcfJbC
	 uTIYfLF6pIpwqeyMjh3cKxJZtrVCbyQ7YjUBJmKsBwxRUb0r4ZGVDGEVkWzQCTkzdV
	 erY5zlFWatqTRi+gpkEdX3cNntU8Ewg3cpA6/BJIbzP38d970V3IRnpYnKq4fM0XE7
	 //az4xi46J6TajE7rd9/dQFBPj2PBQ7ZsQvEzHKbTekdQdydBqqY4PSEOHQyf0J+ad
	 8rJbcmNBFZKzQ==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Erin Shepherd <erin.shepherd@e43.eu>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH 4/4] pidfs: restrict to local file handles
Date: Sun,  1 Dec 2024 14:12:28 +0100
Message-ID: <20241201-work-exportfs-v1-4-b850dda4502a@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
References: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=734; i=brauner@kernel.org; h=from:subject:message-id; bh=N6ELxN7yqBpBUb4zPoFR5SDo9lVcqXtWjzQrppLLRkE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT7JOxPZp08pYkhxnxf7Y76uy/YXy16GPtwNY+Uf+26d FGtqHerO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbiPYHhn3bj0YuxNXNt7Wf2 HtqqKDwh7nJw2ZT+/KvfH/+cP0l9eR4jw7WvFZkx34OmTyp8rzyvPPZf5UNOf5NMrjW7tkVdfMS nywMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

The pidfs filesystem uses local file handles that cannot be exported.
Mark its export operations accordingly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index dde3e4e90ea968c12dba0a0d37c95e2218253369..29c894f2792b4a5360a0e1933f850bfaf08413eb 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -570,6 +570,7 @@ static const struct export_operations pidfs_export_operations = {
 	.fh_to_dentry	= pidfs_fh_to_dentry,
 	.open		= pidfs_export_open,
 	.permission	= pidfs_export_permission,
+	.flags          = EXPORT_OP_LOCAL_FILE_HANDLE,
 };
 
 static int pidfs_init_inode(struct inode *inode, void *data)

-- 
2.45.2


