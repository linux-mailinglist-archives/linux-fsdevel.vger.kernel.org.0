Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101DB74389A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 11:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjF3JqP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 05:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbjF3JqM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:46:12 -0400
Received: from out-12.mta0.migadu.com (out-12.mta0.migadu.com [91.218.175.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89083583
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 02:46:10 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688118368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=byDUJWsDA8+vS/mI4HyAj7iNe7SnN/xM/N5UUGWji4c=;
        b=ncQyX5O0tVEYmsTTNGZWZF1jULv9h7rn23QWyuvd+eUFAWOwMPkuA9sOM/VQdjyMAdvVff
        Lp8KhhoyJ7XoH/UhEae0kqwkHv8PmYxS0m5T46ijcsGEfizmt01YBjDqoNY75Yip3COvqJ
        N+nl+lQEWn+Y3MSTuuCUdPJD8OZu5OY=
From:   Hao Xu <hao.xu@linux.dev>
To:     fuse-devel@lists.sourceforge.net
Cc:     miklos@szeredi.hu, bernd.schubert@fastmail.fm,
        linux-fsdevel@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        cgxu519@mykernel.net
Subject: [PATCH v3 0/3] fuse: add a new fuse init flag to relax restrictions in no cache mode
Date:   Fri, 30 Jun 2023 17:45:59 +0800
Message-Id: <20230630094602.230573-1-hao.xu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Hao Xu <howeyxu@tencent.com>

Patch 1 is a fix for private mmap in FOPEN_DIRECT_IO mode
  This is added here together since the later two depends on it.
Patch 2 is the main dish
Patch 3 is to maintain direct write logic for shared mmap in FOPEN_DIRECT_IO mode

v2 -> v3
    add patch 1 fix here, and adjust it follow Bernd's comment
    add patch 3 which does right thing for shared mmap in FOPEN_DIRECT_IO mode

v1 -> v2:
     make the new flag a fuse init one rather than a open flag since it's
     not common that different files in a filesystem has different
     strategy of shared mmap.

Hao Xu (3):
  fuse: invalidate page cache pages before direct write
  fuse: add a new fuse init flag to relax restrictions in no cache mode
  fuse: write back dirty pages before direct write in direct_io_relax
    mode

 fs/fuse/file.c            | 26 +++++++++++++++++++++++---
 fs/fuse/fuse_i.h          |  3 +++
 fs/fuse/inode.c           |  5 ++++-
 include/uapi/linux/fuse.h |  1 +
 4 files changed, 31 insertions(+), 4 deletions(-)

-- 
2.25.1

