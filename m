Return-Path: <linux-fsdevel+bounces-64835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBC8BF5501
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 10:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4BC84EDC88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 08:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74C431DDB9;
	Tue, 21 Oct 2025 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b="H/mY+hIM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cse.ust.hk (cssvr7.cse.ust.hk [143.89.41.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32443164AF;
	Tue, 21 Oct 2025 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=143.89.41.157
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761036172; cv=pass; b=eJYwUSuyULtwVYUTe8t/Gpowd88vUyHkgCQrmhZBYQSwwq8qbNwPggbjAspmSCWRdW4rT2oxTBLc1xiTLLAR229fb2DvKVtNtx0JjsTsC3VJpyt8FQENd6QxMdw19pmynwPgo8lWGcPYn97wM7ygBHZeYkel7r9GEW7FTKNU84g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761036172; c=relaxed/simple;
	bh=f4/slYl+iwPHP2mr3qpO+dNTUUS42GlntrdKBm3V37s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F81AT6r0eYDyN92LOV1oNUkpCmOkUzfNdYBmeu+Ai8dD/cvNNflINWbSSeEKnPuG2X5uooZmTQ4V7eurTDcYhiIvN3K5lq0MIaNIOpTYDvNY05apVqEc95aHe/+yxrDSn6Mbp8cPYMJbD+u7L6DA2VRuoVFuBHCg7MK8KsGSMt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk; spf=pass smtp.mailfrom=cse.ust.hk; dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b=H/mY+hIM; arc=pass smtp.client-ip=143.89.41.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.ust.hk
Received: from osx.local (ecs-119-8-240-30.compute.hwclouds-dns.com [119.8.240.30] (may be forged))
	(authenticated bits=0)
	by cse.ust.hk (8.18.1/8.12.5) with ESMTPSA id 59L8gXwn703536
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 16:42:38 +0800
ARC-Seal: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse; t=1761036159; cv=none;
	b=bE3ErNzk+Uq9SeNC25K7SRzQFcNn/QLXYDQLchi4SzFGNjh4RRD7vElCLohH/7kTE4SaT70chKg/q+qqeSZmJOKSMC48PFjwc5cQub6VvuUVvpZre4BDXPS/cWQVvhqV14TE/gt+F/O+5WxsbOL2NOHoXZX9+GRTYr7780XH6kM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse;
	t=1761036159; c=relaxed/relaxed;
	bh=UpSO+x+gL+yq4q/lzAAL/INRINWUbd3sIquDFP2xMXQ=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=tO2j95LRSWvWXkf7XXERuOjlzJwDsoOYMihZpPcKlJac+5Wi2kS30Y1jgl95KBROoZTZzlAFHIbnNvTzNUE8H9sxi5PVHI/gBJkyOnqurxD08LtY2mzHYLfaKIu6OBJql+HA/S2j/j+vMm08KdS1t7tsyBaQ++m0xlljeVQ6KKQ=
ARC-Authentication-Results: i=1; cse.ust.hk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cse.ust.hk;
	s=cseusthk; t=1761036159;
	bh=UpSO+x+gL+yq4q/lzAAL/INRINWUbd3sIquDFP2xMXQ=;
	h=Date:From:To:Cc:Subject:From;
	b=H/mY+hIMplznVzAZvdtvgiyK7TanaVBeb6wvZO4fjis8oGEdfR7k/YiYKtulYdoEC
	 XEgnJEApnk8siezdEiw9fEA7XaSkYoNI2IXaOWxilYIZ6F4FVroD1bYEbbnIIu4hwM
	 mLmGGvi7DhWlc0cbRoWsomF/sLxqU2I0Q7UVY2tU=
Date: Tue, 21 Oct 2025 16:42:28 +0800
From: Shuhao Fu <sfual@cse.ust.hk>
To: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>
Cc: Yuezhang Mo <yuezhang.mo@sony.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] exfat: fix refcount leak in exfat_find
Message-ID: <aPdHWFiCupwDRiFM@osx.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Env-From: sfual

Fix refcount leaks in `exfat_find` related to `exfat_get_dentry_set`.

Function `exfat_get_dentry_set` would increase the reference counter of 
`es->bh` on success. Therefore, `exfat_put_dentry_set` must be called
after `exfat_get_dentry_set` to ensure refcount consistency. This patch
relocate two checks to avoid possible leaks.

Fixes: 82ebecdc74ff ("exfat: fix improper check of dentry.stream.valid_size")
Fixes: 13940cef9549 ("exfat: add a check for invalid data size")
Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
---
Change to v1: [1]
- relocate two checks

[1] https://lore.kernel.org/linux-fsdevel/aPZOpRfVPZCP8vPw@chcpu18/
---
 fs/exfat/namei.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 745dce29d..dfe957493 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -645,16 +645,6 @@ static int exfat_find(struct inode *dir, const struct qstr *qname,
 	info->valid_size = le64_to_cpu(ep2->dentry.stream.valid_size);
 	info->size = le64_to_cpu(ep2->dentry.stream.size);
 
-	if (info->valid_size < 0) {
-		exfat_fs_error(sb, "data valid size is invalid(%lld)", info->valid_size);
-		return -EIO;
-	}
-
-	if (unlikely(EXFAT_B_TO_CLU_ROUND_UP(info->size, sbi) > sbi->used_clusters)) {
-		exfat_fs_error(sb, "data size is invalid(%lld)", info->size);
-		return -EIO;
-	}
-
 	info->start_clu = le32_to_cpu(ep2->dentry.stream.start_clu);
 	if (!is_valid_cluster(sbi, info->start_clu) && info->size) {
 		exfat_warn(sb, "start_clu is invalid cluster(0x%x)",
@@ -692,6 +682,16 @@ static int exfat_find(struct inode *dir, const struct qstr *qname,
 			     0);
 	exfat_put_dentry_set(&es, false);
 
+	if (info->valid_size < 0) {
+		exfat_fs_error(sb, "data valid size is invalid(%lld)", info->valid_size);
+		return -EIO;
+	}
+
+	if (unlikely(EXFAT_B_TO_CLU_ROUND_UP(info->size, sbi) > sbi->used_clusters)) {
+		exfat_fs_error(sb, "data size is invalid(%lld)", info->size);
+		return -EIO;
+	}
+
 	if (ei->start_clu == EXFAT_FREE_CLUSTER) {
 		exfat_fs_error(sb,
 			       "non-zero size file starts with zero cluster (size : %llu, p_dir : %u, entry : 0x%08x)",
-- 
2.39.5 (Apple Git-154)


