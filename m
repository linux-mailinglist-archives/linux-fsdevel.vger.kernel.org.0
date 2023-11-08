Return-Path: <linux-fsdevel+bounces-2447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4787E6001
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 22:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54761C20B93
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 21:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A5E374DF;
	Wed,  8 Nov 2023 21:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YQEZy0LW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6747374D9
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 21:33:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D5E2127
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 13:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699479226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z+L0Zj1TswrrrijQkeMOIaFwQ8WSjJs7bi3CCToDeQM=;
	b=YQEZy0LWb61onQcxf12gveYRu7cJiuRDqJHzbFx5ftRBFSDd2+JUF5M8WfdvEcdx8NVC+Z
	PvfdlHbNTY3I/okYUhZe0QaJngrvn3B5ADQIDqJeD2hvpBg7x6LoNk2FUnAqxCVfZoqYj/
	xaKkTFn+1dQCT3JBmZ4VVL7+iUFTw3U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-19cUXYYUN5mt0GiIxkjZbQ-1; Wed, 08 Nov 2023 16:33:43 -0500
X-MC-Unique: 19cUXYYUN5mt0GiIxkjZbQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9570185A780;
	Wed,  8 Nov 2023 21:33:42 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.8.221])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8AD3B2026D68;
	Wed,  8 Nov 2023 21:33:42 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
	id 02535227FA2; Wed,  8 Nov 2023 16:33:41 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org,
	virtio-fs@redhat.com
Cc: stefanha@redhat.com,
	mzxreary@0pointer.de,
	gmaglione@redhat.com,
	hi@alyssa.is
Subject: [PATCH v2] virtiofs: Export filesystem tags through sysfs
Date: Wed,  8 Nov 2023 16:33:33 -0500
Message-ID: <20231108213333.132599-1-vgoyal@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

virtiofs filesystem is mounted using a "tag" which is exported by the
virtiofs device. virtiofs driver knows about all the available tags but
these are not exported to user space.

People have asked these tags to be exported to user space. Most recently
Lennart Poettering has asked for it as he wants to scan the tags and mount
virtiofs automatically in certain cases.

https://gitlab.com/virtio-fs/virtiofsd/-/issues/128

This patch exports tags through sysfs. One tag is associated with each
virtiofs device. A new "tag" file appears under virtiofs device dir.
Actual filesystem tag can be obtained by reading this "tag" file.

For example, if a virtiofs device exports tag "myfs", a new file "tag"
will show up here. Tag has a newline char at the end.

/sys/bus/virtio/devices/virtio<N>/tag

# cat /sys/bus/virtio/devices/virtio<N>/tag
myfs

Note, tag is available at KOBJ_BIND time and not at KOBJ_ADD event time.

v2:
- Add a newline char at the end in tag file. (Alyssa Ross)
- Add a line in commit logs about tag file being available at KOBJ_BIND
  time and not KOBJ_ADD time.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 fs/fuse/virtio_fs.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 5f1be1da92ce..9f76c9697e6f 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -107,6 +107,21 @@ static const struct fs_parameter_spec virtio_fs_parameters[] = {
 	{}
 };
 
+/* Forward Declarations */
+static void virtio_fs_stop_all_queues(struct virtio_fs *fs);
+
+/* sysfs related */
+static ssize_t tag_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct virtio_device *vdev = container_of(dev, struct virtio_device,
+						  dev);
+	struct virtio_fs *fs = vdev->priv;
+
+	return sysfs_emit(buf, "%s\n", fs->tag);
+}
+static DEVICE_ATTR_RO(tag);
+
 static int virtio_fs_parse_param(struct fs_context *fsc,
 				 struct fs_parameter *param)
 {
@@ -265,6 +280,15 @@ static int virtio_fs_add_instance(struct virtio_fs *fs)
 	return 0;
 }
 
+static void virtio_fs_remove_instance(struct virtio_fs *fs)
+{
+	mutex_lock(&virtio_fs_mutex);
+	list_del_init(&fs->list);
+	virtio_fs_stop_all_queues(fs);
+	virtio_fs_drain_all_queues_locked(fs);
+	mutex_unlock(&virtio_fs_mutex);
+}
+
 /* Return the virtio_fs with a given tag, or NULL */
 static struct virtio_fs *virtio_fs_find_instance(const char *tag)
 {
@@ -891,8 +915,15 @@ static int virtio_fs_probe(struct virtio_device *vdev)
 	if (ret < 0)
 		goto out_vqs;
 
+	/* Export tag through sysfs */
+	ret = device_create_file(&vdev->dev, &dev_attr_tag);
+	if (ret < 0)
+		goto out_sysfs_attr;
+
 	return 0;
 
+out_sysfs_attr:
+	virtio_fs_remove_instance(fs);
 out_vqs:
 	virtio_reset_device(vdev);
 	virtio_fs_cleanup_vqs(vdev);
@@ -922,6 +953,9 @@ static void virtio_fs_remove(struct virtio_device *vdev)
 	struct virtio_fs *fs = vdev->priv;
 
 	mutex_lock(&virtio_fs_mutex);
+	/* Remove tag attr from sysfs */
+	device_remove_file(&vdev->dev, &dev_attr_tag);
+
 	/* This device is going away. No one should get new reference */
 	list_del_init(&fs->list);
 	virtio_fs_stop_all_queues(fs);
-- 
2.41.0


