Return-Path: <linux-fsdevel+bounces-30071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C3B985BFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 14:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3346F1C24562
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 12:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AED1CBEA5;
	Wed, 25 Sep 2024 11:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgXw3DG4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D205B1A08AB;
	Wed, 25 Sep 2024 11:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265211; cv=none; b=kwzhLtn+XZF8ArLVU+H3xwfSy4JEuN8pqxgfQEcCfYCfK810KWu//gO0H5+/tRMQ+/IYNLoHvILqYZ0pqrW1M8NqngZY6GfwVJzLuMwtodwa7aLLT6/A3piRjBY9hnz+fvdQsKeUmgnbAARmG729vR9gF7qxLkuxZnr7W1iW884=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265211; c=relaxed/simple;
	bh=gqUbvQt8vmr6+fqLEweAASRSTZ/+RqF0wVvOsjajWyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlvCsvEmoL8cwW7Xl7ntA+2FVyK2W7/jxj99l7AxjcMutQXft4palFZucXhmXIgQMc0rFeRJwcpHiuibtmgolS2QnDBhasieNb+HxE8wIIgPzy55zAYCbZxcr3IsLFlSEVuLovqgJGOWRK+04tZV5l1rv57UQLIEuGLQaM2sx8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgXw3DG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54955C4CECD;
	Wed, 25 Sep 2024 11:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265210;
	bh=gqUbvQt8vmr6+fqLEweAASRSTZ/+RqF0wVvOsjajWyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fgXw3DG4bJQUA9pFZbN6qen1ct+WohKZI8KD+Sglymh7rZb1EE3WXGTyZ8+0janit
	 ZXCAXQdxME9Z9V5SrRSuJ5IbhSJjNoXklsq7eU5ZdxhfAE0MaHK8qB3CwJwDVzDDqM
	 kNPrThRfGWOzSb9ySbmNA2OAswc44Ql5C2B+eOZTaWfgy6hvNWhlyklsUv6VLvBsSf
	 023g9rmw5tmuKRJESEalRr0RGuUjNb+YLn1KTu4f2iiDeUuhnuQzYkrfTbkDe+iFUk
	 6DUCWEjpD6YiFeRBEUvPANU0QGNOMyhT3KLRp3HFBNhW+uC7hMu6cm8e+1H2Xv/kTn
	 j8Sr+AGY58wPg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 242/244] iomap: handle a post-direct I/O invalidate race in iomap_write_delalloc_release
Date: Wed, 25 Sep 2024 07:27:43 -0400
Message-ID: <20240925113641.1297102-242-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 7a9d43eace888a0ee6095035997bb138425844d3 ]

When direct I/O completions invalidates the page cache it holds neither the
i_rwsem nor the invalidate_lock so it can be racing with
iomap_write_delalloc_release.  If the search for the end of the region that
contains data returns the start offset we hit such a race and just need to
look for the end of the newly created hole instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20240910043949.3481298-2-hch@lst.de
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/buffered-io.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d745f718bcde8..ca928cc9be49a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1241,7 +1241,15 @@ static int iomap_write_delalloc_release(struct inode *inode,
 			error = data_end;
 			goto out_unlock;
 		}
-		WARN_ON_ONCE(data_end <= start_byte);
+
+		/*
+		 * If we race with post-direct I/O invalidation of the page cache,
+		 * there might be no data left at start_byte.
+		 */
+		if (data_end == start_byte)
+			continue;
+
+		WARN_ON_ONCE(data_end < start_byte);
 		WARN_ON_ONCE(data_end > scan_end_byte);
 
 		error = iomap_write_delalloc_scan(inode, &punch_start_byte,
-- 
2.43.0


