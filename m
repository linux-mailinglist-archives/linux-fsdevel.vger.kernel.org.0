Return-Path: <linux-fsdevel+bounces-64344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5CCBE1B8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 08:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F63188F761
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 06:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A1E2D46AF;
	Thu, 16 Oct 2025 06:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="GKtc2t7y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward200d.mail.yandex.net (forward200d.mail.yandex.net [178.154.239.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE56246760
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 06:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760596153; cv=none; b=fnfkLi31XIHBm7ZaMsuAg3A82nT1+3eBw/kD91xU/yGDlFQ0aCxatKiaa04uKMVkhTgVpGDWVXUaGwyWgUgMtzc6BwpIgXPuCX6P78KuN5WKbOOR/C83fA+XsGULeMJsFRcWuYoWILqtmBU62+u9+io4NFX9xS4vpBWVfWlchtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760596153; c=relaxed/simple;
	bh=VkyUpFoZoDH0DqYLUzfpe1afe15Iy+aUjwEKnsbTTdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mijY44UM7RBDNAKDScJRcvR/WORBZBIG0K2FCVswfKGe6C+7kDFWYdNiUf3Hop7JPVUMZv1fxmmk+u6b85RHCEcxBbXJz75lLn1J6bnV77ahAsAAqVp3ChmITdYPtMbl0y12j7m8vb9uzpV1tdqYrHBVrcDo+nlweGoNl1ilbwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=GKtc2t7y; arc=none smtp.client-ip=178.154.239.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d102])
	by forward200d.mail.yandex.net (Yandex) with ESMTPS id B908582497
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 09:22:56 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:3d48:0:640:52d7:0])
	by forward102d.mail.yandex.net (Yandex) with ESMTPS id 27AEEC009F;
	Thu, 16 Oct 2025 09:22:49 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id mMKGOeWLumI0-cQrJ6ldh;
	Thu, 16 Oct 2025 09:22:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1760595768; bh=RA6Tyr2fpfaMJQxlLqCtk8inIb2W207XTGJT1VIEq94=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=GKtc2t7yoKnyvoOBnt0R6QayysEMQmKWYEVCtYX/VEmhQvcHxr4PXNh+L1l35MTQ0
	 vy5MYoXX3dumzC87ij6q3bxoWtsZPClHb9h0+srl7btTGM02xVdLzIjDt/1IzAroyB
	 JCSxnuULxD70Xr7KB4aS18wr9wuC15zUxAnQ08Zk=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Richard Fung <richardfung@google.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] fuse: fix digest size check in fuse_setup_measure_verity()
Date: Thu, 16 Oct 2025 09:22:47 +0300
Message-ID: <20251016062247.54855-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wnen compiling with clang 21.1.3 and W=1, I've noticed the following:

fs/fuse/ioctl.c:132:18: warning: result of comparison of constant
18446744073709551611 with expression of type '__u16' (aka 'unsigned
short') is always false [-Wtautological-constant-out-of-range-compare]
  132 |         if (digest_size > SIZE_MAX - sizeof(struct fsverity_digest))
      |             ~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Since the actually supported alorithms are SHA256 and SHA512, this is
better to be replaced with the check against FS_VERITY_MAX_DIGEST_SIZE,
which is now equal to SHA512_DIGEST_SIZE and may be adjusted if even
stronger algorithms will be added someday. Compile tested only.

Fixes: 9fe2a036a23c ("fuse: Add initial support for fs-verity")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 fs/fuse/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index fdc175e93f74..03056e6afeb3 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -129,7 +129,7 @@ static int fuse_setup_measure_verity(unsigned long arg, struct iovec *iov)
 	if (copy_from_user(&digest_size, &uarg->digest_size, sizeof(digest_size)))
 		return -EFAULT;
 
-	if (digest_size > SIZE_MAX - sizeof(struct fsverity_digest))
+	if (digest_size > FS_VERITY_MAX_DIGEST_SIZE)
 		return -EINVAL;
 
 	iov->iov_len = sizeof(struct fsverity_digest) + digest_size;
-- 
2.51.0


