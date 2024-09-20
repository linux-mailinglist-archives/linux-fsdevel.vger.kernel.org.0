Return-Path: <linux-fsdevel+bounces-29742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CA897D430
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 12:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25EC7B218C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 10:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473307E583;
	Fri, 20 Sep 2024 10:28:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F396FB6
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2024 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726828093; cv=none; b=rDgCLIw6POYoQEtRvOKkDhGClU16IrIcUy4S4ZM9TkHbK+QQZvu4l44rzRwtPcQ94r2zl1rCgfcjUbcN4ufMuY2WdyuJqr/Uf9Xm2RRMaB1PMURmNrBCn/YT4GYfJxl1DAv7pJN7GPkVTWrY511291cwVfi49cPpEG7e0esc8CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726828093; c=relaxed/simple;
	bh=SVIUTtq7Mu0n7iAb/ZXsPnhXNGK/0Yrp1IT9RpKuSOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OqKFTRdokSfw+2JYTwAgfykDV+EcvjnQaGr2yC5dS6Mxk4arCLYFwOaCrqjHOqdmvI03vfNxNtk54WXUT6ai5pG/HXNUHXNOtnmgOtZK1KiLxT6m3PLLYQe7kPm7qE4Npy/aJs0AL/MhpyGWGJYiTxNAeHoYy4mdiCFlXSTeX+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C1581007;
	Fri, 20 Sep 2024 03:28:40 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 79B293F66E;
	Fri, 20 Sep 2024 03:28:09 -0700 (PDT)
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Christian Brauner <brauner@kernel.org>,
	dri-devel@lists.freedesktop.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] drm/panthor: Add FOP_UNSIGNED_OFFSET to fop_flags
Date: Fri, 20 Sep 2024 11:28:02 +0100
Message-ID: <20240920102802.2483367-1-liviu.dudau@arm.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 641bb4394f40 ("fs: move FMODE_UNSIGNED_OFFSET to fop_flags")
the FMODE_UNSIGNED_OFFSET flag has been moved to fop_flags and renamed,
but the patch failed to make the changes for the panthor driver.
When user space opens the render node the WARN() added by the patch
gets triggered.

Fixes: 641bb4394f40 ("fs: move FMODE_UNSIGNED_OFFSET to fop_flags")
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/panthor/panthor_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 34182f67136c1..c520f156e2d73 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1383,6 +1383,7 @@ static const struct file_operations panthor_drm_driver_fops = {
 	.read = drm_read,
 	.llseek = noop_llseek,
 	.mmap = panthor_mmap,
+	.fop_flags = FOP_UNSIGNED_OFFSET,
 };
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.46.0


