Return-Path: <linux-fsdevel+bounces-45522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE17EA790C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 16:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1C161892A05
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 14:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6148C23CF0B;
	Wed,  2 Apr 2025 14:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYUCxm6C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5C823C8D9;
	Wed,  2 Apr 2025 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743602914; cv=none; b=WZ4LCYbV1OaA8NSG0hsdyVpu4YgOdaMzctkUMs8QddIZ4jyLX/qTOESZS9fVlFYI2B6Fmc/cTbzctimSVVokoqRzLvkfCPdTcun9IXsICPZpGcnybOAdKRJle4iCdb0L7nOTDAgNZa/C50uTfQk3D+J8ydUn7QElvs0z+B87nME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743602914; c=relaxed/simple;
	bh=0aHy5ajqVlSYjtIMTF8ISiWDHRrTnKpi5swMB8X3rKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgcnIE2sE9Na9h120jKV3uPLL7Ds62EgRKmtK0yl4D3a95aH4RsO2XDqd/pZvD3qV4DX6PV6f3vlzKhEVN3w83JjcV9atJq87YFfbU0VeSK3uxGJM00iDReMHticint/lVEQgJcx14yWcfXt+xsXJA35rQsIegDZWsahsaNHN5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYUCxm6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22BAC4CEEA;
	Wed,  2 Apr 2025 14:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743602914;
	bh=0aHy5ajqVlSYjtIMTF8ISiWDHRrTnKpi5swMB8X3rKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hYUCxm6Cvxxh9ALBDNsw2gTo/C9Bs+kj4vej2Bqw1fdb8VCIHrzbKzRt7ofD1DArY
	 TLUqKSJsVOa6wGAqYxIThUiekCttoN7gl9X/JXrdQpR2I/jORO95H3DD4n80tx6wjB
	 /EW2NxVVu5FXz6LvDH3IWAy/zjkNVq6oJCAwCFb0qYEtAP1klohRkBnuVaTY2TEo2A
	 TB6Bowy+dm+sW3MwFNojvgeX+Hxg3HGnOV67h2pD0AQxEn0rP12VWo9SWgrZD9s32B
	 dbyGWzz/jxXYv14KOBkhnqy+4fOI3NLDTR2WByBKVi1H3yoeHEA54mSv0z3kn+hbVQ
	 yQM4yYdNjEqeA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	jack@suse.cz
Cc: Christian Brauner <brauner@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	mcgrof@kernel.org,
	hch@infradead.org,
	david@fromorbit.com,
	rafael@kernel.org,
	djwong@kernel.org,
	pavel@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com
Subject: [PATCH v2 4/4] kernfs: add warning about implementing freeze/thaw
Date: Wed,  2 Apr 2025 16:07:34 +0200
Message-ID: <20250402-work-freeze-v2-4-6719a97b52ac@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250402-work-freeze-v2-0-6719a97b52ac@kernel.org>
References: <20250402-work-freeze-v2-0-6719a97b52ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636; i=brauner@kernel.org; h=from:subject:message-id; bh=0aHy5ajqVlSYjtIMTF8ISiWDHRrTnKpi5swMB8X3rKk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS/dVm1t/V8uXejQgD3OdddRV+v/V/NoBCzuO5FeXTjq +MOM2SZO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaS8IrhnwrflB/xbU99xN52 HlctKfcX/Hc8zvuhzT75bjsmBT2GNQz/KxwDBF8fP3rMMmPrxPU7TXsTZlzmup3w4EqFxp/omTJ buQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Sysfs is built on top of kernfs and sysfs provides the power management
infrastructure to support suspend/hibernate by writing to various files
in /sys/power/. As filesystems may be automatically frozen during
suspend/hibernate implementing freeze/thaw support for kernfs
generically will cause deadlocks as the suspending/hibernation
initiating task will hold a VFS lock that it will then wait upon to be
released. If freeze/thaw for kernfs is needed talk to the VFS.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/kernfs/mount.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 1358c21837f1..d2073bb2b633 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -62,6 +62,21 @@ const struct super_operations kernfs_sops = {
 
 	.show_options	= kernfs_sop_show_options,
 	.show_path	= kernfs_sop_show_path,
+
+	/*
+	 * sysfs is built on top of kernfs and sysfs provides the power
+	 * management infrastructure to support suspend/hibernate by
+	 * writing to various files in /sys/power/. As filesystems may
+	 * be automatically frozen during suspend/hibernate implementing
+	 * freeze/thaw support for kernfs generically will cause
+	 * deadlocks as the suspending/hibernation initiating task will
+	 * hold a VFS lock that it will then wait upon to be released.
+	 * If freeze/thaw for kernfs is needed talk to the VFS.
+	 */
+	.freeze_fs	= NULL,
+	.unfreeze_fs	= NULL,
+	.freeze_super	= NULL,
+	.thaw_super	= NULL,
 };
 
 static int kernfs_encode_fh(struct inode *inode, __u32 *fh, int *max_len,

-- 
2.47.2


