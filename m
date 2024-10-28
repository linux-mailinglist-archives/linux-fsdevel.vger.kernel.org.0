Return-Path: <linux-fsdevel+bounces-33049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA3B9B2D81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 11:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C92ECB2229B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 10:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C527C1DC74A;
	Mon, 28 Oct 2024 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jc/reLvc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6231DC184;
	Mon, 28 Oct 2024 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112689; cv=none; b=SMceYlHcRPFe7BZhAu2rIvUU2bPPbCkyz5aaxwPcVMAq/1iBD268yd9MbZE2ruDu3n1bRMK5NthW7fgaiOf9SUNY8t/78XrJV55xFxjLfWeIC6gYq/1F8kel6fM32YkMaxNT8cid8xLffTZq3eUj10MdqiTjCi0ET6L7MXqXrX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112689; c=relaxed/simple;
	bh=NPmNay5PzZyZ2qWQZVeChVz7R5i+zmlu4oA2ox8u2lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQDVsmgZUsb7DtmPgp7rLcYEeoz+whHdDYBKSdqH0ToFFOgpAtsTUakPtp9YVbp/MMe1WP6l8l0lDpIKWMj4hEZZ/63EfV/kgyA9cwS0ipB1rVGkTqpeef8NSDP0y1DXLBpZTrxGgxAhqzKqUn0cWRCol60r1WqTZhoPtLr4Trk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jc/reLvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11171C4CEC3;
	Mon, 28 Oct 2024 10:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112688;
	bh=NPmNay5PzZyZ2qWQZVeChVz7R5i+zmlu4oA2ox8u2lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jc/reLvc5BSg3A3j+Rq2RnUpJutcOBVGW6l8/MfEq4Ut633ouY2YZwckFhGvvCv1L
	 w7HkF1O18Vfzvts5F1F62RjSzzGaNdlUFfdR6zjNEMPhFLCPoRRHd8hUWL5LEB9GlM
	 x9T/CaRYx+cgRt42P7rvoi17lWcePRH4bpsSfnmdYuAVwg/X8OAnWX6A78ECnTrOBt
	 of59rgE9rgguyWWhze3I9kVQsRo0oZLR0elnb8JlgBUC646ZhK05fCf7RmmLplEwM2
	 m1eSjF8Gc5SSSSsepfAWNNhDtUD3SG8IY2tULqIWrUR0nsN8FIYhzvnSb14M4bgdzW
	 bavT+vTawPbjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.11 12/32] netfs: Downgrade i_rwsem for a buffered write
Date: Mon, 28 Oct 2024 06:49:54 -0400
Message-ID: <20241028105050.3559169-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105050.3559169-1-sashal@kernel.org>
References: <20241028105050.3559169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit d6a77668a708f0b5ca6713b39c178c9d9563c35b ]

In the I/O locking code borrowed from NFS into netfslib, i_rwsem is held
locked across a buffered write - but this causes a performance regression
in cifs as it excludes buffered reads for the duration (cifs didn't use any
locking for buffered reads).

Mitigate this somewhat by downgrading the i_rwsem to a read lock across the
buffered write.  This at least allows parallel reads to occur whilst
excluding other writes, DIO, truncate and setattr.

Note that this shouldn't be a problem for a buffered write as a read
through an mmap can circumvent i_rwsem anyway.

Also note that we might want to make this change in NFS also.

Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/1317958.1729096113@warthog.procyon.org.uk
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Trond Myklebust <trondmy@kernel.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-cifs@vger.kernel.org
cc: linux-nfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/locking.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/locking.c b/fs/netfs/locking.c
index 75dc52a49b3a4..709a6aa101028 100644
--- a/fs/netfs/locking.c
+++ b/fs/netfs/locking.c
@@ -121,6 +121,7 @@ int netfs_start_io_write(struct inode *inode)
 		up_write(&inode->i_rwsem);
 		return -ERESTARTSYS;
 	}
+	downgrade_write(&inode->i_rwsem);
 	return 0;
 }
 EXPORT_SYMBOL(netfs_start_io_write);
@@ -135,7 +136,7 @@ EXPORT_SYMBOL(netfs_start_io_write);
 void netfs_end_io_write(struct inode *inode)
 	__releases(inode->i_rwsem)
 {
-	up_write(&inode->i_rwsem);
+	up_read(&inode->i_rwsem);
 }
 EXPORT_SYMBOL(netfs_end_io_write);
 
-- 
2.43.0


