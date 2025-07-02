Return-Path: <linux-fsdevel+bounces-53727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F9BAF63D4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 23:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A62176395
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 21:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57E42367DA;
	Wed,  2 Jul 2025 21:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VnNrgdqs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68C62DE700
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 21:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751491064; cv=none; b=Tu+1nfDGqCotp4PRQH5IcwvQ/XBn27Fb81QJS1r3ScrS8aO9u+1unFTlITCzWTAxM3FOy1z0kKW7zphL9mAS5KtOvm19SCnj5hDpaAyfDBCZxfzTWgejbuTQKqf2ExheyW3t5mqOWhUHAHHA/m1+CAVHqkAFDcoHwQ5KyDUOetg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751491064; c=relaxed/simple;
	bh=JWqhBTrNuU3eEjjDpRGLc/D6UonTe/NG5vY8q8tAnYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucRY5wIpjARyZItdUYxxTd5BOORF+jrYFompFeAwnJ00f5ZQmcb43CFHiE5LPWnTefzDYQVc8kqSSTEGvG6JAiibgrPdOBr8jKyN6KHlgV4phaDsR/nunLWyBtmzYKvxfMA+24Bc2p2/KdVSwnslkJ5LNkhVeT8RZ2B9KEIyKII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VnNrgdqs; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yZJCP+2UZQwzSfBgsZZNvcBirXP6VoVDGCDx7eUFErg=; b=VnNrgdqsPoyFYkoQLksjdWhHfF
	v992R3gFxzkRm3cDelvJVyBXRObAoFpvbbbBAKbvy4xjQglKW5D1OvWDkrWRqODrUQvgBpnq1eHL0
	r/l5e9I71vLC/t+Fl9JTkB8GR8AE6q8OmTB6KujZnVKmuG3mooVKpC2Mkwc+S6sWsxkFeIPtJSTHG
	5JWdWK5L1zgLNsSEyXwynue9SfuhXnSdfxTGLtGyirCSi6/yM87KXUn/qsbJBTBd44rkqqv5OOt6h
	BsxS8H6am9ZyZJtfgYh2p0ezHn8S3qXTCx6LAAOstf7wfbPQj4JSQt9pmuWKepwhQPGUtr0s6zRQR
	yUGgFcgg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX4pn-0000000EKV3-3pTK;
	Wed, 02 Jul 2025 21:17:40 +0000
Date: Wed, 2 Jul 2025 22:17:39 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 05/11] vmscan: don't bother with debugfs_real_fops()
Message-ID: <20250702211739.GE3406663@ZenIV>
References: <20250702211305.GE1880847@ZenIV>
 <20250702211408.GA3406663@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702211408.GA3406663@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

... not when it's used only to check which file is used;
debugfs_create_file_aux_num() allows to stash a number into
debugfs entry and debugfs_get_aux_num() extracts it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 mm/vmscan.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f8dfd2864bbf..0e661672cbb9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5420,7 +5420,7 @@ static void lru_gen_seq_show_full(struct seq_file *m, struct lruvec *lruvec,
 static int lru_gen_seq_show(struct seq_file *m, void *v)
 {
 	unsigned long seq;
-	bool full = !debugfs_real_fops(m->file)->write;
+	bool full = debugfs_get_aux_num(m->file);
 	struct lruvec *lruvec = v;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	int nid = lruvec_pgdat(lruvec)->node_id;
@@ -5756,8 +5756,10 @@ static int __init init_lru_gen(void)
 	if (sysfs_create_group(mm_kobj, &lru_gen_attr_group))
 		pr_err("lru_gen: failed to create sysfs group\n");
 
-	debugfs_create_file("lru_gen", 0644, NULL, NULL, &lru_gen_rw_fops);
-	debugfs_create_file("lru_gen_full", 0444, NULL, NULL, &lru_gen_ro_fops);
+	debugfs_create_file_aux_num("lru_gen", 0644, NULL, NULL, 1,
+				    &lru_gen_rw_fops);
+	debugfs_create_file_aux_num("lru_gen_full", 0444, NULL, NULL, 0,
+				    &lru_gen_ro_fops);
 
 	return 0;
 };
-- 
2.39.5


