Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D804C5A2D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Feb 2022 10:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiB0JfU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 04:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiB0JfU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 04:35:20 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6B13AA66;
        Sun, 27 Feb 2022 01:34:44 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id h13so10137210qvk.12;
        Sun, 27 Feb 2022 01:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mni5yEHGP1qoaz/6hLvUm/V5F3W7L/m3Wwp7WeQHDBs=;
        b=i/DtVk9P1DTHcuWOXDH9pwmZG/a6m++cXjyfgszKxoJCGq61z0Vh9V6VT7598xqiMi
         EF1aHesjRXqFVb1MLfCyfjVLdKDjxStOIQgcFf5sdUVfVFVSgj5nzuRpk39ZssABWyKh
         a5V1wQVAoDRNzC9Dl1gk7AqHG50JPjaqkE16unCe75SAiAEMS+WC4cVBEtbtkF7Dem5C
         uPnBaKWJ7OQhiSUrqoI9Da0PZrEndqPQmR1OX4KId4mTUcIqvmNuHTnvKYBBLBjkQG9b
         zfm9wn/aSeqIz2OuKsGS5Jxx5jqmvvBDJl5gDl+K45QxzWErwVzB3/emB9ggfzRG4X0z
         Zzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mni5yEHGP1qoaz/6hLvUm/V5F3W7L/m3Wwp7WeQHDBs=;
        b=z7gfc4HX5nXy1chSEyqmSlX1X47whTIgem/EfSk3ZBe0cD4aMk1vBlMnPGbejdoaIf
         iq6NfBZ0RhxMgfM3VvOJdTk/BWWsojD18e3t10N7mlqDkNZrrNuK4h610LKpVoMG4/uc
         WU8WUqzLxO24LSSV2cDcZWQF3e13drDQYnAbuQqfIwqs+rvnSVLELjfvCWT9g3ilDHMI
         aKsA46ULKw5wUys6ArsBgKoN5+5C0ICxP3GsLc3V6FqjzjbCYWTkxC3EoF3srJgvJB2L
         i6fgf1bQlh0sJLSPqIx1KCTqtI0QfjT73TcyDXgF6yQq9ANO04zJVxBhdoltgU7f3NZK
         Jzmw==
X-Gm-Message-State: AOAM5331l3AuHqqfNBB9b75j/Wz/NFgvy/wRQR1CucQzOBdQF8E1RpcS
        Vpaynl4Wnoc9AaSkVjtp9/A=
X-Google-Smtp-Source: ABdhPJzlq9Z9ay7IQGmu5husNkkRN/qKFoSudupKCgD7SFi/psSCUSPiOgMXvH9tuYollM3Gca/QcA==
X-Received: by 2002:a05:6214:ca3:b0:42d:129a:5ac6 with SMTP id s3-20020a0562140ca300b0042d129a5ac6mr11161514qvs.86.1645954483191;
        Sun, 27 Feb 2022 01:34:43 -0800 (PST)
Received: from sandstorm.attlocal.net (76-242-90-12.lightspeed.sntcca.sbcglobal.net. [76.242.90.12])
        by smtp.gmail.com with ESMTPSA id h3-20020a05622a170300b002e008a93f8fsm469815qtk.91.2022.02.27.01.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 01:34:42 -0800 (PST)
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
Subject: [PATCH 0/6] block, fs: convert most Direct IO cases to FOLL_PIN
Date:   Sun, 27 Feb 2022 01:34:28 -0800
Message-Id: <20220227093434.2889464-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
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

Hi,

The feedback on the RFC [1] prompted me to convert the core Direct IO
subsystem all at once. The key differences here, as compared to the RFC,
are:

    * no dio_w_*() wrapper routines,

    * no CONFIG parameter; and

    * new iov_iter_pin_pages*() routines that pin pages without
      affecting other callers of iov_iter_get_pages*(). Those other
      callers (ceph, rds, net, ...) can be converted separately.

Also, many pre-existing callers of unpin_user_pages_dirty_lock() are
wrong, and this series adds a few more callers. So readers may naturally
wonder about that. I recently had a very productive discussion with Ted
Ts'o, who suggested a way to fix the problem, and I'm going to implement
it, next. However, I think it's best to do that fix separately from
this, probably layered on top, although it could go either before or
after.

As part of fixing the "get_user_pages() + file-backed memory" problem
[2], and to support various COW-related fixes as well [3], we need to
convert the Direct IO code from get_user_pages_fast(), to
pin_user_pages_fast(). Because pin_user_pages*() calls require a
corresponding call to unpin_user_page(), the conversion is more
elaborate than just substitution.

In the main patch (patch 4) I'm a little concerned about the
bio_map_user_iov() changes, because the sole caller,
blk_rq_map_user_iov(), has either a direct mapped case or a copy from
user case, and I'm still not sure that these are properly kept separate,
from an unpin pages point of view. So a close look there by reviewers
would be welcome.

Testing: this needs lots of filesystem testing.

In this patchset:

Patches 1, 2: provide a few new routines that will be used by
conversion: pin_user_page(), iov_iter_pin_pages(),
iov_iter_pin_pages_alloc().

Patch 3: provide a few asserts that only user space pages are being
passed in for Direct IO. (This patch could be folded into another
patch.)

Patch 4: Convert all Direct IO callers that use iomap, or
blockdev_direct_IO(), or bio_iov_iter_get_pages().

Patch 5, 6: convert a few other callers to the new system: NFS-Direct,
and fuse.

This is based on linux-next (next-20220225). I've also stashed it here:

    https://github.com/johnhubbard/linux bio_pup_next_20220225


[1] https://lore.kernel.org/r/20220225085025.3052894-1-jhubbard@nvidia.com

[2] https://lwn.net/Articles/753027/ "The trouble with get_user_pages()"

[3] https://lore.kernel.org/all/20211217113049.23850-1-david@redhat.com/T/#u
    (David Hildenbrand's mm/COW fixes)

John Hubbard (6):
  mm/gup: introduce pin_user_page()
  iov_iter: new iov_iter_pin_pages*(), for FOLL_PIN pages
  block, fs: assert that key paths use iovecs, and nothing else
  block, bio, fs: convert most filesystems to pin_user_pages_fast()
  NFS: direct-io: convert to FOLL_PIN pages
  fuse: convert direct IO paths to use FOLL_PIN

 block/bio.c          | 29 ++++++++--------
 block/blk-map.c      |  6 ++--
 fs/direct-io.c       | 28 ++++++++--------
 fs/fuse/dev.c        |  7 ++--
 fs/fuse/file.c       | 38 +++++----------------
 fs/iomap/direct-io.c |  2 +-
 fs/nfs/direct.c      | 15 +++------
 include/linux/mm.h   |  1 +
 include/linux/uio.h  |  4 +++
 lib/iov_iter.c       | 78 ++++++++++++++++++++++++++++++++++++++++++++
 mm/gup.c             | 34 +++++++++++++++++++
 11 files changed, 170 insertions(+), 72 deletions(-)


base-commit: 06aeb1495c39c86ccfaf1adadc1d2200179f16eb
-- 
2.35.1

