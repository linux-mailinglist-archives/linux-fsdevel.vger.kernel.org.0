Return-Path: <linux-fsdevel+bounces-38447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F7AA02B4A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 16:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005891885E85
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 15:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F61DDF71;
	Mon,  6 Jan 2025 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b="rKWzZ9y6";
	dkim=permerror (0-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b="BH8lzgUp";
	dkim=pass (2048-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b="Xq8eSv9G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764A51DACBE;
	Mon,  6 Jan 2025 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.185.90.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178107; cv=none; b=UcRUIgTKS/pSqUBMjP4pJRQT3FaBHXIet3WsasZYIj0IOfdnrSZcg1UdSJwiSRF0W8mkvWaobBjzhC9Pt4E/6QUhSnm32ruanrVxNSWaCMJK7MF2HVvmNShemzQgMewtx7ZyqZp9yVxmzLRvAxeni75y4omX3x2MjYoLVhimRwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178107; c=relaxed/simple;
	bh=hSp2/2KeglgI/flnnugGWXi9UTshJjqb2tbMgN4C2dg=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=NMJ8nccqDWRgvoKWw7rULwx09IiQUxz+W8/pJ9Ugd5XIRARgvt/ZLso2+J+0LXGOf+mp2RyHvMosrvCNScF1CEdL8SblDZFa7Bmgt7ktlNfSwCzQPTEKY6xUyKWc6kUGCaSyfNjS2TRRSpGnODb1rxGNjij/Xwi/XnposlzR0mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nerdbynature.de; spf=pass smtp.mailfrom=nerdbynature.de; dkim=permerror (0-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b=rKWzZ9y6; dkim=permerror (0-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b=BH8lzgUp; dkim=pass (2048-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b=Xq8eSv9G; arc=none smtp.client-ip=94.185.90.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nerdbynature.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nerdbynature.de
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=nerdbynature.de; i=@nerdbynature.de; q=dns/txt; s=key1;
 t=1736177525; h=date : from : to : cc : subject : message-id :
 mime-version : content-type : from;
 bh=hSp2/2KeglgI/flnnugGWXi9UTshJjqb2tbMgN4C2dg=;
 b=rKWzZ9y6e/Pg4WzzucR5lNeFttIVqzpHikza93nJ2AdKeMU5ZjRIXFDdFmInQ2ez2wzF8
 TqKdCfo7qcLUOe9Cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=nerdbynature.de;
	s=dkim; t=1736177525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=16laj4Me5+o+WZh3Y/wpz56jOsbL2TRJ0UzNl1rcvH8=;
	b=BH8lzgUphqVJtozumNlml2ElcZhCdswiXxdOwvu+xmOTnYvV3Dxaf14D7kfX8QpaQmUPYq
	zONGEI6spkLfNwBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nerdbynature.de;
 i=@nerdbynature.de; q=dns/txt; s=key0; t=1736177525; h=date : from :
 to : cc : subject : message-id : mime-version : content-type : from;
 bh=hSp2/2KeglgI/flnnugGWXi9UTshJjqb2tbMgN4C2dg=;
 b=Xq8eSv9GMD/L9KqO0xNfJtR8i9Sw5PO2yy97SLMTCPrgZEz/nT9GfOKCbfE4Tccxg7tRf
 l8i36BdKtURf6O4QCqbZULasnDx32NHxmPq9s7KtM6mvRoqgV6jkLz1LoWjWkNBa5uTKhZp
 R3JSjLML2pa67KydVnR6WBVlVcxh1ozCTk5ZClLOrnFwdStymPqv3c/F+Tasc7T5tSUdXRr
 mTyOmLGgEa45R7HuMDNQTx4HmdabPlVGObY9bFkPJ7h/RheunfuJ41b1ApkX6oxTjsbHl6F
 AWfv5jbxispGZsC0J0ixAhoxpAsPG7QVpIJTQyRo1I7hyzGZIF5FpHu4tQKQ==
Received: from localhost (localhost [IPv6:::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by trent.utfs.org (Postfix) with ESMTPS id 9748C5F883;
	Mon,  6 Jan 2025 16:32:05 +0100 (CET)
Date: Mon, 6 Jan 2025 16:32:05 +0100 (CET)
From: Christian Kujau <lists@nerdbynature.de>
To: Hans de Goede <hdegoede@redhat.com>
cc: Arnd Bergmann <arnd@arndb.de>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
    linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] vbox: Enable VBOXGUEST and VBOXSF_FS on ARM64
Message-ID: <7384d96c-2a77-39b0-2306-90129bae9342@nerdbynature.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Now that VirtualBox is able to run as a host on arm64 (e.g. the Apple M3 
processors) we can enable VBOXSF_FS (and in turn VBOXGUEST) for this 
architecture. Tested with various runs of bonnie++ and dbench on an Apple 
MacBook Pro with the latest Virtualbox 7.1.4 r165100 installed.

Signed-off-by: Christian Kujau <lists@nerdbynature.de>
---
 drivers/virt/vboxguest/Kconfig | 2 +-
 fs/vboxsf/Kconfig              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
BOFH excuse #76:

Unoptimized hard drive

