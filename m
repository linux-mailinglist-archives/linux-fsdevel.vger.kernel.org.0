Return-Path: <linux-fsdevel+bounces-64715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7211FBF1F81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 17:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 247CF34C00E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 15:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A118C22538F;
	Mon, 20 Oct 2025 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b="oXiRzAPm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cse.ust.hk (cssvr7.cse.ust.hk [143.89.41.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F381A0B15;
	Mon, 20 Oct 2025 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=143.89.41.157
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972497; cv=pass; b=DO6bPHSPrZx5ESwJLnxliGnPoH6h82qqoLOTf5VWXrYdIOZId2itfKS9p25o5te5jsQXwzgZrsunHoITwOrCkcrlBoZplmfj8uS10VPZ6tzMHuBohQjBOnB74S30kIvaOWszaKocNLusXX4hWezfI7Yxc8SPQPGI8SlakTjgdAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972497; c=relaxed/simple;
	bh=uHwQSbSvwX77jFTrZuHSBtTMfOYK7bMh93S8+FB93qo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jAFG3HeF870C6nD9IIanY3pHZrTH6NwBvcJOvuTdTsjC7U0dzN1Ss1Ah2cLRBLOiiizeTw2rgI3byHnxVlAxTiq9T6r0KkYLglvuUfanZ503FmSbZthEgLtWhJAENms9cDoXHU4Db5t5Ma+Fmg2l2AgowRhnfZ/2T6qi4QB3C3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk; spf=pass smtp.mailfrom=cse.ust.hk; dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b=oXiRzAPm; arc=pass smtp.client-ip=143.89.41.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.ust.hk
Received: from chcpu18 (191host009.mobilenet.cse.ust.hk [143.89.191.9])
	(authenticated bits=0)
	by cse.ust.hk (8.18.1/8.12.5) with ESMTPSA id 59KF0w7O544379
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 23:01:04 +0800
ARC-Seal: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse; t=1760972464; cv=none;
	b=d9Llu4a+NQAsoR4s9wTSmASeUXXkaX1gOjN7V29sj6ZZVHpOVutZFPgZZVXBqNVnmeEX0lmpS3EGfnHlBfnm7eElz2kIwxAN8DdrouzPkCp2BmqNGGSi615oKhtl9msKEbXrDsganqBZ+IwSCX/VYNBPYUYfU9zx4MdG8tV2f7I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse;
	t=1760972464; c=relaxed/relaxed;
	bh=TLZbZUEJ2i74b5WPOqtLdJuj23kXTE0/xOLQ3/JJXd8=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=dt4DLsTLyFRWWV70K512o2GW4xBXFYvXsDhqyhQ0hJ67Gbb6UqGTKguztmFGMcqFbCKmMQebnwBIqVn4ZjSloiIcll1dVNqaWXCenRNGdXQqGv0gKHU7NHhhrOUiy1saasMCpp+6+LqnbgLhs4zVphPpa5gbf6heL6MvuvVy0es=
ARC-Authentication-Results: i=1; cse.ust.hk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cse.ust.hk;
	s=cseusthk; t=1760972464;
	bh=TLZbZUEJ2i74b5WPOqtLdJuj23kXTE0/xOLQ3/JJXd8=;
	h=Date:From:To:Cc:Subject:From;
	b=oXiRzAPmO3uj712OISpZTmgEUj184xy74ga6vszL+BmTkYCIu6V/KvVFwu+fUQh2e
	 vR0WJdE/Hnpm3dd7Qh40y6ir/rVPjPf+DgdmFORZzH3k4BGotPgtQvv5/EgYOnObgL
	 AANz2gipnL7SReT00eu8RqK1znKjOHVdfkhLoYRA=
Date: Mon, 20 Oct 2025 15:00:53 +0000
From: Shuhao Fu <sfual@cse.ust.hk>
To: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>
Cc: Yuezhang Mo <yuezhang.mo@sony.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] exfat: fix refcount leak in exfat_find
Message-ID: <aPZOpRfVPZCP8vPw@chcpu18>
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
after `exfat_get_dentry_set` to ensure refcount consistency. In 
`exfat_find`, two branchs fail to call `exfat_put_dentry_set`, leading
to possible resource leaks.

Fixes: 82ebecdc74ff ("exfat: fix improper check of dentry.stream.valid_size")
Fixes: 13940cef9549 ("exfat: add a check for invalid data size")
Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
---
 fs/exfat/namei.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 745dce29d..083a9d790 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -646,11 +646,13 @@ static int exfat_find(struct inode *dir, const struct qstr *qname,
 	info->size = le64_to_cpu(ep2->dentry.stream.size);
 
 	if (info->valid_size < 0) {
+		exfat_put_dentry_set(&es, false);
 		exfat_fs_error(sb, "data valid size is invalid(%lld)", info->valid_size);
 		return -EIO;
 	}
 
 	if (unlikely(EXFAT_B_TO_CLU_ROUND_UP(info->size, sbi) > sbi->used_clusters)) {
+		exfat_put_dentry_set(&es, false);
 		exfat_fs_error(sb, "data size is invalid(%lld)", info->size);
 		return -EIO;
 	}
-- 
2.39.5 (Apple Git-154)


