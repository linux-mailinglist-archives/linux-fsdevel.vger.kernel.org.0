Return-Path: <linux-fsdevel+bounces-30720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FA998DEB3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 17:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2AD7B2C601
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 15:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925751D0DCE;
	Wed,  2 Oct 2024 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL3KTzbs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE69F1CEEAF;
	Wed,  2 Oct 2024 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881334; cv=none; b=hPv7QV3Dqdi432TLa+6RRkqBqqv2m77+Z5O3SXHEUPCSmG2BelG7uzM94jIc/4bBNUvIh5pLWH26MguzRL1942ZuVCxqe+Yk0AvyRFMZnihcafn+Qbpr86bKVLS9Jj4KThqfJ1InpxKKZ72U0UUKvKRkQA/CCL0E9RuwPnh00m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881334; c=relaxed/simple;
	bh=33ahCZ9A/K133WBezUAOVM2T9X8TWw5GgYn6tGWsLAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmeFkEdu0RIOMtRm99NmNMEgSB1j3ej5Y9CUCf5ptx7ahZods6ZjaU1FuqKwsIH9da2NGSRqamQEGrXM3VsPLbexcbImq7BXyfDmv57NCv0HtRox98PvxEZcjmbxgkW4o70PsGAwOB+8TjqYqaRGJkjdgt5OHjBvL4czEf6xcGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL3KTzbs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDEAC4CEC2;
	Wed,  2 Oct 2024 15:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727881333;
	bh=33ahCZ9A/K133WBezUAOVM2T9X8TWw5GgYn6tGWsLAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JL3KTzbssJsZsw6QWg9KZ6ux70TOFLrZLH5kOd+y4m106Ytk5n99OWWhQQBcEjyMT
	 nGnF635tTjj38JVNM+HjFQJxbUVssS02FOMbjvw0t+w7sDe6lhAyepCiei7YHMnbc4
	 lr4AHiB8KVZHjocFejHgue/h7O2sTO35uCmOoh5Qb2m/Tonw7+nBUtwyNUYtSPHD4u
	 R6nRqqTEptiXAkD8Q+VbZHCESadkPylo3Ad4deLOE4Nwt6bCGpveXkrSXrop3+wTD5
	 Kws+ZhFFC8CcJjRYNqK5hQqR7V8GOXbtQa0xj9h7+ALnIc2TdsLGUupc3QJrOA4IGr
	 DNGjXNyMbZ6UQ==
Date: Wed, 2 Oct 2024 08:02:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Brian Foster <bfoster@redhat.com>, sunjunchao2870@gmail.com,
	jack@suse.cz
Subject: [PATCH 2/2] iomap: constrain the file range passed to
 iomap_file_unshare
Message-ID: <20241002150213.GC21853@frogsfrogsfrogs>
References: <20241002150040.GB21853@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002150040.GB21853@frogsfrogsfrogs>

From: Darrick J. Wong <djwong@kernel.org>

File contents can only be shared (i.e. reflinked) below EOF, so it makes
no sense to try to unshare ranges beyond EOF.  Constrain the file range
parameters here so that we don't have to do that in the callers.

Fixes: 5f4e5752a8a3 ("fs: add iomap_file_dirty")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/dax.c               |    6 +++++-
 fs/iomap/buffered-io.c |    6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index becb4a6920c6a..c62acd2812f8d 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1305,11 +1305,15 @@ int dax_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 	struct iomap_iter iter = {
 		.inode		= inode,
 		.pos		= pos,
-		.len		= len,
 		.flags		= IOMAP_WRITE | IOMAP_UNSHARE | IOMAP_DAX,
 	};
+	loff_t size = i_size_read(inode);
 	int ret;
 
+	if (pos < 0 || pos >= size)
+		return 0;
+
+	iter.len = min(len, size - pos);
 	while ((ret = iomap_iter(&iter, ops)) > 0)
 		iter.processed = dax_unshare_iter(&iter);
 	return ret;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c1c559e0cc07c..78ebd265f4259 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1375,11 +1375,15 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 	struct iomap_iter iter = {
 		.inode		= inode,
 		.pos		= pos,
-		.len		= len,
 		.flags		= IOMAP_WRITE | IOMAP_UNSHARE,
 	};
+	loff_t size = i_size_read(inode);
 	int ret;
 
+	if (pos < 0 || pos >= size)
+		return 0;
+
+	iter.len = min(len, size - pos);
 	while ((ret = iomap_iter(&iter, ops)) > 0)
 		iter.processed = iomap_unshare_iter(&iter);
 	return ret;

