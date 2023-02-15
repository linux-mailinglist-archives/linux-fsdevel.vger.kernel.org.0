Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88E1697B53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 13:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjBOMBO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 07:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbjBOMBE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:01:04 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24FD38656
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Feb 2023 04:00:46 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id fi26so21679120edb.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Feb 2023 04:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTdIxWofoZbrNI+0T5uLIfywbnnYI1faqI99lTcvgD4=;
        b=DPicoMrchplmMVruPuhN53nBF3IEotLq2L0p8YcPJQ/0AhVREKehl4KLdc0YoUq0I6
         NvKJ2gKHd8Gw7UWHAIIsgLMBdwJyAez/8/bqIo/2lCe9Nb/2JXiQhOZ3iIgJgDFwIWij
         piXl5UgaHibBzS/wSK2geYlTyiHZbKnOGSBGuZgLG5pzX9QxpD38KQgkRBF8j7cNBoWx
         JSOQLarV6h92oB3j4J0q7X3dH4XcGSAP8PgHMgG6p9NB+wuKkCbLzta/Avvx+MLgyfZv
         Uh6RmRfo3OiAwRm4U3D3XIK76pCRL/0GMLimRRuOeDYN+P4XN8YpkW/XTRWkzHyJltCo
         O46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTdIxWofoZbrNI+0T5uLIfywbnnYI1faqI99lTcvgD4=;
        b=lUQRoZ7uQXale5mcAhAQBQw4Glfjk23+hitrQvV9rjhkIIxbDrJm7xKt4RjqpUaH2S
         +8/k060sjIA1fI7/EQ6DasIC0h0NLA++mHVEIeK19vHcqa8YaSTYqSseGtg8x1lZvEJ0
         BY8GgMS1TrH1ntkkOEbGodfEQpESepxV5mFB9gsYNxzD3JDwMkDS0j/GFSQPlVIroLAX
         ozmIjKSjP5GWpF4TYApnDS/4su42CkuG3bSIanIQ6cDNWReYwv3dKvyDI6VCjlp+UveC
         bXmsjTDwgKMB9IEackT47nTo4Vk1p889UNhk9FauFkcnQUM2HFljGbmc6sB381acZbby
         TSRw==
X-Gm-Message-State: AO0yUKWgiX+PgiArTOKz5p6w6maWQ25MtDhdrKo8pnQTrj/INrC7R3K+
        5NC8KIFhOWhCSNmCasO61bMT7J5MJvO5fxP5
X-Google-Smtp-Source: AK7set+hCDLUEnIdvXW6KZUjw70YbZYedf6amBYRgn/9tgsiKw/kn/BqszQM6Js3Oo3miu4VimUPLg==
X-Received: by 2002:a50:ec85:0:b0:4ad:66b:84a6 with SMTP id e5-20020a50ec85000000b004ad066b84a6mr1654860edr.13.1676462445119;
        Wed, 15 Feb 2023 04:00:45 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id h2-20020a056402094200b004acb42134c4sm7001477edz.70.2023.02.15.04.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 04:00:44 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 15 Feb 2023 13:00:39 +0100
Subject: [PATCH 2/2] Revert "splice: Do splice read from a buffered file
 without using ITER_PIPE"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230215-topic-next-20230214-revert-v1-2-c58cd87b9086@linaro.org>
References: <20230215-topic-next-20230214-revert-v1-0-c58cd87b9086@linaro.org>
In-Reply-To: <20230215-topic-next-20230214-revert-v1-0-c58cd87b9086@linaro.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-mm@kvack.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676462440; l=5678;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=GhZqoVotGOrdGVVTlpDSlth0cBTnSieaqw2vZSOgwMg=;
 b=kNOAlZxm146sX4RVEP1agu2t6Duxj4iwCjq2UwEUESRutNpNxNhcL8oQbqfeiw57PyJEeXzT37Oe
 coVqbCJODCzECjLMISdgy6cJo3Khk2+tqwAcR/SUcXvaAedyrvLB
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

