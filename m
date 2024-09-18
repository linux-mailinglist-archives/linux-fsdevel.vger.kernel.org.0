Return-Path: <linux-fsdevel+bounces-29642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A440F97BD33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 15:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34EB3B2738D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 13:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CD018A924;
	Wed, 18 Sep 2024 13:40:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B4216FF45
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726666855; cv=none; b=Rlr6939IcMCfb2fmyI4CoTiGCA1B2f01FUlGnupAiFJiNgcIvBGKUS+TwxYy1kooswjYlYe8SuyEqukxKvPRUy0JI7jE7JRlpphigO0NQWRRpVR4EJzGqPKd8ww3NJx5UcIc+SrCQ4Uknl8GKdkiRm7JbeRerlLQqWQwoKKU6YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726666855; c=relaxed/simple;
	bh=skXcaiW7rdCdHukWpzvhWq9PYWRg8uSwK/0zBD+x4R0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LnuhnIjSwPk7GqMifa5pUThnEbOLJQXiqN9yqXErBEGire4Gp9x/Cbi6JG2z3mintt42DWkpYbdESjSBnic/LL6ju+DgAYViW7jdCXm1buvOZoEq+dPb9ZqRklnCmEiss6p/gnKbrerAAip/jjuTdMI+RhIw2RJwZ1M0zrJMgdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F0B21007
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 06:41:22 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 893973F64C
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 06:40:52 -0700 (PDT)
Date: Wed, 18 Sep 2024 14:40:46 +0100
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: move FMODE_UNSIGNED_OFFSET to fop_flags
Message-ID: <ZurYXipwj7jv4gy_@e110455-lin.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Christian,

> This is another flag that is statically set and doesn't need to use up
> an FMODE_* bit. Move it to ->fop_flags and free up another FMODE_* bit.
> 
> (1) mem_open() used from proc_mem_operations
> (2) adi_open() used from adi_fops
> (3) drm_open_helper():
>     (3.1) accel_open() used from DRM_ACCEL_FOPS
>     (3.2) drm_open() used from
>     (3.2.1) amdgpu_driver_kms_fops
>     (3.2.2) psb_gem_fops
>     (3.2.3) i915_driver_fops
>     (3.2.4) nouveau_driver_fops
>     (3.2.5) panthor_drm_driver_fops
>     (3.2.6) radeon_driver_kms_fops
>     (3.2.7) tegra_drm_fops
>     (3.2.8) vmwgfx_driver_fops
>     (3.2.9) xe_driver_fops
>     (3.2.10) DRM_GEM_FOPS
>     (3.2.11) DEFINE_DRM_GEM_DMA_FOPS
> (4) struct memdev sets fmode flags based on type of device opened. For
>     devices using struct mem_fops unsigned offset is used.
> 
> Mark all these file operations as FOP_UNSIGNED_OFFSET and add asserts
> into the open helper to ensure that the flag is always set.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Your patch seems to be missing the panthor_drm_driver_fops changes. I've
discovered that on linux-next your patch triggers a WARN() during my testing.

I've added the following change to my local tree to fix the warning.

-- 8< -------------------------------------------
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
-- 8< -------------------------------------------

Best regards,
Liviu

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

