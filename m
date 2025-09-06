Return-Path: <linux-fsdevel+bounces-60433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9E9B46A93
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9242F3BCAD3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 09:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED792D1303;
	Sat,  6 Sep 2025 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="L3TzgIXF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C56280A35
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149903; cv=none; b=oD+XRx9InyvF9CYbKDUsngzd3X7A7ojmz38QieVjQWj0Mf0gsuV7ZbUTnP8+mdLhngzFQE9AQWHqIc8SRoVzGqDA4ThEy9JyjmwEBIf/kGgayTyHB6SF1+f82f14iop/BTKKZVzAXvNvwsu+kC7+RvEHhxsv9ZVrF4WYjjM0RlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149903; c=relaxed/simple;
	bh=ceRTypVUIdQoEoBJATPAq8XFSYWW0YNuqQibyqaJOkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAJptIOlLvT9q9r4bfiGMvZ0j6gKvAK+WeGzKvM/MZjGl6Ht+RbxzYIYFOudf2QVafvINtY4GGGZ1AX5qLF0zDDMtoiXVX32zrLfh6Jbdqx7nw/XxKFOt2R7UPkn2/WG5GgnRcdqrMna5YAEpdsISFPNk8QfV8l1QohfzUg2aRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=L3TzgIXF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=e21NHevm1a58vBDSUa1xY8wy5k6Z25CjZWQCMMUZrOQ=; b=L3TzgIXFeTJFDmFYe3M60P8zVW
	xcSgfAAjNRPPJclVzTa+6KYQHiGb8zbgstRdafiXyoenzV5oxws5V+RT2s+qTiGslBqgfulgSWHUS
	a/zjS0yLMVQocwU7KVjvwemDrTmPGIfR6fzPWt3R2x7p6OMjSvItQlvkBodAUIagkysmLilp7DO3+
	RXqRGcC2SYJo4iVi7g3EkyvgPzlJeVki+tcE/ek9xZlQKd4gRd8g/erG0xAokOyil8Aql9PD9GtRm
	w/b7FgwgC5gWqGAR6siTVvajlM3abkivwY1KZsDWDPvyNjykG4cCvkesDt+/1iIu0BnfuAenXF4gp
	3d48KdGg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuoxO-00000000OrV-0Uy3;
	Sat, 06 Sep 2025 09:11:38 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org,
	amir73il@gmail.com,
	chuck.lever@oracle.com,
	linkinjeon@kernel.org,
	john@apparmor.net
Subject: [PATCH 02/21] constify path argument of vfs_statx_path()
Date: Sat,  6 Sep 2025 10:11:18 +0100
Message-ID: <20250906091137.95554-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250906091137.95554-1-viro@zeniv.linux.org.uk>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/stat.c b/fs/stat.c
index f95c1dc3eaa4..6c79661e1b96 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -293,7 +293,7 @@ static int statx_lookup_flags(int flags)
 	return lookup_flags;
 }
 
-static int vfs_statx_path(struct path *path, int flags, struct kstat *stat,
+static int vfs_statx_path(const struct path *path, int flags, struct kstat *stat,
 			  u32 request_mask)
 {
 	int error = vfs_getattr(path, stat, request_mask, flags);
-- 
2.47.2


