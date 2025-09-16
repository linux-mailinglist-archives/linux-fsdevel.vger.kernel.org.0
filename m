Return-Path: <linux-fsdevel+bounces-61773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C04B59B5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 17:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F16451BC6562
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 15:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E78368097;
	Tue, 16 Sep 2025 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6dQfh5T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26813629A3
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034830; cv=none; b=gTD3oTNFWjsshfEV/kX7fV3ebVys8V5cY/Hrb7GhTaQImVZynJHTixwY/cXFbA8YRvzSjLZI51bSIRleGfXHtO2jZAqA2J3kYuGKMCmoDAb16WNScFKMDSL4mjoFV2zUjFQYQ8ToxIoMMmreoqkurpQbRGkalBfvx+buflqYwJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034830; c=relaxed/simple;
	bh=pDINNza5sI4+5+QBd4r+W1SwwtLUzDen2bjnUuWU8U8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HAEsgW+EtL77DPAys0TWDwpJWeW3xEIogWxr4cf0nHB5YE+FzxFVVSsaO8F26wXW3ZRi8Flup+Q9eH6awCk5Ad6S/CTJEHj+N3oZVRsLoQBBrwmdGgF7T+imIwTYc2l8DEgib1dX58tUA+GV0gu8/52dt2XQnd8JJ1EJTbn31Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6dQfh5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D9FC4CEEB;
	Tue, 16 Sep 2025 15:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758034830;
	bh=pDINNza5sI4+5+QBd4r+W1SwwtLUzDen2bjnUuWU8U8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=C6dQfh5TVbrUUVmiG76rlc4mzbYkigekzKUcZu3LDe7swJtDOatAYXKv7XaC0gkYT
	 KUW0S+sXrURVgD4RCgNW290BMxauhAabz1vcaX0fpqC+gYTkUuBOTJNlqjZcubTM7C
	 Nt8Qw0vt46RGvmICKSuZK6wCoocBkQ+kw/B3kImsyFEQr49UVP5HvunI6tbgGHP5j+
	 0qAcJTvpc47Ep77UO+0g6Qn7ThrNONi8jHyprqaBe0gy4okr7F7BmMpny28B3LSE/n
	 eDJ9prjt8PZzhK6zh40Za7FhDbWiM+PGdppqel3o4I00QT1IEIEuyU+ZntH1bupddM
	 md66H7r3svf4A==
Date: Tue, 16 Sep 2025 08:00:29 -0700
Subject: [PATCH 1/2] iomap: trace iomap_zero_iter zeroing activities
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, brauner@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, hch@lst.de
Message-ID: <175803480303.966383.2380024013746734540.stgit@frogsfrogsfrogs>
In-Reply-To: <175803480273.966383.16598493355913871794.stgit@frogsfrogsfrogs>
References: <175803480273.966383.16598493355913871794.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Trace which bytes actually get zeroed.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/trace.h       |    1 +
 fs/iomap/buffered-io.c |    3 +++
 2 files changed, 4 insertions(+)


diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 6ad66e6ba653e8..a61c1dae474270 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -84,6 +84,7 @@ DEFINE_RANGE_EVENT(iomap_release_folio);
 DEFINE_RANGE_EVENT(iomap_invalidate_folio);
 DEFINE_RANGE_EVENT(iomap_dio_invalidate_fail);
 DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
+DEFINE_RANGE_EVENT(iomap_zero_iter);
 
 #define IOMAP_TYPE_STRINGS \
 	{ IOMAP_HOLE,		"HOLE" }, \
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1e95a331a682e2..741f1f6001e1ff 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1415,6 +1415,9 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
 		/* warn about zeroing folios beyond eof that won't write back */
 		WARN_ON_ONCE(folio_pos(folio) > iter->inode->i_size);
 
+		trace_iomap_zero_iter(iter->inode, folio_pos(folio) + offset,
+				bytes);
+
 		folio_zero_range(folio, offset, bytes);
 		folio_mark_accessed(folio);
 


