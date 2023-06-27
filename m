Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E720874054D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 22:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjF0Uxb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 16:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjF0Uxa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:53:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0A126A8
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 13:53:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52E04611DC
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 20:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F76C433C0;
        Tue, 27 Jun 2023 20:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687899183;
        bh=6bii1OLY78TFxJA0nbJ48++Tukqt+yTeFc16tNHybc8=;
        h=Subject:From:To:Cc:Date:From;
        b=TXXhbkThNwz0DPSBsY4L7/YYy0y/EQU8SDuK/erYNXUuV13npl80SFBimOWPbs/F3
         Z5I8PvHH5AoTGjBOnsy3rypSpJGnT7AJ0wKjSNDhDPAUPwzIFZ6bZRpp/EI6tLSmbZ
         jzJa/tNxM+D+vXn0Elqt1MWprrzDIYQuABx5C1XXif+GH+fzVX8GQAwoSPofdBx7ik
         kJW9yzBwTsz8WguLa09obNIeaqGiISNz5m498GTSPXSaYomiZm0sxBAmNWhqENvJww
         kk5XlaGUZCfL8fJzbAG1fqJZxQHpacujaO9bDVfaZPxP1mykEXgOOfuo7INdvUR434
         ZvyIMjpfs+gJA==
Subject: [PATCH v5 0/3] shmemfs stable directory offsets
From:   Chuck Lever <cel@kernel.org>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, hughd@google.com,
        akpm@linux-foundation.org
Cc:     Christoph Hellwig <hch@lst.de>, Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, jlayton@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Date:   Tue, 27 Jun 2023 16:53:02 -0400
Message-ID: <168789864000.157531.11122232592994999253.stgit@manet.1015granger.net>
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

I've moved the rename-exchange logic to fs/libfs.c, since that is
something that other filesystems will need and is difficult to get
right. I've tried again to address error handling for that type of
rename. That part hasn't been thoroughly tested, though the series
continues to pass xfstests and various other tests done via NFS
export.


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


 fs/libfs.c               | 252 +++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h       |  19 +++
 include/linux/shmem_fs.h |   1 +
 mm/shmem.c               |  62 +++++++---
 4 files changed, 319 insertions(+), 15 deletions(-)

--
Chuck Lever

