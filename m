Return-Path: <linux-fsdevel+bounces-58527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B89B2EA4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9029C3BDBF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBA41F560B;
	Thu, 21 Aug 2025 01:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R443/gY/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A652546447;
	Thu, 21 Aug 2025 01:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738895; cv=none; b=hA6NqgGmSpTp+daplBcZ8ugsbjrzfivQdYcUF2nxIFbL4KhTpW+GDnWc/8KGL66krMm8AZtPltTsYawG5KzVgOYYFd1+hUjPigXTlLN4el1xfnih9sS/EVqVQ2Ag0/vJoh+c9SYWZuJaGpF/YsTR+Ch41xvmFYHZD0LuPs9JxpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738895; c=relaxed/simple;
	bh=3djsZ8DjVp3PZI9P4ccy3kYmlLuOhWoKLh1WQvb1fvk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZwVa9eXxt7dEX+Y3k/UHH27alai9leQ8SV5yeY/7xkkUy0CEnrCktNQ3PrW20Cpx0X1kYwYhim8QoXdHCAAfIwb6yTthHK/52b6aP8am1411BwTWB7tG02niCZKnPyez4SASRNQIuK6ufAitD2CMi+HNOA2hewQOLjaYxail+yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R443/gY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0521DC4CEE7;
	Thu, 21 Aug 2025 01:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738895;
	bh=3djsZ8DjVp3PZI9P4ccy3kYmlLuOhWoKLh1WQvb1fvk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=R443/gY/6LxewdKTIVylUs/KV0Ps/+KICdnFHPYM1Dwua8C7LepMtyEae7WZbfsuZ
	 d8tlfHZZtVpyF1n6yT42sEwIBo0Fq5Pl/YubvrOU+0O0ja7/S+4ghs3PnelDkwBQJ9
	 d5oyK+OssJLcfJ34UvbYM5apFOG645XVHKv5tXmFz6JerLZFtpxJOKHPesRT5uRo53
	 8dLe8ryA31RytKULGHdo5anxCS+uHaJ1k72Z1Xi/Vv5ebJpDUmpaGo+OE85q/rAxtr
	 uaE8xWExcHkbZjBQ6lHsUQ3TzPWa+uG9+eC0rn0LmKEhrZbbllWF4FN0MKAOYBGuJ/
	 id2BKHHXVOJHA==
Date: Wed, 20 Aug 2025 18:14:54 -0700
Subject: [PATCH 07/10] libext2fs: allow unix_write_byte when the write would
 be aligned
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573713461.21546.1107229848391252542.stgit@frogsfrogsfrogs>
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

If someone calls write_byte on an IO channel with an alignment
requirement and the range to be written is aligned correctly, go ahead
and do the write.  This will be needed later when we try to speed up
superblock writes.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/unix_io.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index 4036c4b6f1481e..2ee61395e1275f 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -1480,7 +1480,9 @@ static errcode_t unix_write_byte(io_channel channel, unsigned long offset,
 #ifdef ALIGN_DEBUG
 		printf("unix_write_byte: O_DIRECT fallback\n");
 #endif
-		return EXT2_ET_UNIMPLEMENTED;
+		if (!IS_ALIGNED(data->offset + offset, channel->align) ||
+		    !IS_ALIGNED(data->offset + offset + size, channel->align))
+			return EXT2_ET_UNIMPLEMENTED;
 	}
 
 #ifndef NO_IO_CACHE


