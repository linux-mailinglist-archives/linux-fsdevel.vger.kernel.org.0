Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C6D744190
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 19:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjF3Rst (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 13:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjF3Rsq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:48:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6CD273B
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 10:48:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42F2F617D1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 17:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E11C433C0;
        Fri, 30 Jun 2023 17:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688147324;
        bh=xvAOc5EnSg+pqf/r2cLjPOFtbne1Ol0KJ6DK2s2jVMw=;
        h=Subject:From:To:Cc:Date:From;
        b=aIcQhXBOzHnkH8WpVvrPyJu7YxPpwoBSSKvj7qoIyzV0Tr7Kiggks10bvI8E6K3FX
         bH0P8O3PNJx2pQYfLNmc1pGdBDG4BmGpqtDFpuwhGMcAIMEt1ZtZ3wijc2/DUXBRFI
         otWHw/yf/eCwxvgfnoP8YD3Zy/+aP5ZS8NSOWLm31m9t8mTKYyFKlrWgIXHOrkP+Bm
         SlAWa+75gpsDdlvgEhCGl0TxCFAVRW3SQjqZR1TE0sd/svjfQVkrFKMuUKoouqD9ip
         r4ANCexg+q4YfeL3K5jWtXex0yP+nk+pPtRGQq8t/314JagJMa2+O/2U0lCxz6PHUC
         /bJJO3hGYE/sw==
Subject: [PATCH v7 0/3] shmemfs stable directory offsets
From:   Chuck Lever <cel@kernel.org>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, hughd@google.com,
        akpm@linux-foundation.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>, jlayton@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Date:   Fri, 30 Jun 2023 13:48:43 -0400
Message-ID: <168814723481.530310.17776748558242063239.stgit@manet.1015granger.net>
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

The following series implements stable directory offsets for
shmemfs/tmpfs and provides infrastructure for use by other file
systems that are based on simplefs.


Changes since v6:
- Add appropriate documentation

Changes since v5:
- Rename functions and structures

Changes since v4:
- Remove new fields from struct inode/dentry
- Remove EXPORT_SYMBOL and extern for new functions
- Try again to fix error handling for rename_exchange

Changes since v3:
- Rebased on v6.4
- Fixed error handling bugs

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


 Documentation/filesystems/locking.rst |   2 +
 Documentation/filesystems/vfs.rst     |   6 +-
 fs/libfs.c                            | 247 ++++++++++++++++++++++++++
 include/linux/fs.h                    |  18 ++
 include/linux/shmem_fs.h              |   1 +
 mm/shmem.c                            |  62 +++++--
 6 files changed, 320 insertions(+), 16 deletions(-)

--
Chuck Lever

