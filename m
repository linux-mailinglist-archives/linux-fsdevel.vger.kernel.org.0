Return-Path: <linux-fsdevel+bounces-55317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FCFB097D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E1E17E1BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2101325BEF3;
	Thu, 17 Jul 2025 23:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSkiMCWj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8402F2417C2
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794843; cv=none; b=sP9IDMMKlOpH2Inog86JNtBWEbjkIRovq+F5baQv0VVXXKOh3M+WxZESdJ1n0ydVHLoy5mGM8nTXba9uG1Rex4CVgbSg098/pEmmQsgXX7kKwcxCI2xWlyjfU9trf6rcjDtPbPuXa7BK+fAUOxoANtZfN83JgsJDyqNXNSxoDdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794843; c=relaxed/simple;
	bh=rpsBIfVG1qNARuNdGh5Oea8IF5RCzWGtUqL6UoddRX4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EY6KnOsOMco1K4QmBpqG504sfmQf4O4ugRAys2Dwr3nnHYpxNzcIiOagzuiDfgDlJYvMZiS7dQNbVbclJ+GXvG/w73KvrCcSXGpslVSwoC9k22V4aJv8zLsaPP4013xXgyr4s9nZjcktqU5DNRQVvwgW6FbUyjZ5I9mQvupN2c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSkiMCWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C14C4CEE3;
	Thu, 17 Jul 2025 23:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794843;
	bh=rpsBIfVG1qNARuNdGh5Oea8IF5RCzWGtUqL6UoddRX4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=KSkiMCWj9h8xsR/EsVq1aW6Kz6Q0ynyhDCaDnLqb/oh+Ad6TCXeoDeHbC3VF54awn
	 afsGp9dD6jVKaeUEDI8aD8NZ9DMVnm1xLnh2EjLaPGVsM1PnXbMhtc+9zJj9uAHWLE
	 Z//XPGiyOMwkvMCumJUK8mETj70EleU9H+kw7zBDnnO96X6AeH9YwTFkj7YgzCklb3
	 9mhDohEJfKyHgMdzmq7lDPVO85x5nxN4YlWDMjZlkW3OwM0cMKDN1QgCpT3qztxfr3
	 zLVa75ENTI7vk78CrFdouzIt5i/lU/5aIm2uyt3Vt8Lo8iOOOApacVIg715YRIZRp2
	 zGdqX6zERlARg==
Date: Thu, 17 Jul 2025 16:27:22 -0700
Subject: [PATCH 4/7] fuse: implement file attributes mask for statx
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279449542.710975.4026114067817403606.stgit@frogsfrogsfrogs>
In-Reply-To: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Actually copy the attributes/attributes_mask from userspace.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/dir.c |    2 ++
 1 file changed, 2 insertions(+)


diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 45b4c3cc1396af..4d841869ba3d0a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1285,6 +1285,8 @@ static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
 		stat->result_mask = sx->mask & (STATX_BASIC_STATS | STATX_BTIME);
 		stat->btime.tv_sec = sx->btime.tv_sec;
 		stat->btime.tv_nsec = min_t(u32, sx->btime.tv_nsec, NSEC_PER_SEC - 1);
+		stat->attributes = sx->attributes;
+		stat->attributes_mask = sx->attributes_mask;
 		fuse_fillattr(idmap, inode, &attr, stat);
 		stat->result_mask |= STATX_TYPE;
 	}


