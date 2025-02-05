Return-Path: <linux-fsdevel+bounces-40863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F9DA27FEA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 01:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A0A166327
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 00:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96582CA64;
	Wed,  5 Feb 2025 00:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="pGVfajER"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f66.google.com (mail-oa1-f66.google.com [209.85.160.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827AC25A65E
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 00:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738713808; cv=none; b=aWDceLMWJr9jGXNvzt8qS17bAAAkEyNNO5O1mAvH5L8CJ9bf25Cdjo9UiC8bCleDV6ZzjqVn+5QDV4QXtqnLjwnRIqa0OLBo38oT7kA/4+R9RVwVydsrrBmxqr89KuX3Yb5jiY/yzxhcqElvFllpp66PjZEGkZVy365BWpEuHwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738713808; c=relaxed/simple;
	bh=mNZpD0Sy80vpPKABY4V1YsAxyRRZ+n0QFl/hS3KozyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgEzdkvzSyoXKXnrk5mSMfWskcjbHJAy2a0D3hgbXaPN9JQIqj17XgElSO9UXzvjoOIna5CkIMk6TIuk1MsHrsrMPMuXiopsHSt3qvoZipAxm9LQg2HWk5sx9LZvATPiZwYz5mV1ahu1Tmv+FuqHfepvKodh3W2f9m6CwMsD23c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=pGVfajER; arc=none smtp.client-ip=209.85.160.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-oa1-f66.google.com with SMTP id 586e51a60fabf-2adc2b6837eso1600656fac.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 16:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1738713804; x=1739318604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0G0H6IZpkWX9jNdakJUVZSphjoxgVBMdKBeRIa9iUI=;
        b=pGVfajERQp5Ka/sklTpZgDzF1+18SI1t16iLJsYwHPEuzRulKVjKzyllXBNMNEhUqa
         FUbsfS23OiS/bnYq7WXwgjIu/YwASEusbQPMbiMhR/JBy+lMGjmAIfx7kBis7Oc+G1sk
         2/M6M/RgtwKfNf6tek0kUxsKwcFXR6B3zSbq6KIXcv5RFW1UA5jOvuyB8eE/chSu68K6
         EPDcYO6ao+Yk3hq4HhHE2GZclGkbNqcFBRkjQa88k+v+ZbKGZ2oG/GaNom493/Rpp+rE
         oFqnMk+/FQOl0V0O9U/kEndGccvjm/HLPPH/khZnAXVIuG2DU3BK9vbZz/xmnQILEcrJ
         PVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738713804; x=1739318604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0G0H6IZpkWX9jNdakJUVZSphjoxgVBMdKBeRIa9iUI=;
        b=I8DjazRVokpoYRuCuyi1l6urG4utjBpumu4lg/2g5HUVLaUDgh1wGseGJGSyfTyUBj
         R6VabUVABcjhq2VMCSU7741l9r/BRbA7bkaXG3N8Sh1E+FTpzON5aealZ73WvINK0Nas
         GNOrpDhy2gXXghBmLBgyGP/Ev+sy+BfI6W0jP75+BHirsjdBFjEscY8k2kz2ViOdkSHm
         0cWeCrLBrOL8Y+FvwSgdnQHULLPYTBOFRPsw9no874FqTRfZg1egQIw5Tk+DEfCImYU1
         +cTYbom7ar9Ifb0Zxroait/LEVPjhbL2vQkt2RPzISWl9ehGQs6N0AEy8GaiV1vKy8sB
         ND5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2z8KeCjS5tDTZ7ZYUKNsf6j9cO5dikmsjKt9u5mBz8T80MF8pi8Wwgd3GPZPNUHZqin7mYJkmvUWWDEfJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxq++OQa+vOc8xwb8rFYpngclnIMX34uSWf8CPpcgo72YDyYjb
	/eect8w8/l4EfCYgxi/vfc7Bc8qYzXnG1El5/COUTyZZHmuKuqPSyq/1tE0d2+Q=
X-Gm-Gg: ASbGncuagNTwGuraWuY8rXTApdjt2r9X05ZNxu8aHz+bF8RjcUhXiUKy2KARR9EvkAm
	JHITAmetg21yy3tMstgSWSziWNiAsxDUH4fqIzMS7KBYQ3jbWpF/289wFaLydk7NIMvfTy2KV3l
	3+c769iP0vYqjEoH+PJOrjCVHlAZUzEYafwuIQIU0ZaSNBTPZvAPEaWuJSpSQGSAcbkDTwFdGeJ
	GdtgvDNba5s3p6wO7pn0oYP9RqA7h3gVvmXk5WXjrJwFoE6AaP4w1hbu4nyzBU0znjzsDaiweev
	7CcS8nYcSQEDwP3ajanGH/+gzGXnrx0u
X-Google-Smtp-Source: AGHT+IFoqz6fi3d08M9C5BqpNvy0d4ArXveUMny1fHKKo+YqrdumKcyX6zcBTue2RpOE5rKWkOczbg==
X-Received: by 2002:a05:6870:213:b0:29e:1f4b:a55c with SMTP id 586e51a60fabf-2b804ed3760mr616528fac.7.1738713804411;
        Tue, 04 Feb 2025 16:03:24 -0800 (PST)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:d53:ebfc:fe83:43f5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726617eb64csm3666413a34.37.2025.02.04.16.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 16:03:22 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	dhowells@redhat.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [RFC PATCH 2/4] ceph: introduce ceph_process_folio_batch() method
Date: Tue,  4 Feb 2025 16:02:47 -0800
Message-ID: <20250205000249.123054-3-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205000249.123054-1-slava@dubeyko.com>
References: <20250205000249.123054-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

First step of ceph_writepages_start() logic is
of finding the dirty memory folios and processing it.
This patch introduces ceph_process_folio_batch()
method that moves this logic into dedicated method.

The ceph_writepages_start() has this logic:

if (ceph_wbc.locked_pages == 0)
    lock_page(page);  /* first page */
else if (!trylock_page(page))
    break;

<skipped>

if (folio_test_writeback(folio) ||
    folio_test_private_2(folio) /* [DEPRECATED] */) {
      if (wbc->sync_mode == WB_SYNC_NONE) {
          doutc(cl, "%p under writeback\n", folio);
          folio_unlock(folio);
          continue;
      }
      doutc(cl, "waiting on writeback %p\n", folio);
      folio_wait_writeback(folio);
      folio_wait_private_2(folio); /* [DEPRECATED] */
}

The problem here that folio/page is locked here at first
and it is by set_page_writeback(page) later before
submitting the write request. The folio/page is unlocked
by writepages_finish() after finishing the write
request. It means that logic of checking folio_test_writeback()
and folio_wait_writeback() never works because page is locked
and it cannot be locked again until write request completion.
However, for majority of folios/pages the trylock_page()
is used. As a result, multiple threads can try to lock the same
folios/pages multiple times even if they are under writeback
already. It makes this logic more compute intensive than
it is necessary.

This patch changes this logic:

if (folio_test_writeback(folio) ||
    folio_test_private_2(folio) /* [DEPRECATED] */) {
      if (wbc->sync_mode == WB_SYNC_NONE) {
          doutc(cl, "%p under writeback\n", folio);
          folio_unlock(folio);
          continue;
      }
      doutc(cl, "waiting on writeback %p\n", folio);
      folio_wait_writeback(folio);
      folio_wait_private_2(folio); /* [DEPRECATED] */
}

if (ceph_wbc.locked_pages == 0)
    lock_page(page);  /* first page */
else if (!trylock_page(page))
    break;

This logic should exclude the ignoring of writeback
state of folios/pages.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 fs/ceph/addr.c | 568 +++++++++++++++++++++++++++++++------------------
 1 file changed, 365 insertions(+), 203 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index d002ff62d867..739329846a07 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -978,6 +978,27 @@ static void writepages_finish(struct ceph_osd_request *req)
 	ceph_dec_osd_stopping_blocker(fsc->mdsc);
 }
 
+static inline
+bool is_forced_umount(struct address_space *mapping)
+{
+	struct inode *inode = mapping->host;
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	struct ceph_client *cl = fsc->client;
+
+	if (ceph_inode_is_shutdown(inode)) {
+		if (ci->i_wrbuffer_ref > 0) {
+			pr_warn_ratelimited_client(cl,
+				"%llx.%llx %lld forced umount\n",
+				ceph_vinop(inode), ceph_ino(inode));
+		}
+		mapping_set_error(mapping, -EIO);
+		return true;
+	}
+
+	return false;
+}
+
 static inline
 unsigned int ceph_define_write_size(struct address_space *mapping)
 {
@@ -1046,6 +1067,334 @@ void ceph_init_writeback_ctl(struct address_space *mapping,
 	ceph_wbc->data_pages = NULL;
 }
 
+static inline
+int ceph_define_writeback_range(struct address_space *mapping,
+				struct writeback_control *wbc,
+				struct ceph_writeback_ctl *ceph_wbc)
+{
+	struct inode *inode = mapping->host;
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	struct ceph_client *cl = fsc->client;
+
+	/* find oldest snap context with dirty data */
+	ceph_wbc->snapc = get_oldest_context(inode, ceph_wbc, NULL);
+	if (!ceph_wbc->snapc) {
+		/* hmm, why does writepages get called when there
+		   is no dirty data? */
+		doutc(cl, " no snap context with dirty data?\n");
+		return -ENODATA;
+	}
+
+	doutc(cl, " oldest snapc is %p seq %lld (%d snaps)\n",
+	      ceph_wbc->snapc, ceph_wbc->snapc->seq,
+	      ceph_wbc->snapc->num_snaps);
+
+	ceph_wbc->should_loop = false;
+
+	if (ceph_wbc->head_snapc && ceph_wbc->snapc != ceph_wbc->last_snapc) {
+		/* where to start/end? */
+		if (wbc->range_cyclic) {
+			ceph_wbc->index = ceph_wbc->start_index;
+			ceph_wbc->end = -1;
+			if (ceph_wbc->index > 0)
+				ceph_wbc->should_loop = true;
+			doutc(cl, " cyclic, start at %lu\n", ceph_wbc->index);
+		} else {
+			ceph_wbc->index = wbc->range_start >> PAGE_SHIFT;
+			ceph_wbc->end = wbc->range_end >> PAGE_SHIFT;
+			if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
+				ceph_wbc->range_whole = true;
+			doutc(cl, " not cyclic, %lu to %lu\n",
+				ceph_wbc->index, ceph_wbc->end);
+		}
+	} else if (!ceph_wbc->head_snapc) {
+		/* Do not respect wbc->range_{start,end}. Dirty pages
+		 * in that range can be associated with newer snapc.
+		 * They are not writeable until we write all dirty pages
+		 * associated with 'snapc' get written */
+		if (ceph_wbc->index > 0)
+			ceph_wbc->should_loop = true;
+		doutc(cl, " non-head snapc, range whole\n");
+	}
+
+	ceph_put_snap_context(ceph_wbc->last_snapc);
+	ceph_wbc->last_snapc = ceph_wbc->snapc;
+
+	return 0;
+}
+
+static inline
+bool has_writeback_done(struct ceph_writeback_ctl *ceph_wbc)
+{
+	return ceph_wbc->done && ceph_wbc->index > ceph_wbc->end;
+}
+
+static inline
+bool can_next_page_be_processed(struct ceph_writeback_ctl *ceph_wbc,
+				unsigned index)
+{
+	return index < ceph_wbc->nr_folios &&
+		ceph_wbc->locked_pages < ceph_wbc->max_pages;
+}
+
+static
+int ceph_check_page_before_write(struct address_space *mapping,
+				 struct writeback_control *wbc,
+				 struct ceph_writeback_ctl *ceph_wbc,
+				 struct folio *folio)
+{
+	struct inode *inode = mapping->host;
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	struct ceph_client *cl = fsc->client;
+	struct ceph_snap_context *pgsnapc;
+	struct page *page = &folio->page;
+
+	/* only dirty pages, or our accounting breaks */
+	if (unlikely(!PageDirty(page)) || unlikely(page->mapping != mapping)) {
+		doutc(cl, "!dirty or !mapping %p\n", page);
+		return -ENODATA;
+	}
+
+	/* only if matching snap context */
+	pgsnapc = page_snap_context(page);
+	if (pgsnapc != ceph_wbc->snapc) {
+		doutc(cl, "page snapc %p %lld != oldest %p %lld\n",
+		      pgsnapc, pgsnapc->seq,
+		      ceph_wbc->snapc, ceph_wbc->snapc->seq);
+
+		if (!ceph_wbc->should_loop && !ceph_wbc->head_snapc &&
+		    wbc->sync_mode != WB_SYNC_NONE)
+			ceph_wbc->should_loop = true;
+
+		return -ENODATA;
+	}
+
+	if (page_offset(page) >= ceph_wbc->i_size) {
+		doutc(cl, "folio at %lu beyond eof %llu\n",
+		      folio->index, ceph_wbc->i_size);
+
+		if ((ceph_wbc->size_stable ||
+		    folio_pos(folio) >= i_size_read(inode)) &&
+		    folio_clear_dirty_for_io(folio))
+			folio_invalidate(folio, 0, folio_size(folio));
+
+		return -ENODATA;
+	}
+
+	if (ceph_wbc->strip_unit_end &&
+	    (page->index > ceph_wbc->strip_unit_end)) {
+		doutc(cl, "end of strip unit %p\n", page);
+		return -E2BIG;
+	}
+
+	return 0;
+}
+
+static inline
+void __ceph_allocate_page_array(struct ceph_writeback_ctl *ceph_wbc,
+				unsigned int max_pages)
+{
+	ceph_wbc->pages = kmalloc_array(max_pages,
+					sizeof(*ceph_wbc->pages),
+					GFP_NOFS);
+	if (!ceph_wbc->pages) {
+		ceph_wbc->from_pool = true;
+		ceph_wbc->pages = mempool_alloc(ceph_wb_pagevec_pool, GFP_NOFS);
+		BUG_ON(!ceph_wbc->pages);
+	}
+}
+
+static inline
+void ceph_allocate_page_array(struct address_space *mapping,
+			      struct ceph_writeback_ctl *ceph_wbc,
+			      struct page *page)
+{
+	struct inode *inode = mapping->host;
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	u64 objnum;
+	u64 objoff;
+	u32 xlen;
+
+	/* prepare async write request */
+	ceph_wbc->offset = (u64)page_offset(page);
+	ceph_calc_file_object_mapping(&ci->i_layout,
+					ceph_wbc->offset, ceph_wbc->wsize,
+					&objnum, &objoff, &xlen);
+
+	ceph_wbc->num_ops = 1;
+	ceph_wbc->strip_unit_end = page->index + ((xlen - 1) >> PAGE_SHIFT);
+
+	BUG_ON(ceph_wbc->pages);
+	ceph_wbc->max_pages = calc_pages_for(0, (u64)xlen);
+	__ceph_allocate_page_array(ceph_wbc, ceph_wbc->max_pages);
+
+	ceph_wbc->len = 0;
+}
+
+static inline
+bool is_page_index_contiguous(struct ceph_writeback_ctl *ceph_wbc,
+			      struct page *page)
+{
+	return page->index == (ceph_wbc->offset + ceph_wbc->len) >> PAGE_SHIFT;
+}
+
+static inline
+bool is_num_ops_too_big(struct ceph_writeback_ctl *ceph_wbc)
+{
+	return ceph_wbc->num_ops >=
+		(ceph_wbc->from_pool ?  CEPH_OSD_SLAB_OPS : CEPH_OSD_MAX_OPS);
+}
+
+static inline
+bool is_write_congestion_happened(struct ceph_fs_client *fsc)
+{
+	return atomic_long_inc_return(&fsc->writeback_count) >
+		CONGESTION_ON_THRESH(fsc->mount_options->congestion_kb);
+}
+
+static inline
+int ceph_move_dirty_page_in_page_array(struct address_space *mapping,
+					struct writeback_control *wbc,
+					struct ceph_writeback_ctl *ceph_wbc,
+					struct page *page)
+{
+	struct inode *inode = mapping->host;
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	struct ceph_client *cl = fsc->client;
+	struct page **pages = ceph_wbc->pages;
+	unsigned int index = ceph_wbc->locked_pages;
+	gfp_t gfp_flags = ceph_wbc->locked_pages ? GFP_NOWAIT : GFP_NOFS;
+
+	if (IS_ENCRYPTED(inode)) {
+		pages[index] = fscrypt_encrypt_pagecache_blocks(page,
+								PAGE_SIZE,
+								0,
+								gfp_flags);
+		if (IS_ERR(pages[index])) {
+			if (PTR_ERR(pages[index]) == -EINVAL) {
+				pr_err_client(cl, "inode->i_blkbits=%hhu\n",
+						inode->i_blkbits);
+			}
+
+			/* better not fail on first page! */
+			BUG_ON(ceph_wbc->locked_pages == 0);
+
+			pages[index] = NULL;
+			return PTR_ERR(pages[index]);
+		}
+	} else {
+		pages[index] = page;
+	}
+
+	ceph_wbc->locked_pages++;
+
+	return 0;
+}
+
+static
+int ceph_process_folio_batch(struct address_space *mapping,
+			     struct writeback_control *wbc,
+			     struct ceph_writeback_ctl *ceph_wbc)
+{
+	struct inode *inode = mapping->host;
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	struct ceph_client *cl = fsc->client;
+	struct folio *folio = NULL;
+	struct page *page = NULL;
+	unsigned i;
+	int rc = 0;
+
+	for (i = 0; can_next_page_be_processed(ceph_wbc, i); i++) {
+		folio = ceph_wbc->fbatch.folios[i];
+
+		if (!folio)
+			continue;
+
+		page = &folio->page;
+
+		doutc(cl, "? %p idx %lu, folio_test_writeback %#x, "
+			"folio_test_dirty %#x, folio_test_locked %#x\n",
+			page, page->index, folio_test_writeback(folio),
+			folio_test_dirty(folio),
+			folio_test_locked(folio));
+
+		if (folio_test_writeback(folio) ||
+		    folio_test_private_2(folio) /* [DEPRECATED] */) {
+			doutc(cl, "waiting on writeback %p\n", folio);
+			folio_wait_writeback(folio);
+			folio_wait_private_2(folio); /* [DEPRECATED] */
+			continue;
+		}
+
+		if (ceph_wbc->locked_pages == 0)
+			lock_page(page);  /* first page */
+		else if (!trylock_page(page))
+			break;
+
+		rc = ceph_check_page_before_write(mapping, wbc,
+						  ceph_wbc, folio);
+		if (rc == -ENODATA) {
+			rc = 0;
+			unlock_page(page);
+			ceph_wbc->fbatch.folios[i] = NULL;
+			continue;
+		} else if (rc == -E2BIG) {
+			rc = 0;
+			unlock_page(page);
+			ceph_wbc->fbatch.folios[i] = NULL;
+			break;
+		}
+
+		if (!clear_page_dirty_for_io(page)) {
+			doutc(cl, "%p !clear_page_dirty_for_io\n", page);
+			unlock_page(page);
+			ceph_wbc->fbatch.folios[i] = NULL;
+			continue;
+		}
+
+		/*
+		 * We have something to write.  If this is
+		 * the first locked page this time through,
+		 * calculate max possible write size and
+		 * allocate a page array
+		 */
+		if (ceph_wbc->locked_pages == 0) {
+			ceph_allocate_page_array(mapping, ceph_wbc, page);
+		} else if (!is_page_index_contiguous(ceph_wbc, page)) {
+			if (is_num_ops_too_big(ceph_wbc)) {
+				redirty_page_for_writepage(wbc, page);
+				unlock_page(page);
+				break;
+			}
+
+			ceph_wbc->num_ops++;
+			ceph_wbc->offset = (u64)page_offset(page);
+			ceph_wbc->len = 0;
+		}
+
+		/* note position of first page in fbatch */
+		doutc(cl, "%llx.%llx will write page %p idx %lu\n",
+		      ceph_vinop(inode), page, page->index);
+
+		fsc->write_congested = is_write_congestion_happened(fsc);
+
+		rc = ceph_move_dirty_page_in_page_array(mapping, wbc,
+							ceph_wbc, page);
+		if (rc) {
+			redirty_page_for_writepage(wbc, page);
+			unlock_page(page);
+			break;
+		}
+
+		ceph_wbc->fbatch.folios[i] = NULL;
+		ceph_wbc->len += thp_size(page);
+	}
+
+	ceph_wbc->processed_in_fbatch = i;
+
+	return rc;
+}
+
 /*
  * initiate async writeback
  */
@@ -1057,7 +1406,6 @@ static int ceph_writepages_start(struct address_space *mapping,
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_client *cl = fsc->client;
 	struct ceph_vino vino = ceph_vino(inode);
-	struct ceph_snap_context *pgsnapc;
 	struct ceph_writeback_ctl ceph_wbc;
 	struct ceph_osd_request *req = NULL;
 	int rc = 0;
@@ -1071,235 +1419,49 @@ static int ceph_writepages_start(struct address_space *mapping,
 	      wbc->sync_mode == WB_SYNC_NONE ? "NONE" :
 	      (wbc->sync_mode == WB_SYNC_ALL ? "ALL" : "HOLD"));
 
-	if (ceph_inode_is_shutdown(inode)) {
-		if (ci->i_wrbuffer_ref > 0) {
-			pr_warn_ratelimited_client(cl,
-				"%llx.%llx %lld forced umount\n",
-				ceph_vinop(inode), ceph_ino(inode));
-		}
-		mapping_set_error(mapping, -EIO);
-		return -EIO; /* we're in a forced umount, don't write! */
+	if (is_forced_umount(mapping)) {
+		/* we're in a forced umount, don't write! */
+		return -EIO;
 	}
 
 	ceph_init_writeback_ctl(mapping, wbc, &ceph_wbc);
 
 retry:
-	/* find oldest snap context with dirty data */
-	ceph_wbc.snapc = get_oldest_context(inode, &ceph_wbc, NULL);
-	if (!ceph_wbc.snapc) {
+	rc = ceph_define_writeback_range(mapping, wbc, &ceph_wbc);
+	if (rc == -ENODATA) {
 		/* hmm, why does writepages get called when there
 		   is no dirty data? */
-		doutc(cl, " no snap context with dirty data?\n");
+		rc = 0;
 		goto out;
 	}
-	doutc(cl, " oldest snapc is %p seq %lld (%d snaps)\n",
-	      ceph_wbc.snapc, ceph_wbc.snapc->seq,
-	      ceph_wbc.snapc->num_snaps);
-
-	ceph_wbc.should_loop = false;
-	if (ceph_wbc.head_snapc && ceph_wbc.snapc != ceph_wbc.last_snapc) {
-		/* where to start/end? */
-		if (wbc->range_cyclic) {
-			ceph_wbc.index = ceph_wbc.start_index;
-			ceph_wbc.end = -1;
-			if (ceph_wbc.index > 0)
-				ceph_wbc.should_loop = true;
-			doutc(cl, " cyclic, start at %lu\n", ceph_wbc.index);
-		} else {
-			ceph_wbc.index = wbc->range_start >> PAGE_SHIFT;
-			ceph_wbc.end = wbc->range_end >> PAGE_SHIFT;
-			if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
-				ceph_wbc.range_whole = true;
-			doutc(cl, " not cyclic, %lu to %lu\n",
-			      ceph_wbc.index, ceph_wbc.end);
-		}
-	} else if (!ceph_wbc.head_snapc) {
-		/* Do not respect wbc->range_{start,end}. Dirty pages
-		 * in that range can be associated with newer snapc.
-		 * They are not writeable until we write all dirty pages
-		 * associated with 'snapc' get written */
-		if (ceph_wbc.index > 0)
-			ceph_wbc.should_loop = true;
-		doutc(cl, " non-head snapc, range whole\n");
-	}
 
 	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
 		tag_pages_for_writeback(mapping, ceph_wbc.index, ceph_wbc.end);
 
-	ceph_put_snap_context(ceph_wbc.last_snapc);
-	ceph_wbc.last_snapc = ceph_wbc.snapc;
-
-	while (!ceph_wbc.done && ceph_wbc.index <= ceph_wbc.end) {
+	while (!has_writeback_done(&ceph_wbc)) {
 		unsigned i;
 		struct page *page;
 
+		ceph_wbc.locked_pages = 0;
 		ceph_wbc.max_pages = ceph_wbc.wsize >> PAGE_SHIFT;
 
 get_more_pages:
+		ceph_folio_batch_reinit(&ceph_wbc);
+
 		ceph_wbc.nr_folios = filemap_get_folios_tag(mapping,
 							    &ceph_wbc.index,
 							    ceph_wbc.end,
 							    ceph_wbc.tag,
 							    &ceph_wbc.fbatch);
-		doutc(cl, "pagevec_lookup_range_tag got %d\n",
-			ceph_wbc.nr_folios);
+		doutc(cl, "pagevec_lookup_range_tag for tag %#x got %d\n",
+			ceph_wbc.tag, ceph_wbc.nr_folios);
+
 		if (!ceph_wbc.nr_folios && !ceph_wbc.locked_pages)
 			break;
-		for (i = 0; i < ceph_wbc.nr_folios &&
-			    ceph_wbc.locked_pages < ceph_wbc.max_pages; i++) {
-			struct folio *folio = ceph_wbc.fbatch.folios[i];
-
-			page = &folio->page;
-			doutc(cl, "? %p idx %lu\n", page, page->index);
-			if (ceph_wbc.locked_pages == 0)
-				lock_page(page);  /* first page */
-			else if (!trylock_page(page))
-				break;
-
-			/* only dirty pages, or our accounting breaks */
-			if (unlikely(!PageDirty(page)) ||
-			    unlikely(page->mapping != mapping)) {
-				doutc(cl, "!dirty or !mapping %p\n", page);
-				unlock_page(page);
-				continue;
-			}
-			/* only if matching snap context */
-			pgsnapc = page_snap_context(page);
-			if (pgsnapc != ceph_wbc.snapc) {
-				doutc(cl, "page snapc %p %lld != oldest %p %lld\n",
-				      pgsnapc, pgsnapc->seq,
-				      ceph_wbc.snapc, ceph_wbc.snapc->seq);
-				if (!ceph_wbc.should_loop &&
-				    !ceph_wbc.head_snapc &&
-				    wbc->sync_mode != WB_SYNC_NONE)
-					ceph_wbc.should_loop = true;
-				unlock_page(page);
-				continue;
-			}
-			if (page_offset(page) >= ceph_wbc.i_size) {
-				doutc(cl, "folio at %lu beyond eof %llu\n",
-				      folio->index, ceph_wbc.i_size);
-				if ((ceph_wbc.size_stable ||
-				    folio_pos(folio) >= i_size_read(inode)) &&
-				    folio_clear_dirty_for_io(folio))
-					folio_invalidate(folio, 0,
-							folio_size(folio));
-				folio_unlock(folio);
-				continue;
-			}
-			if (ceph_wbc.strip_unit_end &&
-			    (page->index > ceph_wbc.strip_unit_end)) {
-				doutc(cl, "end of strip unit %p\n", page);
-				unlock_page(page);
-				break;
-			}
-			if (folio_test_writeback(folio) ||
-			    folio_test_private_2(folio) /* [DEPRECATED] */) {
-				if (wbc->sync_mode == WB_SYNC_NONE) {
-					doutc(cl, "%p under writeback\n", folio);
-					folio_unlock(folio);
-					continue;
-				}
-				doutc(cl, "waiting on writeback %p\n", folio);
-				folio_wait_writeback(folio);
-				folio_wait_private_2(folio); /* [DEPRECATED] */
-			}
-
-			if (!clear_page_dirty_for_io(page)) {
-				doutc(cl, "%p !clear_page_dirty_for_io\n", page);
-				unlock_page(page);
-				continue;
-			}
-
-			/*
-			 * We have something to write.  If this is
-			 * the first locked page this time through,
-			 * calculate max possinle write size and
-			 * allocate a page array
-			 */
-			if (ceph_wbc.locked_pages == 0) {
-				u64 objnum;
-				u64 objoff;
-				u32 xlen;
-
-				/* prepare async write request */
-				ceph_wbc.offset = (u64)page_offset(page);
-				ceph_calc_file_object_mapping(&ci->i_layout,
-							      ceph_wbc.offset,
-							      ceph_wbc.wsize,
-							      &objnum, &objoff,
-							      &xlen);
-				ceph_wbc.len = xlen;
-
-				ceph_wbc.num_ops = 1;
-				ceph_wbc.strip_unit_end = page->index +
-					((ceph_wbc.len - 1) >> PAGE_SHIFT);
-
-				BUG_ON(ceph_wbc.pages);
-				ceph_wbc.max_pages =
-					calc_pages_for(0, (u64)ceph_wbc.len);
-				ceph_wbc.pages = kmalloc_array(ceph_wbc.max_pages,
-						      sizeof(*ceph_wbc.pages),
-						      GFP_NOFS);
-				if (!ceph_wbc.pages) {
-					ceph_wbc.from_pool = true;
-					ceph_wbc.pages =
-						mempool_alloc(ceph_wb_pagevec_pool,
-								GFP_NOFS);
-					BUG_ON(!ceph_wbc.pages);
-				}
 
-				ceph_wbc.len = 0;
-			} else if (page->index !=
-				   (ceph_wbc.offset + ceph_wbc.len) >> PAGE_SHIFT) {
-				if (ceph_wbc.num_ops >=
-				    (ceph_wbc.from_pool ?  CEPH_OSD_SLAB_OPS :
-							     CEPH_OSD_MAX_OPS)) {
-					redirty_page_for_writepage(wbc, page);
-					unlock_page(page);
-					break;
-				}
-
-				ceph_wbc.num_ops++;
-				ceph_wbc.offset = (u64)page_offset(page);
-				ceph_wbc.len = 0;
-			}
-
-			/* note position of first page in fbatch */
-			doutc(cl, "%llx.%llx will write page %p idx %lu\n",
-			      ceph_vinop(inode), page, page->index);
-
-			if (atomic_long_inc_return(&fsc->writeback_count) >
-			    CONGESTION_ON_THRESH(
-				    fsc->mount_options->congestion_kb))
-				fsc->write_congested = true;
-
-			if (IS_ENCRYPTED(inode)) {
-				ceph_wbc.pages[ceph_wbc.locked_pages] =
-					fscrypt_encrypt_pagecache_blocks(page,
-						PAGE_SIZE, 0,
-						ceph_wbc.locked_pages ?
-							GFP_NOWAIT : GFP_NOFS);
-				if (IS_ERR(ceph_wbc.pages[ceph_wbc.locked_pages])) {
-					if (PTR_ERR(ceph_wbc.pages[ceph_wbc.locked_pages]) == -EINVAL)
-						pr_err_client(cl,
-							"inode->i_blkbits=%hhu\n",
-							inode->i_blkbits);
-					/* better not fail on first page! */
-					BUG_ON(ceph_wbc.locked_pages == 0);
-					ceph_wbc.pages[ceph_wbc.locked_pages] = NULL;
-					redirty_page_for_writepage(wbc, page);
-					unlock_page(page);
-					break;
-				}
-				++ceph_wbc.locked_pages;
-			} else {
-				ceph_wbc.pages[ceph_wbc.locked_pages++] = page;
-			}
-
-			ceph_wbc.fbatch.folios[i] = NULL;
-			ceph_wbc.len += thp_size(page);
-		}
+		rc = ceph_process_folio_batch(mapping, wbc, &ceph_wbc);
+		if (rc)
+			goto release_folios;
 
 		/* did we get anything? */
 		if (!ceph_wbc.locked_pages)
-- 
2.48.0


