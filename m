Return-Path: <linux-fsdevel+bounces-58523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F4FB2EA45
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0CCD3BD91D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F411F560B;
	Thu, 21 Aug 2025 01:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HC0YmuJH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35DA1A9FB1;
	Thu, 21 Aug 2025 01:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738833; cv=none; b=M0FwYQZR6Ox8LnKAZpbLGtmcq2TyZM/BU0YM/ad5caaDcyS+J13QFycv2y7MPVAFiASOHlix6DaaWk9hFlUMMbAS4doCUwyZa8OcFQfkOCgWCBWIWYvdLfe+5lqslRisp7BKFL86wT+mblFpQU89oXBIxYfHHtt3gGjzdbIEyVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738833; c=relaxed/simple;
	bh=BQ4nOkCNfgWFgwihLHA9hCVysPopxQlb3ceYcVpaJ0k=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBq1AvsPgO9V3ADt3tyV1AIlHu9oFO7UKBxwwCr/1XJ25ymKPRIwzsZebb9fNXV5vb9Yetyma1mq3axD2X6+vhlCMoyhfKEaTjn1iIX8yiulvqksgAecvS49I9LkVucIbBjX1yBmhq9mfXmRutK9xkGjutPtZjFwPIHAIiFXHy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HC0YmuJH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90156C4CEE7;
	Thu, 21 Aug 2025 01:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738832;
	bh=BQ4nOkCNfgWFgwihLHA9hCVysPopxQlb3ceYcVpaJ0k=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=HC0YmuJHEY3dMZ1BLuoZrcI4OA9g5gw5NGCQy1uVzE0PZ7VSdQq7NbNrZnYxT49Xs
	 Ze7wG8G6LvNEBCcbL5dvsSpdAlYdm/BirAzySd+DdVKbKWovDUbA75GNlihayaFEOz
	 afGRj5+mZ60o650JZceGhatT9tDZR6tCumqwLTRo09TZzSNn9UPbeTvdsx4xzdlFUe
	 BaN+nDtpIhn0VR583evIJgj3TLjOkJDZHBf4sTwlqXbl1kwviNfLrs0XioIvZdNL7d
	 /3rNDU4OC1U23OaZdIkfOGVVus/qXoGPxKizLaBnOI2tsMfIEUWxQDco5PUxkXcfpr
	 lzYO8LSIPgxjg==
Date: Wed, 20 Aug 2025 18:13:52 -0700
Subject: [PATCH 03/10] libext2fs: always fsync the device when closing the
 unix IO manager
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573713389.21546.10267507744752133905.stgit@frogsfrogsfrogs>
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
index 14f5a0c434191a..80fff984e48224 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -1147,8 +1147,11 @@ static errcode_t unix_close(io_channel channel)
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


