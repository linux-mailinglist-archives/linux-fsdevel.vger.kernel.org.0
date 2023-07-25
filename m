Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E992B76203F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 19:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjGYReN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 13:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjGYReN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:34:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539F1B3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 10:34:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E63F461803
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 17:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7C7C433C7;
        Tue, 25 Jul 2023 17:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690306451;
        bh=9Bya+vnGZgpYW/N1uWJ2ahaAgUR2Np/Ld9EjBEEqSgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cYJnSrTonSfYF2S+LjzD5lDHwxOOK/6IG6Mk32QmkX0j9AZjT4qtQqW15JHTFb/Jl
         ImUGBJwIu5AkLxWxm9acAd+qaLBb7kSHGP4mJH71R3QCAuDdWBXNvy88+JfKr/tLGM
         ts+56nDg4Qf1hT2D1yeEu6DKUYjofguB7YnI2kvQmyOjflNmTDcY6jaTaRizSb+P6G
         FYm9WmdIVYmDQEQJMpjkg15nyyesSXP3ObxH9GM027GM6MU7vDDbS3as37X/Rk9u6e
         hgUR9RhTWB6Y4+P5KiS9OacP0gC0YZ3lfiBTGXOuO7uyNNmOHG6vTWUW5pVoCPjcg0
         q2RF20VeERNXQ==
From:   Christian Brauner <brauner@kernel.org>
To:     cem@kernel.org
Cc:     Christian Brauner <brauner@kernel.org>, jack@suse.cz,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, djwong@kernel.org, hughd@google.com,
        mcgrof@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V6 0/7] shmem: Add user and group quota support for tmpfs
Date:   Tue, 25 Jul 2023 19:33:43 +0200
Message-Id: <20230725-brummen-fortbestand-1b4f727337dc@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725144510.253763-1-cem@kernel.org>
References: <20230725144510.253763-1-cem@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1882; i=brauner@kernel.org; h=from:subject:message-id; bh=9Bya+vnGZgpYW/N1uWJ2ahaAgUR2Np/Ld9EjBEEqSgQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQcYM85N+2QqNyfCM7nV33nbI88rhF2kT3vl7xxwPy+mi3v YxW4OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZy6Sgjw4NYVwmJW/vCdVSVDjvsev 7tX0tubxtzmMcX9W1mOR8f32VkOMK87JRSse5yn8Z6SfmJDop3zmVGv93Br+Tzx+GC1vdcTgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 25 Jul 2023 16:45:03 +0200, cem@kernel.org wrote:
> This is a new version of the implementation of tmpfs quota, below is the serie's
> changelog, hopefully it make it easier to track down changes done on the past 3
> versions.
> 
> I've rebased this series on Linus today's TOT, hopefully it prevents conflicts.
> 
> I also removed Jan Kara's RwB from patch 4, due to changes in functions
> definition.
> 
> [...]

Applied to the vfs.tmpfs branch of the vfs/vfs.git tree.
Patches in the vfs.tmpfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.tmpfs

[1/7] shmem: make shmem_inode_acct_block() return error
      https://git.kernel.org/vfs/vfs/c/fd612a41ed54
[2/7] shmem: make shmem_get_inode() return ERR_PTR instead of NULL
      https://git.kernel.org/vfs/vfs/c/91f1d62b97b4
[3/7] quota: Check presence of quota operation structures instead of ->quota_read and ->quota_write callbacks
      https://git.kernel.org/vfs/vfs/c/641c3cdf05e0
[4/7] shmem: prepare shmem quota infrastructure
      https://git.kernel.org/vfs/vfs/c/8286a5c8264a
[5/7] shmem: quota support
      https://git.kernel.org/vfs/vfs/c/9a9f8f590f6d
[6/7] shmem: Add default quota limit mount options
      https://git.kernel.org/vfs/vfs/c/fbf5fbc5ed0e
[7/7] shmem: fix quota lock nesting in huge hole handling
      https://git.kernel.org/vfs/vfs/c/5da76f81c519
