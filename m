Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1357414DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjF1PZS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:25:18 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:40522 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbjF1PZE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:25:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 745FC61366
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 15:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25710C433C0;
        Wed, 28 Jun 2023 15:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687965903;
        bh=0tXZEXiIJLpeFxOnH6daR96H3UImBjpwNLzvCQrwB/M=;
        h=Subject:From:To:Cc:Date:From;
        b=uOXfycZpI1aJ6uAwlRrj8OC8eeY6advuefRJChv0KJVUrx4mEaJkR8EE5mxHB4CBj
         YV7Gr2CZqUrytmo162g42IR7mEv7muLnlh1m5Xrn3oOvYPDvhdqeqthATIeUa+6mEp
         SIWsgdwdFviiqK0FcU2Ff1h4cxogYirODde+0hzl7Sz5KOJ5MiOT5Pc2Br+HRiS9Td
         maHtuQqYiNCZipZfXFYjmD0UOWqmzGY0mvnXAe86tXKb/XpehDqcbLL3py2BY5I6iw
         X5zouzzbdD2KkiVFsrJVsxvEjgnJTCK0oRYb0IgRIioAdnGvkDSiaEmp1KpQzi1QuD
         cRHbnPVJDKW3w==
Subject: [PATCH v6 0/3] shmemfs stable directory offsets
From:   Chuck Lever <cel@kernel.org>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, hughd@google.com,
        akpm@linux-foundation.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Christoph Hellwig <hch@lst.de>, jlayton@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Date:   Wed, 28 Jun 2023 11:25:02 -0400
Message-ID: <168796579723.157221.1988816921257656153.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following series implements stable directory offsets for
shmemfs/tmpfs and provides infrastructure for use by other file
systems that are based on simplefs.


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


 fs/libfs.c               | 247 +++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h       |  18 +++
 include/linux/shmem_fs.h |   1 +
 mm/shmem.c               |  62 +++++++---
 4 files changed, 313 insertions(+), 15 deletions(-)

--
Chuck Lever

