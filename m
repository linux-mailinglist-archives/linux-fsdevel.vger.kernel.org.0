Return-Path: <linux-fsdevel+bounces-18858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E728BD4F4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 20:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EE7DB2175E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 18:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A519158D99;
	Mon,  6 May 2024 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Na8EYDvI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F29F158DA4
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 May 2024 18:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715021698; cv=none; b=lvojbW1ySFdjtXute8mTzEb08Rhpqqd5ELzmggCfyxsZFsiGBXjjYQhVuxZfDwXjcuNn1S4h5I18JE8BX1RRH1PNpdCFLUEKKK3FkTen6wqQmWKhxwcc8TGJ3WAjPQHh4/sAfO8aBxsKYN6yGbczLcu9YXuUfhRQmXvcfL08vZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715021698; c=relaxed/simple;
	bh=8QNWl+kq+KG3kN9sHe7MzKaNmeEI1Lwj7OO22VrCnF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S7eKqCoxWWfkN0c/esvihDvfehZy1paGYNbawHgXUU+5wbmOXnIcbQYW32ozObD2XHC/pl4LL8rnejFskrxZqI10RPhDcKf7h3g2vl3RO7C789nZMwefRTjf6d7KZCUywlDaUZe2YXEL+/vioAm7Cqf3g2IrWpsHgB3FR/8bD7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Na8EYDvI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715021695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yZa3ZkGGy+EGoL1mcGuJ1l+5Ncq+o7HM3y58wJO8brs=;
	b=Na8EYDvILF/kD86LMTeD7nL9usqLkTGAn/iJ/GXEkP9RrtPHFW/uUqqjBdlyvKsy3Spv3w
	94vaZoLYUwon9uUYrdvwBqwhImy8egexQnevbtA29RfOv7NMqMRsnsw3PGjarh/mu65uZZ
	OzvYrLZD4eCeAnACbyD1zV3mN4CF6PA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-vRr7tvt9MXSVt-RCXW223Q-1; Mon,
 06 May 2024 14:54:51 -0400
X-MC-Unique: vRr7tvt9MXSVt-RCXW223Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8AF629AB427
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 May 2024 18:54:51 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.32.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3D5E9200B08F;
	Mon,  6 May 2024 18:54:51 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	vgoyal@redhat.com,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2] virtiofs: use string format specifier for sysfs tag
Date: Mon,  6 May 2024 14:57:13 -0400
Message-ID: <20240506185713.58678-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

The existing emit call is a vector for format string injection. Use
the string format specifier to avoid this problem.

Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Brian Foster <bfoster@redhat.com>
---

v2:
- Drop newline.
v1: https://lore.kernel.org/linux-fsdevel/20240425104400.30222-1-bfoster@redhat.com/

 fs/fuse/virtio_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 322af827a232..d5cb300367ed 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -170,7 +170,7 @@ static ssize_t tag_show(struct kobject *kobj,
 {
 	struct virtio_fs *fs = container_of(kobj, struct virtio_fs, kobj);
 
-	return sysfs_emit(buf, fs->tag);
+	return sysfs_emit(buf, "%s", fs->tag);
 }
 
 static struct kobj_attribute virtio_fs_tag_attr = __ATTR_RO(tag);
-- 
2.44.0


