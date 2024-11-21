Return-Path: <linux-fsdevel+bounces-35425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 745A19D4BC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 12:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364362851C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 11:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71991DDC3D;
	Thu, 21 Nov 2024 11:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RpTBYVHP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4cSGDcxj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RpTBYVHP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4cSGDcxj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020C11D90A4;
	Thu, 21 Nov 2024 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188153; cv=none; b=Ch3G2hMdaNQSsxiLw26nnRkFBdm5D0pLVXl3L6k7xkkAnDHC02AH0GGvDvWrpIHutDsDaYBTq723GBUrD/OZzu9lMdRXkem8mA1L5/mpgBP8xiJCjmASZMnRyDIEOr6Q6T8nBIPE3I4W2cLEBa8DOcF2G3HcVC3Q1Nua1wSCFyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188153; c=relaxed/simple;
	bh=5CnqAFaRtWma8glNszfUPQXvlHjCl3h+vVKCMDt8x5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jdS73EZ7f7FtmW9fKNlef6Pj44nyWIGQ7zJa+2ybAEdRYHPhV8EXiC6KqjjGbb5DqDExYYRyG8HWastUjhIliSKF/p7GfvXCeyKFd1SAf83yQVnJ3LwlnRqKHO1OW6alv4tpL72CcpoNxKyWSTuG8IKEk7IOMnp7fBmlh3fYnHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RpTBYVHP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4cSGDcxj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RpTBYVHP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4cSGDcxj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 948AA21A05;
	Thu, 21 Nov 2024 11:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732188144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V2VbJr1FOyyDrN/JRXZjBf5YYpp5FPhCnXLj0Nz6ko0=;
	b=RpTBYVHPZnilU9S5C9NOEFhWpEVBSMnDFvTsJ4iFT0shPGf5eUNWrADAWVO+il9ON92iay
	g7Qcx71u73v3Q5U3cqjUDvi2qWHdoGNAhUy95Wnpd5J/db7Zr5xsqNURvagbxIcXYmWkZQ
	Lb9VGFXaRLCEWdEsMtE9aFMryGAw+hM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732188144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V2VbJr1FOyyDrN/JRXZjBf5YYpp5FPhCnXLj0Nz6ko0=;
	b=4cSGDcxj0ha4IdD6XNUM9muDeVH1TTEQMvC82P1Wr6XqZJ2NFN43qq1OeY3Vx7aFNlpGFs
	9SHrL9s/1nDTAUDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732188144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V2VbJr1FOyyDrN/JRXZjBf5YYpp5FPhCnXLj0Nz6ko0=;
	b=RpTBYVHPZnilU9S5C9NOEFhWpEVBSMnDFvTsJ4iFT0shPGf5eUNWrADAWVO+il9ON92iay
	g7Qcx71u73v3Q5U3cqjUDvi2qWHdoGNAhUy95Wnpd5J/db7Zr5xsqNURvagbxIcXYmWkZQ
	Lb9VGFXaRLCEWdEsMtE9aFMryGAw+hM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732188144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V2VbJr1FOyyDrN/JRXZjBf5YYpp5FPhCnXLj0Nz6ko0=;
	b=4cSGDcxj0ha4IdD6XNUM9muDeVH1TTEQMvC82P1Wr6XqZJ2NFN43qq1OeY3Vx7aFNlpGFs
	9SHrL9s/1nDTAUDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89A6113927;
	Thu, 21 Nov 2024 11:22:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bTaZIfAXP2c9fwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Nov 2024 11:22:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 329D6A08E0; Thu, 21 Nov 2024 12:22:24 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	brauner@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-mm@kvack.org,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 13/19] fanotify: disable readahead if we have pre-content watches
Date: Thu, 21 Nov 2024 12:22:12 +0100
Message-Id: <20241121112218.8249-14-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241121112218.8249-1-jack@suse.cz>
References: <20241121112218.8249-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,toxicpanda.com,kernel.org,linux-foundation.org,ZenIV.linux.org.uk,vger.kernel.org,kvack.org,suse.cz];
	R_RATELIMIT(0.00)[to_ip_from(RLdu9otajk16idfrkma9mbkf9b)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 

From: Josef Bacik <josef@toxicpanda.com>

With page faults we can trigger readahead on the file, and then
subsequent faults can find these pages and insert them into the file
without emitting an fanotify event.  To avoid this case, disable
readahead if we have pre-content watches on the file.  This way we are
guaranteed to get an event for every range we attempt to access on a
pre-content watched file.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/70a54e859f555e54bc7a47b32fe5aca92b085615.1731684329.git.josef@toxicpanda.com
---
 mm/filemap.c   | 12 ++++++++++++
 mm/readahead.c | 14 ++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 36d22968be9a..98f15dccff89 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3149,6 +3149,14 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	unsigned long vm_flags = vmf->vma->vm_flags;
 	unsigned int mmap_miss;
 
+	/*
+	 * If we have pre-content watches we need to disable readahead to make
+	 * sure that we don't populate our mapping with 0 filled pages that we
+	 * never emitted an event for.
+	 */
+	if (unlikely(FMODE_FSNOTIFY_HSM(file->f_mode)))
+		return fpin;
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	/* Use the readahead code, even if readahead is disabled */
 	if ((vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER) {
@@ -3217,6 +3225,10 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 	struct file *fpin = NULL;
 	unsigned int mmap_miss;
 
+	/* See comment in do_sync_mmap_readahead. */
+	if (unlikely(FMODE_FSNOTIFY_HSM(file->f_mode)))
+		return fpin;
+
 	/* If we don't want any read-ahead, don't bother */
 	if (vmf->vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
 		return fpin;
diff --git a/mm/readahead.c b/mm/readahead.c
index 3dc6c7a128dd..e482f9f2e159 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -128,6 +128,7 @@
 #include <linux/blk-cgroup.h>
 #include <linux/fadvise.h>
 #include <linux/sched/mm.h>
+#include <linux/fsnotify.h>
 
 #include "internal.h"
 
@@ -544,6 +545,15 @@ void page_cache_sync_ra(struct readahead_control *ractl,
 	unsigned long max_pages, contig_count;
 	pgoff_t prev_index, miss;
 
+	/*
+	 * If we have pre-content watches we need to disable readahead to make
+	 * sure that we don't find 0 filled pages in cache that we never emitted
+	 * events for. Filesystems supporting HSM must make sure to not call
+	 * this function with ractl->file unset for files handled by HSM.
+	 */
+	if (ractl->file && unlikely(FMODE_FSNOTIFY_HSM(ractl->file->f_mode)))
+		return;
+
 	/*
 	 * Even if readahead is disabled, issue this request as readahead
 	 * as we'll need it to satisfy the requested range. The forced
@@ -622,6 +632,10 @@ void page_cache_async_ra(struct readahead_control *ractl,
 	if (!ra->ra_pages)
 		return;
 
+	/* See the comment in page_cache_sync_ra. */
+	if (ractl->file && unlikely(FMODE_FSNOTIFY_HSM(ractl->file->f_mode)))
+		return;
+
 	/*
 	 * Same bit is used for PG_readahead and PG_reclaim.
 	 */
-- 
2.35.3


