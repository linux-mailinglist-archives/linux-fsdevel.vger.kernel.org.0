Return-Path: <linux-fsdevel+bounces-41947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B8CA39334
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364EC165764
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8A81B87D3;
	Tue, 18 Feb 2025 05:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GOymUiex"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B92D1B4138
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857931; cv=none; b=qU1e5seGuv54VcOEHvfxSYSV3ldekMJdv/DHfOrjmYjx0zfdR2y+uXcqVSHFGlaao5+Rf48dM49SFx++Lu3GTgQm/7uRRy7EhsXH2EdfmUn8+5qqROEQXL7TeoGRBiAhuGv3kKqnOEVuC1ZhgWfDVGagqqYBrGJ16xQxN7HxXmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857931; c=relaxed/simple;
	bh=c5jnf6gmGRbPUmzMoQaRAx9T1mNH/LjfIRmhkU/IxEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVnFeuqbEe6Y+53ayFkbI2RiVhZMvLteCm9KkNYTq5WLVJR55rHcqX7JXHMSZoxVJ40fot4n+wI3DSd9ZgFiRJGylk5duAiXzv2eGAw2s5p8RRsMwFOle4VfldtmVrGvZRyYfh501MkRVTZtnTYB5Xm1/ig68uFZVbE5ndlqAV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GOymUiex; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=cM12HuwtYvDW5RZv6niKy3FbHGL/VsXhMZwF7o58pWw=; b=GOymUiexKmbKfjBa+VOTayPnaZ
	DjxAAIJUF/FUf4CRNU/kaL2XC886bosYTB1fdFVid4eVQmB2nWhAhQgFqoKXbJJy0DQ34yAteTyAJ
	nKnNnWfZrKnN/ISAhv37QR3LkSNma4pKftrPHF96xJklIG387bboRogN142hE5HigjVtPFvKNiVVf
	6VVyApExrz38dGvGHSrWrjE6qkW1ncy45/7ZYIdMy4Vt+GKIKjvedFS9GkbaYlcn/ehxc4VqX89Ow
	wbn8J+Zk1RGHoh6iEsA7Ex9sqz95aVCqIvovldmWwyI7s36W48q+w5ibwFBLMxT1bcWvMdbQGnLIU
	NrElmvmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGWd-00000002TsZ-2F1Z;
	Tue, 18 Feb 2025 05:52:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 15/27] f2fs: Mark some functions as taking a const page pointer
Date: Tue, 18 Feb 2025 05:51:49 +0000
Message-ID: <20250218055203.591403-16-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218055203.591403-1-willy@infradead.org>
References: <20250218055203.591403-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The compiler can make some optimisations if we tell it that a function
call doesn't change this memory.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/f2fs.h | 2 +-
 fs/f2fs/node.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index cf664ca38905..a941a0750712 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2017,7 +2017,7 @@ static inline struct f2fs_checkpoint *F2FS_CKPT(struct f2fs_sb_info *sbi)
 	return (struct f2fs_checkpoint *)(sbi->ckpt);
 }
 
-static inline struct f2fs_node *F2FS_NODE(struct page *page)
+static inline struct f2fs_node *F2FS_NODE(const struct page *page)
 {
 	return (struct f2fs_node *)page_address(page);
 }
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 6aea13024ac1..281d53c95c9a 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -248,7 +248,7 @@ static inline nid_t nid_of_node(struct page *node_page)
 	return le32_to_cpu(rn->footer.nid);
 }
 
-static inline unsigned int ofs_of_node(struct page *node_page)
+static inline unsigned int ofs_of_node(const struct page *node_page)
 {
 	struct f2fs_node *rn = F2FS_NODE(node_page);
 	unsigned flag = le32_to_cpu(rn->footer.flag);
@@ -342,7 +342,7 @@ static inline bool is_recoverable_dnode(struct page *page)
  *                 `- indirect node ((6 + 2N) + (N - 1)(N + 1))
  *                       `- direct node
  */
-static inline bool IS_DNODE(struct page *node_page)
+static inline bool IS_DNODE(const struct page *node_page)
 {
 	unsigned int ofs = ofs_of_node(node_page);
 
@@ -389,7 +389,7 @@ static inline nid_t get_nid(struct page *p, int off, bool i)
  *  - Mark cold data pages in page cache
  */
 
-static inline int is_node(struct page *page, int type)
+static inline int is_node(const struct page *page, int type)
 {
 	struct f2fs_node *rn = F2FS_NODE(page);
 	return le32_to_cpu(rn->footer.flag) & BIT(type);
-- 
2.47.2


