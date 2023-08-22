Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6107840E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 14:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbjHVMgP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 08:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjHVMgP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:36:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6701B2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 05:36:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7703961047
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 12:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86993C433C8;
        Tue, 22 Aug 2023 12:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692707772;
        bh=fk45I840klujEBH09dc4YYEnHCwe+JRgvyiRvN/D0fs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h5TZWvUBSlqJ7aaVF6WcwyT8J2DEIhRGSzJ72R2R5dBaq/TX7fKTAR4WyvE94N89e
         8tGRQ/kv/gj8BeyA07sIuW/0dH5enENqp42ZXvJ0SpiyvlO2YW8IPoi0bsIxalY1Lz
         e6cG5yL1Jl70EJt4lPCrqoo10F8A0q3QW+8fs455XD4KxQlf2NTmbqrX0WLZwxrQSL
         unZKajkjmfMYaAU2aJdKmXGcsMwrDUYrtjerbjCRRDgMXXO7Ku1iCSsTUjZm/32icb
         8N9WGmmYDg+mu1CixLvOqR0qZTlSP4RJPER3+WLq6AGMbI2f9tRkt74joltOSlplDH
         pqs9XFQgUE1Dw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 0/4] super: allow waiting without s_umount held
Date:   Tue, 22 Aug 2023 14:36:04 +0200
Message-Id: <20230822-ahnte-hausdach-0c90215cb885@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818-vfs-super-fixes-v3-v3-0-9f0b1876e46b@kernel.org>
References: <20230818-vfs-super-fixes-v3-v3-0-9f0b1876e46b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778; i=brauner@kernel.org; h=from:subject:message-id; bh=fk45I840klujEBH09dc4YYEnHCwe+JRgvyiRvN/D0fs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ8Wb1eWcoy+sQa83IDKw6G6/yRblGt1lUHLy8JnjPz4ULh P+XGHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5lcrI8DDJlUtj8gqBwvsvmSymJW TN7/DtqM2ucV47cev5hg6Dtwz/vf4deR2Z2MnqfNd4puW3Ph1m8Q8yVRmTTSZHiKafjzVmAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 18 Aug 2023 16:00:47 +0200, Christian Brauner wrote:
> Hey everyone,
> 
> This is an attempty to allow concurrent mounters and iterators to wait
> on superblock state changes without having to hold s_umount. This is
> made necessary by recent attempts to open block devices after superblock
> creation and fixing deadlocks due to blkdev_put() trying to acquire
> s_umount while s_umount is already held.
> 
> [...]

Already applied this but didn't send out a notification.

Jan's suggestion to log a warning when freeze/thaw is called on dying
superblock is on top of the series as well:

      super: use higher-level helper for {freeze,thaw}
      https://git.kernel.org/vfs/vfs/c/051178c366bb

---

Applied to the vfs.super branch of the vfs/vfs.git tree.
Patches in the vfs.super branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.super.fs_supers_lock

[1/4] super: use locking helpers
      https://git.kernel.org/vfs/vfs/c/0ed33598ddf3
[2/4] super: make locking naming consistent
      https://git.kernel.org/vfs/vfs/c/d8ce82efdece
[3/4] super: wait for nascent superblocks
      https://git.kernel.org/vfs/vfs/c/5e8749141521
[4/4] super: wait until we passed kill super
      https://git.kernel.org/vfs/vfs/c/2c18a63b760a
