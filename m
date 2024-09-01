Return-Path: <linux-fsdevel+bounces-28176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E569496788F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 18:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8365DB21A4E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 16:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ABD1822F8;
	Sun,  1 Sep 2024 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uBovR2h7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C569518453F;
	Sun,  1 Sep 2024 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208385; cv=none; b=gPfZrn4p9VUpPAq0mr9VM9ScfyCpPF+GwVlTDWg67Hg+jOFiOaNdvz0+gAaaUF5/cjh0WlUDCSj9uIN++oNHelau+6nuZ/YblNxBI1mwG3hwQ5Ls1u9uGMhOKbeB49BpliIUoHsyDs5arWDsljUALEML+syJYAXzFh+gMcUjyXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208385; c=relaxed/simple;
	bh=oMm9PBHYo4bF6r1c1EIdWZn1Vu/P8ue46SnQKcPFL3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EhZFq6cNdnkPit5MT4ucZNzreDR1g0aGtZF6pdByK8SIvfE1RVvn58WiO1jf+YotkfaVLC5OG0M1CWOb3RJbn8Bs381KSljJCakx9ZyGqWh3AJLeWBmBV6Yqs/2I2Gl4NqB2mYGRpdXmUCTnqoRYNJE5u5t6gIDSe3TaxVDDbU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uBovR2h7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A19C4CEC9;
	Sun,  1 Sep 2024 16:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725208385;
	bh=oMm9PBHYo4bF6r1c1EIdWZn1Vu/P8ue46SnQKcPFL3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uBovR2h7eTc61ch1Qu4mYBjE96/qLoE3/ezQLNe25KQ8U6k+1FAmeRyHXlmDMw28z
	 On+E5ABS/fZiYqo/oBUsD64HzPq3WE0DmjC6Xa0O8CRkrx4ChLkXmqPD7V/XTz7UsL
	 QOYo8kkpVLtgYl3MJpd4PUIObDiFs9RHmmiK6zoM=
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
Subject: [PATCH 6.10 067/149] netfs: Fix netfs_release_folio() to say no if folio dirty
Date: Sun,  1 Sep 2024 18:16:18 +0200
Message-ID: <20240901160819.986674115@linuxfoundation.org>
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

[ Upstream commit 7dfc8f0c6144c290dbeb01835a67e81b34dda8cd ]

Fix netfs_release_folio() to say no (ie. return false) if the folio is
dirty (analogous with iomap's behaviour).  Without this, it will say yes to
the release of a dirty page by split_huge_page_to_list_to_order(), which
will result in the loss of untruncated data in the folio.

Without this, the generic/075 and generic/112 xfstests (both fsx-based
tests) fail with minimum folio size patches applied[1].

Fixes: c1ec4d7c2e13 ("netfs: Provide invalidate_folio and release_folio calls")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20240815090849.972355-1-kernel@pankajraghav.com/ [1]
Link: https://lore.kernel.org/r/20240823200819.532106-4-dhowells@redhat.com
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
 fs/netfs/misc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 607a1972f4563..21acf4b092a46 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -161,6 +161,9 @@ bool netfs_release_folio(struct folio *folio, gfp_t gfp)
 	struct netfs_inode *ctx = netfs_inode(folio_inode(folio));
 	unsigned long long end;
 
+	if (folio_test_dirty(folio))
+		return false;
+
 	end = folio_pos(folio) + folio_size(folio);
 	if (end > ctx->zero_point)
 		ctx->zero_point = end;
-- 
2.43.0




