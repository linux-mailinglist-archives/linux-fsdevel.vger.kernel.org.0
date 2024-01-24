Return-Path: <linux-fsdevel+bounces-8681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E42E83A29D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 08:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02FD31C22369
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 07:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF29715AF6;
	Wed, 24 Jan 2024 07:05:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72099134CA;
	Wed, 24 Jan 2024 07:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706079925; cv=none; b=aBfi94LpkcLdhbMsAODNISHzdl67NJVKM8wKlWZ0ukv8Bs14O6ARCTctmIiU7d57gWS3171KPkNrOxPKBOKP6FmFY6OgoJ9A1kHBDmalGXuottq4egH69GEXZHeaTJZyDwpHBwe5Um7ygsW6WzweTiFozdfUNv8P/4okugP7Ykk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706079925; c=relaxed/simple;
	bh=JltRLPZqDNzmhUV4hjR1/UlE7k8lRufbY57HDg8lyWE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KR6S9AoJOazNMYhK3xXlxB2WsE00DQvZZAAPw2t9Zn+nXIpYgKvQWmXaMdcq/2SOyn50taxEs8qPcroP0eudDRjjgp8Iwoj26QzvdIUXakVKy9fBoGL8uXoBjtql02wqZJq8YC5HQ8HqYXgYiRYTFZA5QYakH6Rx0VQ7k33LkpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W.FWLHZ_1706079912;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W.FWLHZ_1706079912)
          by smtp.aliyun-inc.com;
          Wed, 24 Jan 2024 15:05:12 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	zhangjiachen.jaycee@bytedance.com
Subject: [PATCH] fuse: increase FUSE_MAX_MAX_PAGES limit
Date: Wed, 24 Jan 2024 15:05:12 +0800
Message-Id: <20240124070512.52207-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Ji <laoji.jx@alibaba-inc.com>

Increase FUSE_MAX_MAX_PAGES limit, so that the maximum data size of a
single request is increased.

This optimizes the write performance especially when the optimal IO size
of the backend store at the fuse daemon side is greater than the original
maximum request size (i.e. 1MB with 256 FUSE_MAX_MAX_PAGES and
4096 PAGE_SIZE).

Be noted that this only increases the upper limit of the maximum request
size, while the real maximum request size relies on the FUSE_INIT
negotiation with the fuse daemon.

Signed-off-by: Xu Ji <laoji.jx@alibaba-inc.com>
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
I'm not sure if 1024 is adequate for FUSE_MAX_MAX_PAGES, as the
Bytedance floks seems to had increased the maximum request size to 8M
and saw a ~20% performance boost.
---
 fs/fuse/fuse_i.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 1df83eebda92..6bd2cf0b42e1 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -36,7 +36,7 @@
 #define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
 
 /** Maximum of max_pages received in init_out */
-#define FUSE_MAX_MAX_PAGES 256
+#define FUSE_MAX_MAX_PAGES 1024
 
 /** Bias for fi->writectr, meaning new writepages must not be sent */
 #define FUSE_NOWRITE INT_MIN
-- 
2.19.1.6.gb485710b


