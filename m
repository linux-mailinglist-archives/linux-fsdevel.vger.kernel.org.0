Return-Path: <linux-fsdevel+bounces-25637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10CC94E702
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 08:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADFBE282DC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 06:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE60A1547DF;
	Mon, 12 Aug 2024 06:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aHWmBW19"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8031509A0
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 06:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445071; cv=none; b=DxFXviJTPL1fpfZ3/RqSJtKAIPMAAQPwABIyyFVWpb+O1v6CxtgENAJcuK4zzL6MpCC8NvBr8CwACMP3Y5yJDV81Q42fFdhjuaAE+Kk8PuU+nyN9GcUNHxOScm3m6tMzyZWnf/rNlTAhbtFof0WOoGhP0Qv77ChwlsSHId4b0lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445071; c=relaxed/simple;
	bh=GfAxYkVzP3oh0/dqR9BmRPj3fO6ymq/f7y+BqaErNFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRU8KV6dHkw6M0Khx/pv8iwoTjxYRKb0D1dRhpouxvJ9lv1cZ7Cl6DyvmWWutfLAzjsVisW0DJ0hbi5EyzpY9YcHejk4Jh0qUG0CqJay3TXWKBhQK6C66X+GLazncZQ/CSe7yXvqo7PWX0bx1as62DgC6Ft3z5a+45O3TGNneK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aHWmBW19; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=tWLyQ/FDhiruX0I1ocFEjjB2P486jShUsYpSsgby//E=; b=aHWmBW19SSLfjN+DSDMnlNRiry
	sNzHx8AOW03LHLuVckYncHYBdYmdF14cN5FW9muo2MgeF1IKX/qFc2I4xaYMDiBAeInY5nyXmiWAo
	mgih6RNtWC5ND2ya1/l8ovNkCJYFSKd85V4YmExEyfWKfgt4OiQrSlD3YbPGHJ4xfruqiIwC9300A
	p95pwrVXqzXp3EBcnpHJswJuUGF/k/hmzmFy4NzIcPQUEuq6FFnsVmz2yE8otEMxp3Tlbnl+l7kvF
	BFgKgHtUGGIZF4unCbAuEFub/v8WEPYtB4BwU/Ys2cLjSnm13bGW8ncgEf8BAireU70bFbpb+IxRY
	DKhjVttg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sdOn6-000000010Ud-10Mw;
	Mon, 12 Aug 2024 06:44:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/11] sane_fdtable_size(): don't bother looking at descriptors we are not going to copy
Date: Mon, 12 Aug 2024 07:44:22 +0100
Message-ID: <20240812064427.240190-6-viro@zeniv.linux.org.uk>
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

when given a max_fds argument lower than that current size (that
can happen when called from close_range(..., CLOSE_RANGE_UNSHARE)),
we can ignore all descriptors >= max_fds.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index fbcd3da46109..894bd18241b5 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -272,20 +272,6 @@ static inline bool fd_is_open(unsigned int fd, const struct fdtable *fdt)
 	return test_bit(fd, fdt->open_fds);
 }
 
-static unsigned int count_open_files(struct fdtable *fdt)
-{
-	unsigned int size = fdt->max_fds;
-	unsigned int i;
-
-	/* Find the last open fd */
-	for (i = size / BITS_PER_LONG; i > 0; ) {
-		if (fdt->open_fds[--i])
-			break;
-	}
-	i = (i + 1) * BITS_PER_LONG;
-	return i;
-}
-
 /*
  * Note that a sane fdtable size always has to be a multiple of
  * BITS_PER_LONG, since we have bitmaps that are sized by this.
@@ -297,16 +283,33 @@ static unsigned int count_open_files(struct fdtable *fdt)
  *
  * Rather than make close_range() have to worry about this,
  * just make that BITS_PER_LONG alignment be part of a sane
- * fdtable size. Becuase that's really what it is.
+ * fdtable size. Because that's really what it is.
  */
 static unsigned int sane_fdtable_size(struct fdtable *fdt, unsigned int max_fds)
 {
-	unsigned int count;
+	const unsigned int min_words = BITS_TO_LONGS(NR_OPEN_DEFAULT);  // 1
+	unsigned long mask;
+	unsigned int words;
+
+	if (max_fds > fdt->max_fds)
+		max_fds = fdt->max_fds;
+
+	if (max_fds == NR_OPEN_DEFAULT)
+		return NR_OPEN_DEFAULT;
+
+	/*
+	 * What follows is a simplified find_last_bit().  There's no point
+	 * finding exact last bit, when we are going to round it up anyway.
+	 */
+	words = BITS_TO_LONGS(max_fds);
+	mask = BITMAP_LAST_WORD_MASK(max_fds);
+
+	while (words > min_words && !(fdt->open_fds[words - 1] & mask)) {
+		mask = ~0UL;
+		words--;
+	}
 
-	count = count_open_files(fdt);
-	if (max_fds < NR_OPEN_DEFAULT)
-		max_fds = NR_OPEN_DEFAULT;
-	return ALIGN(min(count, max_fds), BITS_PER_LONG);
+	return words * BITS_PER_LONG;
 }
 
 /*
-- 
2.39.2


