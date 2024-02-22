Return-Path: <linux-fsdevel+bounces-12426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C9385F31B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 09:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E1CEB23A30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 08:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E12724A11;
	Thu, 22 Feb 2024 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aRcOHS/r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF9517583;
	Thu, 22 Feb 2024 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708590985; cv=none; b=UnvW8r0ao0m3hwlsl3FNSbGNIrlzJq3ogdewHlQI5CvumSwR94wTGrzVC9cgTd4MYrSUJ6MihyghLvNCwsZ4AJ+olxieZ1UV1dOsK/rGelOoW8hsG6Fb6k3DFKbeVAME3BQnH5B9HrCY4FJXZWpC0Lk103xJNH0uB1mld2ZbdWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708590985; c=relaxed/simple;
	bh=35o1s17GEgTofroVACV50mopTUDx11285gHuW9ReeHc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N5zcJ/xOkKHkOy6hLLhlnsd4v22Z8XRQoX45rcuG9U5D0GwR7uRxmzlFxpkh5IEervnNSx/QIuRipXDXOVm52sSs1c1MVz91kUSRri2Iqa+hZQYUsV56JC2sd+WAVnI/UMx4/9Bw+KdX/ZfzdA1IS0ZqJvbXWv0v1cIEcbRm5uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aRcOHS/r; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708590977; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=X9yz07D9w8yMy5Y7IPBs0+pEkB7vyXUOF8tVyxWbAGg=;
	b=aRcOHS/ryawRguaMzeoX1EZy6J9O3pMn81rVoRha0GmUmsTPwQ+YNjoH8aKraWjiWdTrtPFy2PYbscwsuzQK+JNwqFua3yQhfPaP5KGKaGo8ky4Gz5KkfyHYAl8SPBWppQGJaSrpjRKwAg8XUDJOOVc2mic1fIFnVgK5dHVwiKg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W10YCEV_1708590966;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W10YCEV_1708590966)
          by smtp.aliyun-inc.com;
          Thu, 22 Feb 2024 16:36:16 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] pidfd: make pidfs_dentry_operations static
Date: Thu, 22 Feb 2024 16:36:04 +0800
Message-Id: <20240222083604.11280-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pidfs_dentry_operations are not used outside the file pidfs.c, so the
modification is defined as static.

fs/pidfs.c:175:32: warning: symbol 'pidfs_dentry_operations' was not declared. Should it be static?

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8284
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/pidfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index c33501c9cd8b..85e9617f0aee 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -172,7 +172,7 @@ static void pidfdfs_prune_dentry(struct dentry *dentry)
 	}
 }
 
-const struct dentry_operations pidfs_dentry_operations = {
+static const struct dentry_operations pidfs_dentry_operations = {
 	.d_delete	= always_delete_dentry,
 	.d_dname	= pidfs_dname,
 	.d_prune	= pidfdfs_prune_dentry,
-- 
2.20.1.7.g153144c


