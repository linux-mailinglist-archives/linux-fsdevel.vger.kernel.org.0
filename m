Return-Path: <linux-fsdevel+bounces-25650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB4394E744
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 08:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254FF1F22DEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 06:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A342154C02;
	Mon, 12 Aug 2024 06:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DlpRpY+k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321641509BF
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 06:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445949; cv=none; b=Ea/s1s5mqAXFrCxHHaBdm5ARF/WGtJcaRZ2N3E566rWX2dB4nc15NKT6FeYnxG0uerPXDPRQ1qTlvq95ZUA3ImUVi95ijD94FOb1pjkq/bc3ADJGGrgjNDldq4NXStW5EuXIyII5Ufso5yela1/f6R1rl5tAjRfxBXvWn9XR8Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445949; c=relaxed/simple;
	bh=Ok9ut7y8X79c+S/Ow9yk9XAGtlPsB/mqCx7I05qHFqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=km+j4gAOFg2+dQaCUMAMqYm8IE9JIhmjmOZ9oKCeCThE2WqU+Ep8AZCkUu0ub4n5hZQ9t/8+0WlN5iTI4NAqqCjMaEER33MDWit800OIyPSgljIuv8/xHRh6EjHwQ7CMktp2y6pdgwirMwacjkYP8dk5yCMpXpxLOvSaS/Co0e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DlpRpY+k; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=P53OWdVPNdmYnfxaiQpjH8gBNbpDMToARdSJWb6uK/8=; b=DlpRpY+kn5g5IYU1v5cYqMUOBf
	AX0V1NVFmEnsQ9zvwNA/QNDTKVWD2zw7eS2KU6+KRILyX6TgkDL1TH/J7lRb8v/lZP0btk+LHpdfz
	33pfHiIA1GcLM4EetOgpJE461r3bNxOxDcoi8juYwsitsA1Sf1dLkKpu9xHjgjQWD+cZPJwVOZwyy
	Q19BFW8bagdv1VnJ5LArE7IQEyTR+Swe8iKvjGtgb5SvJ5hadRsf/XJr2CsCEKrCozWeDtPL0Qg8Q
	zYUIiFhkIcUlccVDowMtedtJu3n0nyR842S+r+AjvqMduSnw78W0RCE0A3uuizvL/lk7aPqI5Obro
	dsMgaKlg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sdP1G-000000010nr-2X4U;
	Mon, 12 Aug 2024 06:59:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: viro@zeniv.linux.org.uk
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/4] amdgpu: get rid of bogus includes of fdtable.h
Date: Mon, 12 Aug 2024 07:59:06 +0100
Message-ID: <20240812065906.241398-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812065906.241398-1-viro@zeniv.linux.org.uk>
References: <20240812065656.GI13701@ZenIV>
 <20240812065906.241398-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c           | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 3a3f3ce09f00..2e2cfc5b5ed9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -20,7 +20,6 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 #include <linux/module.h>
-#include <linux/fdtable.h>
 #include <linux/uaccess.h>
 #include <linux/firmware.h>
 #include "amdgpu.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
index 863b2a34b2d6..f9ff493c100e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
@@ -22,7 +22,6 @@
  * Authors: Andres Rodriguez <andresx7@gmail.com>
  */
 
-#include <linux/fdtable.h>
 #include <linux/file.h>
 #include <linux/pid.h>
 
-- 
2.39.2


