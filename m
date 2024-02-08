Return-Path: <linux-fsdevel+bounces-10825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6F884E8F9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 20:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3EB28FC91
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 19:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D42381DE;
	Thu,  8 Feb 2024 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dTQGG00Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02D5381D3
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707420840; cv=none; b=kpsMqur5av1gPBlkmv7gzeovKjfN0I/xKoT1PxwqiVr/9QAMxtGCkH4K6fyuCtha472YSHEMuIyDzSlGJB8pzE785iJwof/pihFFVNcgifpEGh/JGGAfeFq+k/Tse13HOXUPwJD9DRHzuFrBXLmqW8QYZ6/OLFskBjgjVEyzi/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707420840; c=relaxed/simple;
	bh=n48oWo3G3KIEcmxV/611DpsMC0ryPm6br1Qg/jnSK7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Smn0PotXz8pw64rITh+sHarriCsxIZDx7SvBbyz4qQ/DM9dYgVX3Sdwc1f5gZUZJ0QuDpGKeU1gB/oUE5FEFdCEKVmC8DvFz+q6I0AJNEWTMej+wPsVE+JK3Z7MuR9XHikrlsRixWz73TtwGCdKrJcfn0kxnd+4DEd2BFuUTOuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dTQGG00Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707420837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPnUeFg/dcRAFFaWxKcnPQO6N26PYx0VPSOmFP3Xkj4=;
	b=dTQGG00Y6JtukMiTPpBwgK+OxQdHW8wpZU+xOANy3O5eVD/EKRb2JjXkQFoS6KcjW4D57d
	xY5JdimgBtbFmvUwNcTFtwXtNPIKH6lle/D4NbCIV4Pq0MO1ITvdoAKSXALUV2Tc1sIBTv
	vsSWblaw7tw+FntUkZOL8g+Nmwpplwc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-LJMYgYA7NpSvlOrGcxDMZg-1; Thu, 08 Feb 2024 14:33:53 -0500
X-MC-Unique: LJMYgYA7NpSvlOrGcxDMZg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A184810201EA;
	Thu,  8 Feb 2024 19:33:52 +0000 (UTC)
Received: from localhost (unknown [10.39.192.44])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1E80D2026D06;
	Thu,  8 Feb 2024 19:33:51 +0000 (UTC)
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
Subject: [PATCH v2 1/3] virtiofs: forbid newlines in tags
Date: Thu,  8 Feb 2024 14:32:09 -0500
Message-ID: <20240208193212.731978-2-stefanha@redhat.com>
In-Reply-To: <20240208193212.731978-1-stefanha@redhat.com>
References: <20240208193212.731978-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Newlines in virtiofs tags are awkward for users and potential vectors
for string injection attacks.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 fs/fuse/virtio_fs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 5f1be1da92ce..de9a38efdf1e 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -323,6 +323,16 @@ static int virtio_fs_read_tag(struct virtio_device *vdev, struct virtio_fs *fs)
 		return -ENOMEM;
 	memcpy(fs->tag, tag_buf, len);
 	fs->tag[len] = '\0';
+
+	/* While the VIRTIO specification allows any character, newlines are
+	 * awkward on mount(8) command-lines and cause problems in the sysfs
+	 * "tag" attr and uevent TAG= properties. Forbid them.
+	 */
+	if (strchr(fs->tag, '\n')) {
+		dev_err(&vdev->dev, "refusing virtiofs tag with newline character\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.43.0


