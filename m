Return-Path: <linux-fsdevel+bounces-28174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02465967887
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 18:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2D541F218DE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 16:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61DC181CE1;
	Sun,  1 Sep 2024 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C2K7dAMo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDC21C68C;
	Sun,  1 Sep 2024 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208379; cv=none; b=T0i/LqPcBFKUQtgMLceKyLwqvHwSm5B4ABhkQVglbcO3KJmuQaIN3A11iCCG9P85mbtEmRPZ6JqEnIh2ZIBxUL5tsDcGkosiZiuSafHOwjigQsW068Ruhf7Ss4rR92thsZlcBGYkPyo3j+lJlxe7KhHmqfBMwEHxrCUZuP2VRnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208379; c=relaxed/simple;
	bh=UIALWQ3/FCQWvFNh2VqExjMGio+ih0PHhKLoO5IhNRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mg2mcNTFWqpIJf2qprGK4FvJ2ujFxUChfC3mkitOei7rrU6Mhq2woytEzhDC5m/QJXzjw3Cqg6v4QHUL3oeFFvsF9nQPKPrQHvyRjJvQJGXzYpxfcKn/W7xJrb2NJBhZ0ItHL0AeXhAZyqjcrGgtevQSROeTyGRw3BEkclDJWnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C2K7dAMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9A5C4CEC3;
	Sun,  1 Sep 2024 16:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725208379;
	bh=UIALWQ3/FCQWvFNh2VqExjMGio+ih0PHhKLoO5IhNRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C2K7dAMof9gKHeZ96HH3T/jNjriTjp+Up1X7jjwt1eRaLpDbNxE5gwJfkFtEELmOo
	 Pc9i2TRaykVg2oVK+HUnPlzdV7mfcah1/6TldRIwxBMVkWDk4JYFmf+czFKeIAq6by
	 Ig5Zn+YAUs4SDSMuKRoGEAWyzcIRgN10yRSfv4kU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Jeff Layton <jlayton@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	netfs@lists.linux.dev,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 065/149] mm: Fix missing folio invalidation calls during truncation
Date: Sun,  1 Sep 2024 18:16:16 +0200
Message-ID: <20240901160819.911773395@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160817.461957599@linuxfoundation.org>
References: <20240901160817.461957599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 0aa2e1b2fb7a75aa4b5b4347055ccfea6f091769 ]

When AS_RELEASE_ALWAYS is set on a mapping, the ->release_folio() and
->invalidate_folio() calls should be invoked even if PG_private and
PG_private_2 aren't set.  This is used by netfslib to keep track of the
point above which reads can be skipped in favour of just zeroing pagecache
locally.

There are a couple of places in truncation in which invalidation is only
called when folio_has_private() is true.  Fix these to check
folio_needs_release() instead.

Without this, the generic/075 and generic/112 xfstests (both fsx-based
tests) fail with minimum folio size patches applied[1].

Fixes: b4fa966f03b7 ("mm, netfs, fscache: stop read optimisation when folio removed from pagecache")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20240815090849.972355-1-kernel@pankajraghav.com/ [1]
Link: https://lore.kernel.org/r/20240823200819.532106-2-dhowells@redhat.com
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: Pankaj Raghav <p.raghav@samsung.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/truncate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index e99085bf3d34d..a2af7f088407f 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -174,7 +174,7 @@ static void truncate_cleanup_folio(struct folio *folio)
 	if (folio_mapped(folio))
 		unmap_mapping_folio(folio);
 
-	if (folio_has_private(folio))
+	if (folio_needs_release(folio))
 		folio_invalidate(folio, 0, folio_size(folio));
 
 	/*
@@ -235,7 +235,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 	 */
 	folio_zero_range(folio, offset, length);
 
-	if (folio_has_private(folio))
+	if (folio_needs_release(folio))
 		folio_invalidate(folio, offset, length);
 	if (!folio_test_large(folio))
 		return true;
-- 
2.43.0




