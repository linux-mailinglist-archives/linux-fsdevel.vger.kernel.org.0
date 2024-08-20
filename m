Return-Path: <linux-fsdevel+bounces-26417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A3D95919F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 02:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0BE0B20DE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 00:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338084A1C;
	Wed, 21 Aug 2024 00:11:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-09.prod.sxb1.secureserver.net (sxb1plsmtpa01-09.prod.sxb1.secureserver.net [188.121.53.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C417FA55
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 00:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724199087; cv=none; b=sLMuRdQHafBxp7b5kAyw69rPW74GHEbEbIMqt7if2osJkxz1DWq/lGZyH6QkEj1yAUFDqTfeUUaym2m3M+BLlJRtCZ19lB75Frte+tdsPNW2bXWDZtfhdrggI8bP9FTbG+qz/88v3GazGG45CLv6/tTrqtL4Cu4OwitsY5RxTK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724199087; c=relaxed/simple;
	bh=eJaeTVak1rt+uWU6m8O4EhDKO+Q3iCdDDptK1WJ+Kks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WyXi6/AGXjAD9PhH92km+x4LQRA6QcqAxndXjQIFFHNrEsV++/W+dTfxMz/XhWVPPNdUdGZBjzde3vaylVIaW3P4V1/oRhmhK644pc2garVueQwAAQIro/blyHH5G2E6bDkdKXfmMwDwHg9S6+xSTzPCq392FNtCyLNNSOfHQfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from phoenix.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id gYEdsqtlu3WfYgYFNshvcb; Tue, 20 Aug 2024 16:26:42 -0700
X-CMAE-Analysis: v=2.4 cv=JvU6r94C c=1 sm=1 tr=0 ts=66c52632
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=VwQbUJbxAAAA:8
 a=FXvPX3liAAAA:8 a=6R2sW40mVC26G-UyxH8A:9 a=AjGcO6oz07-iQ99wixmX:22
 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH 5/4] Squashfs: Ensure all readahead pages have been used
Date: Wed, 21 Aug 2024 00:26:22 +0100
Message-Id: <20240820232622.19271-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfG26RX2Z/qj8AIqoDmXkcgPabMADaY/QzpPxQrFw8jzfgUxug2x3Yrr4qy+kjlUzp1LLhM8ZXB0U90b0DsBUacWMJaMiMmbwBOnqevjLSPM2RStCxSxH
 IoTQpENi0oFnAVooFhD+HI9nqbnDxXOPAtl6ubLsBADgyAq4lj/CWuBLLQmyTjGcZ10qdZyItO8vkptohwSCeYOxX4Q5RN0uoY2tKlI3s+POtNRwdN0HJywY
 /bSuZv+3dkmsd9hAgsLaDILA70RR8ZJsfyoGIQLl4VHaEDdfZ+KpM5NdQoe8rYXVZ4CnSdub7Spm4yfV7by+zx9YXxpA7G1nCmGvTuunfHyyUsEDBhnCLR7O
 YYuP4HTs

In the recent work to remove page->index, a sanity check
that ensured all the readhead pages were covered by the
Squashfs data block was removed [1].

To avoid any regression, this commit adds the sanity check
back in an equivalent way.  Namely the page actor will now
return error if any pages are unused after completion.

[1] https://lore.kernel.org/all/20240818235847.170468-3-phillip@squashfs.org.uk/

Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
 fs/squashfs/file.c        | 4 ++--
 fs/squashfs/file_direct.c | 2 +-
 fs/squashfs/page_actor.h  | 6 +++++-
 3 files changed, 8 insertions(+), 4 deletions(-)

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
index c6d837f0e9ca..f770a906c2c6 100644
--- a/fs/squashfs/page_actor.h
+++ b/fs/squashfs/page_actor.h
@@ -37,7 +37,11 @@ static inline struct page *squashfs_page_actor_free(struct squashfs_page_actor *
 
 	kfree(actor->tmp_buffer);
 	kfree(actor);
-	return last_page;
+
+	if (actor->next_page == actor->pages)
+		return last_page;
+	else
+		return ERR_PTR(-EIO);
 }
 static inline void *squashfs_first_page(struct squashfs_page_actor *actor)
 {
-- 
2.39.2


