Return-Path: <linux-fsdevel+bounces-15821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F0D893903
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 10:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0606B20F4C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 08:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC83DDCD;
	Mon,  1 Apr 2024 08:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="AcruFtp/";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="rGlX5rZL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7808FBED
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Apr 2024 08:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711960041; cv=none; b=tafv8pRAeT7xtvqpOXRM6Lb0SMJC17TPnyGFlQ47pAcnvuSN1eHAQq+n1ZQviE36wnoX/aSTnxIn4wUnEdvZRRP7A5jP+73JagixsKzCh6BMzgy+1AI4YgzsmNVE3dI5KBsKopjGNIEpGmfVitugLSIx9RDFgpXraMv295Q55Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711960041; c=relaxed/simple;
	bh=hZlm0zkFCGTOIDnEXMQmJyM/E8WzgMvLYScHTLu2mus=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dstmloA5qLox7hmWbXoZyYa2nTDQ+torudT1PFaoG4MEH5nPJmsAl2C7tg2e/+nTqg4GHU0+XMmI1vPbv9JAzqwxmffUpBUBWoQsNAZg3lYl9r62BSWYdN5bLXVWP8sIPN4+CuvukREdF+maWfe36/uvam1esShUg1A0goQ3jIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=AcruFtp/; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=rGlX5rZL; arc=none smtp.client-ip=89.207.88.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 540B8C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1711960028; bh=FwL4XEYpWWhPGybJNUUC1YdjhmrAss3icF+IWEyyy18=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=AcruFtp/RvLYnXBBEIp8ynn4mXRFhO4MpUIUHMJrUtT5b+/3qVzQ+1ykUEt8PUG8t
	 MnteY9+WgfLrXVEJLdvmTZXoVBkEIVgrHG4Vr/ot/DNvGWebO9cuiAASi6/2iGfR5N
	 lfeoatikR1DrcqrcOdm7TwvVrLJnvX51cfHeftTQSsqdi0wGMsppnvHJg51atCdrn+
	 mKYCm8NhcQ2MWp+gttbLIdGkYsyuABl/jyIWmboyTdYvoxqSSNzohOlEh7qvNjBH8k
	 LbSI2jxbzLdQk1ZwKPA2rmqlN0hhthtOfT+ybJH4TXO6yZgbEEQxj1dXEkdRrknq90
	 SNhswraLhfJbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1711960028; bh=FwL4XEYpWWhPGybJNUUC1YdjhmrAss3icF+IWEyyy18=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=rGlX5rZLYZTd2zyLCBEwnAdYDUNuMsTvQvNXswmywTPK38O2OvDj+lhWr/6zhhIe4
	 P9aFcSUP+F7Rdan14hpZqiIgHtBDYXtL9nKLPMkYyms4H/ocPDbWhwcHXqptbuDi8v
	 2v/RksgDRQsD6ffPuB1J/QyAVjArrLhWk1Y9Fm/oE9rEIrCDSXHoJcxjZ5iXNlyYMK
	 m5Y0+gLlFBngvpISgXRJH9G6qjuVnAdenxQDJMviD4ZDHPyJdGKmd5jPEFjQIV8y2s
	 Jt94bVBRTFwW5RnYii6HPngILgt7bL10eNZvdzVWSJeDsVb5xEhW0BG5F2RE9j4Xg3
	 URyP/+S6YlKPA==
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
CC: <linux-fsdevel@vger.kernel.org>, <linux@yadro.com>, Dmitry Bogdanov
	<d.bogdanov@yadro.com>
Subject: [PATCH 1/2] configfs: reduce memory consumption by symlinks
Date: Mon, 1 Apr 2024 11:26:54 +0300
Message-ID: <20240401082655.31613-2-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240401082655.31613-1-d.bogdanov@yadro.com>
References: <20240401082655.31613-1-d.bogdanov@yadro.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-07.corp.yadro.com (172.17.11.57) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)

Instead of preallocating PAGE_SIZE for a symlink path, allocate the exact
size of that path.

Fixes: e9c03af21cc7 (configfs: calculate the symlink target only once)
Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>

---
I treat this as bugfux due to reducing of enourmous memory consumption.
---
 fs/configfs/symlink.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
index 0623c3edcfb9..224c9e4899d4 100644
--- a/fs/configfs/symlink.c
+++ b/fs/configfs/symlink.c
@@ -54,7 +54,7 @@ static void fill_item_path(struct config_item * item, char * buffer, int length)
 }
 
 static int configfs_get_target_path(struct config_item *item,
-		struct config_item *target, char *path)
+		struct config_item *target, char **path)
 {
 	int depth, size;
 	char *s;
@@ -66,11 +66,16 @@ static int configfs_get_target_path(struct config_item *item,
 
 	pr_debug("%s: depth = %d, size = %d\n", __func__, depth, size);
 
-	for (s = path; depth--; s += 3)
+	*path = kzalloc(size, GFP_KERNEL);
+	if (!*path)
+		return -ENOMEM;
+
+
+	for (s = *path; depth--; s += 3)
 		strcpy(s,"../");
 
-	fill_item_path(target, path, size);
-	pr_debug("%s: path = '%s'\n", __func__, path);
+	fill_item_path(target, *path, size);
+	pr_debug("%s: path = '%s'\n", __func__, *path);
 	return 0;
 }
 
@@ -79,27 +84,22 @@ static int create_link(struct config_item *parent_item,
 		       struct dentry *dentry)
 {
 	struct configfs_dirent *target_sd = item->ci_dentry->d_fsdata;
-	char *body;
+	char *body = NULL;
 	int ret;
 
 	if (!configfs_dirent_is_ready(target_sd))
 		return -ENOENT;
 
-	body = kzalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!body)
-		return -ENOMEM;
-
 	configfs_get(target_sd);
 	spin_lock(&configfs_dirent_lock);
 	if (target_sd->s_type & CONFIGFS_USET_DROPPING) {
 		spin_unlock(&configfs_dirent_lock);
 		configfs_put(target_sd);
-		kfree(body);
 		return -ENOENT;
 	}
 	target_sd->s_links++;
 	spin_unlock(&configfs_dirent_lock);
-	ret = configfs_get_target_path(parent_item, item, body);
+	ret = configfs_get_target_path(parent_item, item, &body);
 	if (!ret)
 		ret = configfs_create_link(target_sd, parent_item->ci_dentry,
 					   dentry, body);
-- 
2.25.1


