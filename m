Return-Path: <linux-fsdevel+bounces-21106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8B08FE9C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 16:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061CC1C24F8F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 14:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45AE19B3FF;
	Thu,  6 Jun 2024 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GvNklwV1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EC4196DB7;
	Thu,  6 Jun 2024 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683064; cv=none; b=G8aPXnUdT30gengDI4kq0ifuhfCn1oyKAgKKTspZw5zrj3MvgcWGAuB9Xc/+sAKKZNllr/A5XG95AdEyRE3ItynNUf/awUUOimqalGCB76stLWbRRj8OzkFiQ/IfIKM3sNnVdUpqpoK1YLgOEUZiwmBjdLPGPGoysKH7lrxFG8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683064; c=relaxed/simple;
	bh=UilmObbR7r5nLNHpqautuz291uaNurHl2F3cXtiZjOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wv7nv/+GBkwnk6wEL3neYeXoOjUF0hk9tXtTxZ6dX6Ed9ea5C7bsIU3hLZ7FCK3EZPzFyjYo5v0I6S4XKnj35sD6f8/PCKKsy5oA8qhX6Zbakqo39dwH3tMWMbGHzFB3+u2k/w6OyZldjFjX6KSowygjyPlrj9Sw0dk0MsKrOto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GvNklwV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7F4C4AF0C;
	Thu,  6 Jun 2024 14:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683064;
	bh=UilmObbR7r5nLNHpqautuz291uaNurHl2F3cXtiZjOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GvNklwV1X9RpYp1AHPM6N2MyMxM9wIDb3hnN4gpLUpnuTVL7Iz3XhIBGD3RoTr1mc
	 xPV8qWeWflM1yR1enSa1aHm00a0r83WNc4O6bVubjb/g0ahFxSzIdctOJjdL2pWSU5
	 Cl2BGya7epwYpIL4jHtZRq/2lqwbEzTOVVeEEVno=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jeff Layton <jlayton@kernel.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	v9fs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 276/374] netfs: Fix setting of BDP_ASYNC from iocb flags
Date: Thu,  6 Jun 2024 16:04:15 +0200
Message-ID: <20240606131701.151618725@linuxfoundation.org>
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

[ Upstream commit c596bea1452ddf172ec9b588e4597228e9a1f4d5 ]

Fix netfs_perform_write() to set BDP_ASYNC if IOCB_NOWAIT is set rather
than if IOCB_SYNC is not set.  It reflects asynchronicity in the sense of
not waiting rather than synchronicity in the sense of not returning until
the op is complete.

Without this, generic/590 fails on cifs in strict caching mode with a
complaint that one of the writes fails with EAGAIN.  The test can be
distilled down to:

        mount -t cifs /my/share /mnt -ostuff
        xfs_io -i -c 'falloc 0 8191M -c fsync -f /mnt/file
        xfs_io -i -c 'pwrite -b 1M -W 0 8191M' /mnt/file

Fixes: c38f4e96e605 ("netfs: Provide func to copy data to pagecache for buffered write")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/316306.1716306586@warthog.procyon.org.uk
Reviewed-by: Jens Axboe <axboe@kernel.dk>
cc: Jeff Layton <jlayton@kernel.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/buffered_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 267b622d923b1..912ad0a1df021 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -163,7 +163,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 	struct folio *folio;
 	enum netfs_how_to_modify howto;
 	enum netfs_folio_trace trace;
-	unsigned int bdp_flags = (iocb->ki_flags & IOCB_SYNC) ? 0: BDP_ASYNC;
+	unsigned int bdp_flags = (iocb->ki_flags & IOCB_NOWAIT) ? BDP_ASYNC : 0;
 	ssize_t written = 0, ret, ret2;
 	loff_t i_size, pos = iocb->ki_pos, from, to;
 	size_t max_chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
-- 
2.43.0




