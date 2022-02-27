Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2777D4C5A37
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Feb 2022 10:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiB0Jfa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 04:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiB0Jf1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 04:35:27 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FA73AA7B;
        Sun, 27 Feb 2022 01:34:49 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id w1so6522740qtj.2;
        Sun, 27 Feb 2022 01:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2eyP4rVDSLxrBLm0L+IwXDpvwWoEKTOhBFmzO4cexJA=;
        b=SN1X/MqfJvhVYBUGyOf9BOYeLe+NmaeROrl70bvkK+f00RgsVrca1L7kNXuD/wcg9L
         xKCmZ2Pz8vWSqvhZGTSGz0bn+yPC7pzdLsxbAHOC7niJ2xUIRbSdTA006UFl43cSvClB
         Eu/WiEesp2A/IaFSnGxRHNzF65Nbr5OEyJxl/q5scyullQobittuRA9RsL64YhSAmZeE
         yblyQp16l6Hjn1nxs1PK37HlbUKIs3dYdip0CwpH9Jr/Npemuiakh89gz0E28sfp/eVK
         AuxWm+yRqP6ewJ+xN63QF5PgRvRcwe0IkEbB5ckzEiEAwC6gCacSZreeldbSK5SU8twf
         hn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2eyP4rVDSLxrBLm0L+IwXDpvwWoEKTOhBFmzO4cexJA=;
        b=0PpvTNKODLTorwdWHYzIDjdlx80ZfY8EZ7gCZyIG0SBk77BjNOQfQYA1JUqiFbVLh/
         bMmCf3qyu9RHfGjzkS86kn/m8ErqhNhxKoBiW2uYadfZqacyyq6TVTDZCsAg6p+v3zwG
         IC2RAk/a4Y0vQ5qQNelB/YxpvHnyiaBmM4mcX2tPSOHzZci2z2hRc0KCBb9lsDeigwAM
         E6M2o8W2MP2SwvEKMeGn+3ToATpIxbOttO8F79uqYw7lUOagYldZ+k5+Q18rKe7TjLtx
         JUewG+phf5bJlJ00MGjHKZyuR6CWOJ8Az1dlOMk+TOjmSz+uayGgnYH1AZdmEeJrsK+G
         qYNg==
X-Gm-Message-State: AOAM531R8RacKMfWfEV96KA95DGWs1pzWbQRi8x38/8QWw95sHBWsrz7
        aDsqSI4cyLxkj5mlNEXJ3SM=
X-Google-Smtp-Source: ABdhPJyOSOodlyfcTfw39UkAF/bKoLbJjNNh1s2ZWZwG1dKH8ifuQJeJtZRTl4AMh8in27Ux3laN9Q==
X-Received: by 2002:a05:622a:2c6:b0:2dd:2d3d:11cd with SMTP id a6-20020a05622a02c600b002dd2d3d11cdmr12732370qtx.638.1645954488604;
        Sun, 27 Feb 2022 01:34:48 -0800 (PST)
Received: from sandstorm.attlocal.net (76-242-90-12.lightspeed.sntcca.sbcglobal.net. [76.242.90.12])
        by smtp.gmail.com with ESMTPSA id h3-20020a05622a170300b002e008a93f8fsm469815qtk.91.2022.02.27.01.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 01:34:48 -0800 (PST)
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
Subject: [PATCH 3/6] block, fs: assert that key paths use iovecs, and nothing else
Date:   Sun, 27 Feb 2022 01:34:31 -0800
Message-Id: <20220227093434.2889464-4-jhubbard@nvidia.com>
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

Upcoming changes to Direct IO will change it from acquiring pages via
get_user_pages_fast(), to calling pin_user_pages_fast() instead.

Place a few assertions at key points, that the pages are IOVEC (user
pages), to enforce the assumptions that there are no kernel or pipe or
other odd variations being passed.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 block/bio.c    | 4 ++++
 fs/direct-io.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index b15f5466ce08..4679d6539e2d 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1167,6 +1167,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
 	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
 
+	WARN_ON_ONCE(!iter_is_iovec(iter));
+
 	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;
@@ -1217,6 +1219,8 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
 	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
 	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
 
+	WARN_ON_ONCE(!iter_is_iovec(iter));
+
 	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 38bca4980a1c..7dbbbfef300d 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -169,6 +169,8 @@ static inline int dio_refill_pages(struct dio *dio, struct dio_submit *sdio)
 {
 	ssize_t ret;
 
+	WARN_ON_ONCE(!iter_is_iovec(sdio->iter));
+
 	ret = iov_iter_get_pages(sdio->iter, dio->pages, LONG_MAX, DIO_PAGES,
 				&sdio->from);
 
-- 
2.35.1

