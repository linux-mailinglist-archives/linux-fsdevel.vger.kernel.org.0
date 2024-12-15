Return-Path: <linux-fsdevel+bounces-37447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1339F25F1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 21:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2D6163FA5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 20:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE181BC08B;
	Sun, 15 Dec 2024 20:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b="4dJZX444";
	dkim=permerror (0-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b="W+E0TvQx";
	dkim=pass (2048-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b="dVexOPZr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A53175BF;
	Sun, 15 Dec 2024 20:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.185.90.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734292877; cv=none; b=UpTWjfteB6KflBg1RMY4LLPw5/vFj9bf80Do1KwVqIA5db+4R17UUZq6ETvu4CaAxwW6B69R3Jl9MfHvXODaKoERCO64PQVxqbl7jLHPDwb2u2qwBdVW8dJ+yiNnY8QIAZ7fQCD6JjJX2BSaDBei30L+RzwmDOPSFSOy/ajnaaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734292877; c=relaxed/simple;
	bh=tiwqBk4ozPoEvxpdMpJIp6y1F9A6UZ2uc+0qtRTtF88=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=cqFkuUPtryDtQBC6dvNyVqoYPWnO/tmU0HJb+m3ta3Hg9QaWFuqXfIi7si6FrJLA/3fQlEwRVP9ZZJ2VZaeEOlfh43S/+JPQXxB5KAXrzM9z1ysdAvL6OIqLaDXZCp+DMD+o2iZPLlPSbNuQLmJCxfzVRVBOevllaBzbe1mU1iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nerdbynature.de; spf=pass smtp.mailfrom=nerdbynature.de; dkim=permerror (0-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b=4dJZX444; dkim=permerror (0-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b=W+E0TvQx; dkim=pass (2048-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b=dVexOPZr; arc=none smtp.client-ip=94.185.90.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nerdbynature.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nerdbynature.de
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=nerdbynature.de; i=@nerdbynature.de; q=dns/txt; s=key1;
 t=1734292347; h=date : from : to : cc : subject : message-id :
 mime-version : content-type : from;
 bh=tiwqBk4ozPoEvxpdMpJIp6y1F9A6UZ2uc+0qtRTtF88=;
 b=4dJZX444ql9cJuzIo+PJfmuspAoEtPHngY7tfYOtPJDzRYAAmEQtetMe995eliaglj5HO
 /dQ26L2vm25dwgYBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=nerdbynature.de;
	s=dkim; t=1734292347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=tBGUwwzsmgjikUY6vrtplG7aYnbzaEqx36oiv3+g0PY=;
	b=W+E0TvQx4vC+Yafu1Z5q/YLOaEWj1kawV54ZDvWlP75Ywi2++YiRN2Hjt4NFOtiud4HwIX
	xdB8nr8pzDQDqOBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nerdbynature.de;
 i=@nerdbynature.de; q=dns/txt; s=key0; t=1734292347; h=date : from :
 to : cc : subject : message-id : mime-version : content-type : from;
 bh=tiwqBk4ozPoEvxpdMpJIp6y1F9A6UZ2uc+0qtRTtF88=;
 b=dVexOPZrTnPxhpZf7u25tty0xy+Mp4IQ6l3Wo16qiXhBG4NcHz4YrVMQn/zOEQLjN1ALJ
 BTPMFQiJAbSfQA1N3Xt+Jf4F881bNUlPo/Lham2dPAaVMTeD5A+Q10J7wdGALlcsdtaTmZD
 lgP7EQLVhdKN+2FaYP7mWhF0eAA18Z8yhaKSS3F9bcsrC8z2kZOqC99a+LYQ+REuZk+yL7f
 KpGgzQBE+6GW0GCOtJclaxRriNNeYCo1FjnZ4J/o5bTRdtH5s7sF1dtm4bksqiNV595bzWE
 ZfAo9ZOgbnTWEEQpsfWVjdryd+ywLWaRW+kVgANDRNYoVPU9jvSrZVYlcfrQ==
Received: from localhost (localhost [IPv6:::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by trent.utfs.org (Postfix) with ESMTPS id F18755F9E2;
	Sun, 15 Dec 2024 20:52:26 +0100 (CET)
Date: Sun, 15 Dec 2024 20:52:26 +0100 (CET)
From: Christian Kujau <lists@nerdbynature.de>
To: Hans de Goede <hdegoede@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
    linux-fsdevel@vger.kernel.org
Subject: [PATCH] vbox: arm64 support for vboxguest
Message-ID: <5020bcc7-eea4-b0f5-30c1-1da12efdca8f@nerdbynature.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

My last email[0] still had "RFC" in the subject line, but no comments were 
received. So, in an attempt of stupi^W boldness, this is the same patch 
again, with RFC removed and ready for mainline, maybe?

Hello,

now that VirtualBox able to run as a host on arm64 (e.g. the Apple M3 
processors) I was wondering if there are any plans to port the vboxguest 
driver to that platform? I added ARM64 to the Kconfig files (see below) on 
vboxguest and vboxsf, and also for vboxvideo, and it compiled just like 
that and at least vboxsf appears to work just fine.

I don't know how to test vboxvideo yet (the module loads just fine), but 
if we at least enable to option in the Kconfig file at least people would 
be able to test it :-)

Thanks,
Christian.

[0] https://lore.kernel.org/lkml/f088e1da-8fae-2acb-6f7a-e414708d8e67@nerdbynature.de/

Signed-off-by: Christian Kujau <lists@nerdbynature.de>

    vbox: Enable VBOXGUEST on ARM64

diff --git a/drivers/gpu/drm/vboxvideo/Kconfig b/drivers/gpu/drm/vboxvideo/Kconfig
index 180e30b82ab9..dfe92bf23bde 100644
--- a/drivers/gpu/drm/vboxvideo/Kconfig
+++ b/drivers/gpu/drm/vboxvideo/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config DRM_VBOXVIDEO
 	tristate "Virtual Box Graphics Card"
-	depends on DRM && X86 && PCI
+	depends on DRM && (ARM64 || X86) && PCI
 	select DRM_CLIENT_SELECTION
 	select DRM_KMS_HELPER
 	select DRM_VRAM_HELPER
diff --git a/drivers/virt/vboxguest/Kconfig b/drivers/virt/vboxguest/Kconfig
index cc329887bfae..11b153e7454e 100644
--- a/drivers/virt/vboxguest/Kconfig
+++ b/drivers/virt/vboxguest/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config VBOXGUEST
 	tristate "Virtual Box Guest integration support"
-	depends on X86 && PCI && INPUT
+	depends on (ARM64 || X86) && PCI && INPUT
 	help
 	  This is a driver for the Virtual Box Guest PCI device used in
 	  Virtual Box virtual machines. Enabling this driver will add
diff --git a/fs/vboxsf/Kconfig b/fs/vboxsf/Kconfig
index b84586ae08b3..d4694026db8b 100644
--- a/fs/vboxsf/Kconfig
+++ b/fs/vboxsf/Kconfig
@@ -1,6 +1,6 @@
 config VBOXSF_FS
 	tristate "VirtualBox guest shared folder (vboxsf) support"
-	depends on X86 && VBOXGUEST
+	depends on (ARM64 || X86) && VBOXGUEST
 	select NLS
 	help
 	  VirtualBox hosts can share folders with guests, this driver

-- 
BOFH excuse #326:

We need a licensed electrician to replace the light bulbs in the computer room.

