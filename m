Return-Path: <linux-fsdevel+bounces-58823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D17AB31B4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 16:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C8DB26186
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A94F308F08;
	Fri, 22 Aug 2025 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="oT2XUVCl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E223307AF0;
	Fri, 22 Aug 2025 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872265; cv=none; b=IZD5lcjQje/sZhruoLQ2mHDH5YMgPxeaJFa6i3GN9mEnB5E1wrZflkZh3BqXoUaWc+Ds7Zq3nb2uaf18BDFgZ0sf13KWz+zd9U0Mj5Ch2g3ir4oIPVNK56QD2CRG1/SwrqiMf9i0+7BbrYTJ/RyVo7Qa+LxlyE4v7IMJ0Ehtlv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872265; c=relaxed/simple;
	bh=yPaC5Glj2v8E/U/j7KKPCMSxwIyAupaFWdx6raN4oSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mxUDgEyfJ4rU6XK/8SuZ5YRTc82JQ3bxc/wooZe25EQA6EwLVzqV6Yz5gwrzyNBDtklZT6Xe4W50Pbqv11onr7zRVzwcQ3V1ZjfaT/JvnwpFz30JdtsDCUnZE7TV0ubfZbWxBTZH7rNG+pVCVDLOV+5uPqU9Ad0eNmZF8qwfjZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=oT2XUVCl; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xAbybAjPZpW3tfiX7evcIQkmqOWGp3EHZACJ2zZ+ZRI=; b=oT2XUVClFUJYZybri3xqB6PgOw
	NLQICzS7tEOCDb715XJj7xagWg5m25mT5s2sjdvfc3z1o/iCDlpd+PcdItYawsJelhH53sldQ3NhL
	bW62KPi9/4XgJqHSbFUdHq6lDaaQNrwmRdda6CvUJjRRffHi5uZCnSDEIiFjQ3FP3HJFep4Kav1s5
	cr8FHaaVhbEYZ5n7ueJIlJypAvJP5NY1YU31kpe+Ls7aRe2aS0bn4QYXv/oNuG+nYWoLoNnnryUaf
	vVp0CKwOdrHN38tKiYerIZolDNuSOGDvEiznyl5WffIvYBfK0CSxGtvwzfb0mZRgo6D7M7G6tQg8m
	5p9d/Rcw==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1upSaI-0008Fn-8H; Fri, 22 Aug 2025 16:17:38 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 22 Aug 2025 11:17:11 -0300
Subject: [PATCH v6 8/9] ovl: Check for casefold consistency when creating
 new dentries
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250822-tonyk-overlayfs-v6-8-8b6e9e604fa2@igalia.com>
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
In-Reply-To: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
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

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v5:
- Change pr_warn message
---
 fs/overlayfs/dir.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 70b8687dc45e8e33079c865ae302ac58464224a6..fc1116f36a30e7217939b087435955e18a40ad2e 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -187,6 +187,13 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, struct dentry *parent,
 			/* mkdir is special... */
 			newdentry =  ovl_do_mkdir(ofs, dir, newdentry, attr->mode);
 			err = PTR_ERR_OR_ZERO(newdentry);
+			/* expect to inherit casefolding from workdir/upperdir */
+			if (!err && ofs->casefold != ovl_dentry_casefolded(newdentry)) {
+				pr_warn_ratelimited("wrong inherited casefold (%pd2)\n",
+						    newdentry);
+				dput(newdentry);
+				err = -EINVAL;
+			}
 			break;
 
 		case S_IFCHR:

-- 
2.50.1


