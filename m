Return-Path: <linux-fsdevel+bounces-22203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 823AC913AFC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 15:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54841C20C52
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 13:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61461836C9;
	Sun, 23 Jun 2024 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5UtIyL+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E65183099;
	Sun, 23 Jun 2024 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150259; cv=none; b=Y4YoFINwp/I6C8unxfHdT3oc+OS7sPOsG5mY9vjBotCms8j75a/HHqDwvP+8+1mtgi66VI8Y6dDm4LrOGxmrcGBL9pa/jrd83ijAoFt2ncelssKHgMAfFkXets3iaGwD4Th9RX+rOMQqypCeJQjhY3uFcDr9e7RPi47JuoZTFc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150259; c=relaxed/simple;
	bh=h4HoumRLcnlemmdGi+U+5lsemQjRD/5NVqMgn8aVb4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7vJsI8dOHboX3G7YTvFAvkKpqoAqKCj2yGANz5Mlh1SeqywrkMy+Kz+ZmPEEDwBf2Q8NiWazmXR6Fu4WQTXBaP6WMkDl5GKKEYaj4urjSZUvpKfKlcsdYxlI+RaftOX68rPXzi1pKVdA1gWqkHvaB2/LMCTPhEBfn3ZO0AX5Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5UtIyL+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F12C4AF07;
	Sun, 23 Jun 2024 13:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150258;
	bh=h4HoumRLcnlemmdGi+U+5lsemQjRD/5NVqMgn8aVb4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e5UtIyL+bha9b4ewSrb6JO1Uxea2dFxTDAeABfLP2hdregIionEH4z/ajhTTDLoL5
	 iwR9yfj9ny4YavDiS+xmeYPH4mj8C57aNy2x3KwcI1F5buYyzkBLF9LxFOKVZaMRIg
	 Sqo++LHq+/AeYq4WHStaoaAJLTTclYVBarsrRjcsjqgxJwCcGdZV6BCRkm1kY5kaNA
	 KJWHetJK24THiRUZ79MOI69sTVbNY3qYFBZOqhUoV56ivgGkn6lpjrHPpbK41gYCWF
	 ng8STvfwaHpBCt+acXwtJPeyvv83/vzcEoTUBBV0HBWiFtLbfzARZIwTME0U6lCL86
	 /NzRUcrlCIZAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yuntao Wang <yuntao.wang@linux.dev>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 08/21] fs/file: fix the check in find_next_fd()
Date: Sun, 23 Jun 2024 09:43:41 -0400
Message-ID: <20240623134405.809025-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134405.809025-1-sashal@kernel.org>
References: <20240623134405.809025-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.6
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
index 3b683b9101d84..005841dd35977 100644
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


