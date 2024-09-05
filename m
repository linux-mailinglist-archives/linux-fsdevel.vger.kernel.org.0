Return-Path: <linux-fsdevel+bounces-28710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7637B96D471
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 11:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A661F24328
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 09:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6423C18732F;
	Thu,  5 Sep 2024 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AJWFPVVW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95AA1990C2;
	Thu,  5 Sep 2024 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529914; cv=none; b=IrfGlG9w6FUji15x9YOFuImanesa+g6XCEgqNhcs9rskpGmhRcjgxmI6j8Bgz76tjeJFS3m/PnHjGNfSDkClxbs0mgetRT+8Xf/ic09oEuLW1ZzC/euNUg5RIvcojWaQ/WXeTlVvxoqoHvhoTu/AWBFs11JcVLyZYi6fsMbAfVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529914; c=relaxed/simple;
	bh=/eCNOC97u0BQscr+7Vs8bpxdBwn4RYq/sinJaLLMzGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dz9/HgPWaTZwGJtwGCfRiltZqw+Kth+dtFbZD3z27uMvAgwNKduGxNkZ96/pPCwbq4WNxk5pNpEE1kL9f2xz9LCRDHRB5Yt/SEXn+jkhOEGObRUgwPefgNauZQum2MIhuhFdefuFnbLAp23JfMURvGUTu2qH4GIWLgkJ9hz3L84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AJWFPVVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A9BC4CEC3;
	Thu,  5 Sep 2024 09:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725529914;
	bh=/eCNOC97u0BQscr+7Vs8bpxdBwn4RYq/sinJaLLMzGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AJWFPVVWLcHfpsizWbz8T8Hfn013dySUHGfmkPdRx8TBnDyA11sgF+9RTkLBDt/Ki
	 v2w/TZjyRfvlwahqn3BqphFd5Z223u+pD0OGvkN9HjH/jR8lXfaICYuHWl5T2UxI00
	 C8fDdZ479HGvyBsc8jH0SJhs2SZbwEi4CGKHRlcI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	netfs@lists.linux.dev,
	v9fs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	ceph-devel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	devel@lists.orangefs.org
Subject: [PATCH 6.10 181/184] mm: Fix filemap_invalidate_inode() to use invalidate_inode_pages2_range()
Date: Thu,  5 Sep 2024 11:41:34 +0200
Message-ID: <20240905093739.395261770@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905093732.239411633@linuxfoundation.org>
References: <20240905093732.239411633@linuxfoundation.org>
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

commit c26096ee0278c5e765009c5eee427bbafe6dc090 upstream.

Fix filemap_invalidate_inode() to use invalidate_inode_pages2_range()
rather than truncate_inode_pages_range().  The latter clears the
invalidated bit of a partial pages rather than discarding it entirely.
This causes copy_file_range() to fail on cifs because the partial pages at
either end of the destination range aren't evicted and reread, but rather
just partly cleared.

This causes generic/075 and generic/112 xfstests to fail.

Fixes: 74e797d79cf1 ("mm: Provide a means of invalidation without using launder_folio")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20240828210249.1078637-5-dhowells@redhat.com
cc: Matthew Wilcox <willy@infradead.org>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: Trond Myklebust <trond.myklebust@hammerspace.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Andrew Morton <akpm@linux-foundation.org>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Christian Brauner <brauner@kernel.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
cc: netfs@lists.linux.dev
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: ceph-devel@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: linux-nfs@vger.kernel.org
cc: devel@lists.orangefs.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/filemap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4221,7 +4221,7 @@ int filemap_invalidate_inode(struct inod
 	}
 
 	/* Wait for writeback to complete on all folios and discard. */
-	truncate_inode_pages_range(mapping, start, end);
+	invalidate_inode_pages2_range(mapping, start / PAGE_SIZE, end / PAGE_SIZE);
 
 unlock:
 	filemap_invalidate_unlock(mapping);



