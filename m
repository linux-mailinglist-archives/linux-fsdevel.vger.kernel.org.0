Return-Path: <linux-fsdevel+bounces-11261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021A08522FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 01:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A72E280E7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 00:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9775017CD;
	Tue, 13 Feb 2024 00:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d42skFIQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50770ED8
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 00:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783212; cv=none; b=Y04my9qWss53IX7Fbk/lKQ2Aj+/JgSglLZQOsn9+XBY/AunFMf9Eqg1vU7j6mIxTnBKw2ORC/22Rn9vFsQI42Da7hqW2bELcCvvxNPJu5VFECbe1qjCer1rwzTPXDfS3JZ3yLfIdCow7aGRkGpQMHQYL32Pu9mHDm2kKYOCTlEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783212; c=relaxed/simple;
	bh=Y4omvdBChe/Cln2+OaJ7L3X93j9YxKgL4u9haJFA7RM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfEVXUm1j9QEH89lFGq+BFW4Wx0ig6lUC1EDCG2lpGiEYN5auUlIeKuYeP2bltNVq8NIo3ikvTdY2I7+9ot/Nr1OLIUcJLMDrDHUIrMKXrPsjbDsMn6zR7XL59/ubMFADbJKeRFDZ48pfJTcO2f1RFdn6GI8voZWAjv8/R6iKis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d42skFIQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707783209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2x59ospy2hIhOih411eScu4ZlRyx6LgiuUyCvAkpzyY=;
	b=d42skFIQ+D4xgyH8kI29B3lIDG6XSx/GbWIkacV/0kgq7Mr0eGjnRtNR1jed6Sytl8QnRX
	tAMQ3C/tYaNogQH5YpLUIdhVdLnGEXCCtMZU+8j2Jdmqw34TXUoGjXoVW2COhomsqVha6t
	jorVvRyF+rMHCVeKJfqlU/MzNh8cLhg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-jdhaNizROZ6w5C-5L_QIPg-1; Mon, 12 Feb 2024 19:13:26 -0500
X-MC-Unique: jdhaNizROZ6w5C-5L_QIPg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E58E83B7E6;
	Tue, 13 Feb 2024 00:13:26 +0000 (UTC)
Received: from localhost (unknown [10.39.195.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 53E682166B31;
	Tue, 13 Feb 2024 00:13:25 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: miklos@szeredi.hu,
	Greg KH <gregkh@linuxfoundation.org>,
	Alyssa Ross <hi@alyssa.is>,
	mzxreary@0pointer.de,
	gmaglione@redhat.com,
	vgoyal@redhat.com,
	virtio-fs@lists.linux.dev,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v4 3/3] virtiofs: emit uevents on filesystem events
Date: Mon, 12 Feb 2024 19:11:49 -0500
Message-ID: <20240213001149.904176-4-stefanha@redhat.com>
In-Reply-To: <20240213001149.904176-1-stefanha@redhat.com>
References: <20240213001149.904176-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

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
index 99b6113bbd13..62a44603740c 100644
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


