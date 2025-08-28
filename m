Return-Path: <linux-fsdevel+bounces-59572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAECB3AE28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B990F583EED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDF22F9992;
	Thu, 28 Aug 2025 23:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UTIcF7VY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446152D23B6
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422497; cv=none; b=g/qE8bUEBpIIhb9LqUO22ktqC/DuLrKZib/HvjD567Tx4McMyvYk5SMpE9NA+ifLn//846DJHfj1iks/OPzE2Xa6KCa8ee3Cx2oAiUwD2zgjLvIqPbb4iw5cbSqf3fa8aujb0wCy7P/Gnz/HV0I49mxPM0sYbeX/xErpUJNFKb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422497; c=relaxed/simple;
	bh=444zcNO7pT+H5++5jB3KedUL3J1WzZiaX4Gk+PisDnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFkU+Eg4hBfDIPnBnl/XcAXD1YRwtKXHM9CokZvD6gj9tNXKJ0piFo+z9yLlrjrNXcqAur4g7G9Ziv2nmZ1h4FwyN86omwJZ9sFCiylI0qlbmXbSNO4HyOjSi/xF0PcwrHCj0Z2u9EGes4fHKXdyfJuyG+rHOQIP2brwZHIXMH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UTIcF7VY; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=DSHsBsybebkm5lSE8uMOltwgyUUnaBIngLf4JtoJ8HI=; b=UTIcF7VYjtgbFtSXLfcRwvACh4
	AwNqlYOKdpy7Xsf3elUxNEj2dqJXuS7pRlHiJKY6sZcbMSwAcQcoTVTvhZ2ocDpAO3Kj4w5A0FKRs
	+/XY3XqVkR2EpEm4EzxW4q5ntFedWN/h1G0ZqH0MsPcjQwcCOnPrPuzg3d6hQm/6VQLjXrCHfP7hc
	V4xU/xu8rhJgnNIEYd6kfU4zRvGNMPVAfyA1WmauelN5RBr7yNUFKxa1apo5JhU/KMQcWinxPadzj
	djSXSIMyBh/FopOFqtaDuowiwXti5GLPk2cEBQra2HcVTpW4IdNnISQPNnV7ClsdrVOfdDHWbas8V
	N4RmNtPQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj3-0000000F28j-2duh;
	Thu, 28 Aug 2025 23:08:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 46/63] may_copy_tree(), __do_loopback(): constify struct path argument
Date: Fri, 29 Aug 2025 00:07:49 +0100
Message-ID: <20250828230806.3582485-46-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
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
index 34a71d5cdf88..b15632b70223 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2990,7 +2990,7 @@ static int do_change_type(const struct path *path, int ms_flags)
  *
  * Returns true if the mount tree can be copied, false otherwise.
  */
-static inline bool may_copy_tree(struct path *path)
+static inline bool may_copy_tree(const struct path *path)
 {
 	struct mount *mnt = real_mount(path->mnt);
 	const struct dentry_operations *d_op;
@@ -3012,7 +3012,7 @@ static inline bool may_copy_tree(struct path *path)
 }
 
 
-static struct mount *__do_loopback(struct path *old_path, int recurse)
+static struct mount *__do_loopback(const struct path *old_path, int recurse)
 {
 	struct mount *old = real_mount(old_path->mnt);
 
-- 
2.47.2


