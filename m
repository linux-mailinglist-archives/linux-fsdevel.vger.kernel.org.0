Return-Path: <linux-fsdevel+bounces-69426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C478C7B2DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29EC3A14BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785D634F257;
	Fri, 21 Nov 2025 18:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPYpRSpZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE33733A012
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748110; cv=none; b=b6mQQlDfET9/DZShqJobUSsoihbzFzyRi3vMBeCRgP3VhKNrTWXRmG2QDnllKaT0BwUguUcFKSf0OWZMxQbBjRh3BKNlN2RqHiIKxzKRjnVyH95X31pOxLXWk8hnpd4iVwQkZx9w2Oo+vp/DtW9eA8iGGV171PkRc7B20P8wptQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748110; c=relaxed/simple;
	bh=3JIddsv4YdlVoXzeFisOQkBcd9iiLLajqax+XG5cCWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ma2ie4pFumVieqfMdr+n9nlyXrpBwyWQV7n8HtsxRrazrpl9BGVM8bYAxyfZSIoRGm3I7oQLJeRasvraBRVV2MAxZz5vk/i6UzGG7CcFdWEmPD9d2YpQ6NTPOP46X9zF5nDOFkBLLOJhyvLWzxw1nEJLOdzKU5qR+HZu4WaG++c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPYpRSpZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B02C116D0;
	Fri, 21 Nov 2025 18:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748110;
	bh=3JIddsv4YdlVoXzeFisOQkBcd9iiLLajqax+XG5cCWg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZPYpRSpZ0weCLilqyQwIU4o2J3tYR7AhcIJSpPC4OVxowwu9gK+pkK6G6jFQ/kCqV
	 X9LFUcD0ThKg7sm3yBDp77QDIwfFW5jfx9QVyU3EoTAjEkveAb1xEVEKeY9yNeSZMi
	 yZDcN6brNCl5sv4EuOiHvEFvvxgGpBs5rkbNR4HWOOgcoUy7NAtIusJn4q1UnCeWKn
	 yh1OASgb6Sj5dr8U1In5ddxhbKDeuqU6IHFbG/xle2NEYQHfdbXFkiPJAUBcVoQPjj
	 6n595ZW10Ek0c6KytWFQYPaDi5rSskfSIePrQ+ZnCqTjny0s1yP9tewFc/jQa4engQ
	 370ukLpXPrWCg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:01:07 +0100
Subject: [PATCH RFC v3 28/47] net/kcm: convert kcm_ioctl() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-28-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=brauner@kernel.org;
 h=from:subject:message-id; bh=3JIddsv4YdlVoXzeFisOQkBcd9iiLLajqax+XG5cCWg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLhwzdgo8WWo7K07VsIPt75X2PzvaEvprsjVOceWG
 zxLm9NR01HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRo2wMfwV7rvp9Pnprc6L8
 amEtLvHu2841mZMsA54bxM3t6ZtUn8jI8CLq1TLpn6u61/+/xHBXS2kK34VABZHIFTX8m+bbm73
 ewwoA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/kcm/kcmsock.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index b4f01cb07561..dace6fada46d 100644
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
+		FD_PREPARE(fdf, 0, kcm_clone(sock));
+		err = ACQUIRE_ERR(fd_prepare, &fdf);
+		if (err)
+			return err;
 
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


