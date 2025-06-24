Return-Path: <linux-fsdevel+bounces-52702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB54AE5F47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3218E189931C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9B925B2F0;
	Tue, 24 Jun 2025 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0Rof7TA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE96258CE7;
	Tue, 24 Jun 2025 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753786; cv=none; b=ewrei3jBcNm3QbBq7DB3QLw9gvl5Rt4Du2EFaHbsFX1uHICJzAuuzVe6UjHK0WSIyL4B5npqzFFm42+KmJ2zkjM5JVo4b3kSo6WOOCMpQ+TVbDMXMwHbumvH+kbup8hCSKTARiAVqQPpcpdcGKDy+PPp/oGjF/EV/dH2OqdgsyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753786; c=relaxed/simple;
	bh=KaE3o8NUMUoxnoYJgN7CddjbKmoL6iHIx4UrIi7jaUY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dy7MJ2mzV37ovIs79Dl17sgoiEKsn69w/rBMnYvJpiqaYezUQJHVgIHUvpWydrc+ej239qclYFjFdNw+XEIY+kObYgUh8h+ekoa4TQGugTfJSBdNkAy0pBlxdu2+JdSdyFTj8IOkusVnH4rYlAgz+Up2m84Qd7fgdcv1JYq6VEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0Rof7TA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E455C4CEEF;
	Tue, 24 Jun 2025 08:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750753786;
	bh=KaE3o8NUMUoxnoYJgN7CddjbKmoL6iHIx4UrIi7jaUY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=S0Rof7TAUh+8WyRGJ+Z9yZLcrsXpya8RQx+Lmka6u9wGgJK23tQiHiDQrC9sX3lsl
	 Zxn6xtNG2muhSYjcTj7yb0kdVzYZSQdUFfVUVbH7X5wa3TP0esJvyxanS1rzWeb/Ni
	 3VJyakTDqAa2ZFttmORm6k0QVZN8pFztJD00w6tcF2tpAXVQyfpxsO/bCRi58Sm6YV
	 yESKY2I/Xg9z0MfYnR/lKG18bkmJy78TjT/xVQ+geoPk3kbMVn34V/7dUPhbYuzVsE
	 AQltv9pv3VFFpYtn+JKQrDRGua0+gt2fx3SyTnnxk+o+05MPnjNdDpQaX0KZ8zZxb7
	 TRPR8UgF2Nhqw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Jun 2025 10:29:10 +0200
Subject: [PATCH v2 07/11] uapi/fcntl: add FD_INVALID
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-work-pidfs-fhandle-v2-7-d02a04858fe3@kernel.org>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
In-Reply-To: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=679; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KaE3o8NUMUoxnoYJgN7CddjbKmoL6iHIx4UrIi7jaUY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWREJb5Q/BKcc6j9wprqSdmVunY/2R+udWriiua3YUxUV
 72d/GNPRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERKohgZ+jc/mV3Hqx0iK6bR
 8PjCSp5gbpGbM74q1m9Sme2j8G7lNoZ/uvqv97y6t/Nxa8GLHO30L0rH5h4yTrudIh6ReWLbNDU
 xNgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a marker for an invalid file descriptor.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/uapi/linux/fcntl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index ba4a698d2f33..a5bebe7c4400 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -110,6 +110,7 @@
 #define PIDFD_SELF_THREAD		-10000 /* Current thread. */
 #define PIDFD_SELF_THREAD_GROUP		-10001 /* Current thread group leader. */
 
+#define FD_INVALID			-10009 /* Invalid file descriptor: -10000 - EBADF = -10009 */
 
 /* Generic flags for the *at(2) family of syscalls. */
 

-- 
2.47.2


