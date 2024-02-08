Return-Path: <linux-fsdevel+bounces-10826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E9284E8FA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 20:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D8AC1F21E7E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 19:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F811383AC;
	Thu,  8 Feb 2024 19:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wg23bapC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CFB38393
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707420842; cv=none; b=maHqWIJ44o7Ws9+laaLWGAXxsyVmPiFXU98xERTmsV7GjgbCGBuq1ob9qKP2SQeuX8qll7rL+/Rx20tHRWtiJvxqgi37I4VgfX6wA7E5puwafTal35YH79rF5VSyX/kngjl3RWppG5KhpbgIbgxIaJ3DC9P/cSzd33NUc3i72bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707420842; c=relaxed/simple;
	bh=yT7npgDt9vk+VlvBGk65wIOfLCa0nDoZtLGtZqP2Euk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8X5tUp5cb5hRNd/cstf/OB5maIAo+QFz5apRRWc0YeOblkOXTEMDsVFpq6KVAlIuXhZXvhBFXj3sDnvG0i02cGkkbHwkZ/e7ZglmFaK2sGoup+LCGtQXheu/H9nwp3v6recxm7LrKp+gbjLzeOX1MNhxaJyqUtFU8m2s0XLTvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wg23bapC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707420839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wziBRRP9edH3/Cx0/1knArrbO5K4rMmmZqjf0PTv500=;
	b=Wg23bapC/8Lao/W3i3tBJr+As7o50fOuvLyJeFNMgGube7N0Ix0ryapZUHY7n5ibE5sQOL
	pgLinv5Vf49O9hO7eWrVcHuo06PrUY5wWdcGDW8dYZnWZM6MyRum2BLwgFhVUXJgUxU5jy
	FFHheFcr1Eb0Lx6MWQjsP/25QCE/nsk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-k-o1oXf0OYWFC56IZDCz9w-1; Thu, 08 Feb 2024 14:33:56 -0500
X-MC-Unique: k-o1oXf0OYWFC56IZDCz9w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCBC5845E3B;
	Thu,  8 Feb 2024 19:33:55 +0000 (UTC)
Received: from localhost (unknown [10.39.192.44])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3255DAC1A;
	Thu,  8 Feb 2024 19:33:54 +0000 (UTC)
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
Subject: [PATCH v2 2/3] virtiofs: export filesystem tags through sysfs
Date: Thu,  8 Feb 2024 14:32:10 -0500
Message-ID: <20240208193212.731978-3-stefanha@redhat.com>
In-Reply-To: <20240208193212.731978-1-stefanha@redhat.com>
References: <20240208193212.731978-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

The virtiofs filesystem is mounted using a "tag" which is exported by
the virtiofs device:

  # mount -t virtiofs <tag> /mnt

The virtiofs driver knows about all the available tags but these are
currently not exported to user space.

People have asked for these tags to be exported to user space. Most
recently Lennart Poettering has asked for it as he wants to scan the
tags and mount virtiofs automatically in certain cases.

https://gitlab.com/virtio-fs/virtiofsd/-/issues/128

This patch exports tags at /sys/fs/virtiofs/<N>/tag where N is the id of
the virtiofs device. The filesystem tag can be obtained by reading this
"tag" file.

There is also a symlink at /sys/fs/virtiofs/<N>/device that points to
the virtiofs device that exports this tag.

This patch converts the existing struct virtio_fs into a full kobject.
It already had a refcount so it's an easy change. The virtio_fs objects
can then be exposed in a kset at /sys/fs/virtiofs/. Note that virtio_fs
objects may live slightly longer than we wish for them to be exposed to
userspace, so kobject_del() is called explicitly when the underlying
virtio_device is removed. The virtio_fs object is freed when all
references are dropped (e.g. active mounts) but disappears as soon as
the virtiofs device is gone.

Originally-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 fs/fuse/virtio_fs.c                         | 113 ++++++++++++++++----
 Documentation/ABI/testing/sysfs-fs-virtiofs |  11 ++
 2 files changed, 103 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-fs-virtiofs

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index de9a38efdf1e..28e96b7cde00 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -31,6 +31,9 @@
 static DEFINE_MUTEX(virtio_fs_mutex);
 static LIST_HEAD(virtio_fs_instances);
 
