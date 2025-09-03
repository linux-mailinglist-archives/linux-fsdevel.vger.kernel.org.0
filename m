Return-Path: <linux-fsdevel+bounces-60090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A146B413F2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB171BA12AA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E472D9EF4;
	Wed,  3 Sep 2025 04:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WsFqNBJM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460F02D594B
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875350; cv=none; b=P+NBeHdp6zNk7ljmyDP9SkfneE9i/azImhwiepqjeGju6R8DEFwEjCr3LjH19IMRG+UE2JUp1/49GAyNqm3hjql1yJJfnOxPpo/EAiztTJ1AUThu9xFn+sCUxsdUjHfKcE83M6eACVmHrJDHgFqxN5msTLH9a4KHUi7BePc12uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875350; c=relaxed/simple;
	bh=9mzFNdl+0gxPgszdt9wbSU8OO94Xm6eOL7nV792zo4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBD+of67/CRTLiWWpfA7mMTLhT2ZUzk9EifnFrCtDktZfjXoNcgcjWFmkcKhKrIyKpiNHbIdOX6Ip1w9ikAH0gSqLo2PwoVB0MvWrT3EoS88NCa2n2WECbPsSsSbUmtbZhVBaLBBLc22jg0guzjzkYceGE0lHAsz0vQ6VjVVkYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WsFqNBJM; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1MiHL+fSsU+wlV3HB7PxYhU53TCT6m6kvF51ovn99Yg=; b=WsFqNBJMJq92vkqKkTWUmXWcFH
	HdlLzFPuMTi03HtmYyfa8x9EG9o1Q8xiRofKngQZa/bckhMq/vBCUQqUZh84rqx0Xy8ZrRWEGsMGr
	++63h6QV4cTUEJv5n2L4DJST63k+za1WgbFC1TqwnVOtSlEoMiZsd4QkBCXLioWa9Cd8UE768g6/3
	ExwBFGmwvdocEg+BNw0xlwa6wIDeUsVtoFdagrC4nHasZAsOYXhUvh77UlxqO+JioyLDlr081ZC3M
	3LQYW2H0j1iSaL/jR+mnp93Pvrg7Hpv3q9V7QqWL37Ppkg3yR9FH2vSA3BUmYsBmc2Ys1c34F0F+v
	9cEGD8hw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX8-0000000ApEH-2fNK;
	Wed, 03 Sep 2025 04:55:46 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 48/65] constify can_move_mount_beneath() arguments
Date: Wed,  3 Sep 2025 05:55:10 +0100
Message-ID: <20250903045537.2579614-49-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 20c409852f6d..18229a6e045d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3472,8 +3472,8 @@ static bool mount_is_ancestor(const struct mount *p1, const struct mount *p2)
  * Context: This function expects namespace_lock() to be held.
  * Return: On success 0, and on error a negative error code is returned.
  */
-static int can_move_mount_beneath(struct mount *mnt_from,
-				  struct mount *mnt_to,
+static int can_move_mount_beneath(const struct mount *mnt_from,
+				  const struct mount *mnt_to,
 				  const struct mountpoint *mp)
 {
 	struct mount *parent_mnt_to = mnt_to->mnt_parent;
-- 
2.47.2


