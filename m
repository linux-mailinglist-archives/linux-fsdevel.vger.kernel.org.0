Return-Path: <linux-fsdevel+bounces-69429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FD7C7B2DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A623A3F82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DE4352FA0;
	Fri, 21 Nov 2025 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1lIebwf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEA825B31C
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748117; cv=none; b=jVnpe/pMyXedqpTPvSkbJqSdssFh2kDeBmbVL3CxQnUUx1/Tr4K6Rckfy+TcdRaHjEvNBySupyhmaGibHPd1spe2sDrnTmxl14w49esF9u+EkDloSfMGeyiovRl8HGH2LDXFR4flRHWrZ7GBugrcnAx4e0LjkN7JDXfaRNMLwZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748117; c=relaxed/simple;
	bh=5/5NjlGUfW5zCUpzrRCWdtDvV0rzUgq13hWzSERQhsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oCz9b+ZQbxeBUmza4n7XeArMEf1lI4Np3JGGY8VF1Tk+B4cZxw8TCcEmoYKY4lElmnRPI2G0wXqde7waP++SUb+vnNC7Aof4DrGRFA6mJW8RK1tFk4G95IEmnsTzUaqphpEbtba2sW+bOQyjWPO/RxPxutMeQDJjE1yk8Sy79MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1lIebwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABA8C4CEF1;
	Fri, 21 Nov 2025 18:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748117;
	bh=5/5NjlGUfW5zCUpzrRCWdtDvV0rzUgq13hWzSERQhsc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C1lIebwfW1aqDx+/th8NXnES6xTjfrpqKeUYay6yOWTz3GjTsiWWtmoNOHbBL/5Wh
	 TKeBL2rdTRjSae7fqt0mUC6t4nNmifFDInXMb3eFsfg9qgjRWZ9YjwJW8lHfJA1dAx
	 bUakVkXvjj2HB4kg2mpKmekksfC03Udms1iGNZifOTglkERI5ixFD7o6eZFMi6WheR
	 H4cYwdj6MGu9g/uC+MtTmO88kGUs0zSAUDqvX+JpAdCww5TV2rXiWun0HwR5vAe7g3
	 DTdQtt5Wg4pJD0HbUavNqfXaMpT3jzfkft1f9V6Qz6ToC0QOF9eXT2jrLjw6aoxgLv
	 T0KWF+DNs9GLQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:01:10 +0100
Subject: [PATCH RFC v3 31/47] net/socket: convert __sys_accept4_file() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-31-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1331; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5/5NjlGUfW5zCUpzrRCWdtDvV0rzUgq13hWzSERQhsc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLjg2ZellsBye8HHm/7Tw/7JVL2cpBDgW+Kup3Zf/
 c2b7adSO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSvo/hv9v7phXPpaP2/fas
 frOSpeC55t7uqKj3/zOXrZ2493H8wmsM/13/ajB+uZly9cv6uzpRW94IFrTdT3LXav23ZZv6hPu
 fXnABAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/socket.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index af72b10ffe49..13617083f95f 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2007,8 +2007,7 @@ static int __sys_accept4_file(struct file *file, struct sockaddr __user *upeer_s
 			      int __user *upeer_addrlen, int flags)
 {
 	struct proto_accept_arg arg = { };
-	struct file *newfile;
-	int newfd;
+	int err;
 
 	if (flags & ~(SOCK_CLOEXEC | SOCK_NONBLOCK))
 		return -EINVAL;
@@ -2016,18 +2015,12 @@ static int __sys_accept4_file(struct file *file, struct sockaddr __user *upeer_s
 	if (SOCK_NONBLOCK != O_NONBLOCK && (flags & SOCK_NONBLOCK))
 		flags = (flags & ~SOCK_NONBLOCK) | O_NONBLOCK;
 
-	newfd = get_unused_fd_flags(flags);
-	if (unlikely(newfd < 0))
-		return newfd;
+	FD_PREPARE(fdf, flags, do_accept(file, &arg, upeer_sockaddr, upeer_addrlen, flags));
+	err = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (err)
+		return err;
 
-	newfile = do_accept(file, &arg, upeer_sockaddr, upeer_addrlen,
-			    flags);
-	if (IS_ERR(newfile)) {
-		put_unused_fd(newfd);
-		return PTR_ERR(newfile);
-	}
-	fd_install(newfd, newfile);
-	return newfd;
+	return fd_publish(fdf);
 }
 
 /*

-- 
2.47.3


