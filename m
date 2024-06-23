Return-Path: <linux-fsdevel+bounces-22212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3110D913B81
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 16:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD637B231A9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 14:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790F719E7C2;
	Sun, 23 Jun 2024 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSTOo2P9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AFC19DFB6;
	Sun, 23 Jun 2024 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150354; cv=none; b=nMg3PKvlzLojF34pUz+GinQ6CqeF3fei0FQzQK43JEnNCmkhd3YbSI8H+UrKNfHKaZ8crbyvaIqcmLGFljYzcaYsgJtr/MNRJenDQ+D+wfsh4YHZ+gGAL2sFGAd+d70s2NEwwjmP5vJAjygNBtK5jH4OZgcbtaPDbanczuNJQEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150354; c=relaxed/simple;
	bh=0DJhXcCP6xNT6lRJrJuYYfSYebrsuIwNcCS1nHAkHoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aX508BWuYd5ypqyyvg3g4CMYkQZxrKrQSGuS3ooeFqLY4PBxKHcVJeRWAsaO4Ml4OS1vf9R5PyiqTzl0Ec8yrSoscGzd/JGHM7ztkrd+ZIqSWfcEs8pwNSNZmVc2gaZEfqWhkIA4Tn7d6xles5Tdop9ilq19GfhQMqNOmICqFr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSTOo2P9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B44C32781;
	Sun, 23 Jun 2024 13:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150354;
	bh=0DJhXcCP6xNT6lRJrJuYYfSYebrsuIwNcCS1nHAkHoE=;
	h=From:To:Cc:Subject:Date:From;
	b=fSTOo2P9kB3ZplXCUZvv0ECR7gfwG0l/MD7Qz5BygHACwoK0kMvhlesfHRFQMxtao
	 F4m1HIlyNIPOqhCr8/UciwfiESbuVraDFhReR5hozPD76o1E+2O8Qnb0TmLzoc6Xds
	 eLVbM4X/xTW7GQv7F9KyTkIQ1ie522f/kciFrQVD9r5yRyChPzxN5elPlPSfCPFF7h
	 pkR4dV+6VVvrQSe2/p47sno6L3ZBygywe8QhOJDgAFBq7fR4TNUsmHD4bHI0yw1uBs
	 83SETrhewxljLnoM7YdqhRXS0tcF3+wA85vBjQwPHpJQ4CTNimtKD6vcye+W+NX+Zw
	 XzlNWsTxAfTcg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yuntao Wang <yuntao.wang@linux.dev>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 1/2] fs/file: fix the check in find_next_fd()
Date: Sun, 23 Jun 2024 09:45:51 -0400
Message-ID: <20240623134552.810231-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.316
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
index 928ba7b8df1e9..f5ba0e6f1a4c6 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -462,12 +462,12 @@ struct files_struct init_files = {
 
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


