Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AB17BAB72
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 22:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjJEUa5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 16:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjJEUa4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 16:30:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0E895
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Oct 2023 13:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696537852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TUi8ml0syel5Tw3+sljCIvjoMhwpWMd7/oN7mXpoaB8=;
        b=Q3o+NOo6hkliZp6xppTChu91WfUuLJqEt+Hqi3h/neA+LbPmnUU+MhP0byy4YMo4iKBfsS
        9zWUEz84PtctNkcPKXF5HmWLNw6Q4g+ccj+thTnBoGA1iK6vESZvXVtnbvwmCg5OpR0fvz
        wKsoGrAHva4YQKGVED1JAJSrnBt/hdY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-S8W0VrATOwyEf_i0-XJxog-1; Thu, 05 Oct 2023 16:30:51 -0400
X-MC-Unique: S8W0VrATOwyEf_i0-XJxog-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F9D21C05EC8;
        Thu,  5 Oct 2023 20:30:50 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.8.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DA2F43532A;
        Thu,  5 Oct 2023 20:30:50 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
        id C924E203E04; Thu,  5 Oct 2023 16:30:49 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        mzxreary@0pointer.de, gmaglione@redhat.com
Subject: [PATCH] virtiofs: Export filesystem tags through sysfs
Date:   Thu,  5 Oct 2023 16:30:30 -0400
Message-ID: <20231005203030.223489-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
will show up here.

/sys/bus/virtio/devices/virtio<N>/tag

# cat /sys/bus/virtio/devices/virtio<N>/tag
myfs

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 5f1be1da92ce..a5b11e18f331 100644
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
+	return sysfs_emit(buf, "%s", fs->tag);
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

