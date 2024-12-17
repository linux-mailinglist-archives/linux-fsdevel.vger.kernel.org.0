Return-Path: <linux-fsdevel+bounces-37651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 740A79F5413
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 18:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB523170B2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 17:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1FD1F941E;
	Tue, 17 Dec 2024 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dguw94iC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501931F8F17;
	Tue, 17 Dec 2024 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456643; cv=none; b=cGgi0WTzSslhJPPVo7W0kJbTDxvXoBwl2FD8cbevv2DnZE+sxx27bkX4ughpQ9WjC+Ndvw7KoVuQ6wWgYpb3k1X2URJhK3/EG2DGzgDxxDwqeE5hFczONNYkDf+6lFY5h90hu+2EOnG0S3CZ1IOIivCU8SBVXxb9Fc/4hycFqK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456643; c=relaxed/simple;
	bh=tTve6jmv6a7QTCCQ45wocrrPtqChJHiXIX15NyGbte0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWcA62e+7WpI9BFkJ2QWY3CT1D+5p2nM4WNhzD3jxE37fUe7SiAQJO/yQou1opMJB8Pd89g0k37a7K+6OuPpI6v4u1R2PgCizvMJ2GJQC6Chzh+7Se4FfkAIlmCF5RISr3HW5/KOIOFVeBvk8zn27yLmmmNdlsbCP2ICTE/gpe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dguw94iC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538DDC4CEEC;
	Tue, 17 Dec 2024 17:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734456642;
	bh=tTve6jmv6a7QTCCQ45wocrrPtqChJHiXIX15NyGbte0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dguw94iCkuly+aE2ahi87SdbbWRG1Zfk49bDOSmBMIOWlGpyV8wfkRRwJwR7lo5Mn
	 03QT2h8PjU92AQ3m/tvtCcAti5YyCgQpstAIkNe6fmzbrfs1vtUfecX4AqspWndhT3
	 HzR/AWdLNxDoc+HFGiu6uTNk4KhwwCZw0rjSE4wg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 122/172] cifs: Fix rmdir failure due to ongoing I/O on deleted file
Date: Tue, 17 Dec 2024 18:07:58 +0100
Message-ID: <20241217170551.394460766@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170546.209657098@linuxfoundation.org>
References: <20241217170546.209657098@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit bb57c81e97e0082abfb0406ed6f67c615c3d206c ]

The cifs_io_request struct (a wrapper around netfs_io_request) holds open
the file on the server, even beyond the local Linux file being closed.
This can cause problems with Windows-based filesystems as the file's name
still exists after deletion until the file is closed, preventing the parent
directory from being removed and causing spurious test failures in xfstests
due to inability to remove a directory.  The symptom looks something like
this in the test output:

   rm: cannot remove '/mnt/scratch/test/p0/d3': Directory not empty
   rm: cannot remove '/mnt/scratch/test/p1/dc/dae': Directory not empty

Fix this by waiting in unlink and rename for any outstanding I/O requests
to be completed on the target file before removing that file.

Note that this doesn't prevent Linux from trying to start new requests
after deletion if it still has the file open locally - something that's
perfectly acceptable on a UNIX system.

Note also that whilst I've marked this as fixing the commit to make cifs
use netfslib, I don't know that it won't occur before that.

Fixes: 3ee1a1fc3981 ("cifs: Cut over to using netfslib")
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index b35fe1075503..fafc07e38663 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -1925,6 +1925,7 @@ int cifs_unlink(struct inode *dir, struct dentry *dentry)
 		goto unlink_out;
 	}
 
+	netfs_wait_for_outstanding_io(inode);
 	cifs_close_deferred_file_under_dentry(tcon, full_path);
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
 	if (cap_unix(tcon->ses) && (CIFS_UNIX_POSIX_PATH_OPS_CAP &
@@ -2442,8 +2443,10 @@ cifs_rename2(struct mnt_idmap *idmap, struct inode *source_dir,
 	}
 
 	cifs_close_deferred_file_under_dentry(tcon, from_name);
-	if (d_inode(target_dentry) != NULL)
+	if (d_inode(target_dentry) != NULL) {
+		netfs_wait_for_outstanding_io(d_inode(target_dentry));
 		cifs_close_deferred_file_under_dentry(tcon, to_name);
+	}
 
 	rc = cifs_do_rename(xid, source_dentry, from_name, target_dentry,
 			    to_name);
-- 
2.39.5




