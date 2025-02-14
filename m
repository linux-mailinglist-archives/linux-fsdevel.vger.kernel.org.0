Return-Path: <linux-fsdevel+bounces-41691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A7EA35398
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 02:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A8316C021
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 01:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3748A208D0;
	Fri, 14 Feb 2025 01:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Ialx0MDE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619D53C17
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 01:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739495893; cv=none; b=O8Hz4CTzhgUWe+Y6+kJy5dMhI83jYVXqxmmAsgesupvgdMQGiRWGF07o8mw3dJd3PtqTRTc7VrlZO6AKU97ZrQ1ryc4S5aR6WC6pCxrSidzPplCZto+piU+Rd5KuBDWVhcdpoMY00gsV/bVeD6ENtfuloHUNK/miRuO+5ZhwHDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739495893; c=relaxed/simple;
	bh=jDFx4/M6Dd95DJ6fEWf3f/j302XuSN2kL3QlY6Sy6vo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I9eoOrG/cuSNfT55tQly6hEMF0mCtYYS0o3l0UnPZUfJ/p/DxC+jmyFPUMO8mO3Qgn8gsCysAIP69pUSfjGiNzp5MPa0k3KdOwfe5brSQastR4hf800vcO0n+qr9C2nhCC75uMyU3b51LhVNO2lFhXnHCQr1KAb/Smo6LB/FUvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Ialx0MDE; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1739495882;
	bh=epzYntnZYC2oauZV5TRtv1vIbx/jl+q/O4tJJlrcIe8=;
	h=From:Date:Subject:To:Cc;
	b=Ialx0MDEyeGVbQMVDvyOobVBHCO7TxPxz9qjZetbZ66IEa5e/4RJcL8+enNom0WRR
	 6KBIPw/7WWxfXJ7VfrsKOtJ9u+EW5+JoDftVXpp8ItqFDA3oU+jJD1ARdPfS2wcdJe
	 Cu3Pvz5H/4xX+D44tL+Y8ekBLpfdgWy0keCOzudFvmoLuMvKUqwN0H/OK+wIJYauiO
	 lrHNJ2ncAHnj6eDwqvITTC5JXipdrdb38Z1k5M9ZPVKaFHsE32HyhUzCypwmkuQMb8
	 fAqgqwqrlb2xQV6VcFQticzFHA2kn1a5xP1TwUWP8QwO7lOK92D5ojZbV3/BLWm90u
	 fQCTJTAXKOlag==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id D530D75D1E; Fri, 14 Feb 2025 09:18:02 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Fri, 14 Feb 2025 09:17:53 +0800
Subject: [PATCH] fuse: Return EPERM rather than ENOSYS from link()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-fuse-link-eperm-v1-1-8c241d987008@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAMCZrmcC/x3M0QpAMBSH8VfRuXZqmyl5Fblg/jhhtEVK3t1y+
 bv4vocigiBSnT0UcEmU3SfoPCM3d34Cy5BMRplSGW15PCN4Fb8wDoSNS2t7VWl0rrCUqiNglPs
 /Nu37fh2Qt35hAAAA
X-Change-ID: 20250214-fuse-link-eperm-544b081eac34
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, 
 Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739495882; l=860;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=jDFx4/M6Dd95DJ6fEWf3f/j302XuSN2kL3QlY6Sy6vo=;
 b=7IYqg6N3mQliyO1P2fyPB64yZtXkX0g1pUenylv/RgJpJIhVHfDeChxhJKRyzCZTeXHYRi1Md
 x/5/5jlzYF3AlhAePLPNLABxd0Y2tf++w2ebwfjHZxYer3jzCgqwOFC
X-Developer-Key: i=matt@codeconstruct.com.au; a=ed25519;
 pk=exersTcCYD/pEBOzXGO6HkLd6kKXRuWxHhj+LXn3DYE=

link() is documented to return EPERM when a filesystem doesn't support
the operation, return that instead.

Link: https://github.com/libfuse/libfuse/issues/925
Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
---
 fs/fuse/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 198862b086ff7bad4007ec2f3200377d12a78385..f07ccaefd1ecfe02b806c30fa9edc6f481260ee8 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1137,6 +1137,8 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	else if (err == -EINTR)
 		fuse_invalidate_attr(inode);
 
+	if (err == -ENOSYS)
+		err = -EPERM;
 	return err;
 }
 

---
base-commit: 68763b29e0a6441f57f9ee652bbf8e7bc59183e5
change-id: 20250214-fuse-link-eperm-544b081eac34

Best regards,
-- 
Matt Johnston <matt@codeconstruct.com.au>


