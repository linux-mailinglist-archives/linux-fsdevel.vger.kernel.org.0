Return-Path: <linux-fsdevel+bounces-30082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E245985FEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 16:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3451F22C2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 14:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69BA1D55BE;
	Wed, 25 Sep 2024 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBljBbCV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1290C1D55A2;
	Wed, 25 Sep 2024 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266687; cv=none; b=mWVlGgzMiuvJCbACoBFfen3fF6fMQXksQr/LrcgefrR+FhaobbVK/IXubnBIWgc8FHXjdOkdljYk9cJ3RNmYjSdTYSeTrmUohDzFvMPbCTFEQlASizq9ZUxWqc0VN1EVrcdocneFakRa4ViGPEW3oxw5SiqichyeqUSjeT0E9lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266687; c=relaxed/simple;
	bh=bBwdSrHKlREvdmD7IQIorAcY3I+8xCMaVmhxKor0NHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XezrTYMJ87nbQ1ji06224rwfb6Mjl1XA3ne/6cZ+nVH0+PMKApO1R2cqs5+gSy0vmcNYMyc/FxnsowjrkeEinZGpSpaw0wB+4Le7RjT5hHIHxEM65k79QqI/g5SgqXZIvb4sKt/+tb1vSap3WBxT1JOzEfupLZ3Imb6mgd8cSsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBljBbCV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84B3C4CEC7;
	Wed, 25 Sep 2024 12:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266686;
	bh=bBwdSrHKlREvdmD7IQIorAcY3I+8xCMaVmhxKor0NHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VBljBbCVLs/h1KcWUrfNvprzWcUkK/8iHWcQ++BwZBsa9PHoPXfUgU0Ima8KZTIBn
	 AQo1yZwEeXtewZ3vZ5JKa1iNoCN/tU3locVFB+yjj/fLiyW/5G5VWZMGuk1oPkRhuu
	 hBUHlqPt8N2aK9SVHEdm8AXKwTuI5nT3+96glyWcWhK2RjebAfhkj+t4e/pZ9ySuOA
	 KHP1QD4V7wlCj9H9+/CAr/UpLWX86NL4ja8X3rP/TR0qj2AfpCw/9MKkBqB+Rgn5Gn
	 ALo7pyj9nR/dwZIiN8AM5hUtOrhzT1kZOBdOiKjFYyMcBFuLX+xlwfL0Iq0AplBOfT
	 R7MvrVU+iT3+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 138/139] iomap: handle a post-direct I/O invalidate race in iomap_write_delalloc_release
Date: Wed, 25 Sep 2024 08:09:18 -0400
Message-ID: <20240925121137.1307574-138-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
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
index 6b89b5589ba28..9cac1ba6bb523 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1177,7 +1177,15 @@ static int iomap_write_delalloc_release(struct inode *inode,
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


