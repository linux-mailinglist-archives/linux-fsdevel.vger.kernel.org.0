Return-Path: <linux-fsdevel+bounces-10951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C2A84F51F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 13:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820341F22B25
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8099336133;
	Fri,  9 Feb 2024 12:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VrHhjKzn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500F73611A
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707481181; cv=none; b=KJ/a6jMyIBYSH6pPLcLKna8FY7l3HHkCuMpoMKJtRPm10kwr05Tfh2xmCQjNfLAsxhKPdT6j9ej+2QPWGOLkGai6ug+W+S1iqI0EfuwBbY2ijuVo8sp8A7KfB5xnLhP32aaz00KC86/i5zxdZSAi5t/iQtt6QnYAAr0nse9fzx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707481181; c=relaxed/simple;
	bh=Rnjg8UYrQkMr0LoNZ+6Py+M+X4Uhd+jX+nS9oqTVy4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwRV+8ueiXiu2jWVsZ6O/ikP6bR+WK8J+VIvJ0+RWFIzQ9DP8NoZwjrKE9lhAIO1Bcs7g6IvNSgzf5qHAxlJ2kswjpx3+KDWaTnmvVrg7uX9RarxMVWq1iWnr8cYQXtEs3lLQ1y//RCWWt4ScywD3xMakvY98dnxhi8Mw/0Rtrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VrHhjKzn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707481179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGHyzkUs9lP9+Ur11qjQwt2Rk1b/jcG9atbOexBoWEY=;
	b=VrHhjKzn2WWubUOc7WT11HhuSMsYloW/Kc5PdmJ2UKzyKhwnTrvwLTU+wlX7oLpcZpJzRx
	4OZuuzHguv68xNfLLA1WFyVH+axxAU9tAdDlJlb5pkodKQ8jutyP5CsIfx2J1RhMeTSUoK
	GHt/OiVx32+u1ouX0w2DA9CKpp8IjLI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-i5V_3R03OhKl2sZ1HsxUwg-1; Fri,
 09 Feb 2024 07:19:36 -0500
X-MC-Unique: i5V_3R03OhKl2sZ1HsxUwg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C8E038060EB;
	Fri,  9 Feb 2024 12:19:35 +0000 (UTC)
Received: from localhost (unknown [10.39.193.29])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 02AF0112132A;
	Fri,  9 Feb 2024 12:19:34 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: miklos@szeredi.hu,
	gmaglione@redhat.com,
	Greg KH <gregkh@linuxfoundation.org>,
	virtio-fs@lists.linux.dev,
	vgoyal@redhat.com,
	Alyssa Ross <hi@alyssa.is>,
	mzxreary@0pointer.de,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 3/3] virtiofs: emit uevents on filesystem events
Date: Fri,  9 Feb 2024 07:18:20 -0500
Message-ID: <20240209121820.755722-4-stefanha@redhat.com>
In-Reply-To: <20240209121820.755722-1-stefanha@redhat.com>
References: <20240209121820.755722-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Alyssa Ross <hi@alyssa.is> requested that virtiofs notifies userspace
when filesytems become available. This can be used to detect when a
filesystem with a given tag is hotplugged, for example. uevents allow
userspace to detect changes without resorting to polling.

The tag is included as a uevent property so it's easy for userspace to
identify the filesystem in question even when the sysfs directory goes
away during removal.

Here are example uevents:

  # udevadm monitor -k -p

  KERNEL[111.113221] add      /fs/virtiofs/2 (virtiofs)
  ACTION=add
  DEVPATH=/fs/virtiofs/2
  SUBSYSTEM=virtiofs
  TAG=test

  KERNEL[165.527167] remove   /fs/virtiofs/2 (virtiofs)
  ACTION=remove
  DEVPATH=/fs/virtiofs/2
  SUBSYSTEM=virtiofs
  TAG=test

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 fs/fuse/virtio_fs.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 22d7c70ef78a..a3014fdc913e 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -306,6 +306,8 @@ static int virtio_fs_add_instance(struct virtio_device *vdev,
 
 	mutex_unlock(&virtio_fs_mutex);
 
+	kobject_uevent(&fs->kobj, KOBJ_ADD);
+
 	return 0;
 }
 
@@ -1565,9 +1567,22 @@ static struct file_system_type virtio_fs_type = {
 	.kill_sb	= virtio_kill_sb,
 };
 
+static int virtio_fs_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
+{
+	const struct virtio_fs *fs = container_of(kobj, struct virtio_fs, kobj);
+
+	add_uevent_var(env, "TAG=%s", fs->tag);
+	return 0;
+}
+
+static const struct kset_uevent_ops virtio_fs_uevent_ops = {
+	.uevent = virtio_fs_uevent,
+};
+
 static int __init virtio_fs_sysfs_init(void)
 {
-	virtio_fs_kset = kset_create_and_add("virtiofs", NULL, fs_kobj);
+	virtio_fs_kset = kset_create_and_add("virtiofs", &virtio_fs_uevent_ops,
+					     fs_kobj);
 	if (!virtio_fs_kset)
 		return -ENOMEM;
 	return 0;
-- 
2.43.0


