Return-Path: <linux-fsdevel+bounces-73600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC72D1C852
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 06:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1678C31E7428
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 04:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE0A32C928;
	Wed, 14 Jan 2026 04:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="M3dMvsPn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCBB326951;
	Wed, 14 Jan 2026 04:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768365175; cv=none; b=KlO94seM68soCdwLCMlMKK3MhxzitBFss+3CcTJUQquvOcXiUx7PUXlnoI1YsmZcA7b/zQqPUW6gmVa4VhbpaR53trCk5TJzc1RMhY5gxwsexWyYmLWDvzdWFrSfZE1QVh+u3ENq1ha9l+w69wye8ZyhC8ad5JyLyy4VobJJ1ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768365175; c=relaxed/simple;
	bh=RpYdlUyxv1m9KBTMQMhcFdZfnQX6+KM2DDV3JhZbmFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CA2e3KRYRHKdl3bHhxPPxcUMnu47OFnIJHXOzox7dT2Or6/fAKClcIgF04uQdhBBPlhxNrkI1g/wWX/aKCxEpet10CVgjuPY9urPUae1m3vd1vNn9HoigfXuTu/zJ1xBp8piiga+u1Uwya7gP+cfNqVoW1JZ0/q4IRoeL++/tO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=M3dMvsPn; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4mbTK5RSQYergtgPKWt7Z+qG+/ykqryRCZrQNU2VHZA=; b=M3dMvsPnnu+FYdOlweB93GGuxe
	hLKxw0/bDaMe/qtQfNxg3sGB2bS39IVAV8UowTmb638MIuTL8iWWQq6FyRac4S8r1um7E3F+IYLXc
	zSH2UM0Z+TB1J3L4NaecEsQBmqkeBq3gyqm4fw1Y88XADoOV3bWGsQ5+MDfpShsBq/jS9fMofDBaH
	4rLPcF23LQ9aOAFsUS0kqA6pBBZK4z9GerzpKxFsiT2HKsj8YkILJPZSz1sQmhrf73+zarDCeW2By
	jF16iUJ5as0wlj4RGJf7pD2VNmnk0UKoY60lpYq3w28V8E6A578e+C/II5RpzKgYD7yGCAzQr/YkG
	0oil3DPQ==;
Received: from [177.139.22.247] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vfsYY-0057lT-Vb; Wed, 14 Jan 2026 05:32:31 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 14 Jan 2026 01:31:42 -0300
Subject: [PATCH 2/3] btrfs: Implement get_disk_uuid()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260114-tonyk-get_disk_uuid-v1-2-e6a319e25d57@igalia.com>
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com>
In-Reply-To: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com>
To: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Carlos Maiolino <cem@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Chris Mason <clm@fb.com>, 
 David Sterba <dsterba@suse.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.3

Every time btrfs mounts a image that it's already mounted (cloned
images), it will assign a new random UUID to it to avoid conflicts.
However, for some internal kernel usage, it's important to access the
original UUID of a given image.

For instance, overlayfs' "index" feature keeps track of the UUID of the
mounted filesystem on it's upper layer, to avoid being remounted with a
different filesystem. However, overlayfs uses the same random UUID
exposed to userspace, so the "index" check will fail when trying to
remount the very same filesystem.

Implement export operation get_disk_uuid() to export the real image
UUID.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 fs/btrfs/export.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index 230d9326b685..09f9ef8c1b1e 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -8,6 +8,7 @@
 #include "export.h"
 #include "accessors.h"
 #include "super.h"
+#include "volumes.h"
 
 #define BTRFS_FID_SIZE_NON_CONNECTABLE (offsetof(struct btrfs_fid, \
 						 parent_objectid) / 4)
@@ -298,10 +299,29 @@ static int btrfs_get_name(struct dentry *parent, char *name,
 	return 0;
 }
 
+static int btrfs_get_disk_uuid(struct super_block *sb, u8 *buf, u32 *len,
+			       u64 *offset)
+{
+	struct btrfs_fs_devices *fs_dev = btrfs_sb(sb)->fs_devices;
+
+	if (fs_dev->temp_fsid)
+		return -ENODATA;
+
+	if (*len < sizeof(uuid_t))
+		return -EINVAL;
+
+	memcpy(buf, &fs_dev->metadata_uuid, sizeof(uuid_t));
+	*offset = offsetof(struct btrfs_fs_devices, metadata_uuid);
+	*len = sizeof(uuid_t);
+
+	return 0;
+}
+
 const struct export_operations btrfs_export_ops = {
 	.encode_fh	= btrfs_encode_fh,
 	.fh_to_dentry	= btrfs_fh_to_dentry,
 	.fh_to_parent	= btrfs_fh_to_parent,
 	.get_parent	= btrfs_get_parent,
 	.get_name	= btrfs_get_name,
+	.get_disk_uuid  = btrfs_get_disk_uuid,
 };

-- 
2.52.0