+/* The /sys/fs/virtio_fs/ kset */
+static struct kset *virtio_fs_kset;
+
 enum {
 	VQ_HIPRIO,
 	VQ_REQUEST
@@ -55,7 +58,7 @@ struct virtio_fs_vq {
 
 /* A virtio-fs device instance */
 struct virtio_fs {
-	struct kref refcount;
+	struct kobject kobj;
 	struct list_head list;    /* on virtio_fs_instances */
 	char *tag;
 	struct virtio_fs_vq *vqs;
@@ -161,18 +164,43 @@ static inline void dec_in_flight_req(struct virtio_fs_vq *fsvq)
 		complete(&fsvq->in_flight_zero);
 }
 
-static void release_virtio_fs_obj(struct kref *ref)
+static ssize_t virtio_fs_tag_attr_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
 {
-	struct virtio_fs *vfs = container_of(ref, struct virtio_fs, refcount);
+	struct virtio_fs *fs = container_of(kobj, struct virtio_fs, kobj);
+
+	return sysfs_emit(buf, fs->tag);
+}
+
+static struct kobj_attribute virtio_fs_tag_attr = {
+	.attr = { .name = "tag", .mode= 0644 },
+	.show = virtio_fs_tag_attr_show,
+};
+
+static struct attribute *virtio_fs_attrs[] = {
+	&virtio_fs_tag_attr.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(virtio_fs);
+
+static void virtio_fs_ktype_release(struct kobject *kobj)
+{
+	struct virtio_fs *vfs = container_of(kobj, struct virtio_fs, kobj);
 
 	kfree(vfs->vqs);
 	kfree(vfs);
 }
 
+static const struct kobj_type virtio_fs_ktype = {
+	.release = virtio_fs_ktype_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = virtio_fs_groups,
+};
+
 /* Make sure virtiofs_mutex is held */
 static void virtio_fs_put(struct virtio_fs *fs)
 {
-	kref_put(&fs->refcount, release_virtio_fs_obj);
+	kobject_put(&fs->kobj);
 }
 
 static void virtio_fs_fiq_release(struct fuse_iqueue *fiq)
@@ -243,25 +271,44 @@ static void virtio_fs_start_all_queues(struct virtio_fs *fs)
 }
 
 /* Add a new instance to the list or return -EEXIST if tag name exists*/
-static int virtio_fs_add_instance(struct virtio_fs *fs)
+static int virtio_fs_add_instance(struct virtio_device *vdev,
+				  struct virtio_fs *fs)
 {
 	struct virtio_fs *fs2;
-	bool duplicate = false;
+	int ret;
 
 	mutex_lock(&virtio_fs_mutex);
 
 	list_for_each_entry(fs2, &virtio_fs_instances, list) {
-		if (strcmp(fs->tag, fs2->tag) == 0)
-			duplicate = true;
+		if (strcmp(fs->tag, fs2->tag) == 0) {
+			mutex_unlock(&virtio_fs_mutex);
+			return -EEXIST;
+		}
 	}
 
-	if (!duplicate)
-		list_add_tail(&fs->list, &virtio_fs_instances);
+	/* Use the virtio_device's index as a unique identifier, there is no
+	 * need to allocate our own identifiers because the virtio_fs instance
+	 * is only visible to userspace as long as the underlying virtio_device
+	 * exists.
+	 */
+	fs->kobj.kset = virtio_fs_kset;
+	ret = kobject_add(&fs->kobj, NULL, "%d", vdev->index);
+	if (ret < 0) {
+		mutex_unlock(&virtio_fs_mutex);
+		return ret;
+	}
+
+	ret = sysfs_create_link(&fs->kobj, &vdev->dev.kobj, "device");
+	if (ret < 0) {
+		kobject_del(&fs->kobj);
+		mutex_unlock(&virtio_fs_mutex);
+		return ret;
+	}
+
+	list_add_tail(&fs->list, &virtio_fs_instances);
 
 	mutex_unlock(&virtio_fs_mutex);
 
-	if (duplicate)
-		return -EEXIST;
 	return 0;
 }
 
@@ -274,7 +321,7 @@ static struct virtio_fs *virtio_fs_find_instance(const char *tag)
 
 	list_for_each_entry(fs, &virtio_fs_instances, list) {
 		if (strcmp(fs->tag, tag) == 0) {
-			kref_get(&fs->refcount);
+			kobject_get(&fs->kobj);
 			goto found;
 		}
 	}
@@ -875,7 +922,7 @@ static int virtio_fs_probe(struct virtio_device *vdev)
 	fs = kzalloc(sizeof(*fs), GFP_KERNEL);
 	if (!fs)
 		return -ENOMEM;
-	kref_init(&fs->refcount);
+	kobject_init(&fs->kobj, &virtio_fs_ktype);
 	vdev->priv = fs;
 
 	ret = virtio_fs_read_tag(vdev, fs);
@@ -897,7 +944,7 @@ static int virtio_fs_probe(struct virtio_device *vdev)
 	 */
 	virtio_device_ready(vdev);
 
-	ret = virtio_fs_add_instance(fs);
+	ret = virtio_fs_add_instance(vdev, fs);
 	if (ret < 0)
 		goto out_vqs;
 
@@ -906,11 +953,10 @@ static int virtio_fs_probe(struct virtio_device *vdev)
 out_vqs:
 	virtio_reset_device(vdev);
 	virtio_fs_cleanup_vqs(vdev);
-	kfree(fs->vqs);
 
 out:
 	vdev->priv = NULL;
-	kfree(fs);
+	kobject_put(&fs->kobj);
 	return ret;
 }
 
@@ -934,6 +980,8 @@ static void virtio_fs_remove(struct virtio_device *vdev)
 	mutex_lock(&virtio_fs_mutex);
 	/* This device is going away. No one should get new reference */
 	list_del_init(&fs->list);
+	sysfs_remove_link(&fs->kobj, "device");
+	kobject_del(&fs->kobj);
 	virtio_fs_stop_all_queues(fs);
 	virtio_fs_drain_all_queues_locked(fs);
 	virtio_reset_device(vdev);
@@ -1520,6 +1568,20 @@ static struct file_system_type virtio_fs_type = {
 	.kill_sb	= virtio_kill_sb,
 };
 
+static int __init virtio_fs_sysfs_init(void)
+{
+	virtio_fs_kset = kset_create_and_add("virtiofs", NULL, fs_kobj);
+	if (!virtio_fs_kset)
+		return -ENOMEM;
+	return 0;
+}
+
+static void __exit virtio_fs_sysfs_exit(void)
+{
+	kset_unregister(virtio_fs_kset);
+	virtio_fs_kset = NULL;
+}
+
 static int __init virtio_fs_init(void)
 {
 	int ret;
@@ -1528,19 +1590,28 @@ static int __init virtio_fs_init(void)
 	if (ret < 0)
 		return ret;
 
+	ret = virtio_fs_sysfs_init();
+	if (ret < 0)
+		goto unregister_virtio_driver;
+
 	ret = register_filesystem(&virtio_fs_type);
-	if (ret < 0) {
-		unregister_virtio_driver(&virtio_fs_driver);
-		return ret;
-	}
+	if (ret < 0)
+		goto sysfs_exit;
 
 	return 0;
+
+sysfs_exit:
+	virtio_fs_sysfs_exit();
+unregister_virtio_driver:
+	unregister_virtio_driver(&virtio_fs_driver);
+	return ret;
 }
 module_init(virtio_fs_init);
 
 static void __exit virtio_fs_exit(void)
 {
 	unregister_filesystem(&virtio_fs_type);
+	virtio_fs_sysfs_exit();
 	unregister_virtio_driver(&virtio_fs_driver);
 }
 module_exit(virtio_fs_exit);
diff --git a/Documentation/ABI/testing/sysfs-fs-virtiofs b/Documentation/ABI/testing/sysfs-fs-virtiofs
new file mode 100644
index 000000000000..4839dbce997e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-fs-virtiofs
@@ -0,0 +1,11 @@
+What:		/sys/fs/virtiofs/<n>/tag
+Date:		Feb 2024
+Contact:	virtio-fs@lists.linux.dev
+Description:
+		[RO] The mount "tag" that can be used to mount this filesystem.
+
+What:		/sys/fs/virtiofs/<n>/device
+Date:		Feb 2024
+Contact:	virtio-fs@lists.linux.dev
+Description:
+		Symlink to the virtio device that exports this filesystem.
-- 
2.43.0


