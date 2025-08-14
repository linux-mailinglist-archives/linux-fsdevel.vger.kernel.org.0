Return-Path: <linux-fsdevel+bounces-57939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A4AB26DA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 19:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C88791722C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 17:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751063093B5;
	Thu, 14 Aug 2025 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Mq5z2A51"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354813090F2;
	Thu, 14 Aug 2025 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755192170; cv=none; b=MyvprnckQx4IEaPtwfKNGi1dhhRX/TtSuCCqbbtOeLQpUIpO8Jbf7oBndAafAZ69PpdrzZpp/se3SLz98t9JpVd+0VjbrU/e08txmMCCaL01dSePLY06OJNSxgn9cGjI3tJR+UHyAvSohgSUpWyM6gEobAxULP5COfsFbbk6CyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755192170; c=relaxed/simple;
	bh=EFjEA7ftO3lBEK6ffWOODoaAEyHoK9FlLLQuiBY3IhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c3LQquYEpeJm3W3wuOa9hOMBcKCjtwFZhgWpaP4dHqPZnTIiAGefDAAld21T2PxzyuNQsZucfkjo53wly75MeCJ6Ij8vPMh1p3XNxmhGFNEWOqs6swjsF5NxwobQXUhV0OJ3nCrq4wnNDiuqr+X+sAN0ov3h6OQJDV4KVgl4Ccw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Mq5z2A51; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=l+EajQQ+PmBq1yQiSrVFmT+z8MVRneEfsXl77NOxCVU=; b=Mq5z2A51pvTNnX090QoGt0HNbf
	PtUKUAZlb6er5z67TxYXJ4NrG64J3s/UFHGW6Cu6daNBEEhSVtU4kJCHyx/ahwq8iaxSZP0R3pzDy
	9YXu3IcGffl0KWSvvO1isB1QnqnOHin1SF14Xd2XUmvVtq307br+NdPkXnf0AwwGLx4ykXaausIFJ
	gfSqeRFAbxPRByBuVVX9f3fHUaJW28gd6SlbTbjKdesm9x/QLM7khpvfTbOGgYaBmW3h9mZzLdbxl
	/0lq8AxuGUK8kpmsORrNrR5P7t3+6CwJcxCbxGKSpB7SEFxKLjeYa6x49aqCF7S4VF//HeOJJsltj
	L+3ZJnvA==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1umbf2-00EDyT-Iu; Thu, 14 Aug 2025 19:22:44 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 14 Aug 2025 14:22:19 -0300
Subject: [PATCH v5 8/9] ovl: Check for casefold consistency when creating
 new dentries
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250814-tonyk-overlayfs-v5-8-c5b80a909cbd@igalia.com>
References: <20250814-tonyk-overlayfs-v5-0-c5b80a909cbd@igalia.com>
In-Reply-To: <20250814-tonyk-overlayfs-v5-0-c5b80a909cbd@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Theodore Tso <tytso@mit.edu>, Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

In a overlayfs with casefold enabled, all new dentries should have
casefold enabled as well. Check this at ovl_create_real().

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v4:
- Add pr_warn()

Changes from v3:
- New patch
---
 fs/overlayfs/dir.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 70b8687dc45e8e33079c865ae302ac58464224a6..88e888ed8696363d6cde39817f6c21e795f0760a 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -187,6 +187,12 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, struct dentry *parent,
 			/* mkdir is special... */
 			newdentry =  ovl_do_mkdir(ofs, dir, newdentry, attr->mode);
 			err = PTR_ERR_OR_ZERO(newdentry);
+			/* expect to inherit casefolding from workdir/upperdir */
+			if (!err && ofs->casefold != ovl_dentry_casefolded(newdentry)) {
+				pr_warn_ratelimited("dentry wrong casefold inheritance");
+				dput(newdentry);
+				err = -EINVAL;
+			}
 			break;
 
 		case S_IFCHR:

-- 
2.50.1


