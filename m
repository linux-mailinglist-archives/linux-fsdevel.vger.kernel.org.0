Return-Path: <linux-fsdevel+bounces-22210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E67F8913B76
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 15:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F43EB22E72
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 13:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160F819D896;
	Sun, 23 Jun 2024 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCCOP8A4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEA219D09C;
	Sun, 23 Jun 2024 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150346; cv=none; b=n1yQT5814pCEVS/inG/m8Ng+h+oe93jfIsjKvX3SMySsFnbRFF4EQ9ZHhVLU7PfQNNcIrPnCm1gaBiefDoJkzuwqG/+mGgjTgS44X4UdtVLKF7XaHcZ4tF9LJA/L5kX3JBz5/S7Uv7f74sawlGyqbEUIUGenpDYpPBSX2JxHwPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150346; c=relaxed/simple;
	bh=A2bSITlnLcwpG+GIR5EBmTrO6XsC5owo3dU/WKyBNsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VOOONSWHxCmfjiwHWb3VOGcifrsFVZAQdek7cbGWwEEWqfGS3nyJbfIsz3IP7iaaCnamVrUhGW5jMAUiiqHbfaTe8ahhz7YHSLL4iqv3lfbBX4v8TSYFFw0vKvdxUBoJSbC8M4Fua67Yr470XwhRRumi47C//Lpdlx/frqEHzs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCCOP8A4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56901C32781;
	Sun, 23 Jun 2024 13:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150346;
	bh=A2bSITlnLcwpG+GIR5EBmTrO6XsC5owo3dU/WKyBNsY=;
	h=From:To:Cc:Subject:Date:From;
	b=YCCOP8A4/TDBer4+Kzeb54sdlPxUg8HBToXHPrq47sYdmR5Q5tBtXqTDhw6v/blMu
	 iLxE9XygtaBXDr/ASsrjtuxlcb4BcRQbkGmODr5un0UHyyrWEiR+VGGrzgIOAH60rF
	 213KVMbLYcZ1yCCICJ/zOGwR91L7Ym5TtPdYV1ksOedl8EhQXIuyuchg0iXPMBG/We
	 K/ZNQQ4RSB8q41VeFf45pdERm3k54otRRKXokhXqbkdSTdu/akd6SWbCoCIbwPckBh
	 XwYzFxN1SYe6TR6vRsHjC02nmD5AiGokxtjBZEDO7tOkHfpco4WbIH444GnII1z6Lr
	 00ZycSefu8NKQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yuntao Wang <yuntao.wang@linux.dev>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 1/2] fs/file: fix the check in find_next_fd()
Date: Sun, 23 Jun 2024 09:45:42 -0400
Message-ID: <20240623134544.810127-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.220
Content-Transfer-Encoding: 8bit

From: Yuntao Wang <yuntao.wang@linux.dev>

[ Upstream commit ed8c7fbdfe117abbef81f65428ba263118ef298a ]

The maximum possible return value of find_next_zero_bit(fdt->full_fds_bits,
maxbit, bitbit) is maxbit. This return value, multiplied by BITS_PER_LONG,
gives the value of bitbit, which can never be greater than maxfd, it can
only be equal to maxfd at most, so the following check 'if (bitbit > maxfd)'
will never be true.

Moreover, when bitbit equals maxfd, it indicates that there are no unused
fds, and the function can directly return.

Fix this check.

Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>
Link: https://lore.kernel.org/r/20240529160656.209352-1-yuntao.wang@linux.dev
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index fdb84a64724b7..913f7d897d2fc 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -494,12 +494,12 @@ struct files_struct init_files = {
 
 static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
 {
-	unsigned int maxfd = fdt->max_fds;
+	unsigned int maxfd = fdt->max_fds; /* always multiple of BITS_PER_LONG */
 	unsigned int maxbit = maxfd / BITS_PER_LONG;
 	unsigned int bitbit = start / BITS_PER_LONG;
 
 	bitbit = find_next_zero_bit(fdt->full_fds_bits, maxbit, bitbit) * BITS_PER_LONG;
-	if (bitbit > maxfd)
+	if (bitbit >= maxfd)
 		return maxfd;
 	if (bitbit > start)
 		start = bitbit;
-- 
2.43.0


