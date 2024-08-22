Return-Path: <linux-fsdevel+bounces-26854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BEE95C229
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 02:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D283B225DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 00:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D5DB653;
	Fri, 23 Aug 2024 00:15:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-02.prod.sxb1.secureserver.net (sxb1plsmtpa01-02.prod.sxb1.secureserver.net [188.121.53.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E3AAD59
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 00:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724372139; cv=none; b=EX47Rda4UHZuTsfmwSG9udQS3xkJPgxlGhoLiXIamynWYwvEZ1RVTC0OJbsTtMI3vzg0RxOcF4AbeJoTozvVqDmoTOATt3LXWQITSucIM3ZgLDprPOIz1VUAawb3pYXfK7jDoAGQjwPNhzkDOw4NIAfIBmZHhiRtBp0MKwN5nCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724372139; c=relaxed/simple;
	bh=pGEKN+wc+DZuM3ExeQa9PJHgawcNAtSwfDs6zevQAN4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e/vIjyvDXUbiTNA7odaKUAHi2aqfIukNxDuhOImn2Mjy1z3hQsBABUT/YPpuqA0Vxlic2mSIGheoQte8jNDWiiSibzRJTCLRN87lBWtatFpTlswz5KCCgFRomr6Rbqk+kz/kOkiZe6kLJebT5acRGTFGEwy0FHQ9YROWJbtybUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from phoenix.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id hHGOsHsK5LW3HhHGasoxDN; Thu, 22 Aug 2024 16:30:57 -0700
X-CMAE-Analysis: v=2.4 cv=Lan36Sfi c=1 sm=1 tr=0 ts=66c7ca31
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=VwQbUJbxAAAA:8
 a=FXvPX3liAAAA:8 a=s94iO8TKwuVpzBr5ofsA:9 a=AjGcO6oz07-iQ99wixmX:22
 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH V3] Squashfs: Ensure all readahead pages have been used
Date: Fri, 23 Aug 2024 00:31:06 +0100
Message-Id: <20240822233106.121522-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfGQ+ljdeCwq4R4QkaKRx4wdqc1EIsUZnsGZe4Fozhg5f2rSUiwnsc2fSCza2HVTuq2Hjj+hsCxkLODof5DxMDw6pYeyt+iePY5bb7sd70GLNkVIYBm1J
 DqVPQIXRjw8yw6I5kPvMfSSJOgE/4Fr1IcBJnoizmrLPeP/DjWA+UddC0V6CBifXdLTGBjMzbnQFh0oX9P9GuWOZ1dd2czyKCV5QLhKAwCTEm9plrmii5x9I
 3JnwDtT17En/PIpQhO6gZcIVA+VWSvkdVo+cEz5gvmVOyozcD32otj+vECCmey4CAxGOcnzffcFQtkQnBHos8GJQOeY5SO+4XrEzxZ5QN9DycdW1fTwPEh+m
 bxwmRVT+

In the recent work to remove page->index, a sanity check
that ensured all the readhead pages were covered by the
Squashfs data block was removed [1].

To avoid any regression, this commit adds the sanity check
back in an equivalent way.  Namely the page actor will now
return error if any pages are unused after completion.

[1] https://lore.kernel.org/all/20240818235847.170468-3-phillip@squashfs.org.uk/

Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
--
V3: last_page should be actor->last_page
---
 fs/squashfs/file.c        | 4 ++--
 fs/squashfs/file_direct.c | 2 +-
 fs/squashfs/page_actor.h  | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 5a3745e52025..21aaa96856c1 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -535,7 +535,7 @@ static int squashfs_readahead_fragment(struct page **page,
 
 	last_page = squashfs_page_actor_free(actor);
 
-	if (copied == expected) {
+	if (copied == expected && !IS_ERR(last_page)) {
 		/* Last page (if present) may have trailing bytes not filled */
 		bytes = copied % PAGE_SIZE;
 		if (bytes && last_page)
@@ -625,7 +625,7 @@ static void squashfs_readahead(struct readahead_control *ractl)
 
 		last_page = squashfs_page_actor_free(actor);
 
-		if (res == expected) {
+		if (res == expected && !IS_ERR(last_page)) {
 			int bytes;
 
 			/* Last page (if present) may have trailing bytes not filled */
diff --git a/fs/squashfs/file_direct.c b/fs/squashfs/file_direct.c
index 646d4d421f99..22251743fadf 100644
--- a/fs/squashfs/file_direct.c
+++ b/fs/squashfs/file_direct.c
@@ -80,7 +80,7 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	if (res < 0)
 		goto mark_errored;
 
-	if (res != expected) {
+	if (res != expected || IS_ERR(last_page)) {
 		res = -EIO;
 		goto mark_errored;
 	}
diff --git a/fs/squashfs/page_actor.h b/fs/squashfs/page_actor.h
index c6d837f0e9ca..ffe25eb77c32 100644
--- a/fs/squashfs/page_actor.h
+++ b/fs/squashfs/page_actor.h
@@ -33,10 +33,11 @@ extern struct squashfs_page_actor *squashfs_page_actor_init_special(
 				loff_t start_index);
 static inline struct page *squashfs_page_actor_free(struct squashfs_page_actor *actor)
 {
-	struct page *last_page = actor->last_page;
+	struct page *last_page = actor->next_page == actor->pages ? actor->last_page : ERR_PTR(-EIO);
 
 	kfree(actor->tmp_buffer);
 	kfree(actor);
+
 	return last_page;
 }
 static inline void *squashfs_first_page(struct squashfs_page_actor *actor)
-- 
2.39.2


