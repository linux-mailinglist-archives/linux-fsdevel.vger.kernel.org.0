Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE2F4CEE49
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Mar 2022 23:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiCFXAD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Mar 2022 18:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbiCFXAC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Mar 2022 18:00:02 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A731C5D5EC
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Mar 2022 14:59:08 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id l25so13471632oic.13
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Mar 2022 14:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=kuAwFNdvfUoB+jhabmE+ejZcyF5svphRQA7Cw43kwi8=;
        b=kPpUrffhO4TxCVaOXzvYs3e+cRGTHM3KtZ7WfofY+N2dasiK1j/6xoWwLR2tAm09KP
         mebxc6zSJHXoGueC47+fk0VBombrG/KE4uWHWY1VJhkV50ZNt525Cds4bc+B/USeEcG7
         FIHMN5Hvi+uN4TskszrITE8f5QC/SJqiuC/FeXphySHlXyGsD4Iu9boUgR5OXeE9FWf8
         3LXroc8K5k3cLjEyDk/dp+yW6EvpFaIggjg6OHx66pO6L76jeZLWAcdg8fK3AuISQl/y
         JXmV3xxAcUXzM6hXZRv7rdyt7uHpCNKZMqXbOa+l5A4VdxulEsmI5VwOHylGRJjlwwfw
         E+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=kuAwFNdvfUoB+jhabmE+ejZcyF5svphRQA7Cw43kwi8=;
        b=xaLalxRzv8JQH0qOPw8KMIQI/TPgsB/R/kCJHW0k7XjPaZcBulR4MRcuJlvh5uOpf1
         Vqwq3xNuKjpgw1zFUthlACpZEnf758Q4is9/HKuM9JXNHIFqCmQ9h1TvmF5K2LDipbvw
         9c4kY3Ik+EJ4yzDytQwkM/aOhNw/6U518wi0RHjXA8kxqmOoGMDOvrdwCprwzSc/fK1c
         0vGTCmf9+DfDPQ3Oap/VNfAsazGwEa7xqvJ+p0sGGEX9W2WY28ckM0Pg1wxY8rcEVqJa
         BAtlgUY6tL/CFQSseHX/S/vCL3NwojIrpK3aaDtDoTAwPdjNZLh1YGjxCVYdzrnzexBP
         GOUw==
X-Gm-Message-State: AOAM5331IocUQmGQ3vqsl7zusBNbkqzbk6cUiySeOQkPo0rBTGUF96J8
        xRs43m5gphwjpzLdvGdCA6OymQ==
X-Google-Smtp-Source: ABdhPJx/Hqu7SfzlGzmEpo8d7O7y359VqM5bOvt1wDfmQObfLuYDP6UYX4MMELpvv/a9avdsR+wwjQ==
X-Received: by 2002:a05:6808:18a7:b0:2d4:6a7e:23e6 with SMTP id bi39-20020a05680818a700b002d46a7e23e6mr5771492oib.152.1646607547846;
        Sun, 06 Mar 2022 14:59:07 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 67-20020aca0746000000b002d71928659dsm5586722oih.8.2022.03.06.14.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 14:59:07 -0800 (PST)
Date:   Sun, 6 Mar 2022 14:59:05 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>, Christoph Hellwig <hch@lst.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Borislav Petkov <bp@suse.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH mmotm v2] tmpfs: do not allocate pages on read
In-Reply-To: <20220306092709.GA22883@lst.de>
Message-ID: <90bc5e69-9984-b5fa-a685-be55f2b64b@google.com>
References: <f9c2f38f-5eb8-5d30-40fa-93e88b5fbc51@google.com> <20220306092709.GA22883@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mikulas asked in
https://lore.kernel.org/linux-mm/alpine.LRH.2.02.2007210510230.6959@file01.intranet.prod.int.rdu2.redhat.com/
Do we still need a0ee5ec520ed ("tmpfs: allocate on read when stacked")?

Lukas noticed this unusual behavior of loop device backed by tmpfs in
https://lore.kernel.org/linux-mm/20211126075100.gd64odg2bcptiqeb@work/

Normally, shmem_file_read_iter() copies the ZERO_PAGE when reading holes;
but if it looks like it might be a read for "a stacking filesystem", it
allocates actual pages to the page cache, and even marks them as dirty.
And reads from the loop device do satisfy the test that is used.

