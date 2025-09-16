Return-Path: <linux-fsdevel+bounces-61614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A975B58A4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3B11B213A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42A11DF265;
	Tue, 16 Sep 2025 00:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guhUwNEd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2984D2BB13;
	Tue, 16 Sep 2025 00:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984199; cv=none; b=pwJy9gPDeIeHtDVcE6JJkmcJUXaPov14jepU6RrSGI5IEj2fJahrJOnrJX9MfMyUhizpxpgf33QWq/CR5exoTlr/hBATtHoZhhkcyj4ri0vnrRgbaP4c2xARGsNUihDxWf1aNWPgm2Nku59PV9bbRz2wzr7t+xK6mb+krIim+RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984199; c=relaxed/simple;
	bh=KKOesC4N3eWW275XBlOxLzGJkqlqy0Wck4sg05kb8XI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ljnAtDfLXtD2Tqse6PVHj37wfC4dqUr+7XNpgd0D7wn9ZcqUOPlBj2RlYE3D1iItATgKbO1kOraCT51TWIRcZqbm5WB37CcFIK7RTgA3aRBGa1/3JYughGO/lWc6Ht/20UOcrJnLguFgcNCk+cDmsxjNAQFFnrdEZ8FfnxOlhCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guhUwNEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EC0C4CEF1;
	Tue, 16 Sep 2025 00:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984199;
	bh=KKOesC4N3eWW275XBlOxLzGJkqlqy0Wck4sg05kb8XI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=guhUwNEdaPbCwgc32PPxHHNyGa5kkHBDVO715P1dgRYOMnVTOD/e9bZccxvOQmTmH
	 3Dd9zjj2COfZdMjUg1eqFjD3n6AOuvUihKE1TvAuMg2u/OC+HP5or2Zt+IBVBoGMnn
	 jlA85WDwcJGKsSj1+4ikIGXumC+RIoCRl1lhJmKHBDd2TwBU2op5dFiWByL0tpgdco
	 GJCRITubr8P3sHzfZdV4dddKkWjiawCL5QEKHwg+qVPLr42J5sbwoSNPtIw3n7xGeU
	 XxGyw0d8kBSFsceZfmsXBVeg7noSSh6W0XitkGTLErulJ32BTsQSGjIMU1e9ed0sIp
	 r8zwG0Z6Uemuw==
Date: Mon, 15 Sep 2025 17:56:38 -0700
Subject: [PATCH 02/10] libext2fs: always fsync the device when flushing the
 cache
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798161361.390072.7133982571354091080.stgit@frogsfrogsfrogs>
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
index a540572a840d17..f716de35cf5cb1 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -1462,7 +1462,8 @@ static errcode_t unix_flush(io_channel channel)
 	retval = flush_cached_blocks(channel, data, 0);
 #endif
 #ifdef HAVE_FSYNC
-	if (!retval && fsync(data->dev) != 0)
+	/* always fsync the device, even if flushing our own cache failed */
+	if (fsync(data->dev) != 0 && !retval)
 		return errno;
 #endif
 	return retval;


