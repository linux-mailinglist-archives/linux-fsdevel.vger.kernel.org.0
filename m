Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08BB6D6475
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 16:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbjDDOAT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 10:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235899AbjDDOAE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:00:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EBD35B7
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Apr 2023 06:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Ppztqzi2Gw646l+hIyTnCePJrLfpu78r8b6P3LTQWro=; b=QKtJNp4eL+NLKoIYZbLEmbEGis
        1qdDzcW0CcwQ29e84+KiR3pVsW6g6OntvQTB+mAqEuOKqIYap9JvAgvO0T+7PJXH8ugpx5+JVTnoD
        snk9NZgn+wdjGWSwu4NFqsi6+bG2AqhvrxkuVmBDbxFfffr3U8UH/tm1G1IxczdInG6JVD0QKhcPm
        HBnoWqq4DnsfJDZchMdMiEEzyfJhITGbfk5Swvh4slxDsFyb3QWrAmNeHUsFvML3JL0hD5h1iEltf
        O7wamIL02Wro9+OM/ml7U9mwh2uF+V3G6vdyXobRIWR8ABTZ3cMFiOJThLPe27oES5R20uxnt1s3v
        5JtoEU9A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pjhBU-00FPcd-1A; Tue, 04 Apr 2023 13:58:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: [PATCH 0/6] Avoid the mmap lock for fault-around
Date:   Tue,  4 Apr 2023 14:58:44 +0100
Message-Id: <20230404135850.3673404-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The linux-next tree currently contains patches (mostly from Suren)
which handle some page faults without the protection of the mmap lock.
This patchset adds the ability to handle page faults on parts of files
which are already in the page cache without taking the mmap lock.

I've taken a very gradual approach to pushing the lock down.  I'm not 100%
confident in my ability to grasp all the finer aspects of VMA handling,
so some reviewrs may well feel that I could have combined some of
these patches.  I did try to skip one of these steps and it had a bug,
so I feel justified in proceeding cautiously.

Several people have volunteered to run benchmarks on this, so I haven't.
I have run it through xfstests and it doesn't appear to introduce any
regressions.

Matthew Wilcox (Oracle) (6):
  mm: Allow per-VMA locks on file-backed VMAs
  mm: Move FAULT_FLAG_VMA_LOCK check from handle_mm_fault()
  mm: Move FAULT_FLAG_VMA_LOCK check into handle_pte_fault()
  mm: Move FAULT_FLAG_VMA_LOCK check down in handle_pte_fault()
  mm: Move the FAULT_FLAG_VMA_LOCK check down from do_pte_missing()
  mm: Run the fault-around code under the VMA lock

 mm/hugetlb.c |  4 ++++
 mm/memory.c  | 28 +++++++++++++++++++---------
 2 files changed, 23 insertions(+), 9 deletions(-)

-- 
2.39.2