This oddity was added for an old version of unionfs, to help to limit
its usage to the limited size of the tmpfs mount involved; but about
the same time as the tmpfs mod went in (2.6.25), unionfs was reworked
to proceed differently; and the mod kept just in case others needed it.

Do we still need it? I cannot answer with more certainty than "Probably
not". It's nasty enough that we really should try to delete it; but if
a regression is reported somewhere, then we might have to revert later.

It's not quite as simple as just removing the test (as Mikulas did):
xfstests generic/013 hung because splice from tmpfs failed on page not
up-to-date and page mapping unset.  That can be fixed just by marking
the ZERO_PAGE as Uptodate, which of course it is: do so in
pagecache_init() - it might be useful to others than tmpfs.

My intention, though, was to stop using the ZERO_PAGE here altogether:
surely iov_iter_zero() is better for this case?  Sadly not: it relies
on clear_user(), and the x86 clear_user() is slower than its copy_user():
https://lore.kernel.org/lkml/2f5ca5e4-e250-a41c-11fb-a7f4ebc7e1c9@google.com/

But while we are still using the ZERO_PAGE, let's stop dirtying its
struct page cacheline with unnecessary get_page() and put_page().

Reported-by: Mikulas Patocka <mpatocka@redhat.com>
Reported-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Hugh Dickins <hughd@google.com>
---
v2: Set ZERO_PAGE uptodate during init, per hch.

 mm/filemap.c |  6 ++++++
 mm/shmem.c   | 20 ++++++--------------
 2 files changed, 12 insertions(+), 14 deletions(-)

--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1063,6 +1063,12 @@ void __init pagecache_init(void)
 		init_waitqueue_head(&folio_wait_table[i]);
 
 	page_writeback_init();
+
+	/*
+	 * tmpfs uses the ZERO_PAGE for reading holes: it is up-to-date,
+	 * and splice's page_cache_pipe_buf_confirm() needs to see that.
+	 */
+	SetPageUptodate(ZERO_PAGE(0));
 }
 
 /*
diff --git a/mm/shmem.c b/mm/shmem.c
index 3c346f2e557f..659bd599d731 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2501,19 +2501,10 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct address_space *mapping = inode->i_mapping;
 	pgoff_t index;
 	unsigned long offset;
-	enum sgp_type sgp = SGP_READ;
 	int error = 0;
 	ssize_t retval = 0;
 	loff_t *ppos = &iocb->ki_pos;
 
-	/*
-	 * Might this read be for a stacking filesystem?  Then when reading
-	 * holes of a sparse file, we actually need to allocate those pages,
-	 * and even mark them dirty, so it cannot exceed the max_blocks limit.
-	 */
-	if (!iter_is_iovec(to))
-		sgp = SGP_CACHE;
-
 	index = *ppos >> PAGE_SHIFT;
 	offset = *ppos & ~PAGE_MASK;
 
@@ -2522,6 +2513,7 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		pgoff_t end_index;
 		unsigned long nr, ret;
 		loff_t i_size = i_size_read(inode);
+		bool got_page;
 
 		end_index = i_size >> PAGE_SHIFT;
 		if (index > end_index)
@@ -2532,15 +2524,13 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 				break;
 		}
 
-		error = shmem_getpage(inode, index, &page, sgp);
+		error = shmem_getpage(inode, index, &page, SGP_READ);
 		if (error) {
 			if (error == -EINVAL)
 				error = 0;
 			break;
 		}
 		if (page) {
-			if (sgp == SGP_CACHE)
-				set_page_dirty(page);
 			unlock_page(page);
 
 			if (PageHWPoison(page)) {
@@ -2580,9 +2570,10 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			 */
 			if (!offset)
 				mark_page_accessed(page);
+			got_page = true;
 		} else {
 			page = ZERO_PAGE(0);
-			get_page(page);
+			got_page = false;
 		}
 
 		/*
@@ -2595,7 +2586,8 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		index += offset >> PAGE_SHIFT;
 		offset &= ~PAGE_MASK;
 
-		put_page(page);
+		if (got_page)
+			put_page(page);
 		if (!iov_iter_count(to))
 			break;
 		if (ret < nr) {
