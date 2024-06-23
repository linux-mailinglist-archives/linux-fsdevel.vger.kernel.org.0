Return-Path: <linux-fsdevel+bounces-22207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41507913B5D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 15:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBFFA1F21A6A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 13:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F3319A2BD;
	Sun, 23 Jun 2024 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqra/tYZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D74D19A29E;
	Sun, 23 Jun 2024 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150329; cv=none; b=QauLDRZpFym7deyXKd4cIgSIh3j93MYl8KGT/IzJr2CtFfHUkGCVyV37O6H7V/NMlz4h6pc7sPn0UrKsCeXSOZAcGV53P7BGm96pBkvq/NgNdCmQcz11ezhFokSazCoPQyaP0zKnStiEnTVSbg2XQZXdNeqo63z3nB3kGFwxQaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150329; c=relaxed/simple;
	bh=xRYwX0A8P+3xrPF560IY5kbgx5sO63zGx3/Hh1VbJuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6kQI3uuRB3xh6a8rxenEZmssNk8U64OBgmB9KxlWysSruin96WMMQTw5dQSIka05IzdIvyjGX0WoP1WSDCpmAA5/QoEI7RHZK1OO3iktA8Kk9fh84yrzE+WLAgwp8czogsbkludeYevKUO+9mA2Y+q52NQ18QyXTYC8YUzlbWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqra/tYZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943E8C2BD10;
	Sun, 23 Jun 2024 13:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150329;
	bh=xRYwX0A8P+3xrPF560IY5kbgx5sO63zGx3/Hh1VbJuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aqra/tYZ5teRp02YS1soCF+3LGMatTYZPmu1wr0fL+8hEpDlkACW+AXcYpYmM9ntW
	 t4KiqCvOSdDOgJ2Ss1801rHjldX/DgeIf6FVLbOn8mowSAAZMKAyz4AB+hRJQ8KWXD
	 0MBue8iyRncOdDGPtktLDL5yw/agR3gg0J0KpZNXEGfiHfbRFDnWT3AoP7yv+zhbm0
	 X19i3udo7U2RTh+r4VofYhySOZPhSDiKHblyFtGLtqcGA8hiRr21ATZenzSSl9mhJD
	 ri3OmDwpud0nOzITkK+Ks8R9DhQ9vJMH36/eAliCVUnkc4NwRM/0z7b9SGhsnsI546
	 idXbKWwkaY5RA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yuntao Wang <yuntao.wang@linux.dev>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 07/12] fs/file: fix the check in find_next_fd()
Date: Sun, 23 Jun 2024 09:45:10 -0400
Message-ID: <20240623134518.809802-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134518.809802-1-sashal@kernel.org>
References: <20240623134518.809802-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.95
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
index dbca26ef7a01a..69386c2e37c50 100644
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


