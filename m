Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B08C6A0042
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Feb 2023 01:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjBWA6H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Feb 2023 19:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjBWA6D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Feb 2023 19:58:03 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2831E1DBAB
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Feb 2023 16:58:02 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536bf649e70so98502117b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Feb 2023 16:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5DZ3zrglXkc4zRJ24Mq++0gtFytF9RdLpBxclVHmdr8=;
        b=P+0z1HKgEn/jmZlepeouDrAc3nsZOERgHaJzjMzI0moOn4Q1pfkcsgiN2ROL3srMPJ
         9ZxjgHEw5llWiD79l0pJMTARN5/8hGRbMIa8H6z3gJqfI2s9Rl31staN5cKjCnKcvT9y
         UhcLs/Nejr1R69gb/NRqPIUXT75aZIqW3n66ae1dAwxzWpi2f3Nwhc51Gr+lnGFVjuPb
         x/duqcnpvsCEjLSPrm+XlIvPEbkEVFZRl7i94LhnhE+9C0yAm0OxXnRGwK2Qp0THJWoh
         yAVA6FQvNP7gm/zHD775wLwrx2HjOCX/uEcb2ENEkxOekuVJ4iyxSd4/R18rdQY8yBfZ
         09Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5DZ3zrglXkc4zRJ24Mq++0gtFytF9RdLpBxclVHmdr8=;
        b=kQND1+2ppgoxApddVNeiX34wsiR+eWKvipphvNaoA4p4wG6XGu4gIQid0jwFLCB39/
         y9hcet67nLxyAC0p2tbWUIfPGrPEkAT1V9kIdfKrUUzJEUrWFrlOVdNlLruKziGsSmM/
         R5fXtoyq99opGkUefsA/88TWiteAyOvF0fhi7FnWdPYnbTIlklI75xnlpEKeG7qyuqRz
         MG0AzY7+PZ6wRpimWyTxPYa6VNplJqn1p5Wj1Kgt07Y4aZaiaPY58bNdUazNNNAkp7np
         bQG3dMOaAnqDIafOuNj/pL4plvnH/ig4vV6WoBPud5VRvcQjz9Dw9d/dxVH8LxHWoJTA
         b82w==
X-Gm-Message-State: AO0yUKUUEf3+Nkf/20pe3m9jmTPQ7ooagKsxjwW7I+0yox2NzROnNP/V
        TWgZhAwBuA3gyKJjL1jUOKFT5RfNGMyWFROQSG1A
X-Google-Smtp-Source: AK7set+ca5/1tSRd8ROL/oWP5K4ZtIIh8sTd53BHUWCNXoZKgAxJ64umNuEDbtxRJDoupAyNyi/vB1QCOZlH8L9UioVS
X-Received: from axel.svl.corp.google.com ([2620:15c:2d4:203:3e99:dd9e:9db9:449c])
 (user=axelrasmussen job=sendgmr) by 2002:a81:af07:0:b0:52e:bb19:26c0 with
 SMTP id n7-20020a81af07000000b0052ebb1926c0mr1506007ywh.2.1677113881400; Wed,
 22 Feb 2023 16:58:01 -0800 (PST)
Date:   Wed, 22 Feb 2023 16:57:49 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230223005754.2700663-1-axelrasmussen@google.com>
Subject: [PATCH v2 0/5] mm: userfaultfd: refactor and add UFFDIO_CONTINUE_MODE_WP
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     James Houghton <jthoughton@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series, currently based on 6.2, is divided into two parts:

- Commits 1-4 refactor userfaultfd ioctl code without behavior changes, with the
  main goal of improving consistency and reducing the number of function args.
- Commit 5 adds UFFDIO_CONTINUE_MODE_WP.

The refactors are sorted by increasing controversial-ness, the idea being we
could drop some of the refactors if they are deemed not worth it.

Changelog:
v1->v2: refactor before adding the new flag, to avoid perpetuating messiness

Axel Rasmussen (5):
  mm: userfaultfd: rename functions for clarity + consistency
  mm: userfaultfd: don't pass around both mm and vma
  mm: userfaultfd: combine 'mode' and 'wp_copy' arguments
  mm: userfaultfd: don't separate addr + len arguments
  mm: userfaultfd: add UFFDIO_CONTINUE_MODE_WP to install WP PTEs

 fs/userfaultfd.c                         | 121 +++++-------
 include/linux/hugetlb.h                  |  28 ++-
 include/linux/shmem_fs.h                 |   8 +-
 include/linux/userfaultfd_k.h            |  57 +++---
 include/uapi/linux/userfaultfd.h         |   7 +
 mm/hugetlb.c                             |  35 ++--
 mm/shmem.c                               |  13 +-
 mm/userfaultfd.c                         | 236 +++++++++++------------
 tools/testing/selftests/vm/userfaultfd.c |   4 +
 9 files changed, 245 insertions(+), 264 deletions(-)

--
2.39.2.637.g21b0678d19-goog

