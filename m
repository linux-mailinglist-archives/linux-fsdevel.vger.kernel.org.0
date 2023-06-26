Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E328373E81A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 20:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjFZSXA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 14:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjFZSW4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:22:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E1A171A
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 11:22:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6BDF60F66
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 18:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802CDC433C0;
        Mon, 26 Jun 2023 18:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687803682;
        bh=uJDkQA9txYVs51qAFWDaoAqdXxOhhJl825u9zR3z0IU=;
        h=Subject:From:To:Cc:Date:From;
        b=jv6QhiYLSelfMrF0PQe3c92WZVF0WVnIZQTKfsWBov2Ed1mjPiLsHx7g1rm37ntWO
         9Sv1Zw7y3fS3LXW6+u+siZtqlNi5KUXJiUnRw+deW+joaSBCmG36lxGBQCbNBwITiM
         sIQLvTNFV4z84wZpp91NRBFmpB84UZlxccZsJrMT+FZGaMh4hFXTi/BnyeM4C11OJt
         0wJAbbaO9jqHEMzswthSkivEUSmBr39nz5XGGap3uNybwf6Qc4WkeWX2ZsDwpGlhor
         GQv81I0D4D9SO7KjTTWIMbPtdmPI9xcpbTHPUpRzvbs76Xt4M6B8/jW2C9WjsksbAi
         9dXgZpEK/7JUw==
Subject: [PATCH v4 0/3] shmemfs stable directory offsets
From:   Chuck Lever <cel@kernel.org>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, hughd@google.com,
        akpm@linux-foundation.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, jlayton@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 26 Jun 2023 14:21:20 -0400
Message-ID: <168780354647.2142.537463116658872680.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following series is for continued discussion of the need for
and implementation of stable directory offsets for shmemfs/tmpfs.


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


 fs/dcache.c            |   1 +
 fs/libfs.c             | 185 +++++++++++++++++++++++++++++++++++++++++
 include/linux/dcache.h |   1 +
 include/linux/fs.h     |   9 ++
 mm/shmem.c             |  69 +++++++++++----
 5 files changed, 250 insertions(+), 15 deletions(-)

--
Chuck Lever

