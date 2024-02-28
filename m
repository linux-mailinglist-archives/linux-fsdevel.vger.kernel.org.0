Return-Path: <linux-fsdevel+bounces-13134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC5F86BA2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 22:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B6D1C218A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 21:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C06370055;
	Wed, 28 Feb 2024 21:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBLT9KkY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04D13FB97;
	Wed, 28 Feb 2024 21:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709156835; cv=none; b=lrdt9zr/b56WOXfs65G+cw1+Cczg7Jzq1qER/bxb54T3Ea7LrwxPBQh001hcy2D3iMie7zji6o1NGLAQ+ugIQzgdmVSHkaUbQJg+Vs11me0LIX3647G7x/OXeCmFZkYrrfGS6aNCI1ln+bojMv3zwvEj3BK56hyEtZ+wvOOx7ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709156835; c=relaxed/simple;
	bh=sxZkuOb7q4tDGVwfQR84w+qL7n5xeOeJqnEC5GcENck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tBlJc7lCL1eFlOraO1pY/2/E2c582m/nhR1ymZxn89tgCImcq4XkBnTmzHU2eP2LPlsBM4TR86mduuLQaCe7+0vCoDmx3/ZqMk0XiFwdT8xFy3EHMu8WKigyb+MzN+lnu1bZbRuyGQapD/fmPri/xSw6PObx6o69PoAxBMPKIbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBLT9KkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACC0C433F1;
	Wed, 28 Feb 2024 21:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709156835;
	bh=sxZkuOb7q4tDGVwfQR84w+qL7n5xeOeJqnEC5GcENck=;
	h=From:To:Cc:Subject:Date:From;
	b=NBLT9KkYzdKS7QSnvZ7KA72L3EpUiVoxlKlVr2PbI6c1Ufti5h2DT5m8VvAKzchcV
	 u5bK2BpSOkOsH4pn7khd/2M4ASoElLqATSSx0MCTGgWekJ0+bsC4ecbtBCLHp69JiD
	 vktpr9Gt00Ba2mBXfO4M0a/0TZRemDSmMk082t1lDNrZPOOQRHvYvkVQHAPG2JVqFo
	 11Z63fk2hWSazvSjPl5/nymWcwCmtaWHbdhHE+m4ucNoh0214aaY2DNigqLUAvtoa9
	 /C86MauACM1Kh6yO+ycdxrE7icjc1EF+lmYWXtZMSs0dQs2XM9vaCoTcPxJQiT9bxc
	 VUDkEmADftTwg==
From: Arnd Bergmann <arnd@kernel.org>
To: Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Jane Chu <jane.chu@oracle.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtiofs: don't mark virtio_fs_sysfs_exit as __exit
Date: Wed, 28 Feb 2024 22:46:59 +0100
Message-Id: <20240228214708.611460-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Calling an __exit function from an __init function is not allowed
and will result in undefined behavior when the code is built-in:

WARNING: modpost: vmlinux: section mismatch in reference: virtio_fs_init+0x50 (section: .init.text) -> virtio_fs_sysfs_exit (section: .exit.text)

Remove the incorrect annotation.

Fixes: a8f62f50b4e4 ("virtiofs: export filesystem tags through sysfs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/fuse/virtio_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 3a7dd48b534f..36d87dd3cb48 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1595,7 +1595,7 @@ static int __init virtio_fs_sysfs_init(void)
 	return 0;
 }
 
-static void __exit virtio_fs_sysfs_exit(void)
+static void virtio_fs_sysfs_exit(void)
 {
 	kset_unregister(virtio_fs_kset);
 	virtio_fs_kset = NULL;
-- 
2.39.2


