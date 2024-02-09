Return-Path: <linux-fsdevel+bounces-10950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BF984F520
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 13:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB8D7B24366
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCAB36132;
	Fri,  9 Feb 2024 12:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xxm5G9X+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23A12E852
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 12:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707481181; cv=none; b=V9CFrB3RVoemsXZvenGyO7P/YzWpzSLfe/3Icxc2dbNyhlJl1Z3NdqUr2cRm+3nbc3m3ZtBt3rVXcbDu+kIEDGODkzRTQzlAVGRETsQ3jOBwA7Y6mHSBSoYNpa0koj9X5Y7vInTIBgLBuoPobicr14gbb2E//4ERduW4Pil/rvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707481181; c=relaxed/simple;
	bh=Kz2weS4NpQZtTg9JugiSsNZjuY9Ty2X/YP9AC9Lwud0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYoBNueoWkCmDc5hsQnhhgPZXxjJsb4ndNjRINRe4dwc5Ci4zB/AxWhCdQkQ+em5rFzixlZ92cMGkOrcODMZWTugxCsKlh7gTu8CVAkVQLQ7pLNAbIHr1wEB94iB8XNE5ti0w5ZYVWCjmu5NKnz9QS9q4LZ3W8y9vaN5ns4Qhtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xxm5G9X+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707481178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=44/q20LZWU/VM2/BpdlBLVOyLwhGkidR9iy/9wxlW6U=;
	b=Xxm5G9X+T6+s1DKmuaI0lXPF8bmr/K6Z1yEjC0x+qIVG4jkmjXRE8RC8gJSjsgkVK15EiR
	n5luedv9nYuiU+pr8BibwAmPqDbEUzE92qnuBYpuLMb9CRUUMs6SckRCX5/U40m0fv4KmF
	IfJdTmfrS85d5iI0aZ7itzF9cZvQC50=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-chWxYG1jOI2nEjUT5eVubQ-1; Fri, 09 Feb 2024 07:19:33 -0500
X-MC-Unique: chWxYG1jOI2nEjUT5eVubQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16AED837225;
	Fri,  9 Feb 2024 12:19:33 +0000 (UTC)
Received: from localhost (unknown [10.39.193.29])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6EA3C1121C;
	Fri,  9 Feb 2024 12:19:32 +0000 (UTC)
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
Subject: [PATCH v3 2/3] virtiofs: export filesystem tags through sysfs
Date: Fri,  9 Feb 2024 07:18:19 -0500
Message-ID: <20240209121820.755722-3-stefanha@redhat.com>
In-Reply-To: <20240209121820.755722-1-stefanha@redhat.com>
References: <20240209121820.755722-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

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
 fs/fuse/virtio_fs.c                         | 110 ++++++++++++++++----
 Documentation/ABI/testing/sysfs-fs-virtiofs |  11 ++
 2 files changed, 100 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-fs-virtiofs

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index d84dacbdce2c..22d7c70ef78a 100644
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
@@ -161,18 +164,40 @@ static inline void dec_in_flight_req(struct virtio_fs_vq *fsvq)
 		complete(&fsvq->in_flight_zero);
 }
 
-static void release_virtio_fs_obj(struct kref *ref)
+static ssize_t tag_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
 {
-	struct virtio_fs *vfs = container_of(ref, struct virtio_fs, refcount);
+	struct virtio_fs *fs = container_of(kobj, struct virtio_fs, kobj);
+
+	return sysfs_emit(buf, fs->tag);
+}
+
+static struct kobj_attribute virtio_fs_tag_attr = __ATTR_RO(tag);
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
@@ -243,25 +268,44 @@ static void virtio_fs_start_all_queues(struct virtio_fs *fs)
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
 
@@ -274,7 +318,7 @@ static struct virtio_fs *virtio_fs_find_instance(const char *tag)
 
 	list_for_each_entry(fs, &virtio_fs_instances, list) {
 		if (strcmp(fs->tag, tag) == 0) {
-			kref_get(&fs->refcount);
+			kobject_get(&fs->kobj);
 			goto found;
 		}
 	}
@@ -875,7 +919,7 @@ static int virtio_fs_probe(struct virtio_device *vdev)
 	fs = kzalloc(sizeof(*fs), GFP_KERNEL);
 	if (!fs)
 		return -ENOMEM;
-	kref_init(&fs->refcount);
+	kobject_init(&fs->kobj, &virtio_fs_ktype);
 	vdev->priv = fs;
 
 	ret = virtio_fs_read_tag(vdev, fs);
@@ -897,7 +941,7 @@ static int virtio_fs_probe(struct virtio_device *vdev)
 	 */
 	virtio_device_ready(vdev);
 
-	ret = virtio_fs_add_instance(fs);
+	ret = virtio_fs_add_instance(vdev, fs);
 	if (ret < 0)
 		goto out_vqs;
 
@@ -906,11 +950,10 @@ static int virtio_fs_probe(struct virtio_device *vdev)
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
 
@@ -934,6 +977,8 @@ static void virtio_fs_remove(struct virtio_device *vdev)
 	mutex_lock(&virtio_fs_mutex);
 	/* This device is going away. No one should get new reference */
 	list_del_init(&fs->list);
+	sysfs_remove_link(&fs->kobj, "device");
+	kobject_del(&fs->kobj);
 	virtio_fs_stop_all_queues(fs);
 	virtio_fs_drain_all_queues_locked(fs);
 	virtio_reset_device(vdev);
@@ -1520,6 +1565,20 @@ static struct file_system_type virtio_fs_type = {
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
@@ -1528,19 +1587,28 @@ static int __init virtio_fs_init(void)
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


