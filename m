Return-Path: <linux-fsdevel+bounces-49627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4744AC010A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3021BC421E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286B53D76;
	Thu, 22 May 2025 00:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3CZA7ZC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B9180B;
	Thu, 22 May 2025 00:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872526; cv=none; b=Zt8rSclBZ8Wrz2j7ADiEsDKuWUBalPNwUC4WGn3+udVXrMDpeW2GxNcGfeEKVw4OdA81XwNaAUN4PlYhO23xgb3+rirj3uNK4V+9N/xpfUXD9+5rnJEPpkCFtpw9X/So4fbqHQW3ayJpMJUNzfecftYn2fW9FHtXbB1ZuGczPuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872526; c=relaxed/simple;
	bh=Nz6w1nTcDqRrs+/sNPxv4IfXzwvg3jAxVnMvTDHX5C4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LVJdl1YwZ/tmFOEbsTEkvrs5jcD2MtTfe0JceRn/Xki3FWt1MCip8jtiJ5q285yehkttCndQEkIocWP3HSifAwJTky+jzMSVyKOH9RQK6Q1bZ+THl+Stqe45eIflSmGoCYHuzzlyZHhbqOHAC/klVitVwnGLn27Nsr9mWodRIjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3CZA7ZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CDFC4CEE4;
	Thu, 22 May 2025 00:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872526;
	bh=Nz6w1nTcDqRrs+/sNPxv4IfXzwvg3jAxVnMvTDHX5C4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=j3CZA7ZCb/mH8SRmw1TizXfd1ru2l7f0x6gWz0ihbhKNbNMmIB3tF2p7l8mR3IZXK
	 2pjFK7WmT/RmCOYeZ4GDjWa8XUud60e1QDnhMquOq1q7kdG5ERu6Di+SyTBbByNU8B
	 Cl91gXilnm/o5eJJLn8Sns98qFZgHazuSzA1cbYQMjSE0Gw/gkmAo43cc3tzQTAzuT
	 EIPwqinf0KV+CSdUtWxYJeQx+F0g+9xmlckEr90vwo2rLnswZHdXbtFJ9y3hv9x1rx
	 vAj4DPQkY23M5estNsPUXkOTxTCGFHZZQ+Q3qyKtjALJFUmGAKypTQZVBZROxKMtRg
	 KWzsLW+alX5dw==
Date: Wed, 21 May 2025 17:08:45 -0700
Subject: [PATCH 02/10] libext2fs: always fsync the device when closing the
 unix IO manager
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 joannelkoong@gmail.com, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Message-ID: <174787198103.1484572.14307160616313425545.stgit@frogsfrogsfrogs>
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
index 40fd9cc1427c31..7c5cb075d6b6b6 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -1136,8 +1136,11 @@ static errcode_t unix_close(io_channel channel)
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


