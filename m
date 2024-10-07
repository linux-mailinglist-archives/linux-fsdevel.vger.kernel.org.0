Return-Path: <linux-fsdevel+bounces-31229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ED699353B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 19:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C070C1F243E3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 17:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A8D1DDA31;
	Mon,  7 Oct 2024 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uAN3fh/b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67BD1DDA13
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323042; cv=none; b=BZxtsPL16JqB4M4wIT2EkDBaz1kj9pcjufw5cUll59lJS+NqUGqhOUhnUAki/H58XrJpeYzV3b0zLrHudyuUOJi4g6BmpAyHjNfgh/JBp/8J7tt9ORQfFAmkOmM7PXHs1YVlcqJco9rio0J5IHo3In6YRT7FJoaQHv6it56kEaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323042; c=relaxed/simple;
	bh=gXkenfMs4rzWxuuBtRzdzoi2LTqPpSkdlUOP+YzYVvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L23T37uCOcc3GNPowyKN9qxEXv0rqCT4lE0vnRUnZ7nUjmwJeT8OszCTigdlmnXUvwYIOz1+572aOGNhGztKjqZRUpvocsx/sti69U2vKOjL8KJPR3YVQ7gMe0eEyYlqEh1z5gDI/f3c3fa6zW/+B+wSNdCd1CTczWsI62AIhuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uAN3fh/b; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GdmgQ0oG+YQdN1Dt55diT1apc2kl8CAo9m7YP5Hm0g0=; b=uAN3fh/bvSHwn2sAJE8oLtuyqa
	s5nSOxs2kR5nBGmTFCfzQK9v2m9HKtb+ypxO3L+2XD7g5NAK1cj9lLygk7f44YAy4zXz3x5Q1U1nk
	EslHfZG4gknjM89ShioAaQ6/+8k0MrFK47SrzmTu6uiF4QzW69h48q84WGXB+YvK2eKc9QO+r2/MP
	4hFrSQ39wDdcLroNOXN1fpi33dLCUmc3iECNaY2c44dSrb/SmqFAsUhlSeqDzGLbf3Dv38vVwRgAe
	7utzPnJdeE9A3EipY/xYteVVlQXJ6hoJImiqxmDprYe6Od8XM8bXWBVD5JyPdiQuo6guhQd4tssos
	PArBeWeg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxrm3-00000001f3U-1m7P;
	Mon, 07 Oct 2024 17:43:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org
Subject: [PATCH v3 07/11] fs/file.c: add fast path in find_next_fd()
Date: Mon,  7 Oct 2024 18:43:54 +0100
Message-ID: <20241007174358.396114-7-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007174358.396114-1-viro@zeniv.linux.org.uk>
References: <20241007173912.GR4017910@ZenIV>
 <20241007174358.396114-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

From: Yu Ma <yu.ma@intel.com>

Skip 2-levels searching via find_next_zero_bit() when there is free slot in the
word contains next_fd, as:
(1) next_fd indicates the lower bound for the first free fd.
(2) There is fast path inside of find_next_zero_bit() when size<=64 to speed up
searching.
(3) After fdt is expanded (the bitmap size doubled for each time of expansion),
it would never be shrunk. The search size increases but there are few open fds
available here.

This fast path is proposed by Mateusz Guzik <mjguzik@gmail.com>, and agreed by
Jan Kara <jack@suse.cz>, which is more generic and scalable than previous
versions. And on top of patch 1 and 2, it improves pts/blogbench-1.1.0 read by
8% and write by 4% on Intel ICX 160 cores configuration with v6.10-rc7.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Yu Ma <yu.ma@intel.com>
Link: https://lore.kernel.org/r/20240717145018.3972922-4-yu.ma@intel.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/file.c b/fs/file.c
index 36c5089812f5..236d8bbadb0e 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -472,6 +472,15 @@ static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
 	unsigned int maxfd = fdt->max_fds; /* always multiple of BITS_PER_LONG */
 	unsigned int maxbit = maxfd / BITS_PER_LONG;
 	unsigned int bitbit = start / BITS_PER_LONG;
+	unsigned int bit;
+
+	/*
+	 * Try to avoid looking at the second level bitmap
+	 */
+	bit = find_next_zero_bit(&fdt->open_fds[bitbit], BITS_PER_LONG,
+				 start & (BITS_PER_LONG - 1));
+	if (bit < BITS_PER_LONG)
+		return bit + bitbit * BITS_PER_LONG;
 
 	bitbit = find_next_zero_bit(fdt->full_fds_bits, maxbit, bitbit) * BITS_PER_LONG;
 	if (bitbit >= maxfd)
-- 
2.39.5


