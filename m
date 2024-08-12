Return-Path: <linux-fsdevel+bounces-25641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEF794E705
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 08:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8A271F2270E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 06:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE3615CD78;
	Mon, 12 Aug 2024 06:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cOj5BjfG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4BA152176
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 06:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445071; cv=none; b=TNfVL3M4eD+6Z3OMLpjGQLApCkBMkKmYMuzRxpQ+Air4Ouuhs4/AeYBCYxXICWoOD4CiSzHxyK5PIL5JnJ/jqfS7VNSndpfFksW/FEwMZxGo/fdqn6KJB8pC8Y6N0GDDbaIDfLEsQYkpAQAJ5Y+xpo876g8IgQ+otTEBchiS20o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445071; c=relaxed/simple;
	bh=yKsBmsESsGcdPNhrpQn9NF43ra4r96XbhDcVtqpIWjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+qQZVTM1wPsevC+u7FuTrwFJuOXDgC65ewfAIFs3icKYBAmnUsmJGH0PoLGYWpQVqjqpE0rD+ZcOg92h+907AcXRx851ewTcxfjbTYCOywKURU80VzLPcCOR4X0fT0p1boY2Jpwea3jotglYAHbjsUkW1lQHbJIHLqkPiKaBp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cOj5BjfG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=a/B+4NoClzkcJyCwlXuszeYtFek+zdw7ynoQgbc1yRo=; b=cOj5BjfG5zf1vXTaOn0iQUn/8T
	Nem2ZYIzEMH1mhNINbZ+HwSZO7ZuaFrSzDeK2vli/hKHPxtY6slAEn8sZoDV6tV+2XJgHXNjI0Xt4
	pYxtHNV8fNO+xgYwmLmHFfpFsM6uMA2AZHITZQu8kJDrdsKtbVSbd/ObB0bM210xl5ahhP8Wip2x2
	LroaFCzyPy+ds9ic0MckI7WuZza2PDt+7Td5jqDlBoyRMy023yg80lBnTLzWW7QRr5Gmn4K8NEMWj
	KQQ5v1uOH0Uk8qwbWP4192RZUMk3DVzq//eXVh1etghDL7o8VxHbDg32kyCdgr1qrIYqw/TW8VmRT
	z3vzzTRQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sdOn6-000000010Uy-2qNr;
	Mon, 12 Aug 2024 06:44:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/11] fs/file.c: add fast path in find_next_fd()
Date: Mon, 12 Aug 2024 07:44:25 +0100
Message-ID: <20240812064427.240190-9-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812064427.240190-1-viro@zeniv.linux.org.uk>
References: <20240812064214.GH13701@ZenIV>
 <20240812064427.240190-1-viro@zeniv.linux.org.uk>
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
index 0340c811b22a..1ee85e061ade 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -490,6 +490,15 @@ static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
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


