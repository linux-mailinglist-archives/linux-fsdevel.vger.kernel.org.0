Return-Path: <linux-fsdevel+bounces-34472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DBC9C5C07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 16:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B502E1F22C33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 15:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7AD2010FB;
	Tue, 12 Nov 2024 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwTrH+G1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06270201011;
	Tue, 12 Nov 2024 15:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731425808; cv=none; b=pJK+WF8jEa/qBVBBUMTZbYzowks4ZMn+HYzC92p6k6mZCkekNTMWrC7TVCG+MwPKd8msyUKK5SS/ccztOB+ahF3iIn3v6+Ab5ALL4o+H4uKW9LE/0E5KR6ebq+A2uhu5Bx7q0t1UNnLzGhzwDWYJEO+m3IYVyxre7sA/ZUd6VbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731425808; c=relaxed/simple;
	bh=kMlXDmOWUKzRt5dKs6VeajTwf8T192AMUztsAE4cSR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bcgKb6pIdT6Hxtwbt1nXx2kF9I9vkfaatcNqak0TOcdQm+cbqZKOxopQsxjfT9BLFSReaoRSbXBDe//UqohrkW7ZmyPNGKHyqSDAs/bFqa4Lv0241ps7lS53iMvEgQ1ZddsxJ4ldbO6je2P401TJ6sPoook95t8/lEhYP4CWeCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwTrH+G1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C4DC4CECD;
	Tue, 12 Nov 2024 15:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731425807;
	bh=kMlXDmOWUKzRt5dKs6VeajTwf8T192AMUztsAE4cSR8=;
	h=From:To:Cc:Subject:Date:From;
	b=DwTrH+G1idF+vu7kt7bAW1UZTwhhr3WIfAwE5SNwKz1lnxMqjesjq5NlBXp9Znc1+
	 3iGSGKU1dy2tA1PI/X3oPKYlvXAYGl0yzdDq4+egcpM6UMUr2tw4mai6Fa3U+lR7kE
	 VeabQ/Pt/uq+ZfcQp1PxYKF9vFWfd31vQTUJFNNSJDRJXgIcBsB/2+H+VBw1k0gF3R
	 tbwtRdDBgWyRTh2NKAzfVMfDdnd0Ro4ks1sGXImP2HshKrotiRJQiJsqAqD71nDqNY
	 4x3/x0yBc5jfk4aFb4zQ0yDDNnLpHsQyeV8Y6l9x0q8FbtFXu6Jed3Oo6kWDVREswz
	 Dwj93il8qlMYw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] iov_iter: fix copy_page_from_iter_atomic() for highmem
Date: Tue, 12 Nov 2024 16:36:11 +0100
Message-ID: <20241112-geregelt-hirte-ab810337e3c0@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2199; i=brauner@kernel.org; h=from:subject:message-id; bh=P/6/Ri9l3HPEWisxKk3LYAQbScVl0oRh/0ntUpxUuS4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQbl75bZZCYctHTWyigp0N2yxEuSb8PSuKb/nBKCGVMM njx8+/njlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImw5zL898lkaTw/5Un+y0OH p6y2NP84fcPtnhPJMjY3bXrzOIumxjIybNjSlt1n9qRim+0nxyn61QmMXG7nM4RMPVktb8/yYVz MBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

When fixing copy_page_from_iter_atomic() in c749d9b7ebbc ("iov_iter: fix
copy_page_from_iter_atomic() if KMAP_LOCAL_FORCE_MAP") the check for
PageHighMem() got moved out of the loop. If copy_page_from_iter_atomic()
crosses page boundaries it will use a stale PageHighMem() check for an
earlier page.

Fixes: 908a1ad89466 ("iov_iter: Handle compound highmem pages in copy_page_from_iter_atomic()")
Fixes: c749d9b7ebbc ("iov_iter: fix copy_page_from_iter_atomic() if KMAP_LOCAL_FORCE_MAP")
Cc: stable@vger.kernel.org
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Hey Linus,

I think the original fix was buggy but then again my knowledge of
highmem isn't particularly detailed. Compile tested only. If correct, I
would ask you to please apply it directly.

Thanks!
Christian
---
 lib/iov_iter.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 908e75a28d90..e90a5ababb11 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -457,12 +457,16 @@ size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
 }
 EXPORT_SYMBOL(iov_iter_zero);
 
+static __always_inline bool iter_atomic_uses_kmap(struct page *page)
+{
+	return IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP) ||
+	       PageHighMem(page);
+}
+
 size_t copy_page_from_iter_atomic(struct page *page, size_t offset,
 		size_t bytes, struct iov_iter *i)
 {
 	size_t n, copied = 0;
-	bool uses_kmap = IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP) ||
-			 PageHighMem(page);
 
 	if (!page_copy_sane(page, offset, bytes))
 		return 0;
@@ -473,7 +477,7 @@ size_t copy_page_from_iter_atomic(struct page *page, size_t offset,
 		char *p;
 
 		n = bytes - copied;
-		if (uses_kmap) {
+		if (iter_atomic_uses_kmap(page)) {
 			page += offset / PAGE_SIZE;
 			offset %= PAGE_SIZE;
 			n = min_t(size_t, n, PAGE_SIZE - offset);
@@ -484,7 +488,7 @@ size_t copy_page_from_iter_atomic(struct page *page, size_t offset,
 		kunmap_atomic(p);
 		copied += n;
 		offset += n;
-	} while (uses_kmap && copied != bytes && n > 0);
+	} while (iter_atomic_uses_kmap(page) && copied != bytes && n > 0);
 
 	return copied;
 }
-- 
2.45.2


