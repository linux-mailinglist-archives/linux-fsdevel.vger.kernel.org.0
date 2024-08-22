Return-Path: <linux-fsdevel+bounces-26583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1897A95A8B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 02:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54B961C21D10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 00:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6EE8F5A;
	Thu, 22 Aug 2024 00:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SsLNgAwC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBC54C99
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286174; cv=none; b=ZoA45i2jJ3nnsxpuoHMl1XOXmPV5V3IR72vnG23+dORxJk0CXYR47lKmYAYRyOWTkRl6N0NcB/TLuUMKQfpIFYd+Bym/guImgwTnqsZi5yoO+g55h/XJ9JRFe4/CWF0gl678T9d+W6TzIe//fJiQxTXzHWATe1sTaO6q5A4bG9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286174; c=relaxed/simple;
	bh=sz8Zvd1mW9BoOW3/TxhsyNUzOS2fLPXsoGCH9dZupCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCHCw1wlvJ+JZbfC4oDXyc0S7rBbfXqWEMQVJu6381eT3s++k+Sv436xKUBsCwI/3W80Sonbiwo8fIURvDOh9HGeV1Gm5Bs8b7iI8202NSS+hmsK5UCWsaH+DNGNOGSLPXEXD86bb28BSpkkKrD5Q9Wx7OmNtarrO4Qzz4oJdwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SsLNgAwC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YCkio2xXve4i4xl2Y3axx1EiF0M1muVH8w/CpravqSA=; b=SsLNgAwCqzgxmnixE+EVtst6w4
	0H9AJqStlV5F2sy2cQS05SCzRD2SEweNYjUoRWx943DdouvDAf8Z8RBp9o8Gz8KIIkLlG4orZT0ro
	feJG812MRQHEkHhkMF7qRx2SWqEM2QlI8Qs/YY495Ne85AVZ9DRt6Kg/PIcLrs6v603TvbCCoAPun
	mdYXS7Dxw7M8aWR2wdrrSpebeaCUB7QmFF7KKks2dzCvtRGMPQK7mZV8okn3V4exERMpL4hcUaLuo
	FeYXr/kmTvDK5oUW7W8YcubWB9itgSbcX8mjX9VtYlgJ4+jk8KbrjyGXRSLgMeLPJeQ4cfkUg86M2
	M2g49RaQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sgvbH-00000003w84-10Zk;
	Thu, 22 Aug 2024 00:22:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 08/12] fs/file.c: add fast path in find_next_fd()
Date: Thu, 22 Aug 2024 01:22:46 +0100
Message-ID: <20240822002250.938396-8-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822002250.938396-1-viro@zeniv.linux.org.uk>
References: <20240822002012.GM504335@ZenIV>
 <20240822002250.938396-1-viro@zeniv.linux.org.uk>
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
index d6f5add1a786..b94ee8270867 100644
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
2.39.2


