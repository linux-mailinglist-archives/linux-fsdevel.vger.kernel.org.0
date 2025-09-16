Return-Path: <linux-fsdevel+bounces-61619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7286CB58A59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C494166F57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFD71DE89A;
	Tue, 16 Sep 2025 00:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEwokMew"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E20D2FB;
	Tue, 16 Sep 2025 00:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984277; cv=none; b=r/myZ+FicyOcM4YQDqX8Lcza58rUWcpG5CkuRRbIRabNJkyNdykBTzfTvQD/PB13CzIiDPTFfpFFfwI6NWD2nrg+vL8IzoYHEvgxAWLeMG/tVSWZigcDwvawYRo7B+LiAYPmgw/F2KkDQDsaJ3nuMmdYno7LJ5F+p8Icm87rFEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984277; c=relaxed/simple;
	bh=3vFtXyg44o1/v+3fW4KCAcXaQwgHuUyEDESkvGCIHDk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hm7hv9pMtCOQCPrkh6/b4CkeHbSu0pwgSoMZ8F5lW7B6Iljx9hAIxdc2uXUchQ5w/bXqABYlMj1pSY9+1BAGPSdA+b/C5pN3/mMd78FohJmPfOjXD5nrLeuVV7398r7+rtXTTiIX2OeqpEAamDL2WjN4VakZTpK6I0U9eqhH9Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEwokMew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1822AC4CEF1;
	Tue, 16 Sep 2025 00:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984277;
	bh=3vFtXyg44o1/v+3fW4KCAcXaQwgHuUyEDESkvGCIHDk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=uEwokMewKrbRc7TnycfbueX98NYoNVgFbO+tAPOroQ85PWz4YH0W3r3s3oBQ/E0Tq
	 vTilQSuzFAErhBnDHxYWm4k5739L8RlHm0IxDtyco3MkAEJl9jkNiiig3/ZNxhuCTZ
	 3AamIBxp/6zY5AHjXpI8EpbuGs11I/MAfC0runW3U5g3gaEHJQTUh/k0v9V2EEULqY
	 1xNA+qp6bHFcaK69a5+rZ6Lq2AupPNHo2nhMLbKtVHl0NqUfq3OL3QuJWPjPO/ZTwX
	 nHbVbh/ic9nM29hl1SW+7yKKkGjSI1TTettw/9W+C99l5RHxdKyArf2M4C+gV/FiRY
	 2DO4RsW29ICxA==
Date: Mon, 15 Sep 2025 17:57:56 -0700
Subject: [PATCH 07/10] libext2fs: allow unix_write_byte when the write would
 be aligned
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798161451.390072.3945026407851009864.stgit@frogsfrogsfrogs>
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

If someone calls write_byte on an IO channel with an alignment
requirement and the range to be written is aligned correctly, go ahead
and do the write.  This will be needed later when we try to speed up
superblock writes.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/unix_io.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index d4973d1a878057..068be689326443 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -1479,7 +1479,9 @@ static errcode_t unix_write_byte(io_channel channel, unsigned long offset,
 #ifdef ALIGN_DEBUG
 		printf("unix_write_byte: O_DIRECT fallback\n");
 #endif
-		return EXT2_ET_UNIMPLEMENTED;
+		if (!IS_ALIGNED(data->offset + offset, channel->align) ||
+		    !IS_ALIGNED(data->offset + offset + size, channel->align))
+			return EXT2_ET_UNIMPLEMENTED;
 	}
 
 #ifndef NO_IO_CACHE


