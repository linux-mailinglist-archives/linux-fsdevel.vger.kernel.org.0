Return-Path: <linux-fsdevel+bounces-65589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01964C08906
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 04:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E8EA4E6B1C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 02:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9346223A99E;
	Sat, 25 Oct 2025 02:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZvtftmRN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399B31FBC8C;
	Sat, 25 Oct 2025 02:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761360611; cv=none; b=VNEOb6Y44FHaGaAx0I11VgT3/FTKDjPeQYd+6zj74OVZviMBJiJXe7HLZRLQmvjaGlnIpXab9b1OUKjBu+4oVO0MveIwyaFfaGwDJPGXEm0pcBi0TzAAYIWBNdJVYJAKIkH8s8QPNYeWNKntrmVozsuoa/IfAz1qpBUQ6iTkwbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761360611; c=relaxed/simple;
	bh=IthRKqaXYla/GIkqCMwx+59tGaJNkOv0wDQqAyF/piY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hcDXG94TVKTMH6YaWLqGc4egR25p2qCNurGZhcKU1efhStjFToAzh0GMw/jP/CqY5mkHgmhU/3m9zZajKAhHE4NFmVrkqrwgPScrs6OWrPVYZhYrEslHGyeEgLDFU9cQa6DsvNc9hOP5ya2MrvWzCc3kuCMMq2GAmbUwYcRZp3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZvtftmRN; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=/J
	5o70XA/obLpt91BZcECXr4vrBe6G5ePfm/spl+71w=; b=ZvtftmRN5u2bWYrP/X
	zrSrAm1511uFYWF160nmSoEQFnyWfno5HgsC9OcWlxHevIFXGEPDk5QqUYdHNExr
	X96T6PF2GDhGD5ZcpVTfnaG5OFWyArVBNnh8Fteqyi6qOKEn2QQaWOsY0zWVS0Hv
	O1XyquM2og7/5taDm94IpbMpE=
Received: from MS-CMFLBWVCLQRG.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3HzzAOvxoLsBsCg--.59453S2;
	Sat, 25 Oct 2025 10:49:38 +0800 (CST)
From: GuangFei Luo <luogf2025@163.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	GuangFei Luo <luogf2025@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] mount: fix duplicate mounts using the new mount API
Date: Sat, 25 Oct 2025 10:49:34 +0800
Message-ID: <20251025024934.1350492-1-luogf2025@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3HzzAOvxoLsBsCg--.59453S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr1UKFy8Zw45GFWxGF4xXrb_yoW8XF1xpF
	1FyF9xGrn3Gr43Xw4xZFZ5KrW3Ars5Z3Z0gF15uw1YyryIgF93Xas29F4SvF4UtFWUWF9r
	ZF4xtr17C3sFgF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_9a9rUUUUU=
X-CM-SenderInfo: poxrwwisqskqqrwthudrp/1tbizQrxmWj8MyhzWgAAsJ

When using the new mount API, invoking the same mount command multiple
times such as:
mount /dev/mapper/mydevice /mnt/mydisk2
results in multiple identical mount entries being created:
/dev/mapper/mydevice on /mnt/mydisk2 type ext4 (rw,relatime)
/dev/mapper/mydevice on /mnt/mydisk2 type ext4 (rw,relatime)
/dev/mapper/mydevice on /mnt/mydisk2 type ext4 (rw,relatime)
...

Fixes: 2db154b3ea8e ("vfs: syscall: Add move_mount(2) to move mounts around")
Signed-off-by: GuangFei Luo <luogf2025@163.com>
Cc: <stable@vger.kernel.org> # 5.2+
---
 fs/namespace.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index d82910f33dc4..9436471955ce 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4427,6 +4427,7 @@ SYSCALL_DEFINE5(move_mount,
 {
 	struct path to_path __free(path_put) = {};
 	struct path from_path __free(path_put) = {};
+	struct path path __free(path_put) = {};
 	struct filename *to_name __free(putname) = NULL;
 	struct filename *from_name __free(putname) = NULL;
 	unsigned int lflags, uflags;
@@ -4472,6 +4473,14 @@ SYSCALL_DEFINE5(move_mount,
 			return ret;
 	}
 
+	ret = user_path_at(AT_FDCWD, to_pathname, LOOKUP_FOLLOW, &path);
+	if (ret)
+		return ret;
+
+	/* Refuse the same filesystem on the same mount point */
+	if (path.mnt->mnt_sb == to_path.mnt->mnt_sb && path_mounted(&path))
+		return -EBUSY;
+
 	uflags = 0;
 	if (flags & MOVE_MOUNT_F_EMPTY_PATH)
 		uflags = AT_EMPTY_PATH;
-- 
2.43.0


