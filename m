Return-Path: <linux-fsdevel+bounces-72623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E709CFE733
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 16:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D73F530704F6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 15:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4849336EF7;
	Wed,  7 Jan 2026 14:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cA+jkYKy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122F431B81C;
	Wed,  7 Jan 2026 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795638; cv=none; b=FSL3RwrFtnC2SFHGc52Y4DrWvmYPXXaBpC8IuN2jskFSlMPnnYeL8OiL/seuuhRt2x7eQ6LVhPOkGu7bioR4JjiUmKEZsZyd2nMAg/WdjpXYehip5XKCWiNculmpvolBsy2+36jU1n7HZyqoflxespLQIZhsWm25a7h/c0Kb8k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795638; c=relaxed/simple;
	bh=pS9yyXCuYMf7+KI6SO4u/vUJdTQQPT4ls4okttVSWaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QaFu1UG/J9tFNiVNDcTd1plssb0b21I/2M3erSMHGWXviFjzEUTpisP5StuvAqcahhrLBnmlIvvcECchdG2PqwoGNO1WdjhdF2nPA1rReD5sUYZnxVmTNHmdm+0XkfcD6PUgxNzMjGa767edwdXwXj7odCV+fHtlpruqX2C36jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cA+jkYKy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E71C4CEF1;
	Wed,  7 Jan 2026 14:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767795637;
	bh=pS9yyXCuYMf7+KI6SO4u/vUJdTQQPT4ls4okttVSWaE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cA+jkYKyIk9GTNT/RIbyJ9+oKweiiJOPVQCV7mks0aWjroSOLgyr8NLfelO+dq/eT
	 tGcBFxnITdlA3YUwDbY02hxwKrWVId2eHezILAMkPjIrQ7TQDYEyhGgR3LYdRG7KBj
	 my+DRpKBaHOOqBrZSB9du2hQPSCpR3iuL+pnPeS5KmJFKSAFfnMvlstBnNCyr0/uol
	 RaLURmzRTHfr/7jKY0wRcFvR6Zlw0/AQV+IfhkzSJph2a6+2424ezAWL+djjqJRu0V
	 Nkc/d4zOjIgbTfqQtGXE7hAEctSbGVMbuu5+P1ZG7HPzP6zqMoyZDLUT8OEDZ4lfZt
	 3zCQr7PD6PLww==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 07 Jan 2026 09:20:10 -0500
Subject: [PATCH 2/6] smb/client: properly disallow delegations on
 directories
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-setlease-6-19-v1-2-85f034abcc57@kernel.org>
References: <20260107-setlease-6-19-v1-0-85f034abcc57@kernel.org>
In-Reply-To: <20260107-setlease-6-19-v1-0-85f034abcc57@kernel.org>
To: Christian Brauner <brauner@kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Andreas Gruenbacher <agruenba@redhat.com>, Xiubo Li <xiubli@redhat.com>, 
 Ilya Dryomov <idryomov@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 NeilBrown <neil@brown.name>
Cc: Christoph Hellwig <hch@infradead.org>, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, gfs2@lists.linux.dev, 
 ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1365; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=pS9yyXCuYMf7+KI6SO4u/vUJdTQQPT4ls4okttVSWaE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpXmusiT+Zo4rGBFj36gZGzZezqsdQ5jMDN7570
 +X3LnovMQ6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV5rrAAKCRAADmhBGVaC
 FQyMD/9Yn2ldQZofv33ljyPfw1HKZHxfV9g/4IXvDS0coXZV6btn300rZiiHijlDiQL22qszkfB
 /O5PtQ1peH2IuYCsNFIVCGWPjk6v1RJQ5Laeekscv207sRvr5nppbivyGjDLQ26gBSxZ08hmyMR
 Nl6WavAO7n/mTPxDgtfZNRjQur9yv2xVTZsN/nnO3ZCH7hL9kakZEpaXpgXLr7y00ToeMt6EU9l
 Sdo2kgGbG/83S7eNy8Lr+F8aYFgbPE72ftaxhTcOMfWt9tGgtefRlXQORqlppSRKBKb1T0l8wmJ
 0dWUV6cweW4Cg1/ITOkHrp79vgFzL1km9I1yH092pUxCz5gzTkpy4Zl3rkzUnlLziVOfXrpuqrd
 w/OPxT8+Dw+ALUDRs7NvJdESsYzb6njiUWrO93vRdPNf9FNXxThSdRQFbqCidSfhKUyvStDYFQi
 lcgBKOXwxRmHVzOBjQ/axpCrQy5KVBprSIuXFBzXqkIzd5siyyiJT+0wQwfSACU537xUx43faEK
 lDnmDlcpCWS8WgyESuaIKTIOd2Y7oZc7qT2kSV/NtUb5f2Tuc2DzqggxrSdFWsd97LL4Aus78WE
 bIyQGskKVTfRSBzNzO1nbaXG6wVlTBLAa3WUVnRuaK2XtH3poGnHCEf33B9r8ujY2TOo0asLeub
 OnlAv+OtROjS4Nw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The check for S_ISREG() in cifs_setlease() is incorrect since that
operation doesn't get called for directories. The correct way to prevent
delegations on directories is to set the ->setlease() method in directory
file_operations to simple_nosetlease().

Fixes: e6d28ebc17eb ("filelock: push the S_ISREG check down to ->setlease handlers")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/smb/client/cifsfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index d9664634144d3ebba5cdd659f651d6e6e8f975fa..a3dc7cb1ab541d35c2e43eefb7a2d2d23ad88bb3 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1149,9 +1149,6 @@ cifs_setlease(struct file *file, int arg, struct file_lease **lease, void **priv
 	struct inode *inode = file_inode(file);
 	struct cifsFileInfo *cfile = file->private_data;
 
-	if (!S_ISREG(inode->i_mode))
-		return -EINVAL;
-
 	/* Check if file is oplocked if this is request for new lease */
 	if (arg == F_UNLCK ||
 	    ((arg == F_RDLCK) && CIFS_CACHE_READ(CIFS_I(inode))) ||
@@ -1712,6 +1709,7 @@ const struct file_operations cifs_dir_ops = {
 	.remap_file_range = cifs_remap_file_range,
 	.llseek = generic_file_llseek,
 	.fsync = cifs_dir_fsync,
+	.setlease = simple_nosetlease,
 };
 
 static void

-- 
2.52.0


