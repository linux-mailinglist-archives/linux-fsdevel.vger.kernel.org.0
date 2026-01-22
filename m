Return-Path: <linux-fsdevel+bounces-75062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGMUIOtMcmnpfAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:14:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB71869B69
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E163D300F16A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74CD3ECBE2;
	Thu, 22 Jan 2026 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="wkB/k3UG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2240D4B8DC2;
	Thu, 22 Jan 2026 15:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769096835; cv=none; b=aUK3pVJDpqVeZRLtSOa4LfSPdG59mI22HqQixox9f/bMxv93eX9oRiWFVCNp4zK2vp6F+pa6GKInhrjduddh9ap0ja0EQwMLU+QI9iM/G2gaNbK9ODKo38yIkvcSlLu3XhUWwbKm13NlDmxi0hOypTXkY7bDQ2dyjIdke8mpdok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769096835; c=relaxed/simple;
	bh=+uFr721NzNRjrhsi+mlKchCob4/qStAazPjjfeeN3Bw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B5gmSnTTKbiWPQi4KcMadhtm5KuQ2wjKZ+NS/a761wqzR0QwUeLU4HI0cown3j+dMwK60zPnsEoSv0pOut+O4xtMCNbf6LxWwcRfx5ee9/YNVfPlMZ96LUzMc2in/JKRDFbAQWHaAxkRPzdqqZlfJcpScvOvmWVK3+x40iR7g5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=wkB/k3UG; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QqSfxPfujpN7eymI2ZrcsWZPzRbFHZJFWOBUz2J8E8c=;
	b=wkB/k3UG20e+95A8eSbEb5xUp0/zduIobFj4GU0J5jk8Q3varvFOUf3FP9m2Nd/sthsnFWZqy
	YH35fYzD+MQV8oYmQSVuTvWBgyX1JkdcKwNRx5Mg/Ft0jeLoUgeHClcxurVjFtpKSxKfWqfFsT6
	Zhd4BoYeGvOZ2ldyRXULCI4=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dxlhq3MHlzmV8f;
	Thu, 22 Jan 2026 23:43:39 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A9C3402AB;
	Thu, 22 Jan 2026 23:47:04 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 23:47:03 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <hch@lst.de>, <djwong@kernel.org>, <amir73il@gmail.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v17 05/10] erofs: using domain_id in the safer way
Date: Thu, 22 Jan 2026 15:34:01 +0000
Message-ID: <20260122153406.660073-6-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20260122153406.660073-1-lihongbo22@huawei.com>
References: <20260122153406.660073-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75062-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[lst.de,kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org,huawei.com];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:dkim,huawei.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB71869B69
X-Rspamd-Action: no action

Either the existing fscache usecase or the upcoming page
cache sharing case, the `domain_id` should be protected as
sensitive information, so we use the safer helpers to allocate,
free and display domain_id.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 Documentation/filesystems/erofs.rst | 5 +++--
 fs/erofs/fscache.c                  | 6 +++---
 fs/erofs/super.c                    | 8 ++++----
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index 08194f194b94..40dbf3b6a35f 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -126,8 +126,9 @@ dax={always,never}     Use direct access (no page cache).  See
 dax                    A legacy option which is an alias for ``dax=always``.
 device=%s              Specify a path to an extra device to be used together.
 fsid=%s                Specify a filesystem image ID for Fscache back-end.
-domain_id=%s           Specify a domain ID in fscache mode so that different images
-                       with the same blobs under a given domain ID can share storage.
+domain_id=%s           Specify a trusted domain ID for fscache mode so that
+                       different images with the same blobs, identified by blob IDs,
+                       can share storage within the same trusted domain.
 fsoffset=%llu          Specify block-aligned filesystem offset for the primary device.
 ===================    =========================================================
 
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index f4937b025038..cd7847fd2670 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -379,7 +379,7 @@ static void erofs_fscache_domain_put(struct erofs_domain *domain)
 		}
 		fscache_relinquish_volume(domain->volume, NULL, false);
 		mutex_unlock(&erofs_domain_list_lock);
-		kfree(domain->domain_id);
+		kfree_sensitive(domain->domain_id);
 		kfree(domain);
 		return;
 	}
@@ -407,7 +407,7 @@ static int erofs_fscache_register_volume(struct super_block *sb)
 	}
 
 	sbi->volume = volume;
-	kfree(name);
+	domain_id ? kfree_sensitive(name) : kfree(name);
 	return ret;
 }
 
@@ -446,7 +446,7 @@ static int erofs_fscache_init_domain(struct super_block *sb)
 	sbi->domain = domain;
 	return 0;
 out:
-	kfree(domain->domain_id);
+	kfree_sensitive(domain->domain_id);
 	kfree(domain);
 	return err;
 }
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index dca1445f6c92..6fbe9220303a 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -525,8 +525,8 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 			return -ENOMEM;
 		break;
 	case Opt_domain_id:
-		kfree(sbi->domain_id);
-		sbi->domain_id = kstrdup(param->string, GFP_KERNEL);
+		kfree_sensitive(sbi->domain_id);
+		sbi->domain_id = no_free_ptr(param->string);
 		if (!sbi->domain_id)
 			return -ENOMEM;
 		break;
@@ -624,7 +624,7 @@ static void erofs_set_sysfs_name(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if (sbi->domain_id)
+	if (sbi->domain_id && sbi->fsid)
 		super_set_sysfs_name_generic(sb, "%s,%s", sbi->domain_id,
 					     sbi->fsid);
 	else if (sbi->fsid)
@@ -852,7 +852,7 @@ static void erofs_sb_free(struct erofs_sb_info *sbi)
 {
 	erofs_free_dev_context(sbi->devs);
 	kfree(sbi->fsid);
-	kfree(sbi->domain_id);
+	kfree_sensitive(sbi->domain_id);
 	if (sbi->dif0.file)
 		fput(sbi->dif0.file);
 	kfree(sbi->volume_name);
-- 
2.22.0


