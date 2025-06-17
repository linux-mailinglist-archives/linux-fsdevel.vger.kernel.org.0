Return-Path: <linux-fsdevel+bounces-51916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3290CADD277
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC04189B8C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 15:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447192ECD3D;
	Tue, 17 Jun 2025 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjUdPbhD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DDF2ECD2F
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174947; cv=none; b=GKE9iENF1bBjhxPN4MoUhgvsFOjlNiXUllLgzEOb7ag1ifjSj6ajeRa3J4XSrxFO19/F1FJOZuclDTu1fj0yjKBsOuaelykg9dxV2RRGzAWIZe2KL3OyrcC/+O6ZSfEH3Sw0rqOf0sLp16RD/DSTU+a6wnGDgMe9srmcHgxkz6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174947; c=relaxed/simple;
	bh=UHJw0+IWD87G0xSJs3wlAUiSuj8RNBznHlUR4CGwtZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WiUeJWP4ijlo27a3Kt1kipryUInDvd+hLGkBWtGeX54DNqqY/PoTYSC7m28nKizFtOPW5Wl+OVdXlfBGX4A3dXdqOxLAe0gRiQMkdWN35kxEUvX89b30KNAJMW1iZhWNc5MINb91TSR+TGUaOSsGeXLHNEz54wsxoiFgEDioxlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjUdPbhD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5631DC4CEE3;
	Tue, 17 Jun 2025 15:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750174947;
	bh=UHJw0+IWD87G0xSJs3wlAUiSuj8RNBznHlUR4CGwtZQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sjUdPbhDVqArW7OU6aFHPRUsQhb4RjMtFyPxfr15aex0V4CN86vMuK9Kmu0o7640T
	 0v+io3fYiCVL5ZCpYZUomKhPmHEs4w3jqD6+dXqm6IgQ/ehhxRW730DR4AUgt0/MLU
	 AX0967LJPuiQPDGTHBLPPO72cQHXg5DZue+CrgkLTe6PoXMP4tox8YOaeU23I5uPbe
	 /4fbC3o+YjPjnjl0El5XHIS8FMyEO2o80legmL3fkU0Ye19F8BKKrDdCvcXGoP7aS/
	 tp9pYj3ajDC8v8oPauE2UEBhjbfkUC5R7yAWWswCK7RuiT4FMpdUdIyhMzeZRFxxYo
	 aqBqEP6kbNrIQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 17 Jun 2025 17:42:11 +0200
Subject: [PATCH RFC 3/9] libfs: prepare to allow for non-immutable pidfd
 inodes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-work-pidfs-xattr-v1-3-2d0df10405bb@kernel.org>
References: <20250617-work-pidfs-xattr-v1-0-2d0df10405bb@kernel.org>
In-Reply-To: <20250617-work-pidfs-xattr-v1-0-2d0df10405bb@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=588; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UHJw0+IWD87G0xSJs3wlAUiSuj8RNBznHlUR4CGwtZQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQE9txwquB8pJHYO9O55tinT1wT/van7FThaVn0eqbwf
 pNSP/aQjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInUmDD8L1xye41LjBSb1/vp
 OZ3Xk9ev3pq89e3mDUcPn1fuc3JO82ZkmGRh+NnwmMv1b+WbKiunGaUFxGaeVbnCye6+tcG4wzm
 NHQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Allow for S_IMMUTABLE to be stripped so that we can support xattrs on
pidfds.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/libfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index f496373869fb..9098dc6b26f9 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -2162,7 +2162,6 @@ static struct dentry *prepare_anon_dentry(struct dentry **stashed,
 
 	/* Notice when this is changed. */
 	WARN_ON_ONCE(!S_ISREG(inode->i_mode));
-	WARN_ON_ONCE(!IS_IMMUTABLE(inode));
 
 	dentry = d_alloc_anon(sb);
 	if (!dentry) {

-- 
2.47.2


