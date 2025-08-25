Return-Path: <linux-fsdevel+bounces-58941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5E2B3358A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65402167EC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EE72750F0;
	Mon, 25 Aug 2025 04:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kbIxWRPq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136B827FD75
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097045; cv=none; b=KAcYVRCncs+YNwdiWy2DS/f1K13cl7D7FUqNjJWTo9mbReahmvr8602pYumP3PeChSWNvbwEd+mdTw//7OiZ3Vxrvdf3Pv8cHbC44PV1TcOQUv56ToiuHpwUhI7TNJql3yjk+g2muED1Kla7PdrcpmYxb6Cf5ITL5vc5SAyGJMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097045; c=relaxed/simple;
	bh=zaN3ciNcUAYFk0bHjrzrqVupYd/GGHCS7Cn7YyyuNPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQE9bMI+QDBO8UrbyukTguhRTQFOWgYZ+nlimaN+dG3CPA7o+cZ2+eJohGtsO+DLySaFfEgAPfdeO9crIqlgSZDqIjdO+whCK1JPegYTuJJcx1mdzT7kBBK+NBVOlJl+VHrznD4gyiZYuari0ISPwoerLNFgibuqoBmPApp28zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kbIxWRPq; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=C5+2vjMFK+CSY9byzRvQP3jj1uqwfTr0daCrAcM3cUs=; b=kbIxWRPqfTMMSYM1Ds8Qlmh6qd
	jiS06BiBoOhwTgi2PR2fhmT0UARZFIjSHbjEn/nI1Crg/51nWYCf7Xzr0RRS96x5FfuZp6umrISJI
	77x5TAlIALMkZpqmUm1Yb5QSEWwf8YXcakvi+HzqCXH0Hodschx9ZcHpyMya/jqAxwKX7Yot2XCIp
	6ZSHk8vR3ksFOhj+uB2njgp690qXj4oFdIHvLJCpD9nCl8FFZAz44Uc+6gqUvKcrjUitCuHhTTcUs
	/S3OURkyqv8oDwiavH76IOwkepmZSx1LaOzprBJH64mwirQnll5/oVS8nsAvA6uW4ek41DZB5MBMX
	QrC15+sA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3p-00000006TEo-0tyf;
	Mon, 25 Aug 2025 04:44:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 43/52] do_{loopback,change_type,remount,reconfigure_mnt}(): constify struct path argument
Date: Mon, 25 Aug 2025 05:43:46 +0100
Message-ID: <20250825044355.1541941-43-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
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
 fs/namespace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index bf1a6efd335e..68c12866205c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2915,7 +2915,7 @@ static int flags_to_propagation_type(int ms_flags)
 /*
  * recursively change the type of the mountpoint.
  */
-static int do_change_type(struct path *path, int ms_flags)
+static int do_change_type(const struct path *path, int ms_flags)
 {
 	struct mount *m;
 	struct mount *mnt = real_mount(path->mnt);
@@ -3035,8 +3035,8 @@ static struct mount *__do_loopback(struct path *old_path, int recurse)
 /*
  * do loopback mount.
  */
-static int do_loopback(struct path *path, const char *old_name,
-				int recurse)
+static int do_loopback(const struct path *path, const char *old_name,
+		       int recurse)
 {
 	struct path old_path __free(path_put) = {};
 	struct mount *mnt = NULL;
@@ -3266,7 +3266,7 @@ static void mnt_warn_timestamp_expiry(const struct path *mountpoint,
  * superblock it refers to.  This is triggered by specifying MS_REMOUNT|MS_BIND
  * to mount(2).
  */
-static int do_reconfigure_mnt(struct path *path, unsigned int mnt_flags)
+static int do_reconfigure_mnt(const struct path *path, unsigned int mnt_flags)
 {
 	struct super_block *sb = path->mnt->mnt_sb;
 	struct mount *mnt = real_mount(path->mnt);
@@ -3303,7 +3303,7 @@ static int do_reconfigure_mnt(struct path *path, unsigned int mnt_flags)
  * If you've mounted a non-root directory somewhere and want to do remount
  * on it - tough luck.
  */
-static int do_remount(struct path *path, int ms_flags, int sb_flags,
+static int do_remount(const struct path *path, int ms_flags, int sb_flags,
 		      int mnt_flags, void *data)
 {
 	int err;
-- 
2.47.2