next-20230213 introduced commit d9722a475711 ("splice: Do splice read from
a buffered file without using ITER_PIPE") which broke booting on any
Qualcomm ARM64 device I grabbed, dereferencing a null pointer in
generic_filesplice_read+0xf8/x598. Revert it to make the devices
bootable again.

This reverts commit d9722a47571104f7fa1eeb5ec59044d3607c6070.
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 fs/splice.c | 159 +++++++++---------------------------------------------------
 1 file changed, 24 insertions(+), 135 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index fa82dfee1ed0..10b258250868 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -22,7 +22,6 @@
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/pagemap.h>
-#include <linux/pagevec.h>
 #include <linux/splice.h>
 #include <linux/memcontrol.h>
 #include <linux/mm_inline.h>
@@ -378,135 +377,6 @@ static ssize_t generic_file_direct_splice_read(struct file *in, loff_t *ppos,
 	return ret;
 }
 
-/*
- * Splice subpages from a folio into a pipe.
- */
-static size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
-				     struct folio *folio,
-				     loff_t fpos, size_t size)
-{
-	struct page *page;
-	size_t spliced = 0, offset = offset_in_folio(folio, fpos);
-
-	page = folio_page(folio, offset / PAGE_SIZE);
-	size = min(size, folio_size(folio) - offset);
-	offset %= PAGE_SIZE;
-
-	while (spliced < size &&
-	       !pipe_full(pipe->head, pipe->tail, pipe->max_usage)) {
-		struct pipe_buffer *buf = &pipe->bufs[pipe->head & (pipe->ring_size - 1)];
-		size_t part = min_t(size_t, PAGE_SIZE - offset, size - spliced);
-
-		*buf = (struct pipe_buffer) {
-			.ops	= &page_cache_pipe_buf_ops,
-			.page	= page,
-			.offset	= offset,
-			.len	= part,
-		};
-		folio_get(folio);
-		pipe->head++;
-		page++;
-		spliced += part;
-		offset = 0;
-	}
-
-	return spliced;
-}
-
-/*
- * Splice folios from the pagecache of a buffered (ie. non-O_DIRECT) file into
- * a pipe.
- */
-static ssize_t generic_file_buffered_splice_read(struct file *in, loff_t *ppos,
-						 struct pipe_inode_info *pipe,
-						 size_t len,
-						 unsigned int flags)
-{
-	struct folio_batch fbatch;
-	size_t total_spliced = 0, used, npages;
-	loff_t isize, end_offset;
-	bool writably_mapped;
-	int i, error = 0;
-
-	struct kiocb iocb = {
-		.ki_filp	= in,
-		.ki_pos		= *ppos,
-	};
-
-	/* Work out how much data we can actually add into the pipe */
-	used = pipe_occupancy(pipe->head, pipe->tail);
-	npages = max_t(ssize_t, pipe->max_usage - used, 0);
-	len = min_t(size_t, len, npages * PAGE_SIZE);
-
-	folio_batch_init(&fbatch);
-
-	do {
-		cond_resched();
-
-		if (*ppos >= i_size_read(file_inode(in)))
-			break;
-
-		iocb.ki_pos = *ppos;
-		error = filemap_get_pages(&iocb, len, &fbatch, true);
-		if (error < 0)
-			break;
-
-		/*
-		 * i_size must be checked after we know the pages are Uptodate.
-		 *
-		 * Checking i_size after the check allows us to calculate
-		 * the correct value for "nr", which means the zero-filled
-		 * part of the page is not copied back to userspace (unless
-		 * another truncate extends the file - this is desired though).
-		 */
-		isize = i_size_read(file_inode(in));
-		if (unlikely(*ppos >= isize))
-			break;
-		end_offset = min_t(loff_t, isize, *ppos + len);
-
-		/*
-		 * Once we start copying data, we don't want to be touching any
-		 * cachelines that might be contended:
-		 */
-		writably_mapped = mapping_writably_mapped(in->f_mapping);
-
-		for (i = 0; i < folio_batch_count(&fbatch); i++) {
-			struct folio *folio = fbatch.folios[i];
-			size_t n;
-
-			if (folio_pos(folio) >= end_offset)
-				goto out;
-			folio_mark_accessed(folio);
-
-			/*
-			 * If users can be writing to this folio using arbitrary
-			 * virtual addresses, take care of potential aliasing
-			 * before reading the folio on the kernel side.
-			 */
-			if (writably_mapped)
-				flush_dcache_folio(folio);
-
-			n = splice_folio_into_pipe(pipe, folio, *ppos, len);
-			if (!n)
-				goto out;
-			len -= n;
-			total_spliced += n;
-			*ppos += n;
-			in->f_ra.prev_pos = *ppos;
-			if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
-				goto out;
-		}
-
-		folio_batch_release(&fbatch);
-	} while (len);
-
-out:
-	folio_batch_release(&fbatch);
-	file_accessed(in);
-
-	return total_spliced ? total_spliced : error;
-}
-
 /**
  * generic_file_splice_read - splice data from file to a pipe
  * @in:		file to splice from
@@ -524,13 +394,32 @@ ssize_t generic_file_splice_read(struct file *in, loff_t *ppos,
 				 struct pipe_inode_info *pipe, size_t len,
 				 unsigned int flags)
 {
-	if (unlikely(*ppos >= file_inode(in)->i_sb->s_maxbytes))
-		return 0;
-	if (unlikely(!len))
-		return 0;
+	struct iov_iter to;
+	struct kiocb kiocb;
+	int ret;
+
 	if (in->f_flags & O_DIRECT)
 		return generic_file_direct_splice_read(in, ppos, pipe, len, flags);
-	return generic_file_buffered_splice_read(in, ppos, pipe, len, flags);
+
+	iov_iter_pipe(&to, ITER_DEST, pipe, len);
+	init_sync_kiocb(&kiocb, in);
+	kiocb.ki_pos = *ppos;
+	ret = call_read_iter(in, &kiocb, &to);
+	if (ret > 0) {
+		*ppos = kiocb.ki_pos;
+		file_accessed(in);
+	} else if (ret < 0) {
+		/* free what was emitted */
+		pipe_discard_from(pipe, to.start_head);
+		/*
+		 * callers of ->splice_read() expect -EAGAIN on
+		 * "can't put anything in there", rather than -EFAULT.
+		 */
+		if (ret == -EFAULT)
+			ret = -EAGAIN;
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL(generic_file_splice_read);
 

-- 
2.39.1

