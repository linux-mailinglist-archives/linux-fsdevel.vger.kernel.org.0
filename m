Return-Path: <linux-fsdevel+bounces-61586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 956ABB58A05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A11617CF36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F6B14B950;
	Tue, 16 Sep 2025 00:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFaigdFp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409EF4207F
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983714; cv=none; b=O2z7FKR7N1O6oVf008PBmUgDrtzmJ68fLBbNru4A4cxB/c6f7O18FCftKWHjR1c1yPXIA9yUlac/U5WmngoDOK/EO9oiuTrJurURNtRZ9AdRzjKB7Fx+KnXtYiXZykjcRySzziYs2+f+CMsgOULwUDVAAiDoIaTqnamlZtYgiX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983714; c=relaxed/simple;
	bh=nYtDnV92RYNw+2FLygPr/7YVjjtElItaNXJOlzKIJwI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5yc8Y/Bsp2+VjtghnEj12pUyzFSA/Vf5tHeN58r/Zp0mtJ7QBZ77+XU8uoDwaUvfh0I6Y3+AzOVmE2gcopzK8tf3ny7+iRFV6Q9WV4TjwQVWX1GuskqRsaSVIrqma9oNTvBYuyQguRQe06SRG8wLIo0+vk9LfTcBUILtKxvGOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFaigdFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD229C4CEF1;
	Tue, 16 Sep 2025 00:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983713;
	bh=nYtDnV92RYNw+2FLygPr/7YVjjtElItaNXJOlzKIJwI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=OFaigdFpfHG/5BSiECtJOWQl/jRxIj9xg6yxAvWriGMDiDXEYtUACBz4jWjZushPF
	 XAyky0rOsNe6TlUVvQw0whCNVCsYdBpAzYmh30XvR1igf4V0TR5R3eEQFchZEvqyS9
	 mzAivXvORrdtDuzkTSg65gVKKaEiLVawN0ehGyKktGBCk/5zEuYnjCOyYi1q9zBFyL
	 R5kr1lys/4K/6gmP3FPKtvl3OJnGEhQeDdjC4stKlOe7A8+d1yWGwdnNrclE0hcssF
	 fEywXoDQz9j6PiiWj5stJx31QIBso8kRgXajzrwNn3d8gih7IgudqOV5T93BhLNsFz
	 QOsD49fTgmdMg==
Date: Mon, 15 Sep 2025 17:48:33 -0700
Subject: [PATCH 3/3] libfuse: enable iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798155566.387947.1167837197335562079.stgit@frogsfrogsfrogs>
In-Reply-To: <175798155502.387947.1593770316300327637.stgit@frogsfrogsfrogs>
References: <175798155502.387947.1593770316300327637.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Remove the guard that we used to avoid bisection problems.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/fuse_lowlevel.c |    2 --
 1 file changed, 2 deletions(-)


diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 1dc0fcbe54be6c..460ade5a9704a4 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2997,8 +2997,6 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 			se->conn.capable_ext |= FUSE_CAP_OVER_IO_URING;
 		if (inargflags & FUSE_IOMAP)
 			se->conn.capable_ext |= FUSE_CAP_IOMAP;
-		/* Don't let anyone touch iomap until the end of the patchset. */
-		se->conn.capable_ext &= ~FUSE_CAP_IOMAP;
 	} else {
 		se->conn.max_readahead = 0;
 	}


