Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501224C5A41
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Feb 2022 10:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiB0Jfe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 04:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiB0Jfa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 04:35:30 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD82B3B00A;
        Sun, 27 Feb 2022 01:34:54 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id c7so8186936qka.7;
        Sun, 27 Feb 2022 01:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ydXRxafX1EOKVAeUm3spAkjR9HLvDHZhsiMVOXC7pM=;
        b=Ry/pcRhCOPtr1BHLw6EHtZnD+ABBqojtwAXfsBmfqclWrxUkX6MSl4hET36Zct4AbT
         4uOAlghzb+c72+v2pSSvRm9khxVGZyzADyCaA/2p864tFi9InGHoLV0kZrMm87/zxJVh
         VSq5O3bnrSjGRHZCSfSHEs5jlLPJrKFDBq1EveU6WRvxDlNB/p5VOKzVXfQ629fxPNIr
         qawBh26DurhQt+kvkGKMpZaWMscQKuOJlDFAwqqL6UrQyJ9vSzYS3uQG5AL7kRhVM2jS
         wIj427P9ZAnm1FzBk73O1UcZn8Qg1HgpjyUioAIyoz4lhqRQZQr0yTULOXil6Kri7OeG
         NslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ydXRxafX1EOKVAeUm3spAkjR9HLvDHZhsiMVOXC7pM=;
        b=RBxDqXomR6rJ3gjI0kdDutTwO3UiVItGXQolGym3ibmsqmFpB3s2iHHaIG3fhoU+UE
         tbb4XLXWYySI2eEUEgLgVTQmsd2WhwQtdnh35yYxMcFeXffyDnbcT4HLTLoHdLQpQyGM
         uMp1Wdly8GSw/jWijdQa2JF6+iecO/69HB0ghGYZh8ytA58BEFpq82ihEYbFMoFnrqLU
         kYe/iOtlgOOguID81mPla9JEGNy1OwAUfQ0uF2RoAqpjZn1tzKkBzNkjVqO6DrruD0VS
         /rU0sf4sjLF7u1jnUirFpnM/vgb0AMCON7hp3o/pMYVDadrsYtoAfKu+VLIkj15d00rv
         HZgQ==
X-Gm-Message-State: AOAM531cRkW5/f+cqkpiZRqfHyXMSC7TYukbKt/P2InqzCHWfk06gMP5
        eBmln+MbIYDgLgrywzazeN0=
X-Google-Smtp-Source: ABdhPJxMxpMStJYT/anaXMiOzH0PUmpS5c44ybggs8kRB3SW3X4/9Ls7JKzoSQwP278gUHwekI7TMA==
X-Received: by 2002:a05:620a:469f:b0:648:f460:333c with SMTP id bq31-20020a05620a469f00b00648f460333cmr8758089qkb.36.1645954494005;
        Sun, 27 Feb 2022 01:34:54 -0800 (PST)
Received: from sandstorm.attlocal.net (76-242-90-12.lightspeed.sntcca.sbcglobal.net. [76.242.90.12])
        by smtp.gmail.com with ESMTPSA id h3-20020a05622a170300b002e008a93f8fsm469815qtk.91.2022.02.27.01.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 01:34:53 -0800 (PST)
From:   jhubbard.send.patches@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 6/6] fuse: convert direct IO paths to use FOLL_PIN
Date:   Sun, 27 Feb 2022 01:34:34 -0800
Message-Id: <20220227093434.2889464-7-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227093434.2889464-1-jhubbard@nvidia.com>
References: <20220227093434.2889464-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Convert the fuse filesystem to support the new iov_iter_get_pages()
behavior. That routine now invokes pin_user_pages_fast(), which means
that such pages must be released via unpin_user_page(), rather than via
put_page().

This commit also removes any possibility of kernel pages being handled,
in the fuse_get_user_pages() call. Although this may seem like a steep
price to pay, Christoph Hellwig actually recommended it a few years ago
for nearly the same situation [1].

