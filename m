Return-Path: <linux-fsdevel+bounces-69309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D0EC7684C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id D892E28A7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EAE3242A7;
	Thu, 20 Nov 2025 22:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aB7bVGoV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DB43587AF
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677997; cv=none; b=p7+BHL/7SD+eKR13LgED6oDm1ABG5fvMnCCoR9msNRrp0O8siTyRNl1oTviKMAuI0xMSciuZl1/TWhxJEDsL9gIu55ujOReiMhrDw87nNd2OQ3LZAcoCDmh1S6MOxWlHHZPSBQGL1oJFqbK0wFfmJJIRj4U/Zpn9b+JjLelCC3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677997; c=relaxed/simple;
	bh=nKyiqCMn79L2AXIH/CsZfWa/m9JxYYpl/HzS0c2qQUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ABfRhwXqD+brm6XuWfRP8FsI8Za5B16/yPU+L0EzO5q3nArYLpBi9sviG4tJGDgsiflhqkK+N7PwN4YKX/WvcfrNjxVT9zac1EcfClJ2oDHZqdG8vsq6dD174HIzOD/prg4JCL3SiZNW2Ad4BcJbXPzCmOJZzXZphfgNLYl9ypg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aB7bVGoV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD411C4CEF1;
	Thu, 20 Nov 2025 22:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677997;
	bh=nKyiqCMn79L2AXIH/CsZfWa/m9JxYYpl/HzS0c2qQUo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aB7bVGoVm8h9OGtJ/i0a71z0G+l/8C+PlXiz0koODzTPaUfasQU9LVbYlZM0F8ZYf
	 rvYQOszXFOp/kXGH0fvsEwgs7J63CtaBeg3r0qxs5qR6DDXs5SlFbDwkRyGVFFKhX4
	 a+YII5MtDyscxClLeAY3IlWc98PQt0Q980oEOedz8mvW7Xup4/2vpOCxJy0KZQvxKa
	 Wkf3fW6NxrpBo0Wg9BSXE96trsBfd+mH2olyvCHgmOMtXBfTiE1jJIqt60VLrKNbaq
	 TQz6NuKpDpJTf4m4jD/C9tgw+fIJeRZ+bRclsTYfLljDItgZ7TWDhFcOlLLwZY1ADE
	 RQjKiKJZHYpMw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:26 +0100
Subject: [PATCH RFC v2 29/48] net/kcm: convert kcm_ioctl() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-29-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1194; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nKyiqCMn79L2AXIH/CsZfWa/m9JxYYpl/HzS0c2qQUo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3srpmyfFxTwf/qZBYHyq3Wuct+fnCPd+Pmc7a1tD
 b8iLe9mdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwky4KR4XxG9eEZC+pXGios
 fML/5FenXKmhvNGXJ2Z1Rz956Dy8VMbIcP0Qc7tR8jbxFVvseCNDjTtV3WZvtGZLqpu/YOf1+o9
 nuAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/kcm/kcmsock.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index b4f01cb07561..bea2cfc8b89c 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1560,25 +1560,17 @@ static int kcm_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	}
 	case SIOCKCMCLONE: {
 		struct kcm_clone info;
-		struct file *file;
 
-		info.fd = get_unused_fd_flags(0);
-		if (unlikely(info.fd < 0))
-			return info.fd;
+		FD_PREPARE(fdf, 0, kcm_clone(sock)) {
+			if (fd_prepare_failed(fdf))
+				return fd_prepare_error(fdf);
 
-		file = kcm_clone(sock);
-		if (IS_ERR(file)) {
-			put_unused_fd(info.fd);
-			return PTR_ERR(file);
-		}
-		if (copy_to_user((void __user *)arg, &info,
-				 sizeof(info))) {
-			put_unused_fd(info.fd);
-			fput(file);
-			return -EFAULT;
+			info.fd = fd_prepare_fd(fdf);
+			if (copy_to_user((void __user *)arg, &info, sizeof(info)))
+				return -EFAULT;
+
+			err = fd_publish(fdf);
 		}
-		fd_install(info.fd, file);
-		err = 0;
 		break;
 	}
 	default:

-- 
2.47.3


