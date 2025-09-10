Return-Path: <linux-fsdevel+bounces-60740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C05FB51064
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 10:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F459461F5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 08:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F316330DEDE;
	Wed, 10 Sep 2025 07:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ug8330kP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B86C30DD0B;
	Wed, 10 Sep 2025 07:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491141; cv=none; b=Hqi99WZHTQzfJ6/e1YVy4jtBLqovFKjVyK/jyH83GA4PaDs65v52NRaG3fKGzbrQeFbnM9/qFhrQ52TQ0lbWjRncP8Z7DIPtl6Poyqwk3bLX0srWAaEwPD7/PKGeGesUA/e6onSmNQx3GNi9vnBbFd6+0zT0V+oLe5V45B3JchE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491141; c=relaxed/simple;
	bh=mFPObuzpF37b4JTpVbmbqGrsleEfc+vMrJEhgyaAVps=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=pVLfhek52FgnjQj/nrL2qE2EhqRT/6Q8F0NDE2vxCLRZA9wk+LJwL5rjDN7rIfBnc1r4qgMg4hTGNmg+7LkWM98oY9bAxDUEtvRltEZla9S8ZoxXPeLSFi7MTy36HMhX9+6Uje6pmSqIZisKNGbQll9MGdVh+ts4jhKdPvPg30s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ug8330kP; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1757491132; bh=CRkkhFM8grEXCn/UNb5SFiYKtdwx4jQPUUTOBUsnr1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ug8330kPmNPydiEM9gDJFCIG+fIYeUqjPpBiYS7GQG8RzdEca7ogl3GcM6vn9hXWC
	 Dp52U0oftRBuqrCHFx7G+EFWBmbMrcFblrCXcsGUufLzLWgeynkt7rt82XwmUPPQXX
	 xL+e7e/mjPtyXy9zvqD1vO/1DY1gkveCspajISQw=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id EB198E7E; Wed, 10 Sep 2025 15:58:49 +0800
X-QQ-mid: xmsmtpt1757491129thc94ys5b
Message-ID: <tencent_B32D6D8C9450EBFEEE5ACC2C7B0E6C402D0A@qq.com>
X-QQ-XMAILINFO: NG7xP+P+sy64akR4b6dN/NBZT+wuWHSk3x5ICkkVdFquAADQRcZ95scO+BDNin
	 rmqRjFCvaJRYi2wUAmv2g3t1peLlXlYd/93z8ntRdYLpeVbMV6aghH/my5uSqH8mJO+W8OPacB1w
	 4XjbfMgX/uBNhSTP49PTBuWm9WAWc10Z6WNSrZ2OyYWRYAoSU4OgRkk6BHQmovyjv03OvcUloZ66
	 3BYNFmAwhVeM6dnKXAEYneUiwECuuKiojGL2uWwYRwJzjLgT4dLolcZHMoSZLIxjA1CM67Mk7p5M
	 wVDcL7I1ro+N9tKeImwdXM9csDw8s8UDr7b6Vkxej8nTlA24yjhLDvDap/8WU3RHOAXMknkfzXXy
	 2xHjJqRocPSBirGTd4GYD6To+c4ZtffDl8VOI2EtpxLkpLiFONV/UaDPi+HS2nJaxj8R/N7dP0iS
	 a6sANwZliAcqU2llWrYxuplTL/eV3Cmk6S8/i4Y7mh52kmqXuDcl+Rj/0SnCUxvBknooQ7N04O/Q
	 FueEpYAc205DGXZTzqyXlTB18Czo+U3pcP+nUtpyvCeGNAQu7C670DjmHU64JiETChh+pcLeN7Ta
	 gfQo2/NEsvsL64FBmkRhwl2GbJG9VMT55GA6wyHAaNF0/bJ9+vaxMSB9dQkz5uNZpTdQjUzN3CcE
	 c3T1nbe9L00mfLs46v+F/yM+lvfhTBwYyKTgj+zbhzOh6MSTnNXcAXI1ADvJyT8+IbGywpUnCG2Q
	 0/RdoL0tnlALrqBVqe9yMSoSkrGKLIYiP/gK7yAxGyzgkcCqZbEILjFGACmsL3wnUAwKVNb7Jrnd
	 baosfSKS+6rh7ge2uN8Ew0XtfOmpTv920IeCTuEE2YcmIxIBC9UwxxzAyjaeSP+rc00W0+XLH7nM
	 LrV3ECiyDXsTMiIuP0uMM16INfqi9cfBooI6UUcqa6qvpHiozexg/sRxJ3H2tKTYkkw8xIs4IUsr
	 ruZHBv8u23cfmubf2crLBtrK8N64aTRxSis6pikkWgKLsyaQURXpyxhEWKNhBJ
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+b6445765657b5855e869@syzkaller.appspotmail.com
Cc: dakr@kernel.org,
	gregkh@linuxfoundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] USB: core: remove the move buf action
Date: Wed, 10 Sep 2025 15:58:47 +0800
X-OQ-MSGID: <20250910075846.1492634-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68c118e8.a70a0220.3543fc.000e.GAE@google.com>
References: <68c118e8.a70a0220.3543fc.000e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The buffer size of sysfs is fixed at PAGE_SIZE, and the page offset
of the buf parameter of sysfs_emit_at() must be 0, there is no need
to manually manage the buf pointer offset.

Fixes: 711d41ab4a0e ("usb: core: Use sysfs_emit_at() when showing dynamic IDs")
Reported-by: syzbot+b6445765657b5855e869@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b6445765657b5855e869
Tested-by: syzbot+b6445765657b5855e869@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/usb/core/driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index c3177034b779..f441958b0ef4 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -119,11 +119,11 @@ ssize_t usb_show_dynids(struct usb_dynids *dynids, char *buf)
 	guard(mutex)(&usb_dynids_lock);
 	list_for_each_entry(dynid, &dynids->list, node)
 		if (dynid->id.bInterfaceClass != 0)
-			count += sysfs_emit_at(&buf[count], count, "%04x %04x %02x\n",
+			count += sysfs_emit_at(buf, count, "%04x %04x %02x\n",
 					   dynid->id.idVendor, dynid->id.idProduct,
 					   dynid->id.bInterfaceClass);
 		else
-			count += sysfs_emit_at(&buf[count], count, "%04x %04x\n",
+			count += sysfs_emit_at(buf, count, "%04x %04x\n",
 					   dynid->id.idVendor, dynid->id.idProduct);
 	return count;
 }
-- 
2.43.0


