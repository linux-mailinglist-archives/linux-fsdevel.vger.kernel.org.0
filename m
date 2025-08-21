Return-Path: <linux-fsdevel+bounces-58522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04164B2EA44
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865AFA255B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89A91F8676;
	Thu, 21 Aug 2025 01:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwiDvijy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208C51A9FB1;
	Thu, 21 Aug 2025 01:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738817; cv=none; b=icTXuT4s+Dd4yTJ1P+2YjbeWpFwlTniAsHqrywg/jZWVo2ZLQzRlj6QneazcOs6rN1hvia1Av4hlmU2zKAjoaroPFtVeEvrCWEjRuocMIyB8mXCsM1ciVtSGY+7Qo1KANrQlzNhz1qKh3mCl5w0pj6WcXG+xS7SBur/E7oluYYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738817; c=relaxed/simple;
	bh=RPqsARQZXturyDdD9HIYF20lIJZfviWdmU6+IYIWMKo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dBcjXbtVLqjBQZ0rgqBzR5oaOLXPDlt0gR0q3re9rA3/SQjvSwbRyDfSVAdeDnQdYFlRBPqFZ7oZ+4mkZxONl48SU3U4hpJ8R4ylgaqtTg93U5I8yTNC6TBW7dFYilKrq9868qd3vRxtDFKGjmr0vpO3Ij8a1T+4azQuIWb4YUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwiDvijy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB411C4CEE7;
	Thu, 21 Aug 2025 01:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738817;
	bh=RPqsARQZXturyDdD9HIYF20lIJZfviWdmU6+IYIWMKo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jwiDvijyE5wqRDlCOksuXFohTWkdQfSs3bk/XXgEDeXbdb5bqZS2XoWbrOCmhfvBi
	 TStCACpmXYOjyGjKgqkDOMZb92roKiOZXpr2nC8D4zpPvgFClLvdmv7JdgWrhkOlc2
	 +HUETQn4UOZVcA18ZQoDqE72QLCkFKvKHvALCtSHSznG/UbROoDHiNlrGLiqScWO4S
	 pdYj/BMylsM9Ej9LchtY63poRnfGuk5TP1fej258DUXvAPmW6+mhrCU1lqrrvXWmmE
	 denqWkhQSEavLkwU3w3L+d2AWJrI5eHKgI2kEuXdsy6dhEOLB2715mxkl2Y6e3EPbG
	 27iLgEKiwYzYA==
Date: Wed, 20 Aug 2025 18:13:36 -0700
Subject: [PATCH 02/10] libext2fs: always fsync the device when flushing the
 cache
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573713370.21546.11191910658344980579.stgit@frogsfrogsfrogs>
In-Reply-To: <175573713292.21546.5820947765655770281.stgit@frogsfrogsfrogs>
References: <175573713292.21546.5820947765655770281.stgit@frogsfrogsfrogs>
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
index 561eddad6b8b17..14f5a0c434191a 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -1463,7 +1463,8 @@ static errcode_t unix_flush(io_channel channel)
 	retval = flush_cached_blocks(channel, data, 0);
 #endif
 #ifdef HAVE_FSYNC
-	if (!retval && fsync(data->dev) != 0)
+	/* always fsync the device, even if flushing our own cache failed */
+	if (fsync(data->dev) != 0 && !retval)
 		return errno;
 #endif
 	return retval;


