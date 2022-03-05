Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C024B4CE2AA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Mar 2022 06:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiCEFJy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Mar 2022 00:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiCEFJy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Mar 2022 00:09:54 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0B656409
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Mar 2022 21:09:04 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id w1so9174472qtj.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Mar 2022 21:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=RRLGmRSN4FEWITZQTBLeanINokMLl7XBSuB1f8u1R8U=;
        b=Qd2Mcb5+9Cp91rLqN/x7h38CVuNBC7gPy+0Nke+8O6T0WZYCjad/ZMzp2FnSbWlhYE
         VOae4qZk7kOo1u/MUyz1U3PGRhof/VcF4eM+bdZys4lQOEUN8Udrae4ObRVdhCs+xrEK
         x6ZOd+290P1XvjppqniCU7Vxl7YH/cZplf9mEesICeJFdUvS1aoNVwpZwQHNzGwCO2Un
         UZSiO31u4dts5CQheLHRMpXNj7ub8LXNye4hiHmFmPKMkQxOt3ZgYI0a5S/nQVus7J1R
         sJtCnY6KgiVYQQRh21s5rQrfRVmtJXZBJXJ5UEGUe8xDVoFgki2e2sE5t91DvCEHpHjn
         WyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=RRLGmRSN4FEWITZQTBLeanINokMLl7XBSuB1f8u1R8U=;
        b=qTpX5TVmm6sXNSkPBJGoCRIaJj4iOlL5Zi5Ek81aO9hN4q/ouF8IGSm0ANDLcV167D
         3T/u4e4KGlmh1zKZy0AsqmTk6CbXlaQuUVKtsFQ3miBldqkbwsEadXz/z3m83Ro18S25
         UQl5hcj9cg+EJKqewEss5M0FBfEh2oLCz/cIsVj8uLwEbmSJ2rnAO6v1FKv7hqoclTdm
         EvZrC8BieNVm4wY12HO+8f87PmHiS4w/xaOkv/rgDK9fS6pwaSYVp0T7aYzGgdOw5CFN
         pTiiSOWr78AjKqRFjxYHV+px/OeG3OeBzuBevJMzcAxe/TA7X4IgQQuuN7qMdTvt1aes
         ne/g==
X-Gm-Message-State: AOAM533Sb3rLjlbO3LQuIpXqPUUrWoMU3tRieBtprWwCMQwo5ucllYxG
        hh073PCwv2x8cf3Jtr6VCU0GgA==
X-Google-Smtp-Source: ABdhPJwyQuaxpv8fho+9kTbdzDIGjjpwV0LJxK/pKpMXlHUA4J5IgQrWtQcCEraaAueh5IEKRwMooQ==
X-Received: by 2002:a05:622a:60b:b0:2dd:9686:da7e with SMTP id z11-20020a05622a060b00b002dd9686da7emr1753263qta.513.1646456943432;
        Fri, 04 Mar 2022 21:09:03 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c16-20020a05622a059000b002dc93dc92d1sm4894991qtb.48.2022.03.04.21.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 21:09:02 -0800 (PST)
Date:   Fri, 4 Mar 2022 21:09:01 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@lst.de>, Borislav Petkov <bp@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH mmotm] tmpfs: do not allocate pages on read
Message-ID: <f9c2f38f-5eb8-5d30-40fa-93e88b5fbc51@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
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
the ZERO_PAGE as Uptodate, which of course it is; doing so here in
shmem_file_read_iter() is distasteful, but seems to be the best way.

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

 mm/shmem.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

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
@@ -2580,9 +2570,15 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			 */
 			if (!offset)
 				mark_page_accessed(page);
+			got_page = true;
 		} else {
 			page = ZERO_PAGE(0);
-			get_page(page);
+			/*
+			 * Let splice page_cache_pipe_buf_confirm() succeed.
+			 */
+			if (!PageUptodate(page))
+				SetPageUptodate(page);
+			got_page = false;
 		}
 
 		/*
@@ -2595,7 +2591,8 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		index += offset >> PAGE_SHIFT;
 		offset &= ~PAGE_MASK;
 
-		put_page(page);
+		if (got_page)
+			put_page(page);
 		if (!iov_iter_count(to))
 			break;
 		if (ret < nr) {
