Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7BE4F9E4C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 22:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239545AbiDHUlD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 16:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239543AbiDHUlC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:41:02 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A84339174
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Apr 2022 13:38:55 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id s4so5771370qkh.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Apr 2022 13:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=9HwDppLqHaQcBs/UBe2aw4cxWmdlTn3unTRBCytLFO0=;
        b=kDWT7DbLIXeryuqgzJKXPRooe+DFb5VrAV9s8VQQh3/+L/jkAAOBZkzbwMa9Y+oos5
         xnxE+TBlfk7ynX1+gqkkuP3JzEVI8mo5QCIzJjw4NrdeaKKiBsjlQPa32LF4zQlR8CMo
         qxfJz6xxrivp2BwcN71Gyk/3z0QMnL9Gmeu3Da1e3QfE4v/4pQSGcCwMiLyOcku5wgHf
         CZfBgZObe0vK4UJoPcPOS8TbVZaWAoObLYWjFjYFc3HV77ztvqr9DZRoGtYuTW224KS0
         nv+SXeVtLimXZK1E6e75cZMoMhsooPeZNKUKc0CnODdMdlAwq5ZZ3HIupplfob3LOqv4
         T//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=9HwDppLqHaQcBs/UBe2aw4cxWmdlTn3unTRBCytLFO0=;
        b=uBFtwNWT5TCO+NXOhAw6RD77wYtZ3YXXIUS1YY/NgHHcW7XjhM4E4i4gkzPZx9ykfz
         GCUFTy9NOYVtYer+1W89QC4kY0JtdykAJCy/aNZKigwRZNhijRL9ZKkfc0zBfM5lRbaV
         loIQotK07N+2CSpchJ5v/6Z3p20A5WIkhOW/2Zxi2dMLolhVhuN7k/BEG4ioeh1ZRjL3
         6F44BKiEXFKi0wSjZk/e+4sDxpqZzFWr+H+ky/Z66N3ScDl77DiPVYFlBbWuauV5emNP
         KDhBfEVPhaUeQzFBJO+siQvvs8eJGa/OsaX2/H4raM8pXWijtA3gucTbegwgY44SbaVl
         XUuQ==
X-Gm-Message-State: AOAM530PcNLhdxsyJOtVRyqK2XuBQxc6QWB+LPsFVyStgjqFltF203oc
        TDVxGcjNZyhDBeCqYJ7vIOFX3g==
X-Google-Smtp-Source: ABdhPJxNNfuUtbU+jVA4OD408wRYRnD+uHeEDWk6oAgIVTm4FABTOcVGdZuqmIMJ8LrzmwY67c43ig==
X-Received: by 2002:a37:b983:0:b0:67e:c0d2:c3ca with SMTP id j125-20020a37b983000000b0067ec0d2c3camr13883611qkf.749.1649450334495;
        Fri, 08 Apr 2022 13:38:54 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k2-20020a37ba02000000b0067dc1b0104asm13964961qkf.124.2022.04.08.13.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 13:38:53 -0700 (PDT)
Date:   Fri, 8 Apr 2022 13:38:41 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Mark Hemment <markhemm@googlemail.com>,
        Patrice CHOTARD <patrice.chotard@foss.st.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] tmpfs: fix regressions from wider use of ZERO_PAGE
Message-ID: <9a978571-8648-e830-5735-1f4748ce2e30@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Chuck Lever reported fsx-based xfstests generic 075 091 112 127 failing
when 5.18-rc1 NFS server exports tmpfs: bisected to recent tmpfs change.

Whilst nfsd_splice_action() does contain some questionable handling of
repeated pages, and Chuck was able to work around there, history from
Mark Hemment makes clear that there might be similar dangers elsewhere:
it was not a good idea for me to pass ZERO_PAGE down to unknown actors.

Revert shmem_file_read_iter() to using ZERO_PAGE for holes only when
iter_is_iovec(); in other cases, use the more natural iov_iter_zero()
instead of copy_page_to_iter().  We would use iov_iter_zero() throughout,
but the x86 clear_user() is not nearly so well optimized as copy to user
(dd of 1T sparse tmpfs file takes 57 seconds rather than 44 seconds).

And now pagecache_init() does not need to SetPageUptodate(ZERO_PAGE(0)):
which had caused boot failure on arm noMMU STM32F7 and STM32H7 boards
Reported-by: Patrice CHOTARD <patrice.chotard@foss.st.com>

Reported-by: Chuck Lever III <chuck.lever@oracle.com>
Fixes: 56a8c8eb1eaf ("tmpfs: do not allocate pages on read")
Signed-off-by: Hugh Dickins <hughd@google.com>
Tested-by: Chuck Lever III <chuck.lever@oracle.com>
---

 mm/filemap.c |    6 ------
 mm/shmem.c   |   31 ++++++++++++++++++++-----------
 2 files changed, 20 insertions(+), 17 deletions(-)

--- 5.18-rc1/mm/filemap.c
+++ linux/mm/filemap.c
@@ -1063,12 +1063,6 @@ void __init pagecache_init(void)
 		init_waitqueue_head(&folio_wait_table[i]);
 
 	page_writeback_init();
-
-	/*
-	 * tmpfs uses the ZERO_PAGE for reading holes: it is up-to-date,
-	 * and splice's page_cache_pipe_buf_confirm() needs to see that.
-	 */
-	SetPageUptodate(ZERO_PAGE(0));
 }
 
 /*
--- 5.18-rc1/mm/shmem.c
+++ linux/mm/shmem.c
@@ -2513,7 +2513,6 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		pgoff_t end_index;
 		unsigned long nr, ret;
 		loff_t i_size = i_size_read(inode);
-		bool got_page;
 
 		end_index = i_size >> PAGE_SHIFT;
 		if (index > end_index)
@@ -2570,24 +2569,34 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			 */
 			if (!offset)
 				mark_page_accessed(page);
-			got_page = true;
+			/*
+			 * Ok, we have the page, and it's up-to-date, so
+			 * now we can copy it to user space...
+			 */
+			ret = copy_page_to_iter(page, offset, nr, to);
+			put_page(page);
+
+		} else if (iter_is_iovec(to)) {
+			/*
+			 * Copy to user tends to be so well optimized, but
+			 * clear_user() not so much, that it is noticeably
+			 * faster to copy the zero page instead of clearing.
+			 */
+			ret = copy_page_to_iter(ZERO_PAGE(0), offset, nr, to);
 		} else {
-			page = ZERO_PAGE(0);
-			got_page = false;
+			/*
+			 * But submitting the same page twice in a row to
+			 * splice() - or others? - can result in confusion:
+			 * so don't attempt that optimization on pipes etc.
+			 */
+			ret = iov_iter_zero(nr, to);
 		}
 
-		/*
-		 * Ok, we have the page, and it's up-to-date, so
-		 * now we can copy it to user space...
-		 */
-		ret = copy_page_to_iter(page, offset, nr, to);
 		retval += ret;
 		offset += ret;
 		index += offset >> PAGE_SHIFT;
 		offset &= ~PAGE_MASK;
 
-		if (got_page)
-			put_page(page);
 		if (!iov_iter_count(to))
 			break;
 		if (ret < nr) {
