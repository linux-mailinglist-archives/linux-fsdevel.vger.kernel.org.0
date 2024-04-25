Return-Path: <linux-fsdevel+bounces-17734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC068B1F64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 12:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0777FB26C09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 10:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BCC200BF;
	Thu, 25 Apr 2024 10:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YV0qmLVL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DF01EB3E
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 10:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714041708; cv=none; b=mCMQ+mqHrMRUZToIc1U1WevOV1I8Vg1/ocrzT/csMeWbPG5bYo8deWuFerXtmP+TdPTJHQ275jK5dL+X7xy3ZTpBMVOi0MtzlUEvsbE4n9axBLy3JcwymbT2PWu9opnLH6kujviIL6XQW2ngEmX8tf9Ie48TGAmg5bbweKbY5/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714041708; c=relaxed/simple;
	bh=v/KGBsa8Z6C9GRLqvYfgM0+hHAy0dlhhZCGSoHWjk1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JUacjEbA6YdDboZ6AlVRKC49bnDWgBXPFEssFzfAxtkrA+k1qHLq02W+5g7lg27/wDxB+SrR0IpjGNGh3idIbksfdnreThj/5sIArvCL0q0HNGL/SdmRUmcPt0rgAQ6MRFE7WcQFCxuRxCh5DBHO9XmPmYPElbn/N9iJngdsY/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YV0qmLVL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714041705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dGr6+xziLxpyqNFPHJWI7xrD+XnHnDGrKw/3Y9Rvwsw=;
	b=YV0qmLVLktK/uucdMGngfKy6w7wPVC2eKs9I+yO6N+GgnspBi6R1n7hiUkk9YkSmgUjEeA
	AgQ4mZXZkz3ZARieelp5AOH4STYYYUYNKOjkJVPKukgCceDq7fsP2xIlArwUKDd6RgtrVn
	Ca53+fDgED/CP8F+BeTORJU6Xkm2URk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-1Ce3DHKXNX-avTSShUn6mA-1; Thu, 25 Apr 2024 06:41:44 -0400
X-MC-Unique: 1Ce3DHKXNX-avTSShUn6mA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9731812C59
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 10:41:43 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.16.38])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 580D15C5CC2;
	Thu, 25 Apr 2024 10:41:43 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	vgoyal@redhat.com,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] virtiofs: include a newline in sysfs tag
Date: Thu, 25 Apr 2024 06:44:00 -0400
Message-ID: <20240425104400.30222-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

The internal tag string doesn't contain a newline. Append one when
emitting the tag via sysfs.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---

Hi all,

I just noticed this and it seemed a little odd to me compared to typical
sysfs output, but maybe it was intentional..? Easy enough to send a
patch either way.. thoughts?

Brian

 fs/fuse/virtio_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 322af827a232..bb3e941b9503 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -170,7 +170,7 @@ static ssize_t tag_show(struct kobject *kobj,
 {
 	struct virtio_fs *fs = container_of(kobj, struct virtio_fs, kobj);
 
-	return sysfs_emit(buf, fs->tag);
+	return sysfs_emit(buf, "%s\n", fs->tag);
 }
 
 static struct kobj_attribute virtio_fs_tag_attr = __ATTR_RO(tag);
-- 
2.44.0


