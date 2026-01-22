Return-Path: <linux-fsdevel+bounces-75041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJDEN/kycmmadwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 15:23:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7262F67E15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 15:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C787258B0BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 13:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5D3340A6C;
	Thu, 22 Jan 2026 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="oo7DWSfH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3BE330B22;
	Thu, 22 Jan 2026 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769089823; cv=none; b=Etfm9XEzKc4UA261MprdT1FcugfJsGawqt/B9GvnxN9LqMStM9WCIEU/izp2LQC7d5uqacxIfHGi0KxyuTnD+LSerEBTG2Nu96XBFxQPooI1zdkGWf9eHjex+nf6nylz59oZ368VGYOHdf9gEbYNxVloDO6yGQt2+tnSFjgVD50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769089823; c=relaxed/simple;
	bh=5MfobSVxZXGISDnvwk/oyoJ2THkDS+BLtt7M7DQLhwA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B3+1vNxvvUsLx9ONZvuq8SSuvmx7mtQZJy7cZBEErgxuSwJW1HHcgrtvMGlKrDUmKQ7fHEOQdT+NKjx8KuxEksFW0AVj3oJWWaMp3YXM25LW/ZX4r07pcNt90hwbiuDYDWi5S+RCtRujuwbwswxp0F3eLQXS4bgs2OgDH7/VNhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=oo7DWSfH; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+RJ/lUy/s4IsZLQoItUqmF+7IGRzX6S4ot1reZrnGfM=;
	b=oo7DWSfHxz0tzaJHOoVC3r/qXviwmoPgLWhb+KrBpatngd5uXVxdOxFIiX4r7+E1CWfIwwNeO
	vnSMQYPXGonhfcr3bHFu86XuLvT+cYaHWTLEo0PjmykNrwAX6AM4cwZh/j4INmQO5J7uVJzMH3h
	Brn7uCrXTZeIwXiYVNBrxHI=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dxj5R3tsJzcb0S;
	Thu, 22 Jan 2026 21:46:19 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id DC2B240567;
	Thu, 22 Jan 2026 21:50:18 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 21:50:18 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <hch@lst.de>, <djwong@kernel.org>, <amir73il@gmail.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v16 05/10] erofs: using domain_id in the safer way
Date: Thu, 22 Jan 2026 13:37:13 +0000
Message-ID: <20260122133718.658056-6-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20260122133718.658056-1-lihongbo22@huawei.com>
References: <20260122133718.658056-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FREEMAIL_CC(0.00)[lst.de,kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org,huawei.com];
	DMARC_POLICY_ALLOW(0.00)[huawei.com,quarantine];
	TAGGED_FROM(0.00)[bounces-75041-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7262F67E15
X-Rspamd-Action: no action

Either the existing fscache usecase or the upcoming page
cache sharing case, the `domain_id` should be protected as
sensitive information, so we use the safer helpers to allocate,
free and display domain_id.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 Documentation/filesystems/erofs.rst | 5 +++--
 fs/erofs/fscache.c                  | 4 ++--
 fs/erofs/super.c                    | 8 ++++----
 3 files changed, 9 insertions(+), 8 deletions(-)

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
index f4937b025038..a2cc0f3fa9d0 100644
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


