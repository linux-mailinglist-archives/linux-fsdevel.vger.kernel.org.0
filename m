Return-Path: <linux-fsdevel+bounces-20728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E478D74AC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 11:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55155282337
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 09:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1930374CB;
	Sun,  2 Jun 2024 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rN6lHVAh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D061029CFB;
	Sun,  2 Jun 2024 09:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717322221; cv=none; b=mvU9Z79E12NVvPOtSbOuU1c6IKKfub04Anr7RqyM+H+C57OJzuND1sWVDr05cqmbOyN3x11Dh8n1gNLGZMQbo3y8OUxzq38ys1iS7whpiOnWAVZGxCuUyM2hja4DbuRah5OSqTm9CP4nPONfdpIjg+V5whCxiLu1FLlkkEUDhHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717322221; c=relaxed/simple;
	bh=94oYn28sQMThSshDbznH0NXY+/CnYNyP4bnXq2olcDk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=p8o8IBus637dG2v1TOAjY/rljDFS0wMiV54P+AJGRq2IuysiF3gy8btImbySY4iIZVYj9WZVlmIIN5RqgTY0sm/ZJ8BEk78yF6bb6z7hYDLvwOGe0tUuKnMGx+8STm+QLtoZKPRO0pNQIbqln2toIATmaa/ZT6wcBq1/n6wURMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=rN6lHVAh; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1717322216; bh=yAGaiayGKFE1lZ7KHZ0iKdH2nu2needeaNKQWb5vLMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rN6lHVAhUCv1Igea2g9RpSjmIxYJ7JQeKqdMoerloOQiRAVMMd+XqkNdDC94SIK+j
	 ouzdtD6C/kjqT5Gt2/h96zj+gFfwxSbF0Tf4lqe5IxT19AxOOFzI8dZ/c/bw4LeEER
	 7E4US93CeX0N7TjkW33WI0ueWS+GUA5S+7HGJzF4=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id E352E24B; Sun, 02 Jun 2024 17:56:53 +0800
X-QQ-mid: xmsmtpt1717322213tn7qbsm37
Message-ID: <tencent_706EA97643BAE446F774577CA6D6536A0305@qq.com>
X-QQ-XMAILINFO: NDgMZBR9sMmapMNs4lAv6xsi5CZUvaxRTgDCnQpuxpUhHgwEi1dv+P3x72iO2i
	 LjqWnzgBB0bGwr4vQJo2P58jK7IvrUD3ZGLdzHoznl65zQyNZnR6bUGbFhnkxsyZiDVqLObZ21m5
	 Pms/pqYoXeoJZY0ub0vG6vzUX4yPZl+9i/GNAN0l7VBJb+KCZMwTOLwZojDBM8yZ8VKfQNMyNKyk
	 jLo/iOv/OahfzPX5kzLm21SH/xJEBwWu/pHOTD0f6u6NV8bUDv84hwhvMbsC+l9wbgfoiWZx5YC1
	 /l8hkbngeid7iKGV0pLxsI83ha1jN3/DlKV0XopX/PO0J/dOg5rRVRvyzcU7j/XwxMttNpfsrWVE
	 7AdEH0Vqy4qz5IqcKn/Dc9VGyxgN2ZEM/U0LPdE1eHUk+v8ylM8LRBkILwqCB3QzzwUBJZz8EHEo
	 lJM4dNz9v6FMClC0s3/1HE4VzyiDrrwjmACDwdc5OKXLj8yYnQHVmYgL1oyEV32ojzrptg+JDx/Q
	 dGug62LLL3iu9d2JPOyVeK8Q4wiXFuyEcmKeQmDK7AXvhDvAhDY0hikIKT6Yes8itxYsRR7W75QW
	 lu2qlhawXpDr+tRD8yIKyOpejqph9PsCPOB8t6XWQxmSFJnAPp/xf99F+RASZwZ3fQ+AHdWAz5T1
	 anPtmWzLh9IOBuNiO1EZJPpNR/JHZhLwK3DL5sgai3csWhQ/5AAiOalHROQRL9lGKZpsov5K6WRn
	 GSuYsQ5xo9BOOd+nn/u1yS5YyffqtuPHtzvcanq10EKAUa13l/J121mCfofqFlLa3FdnjjDBKDiI
	 QUrvJrUQSXb1BxsTB6GcuoZZPEYHLB1elYXAEXBhn0e+vbKQsxN6QNIE1Hyk3VqZ/IhJqiDhTjL1
	 vaVteTmfVMYrf/NvTGU0qnJ91LYCNTT6rAZ808YesXFil+M4ADlfz0SY96I2gdnU/oaXIKkaMh
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com
Cc: almaz.alexandrovich@paragon-software.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntfs3@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] fs/ntfs3: dealing with situations where dir_search_u may return null
Date: Sun,  2 Jun 2024 17:56:54 +0800
X-OQ-MSGID: <20240602095653.1544037-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000f386f90616fea5ef@google.com>
References: <000000000000f386f90616fea5ef@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If hdr_find_e() fails to find an entry in the index buffer, dir_search_u() maybe
return NULL.
Therefore, it is necessary to add relevant judgment conditions in ntfs_lookup().

Reported-and-tested-by: syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/ntfs3/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 084d19d78397..293c37171d97 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -93,7 +93,7 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
 	 * If the MFT record of ntfs inode is not a base record, inode->i_op can be NULL.
 	 * This causes null pointer dereference in d_splice_alias().
 	 */
-	if (!IS_ERR_OR_NULL(inode) && !inode->i_op) {
+	if (IS_ERR_OR_NULL(inode) || !inode->i_op) {
 		iput(inode);
 		inode = ERR_PTR(-EINVAL);
 	}
-- 
2.43.0


