Return-Path: <linux-fsdevel+bounces-21107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AE48FE9C9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 16:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A454C2863FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 14:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B8319B3F4;
	Thu,  6 Jun 2024 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sZs+KFHs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553FF19B588;
	Thu,  6 Jun 2024 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683065; cv=none; b=OQzvfDQHt+Xq63qyRNozgR2z4q10JU1G5H9/eOaxdwN++DdWyzHQL38jHfUnFaTBNiy8W8gz81Kqf3RiN0Gyv4aUtbUJT+vFqP8Z8UqEN0LUlP/5ALKDR171Nm9aKqw4RIoaxbn/3Ks9B1QNQBHNbrr0/P+orTOpq3hD7A3uTvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683065; c=relaxed/simple;
	bh=U3tvp00cBml/3/LozcTj/aStuQPzsTggVXKu4P/7SSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=on3jfwwsHlterPetPEfIwjv/tTFLkVaDOPrlFUZQ223bK1d5F2S0iXQHSRI6vFHtK0tOJPn/5zBoPC6BEX7867lMzXvw3LC6HQKh64B0nJx3QC8kLBJyVYd+uEfW9YSD74Cl+b3bQAa3U4Q7BW0V0kxbNy61GvkFgEYh03jP7q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sZs+KFHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3273CC4AF08;
	Thu,  6 Jun 2024 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683065;
	bh=U3tvp00cBml/3/LozcTj/aStuQPzsTggVXKu4P/7SSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sZs+KFHsdkWIs7kmCbAYPgru3XNGPrKkim6FCG3qMCFn9P05DuhPl9Wt/els4jQwk
	 6OKalOMHL05nV+Hnb0Bb7Qv1Q6kwltB5OPrJy4c+BbowjgO3Otkn0gskQSm/PLfpWx
	 VKbxEPWnTiodV3roZxx/z1/3fiRgJWs/ChiPq8NU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Steve French <sfrench@samba.org>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 278/374] cifs: Set zero_point in the copy_file_range() and remap_file_range()
Date: Thu,  6 Jun 2024 16:04:17 +0200
Message-ID: <20240606131701.206658882@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 3758c485f6c9124d8ad76b88382004cbc28a0892 ]

Set zero_point in the copy_file_range() and remap_file_range()
implementations so that we don't skip reading data modified on a
server-side copy.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
Stable-dep-of: 93a43155127f ("cifs: Fix missing set of remote_i_size")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 39277c37185ca..c8449f43856c5 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1342,6 +1342,8 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 	rc = cifs_flush_folio(target_inode, destend, &fstart, &fend, false);
 	if (rc)
 		goto unlock;
+	if (fend > target_cifsi->netfs.zero_point)
+		target_cifsi->netfs.zero_point = fend + 1;
 
 	/* Discard all the folios that overlap the destination region. */
 	cifs_dbg(FYI, "about to discard pages %llx-%llx\n", fstart, fend);
@@ -1360,6 +1362,8 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 			fscache_resize_cookie(cifs_inode_cookie(target_inode),
 					      new_size);
 		}
+		if (rc == 0 && new_size > target_cifsi->netfs.zero_point)
+			target_cifsi->netfs.zero_point = new_size;
 	}
 
 	/* force revalidate of size and timestamps of target file now
@@ -1451,6 +1455,8 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 	rc = cifs_flush_folio(target_inode, destend, &fstart, &fend, false);
 	if (rc)
 		goto unlock;
+	if (fend > target_cifsi->netfs.zero_point)
+		target_cifsi->netfs.zero_point = fend + 1;
 
 	/* Discard all the folios that overlap the destination region. */
 	truncate_inode_pages_range(&target_inode->i_data, fstart, fend);
-- 
2.43.0




