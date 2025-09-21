Return-Path: <linux-fsdevel+bounces-62340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66325B8DAB4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 14:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A733B6DD9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 12:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAED7274FE0;
	Sun, 21 Sep 2025 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="lohutpMT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4850224679E;
	Sun, 21 Sep 2025 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758457250; cv=none; b=Z+QXE5g3Qsc2UTzH7fI1IDFvTCl/tN/ODRd1g5V4tPBX5D1N+Jd2wn7mwRZiPBxVvCCmDpU/RGnbSQi5d7sXZbgnCbDd8gNLxw6ACv6bxmNeYU0PO7a05SbfK4MosxQ+isAaEhQc70bDopL8/gngdp3BzzyFpOUAuOwSnu6NuhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758457250; c=relaxed/simple;
	bh=0/xFIGPokxVj1/HnD0t8zmXF0Y+RNw3sGgAPWDNgNj8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=rYfzToAXyXRBMJofK3BoUjvPUtJzUdqifQXNkRZdGBEYFCxJIuP7b2itVfImvpH47LCGNcCP0ARs1olRZzJk882u4KYEyZFz9dkJRbx1L8ZFeoysgiFTAva56EbirdjXVvk26cmed1teiBr5a04kxfW98dHcj5Ymvj7pb+zOPy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=lohutpMT; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1758457242; bh=KWPqpIEDljNFZNnGmHMkljrvkkUssbDvBzSFH5RWDI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lohutpMTTJwZiwxwYhNE4SFoweQfzRXSIuaTWghjQ/C3xu6zMd1inuqV4J3UlTa8X
	 PN0IjvgBAYyMqa9oSfxPOS6rX31YsxqNN7dLLoxKGeE/s9+6XTPFOREKSZqrNL0Ak9
	 sVsiwWO+f3h8RXLVMVuCHt85Ouc42p4Vatedje7g=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 527B2895; Sun, 21 Sep 2025 20:20:39 +0800
X-QQ-mid: xmsmtpt1758457239t1no4ihfp
Message-ID: <tencent_E396D637CE4A26757F761367A83C5D366809@qq.com>
X-QQ-XMAILINFO: OU6NwKylrhQGAlkituWv7Ky1XwQlq6/5RieMvypAVhGbzSk3PEcZAwg22VJaKH
	 1Ca83KPtOSNemjIC4ucz0CLaqPU99iokuhd6aTGt/GFtyTz+gePj0+IvBB2hWaYvij2LKcW1ylL4
	 9uIdXJpnfvIehTObs4XqsKKsgXlBhvJd+/T7ds5RuApZZT6fNUCxxmZOpzJ5SNaBlR/7hTYwPxrr
	 MrOn7dKM3u/Syo/4JLamfZTBvbMCT/hUf+FqErVV4Eai+nffooF5sAEBjK7DHMbrTLbnZAFe56M1
	 s9/0VJsG6FPsJr7FIUb+9fESqcAZbP/+W3euhM8Z1RmjNCW6lRbTravB5u7fcV+xmSp8B3HS6SVB
	 48FlV0ulMHgqq+8N+OScRNTHl2J73vQsaQQk/kQVvJnszUggHq9h2CdUTwYvzjZQUvDDaJ66Adth
	 3l43UN0VpAQDRFZl2H8Lch37H6tq3ZRqT/xah2Hr+fJ5hgyth6sywrHfMXqWcFkk+Xo2+tUdEyoe
	 hpoVyNZzTq3cZcWkjZGni4+S5h7FdSbAhlMEawL2tVj5b6+tMaPfoqF8N/S2ZwXnynG/Kl2TR3nb
	 hSncK3oYK+2jbmMX5cxw4LjsZMrJZtw8YMQwudXgYnYJUWUvAOCU1mm4vF1jIYMKvTfnOzq4bm8X
	 YTpHUk2gUvNy2hFfqAh6ITuD1JZsoK7frxZ9WVUhhnxOnyhcWSTKUcTAa3E5NFaI/+q12qQ2+faH
	 yGDZG0sKxlC6a4MPoYR4Q3zoxVpzy1n6AHu1pJnEQuIHs1SajlCvl+uMI/OmexEyCGOA+ZoqJAQw
	 3xHm3qjxK91p04UotZRZd3s6y8LHRX3ulyh/XuRPnXaQwjPPyto4u0U51dfrgsXAxyEUHIfYk/Un
	 nN+c4OcJ9PG1AXPmDEI+70Vd8nhCXqrDx0g0adIxYQBLFywCybLEx3fLfJZJVC+k7PVy1x99gke0
	 EeSZHOhHxQER01FWoRLIC0D3rMdmrJOIPOzBgOBrWhN+8ancdcyVRIIjVl5CvYAGU4DNQUDhs=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+a56aa983ce6a1bf12485@syzkaller.appspotmail.com
