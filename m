Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2EF7243E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 15:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238182AbjFFNLb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 09:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238101AbjFFNLH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:11:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121E7173C
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 06:10:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C9A6632EF
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 13:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72ABCC433EF;
        Tue,  6 Jun 2023 13:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686057054;
        bh=sXs4hnnNnWj99mlOMyhDV0acxkehx5bfh/cy3L29wc4=;
        h=Subject:From:To:Cc:Date:From;
        b=lf3vrhnl/EXxicDpT/c3MHxARnod5KpedTuuuQGZ2yHxaNbEFq+IqW1k84JF3fvoX
         cQqGRkC9SFv0IfzZDF6qErr6BG8ltPuNS219egws82MKRXbYtSDAnIR+6ts9sBP5rY
         c1ypsJHKdMKi+Z1vdkjWJLiQKNHoSJGlsg2KzMdjJwh8ox5/8jbO/vC52NmqJDpDQ3
         DoGVe1mypQBmfExdpSwIEotNes/oxgANmR8GKySKXRCxT0MTp4+AZwCN6bbeGTCbGS
         zLuAVL/uhOHE21xk45/eP+H+J2fqQjYCFbiHHsJotP6rfahR5Mlt0YFnZB3F1c7zj8
         NStvO0J2gthUQ==
Subject: [PATCH v3 0/3] shmemfs stable directory offsets
From:   Chuck Lever <cel@kernel.org>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, hughd@google.com,
        akpm@linux-foundation.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 06 Jun 2023 09:10:52 -0400
Message-ID: <168605676256.32244.6158641147817585524.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following series is for continued discussion of the need for
and implementation of stable directory offsets for shmemfs/tmpfs.

As discussed in Vancouver, I've re-implemented this change in libfs
so that other "simple" filesystems can use it. There were a few
other suggestions made during that event that I haven't tried yet.

Changes since v2:
- Move bulk of stable offset support into fs/libfs.c
- Replace xa_find_after with xas_find_next for efficiency

Changes since v1:
- Break the single patch up into a series

Changes since RFC:
- Destroy xarray in shmem_destroy_inode() instead of free_in_core_inode()
- A few cosmetic updates

---

Chuck Lever (3):
      libfs: Add directory operations for stable offsets
      shmem: Refactor shmem_symlink()
      shmem: stable directory offsets


 fs/dcache.c            |   1 +
 fs/libfs.c             | 185 +++++++++++++++++++++++++++++++++++++++++
 include/linux/dcache.h |   1 +
 include/linux/fs.h     |   9 ++
 mm/shmem.c             |  58 +++++++++----
 5 files changed, 240 insertions(+), 14 deletions(-)

--
Chuck Lever

