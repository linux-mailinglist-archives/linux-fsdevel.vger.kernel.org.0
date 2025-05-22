Return-Path: <linux-fsdevel+bounces-49641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 942ECAC012A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE1E1BC44BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638CA1FC3;
	Thu, 22 May 2025 00:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oS9I9JJF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC6928F1;
	Thu, 22 May 2025 00:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872745; cv=none; b=edAXN4i1Pk5p6XAuk6DkQeY1OofmWkjcSWKw3YCjUgdWK6XauZyNw05a+jrqRrsVsE0jysMsfU9AlWlocBQd7/VrGZkDj3iTqWso8mZVo+BxnjZJud3QR+u4B5VH0uy1idcqyENoHbl5wa0HYXAeGU9K5FLt61EmGBEdDVOJdgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872745; c=relaxed/simple;
	bh=YHDhhXa9tv32bSRd6tA/amPInhg3VJlTk+d2jUjqkoY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oEz3xkUGS+mN22V6yiJvnIICvaXGoJxSzp5xwPl3eBBsrd28hMttHloEVxCw8k0Z8li0EQEHAuJHyDaU1trSPGMUuee0hoWa2D+83MFUffxDtshO92yayFD7PSosXu3DGpIgWVLXgDi5FJQgf4ISTeFnvIl2wYrbRR99m1xLBzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oS9I9JJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D92CC4CEE4;
	Thu, 22 May 2025 00:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872745;
	bh=YHDhhXa9tv32bSRd6tA/amPInhg3VJlTk+d2jUjqkoY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=oS9I9JJFR6VSkLKY3ibCEis37/w5y2xccReqOv3/caotLIpQtyNjPeNC9JRiEx3aC
	 j0/n9WhnhZSpY2klWNlTKn1+eBLLSnOnb5bqcUJ/ES3vCsvyqxJ7hVqCTsOUoaaLSS
	 1odgD+NvTX3OMwaCh2q5PMoADgFLhq6zf4B5s6Vbm/fQB69V11NX8ab5qLsIdLJ9QG
	 xGVFelvyPG9fXFlgFumkykAb98g5pRFGZVLRnvYtlrQl7FY27ipAJ/xKHAo2z+sM6x
	 8Swkm5FiQMdPwaK7OBBhPjWhNXH/Fb+rNK3WGbBjK5MzcJXckbYFklhdIlUwed60zC
	 NkoHGBTG1S8lg==
Date: Wed, 21 May 2025 17:12:24 -0700
Subject: [PATCH 06/16] fuse2fs: only flush the cache for the file under
 directio read
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 joannelkoong@gmail.com, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Message-ID: <174787198541.1484996.8140909890324412388.stgit@frogsfrogsfrogs>
In-Reply-To: <174787198370.1484996.3340565971108603226.stgit@frogsfrogsfrogs>
References: <174787198370.1484996.3340565971108603226.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

We only need to flush the io_channel's cache for the file that's being
read directly, not everything else.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index c0f868e8f01ed4..3ec99310b0f112 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4957,7 +4957,7 @@ static int fuse_iomap_begin_read(struct fuse2fs *ff, ext2_ino_t ino,
 		return -ENOSYS;
 
 	/* flush dirty io_channel buffers to disk before iomap reads them */
-	err = io_channel_flush(ff->fs->io);
+	err = io_channel_flush_tag(ff->fs->io, ino);
 	if (err)
 		return translate_error(ff->fs, ino, err);
 


