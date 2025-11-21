Return-Path: <linux-fsdevel+bounces-69411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E43DBC7B2FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5E104EB1BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392B7350D7E;
	Fri, 21 Nov 2025 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2n3XTg+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BA134F248
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748079; cv=none; b=SGGHuE8wCZ0AnX0Q8txYu0kymcwcmBf8ht5D5rG9EkzmpjblTfnYCfS6105TiXQ16Dp3Fblbjl9mMfO/mAk+dF8aU+Sbjw5yokJMBmb+PZCUclxNBgIDYLcvkyVYvyvDQcV7NH2CsOse5Jgp5BmKEarbMlg8SE2f/ovcdIjt15M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748079; c=relaxed/simple;
	bh=LskDtvD/Y0zigIriafxUjxIzNpfNJp9mFCxAppJ2g4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PoM5n5siUJrI4j+6Q9HgR+mrDfrxci+ayNbVd2VXGJVjWApSFzDMTV37yodHQnywxoxBYJFz04BdMjUUcM8tS0ajmmYZOJ/rpcBV/TfZgg4znlbKIHJ3MS0TFLWRBCEVGZNLOJFyJzlaDRGXqQEF4A4YSKzOOu15CmrrY830OUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2n3XTg+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12E9C116D0;
	Fri, 21 Nov 2025 18:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748079;
	bh=LskDtvD/Y0zigIriafxUjxIzNpfNJp9mFCxAppJ2g4I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N2n3XTg+HTGB4n6S7c9hbotpdGtrnsOXahAWUs6C8d11byaxZpdHzcOTRiE9BnWW0
	 Qf1awiQkPXdgpI9NTBNKsKaCG5bGNU7U3hDQmQuwgN1pdTB5yrUhzYi1dZxZ5JbiMm
	 FQMonr/eI7ALhYDRcyxjrfy6lZ9fXuZOuoK0hvs6J0Pow7Xv1Lcm4BnRO2PmlfgKIv
	 NIO1DtWGRnHG44m2qG21D0WFmS5CrQsEiIk7XTAXWJ1CBgsEsZgZ13Pe17RwC98trB
	 U3DSKH4eDzkiV3q9edG4GvUDoH7c6zYgh4jc7qtRsFaIY+6BOCvHm7yt6CCKhJ+1UY
	 sKu8PvAEc0n3g==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:00:52 +0100
Subject: [PATCH RFC v3 13/47] open: convert do_sys_openat2() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-13-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223; i=brauner@kernel.org;
 h=from:subject:message-id; bh=LskDtvD/Y0zigIriafxUjxIzNpfNJp9mFCxAppJ2g4I=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrDgfof/PRijXfPWWV7eU0n8UOc8WkHa/y6T2jy+hd
 mYU8xqjjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImkWjIydH97ICUjkHN7wpp7
 ib57GQQYBaWkF3i9OlFs6nDt3syqKEaGE7/Nbtur6c6Ocj/qwMjpv+DdhHNtTV3njM2Cpl2dIDu
 XBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/open.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 3d64372ecc67..5b86cea07a89 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1421,8 +1421,8 @@ static int do_sys_openat2(int dfd, const char __user *filename,
 			  struct open_how *how)
 {
 	struct open_flags op;
-	struct filename *tmp;
-	int err, fd;
+	struct filename *tmp __free(putname);
+	int err;
 
 	err = build_open_flags(how, &op);
 	if (unlikely(err))
@@ -1432,18 +1432,11 @@ static int do_sys_openat2(int dfd, const char __user *filename,
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
 
-	fd = get_unused_fd_flags(how->flags);
-	if (likely(fd >= 0)) {
-		struct file *f = do_filp_open(dfd, tmp, &op);
-		if (IS_ERR(f)) {
-			put_unused_fd(fd);
-			fd = PTR_ERR(f);
-		} else {
-			fd_install(fd, f);
-		}
-	}
-	putname(tmp);
-	return fd;
+	FD_PREPARE(fdf, how->flags, do_filp_open(dfd, tmp, &op));
+	err = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (err)
+		return err;
+	return fd_publish(fdf);
 }
 
 int do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)

-- 
2.47.3


