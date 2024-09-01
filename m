Return-Path: <linux-fsdevel+bounces-28173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD9D96784D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 18:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A511F216A4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 16:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9E9184531;
	Sun,  1 Sep 2024 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2V5O9nqs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA018537FF;
	Sun,  1 Sep 2024 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208215; cv=none; b=dQiGZmQJbvUcIxdGz9wfBYzteXAwrU0iVoiCb/42O8hWzpAS35fy727IE2XoXHbDNO21sJuDHV/jCpyFhOVAgEwEGUT/T5Fo1GUkhAy9Uft7eRFbfWzSdEJxqOEUlQc01duJylFFIrLBSTqrnZ2/2NB04GzlSKiL+aCktqIT13Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208215; c=relaxed/simple;
	bh=xhn+MF3hqGrLXb1LRI3b0c5JVKjjLvNvVZqlphT19lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSyeIomYRCk2C4X6h+JJsIcoX+pV9ljv0iA7FBoJDS07qwuNdKQGlgjsfV21zD6qviY/TtTbpmKBtmW12WB7DKMBNL+uzI/EWYXE+EFwx+HNeH2ejxDZehL16PsewYRubibysdtr7e8VKEU8Dy0TpeOLiQhn6Cii4SwNJYRvq+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2V5O9nqs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31360C4CEC3;
	Sun,  1 Sep 2024 16:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725208214;
	bh=xhn+MF3hqGrLXb1LRI3b0c5JVKjjLvNvVZqlphT19lI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2V5O9nqsFDR57FvnegInxeAuc83cHU0ZNA4UjPv3TDvSaxBQXOJL5oCBdZE8MzIJI
	 KV6BtVKD9PM/Zn1St6GUfqCAQ+per85uqgYUzh+2ZTIVlK/RJLGb4UeQA5tepxGe+M
	 y0Py8J/fmH4h9iCzTfDqJkr8iH/u87y2rEojN2Hw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	ceph-devel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.10 014/149] netfs, ceph: Partially revert "netfs: Replace PG_fscache by setting folio->private and marking dirty"
Date: Sun,  1 Sep 2024 18:15:25 +0200
Message-ID: <20240901160818.003327412@linuxfoundation.org>
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

commit 92764e8822d4e7f8efb5ad959fac195a7f8ea0c6 upstream.

This partially reverts commit 2ff1e97587f4d398686f52c07afde3faf3da4e5c.

In addition to reverting the removal of PG_private_2 wrangling from the
buffered read code[1][2], the removal of the waits for PG_private_2 from
netfs_release_folio() and netfs_invalidate_folio() need reverting too.

It also adds a wait into ceph_evict_inode() to wait for netfs read and
copy-to-cache ops to complete.

Fixes: 2ff1e97587f4 ("netfs: Replace PG_fscache by setting folio->private and marking dirty")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/3575457.1722355300@warthog.procyon.org.uk [1]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8e5ced7804cb9184c4a23f8054551240562a8eda [2]
Link: https://lore.kernel.org/r/20240814203850.2240469-2-dhowells@redhat.com
cc: Max Kellermann <max.kellermann@ionos.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Xiubo Li <xiubli@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: ceph-devel@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ceph/inode.c |    1 +
 fs/netfs/misc.c |    7 +++++++
 2 files changed, 8 insertions(+)

--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -697,6 +697,7 @@ void ceph_evict_inode(struct inode *inod
 
 	percpu_counter_dec(&mdsc->metric.total_inodes);
 
+	netfs_wait_for_outstanding_io(inode);
 	truncate_inode_pages_final(&inode->i_data);
 	if (inode->i_state & I_PINNING_NETFS_WB)
 		ceph_fscache_unuse_cookie(inode, true);
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -101,6 +101,8 @@ void netfs_invalidate_folio(struct folio
 
 	kenter("{%lx},%zx,%zx", folio->index, offset, length);
 
+	folio_wait_private_2(folio); /* [DEPRECATED] */
+
 	if (!folio_test_private(folio))
 		return;
 
@@ -165,6 +167,11 @@ bool netfs_release_folio(struct folio *f
 
 	if (folio_test_private(folio))
 		return false;
+	if (unlikely(folio_test_private_2(folio))) { /* [DEPRECATED] */
+		if (current_is_kswapd() || !(gfp & __GFP_FS))
+			return false;
+		folio_wait_private_2(folio);
+	}
 	fscache_note_page_release(netfs_i_cookie(ctx));
 	return true;
 }



