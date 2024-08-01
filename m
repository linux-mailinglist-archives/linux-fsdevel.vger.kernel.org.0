Return-Path: <linux-fsdevel+bounces-24744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F45E9449B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 12:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25A721C25764
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 10:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2484183CC8;
	Thu,  1 Aug 2024 10:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECGKPem3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C14183CC4;
	Thu,  1 Aug 2024 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722509490; cv=none; b=A0FSfDLnx7hZp8f8NZjouVoIUfLaFSX57PxhKtQocqAZQi36nHuawfasOd2nmtYcntkVKWV5Rzq4iyI9HzhrwO5qaP8m7wQUAxlNWsAOrUHSZqcZUnBe2rfREOJ26WqbhosxBA5typTvnjU2HPSF/n2rAYveveFpI9H2HURi5yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722509490; c=relaxed/simple;
	bh=nQfFDUQSVv8HuknkBtK4lXJBt8rvP0e3um6yBQSVNUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OY062rNcGPglJU/IAIGFUqsJYf+OnhT8nEklgvUKIyrg7xi/yEWnUC/SUGZrtabZkORM3h1bVbtqz5GC9A2RrG6qHXGR2UlTAROXQFlaQ0+wWiYG7+V09RnWI1tHAmeWYxn0TuUG7pWAoOyJQiDJxW1EMcOPCwRL9wumF/TrWYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECGKPem3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACB5C32786;
	Thu,  1 Aug 2024 10:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722509489;
	bh=nQfFDUQSVv8HuknkBtK4lXJBt8rvP0e3um6yBQSVNUg=;
	h=From:To:Cc:Subject:Date:From;
	b=ECGKPem3M5JyBbM6Wa57DV81aZXAJGeESobxoiAkrN3aoc6ENYorjhVbDq4/RLRTs
	 8tUHuRsYnO7ZHEKb8dgAcWo5H0J4nZ2QRK57KlxDruvF4NQm+15fmlZRc2lLfPsvMq
	 H++KLQMa+MemQrhKSvg0miKUWEqR+oubASngarcs3Pg41tQkgpV42xqi+vCTVGK1nf
	 tZddURAeiHA1YOTceVFOds5mIJacNM4SgrxGfxuWwMqauGPQlcRGD1EWQbMvVUTGrG
	 xha4s2E5R8VJDADJkS5ZWLPzEg7YPoNzT9vBaGViGiEF8jDDIXmqSNTRm3kTNjQWye
	 xmWVyNGgEjwpQ==
From: Jeff Layton <jlayton@kernel.org>
To: brauner@kernel.org
Cc: sfr@canb.auug.org.au,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: clean up warnings for multigrain timestamp docs
Date: Thu,  1 Aug 2024 06:51:27 -0400
Message-ID: <20240801105127.25048-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stephen Rothwell reported seeing a couple of warnings when building
htmldocs:

/home/jlayton/git/linux/Documentation/filesystems/multigrain-ts.rst:83: WARNING: duplicate label filesystems/multigrain-ts:multigrain timestamps, other instance in /home/jlayton/git/linux/Documentation/filesystems/multigrain-ts.rst
/home/jlayton/git/linux/Documentation/filesystems/multigrain-ts.rst: WARNING: document isn't included in any toctree

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/filesystems/index.rst         | 1 +
 Documentation/filesystems/multigrain-ts.rst | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

Christian,

It may be best to fold this patch into f9cb86069bad (Documentation: add a
new file documenting multigrain timestamps)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index e8e496d23e1d..44e9e77ffe0d 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -29,6 +29,7 @@ algorithms work.
    fiemap
    files
    locks
+   multigrain-ts
    mount_api
    quota
    seq_file
diff --git a/Documentation/filesystems/multigrain-ts.rst b/Documentation/filesystems/multigrain-ts.rst
index f58c14c53b0f..97877ab3d933 100644
--- a/Documentation/filesystems/multigrain-ts.rst
+++ b/Documentation/filesystems/multigrain-ts.rst
@@ -79,8 +79,8 @@ is no such guarantee, and the second file may appear to have been modified
 before, after or at the same time as the first, regardless of which one was
 submitted first.
 
-Multigrain Timestamps
-=====================
+Multigrain Timestamp Implementation
+===================================
 Multigrain timestamps are aimed at ensuring that changes to a single file are
 always recognizable, without violating the ordering guarantees when multiple
 different files are modified. This affects the mtime and the ctime, but the
-- 
2.45.2


