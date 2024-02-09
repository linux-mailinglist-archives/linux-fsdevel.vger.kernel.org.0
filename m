Return-Path: <linux-fsdevel+bounces-10949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2AA84F51E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 13:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A9D286195
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0088536113;
	Fri,  9 Feb 2024 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHIP5itH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB63F33CE2
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 12:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707481177; cv=none; b=N7E3rGMECriVE+7jueqIjJcVbEnU65mOT7cYEh+OIE3JAWPeAROZaVU4yw3+nRfLIBm9l0rEY6vxncwr9sSzl6rt7EOHmD0Iytd8kxobMRb5E5EeD6XsxXY99njRakftaTp/X5En1KkT0dmXhI6hVGAkLIZ+Lb+vlBnrHLdERok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707481177; c=relaxed/simple;
	bh=hd8ZTq2sDwWRqeoAKm381lzAkHmMP0UWzosyI6LCFoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nW+ixS0i0H06RYhWva6/J5yvyqBOkzkbfHCkci/P4KLXTnDXTc6/uG7u9mKjmfQ4PO+cjTiDiGK/GkFv2nIn7azxL8S2OEDKIlYmgwTQ3SAlrkhHFsbSdp5z6mnzKqCt9xvsK8qPC4GL6ap5QO73UpkuyeOSu3BUxex/8zZYDlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QHIP5itH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707481174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DVtLq4kSxxcXAHECUE/gwzTexd/LJnjpTSpOjMxsz6I=;
	b=QHIP5itHuPCOfE1jy+eqalye9QCDNIUCZCfZT929h8+xZB8b+SNG2AT8G288HbifMRejWo
	TUd5pkV6H+NNodwRTJeacB5eUgnogJwUslCh6Tx4PqvM6eCfU/0QsgBub2UWkRZR6BwD6V
	83aLYOVw722cULShga5Qfq7jkU0EaWM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-EtxSSYN_MZiEpatBLZ1jVA-1; Fri,
 09 Feb 2024 07:19:31 -0500
X-MC-Unique: EtxSSYN_MZiEpatBLZ1jVA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E65CA3C0C48E;
	Fri,  9 Feb 2024 12:19:30 +0000 (UTC)
Received: from localhost (unknown [10.39.193.29])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4ABD0111F3C6;
	Fri,  9 Feb 2024 12:19:29 +0000 (UTC)
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
Subject: [PATCH v3 1/3] virtiofs: forbid newlines in tags
Date: Fri,  9 Feb 2024 07:18:18 -0500
Message-ID: <20240209121820.755722-2-stefanha@redhat.com>
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

Newlines in virtiofs tags are awkward for users and potential vectors
for string injection attacks.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 fs/fuse/virtio_fs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 5f1be1da92ce..d84dacbdce2c 100644
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
+		dev_dbg(&vdev->dev, "refusing virtiofs tag with newline character\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.43.0


