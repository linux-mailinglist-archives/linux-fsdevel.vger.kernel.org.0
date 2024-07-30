Return-Path: <linux-fsdevel+bounces-24553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0F5940730
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A46FFB209A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A701957F9;
	Tue, 30 Jul 2024 05:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhEioAxF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDE3166312;
	Tue, 30 Jul 2024 05:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316507; cv=none; b=tIsADToLHRM1q9x2lekR21qDGj3ECXtaNGwD92Ff6PJrG1u579MH5hohbNgwMMZlaQ1qbIkg4yFb1OYewAGHiVjw8XFtP+reLkLqvfDhKa2sCErUwMvGEfayTkArkQzGPRKEWYAvcbLLNkbsbuzaH81L0Mxq6QBlwZSx4rY9k+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316507; c=relaxed/simple;
	bh=w8MAF0Vhk3EPa5RCckJuviDewK5tS4eN6bhhBrX0HY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F1mwJ5cSjtUIwZEz5oBFlBWUR79cTCEiLAVnoWFPdp06X1mNM9qLj/RCXAbBJSz1Debgm+bFsui4nAU7vXGSQWtIp/N4KTGB9f60qMfD6ATPBqSO2V6CDgvZtRwJsT3TQBMW4g59xYZm+aleAl1yoytu48dZknfvzCDCrjCbTQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhEioAxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9391C4AF0F;
	Tue, 30 Jul 2024 05:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316506;
	bh=w8MAF0Vhk3EPa5RCckJuviDewK5tS4eN6bhhBrX0HY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GhEioAxF1Ljf3uvVTvJs5C7jq1QVYlH6TBKLe1QpFLMiq0tVKbOCng7bJ1KdxfXQg
	 4RwfLjvLZqmI8XksJ8bsXl+XP4rB2V/g2VFuFbV4ia72AAvI/T87soFoDKjqWEJlHv
	 j/rBZ/TyqrIXxNT/ogNTpjQpu5MujHkb6/5MRRDClty8jUgqMObuPxIG2z20wtsG8e
	 0MEo1cOutv+5R3/fscrWpAapMYZ0M1FWsVC4dAHM3nrKCVbdEayAkr7QXjv8avp8PO
	 7tXLC+55/J10F62rmUppwat1P4rbVy2P4KHLDtXuRRxPvXYc5JrRrFc5B6V2+fZMSf
	 o4LfEgrZI3A4w==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 21/39] o2hb_region_dev_store(): avoid goto around fdget()/fdput()
Date: Tue, 30 Jul 2024 01:16:07 -0400
Message-Id: <20240730051625.14349-21-viro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730051625.14349-1-viro@kernel.org>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

Preparation for CLASS(fd) conversion.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ocfs2/cluster/heartbeat.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 4b9f45d7049e..bc55340a60c3 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -1770,23 +1770,23 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 	int live_threshold;
 
 	if (reg->hr_bdev_file)
-		goto out;
+		return -EINVAL;
 
 	/* We can't heartbeat without having had our node number
 	 * configured yet. */
 	if (o2nm_this_node() == O2NM_MAX_NODES)
-		goto out;
+		return -EINVAL;
 
 	fd = simple_strtol(p, &p, 0);
 	if (!p || (*p && (*p != '\n')))
-		goto out;
+		return -EINVAL;
 
 	if (fd < 0 || fd >= INT_MAX)
-		goto out;
+		return -EINVAL;
 
 	f = fdget(fd);
 	if (fd_file(f) == NULL)
-		goto out;
+		return -EINVAL;
 
 	if (reg->hr_blocks == 0 || reg->hr_start_block == 0 ||
 	    reg->hr_block_bytes == 0)
@@ -1908,7 +1908,6 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 	}
 out2:
 	fdput(f);
-out:
 	return ret;
 }
 
-- 
2.39.2


