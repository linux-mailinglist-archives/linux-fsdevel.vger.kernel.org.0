Return-Path: <linux-fsdevel+bounces-13546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5844870A76
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 20:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD611F23556
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347467A158;
	Mon,  4 Mar 2024 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QErDKXHo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B91E79DC2
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 19:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579637; cv=none; b=C0vAge5gwRsiMIwsaQJBvEQ/hlNH3BwCTo0QkaqCqksDVAFF57D23qmHcKc3jgSf8dYYx1x2bi8dqp8J5tCCdMlarpiYQxgZRGrR/CHoBcozBQPQE3HehIFZESYSSXMHuw+p6EDWwmJbVeMXCb+jFEpoOgMhkwij2+etM9MXiX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579637; c=relaxed/simple;
	bh=Yvp3SBF6+8zPzJgMF4RTTYUtctszJUGlguQC1VX4iyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X+qfI0jMMkUReS480toWUL6HXU1FQ/Yei8f11MV9S4LauSlOlV+LxDFiDcm9KDfjx16ApjzyETnQ36+FGfmTNR+/PfSAEMcd96kNUPHifrvzY26LjnznNNYVDzwyP8ZBoCJOKsPeWVM1/wQLL7PxE1kaaUVf8gU95YeFauoT1wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QErDKXHo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709579635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vvUt/Be8Gcd/hjdzGuVqAyt+8YqkryL5Dumkd6mCSo8=;
	b=QErDKXHojoPynCkrHzJ3U6CmtfC6l70vXWpCKTciPkgf8tX3+Apf+L2wAOMaHS1x8prv0r
	MT29gRqPy4FoZD8+FcDz+M6wghmKem7/qewIz5ff45BZvWuc5bg4F/ox3WL/gigrDBB1Tv
	Q73q4qVIyddMygq85xpRvUwTovhCp+w=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-wxHMBpG3N_iwhNcWtm15qQ-1; Mon, 04 Mar 2024 14:13:53 -0500
X-MC-Unique: wxHMBpG3N_iwhNcWtm15qQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a44143c8908so453826866b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 11:13:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579632; x=1710184432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vvUt/Be8Gcd/hjdzGuVqAyt+8YqkryL5Dumkd6mCSo8=;
        b=hpas+Qd51D6SraPw1gkSBIUrK2Kh4miIjLfXWUJgG4bTzoIOIyBbE5gG+feL8S0kto
         ysBMSQdOL19masIFM0cpTXwGc99zUIziZTjlok0dbQtk6K7IUZMBLmylcGDHOuYe52O7
         MM3jHU5LhpDAJihekWDZea6bvxU/XdY3AHI3Iwhoy5oNsnAfCvn2zZGsyD5xesgfgbFD
         a8HT1mk5M4EiIZlWtyTRM3V9vW+7KhxeLr9bTSb9FoEcVMNVJmR0Gx06kHltOYv2scxt
         U0K/JuJiJE/yB5xJ/hSPCrasnt89qkHbznuUlmD06BZUmXPag3RoFufQ62IYYsD7SfEZ
         bvJA==
X-Forwarded-Encrypted: i=1; AJvYcCV4B+SSiuPGHZRGYf15aiYXj54ewfDLOyUsrjdjYqTAZeqCBTTYy/reQ4fRKH5Wvao1RaFttfG1a6K3KkkBM+1Ek54RKq3FKuDih9OdJw==
X-Gm-Message-State: AOJu0Yyn7+row53S441EV4Bw/w8fYWXEOcNJOs6AKCE5BPJRoMKqKlnF
	BEATw7qJonlalwG9nP1uy7V1GRz6ASMFcN826cESRTpj6tVBhQfzTLlyfmCmSZPLR7dCfDtjvuU
	ECVd7DwTAzrqDbTxu4gXcPBfXDm5lAnrNdh6tqNG1aAV9oO5C5cAP7qGn1vFu/xDN89sbkQ==
X-Received: by 2002:a17:906:4ac4:b0:a44:52ec:b9e7 with SMTP id u4-20020a1709064ac400b00a4452ecb9e7mr388132ejt.16.1709579632440;
        Mon, 04 Mar 2024 11:13:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQbsKnmCO2v9c3n5rWiSsG93Fzu0C8g8BYXFgADgUetrMCVvdkY/V3EQ4xBS9gjIDqDhD9GQ==
X-Received: by 2002:a17:906:4ac4:b0:a44:52ec:b9e7 with SMTP id u4-20020a1709064ac400b00a4452ecb9e7mr388110ejt.16.1709579632033;
        Mon, 04 Mar 2024 11:13:52 -0800 (PST)
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id tj10-20020a170907c24a00b00a444526962asm5091450ejc.128.2024.03.04.11.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:13:51 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH] xfs: allow cross-linking special files without project quota
Date: Mon,  4 Mar 2024 16:50:14 +0100
Message-ID: <20240304155013.115334-2-aalbersh@redhat.com>
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
 fs/xfs/xfs_inode.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 5ca561634164..641270f4d794 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1232,11 +1232,24 @@ xfs_link(
 	 * the tree quota mechanism could be circumvented.
 	 */
 	if (unlikely((tdp->i_diflags & XFS_DIFLAG_PROJINHERIT) &&
+		     !special_file(VFS_I(sip)->i_mode) &&
 		     tdp->i_projid != sip->i_projid)) {
 		error = -EXDEV;
 		goto error_return;
 	}
 
+	/*
+	 * Don't allow cross-linking of special files. However, allow
+	 * cross-linking if original file doesn't have any project.
+	 */
+	if (unlikely((tdp->i_diflags & XFS_DIFLAG_PROJINHERIT) &&
+				special_file(VFS_I(sip)->i_mode) &&
+				sip->i_projid != 0 &&
+				tdp->i_projid != sip->i_projid)) {
+		error = -EXDEV;
+		goto error_return;
+	}
+
 	if (!resblks) {
 		error = xfs_dir_canenter(tp, tdp, target_name);
 		if (error)
-- 
2.42.0