[1] https://lore.kernel.org/kvm/20190724061750.GA19397@infradead.org/

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 fs/fuse/dev.c  |  7 +++++--
 fs/fuse/file.c | 38 +++++++++-----------------------------
 2 files changed, 14 insertions(+), 31 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index e1b4a846c90d..9db85c4d549a 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -675,7 +675,10 @@ static void fuse_copy_finish(struct fuse_copy_state *cs)
 			flush_dcache_page(cs->pg);
 			set_page_dirty_lock(cs->pg);
 		}
-		put_page(cs->pg);
+		if (cs->pipebufs)
+			put_page(cs->pg);
+		else
+			unpin_user_page(cs->pg);
 	}
 	cs->pg = NULL;
 }
@@ -730,7 +733,7 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 		}
 	} else {
 		size_t off;
-		err = iov_iter_get_pages(cs->iter, &page, PAGE_SIZE, 1, &off);
+		err = iov_iter_pin_pages(cs->iter, &page, PAGE_SIZE, 1, &off);
 		if (err < 0)
 			return err;
 		BUG_ON(!err);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 94747bac3489..ecfa5bdde919 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -611,18 +611,6 @@ void fuse_read_args_fill(struct fuse_io_args *ia, struct file *file, loff_t pos,
 	args->out_args[0].size = count;
 }
 
-static void fuse_release_user_pages(struct fuse_args_pages *ap,
-				    bool should_dirty)
-{
-	unsigned int i;
-
-	for (i = 0; i < ap->num_pages; i++) {
-		if (should_dirty)
-			set_page_dirty_lock(ap->pages[i]);
-		put_page(ap->pages[i]);
-	}
-}
-
 static void fuse_io_release(struct kref *kref)
 {
 	kfree(container_of(kref, struct fuse_io_priv, refcnt));
@@ -720,7 +708,8 @@ static void fuse_aio_complete_req(struct fuse_mount *fm, struct fuse_args *args,
 	struct fuse_io_priv *io = ia->io;
 	ssize_t pos = -1;
 
-	fuse_release_user_pages(&ia->ap, io->should_dirty);
+	unpin_user_pages_dirty_lock(ia->ap.pages, ia->ap.num_pages,
+				    io->should_dirty);
 
 	if (err) {
 		/* Nothing */
@@ -1382,25 +1371,14 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 	size_t nbytes = 0;  /* # bytes already packed in req */
 	ssize_t ret = 0;
 
-	/* Special case for kernel I/O: can copy directly into the buffer */
-	if (iov_iter_is_kvec(ii)) {
-		unsigned long user_addr = fuse_get_user_addr(ii);
-		size_t frag_size = fuse_get_frag_size(ii, *nbytesp);
-
-		if (write)
-			ap->args.in_args[1].value = (void *) user_addr;
-		else
-			ap->args.out_args[0].value = (void *) user_addr;
-
-		iov_iter_advance(ii, frag_size);
-		*nbytesp = frag_size;
-		return 0;
-	}
+	/* Only user space buffers are allowed with fuse Direct IO. */
+	if (WARN_ON_ONCE(!iter_is_iovec(ii)))
+		return -EOPNOTSUPP;
 
 	while (nbytes < *nbytesp && ap->num_pages < max_pages) {
 		unsigned npages;
 		size_t start;
-		ret = iov_iter_get_pages(ii, &ap->pages[ap->num_pages],
+		ret = iov_iter_pin_pages(ii, &ap->pages[ap->num_pages],
 					*nbytesp - nbytes,
 					max_pages - ap->num_pages,
 					&start);
@@ -1484,7 +1462,9 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 		}
 
 		if (!io->async || nres < 0) {
-			fuse_release_user_pages(&ia->ap, io->should_dirty);
+			unpin_user_pages_dirty_lock(ia->ap.pages,
+						    ia->ap.num_pages,
+						    io->should_dirty);
 			fuse_io_free(ia);
 		}
 		ia = NULL;
-- 
2.35.1

