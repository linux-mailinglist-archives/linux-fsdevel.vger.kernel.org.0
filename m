Return-Path: <linux-fsdevel+bounces-10828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC64384E8FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 20:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7858287435
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 19:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC80B381B3;
	Thu,  8 Feb 2024 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUkSyufh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C39383B5
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 19:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707420846; cv=none; b=qSsyF+BnGfW6EPL6Rcx2Q7A5nQgBuj75hltDxVQjYbJA1mE5ytlujlgDpH27C3VM05+Ce+9DHGvadq6R51SAsX+PqbQ26NMBYqS7xzy/PsHv9DuWQ/6LRHURMnguajyt727JD3oryP1wbv5wYcOgc950iLlK/MZ12PS0engxY3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707420846; c=relaxed/simple;
	bh=+Z8lwzYvckFWiP6BYN7U4cbT3GpIw1MQ1kqj+vQrUcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFqudsN5qAnKe9UUuky96jLLv5SZsLn4opBP7TDSF7cPMf8dqAY6AiFgxNo0gqUn8qEJ147WRytga93kEkMsUkW56LUSMz56qDRawwIcWDRvUhIPxndxo8SHYAYqFloXYUBw4n1lsHFzVIPLTsh7n4NTf38kYR4gkGov+O21sRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MUkSyufh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707420842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aD5G43Xjkg+KfiRuemAiqEi3KXzjNIYSfelc8YcP8kc=;
	b=MUkSyufhQ/L3Z2ZXL+mSI/6Cm2D94Tb8WUK8xPJWU10LQE3uxwffYYxLCSYl4a3RLyAazP
	Mo3jA8Izlsm9uoaEfLAG0sh/zHUSH+0DODiyemV1RCokA+2zyHbRAiRBJP6IN1BeF4CVL/
	o4+h6XIjODYKREOqT7ovzXyZcSZX0bk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-5dtf-tMLPp6mIZwW96qeNg-1; Thu,
 08 Feb 2024 14:33:59 -0500
X-MC-Unique: 5dtf-tMLPp6mIZwW96qeNg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A2413C0BE47;
	Thu,  8 Feb 2024 19:33:58 +0000 (UTC)
Received: from localhost (unknown [10.39.192.44])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9FA9B112131D;
	Thu,  8 Feb 2024 19:33:57 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Alyssa Ross <hi@alyssa.is>,
	gmaglione@redhat.com,
	virtio-fs@lists.linux.dev,
	vgoyal@redhat.com,
	mzxreary@0pointer.de,
	Greg KH <gregkh@linuxfoundation.org>,
	miklos@szeredi.hu,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 3/3] virtiofs: emit uevents on filesystem events
Date: Thu,  8 Feb 2024 14:32:11 -0500
Message-ID: <20240208193212.731978-4-stefanha@redhat.com>
In-Reply-To: <20240208193212.731978-1-stefanha@redhat.com>
References: <20240208193212.731978-1-stefanha@redhat.com>
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
 fs/fuse/virtio_fs.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 28e96b7cde00..18a8f531e5d4 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -270,6 +270,17 @@ static void virtio_fs_start_all_queues(struct virtio_fs *fs)
 	}
 }
 
+static void virtio_fs_uevent(struct virtio_fs *fs, enum kobject_action action)
+{
+	char tag_str[sizeof("TAG=") +
+		     sizeof_field(struct virtio_fs_config, tag) + 1];
+	char *envp[] = {tag_str, NULL};
+
+	snprintf(tag_str, sizeof(tag_str), "TAG=%s", fs->tag);
+
+	kobject_uevent_env(&fs->kobj, action, envp);
+}
+
 /* Add a new instance to the list or return -EEXIST if tag name exists*/
 static int virtio_fs_add_instance(struct virtio_device *vdev,
 				  struct virtio_fs *fs)
@@ -309,6 +320,8 @@ static int virtio_fs_add_instance(struct virtio_device *vdev,
 
 	mutex_unlock(&virtio_fs_mutex);
 
+	virtio_fs_uevent(fs, KOBJ_ADD);
+
 	return 0;
 }
 
@@ -977,6 +990,8 @@ static void virtio_fs_remove(struct virtio_device *vdev)
 {
 	struct virtio_fs *fs = vdev->priv;
 
+	virtio_fs_uevent(fs, KOBJ_REMOVE);
+
 	mutex_lock(&virtio_fs_mutex);
 	/* This device is going away. No one should get new reference */
 	list_del_init(&fs->list);
-- 
2.43.0