Cc: dakr@kernel.org,
	gregkh@linuxfoundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] comedi: Unregister is prohibited when attach fails before register
Date: Sun, 21 Sep 2025 20:20:35 +0800
X-OQ-MSGID: <20250921122034.2602371-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68cf794c.050a0220.13cd81.002a.GAE@google.com>
References: <68cf794c.050a0220.13cd81.002a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reproducer executed the COMEDI_DEVCONFIG command twice against the
c6xdigio driver, first for device comedi3 and then for comedi1. Because
the c6xdigio driver only supports a single port, the COMEDI_DEVCONFIG
command for device comedi1 failed, and the registered driver was released
by executing a detach.

Subsequently, another process attempted the same attach, resulting in a
UAF error when accessing the released drv->p during detach.

When the c6xdigio driver fails to attach, it sets driver to NULL to prevent
the comedi device from calling the detach command of the underlying c6xdigio
driver.

syzbot reported:
CPU: 1 UID: 0 PID: 6035 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(full)
BUG: KASAN: slab-use-after-free in sysfs_remove_file_ns+0x63/0x70 fs/sysfs/file.c:522
Call Trace:
 driver_remove_file+0x4a/0x60 drivers/base/driver.c:197
 bus_remove_driver+0x224/0x2c0 drivers/base/bus.c:743
 driver_unregister+0x76/0xb0 drivers/base/driver.c:277
 comedi_device_detach_locked+0x12f/0xa50 drivers/comedi/drivers.c:207
 comedi_device_detach+0x67/0xb0 drivers/comedi/drivers.c:215
 comedi_device_attach+0x43d/0x900 drivers/comedi/drivers.c:1011

Allocated by task 6034:
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 bus_add_driver+0x92/0x690 drivers/base/bus.c:662
 driver_register+0x15c/0x4b0 drivers/base/driver.c:249
 c6xdigio_attach drivers/comedi/drivers/c6xdigio.c:253 [inline]

Freed by task 6034:
 kobject_put+0x1e7/0x5a0 lib/kobject.c:737
 bus_remove_driver+0x16e/0x2c0 drivers/base/bus.c:749
 driver_unregister+0x76/0xb0 drivers/base/driver.c:277
 comedi_device_detach_locked+0x12f/0xa50 drivers/comedi/drivers.c:207
 comedi_device_detach+0x67/0xb0 drivers/comedi/drivers.c:215
 comedi_device_attach+0x43d/0x900 drivers/comedi/drivers.c:1011

Fixes: 2c89e159cd2f ("Staging: comedi: add c6xdigio driver")
Reported-by: syzbot+a56aa983ce6a1bf12485@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a56aa983ce6a1bf12485
Tested-by: syzbot+a56aa983ce6a1bf12485@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/comedi/drivers/c6xdigio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/c6xdigio.c b/drivers/comedi/drivers/c6xdigio.c
index 14b90d1c64dc..023c72e589a7 100644
--- a/drivers/comedi/drivers/c6xdigio.c
+++ b/drivers/comedi/drivers/c6xdigio.c
@@ -242,8 +242,10 @@ static int c6xdigio_attach(struct comedi_device *dev,
 	int ret;
 
 	ret = comedi_request_region(dev, it->options[0], 0x03);
-	if (ret)
+	if (ret) {
+		dev->driver = NULL;
 		return ret;
+	}
 
 	ret = comedi_alloc_subdevices(dev, 2);
 	if (ret)
-- 
2.43.0


