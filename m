Return-Path: <linux-fsdevel+bounces-29364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FCC97894D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 22:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AD3D2834A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 20:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991921487C1;
	Fri, 13 Sep 2024 20:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvQPPSDV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ED3BA2E;
	Fri, 13 Sep 2024 20:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726257990; cv=none; b=Ur1ncusQ6W6dqUgVoitgD2xCitDFLJOcvlqdOhacFKYnMwDSWxHt7bfvqdSUmHOrDBA2HBF0MidO6stbU3ETyv6lOdZUKCe9u7CflDX9EZwwP0WJHfp4WJEouhnTA4yDRfM6YvusyOiK/nt48VwWCw/phn4bhVvITmD01B3l+Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726257990; c=relaxed/simple;
	bh=9WkUEfh4AEhyzC3ZpjhHXvMPaqjKmVWY03ZNl/O+GoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=llSKQwCWzSWSv2Z2UUez+Qsqkpo/fkySqYXtleur5GfQGtMpThu9tvlregcJuGbVN3s/x0EsrSVqPmQ8f18glDx++tf1EB3+dxMGHdZ9vLGaq+rCFRuX5h9PQFUDc32Q/m3ElyUXzpOntO8iAyOa8AI0egKOgv8XcXm1kWOEfm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvQPPSDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F889C4CEC0;
	Fri, 13 Sep 2024 20:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726257989;
	bh=9WkUEfh4AEhyzC3ZpjhHXvMPaqjKmVWY03ZNl/O+GoQ=;
	h=From:To:Cc:Subject:Date:From;
	b=qvQPPSDV/TThvI/waD9JNlIp6BYYTUcGZjGN3dMTLaHtELsWbVr3qnFsh0cUww1Oz
	 H/mDbuKG8+eDDuYPGgY6kU//rWHdqtoGyVOpCjFgX4/l/Ri7OXUF7XBO5p750o6C8r
	 chUAialy8uHw7WZ/ciyuAsDAUg00uS69dlYSqS18dpvXpTN8jlbbEFU9bk16zZZakH
	 fXAh1Fit/JD7CrLrsLDc2/ykYt1R79wonEoCULXo7ztsT25oEs1V5q+CpxYzTunmWr
	 w9/TMWvwmIlmf2cWegwiHSAfcAmO34oLC3ovfxqCoU8DVtEJ7RKDG5AyYqYqd534s/
	 oGH82PFg4vzmg==
From: trondmy@kernel.org
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH] filemap: filemap_read() should check that the offset is positive or zero
Date: Fri, 13 Sep 2024 16:04:18 -0400
Message-ID: <482ee0b8a30b62324adb9f7c551a99926f037393.1726257832.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We do check that the read offset is less than the filesystem limit,
however for good measure we should also check that it is positive or
zero, and return EINVAL if that is not the case.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 mm/filemap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index c69227ccdabb..99ed5d291a6a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2600,6 +2600,8 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 	loff_t isize, end_offset;
 	loff_t last_pos = ra->prev_pos;
 
+	if (unlikely(iocb->ki_pos < 0))
+		return -EINVAL;
 	if (unlikely(iocb->ki_pos >= inode->i_sb->s_maxbytes))
 		return 0;
 	if (unlikely(!iov_iter_count(iter)))
-- 
2.46.0


