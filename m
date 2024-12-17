Return-Path: <linux-fsdevel+bounces-37613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9C29F4512
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 08:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53409167542
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 07:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97D8189F42;
	Tue, 17 Dec 2024 07:27:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D571E529;
	Tue, 17 Dec 2024 07:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734420436; cv=none; b=BhfBe8arp1zty/q4Crv0wF0/ZzTkl5TGJn74qaChfmuBmDgwmF2xuqdej7o61s5YEp2SrzhZRy9xxf0CK7n9GeUKCTinPK6ZrZtEIUnAXIrsiWB3DBb7QAVuQK4lG9cVU8Z7cQHfrIZQcZhphDzwTg+AoG82u6gQ/lHFXmC84+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734420436; c=relaxed/simple;
	bh=2sGUqM8w9ooXANynqwBRB+/22kC2R1VTet3pCT5HhN4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mr8nyF+EoZ7Vp8TKu5pvDnO7ZEWBHL26cFHgjxXiPQMYsqfejidXrKRWBabLo7ph2W1zw1OG6BQK03/gV522R8q9LnVJFkutYj0KeupQYxX60wRZEFP2X/39r1EiOmOICc4TUj1P+nIWLXWALQX6EESUtfp2fPkHTuK0LUUbdjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YC7c71wz9zhZW8;
	Tue, 17 Dec 2024 15:24:39 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id 37D8C1800E6;
	Tue, 17 Dec 2024 15:27:10 +0800 (CST)
Received: from huawei.com (10.67.175.69) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Dec
 2024 15:27:09 +0800
From: Zhang Kunbo <zhangkunbo@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chris.zjh@huawei.com>, <liaochang1@huawei.com>
Subject: [PATCH -next] fs: fix missing declaration of init_files
Date: Tue, 17 Dec 2024 07:18:36 +0000
Message-ID: <20241217071836.2634868-1-zhangkunbo@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh100007.china.huawei.com (7.202.181.92)

fs/file.c should include include/linux/init_task.h  for
 declaration of init_files. This fixes the sparse warning:

fs/file.c:501:21: warning: symbol 'init_files' was not declared. Should it be static?

Signed-off-by: Zhang Kunbo <zhangkunbo@huawei.com>
---
 fs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/file.c b/fs/file.c
index fb1011cf6b4a..25c6e53b03f8 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -22,6 +22,7 @@
 #include <linux/close_range.h>
 #include <linux/file_ref.h>
 #include <net/sock.h>
+#include <linux/init_task.h>
 
 #include "internal.h"
 
-- 
2.34.1


