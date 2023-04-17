Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4713C6E3E9A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 06:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjDQEqg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 00:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjDQEqe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 00:46:34 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F7935BC
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Apr 2023 21:46:32 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-54fb615ac3dso192491737b3.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Apr 2023 21:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681706792; x=1684298792;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7RMbe6t8cwMwC4L+hDo6tlAvnHa7eL2NdAx0QI15tWA=;
        b=c1lvjA2Ydr0KKWFVOurlEuJLUUiQc/fd5uFEN6VsS61oIZ+QIKo9crxs9j3T2Iaqb8
         O0bQpK7v7bm+8V4tAh2R8nFUz7Ugm61CMH66mrUWcnaW3cUBj0dra+tYZ1dM7R3ctbu7
         l/L43imdrVY+1oDd+OPtXfYeEVbXrW73SmRKmSwjTBWAaZi8+hYGbksw0BetMOlV2hOm
         s+CLHiAKG797aQeXHH3LJQGarc2O476afCnrfdwgInbC6MI63fsZSBNG7r1ZJx7r28NE
         nobICetFvaOEDfIzUUzzyi8cUeTNUEO8mJIHwZXxYulQBrZQ+AXdzWfGxnHNKh9SSvbq
         rYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681706792; x=1684298792;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7RMbe6t8cwMwC4L+hDo6tlAvnHa7eL2NdAx0QI15tWA=;
        b=HD0T+6B/47nMIWQfF3oykWD1YLFgdp44LVsJVnHvUPLP0wXJCxek8VnAFcm99F/bYz
         2fMTHWlfAk2bYyCpHCnKE1aVlFcmrA7VZRjm7vc6JiQk6nEbOW3u3Qs7PBbm047RSmxn
         mWd1FI18uH6C0bHiKq2ReSH9H1EoNt22wU/tUjHo81JL+1eTZR0cdVyZAtWbvFvqoDVR
         KByUmXzyZJbzK57Ee3iRojkdGmSlURb1KENWhpQMhv7KpQLO64D8E9xO85/x8ada0lfk
         aMgz+yK2q/eoPDqCjkvO4sNNDdgvLssFT6QAqSjcfI3d4o6iJ/EoeC2C0jNo5SsRR0vB
         hMbg==
X-Gm-Message-State: AAQBX9dNW7qQvKL80pS5qvUlYivIHOrwtVhGnf8MHpUYRsnmS25L0kkv
        EmiWAvxVOG58M3Hn0k8x+8Qj3A==
X-Google-Smtp-Source: AKy350bB7WbtLMHSyStHV27G5/XguAU1bkC12dSQmwfI/VO4RT1/tD2O8SYSmrnwX7w62M2HdexZQQ==
X-Received: by 2002:a81:4951:0:b0:54f:e0e7:c6fb with SMTP id w78-20020a814951000000b0054fe0e7c6fbmr9832191ywa.8.1681706790262;
        Sun, 16 Apr 2023 21:46:30 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id cm19-20020a05690c0c9300b00545a08184e0sm2903022ywb.112.2023.04.16.21.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 21:46:29 -0700 (PDT)
Date:   Sun, 16 Apr 2023 21:46:16 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     David Howells <dhowells@redhat.com>
cc:     Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH next] shmem: minor fixes to splice-read implementation
Message-ID: <2d5fa5e3-dac5-6973-74e5-eeedf36a42b@google.com>
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

generic_file_splice_read() makes a couple of preliminary checks (for
s_maxbytes and zero len), but shmem_file_splice_read() is called without
those: so check them inside it.  (But shmem does not support O_DIRECT,
so no need for that one here - and even if O_DIRECT support were stubbed
in, it would still just be using the page cache.)

HWPoison: my reading of folio_test_hwpoison() is that it only tests the
head page of a large folio, whereas splice_folio_into_pipe() will splice
as much of the folio as it can: so for safety we should also check the
has_hwpoisoned flag, set if any of the folio's pages are hwpoisoned.
(Perhaps that ugliness can be improved at the mm end later.)

The call to splice_zeropage_into_pipe() risked overrunning past EOF:
ask it for "part" not "len".

Fixes: b81d7b89becc ("shmem: Implement splice-read")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
Thank you, David, for attending to tmpfs in your splice update:
yes, I too wish it could have just used the generic, but I'm sure
you're right that there's a number of reasons it needs its own.

 mm/shmem.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2902,6 +2902,11 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 	loff_t isize;
 	int error = 0;
 
+	if (unlikely(*ppos >= MAX_LFS_FILESIZE))
+		return 0;
+	if (unlikely(!len))
+		return 0;
+
 	/* Work out how much data we can actually add into the pipe */
 	used = pipe_occupancy(pipe->head, pipe->tail);
 	npages = max_t(ssize_t, pipe->max_usage - used, 0);
@@ -2911,7 +2916,8 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 		if (*ppos >= i_size_read(inode))
 			break;
 
-		error = shmem_get_folio(inode, *ppos / PAGE_SIZE, &folio, SGP_READ);
+		error = shmem_get_folio(inode, *ppos / PAGE_SIZE, &folio,
+					SGP_READ);
 		if (error) {
 			if (error == -EINVAL)
 				error = 0;
@@ -2920,7 +2926,9 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 		if (folio) {
 			folio_unlock(folio);
 
-			if (folio_test_hwpoison(folio)) {
+			if (folio_test_hwpoison(folio) ||
+			    (folio_test_large(folio) &&
+			     folio_test_has_hwpoisoned(folio))) {
 				error = -EIO;
 				break;
 			}
@@ -2956,7 +2964,7 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 			folio_put(folio);
 			folio = NULL;
 		} else {
-			n = splice_zeropage_into_pipe(pipe, *ppos, len);
+			n = splice_zeropage_into_pipe(pipe, *ppos, part);
 		}
 
 		if (!n)
