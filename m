Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8481A7B3DC5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 05:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbjI3DX2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 23:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjI3DX0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 23:23:26 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89972193
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 20:23:22 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d7f0a60a159so16412031276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 20:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696044201; x=1696649001; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u464Sxm0ujPzUaibJwHmo6uSfWYXgo9KUxPB7fJkQzM=;
        b=jIk25V+kFNOpNETB/dnVoXERdd096a32LnQZAFFilT2BHNc7vKqXZ9WvLZusO/jhAp
         lUGU4s9l8zpD9reONW7Hh0JWletqMKXMNqUsKcrGRhzCszJCXTLyuCFO/eiXMk8oACT5
         QgmZPGiiRGV94UiGOsPSvyY2ZxqvnfAbWMnwJ0l4EyODHAfXR46rqPHqyS6DxychQuaH
         sys3cNea25492qlbh38gwQzDPVtwZWFjo84n1lYzMNF9mKpJu0HOGezexRRKcSwkHA1m
         MkNOFNwOFW77koSZM92aLSgivDE7C7SlYq1tn6FvGtf/iTsk20GB8xcoPms4X/XYbOe2
         pvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696044201; x=1696649001;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u464Sxm0ujPzUaibJwHmo6uSfWYXgo9KUxPB7fJkQzM=;
        b=KnrFiODQ2eFT16vNs+owuoV2Xg/1Wl8yVxR6GSiVhELJGhKPRLZyNhWFjDBENLjuM6
         hqOdedh9c3M52utXmOW5u2wZmIZJiHQ3PuNkgYQF/L+Nw4uSyuHpWEoVLY2k5pBK6LJ2
         RBUNPCcPHbl5OXwFDujGjFkx60HMjMIoD/rdUZyyLinwVIui4l9tgoewa3gcqDq2EdKL
         CnDxXPHwu+ykEHdI1hvh9yeVI8HbSbUPjBUAJ/RkXqfTlzMAq+VX4jRE/Df8BuBnzcpL
         zvP5x0izeNbAsr37MyDsUuEw3RpjACMkYEs1zk97foDxz+5ZOnqxXSc7m6LCmbjXWEAK
         P0kg==
X-Gm-Message-State: AOJu0YxTsdRtT7ppxmr77ZJe3n9x249rqp+Zv4UYaLtv/1auFVcKC6GC
        8Z5QYpcN33S+E3KuCi+bSqjZOg==
X-Google-Smtp-Source: AGHT+IHdyJ6lGHBlGP9IqvKprbLeVqba/douBbEisvvniP4hzfe3psIPtxTRADPUKu7cyiP+Qngk6Q==
X-Received: by 2002:a25:2601:0:b0:d71:8729:23b8 with SMTP id m1-20020a252601000000b00d71872923b8mr5578703ybm.13.1696044201598;
        Fri, 29 Sep 2023 20:23:21 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e195-20020a2550cc000000b00d8679407796sm4282793ybb.48.2023.09.29.20.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 20:23:19 -0700 (PDT)
Date:   Fri, 29 Sep 2023 20:23:11 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Christian Brauner <brauner@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 0/8] shmem,tmpfs: general maintenance
Message-ID: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

And here is a series of patches based on v6.6-rc3: mostly just cosmetic
mods in mm/shmem.c, but the last two enforcing the "size=" limit better.
8/8 goes into percpu counter territory, and could stand alone: I'll add
some more Cc's on that one.

Applies to any v6.6-rc so far, and to next-20230929 and to
mm-everything-2023-09-29-23-51: hah, there's now an 09-30-01-16,
I haven't tried it yet, but this should be good on that too.

1/8 shmem: shrink shmem_inode_info: dir_offsets in a union
2/8 shmem: remove vma arg from shmem_get_folio_gfp()
3/8 shmem: factor shmem_falloc_wait() out of shmem_fault()
4/8 shmem: trivial tidyups, removing extra blank lines, etc
5/8 shmem: shmem_acct_blocks() and shmem_inode_acct_blocks()
6/8 shmem: move memcg charge out of shmem_add_to_page_cache()
7/8 shmem: _add_to_page_cache() before shmem_inode_acct_blocks()
8/8 shmem,percpu_counter: add _limited_add(fbc, limit, amount)

 include/linux/percpu_counter.h |  23 ++
 include/linux/shmem_fs.h       |  16 +-
 lib/percpu_counter.c           |  53 ++++
 mm/shmem.c                     | 500 +++++++++++++++++------------------
 4 files changed, 333 insertions(+), 259 deletions(-)

Hugh
