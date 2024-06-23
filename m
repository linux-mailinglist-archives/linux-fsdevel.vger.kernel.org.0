Return-Path: <linux-fsdevel+bounces-22205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C951D913B37
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 15:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8609728157D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 13:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906331922E9;
	Sun, 23 Jun 2024 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4fwikI+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D641922C0;
	Sun, 23 Jun 2024 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150301; cv=none; b=YLtRcVlNdICCMRxBZTFqB12FSz/933OZ2hOAGtqfaf57ZPuPfzkN5eKpXYPVszBKKaQvOqdahV9IgnhvZl6ZzHiI+v81zKdk7oRHdgEOd8HVDQ6FRUdI2CHJSbDwnxdd94bxAs5VG6PbKfyJpb6S309Maj825NrjHn7PHtZ35Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150301; c=relaxed/simple;
	bh=7FqicvDUYKPGZolfw+2sfBKMu8QQLpoAgoKBu9pkmws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4GcfyCuB5tdvKLtVCUVpqC7V6KhZ7cTUHZLwc5Oy5hApOntELexmYSAbFS/YpKxwmqbHXcv7TxM2Csi9Bn2IGX+5CLzAs2IcvywTH8xP9wmgp0o/n9GS6ouYMdADS9SxVMmP0IBHPnxhyxi3jWq5DtQofneDIvYpjLyX2hVJ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4fwikI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C718FC2BD10;
	Sun, 23 Jun 2024 13:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150301;
	bh=7FqicvDUYKPGZolfw+2sfBKMu8QQLpoAgoKBu9pkmws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K4fwikI+vQ8IVZ9d2cngYy+NmQnTU9qFLPMfd3T7Kd8lY/++eANN2PEUVOlRhkp3V
	 9f+iQHPXxavKPNpyvbTcjUiHwzV7VBO5MnwZlSAlnQyuQslXVJF4q4GasEOhviyWOa
	 zrZbdX8L9wHymwIgWKjbM/65o4PnsRfnwX3/8AAQ+0V14SvRCH2/Q0Su9px8Cut/XD
	 Ee25nIeJCXdr+eZaF1a2B31fy/Wd4anqkzHfVOLzq/HnXw+e9Hcl2q0jPhx28+WkuP
	 +8x1ERK2jv4mmWPIri6/xveFTEJlMCu+Tvo/hc5ggCc8HbMg8fksEaD0MK/a5baITk
	 Mjvg22RZlwmeg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yuntao Wang <yuntao.wang@linux.dev>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/16] fs/file: fix the check in find_next_fd()
Date: Sun, 23 Jun 2024 09:44:37 -0400
Message-ID: <20240623134448.809470-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134448.809470-1-sashal@kernel.org>
References: <20240623134448.809470-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.35
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
index 3e4a4dfa38fca..a815f6eddc511 100644
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


