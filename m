Return-Path: <linux-fsdevel+bounces-38580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38110A04391
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 16:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25763164BC3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 15:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A865E1F2C4C;
	Tue,  7 Jan 2025 15:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b="8w6jIKEs";
	dkim=permerror (0-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b="48F1Iu8B";
	dkim=pass (2048-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b="ndj+F4+E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D6F1F2C4B;
	Tue,  7 Jan 2025 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.185.90.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736262103; cv=none; b=akkektumvqhTfwYbZ+tGw1syI9D8+VT9chjADoLn9f4WJi4A8dXJ1tFgzk/FPEaPyX7WIqPOn9HjAJfxSCukKeF4NdQEp6Q55uamkIbVeRrPdiB0+9KdkomNSEynYE0n9q481YyM9t8WuSzQYQOx8PqPlsAHpsUhMLKE7skAlYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736262103; c=relaxed/simple;
	bh=Qx9w4rABUFJDcA75vJXfrE39IA/yqdDpo/xWmKUr97I=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=fRglWIBm7DffyFKhMSdx21v6pCWA7il1btU7btQLfY+XiGLoh9VfXJqB4yxxkAFOKP06DY1PoiXCc8BnLOAys2QgrfHjh4XTX2WK8SxYwOVLI+rsqOjBUNoF03AVwAsFu9Yj4xnAOKtSlL957uOmwsNi1mKemL/BuWeukCD6Qcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nerdbynature.de; spf=pass smtp.mailfrom=nerdbynature.de; dkim=permerror (0-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b=8w6jIKEs; dkim=permerror (0-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b=48F1Iu8B; dkim=pass (2048-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b=ndj+F4+E; arc=none smtp.client-ip=94.185.90.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nerdbynature.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nerdbynature.de
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=nerdbynature.de; i=@nerdbynature.de; q=dns/txt; s=key1;
 t=1736262094; h=date : from : to : cc : subject : message-id :
 mime-version : content-type : from;
 bh=Qx9w4rABUFJDcA75vJXfrE39IA/yqdDpo/xWmKUr97I=;
 b=8w6jIKEsKvy5EtTzqK3fyVcrE57Y02ZXG7cZ50njj08HhitY+ZRpEeHSjtrl/qbALyiVp
 8uVnDAHezgriWnaBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=nerdbynature.de;
	s=dkim; t=1736262094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=fCw32xNVr3N9HVSIM9el/uDAsXmKS1rjSDRGk3J8Y2Q=;
	b=48F1Iu8B2oWI046voQr2FCNDPoffbVZt7qLWglG5vDeh04DhyWMtSQVsqASGvBDKNrumcD
	qr1zyJdCZXwXSuAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nerdbynature.de;
 i=@nerdbynature.de; q=dns/txt; s=key0; t=1736262094; h=date : from :
 to : cc : subject : message-id : mime-version : content-type : from;
 bh=Qx9w4rABUFJDcA75vJXfrE39IA/yqdDpo/xWmKUr97I=;
 b=ndj+F4+Esn2TXv/xoR76Qi0/Ju3jxFAshtBMUmsK02mLztcuASOd7clC+ftr3W8n6ZiUj
 V2YOp9yMeq5QloVrxLLGf0+oxhyekOQ9saJ9bnpl92LXMPkgsA/7iULVB48BLEpY+ttogcC
 6CmO5aA/uCZwKgJKzOLjeitSkGOqL8aUsoKSULvBJdhoFFNdtmXmvgkgCJXHroa2/YnelnU
 0T1eeK4VP/vwrweO5FdCWW9BnQpAICosPj4D7ZrEdsqfmJYpZJBT1alrP+GMtJEiAOyKjl7
 QOsF3Oju6Lcg99FWQZc+rphQ/dKUnQf/EplF0PMMDF0f/0hrzN4F+kg411/Q==
Received: from localhost (localhost [IPv6:::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by trent.utfs.org (Postfix) with ESMTPS id 0E8EC5F8B2;
	Tue,  7 Jan 2025 16:01:34 +0100 (CET)
Date: Tue, 7 Jan 2025 16:01:34 +0100 (CET)
From: Christian Kujau <lists@nerdbynature.de>
To: Hans de Goede <hdegoede@redhat.com>
cc: Arnd Bergmann <arnd@arndb.de>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
    linux-fsdevel@vger.kernel.org
Subject: [PATCH v3] vbox: Enable VBOXGUEST and VBOXSF_FS on ARM64
Message-ID: <1c6f68d1-a51a-1c38-2eca-89fa63dc30c6@nerdbynature.de>
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>

---
v3: version history added, along with Hans' Reviewed-by

v2: vboxvideo change removed, see:
    https://lore.kernel.org/lkml/7384d96c-2a77-39b0-2306-90129bae9342@nerdbynature.de/

v1: initial version, see:
    https://lore.kernel.org/lkml/a969298e-0986-470c-9711-703af784d672@redhat.com/

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

