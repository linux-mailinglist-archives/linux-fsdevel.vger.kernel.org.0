Return-Path: <linux-fsdevel+bounces-22209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58235913B6E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 15:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6161C20C61
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 13:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2E819CCFC;
	Sun, 23 Jun 2024 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouTFVk5X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C9919CCF0;
	Sun, 23 Jun 2024 13:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150340; cv=none; b=YblQ/ypHy8q9fy1UbOb+XvIDGBlbxELz2PTUsS2OAJ4ocGbCPZjCSDbRdNmJMCta+u8Sbm2rZRmLHmSYhWS8z0KiKfTfBk/qsbcwCldliXghA8vfCpBrqGWWpg4SxebRmJvV7m13o6EADf8VfIhpu01ZQwmPgoQtbN5ridsedDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150340; c=relaxed/simple;
	bh=UsRpr36vl0Hn4+gT8veKOAKuzW0WIfCNn+fd0PmuKa0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WDyW2jFNh/ebb1d7SQllU5nu7/LuioK91C/OsUxGbJFFZ0AimL0HZjK70YefGzyhgjNAGgzeiY+sF0p8ZRLXa+H0YDcgUS6NQ9acuUNIIB1+e/YFkLsxnW8pgzH5po0TDpDPy2TIfG7QxV+gj7pPRSx433bnAA/cYGl3/V0C70c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouTFVk5X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF232C2BD10;
	Sun, 23 Jun 2024 13:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150340;
	bh=UsRpr36vl0Hn4+gT8veKOAKuzW0WIfCNn+fd0PmuKa0=;
	h=From:To:Cc:Subject:Date:From;
	b=ouTFVk5X7lq7TMlQi1VB7mIF6lGIj7uADTCqolg8LsHRpHiltooN806XMeDPDUgIF
	 oCFWZKuFLQ/cgLpL+o/N8fzfIFv0EFEy4CCmSwuaDBTI9OanzbEFkOAd6kZlXOWSjR
	 69VfTe7qOGxIlEgPCUW+2SYIwvnYrTvYdqZCdq2GR4KhggchgEtsu3+W1jhWfWFXYw
	 ga5aZ8QzatWkWE4GKZoeJGtwoot0O+ryjNmWXwixXUHBeUSzK41XNo4o5q/2GYaJKP
	 QPG6lzKdoFJDewPRzNph8TD2uFoJnCMq1vFRQAjwrc1xEP8bV0b2RXy/hDAK2kWD0b
	 tYuJNW8NfNY7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yuntao Wang <yuntao.wang@linux.dev>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 1/3] fs/file: fix the check in find_next_fd()
Date: Sun, 23 Jun 2024 09:45:35 -0400
Message-ID: <20240623134538.810055-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.161
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
index 69a51d37b66d9..b46a4a725a0ef 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -481,12 +481,12 @@ struct files_struct init_files = {
 
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


