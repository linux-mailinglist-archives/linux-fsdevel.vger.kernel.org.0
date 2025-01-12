Return-Path: <linux-fsdevel+bounces-38963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A9BA0A78F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 09:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 755B33A8A19
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 08:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31DD1632DF;
	Sun, 12 Jan 2025 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YTfViQE8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BABA1684AC
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736669230; cv=none; b=VtniZHP8MtWS8tbb2Vvxjv1tYikWGAspi4hiRp7/xL/xox5KWSOl9v9H5jruU7U567TRz51hFDyEhvbKhQC8maP51fup/NKYXET4li19qGu0e/RDeNPh4iOOWk6HJLf01r9taW+Lm+BMXXv8YwwGeD2ZBUwMHseFyuqNkoPNzdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736669230; c=relaxed/simple;
	bh=a80962AGD0bL4RTkj4HI2WkzDl4gR16hvvx0M4XOjRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYQd0C5ObX7FCYu5aLFPibNuTSmr9orUIsMbxEsheNzF/QNudkiatPk0whSYosB+7/Mb4dcos6htQYvkbe4bjRf9hm6lxuNoB/eGsa2202czLpvDcJd0gB8D5KSAqTY523PncUkJihfGhBHmfZpcAdGQ50arK9kxlDDooz7Qw5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YTfViQE8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gX2Z1GBA+HPHQoAFq+18FlcSwvN4OZcqZvt4eAIX0D8=; b=YTfViQE8fMrc9iWdlv4WUr/Kt6
	gypxONDXe9fRLNUvfPWOwT+OLEo2FncK0Xvh3XEc3U16n/n/+0pvG3aDmMP2pLgbCfrEsxKgFdCNx
	vyRzgMXiuBNJwXER3eRXTYQST+ylrstzP38bnp9lnghJlMIm1R6q0ewSYunoVoziY/3B6rPsvfg9o
	4nsrcVoPN09vxpRNAgCXnh07/ELYr20+7zYsHV55E9D/qPGDjX4Kdoegd/jvCmBYFH4wipvNRZLcr
	FRHtlznwIvsfZ1laQoiJHXqa8VPJm10swpNPeuKpjFsGibB1w3IInEfkDr8Y9/C7RIAKxLXoQ/CrL
	Vc/W2wKg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tWszy-00000000ajd-2Slx;
	Sun, 12 Jan 2025 08:07:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH v2 10/21] netdevsim: don't embed file_operations into your structs
Date: Sun, 12 Jan 2025 08:06:54 +0000
Message-ID: <20250112080705.141166-10-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112080705.141166-1-viro@zeniv.linux.org.uk>
References: <20250112080545.GX1977892@ZenIV>
 <20250112080705.141166-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Just use debugfs_get_aux() instead of debugfs_real_fops().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/net/netdevsim/hwstats.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/net/netdevsim/hwstats.c b/drivers/net/netdevsim/hwstats.c
index 0e58aa7f0374..66b3215db3ac 100644
--- a/drivers/net/netdevsim/hwstats.c
+++ b/drivers/net/netdevsim/hwstats.c
@@ -331,7 +331,6 @@ enum nsim_dev_hwstats_do {
 };
 
 struct nsim_dev_hwstats_fops {
-	const struct file_operations fops;
 	enum nsim_dev_hwstats_do action;
 	enum netdev_offload_xstats_type type;
 };
@@ -342,13 +341,12 @@ nsim_dev_hwstats_do_write(struct file *file,
 			  size_t count, loff_t *ppos)
 {
 	struct nsim_dev_hwstats *hwstats = file->private_data;
-	struct nsim_dev_hwstats_fops *hwsfops;
+	const struct nsim_dev_hwstats_fops *hwsfops;
 	struct list_head *hwsdev_list;
 	int ifindex;
 	int err;
 
-	hwsfops = container_of(debugfs_real_fops(file),
-			       struct nsim_dev_hwstats_fops, fops);
+	hwsfops = debugfs_get_aux(file);
 
 	err = kstrtoint_from_user(data, count, 0, &ifindex);
 	if (err)
@@ -381,14 +379,13 @@ nsim_dev_hwstats_do_write(struct file *file,
 	return count;
 }
 
+static struct debugfs_short_fops debugfs_ops = {
+	.write = nsim_dev_hwstats_do_write,
+	.llseek = generic_file_llseek,
+};
+
 #define NSIM_DEV_HWSTATS_FOPS(ACTION, TYPE)			\
 	{							\
-		.fops = {					\
-			.open = simple_open,			\
-			.write = nsim_dev_hwstats_do_write,	\
-			.llseek = generic_file_llseek,		\
-			.owner = THIS_MODULE,			\
-		},						\
 		.action = ACTION,				\
 		.type = TYPE,					\
 	}
@@ -433,12 +430,12 @@ int nsim_dev_hwstats_init(struct nsim_dev *nsim_dev)
 		goto err_remove_hwstats_recursive;
 	}
 
-	debugfs_create_file("enable_ifindex", 0200, hwstats->l3_ddir, hwstats,
-			    &nsim_dev_hwstats_l3_enable_fops.fops);
-	debugfs_create_file("disable_ifindex", 0200, hwstats->l3_ddir, hwstats,
-			    &nsim_dev_hwstats_l3_disable_fops.fops);
-	debugfs_create_file("fail_next_enable", 0200, hwstats->l3_ddir, hwstats,
-			    &nsim_dev_hwstats_l3_fail_fops.fops);
+	debugfs_create_file_aux("enable_ifindex", 0200, hwstats->l3_ddir, hwstats,
+			    &nsim_dev_hwstats_l3_enable_fops, &debugfs_ops);
+	debugfs_create_file_aux("disable_ifindex", 0200, hwstats->l3_ddir, hwstats,
+			    &nsim_dev_hwstats_l3_disable_fops, &debugfs_ops);
+	debugfs_create_file_aux("fail_next_enable", 0200, hwstats->l3_ddir, hwstats,
+			    &nsim_dev_hwstats_l3_fail_fops, &debugfs_ops);
 
 	INIT_DELAYED_WORK(&hwstats->traffic_dw,
 			  &nsim_dev_hwstats_traffic_work);
-- 
2.39.5


