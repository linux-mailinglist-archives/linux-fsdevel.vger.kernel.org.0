Return-Path: <linux-fsdevel+bounces-14412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD5487C1DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 18:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE00283DBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 17:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7D774439;
	Thu, 14 Mar 2024 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bs7vAs29"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9726E74436
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 17:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710436242; cv=none; b=u/j9mGM9WD45Yn0Z/i9VK7EeP/xfR65JbZJl8RC+mlR9NdACtVqOwIMSTp9H1cQ3Pwn/An78Ju1bFPjdfdpLvG1eoMaEcoQ4NuCauABdcGVTmEnKh2ozxh41utswRppYqeQpC2MdEoCRt2ZTv0d7Qz2O81t3pDtc8vPthWAPudo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710436242; c=relaxed/simple;
	bh=TyItB/hAYM3pBtSHA6TUbqO5G1iY4oZ8BvSG7S1PdMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eQQbgNdTX8KYmqSFHo9YyC+QoIFRhmCQET4ID+bOCAhvKquVzFkWAkgJdPwdBqIJgQHJGTlO+zx4SVfY92fzGilYtmY+uUVhXZd4GbqMX+bRweKFv9oEACGOfefovd7MSHuaRmT7fCoa4N2v/I5K+uNABrHVg+xURDSJPBr8KVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bs7vAs29; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710436236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nglP/KsI47mDuSUjIPZ3C/44ECCEYoTczUhHN4ODHLg=;
	b=Bs7vAs29pTXtN2JwQe568fGxT2eAAQWoVLFcywx4Avdq224G6Ks3jsKumoOxTf0rfrULdv
	W8akua8SNtQZZFIC9lVa6qb9pu392uMzD2K5CBp2rk1Sbux6h7996+Hd5Qv3qd5MgYonV0
	tXNK6ic7jWdi9574uDaa3CgLhi7tJlI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-Y5Slyb5eM9Ct4NF4C29tLQ-1; Thu, 14 Mar 2024 13:10:35 -0400
X-MC-Unique: Y5Slyb5eM9Ct4NF4C29tLQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a4679ce1706so31546466b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 10:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710436233; x=1711041033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nglP/KsI47mDuSUjIPZ3C/44ECCEYoTczUhHN4ODHLg=;
        b=vkGq5CyPLTq6p+Y7dMkMaeeNPXnm5IcY3/OrHxRH254Q9KeURAt4OnAWxbXsViqpQt
         Tflwuz46dm4a6O4EPrVBwkJ+Bfson8axXc+UuAU4tjcUPdGSW80A3hJdZ0gbkWLMfHsZ
         FwdGfPqy0aRYfDJjgVJzPFEcdoLD3V4iCNL1c0h6oUC9/zRcqzXqFsNPLTZrNhyOZcRb
         3jpnlm1BSHlQcVgJMENkurFhsLBWC0xHujoUgzMeiYh5FoenfWgCYlV1DRGVxZvTKUOq
         E8GMf/hqX67MelFOKo6i/lfMqXFDgVFJFx1Z4yErlWFIIa6ZCrXzaDiEE/6V103p4Ibq
         bSog==
X-Forwarded-Encrypted: i=1; AJvYcCUpc8PVgcue+QhpXI/dVmtlpmkGiCeBe11Jb7PefZI/Uk47pzcgR3pwN+ohz8dbdT9tC7uIlIr3lW+w0tTDV4LOPL7D0wRhprbV4iVGHA==
X-Gm-Message-State: AOJu0YyhHtsAaHMqe5g7ra/ZlKB1AdeLyMdYdqdpymJGE/BO222zNXVn
	LFCF1qXcV4hhdgqWpK7TmbaW/NAK3zG9xlI0fy/voafePniWfKyxXnxRIeWKxQIUN67086gfOso
	6IdEy5tZG37sRycJImjwjo+BoUDhGpG8PiUXUZX1cDwXf5x/Mhir45WJHjvgUbxFpyxQ4Eg==
X-Received: by 2002:a17:906:6858:b0:a46:5f1d:f357 with SMTP id a24-20020a170906685800b00a465f1df357mr299967ejs.10.1710436233421;
        Thu, 14 Mar 2024 10:10:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvPIcNkko9NH8iuSw0lecUD6Jh90LB+MmU7nCy0xCAvv6LMzlZ3Px9WFVsLc0xgJZghD3x5A==
X-Received: by 2002:a17:906:6858:b0:a46:5f1d:f357 with SMTP id a24-20020a170906685800b00a465f1df357mr299935ejs.10.1710436232695;
        Thu, 14 Mar 2024 10:10:32 -0700 (PDT)
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id v19-20020a1709060b5300b00a466715aec4sm885899ejg.96.2024.03.14.10.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 10:10:32 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: david@fromorbit.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v2] xfs: allow cross-linking special files without project quota
Date: Thu, 14 Mar 2024 18:07:02 +0100
Message-ID: <20240314170700.352845-3-aalbersh@redhat.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's an issue that if special files is created before quota
project is enabled, then it's not possible to link this file. This
works fine for normal files. This happens because xfs_quota skips
special files (no ioctls to set necessary flags). The check for
having the same project ID for source and destination then fails as
source file doesn't have any ID.

mkfs.xfs -f /dev/sda
mount -o prjquota /dev/sda /mnt/test

mkdir /mnt/test/foo
mkfifo /mnt/test/foo/fifo1

xfs_quota -xc "project -sp /mnt/test/foo 9" /mnt/test
> Setting up project 9 (path /mnt/test/foo)...
> xfs_quota: skipping special file /mnt/test/foo/fifo1
> Processed 1 (/etc/projects and cmdline) paths for project 9 with recursion depth infinite (-1).

ln /mnt/test/foo/fifo1 /mnt/test/foo/fifo1_link
> ln: failed to create hard link '/mnt/test/testdir/fifo1_link' => '/mnt/test/testdir/fifo1': Invalid cross-device link

mkfifo /mnt/test/foo/fifo2
ln /mnt/test/foo/fifo2 /mnt/test/foo/fifo2_link

Fix this by allowing linking of special files to the project quota
if special files doesn't have any ID set (ID = 0).

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_inode.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 1fd94958aa97..b7be19be0132 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1240,8 +1240,19 @@ xfs_link(
 	 */
 	if (unlikely((tdp->i_diflags & XFS_DIFLAG_PROJINHERIT) &&
 		     tdp->i_projid != sip->i_projid)) {
-		error = -EXDEV;
-		goto error_return;
+		/*
+		 * Project quota setup skips special files which can
+		 * leave inodes in a PROJINHERIT directory without a
+		 * project ID set. We need to allow links to be made
+		 * to these "project-less" inodes because userspace
+		 * expects them to succeed after project ID setup,
+		 * but everything else should be rejected.
+		 */
+		if (!special_file(VFS_I(sip)->i_mode) ||
+		    sip->i_projid != 0) {
+			error = -EXDEV;
+			goto error_return;
+		}
 	}
 
 	if (!resblks) {
-- 
2.42.0


