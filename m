Return-Path: <linux-fsdevel+bounces-34868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE899CD82D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 07:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82EF28374E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 06:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7525C18873E;
	Fri, 15 Nov 2024 06:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KakwhxgE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B20185924;
	Fri, 15 Nov 2024 06:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653289; cv=none; b=tLbMG9DFd9ITTVANdEGLaAnUJEbCSQKCPwLZCJV1465W+/V8C0c+qqJ8S6nn3K4uUOfu6cwn3ykECrPIa5Y3fWx3QGFhSZ6bbLzdOzzAbWj4Bjik2xy6pjh59wOLOd60bUcKkiWIklDM60RER0Pmcg20PT9op/voUa2RlJrPClw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653289; c=relaxed/simple;
	bh=zakHiXayz7SY1jBhcUhQzU+JONzAKDRAo+HlUYF2IG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWpRt1p19H2ZBgpCW/AgsSQ63dM+hMT0dYOO7aoctqFSEvNrPR1fvaodXkMuiA5PJ7hu4M4ON8bSET5AVFkVcqpkd0l4Ay+sIu+HZEt6CELZwnOl+87eZmcLfDun6X3QvnCLc8xh0Vgx9ld9LA6H/hzkThp1Px7eVHBnfkD0jdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KakwhxgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2930C4CECF;
	Fri, 15 Nov 2024 06:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731653289;
	bh=zakHiXayz7SY1jBhcUhQzU+JONzAKDRAo+HlUYF2IG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KakwhxgEMiiEj8EoCeF2MovKQ2iMqLxkH7LfuwYoHDFWFGkYU8BSmQhq8gFwVs+tQ
	 stcsqn/E3dHjgKMjhRvmvSbk7u44zDuJsxyBhMYRdExaylL8ahs0qJl6ilZnWTTFeE
	 4df1ZD6KSPqvkkGZzekrLZcjYJedkyrlNTVm5+FM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
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
Subject: [PATCH 6.11 43/63] netfs: Downgrade i_rwsem for a buffered write
Date: Fri, 15 Nov 2024 07:38:06 +0100
Message-ID: <20241115063727.469260672@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063725.892410236@linuxfoundation.org>
References: <20241115063725.892410236@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

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




