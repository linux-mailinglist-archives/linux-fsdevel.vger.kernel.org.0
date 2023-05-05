Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916F46F88AE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 20:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjEESiD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 14:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjEESiC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 14:38:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650A51AEC7
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 May 2023 11:38:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F05E660BCB
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 May 2023 18:37:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A33C433EF;
        Fri,  5 May 2023 18:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683311879;
        bh=pZUaTTVkVO1QhEY4Czhvk8wgXtXy9SD+2I1AGI0BYwU=;
        h=Subject:From:To:Cc:Date:From;
        b=HeblO6WBK57Zn/gDOyLK4dUmHLD9+2Oi5+rtHh8iZdyBV/lhg+lrn6ltZhh446ktw
         qR7aI6gx3U5HN9AZ+XefGt/XHokwN9ZuWjxrdM/DLudYnopGLYAQmgdr9tckIhT2dT
         kpQHGJ692iZR1q0zDWuAGtZUPk0d2ioLieP4yNWXMDGjfS5rNPZOC1F/xpg5AcuN9z
         OGNHQa/9vFumsq1jWu7bV2iF9V7ve5ol9k3r8UhXtJEclg7aNfmMMVELtcxWEcL/jK
         FWSPIScUme0rKtDDa2DHcFgCvtlfDNPimBSZRR+LzxUa2xhWuaKBLpjDsc2kMOQh2F
         SWYWchWeL7/fg==
Subject: [PATCH v2 0/5] shmemfs stable directory cookies
From:   Chuck Lever <cel@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Date:   Fri, 05 May 2023 14:37:47 -0400
Message-ID: <168331111400.20728.2327812215536431362.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following series is for continued discussion of the need for
and implementation of stable directory cookies for shmemfs/tmpfs.

Based on one of Andrew's review comments, I've split this one patch
into a series to (hopefully) reduce its complexity and make it
easier to analyze the changes.

Although the patch(es) have been passing functional tests for
several weeks, there have been some reports of performance
regressions that we still need to get to the bottom of.

We might consider a simpler lseek/readdir implementation, as using
an xarray is effective but a bit of overkill. I'd like to avoid a
linked list implementation as that is known to have significant
performance impact past a dozen or so list entries.

Changes since v1:
- Break the patch up into a series

Changes since RFC:
- Destroy xarray in shmem_destroy_inode() instead of free_in_core_inode()
- A few cosmetic updates

---

Chuck Lever (5):
      shmem: Refactor shmem_symlink()
      shmem: Add dir_operations specific to tmpfs
      shmem: Add a per-directory xarray
      shmem: Add a shmem-specific dir_emit helper
      shmem: stable directory cookies


 include/linux/shmem_fs.h |   2 +
 mm/shmem.c               | 213 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 201 insertions(+), 14 deletions(-)

--
Chuck Lever

