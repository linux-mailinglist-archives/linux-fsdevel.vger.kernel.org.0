Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CDF76AA85
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 10:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjHAIHF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 04:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjHAIHD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:07:03 -0400
Received: from out-124.mta1.migadu.com (out-124.mta1.migadu.com [95.215.58.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97768C6
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 01:07:01 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690877219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Y0FEsKxCEaKhnC6XTjUumQ7IBWiwYpmkheZOzUrbXgc=;
        b=B7TtbVDvlyrgM8pMVdTIddwTexeNDsJOCy7QmAdun8GDntc0NHggkdVlzr7yqbW6JyRgwF
        /adrSI6tC5kjCusV6k+99hvLXKHNqpR+xe7e+fEQnacW7Q6sw0OJMieRJPYQv830LIXaNg
        hhbBam1OMFPG6GNvUBI+rRvU9umtPNA=
From:   Hao Xu <hao.xu@linux.dev>
To:     fuse-devel@lists.sourceforge.net, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        Wanpeng Li <wanpengli@tencent.com>, cgxu519@mykernel.net
Subject: [PATCH v4 0/3] fuse: add a new fuse init flag to relax restrictions in no cache mode
Date:   Tue,  1 Aug 2023 16:06:44 +0800
Message-Id: <20230801080647.357381-1-hao.xu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Hao Xu <howeyxu@tencent.com>

Patch 1 is a fix for private mmap in FOPEN_DIRECT_IO mode
  This is added here together since the later two depends on it.
Patch 2 is the main dish
Patch 3 is to maintain direct io logic for shared mmap in FOPEN_DIRECT_IO mode

v3 -> v4
    fix race condition for buffered write and direct read by flushing
    pages before direct read to avoid to get stale data

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
 include/uapi/linux/fuse.h |  4 ++++
 4 files changed, 34 insertions(+), 4 deletions(-)


base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
-- 
2.25.1

