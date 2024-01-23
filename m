Return-Path: <linux-fsdevel+bounces-8519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E06838A73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 10:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58AC6B241E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 09:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B5E59B69;
	Tue, 23 Jan 2024 09:37:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671A956478;
	Tue, 23 Jan 2024 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706002634; cv=none; b=nUA6aym/nynI3DBN0VLgtuuSqc0pFo7NnpITYUPBM57hTs3nsk8Z8IC6fSVzIK5rKt0DBGBk876zEjKX9S7p9u4qf+RT8JJ6+iU//f64zZRPQCKauLvahHiVSe8o/2co3OvoeN82d3NcFNORbAc97odYa29B40Ogh6c7NIJfPNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706002634; c=relaxed/simple;
	bh=9L2HdofWJcLlzgURvijzTLaL93o4p+E1h/gJ1Az/+I8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UKvNi9dJRw8kuf72aujyN9PRAfgpjXvJd9cAlss9vwTmEfTsqtlc9CPq+q/sZ1X7MQBhAmQKBQzfJJZ4ocF2ovQiXGnjZWqjrGR7ZORagxcu8nXBDC8ApVlP4pgxNGxegTNE7RcAAVVQhtZWfAsJK8LhKHJuUxZicbwtseZPXVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W.CRkwM_1706002621;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W.CRkwM_1706002621)
          by smtp.aliyun-inc.com;
          Tue, 23 Jan 2024 17:37:02 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] fuse: disable support for file handle when FUSE_EXPORT_SUPPORT not configured
Date: Tue, 23 Jan 2024 17:37:01 +0800
Message-Id: <20240123093701.94166-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I think this is more of an issue reporter.

I'm not sure if it's a known issue, but we found that following a
successful name_to_handle_at(2), open_by_handle_at(2) fails (-ESTALE,
Stale file handle) with the given file handle when the fuse daemon is in
"cache= none" mode.

It can be reproduced by the examples from the man page of
name_to_handle_at(2) and open_by_handle_at(2) [1], along with the
virtiofsd daemon (C implementation) in "cache= none" mode.

```
./t_name_to_handle_at t_open_by_handle_at.c > /tmp/fh
./t_open_by_handle_at < /tmp/fh
t_open_by_handle_at: open_by_handle_at: Stale file handle
```

After investigation into this issue, I found the root cause is that,
when virtiofsd is in "cache= none" mode, the entry_valid_timeout is
configured as 0.  Thus the dput() called when name_to_handle_at(2)
finishes will trigger iput -> evict(), in which FUSE_FORGET will be sent
to the daemon.  The following open_by_handle_at(2) will trigger a new
FUSE_LOOKUP request when no cached inode is found with the given file
handle.  And then the fuse daemon fails the FUSE_LOOKUP request with
-ENOENT as the cached metadata of the requested inode has already been
cleaned up among the previous FUSE_FORGET.

This indeed confuses the application, as open_by_handle_at(2) fails in
the condition of the previous name_to_handle_at(2) succeeds, given the
requested file is not deleted and ready there.  It is acceptable for the
application folks to fail name_to_handle_at(2) early in this case, in
which they will fallback to open(2) to access files.


As for this RFC patch, the idea is that if the fuse daemon is configured
with "cache=none" mode, FUSE_EXPORT_SUPPORT should also be explicitly
disabled and the following name_to_handle_at(2) will all fail as a
workaround of this issue.

[1] https://man7.org/linux/man-pages/man2/open_by_handle_at.2.html

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 2a6d44f91729..9fed63be60fe 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1025,6 +1025,7 @@ static struct dentry *fuse_get_dentry(struct super_block *sb,
 static int fuse_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 			   struct inode *parent)
 {
+	struct fuse_conn *fc = get_fuse_conn(inode);
 	int len = parent ? 6 : 3;
 	u64 nodeid;
 	u32 generation;
@@ -1034,6 +1035,9 @@ static int fuse_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 		return  FILEID_INVALID;
 	}
 
+	if (!fc->export_support)
+		return -EOPNOTSUPP;
+
 	nodeid = get_fuse_inode(inode)->nodeid;
 	generation = inode->i_generation;
 
-- 
2.19.1.6.gb485710b


