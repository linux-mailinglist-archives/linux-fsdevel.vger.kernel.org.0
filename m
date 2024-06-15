Return-Path: <linux-fsdevel+bounces-21741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29AC90957E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 04:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8F921C2166A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 02:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05202748F;
	Sat, 15 Jun 2024 02:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="eJ+iZr/r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F4E173;
	Sat, 15 Jun 2024 02:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718416842; cv=none; b=jvQSIUT58T1r097tRlEEojvYzcWlIhucWce0rBWDHT2m5Gco/2/lByRhgO+A6Ax7mDTTt/L4FTmrF1Y1CLU1ceLZRdp5R9CUvHmrEwtQv9cdZm0lU7ZFmCgC6d/n6/hiflfLuddtJeGGMdYzWMtQHUCevG8bMbXxmejV2i114+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718416842; c=relaxed/simple;
	bh=9ISOyBLtHHQ46y4nFfeB+yVtWI0bgXWueaPVsR6AzWs=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=T3cMapBxCsG4fYdH7uNJg5NnkQmhQkXyu8pwudGe6dS4SbFFyzgWIOTsnNVeRF9bLEPN+KRi8MrWe5mvPfQslYro6NZ70xJJqTOr44ARC/0ShJizaiwLOE61Jjm8pG0CFhmNYCiI55GGMkSbZISQQEPUFLWLPsnAqV/o9ysiwR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=eJ+iZr/r; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718416824; bh=DJDeMoW5K5uNcfOJ2hT7v2SrNoqRd/4YkoDeJ+9atGg=;
	h=From:To:Cc:Subject:Date;
	b=eJ+iZr/rgqwtXgFk/sEqime0C5k4yE25U/jmnPEWAWC/8q2BqQQGkIFqM+trlrh/H
	 z5pt1UltGnF0s/dWrhlidi16ao47Q/QVBvoX6ivKxUfJPxtxz0hMG4LUSqEa7aXr+U
	 3lGGRD7MmGdll1d1Px69VDD81OXZlcTCIqn7xkt0=
Received: from ubuntu.. ([36.129.28.219])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 169DCBE; Sat, 15 Jun 2024 10:00:22 +0800
X-QQ-mid: xmsmtpt1718416822tqw4lq6li
Message-ID: <tencent_3A7366F414667EE52C073850077331ADC709@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjfSY+ydDZN+BXeDP30J0wj4xtvlDZEaDgl4/hAdFzBnXHuaOzt3
	 UZfpMFDC2otftaIGkqU17cEcwh5z9dupvR5HLjTRs2ifVNov15Y1eBrPSsIqVXOzc7EUDvRt41t7
	 sGiPEpiN3fqm9mgu0Bgw4AWnuz1Oxfxw5QH5CGa+9iEhYF2gV426OC2D6eLVaQ/5zzFku8YEgU5O
	 STGfVajBIANG8WDCA46MOmoqw8LasEKQAOfvM8JPmO2jmbjBuFQYCkx9uLIuujtAO4x6e/9sUG4U
	 QfwsoONDMDVhkNTEWCmJU/RTognfjO/5unSq2khU3LHjaLFoGJy30vldq/sL2eJQkeQHIWTVc5hH
	 P/mI7TnME8qK9dM/TsoBnPrSu8KbNIUSFKt9Hjy/qeXiIwbC+I9RDW2bZh+RcnsQEMnoldsVFYs+
	 AL5wxCgLHQkLDAIuctUdFesJsKxgb/JgA31BBhTgGHTTt91LNeEvLnjcNt6/56jAhGkwB93R1Ijv
	 a1zqwcColL86vdO+bWPL6GIytjAzNMPswsAH3lQ2KV3McgQx/ViG/iwTDe4GvaThs9b905DzHas4
	 owEXaNsPl5s7OjRy69GZVyXenZdfez7BwdjJfp6fgx5QyOsR5eVH34VkWDSIuzZwNycqqSDkcfTt
	 3bvn0Rsb1d8AwnYiMX6t+YdHf4nf1TallFrRSKAY6GU15cHXw9CPo2hXsBNZzsubvDrr6UA1uFWK
	 R65k1VWbTmwnri6MloM/fLi1XrNFOUKZV2uBk3JgwCavCEfuTEXAhaiRPAZKljfmQW9y3824ZsSs
	 1uamwi4UAgWdjdiMT0N4IfAWe2npvEj+NcdrRwfvvHqjwSd2+y0zonfB6j+p0l2MercIQBMpkE/s
	 McmFhadDLvBLq2SrHvrOhWNfgMSs6Y83oPrvt5KUt75MObJllPFdRx9IzHrIvTL65stMSI/FYujc
	 yJp+yTofAiwqr8WbP62Gr/JFHh5w/XG84DWXvoRQuJxWqtUSX/oz6H1ryWXQdthKkXd+OlzyiEEs
	 iulhXFVRwdcbOuQ+CJ4zw7b+OZoXc=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Congjie Zhou <zcjie0802@qq.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	Congjie Zhou <zcjie0802@qq.com>
Subject: [PATCH] fs: modify the annotation of vfs_mkdir() in fs/namei.c
Date: Sat, 15 Jun 2024 09:59:13 +0800
X-OQ-MSGID: <20240615015913.14461-1-zcjie0802@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

modify the annotation of @dir and @dentry

Signed-off-by: Congjie Zhou <zcjie0802@qq.com>
---
 fs/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 37fb0a8aa..eda889f0c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4095,8 +4095,8 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
 /**
  * vfs_mkdir - create directory
  * @idmap:	idmap of the mount the inode was found from
- * @dir:	inode of @dentry
- * @dentry:	pointer to dentry of the base directory
+ * @dir:	inode of parent dentry of @dentry
+ * @dentry:	pointer to dentry of the new directory
  * @mode:	mode of the new directory
  *
  * Create a directory.
-- 
2.34.1


