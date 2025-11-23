Return-Path: <linux-fsdevel+bounces-69550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17899C7E3E0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED5A84E2E6D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8BB2D8767;
	Sun, 23 Nov 2025 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwZtqaw+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDBA2248B9
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915675; cv=none; b=gn+/OusRHrv83PJfoZIdNy2jAqsoqw2fYMAJ/ix7fdZH6bxbmy28t4Yu1z0JQeD3YaDJp43MIHVAzT9hIZmtFYc5QmxdUfvtdZHQ9DAxVkPsdlyCnpzSnnkytvYWEfI2pw8sXMDEDTvqKeSyHuiJaEgU5n2fbf0lFIiR2Jhm45U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915675; c=relaxed/simple;
	bh=e4TCm6SAPxYFZTddJzXprcnbY8seSKHtS6z+Ksg40Eo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PQC6tjwqNfMQ1UYuQbVhphzLsiMGW8mOe3VHIvOePmxxDjTn1KnXeLhtraUX7gsfpRXiMYHWHJMCaK9SoyJCOhtnT+4iPYjGTL4oDwp8yMP8MlDJyCdqBi4rqVy9ux+rKYOcTW6QwU9+YH0cKIbpEqpJsEOXdebwWHXg7r3PWQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwZtqaw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0711AC116D0;
	Sun, 23 Nov 2025 16:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915675;
	bh=e4TCm6SAPxYFZTddJzXprcnbY8seSKHtS6z+Ksg40Eo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mwZtqaw+8P4AHy389l279NgI/3jpaHh0JU+hE7lXNNDbSVRov4VWN7aRxwVuVjGF9
	 LnG4XqJEB71GZidsyNCQRHNpHdwGPFGNsmyZx6DG9iKEW267jKnb1aobgQ3QoJZywB
	 ZPJufVS7PmxSYKb+3xX+60QXKfa7R+S1KI/qzgsZA6BSB3HkYkaCOL2pLKlJSxon4G
	 +7y+K57PPM/UuYBTPfjNklDCfjewrBRuvHLxYINLuzaRQ2N7mtTwZoyR9Hs3J47uYH
	 8onAd3h9CnNAFijgBjS7xFJY1GXGBgp3niKJDOnrjfgxxPBHy42L1l4HxFQqvys2jI
	 5CuslmC+a/m5g==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:46 +0100
Subject: [PATCH v4 28/47] net/kcm: convert kcm_ioctl() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-28-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136; i=brauner@kernel.org;
 h=from:subject:message-id; bh=e4TCm6SAPxYFZTddJzXprcnbY8seSKHtS6z+Ksg40Eo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0eJPMgU6ym5HdZ+yD9mnbXnry59rhKex+o6kr8cl
 Aumm6zuKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmEjaaYZ/5jfy/7emLZ397v6X
 T5klN5Zu3SmjNiXiZ8OKZya1rIefsTL8zxcpcG3LubiDqyiNbcsMOdU/J6ZO231e6oplib9Ysd0
 VTgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/kcm/kcmsock.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index b4f01cb07561..7ce5f492df14 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1560,25 +1560,16 @@ static int kcm_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	}
 	case SIOCKCMCLONE: {
 		struct kcm_clone info;
-		struct file *file;
 
-		info.fd = get_unused_fd_flags(0);
-		if (unlikely(info.fd < 0))
-			return info.fd;
+		FD_PREPARE(fdf, 0, kcm_clone(sock));
+		if (fdf.err)
+			return fdf.err;
 
-		file = kcm_clone(sock);
-		if (IS_ERR(file)) {
-			put_unused_fd(info.fd);
-			return PTR_ERR(file);
-		}
-		if (copy_to_user((void __user *)arg, &info,
-				 sizeof(info))) {
-			put_unused_fd(info.fd);
-			fput(file);
+		info.fd = fd_prepare_fd(fdf);
+		if (copy_to_user((void __user *)arg, &info, sizeof(info)))
 			return -EFAULT;
-		}
-		fd_install(info.fd, file);
-		err = 0;
+
+		err = fd_publish(fdf);
 		break;
 	}
 	default:

-- 
2.47.3


