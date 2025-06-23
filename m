Return-Path: <linux-fsdevel+bounces-52497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A0BAE3944
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 11:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 952067A95CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 09:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E47233151;
	Mon, 23 Jun 2025 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sr1oOWyC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680191C3BFC;
	Mon, 23 Jun 2025 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669298; cv=none; b=d4deyHRiyZKBWaZ+jYBxfuoGb1KkN+8/urtWVr54wNAdgOUyn1v2Wo6FreCCt1batwNDs0Th+JqSQ/6Y9lo0iA+31MfdPVbLK/+Zy6yavKva1meaRwIBwGhm+liDY/teZNevajD2jEtaI6Ljmlds3XNIia3WpTYEHgAZ581d8Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669298; c=relaxed/simple;
	bh=x0hJaWV+M6v/bmrgFW41mF0ngSOkgOMOw2KzsQtObgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KuUDAOu8FQTIolgNBptACUZ2hs3xqcVuk4qyhuqtulq1nSwkzVfIXTg7b/mHkqceH/nbE1IT4TjI9YjfquQbbCQ0d21L4IwBf8IAg6/cn3B1xMt2lPZl9yzAD91KLPpP+rOtU/W5lnXSg1yJvD7Ups95opa8AvqLtCSUgwEtglE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sr1oOWyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE859C4CEF1;
	Mon, 23 Jun 2025 09:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750669298;
	bh=x0hJaWV+M6v/bmrgFW41mF0ngSOkgOMOw2KzsQtObgA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sr1oOWyCbuvFvwNKG2qrpMsyoffUsM7FiACqllL8MqOhAHFwLFNP3TcffAhpDrRHq
	 v5X1VXDyE9QxJGQwsprs7uf2O531vQlCP7OaqUkCRMFSjwkQ8+V0sFelA29UQYsdcv
	 MRlpHyJ+hcm3x2n1SVn8vZvaGR9RpXwxm56z9j5zrXcdXpM8hWTUX6h1r4ZN4TFHXR
	 gS6HAKxvwz96LbOLIdUUWtnVRTngoPEgTRzk7W7S3G41PmMi4oQuJDIXHOBU0013Mk
	 PuvSLiujP4gLd0ncU05eHvFUh+ZwtKtSig64cR5YlXDPHA1YWwJyM8Hf7nNvOlACE0
	 qVA9BhPgqpeDg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 23 Jun 2025 11:01:23 +0200
Subject: [PATCH 1/9] fhandle: raise FILEID_IS_DIR in handle_type
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-work-pidfs-fhandle-v1-1-75899d67555f@kernel.org>
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
In-Reply-To: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>, stable@kernel.org
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=826; i=brauner@kernel.org;
 h=from:subject:message-id; bh=x0hJaWV+M6v/bmrgFW41mF0ngSOkgOMOw2KzsQtObgA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWREir/WPdcYGNyZfvIGo4Fs9snDRXLnXh/9n8goHTsj1
 Xjd1RNuHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO5zcnw39Eh4meM+jz55Tw6
 rC0TcmwL/wXNtLcSvpYU8V0j4tPxhQz/FHctuizExue46Z3/+fkFZyexXTEVkZY5l5PktERq0XJ
 5VgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently FILEID_IS_DIR is raised in fh_flags which is wrong.
Raise it in handle->handle_type were it's supposed to be.

Fixes: c374196b2b9f ("fs: name_to_handle_at() support for "explicit connectable" file handles")
Cc: <stable@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fhandle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 3e092ae6d142..66ff60591d17 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -88,7 +88,7 @@ static long do_sys_name_to_handle(const struct path *path,
 		if (fh_flags & EXPORT_FH_CONNECTABLE) {
 			handle->handle_type |= FILEID_IS_CONNECTABLE;
 			if (d_is_dir(path->dentry))
-				fh_flags |= FILEID_IS_DIR;
+				handle->handle_type |= FILEID_IS_DIR;
 		}
 		retval = 0;
 	}

-- 
2.47.2


