Return-Path: <linux-fsdevel+bounces-15197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C585E88A2B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 14:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD492C8123
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 13:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF52152510;
	Mon, 25 Mar 2024 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skM8ZPd1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8860154C0A;
	Mon, 25 Mar 2024 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711355747; cv=none; b=clzMrc1tPknO61KTlYXcLKNdjOj7POoGJ2JIVuLDQktIUSMHr0o39qwhimEM2qdLjOE3qwDKsoA68SMf9kONI/BBYvrLzRnecaYjxH/5Z7bX/RQsuJztraswbAw6N3P6rBRNf8ZRWA7baCSuxXO9JXjauheuRYqVmyaGqoi8A84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711355747; c=relaxed/simple;
	bh=D/cqShrDInb29DCswvll5FkJaDOerwFsZiddIswk7hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MW5hzf8YpVuOtFziUADuDuAouhtk64mPb0HEArB2cYv5LJC/JHtAc1SeDmfSrNSvRR3Hl/0QkpObpV+cDVNipGKtJJRXWwO7ZpglK4g/i2cYwRZPkWpterBSdlA9qdlXUIlzHXMxZB9U8TAZxfgSF5BaZZ9mFbM5u+79+CwZFYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skM8ZPd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E063DC433F1;
	Mon, 25 Mar 2024 08:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711355747;
	bh=D/cqShrDInb29DCswvll5FkJaDOerwFsZiddIswk7hA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=skM8ZPd1xsYf1kc26gj+77gFY84PiOgZcsWUHAdT38x6TMO4cY9uMQ5TR83dtZiEu
	 XJDzWhl2vntb3ZxzrT/fl8gh0yrcg6gYuLl746cRuwtImpeI2c0HzumjeKWUx+Y2bS
	 UOvxQw8aYAZ2UT8z0jDEBk89d7WEhI5UuLWIXS9y63SjelDULhJ9aeU7+W6AS69GrB
	 1WcSbtmFJz4K/y/Vvi17ZezjSqinVh/qagpwUDZ9c8PSkt1Ps4rSYb0Tl+1aifa/So
	 I7HnDIhRvMMSMjkEx088X0nztc1RJxsJicv026uLqYcN1H9JIFcXPZiGGRdbC4tEzQ
	 +IgnBAkJaJzvg==
From: Christian Brauner <brauner@kernel.org>
To: Johan Hovold <johan@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Anton Altaparmakov <anton@tuxera.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	ntfs3@lists.linux.dev
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-ntfs-dev@lists.sourceforge.net,
	regressions@lists.linux.dev
Subject: [PATCH 2/2] ntfs3: remove warning
Date: Mon, 25 Mar 2024 09:34:38 +0100
Message-ID: <20240325-faucht-kiesel-82c6c35504b3@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <Zf2zPf5TO5oYt3I3@hovoldconsulting.com>
References: <Zf2zPf5TO5oYt3I3@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=987; i=brauner@kernel.org; h=from:subject:message-id; bh=D/cqShrDInb29DCswvll5FkJaDOerwFsZiddIswk7hA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQxmstJK0fN4gtVX16YfEHrgUTJunn3k4/8Nu1qu+3Uc +P+6RCujlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInwKzMynJrnGXTn+sXH1oF8 d/oU2U3eflZS2LclfFbQU17TQ4+/azD8j3bLPc995SOnWXCLIu+ZiZJbVTX0C7ws7szgfbjv9Po XTAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

This causes visible changes for users that rely on ntfs3 to serve as an
alternative for the legacy ntfs driver. Print statements such as this
should probably be made conditional on a debug config option or similar.

Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/Zf2zPf5TO5oYt3I3@hovoldconsulting.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ntfs3/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index eb7a8c9fba01..8cc94a6a97ed 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -424,7 +424,6 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 
 	if (names != le16_to_cpu(rec->hard_links)) {
 		/* Correct minor error on the fly. Do not mark inode as dirty. */
-		ntfs_inode_warn(inode, "Correct links count -> %u.", names);
 		rec->hard_links = cpu_to_le16(names);
 		ni->mi.dirty = true;
 	}
-- 
2.43.0


