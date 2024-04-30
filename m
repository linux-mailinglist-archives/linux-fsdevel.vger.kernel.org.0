Return-Path: <linux-fsdevel+bounces-18311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FA08B70E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 12:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80BEB1C20C86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 10:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D03512CD90;
	Tue, 30 Apr 2024 10:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="189nOsfc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9282412CD89;
	Tue, 30 Apr 2024 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474251; cv=none; b=Y14KL2qfQ/Z6zWaIXBpRoJt6UvjWc59sztvZI84yYXx0jILPB16hS8DqoHa5ytvy27+OSs9WgzdPnLUpnW/hZXz1suvqvfFJR0CaDXymbgt3RCFTNlbgUtDOm0VRmuSvl0sJ+jDdd8sk80iSdS1oFa6owFOwQEs8A+wq93By/50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474251; c=relaxed/simple;
	bh=hmROxyLa2tYHwMBOXZi/n3ILfpyfwNKnkAkGh30GTa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+nuWuCXUoTbZ0oedA29m16ZOA28Erq9iIZZ1i8aFQd3MtlTjtqr4ZRNa2uJQHVaKIgJwR4KM2/B6wYU2ZlnL1zfKZ5YXQhch5CcmnvJN8TMfZjrhkV0RHIttNHVWOAI3yRbNIbq3Hyz4JVHXU3idbijOqly695VtBhrq/isLnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=189nOsfc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A2DC2BBFC;
	Tue, 30 Apr 2024 10:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714474251;
	bh=hmROxyLa2tYHwMBOXZi/n3ILfpyfwNKnkAkGh30GTa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=189nOsfcbJ8IhSfLgcxMdlmnaNrS/buXfuz4CyqP8jq5MXo0g1WgL/7Unl4OU7b4S
	 C24H5RNJ2Lk/GF4MwgJtmzO5NiA4Q0zsQqrTcV4pX4RHKy0GfDFlxGnsucaR3K3yNt
	 eM6B9NKwUfvyJH9Rdxkl68NjDs1qXxZd58X0hT2I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 063/228] netfs: Fix writethrough-mode error handling
Date: Tue, 30 Apr 2024 12:37:21 +0200
Message-ID: <20240430103105.626727791@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>
References: <20240430103103.806426847@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 619606a7b8d5e54b71578ecc988d3f8e1896bbc6 ]

Fix the error return in netfs_perform_write() acting in writethrough-mode
to return any cached error in the case that netfs_end_writethrough()
returns 0.

This can affect the use of O_SYNC/O_DSYNC/RWF_SYNC/RWF_DSYNC in 9p and afs.

Fixes: 41d8e7673a77 ("netfs: Implement a write-through caching option")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/6736.1713343639@warthog.procyon.org.uk
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/buffered_write.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 9a0d32e4b422a..8f13ca8fbc74d 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -164,7 +164,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 	enum netfs_how_to_modify howto;
 	enum netfs_folio_trace trace;
 	unsigned int bdp_flags = (iocb->ki_flags & IOCB_SYNC) ? 0: BDP_ASYNC;
-	ssize_t written = 0, ret;
+	ssize_t written = 0, ret, ret2;
 	loff_t i_size, pos = iocb->ki_pos, from, to;
 	size_t max_chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
 	bool maybe_trouble = false;
@@ -395,10 +395,12 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 
 out:
 	if (unlikely(wreq)) {
-		ret = netfs_end_writethrough(wreq, iocb);
+		ret2 = netfs_end_writethrough(wreq, iocb);
 		wbc_detach_inode(&wbc);
-		if (ret == -EIOCBQUEUED)
-			return ret;
+		if (ret2 == -EIOCBQUEUED)
+			return ret2;
+		if (ret == 0)
+			ret = ret2;
 	}
 
 	iocb->ki_pos += written;
-- 
2.43.0




