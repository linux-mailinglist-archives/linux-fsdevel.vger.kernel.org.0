Return-Path: <linux-fsdevel+bounces-49626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 361EBAC0108
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CBF27A64C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587531FC3;
	Thu, 22 May 2025 00:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLZu/DCM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B400D380;
	Thu, 22 May 2025 00:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872510; cv=none; b=k/yxkiokbtTmjeuJwc1UnKH9OODM6NMgqs52PY4fKo0vqFq6+4LFOWFezfAdZySTRs6wZU9pLKwHi524x6RQNXArtybyQtx9UG+pXsZBcwsFoKpaLpIQZwelPqUbNfAmxjZCeZ+wN0JKFFq8ETm5HlCJDM+gr2jxIrrEM4qLk2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872510; c=relaxed/simple;
	bh=SxXuyWp829Z13KvBCGIZzexTf0rtkJxNN0mCnFW3u/8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rBSpFHorFugxtF++IQ8taDf7/djRoiAsI6kfzThUm8vdUJVjzc/yF6PBMDdoVfNkRmxUyZkV8MtD6nItV8+PXtJjNQ90CJe7m4Yq7nKtqlJQdeSu7YOBiwzE1qu39odmUUW9lQxhf6QPKzFN9Z7tl1+zheusdNgAuxgVslju+nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLZu/DCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C213C4CEE4;
	Thu, 22 May 2025 00:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872510;
	bh=SxXuyWp829Z13KvBCGIZzexTf0rtkJxNN0mCnFW3u/8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=GLZu/DCMm8BuUWUU3iO7P+w3EzXKOq9hEYVEhJxcRI44us5K/GfijGQAbNpwDM9jV
	 6jEE59kK5T3/oJM0N3os8JURQvMo/GzClXxSriP/t7AaU9xkHF9H9AAanQW0K1GR0o
	 gBBmXE22S6KPhnYBJjlqtBVeNe4Ji23qHzAnQMOSbs9/qAJh7NK75G0HstmKod8qLM
	 MvOhRC4Xi9hf/0SvaO04R0TL6h3cNx+AB0C4RtxLAEmY1Hol16k98a5GgzUq4hKcme
	 qAO2qitc4f+rb+7Z1zo3DXdJF6AS6JwUG3oEBFA20PFP1Jq+igMIF1vJJUbaUxOHIf
	 vPJ1uPCt+Q/ng==
Date: Wed, 21 May 2025 17:08:27 -0700
Subject: [PATCH 01/10] libext2fs: always fsync the device when flushing the
 cache
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 joannelkoong@gmail.com, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Message-ID: <174787198085.1484572.9369427239470858864.stgit@frogsfrogsfrogs>
In-Reply-To: <174787198025.1484572.10345977324531146086.stgit@frogsfrogsfrogs>
References: <174787198025.1484572.10345977324531146086.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

When we're flushing the unix IO manager's buffer cache, we should always
fsync the block device, because something could have written to the
block device -- either the buffer cache itself, or a direct write.
Regardless, the callers all want all dirtied regions to be persisted to
stable media.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/unix_io.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index ede75cf8ee3681..40fd9cc1427c31 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -1452,7 +1452,8 @@ static errcode_t unix_flush(io_channel channel)
 	retval = flush_cached_blocks(channel, data, 0);
 #endif
 #ifdef HAVE_FSYNC
-	if (!retval && fsync(data->dev) != 0)
+	/* always fsync the device, even if flushing our own cache failed */
+	if (fsync(data->dev) != 0 && !retval)
 		return errno;
 #endif
 	return retval;


