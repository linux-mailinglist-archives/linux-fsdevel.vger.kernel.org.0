Return-Path: <linux-fsdevel+bounces-61615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96439B58A52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2DA3B2DFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B351EBFE0;
	Tue, 16 Sep 2025 00:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AndGDpgb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84A31C3BE0;
	Tue, 16 Sep 2025 00:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984214; cv=none; b=cd1g2OJUeaCvXahA/EosiejDcv6pffvxcigfCQ2utsLdn2v63C62JFd0hm3UIh7qMojxgEfROl9KTGmNcMrEBhzYdWBQGdM7IFni0dBUXhTiwyk879jOkbH0bq4pJxIStDlhTsGOVmZO5RGpXSupV2Xoc1wumlWd4JGEcGKudWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984214; c=relaxed/simple;
	bh=sxwCFfNBaYE0L9U6Y5quTt8JonYFw7sr8bbiUjsVrOQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ReLrZud66+3fS41+p7/ZLXWEpoboICToFRKMwg59X8T9jnidvyysrQlV2tpJKufLlqji9MlAa7VTQ3+pohzHlnj2mqDb2rsXKya/tOskyqpjZnrBoTDc3u0CwFCH1puL4gmxCZWp1wQcbxG2J4N1/B2Gf+2OeUIcJBjai+An/v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AndGDpgb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CC3C4CEF1;
	Tue, 16 Sep 2025 00:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984214;
	bh=sxwCFfNBaYE0L9U6Y5quTt8JonYFw7sr8bbiUjsVrOQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=AndGDpgbmHn3DVYhGn7MP5AuAoWXAyybogoa36L98/zxO1+ysP3Kcs1vg9hqsZXwh
	 if34jZUyXmIYinGhfYpPiHZkEZz78bcq9A35Vu1d3az44dLu+yR/SJK8Aj5BEeEY3U
	 SgyRiCfQOpDZGbYm0J5oEEReEuwlUyNgQceZBj+qtk9p99/InuIk1MyYUXsUBIilaF
	 iWx8qNZgFnHYGf3MgIkhX/c2T1oUG+M7gdDiWN5B5JZwG7RoH3dx/tMC/FLSVJs2Gk
	 co8Mxky4KGcNbHHldAvH5TtiZzS6mUUlemi7im1Ba5YzdiCXXDoHRPleKzxOjqzPun
	 C7A+e8vvvi7iA==
Date: Mon, 15 Sep 2025 17:56:54 -0700
Subject: [PATCH 03/10] libext2fs: always fsync the device when closing the
 unix IO manager
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798161379.390072.9493041674509978790.stgit@frogsfrogsfrogs>
In-Reply-To: <175798161283.390072.8565583077948994821.stgit@frogsfrogsfrogs>
References: <175798161283.390072.8565583077948994821.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

unix_close is the last chance that libext2fs has to report write
failures to users.  Although it's likely that ext2fs_close already
called ext2fs_flush and told the IO manager to flush, we could do one
more sync before we close the file descriptor.  Also don't override the
fsync's errno with the close's errno.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/unix_io.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)


diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index f716de35cf5cb1..b04e8a89a951dd 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -1146,8 +1146,11 @@ static errcode_t unix_close(io_channel channel)
 #ifndef NO_IO_CACHE
 	retval = flush_cached_blocks(channel, data, 0);
 #endif
+	/* always fsync the device, even if flushing our own cache failed */
+	if (fsync(data->dev) != 0 && !retval)
+		retval = errno;
 
-	if (close(data->dev) < 0)
+	if (close(data->dev) < 0 && !retval)
 		retval = errno;
 	free_cache(data);
 	free(data->cache);


