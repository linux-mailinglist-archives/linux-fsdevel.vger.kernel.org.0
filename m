Return-Path: <linux-fsdevel+bounces-72915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3CBD051D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 18:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EBAF7307D497
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 17:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6572C11C9;
	Thu,  8 Jan 2026 17:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+n7g0Lb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7195F1F4168
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767893542; cv=none; b=WKhV5kVgpo5xAMOJnt1i71dLY028fDAdCScIMaJngxPH6hWTFcq9iveXasgc+K7eBoPlKfsPyKwrbcPGeIF365Z59msBEPbdnJwzYsWI5T/Fd6SjPE9EVisRM17l9BByIAcvUCA3vIV/4BQUqcLXGML+QpQ1GAFRfiEntcbgBAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767893542; c=relaxed/simple;
	bh=xzJKW3u2mY+V67Yh7QsfAdtvSWZdkjU8LygyYBwkUz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mXSXBaZiVNtICO6G/nBsd2LwSRe++LWiFZGLXJP7Favs/XaeCiKhKIw6DGQSuunpv1j1acZNVHNtthGDZlV8vHI3cTFNTMRACaK7j0yNqUw+wFetpHNMn9F6fxe+EsopZ3DI05Z3FCFWf5NP8YeQlPnOyLuFqwmJAvIy1IP07w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+n7g0Lb; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b75e366866so914518b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 09:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767893541; x=1768498341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfEmsIj198Gae7+6nneb190u53h9l6A6PCjB1RHQ+i0=;
        b=c+n7g0Lbx+EtZM2Rz1Kgxvdz/7hPgME3pkE5FGlIYlc2l2XFPNQjthNbjSsMVStoD6
         f2j6kbGRNZo+WrlpnyBSQ2K4Kuu6BwhetIaY9KOcyHJHtju6EE0M4MeOIbDTbGW1EI3k
         AjqRxnlh2p9cXqLXOXRsZgIqRDJSDxZybHkg2pbqYHQvJJt1jfnRLSx+0EcPbpQnC2Mi
         amqpelYsDzdDFsnm8AGKbXEyONmda1jdrh1hAH61qOX0/6d8pWSfyWkOUhP8ND1y45Ik
         wcFAgYbYW/AJaVpLajf9exaHNJ2cJo4jDYMC1Xg6S3mSKIiFeN2bzjRS6yCaCvBO1ycH
         7d/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767893541; x=1768498341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IfEmsIj198Gae7+6nneb190u53h9l6A6PCjB1RHQ+i0=;
        b=r/vywf19LQeD5dsVmgXTiJCldooeh+uZf/bTHPfjW3odb+YPl+ep3evtEe2slpSLj8
         7pSN0c2lX15f86BOIuXXmMyq6bzdJoMTU4wvaZL6MUvzCJK9nBaZgr27kMCxKJObRhhp
         a5qxevIT4YUdGWp7n6qpsgYy/BozNhML/fnwlOb4YsvjAlYpdNYzEfmPV+nQHVhBppQP
         QIArB+wmQqpRPKJmGUwroYmmQIChgFjbCwusX7LYJhbs2nuXQ/si2nE4nwhk8FBkSTTZ
         I80bH4yvASq403vg/k6f/Sr++4V9Tu5JGOm8Sp0f6pQBTXfwbOOBdT5LFMzVM3sIvb7h
         LAfg==
X-Gm-Message-State: AOJu0YzOktqXZl1vs4Z2Y91yIxSMU3XXeAPNkX608pkpLMa0X2bs9ZOX
	HH6KKCCr27UrXexruaBLHpbY3kO1jllSDIx8nYwpKW57Lhmsnz887Nwj
X-Gm-Gg: AY/fxX4e2e+yRjByfS0Deueho+UbL+Ov90oaXi310bKEPKF4c4KDqGxSdpvNVWkJY2q
	AZFFpm6aymqg3sX5UV3fh7QoDIU60p8PhqOG3PGQZFuwSeIYYPahKlX0AvMEsyefHczcIppYvbl
	fBeTg6N5NpUwquvYGoD9c3l0DCFyX+SFwu2YVMSxpBrSxE1GpxCZBZ2env6FIRyOQPHK8X8Q2wZ
	yjVard+0olosxOUcFD3Qej3mwBIEOMpey8l5S0JU0oFqhr6F7cV/9Tl/BKAQdK13ZaWVEyr6lkM
	cB0IhqblFdD4GlNqZq6n+V59pHsvlwjHGyWk4I1Cv/zqrdmEgyqBi3HX9AAi2axgf/cz0Qq4zj9
	ZDK7Vzvu2dbR+BdUbCVBRRUyhhWAhY/qd5L7v96sBDgyLTyIqwy0TmikXdw5I6TjgxWN9R6vxlv
	wmOV/jGmJdm0ec/GTPBl/3msHab/uPriKvarvJsw==
X-Google-Smtp-Source: AGHT+IEvwfliopOzpotbxQ1mG4ZsVqsLfeO8CaF/ab6/vSLVbLvAkUWtrc3pNtPR+k34eznpy6VGMg==
X-Received: by 2002:a05:6a21:3291:b0:35f:fafa:a198 with SMTP id adf61e73a8af0-3898f8f4c69mr6290946637.10.1767893540578;
        Thu, 08 Jan 2026 09:32:20 -0800 (PST)
Received: from localhost.localdomain ([111.125.210.92])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbfe1ca23sm8401775a12.12.2026.01.08.09.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 09:32:20 -0800 (PST)
From: Prithvi Tambewagh <activprithvi@gmail.com>
To: syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com,
	hch@lst.de,
	jlbec@evilplan.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Prithvi Tambewagh <activprithvi@gmail.com>
Subject: Syzbot test for fixing recursive locking in __configfs_open_file
Date: Thu,  8 Jan 2026 23:02:11 +0530
Message-Id: <20260108173211.248566-1-activprithvi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6767d8ea.050a0220.226966.0021.GAE@google.com>
References: <6767d8ea.050a0220.226966.0021.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test upstream 3a8660878839faadb4f1a6dd72c3179c1df56787

Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
---
 drivers/target/target_core_configfs.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index b19acd662726..f29052e6a87d 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -108,8 +108,8 @@ static ssize_t target_core_item_dbroot_store(struct config_item *item,
 					const char *page, size_t count)
 {
 	ssize_t read_bytes;
-	struct file *fp;
 	ssize_t r = -EINVAL;
+	struct path path = {};
 
 	mutex_lock(&target_devices_lock);
 	if (target_devices) {
@@ -131,17 +131,18 @@ static ssize_t target_core_item_dbroot_store(struct config_item *item,
 		db_root_stage[read_bytes - 1] = '\0';
 
 	/* validate new db root before accepting it */
-	fp = filp_open(db_root_stage, O_RDONLY, 0);
-	if (IS_ERR(fp)) {
+	r = kern_path(db_root_stage, LOOKUP_FOLLOW, &path);
+	if (r) {
 		pr_err("db_root: cannot open: %s\n", db_root_stage);
 		goto unlock;
 	}
-	if (!S_ISDIR(file_inode(fp)->i_mode)) {
-		filp_close(fp, NULL);
+	if (!d_is_dir(path.dentry)) {
+		path_put(&path);
 		pr_err("db_root: not a directory: %s\n", db_root_stage);
+		r = -ENOTDIR;
 		goto unlock;
 	}
-	filp_close(fp, NULL);
+	path_put(&path);
 
 	strscpy(db_root, db_root_stage);
 	pr_debug("Target_Core_ConfigFS: db_root set to %s\n", db_root);

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.34.1


