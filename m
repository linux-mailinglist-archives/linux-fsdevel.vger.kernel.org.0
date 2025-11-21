Return-Path: <linux-fsdevel+bounces-69419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEC0C7B2D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C813A420A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17DA1FF1C4;
	Fri, 21 Nov 2025 18:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwIlm3/f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2E534D38E
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748096; cv=none; b=sRANw9Z0GZZshyItLul+9gPyZrqJj0Pna1d7r77bbZx2CU9voy+zDh4kSgMlanjf+3kaxjxYdgAK+1mv8WZRKp1PrR1jgsAvuqgk0yrMZzIO0WU0Ip5/3qtOf5q0CGLfNZGirfH0nS658rWkm71XDZFvLgnetTiOLDwu1oz2iG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748096; c=relaxed/simple;
	bh=gd9Gug/1Ypstiv3qB6hCAVkcabuN+Wspz1Ampzzupv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eMkEL8iRhxnBS2XOXI0amqClPL6JxL4UCAFnPjqp/Rsg92tsVQQ00akhPNT+9fQsStKeiAknCEmP6eKhq59d4YoQK7Wx/eIe4bbcZ58AMOBqVDIdq/ZGqzaiMOYw/oiQsq/coQgHZM0AhOToEJOWME9WRnf8mLUOmRnk5NR3iCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwIlm3/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51579C116C6;
	Fri, 21 Nov 2025 18:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748095;
	bh=gd9Gug/1Ypstiv3qB6hCAVkcabuN+Wspz1Ampzzupv0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gwIlm3/fz0b0a+nsZsvpjk8iMJGP2GAPC88gxywDMoqc8HdCR9YapZcIU4qWdNMyE
	 CT2Nb9dBqh9ba6utTKdyqnPE6ggiWuIKnHI3v4OreUnA0QEWuaYXv00wNrZUxvTfTK
	 Y8PUQ03KhasqS5di3RZGn9bDhAyWqkvwbhYi533tOLvXHpmdCB5SePKS3ECO+ceUfM
	 5Sido+Zk729Ly+rEobDWZLaWCzB7warIpDUY7/daVSuztVS46cq2Ck5Ip7feQsYkTp
	 Mid90kpxBuk41d7j1W1gKCMiVwTZJ0yK+ZUPDkvj9A6kwkNzztdB7ipYI7aSVnw7f4
	 HnyyGs80eSRrg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:01:00 +0100
Subject: [PATCH RFC v3 21/47] exec: convert begin_new_exec() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-21-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=754; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gd9Gug/1Ypstiv3qB6hCAVkcabuN+Wspz1Ampzzupv0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLjg8CD+wZv9tSk7I8+ZXohPaSrdsftcs/ei3QoXN
 stPUgn73VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR4beMDPc2W+i2PHoo+ebm
 5xc3t355Z90bIuixoey1F++Ry0HbPyQwMpyUeOA4dbbrE3a3+V77TjKYMXy055om8f+yzwPHp8y
 xm/gB
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/exec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 4298e7e08d5d..b19bdcd6fd1e 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1280,12 +1280,12 @@ int begin_new_exec(struct linux_binprm * bprm)
 
 	/* Pass the opened binary to the interpreter. */
 	if (bprm->have_execfd) {
-		retval = get_unused_fd_flags(0);
-		if (retval < 0)
+		FD_PREPARE(fdf, 0, bprm->executable);
+		retval = ACQUIRE_ERR(fd_prepare, &fdf);
+		if (retval)
 			goto out_unlock;
-		fd_install(retval, bprm->executable);
 		bprm->executable = NULL;
-		bprm->execfd = retval;
+		bprm->execfd = fd_publish(fdf);
 	}
 	return 0;
 

-- 
2.47.3


