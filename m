Return-Path: <linux-fsdevel+bounces-49633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4BEAC0117
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D4607B7B0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD71F20EB;
	Thu, 22 May 2025 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSExbJlp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106CC383;
	Thu, 22 May 2025 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872620; cv=none; b=CeqSYfVJgHb2Huj8W1LB07pfNzvLG6lof1pl5P3t1E3UzlAssyncRgvkNZF+5ztlehc6lIPE4hRvY4dNiNL86n21ZGZHkWZl3Y+YRRYyIIjjvD8i+/PUVirqDIxYVQmPlKhz8obEOe3E0USbfgA4y8iUr9ua0qx9z2P7DIGx2Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872620; c=relaxed/simple;
	bh=yGt0cgsw+qRVes2874CXqfGsDsy6zpdYBCfFWbgc3Aw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gk17SSRw5hXS3HqOhMj+4xDCnYtoIeaJKH8CNu6bHgocB6NKDJZmyegV7xyy9Fo0rsBtTeYJUjlIlAo+a2Ymd1xqvhtV5gcTTleKxhELhLRRw4nRldKzeigpLX7pNGEa1Fhua/SAALSZ9Irtd1y/XaK+rHEnBuM31/EdCQWtJrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSExbJlp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D99C4CEE4;
	Thu, 22 May 2025 00:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872619;
	bh=yGt0cgsw+qRVes2874CXqfGsDsy6zpdYBCfFWbgc3Aw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=mSExbJlpw7E+6ReVC8S9kVLwUdCRseUHzQglHD1PVfwbVj+unQSW8ybMz2zQlMmy4
	 zmIu7byPwYjc38KgkBnpOqtpDN+5Vj9gc9mMKoucKZiPybvGP6pXrHwOUn1Yefvts1
	 6ikmEjlh/vWIGRgxMMjuEWr6sROsD73bYhZkjqxNK7nChqKg1vkXrhSAc65/ffp0nm
	 taXeUG7e9lJs1IjEkPVz2gAcFG1Dh1BDh1CTdWrIimzPfcUSyx5cQeLin6K5S8jHLo
	 INvcfByqpXuvDP+EBBfarHuUMSf1+IS5b5BELykpqJPtA9gC7ydEPJMCrbviu3tFjw
	 V0BMDparh9AFw==
Date: Wed, 21 May 2025 17:10:19 -0700
Subject: [PATCH 08/10] libext2fs: allow unix_write_byte when the write would
 be aligned
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 joannelkoong@gmail.com, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Message-ID: <174787198211.1484572.66428039447930057.stgit@frogsfrogsfrogs>
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

If someone calls write_byte on an IO channel with an alignment
requirement and the range to be written is aligned correctly, go ahead
and do the write.  This will be needed later when we try to speed up
superblock writes.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/unix_io.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index 4c924ec9ee0760..008a5b46ce7f1f 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -1534,7 +1534,9 @@ static errcode_t unix_write_byte(io_channel channel, unsigned long offset,
 #ifdef ALIGN_DEBUG
 		printf("unix_write_byte: O_DIRECT fallback\n");
 #endif
-		return EXT2_ET_UNIMPLEMENTED;
+		if (!IS_ALIGNED(data->offset + offset, channel->align) ||
+		    !IS_ALIGNED(data->offset + offset + size, channel->align))
+			return EXT2_ET_UNIMPLEMENTED;
 	}
 
 #ifndef NO_IO_CACHE


