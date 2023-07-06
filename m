Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F2674926C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 02:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbjGFASY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 20:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbjGFASW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 20:18:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035AE19AD;
        Wed,  5 Jul 2023 17:18:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 171A6617E1;
        Thu,  6 Jul 2023 00:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16A93C433B8;
        Thu,  6 Jul 2023 00:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688602695;
        bh=HpMG+tyy/PpsvKEb8NWliRWVb2DUG5Z8rXMZJ3Y3mkc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LikA3OcMzLtL2uR3eKzQF0LeVsSNlJMLK11D/oOQ9aYM0WA8UsDwj10GcOrJC8tjt
         pOtPDyPeQukRBF4JtgJ+YubOhUz7XE54fcrit2sn66Vdd3x7HS1eQYlvPRjNX5zd92
         jbiBLti3sH7MFOCUBJiPHyJ4F+VPb+WyALiwovY5jyWvkCE4p8ezOZqmUEYC5vv9fY
         v4sL7Nm2aJYhzPUkvH3ccCI0wtBJ09fMx9u1UWMg3moBDCd7LRGoHd2Z5SlXNCn/EI
         8zubzYmjfskHw8c7CvYiw2po7nMHPqBCXwQ7gLh1SlEOU9UZq29FGodMiixx1gmjKs
         hUJbESOiaXfLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0210C691EF;
        Thu,  6 Jul 2023 00:18:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2 0/6] fs: Fix directory corruption when moving
 directories
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168860269498.29151.2669410551132746914.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Jul 2023 00:18:14 +0000
References: <20230601104525.27897-1-jack@suse.cz>
In-Reply-To: <20230601104525.27897-1-jack@suse.cz>
To:     Jan Kara <jack@suse.cz>
Cc:     viro@ZenIV.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        miklos@szeredi.hu, djwong@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Christian Brauner <brauner@kernel.org>:

On Thu,  1 Jun 2023 12:58:20 +0200 you wrote:
> Hello,
> 
> this patch set fixes a problem with cross directory renames originally reported
> in [1]. To quickly sum it up some filesystems (so far we know at least about
> ext4, udf, f2fs, ocfs2, likely also reiserfs, gfs2 and others) need to lock the
> directory when it is being renamed into another directory. This is because we
> need to update the parent pointer in the directory in that case and if that
> races with other operation on the directory (in particular a conversion from
> one directory format into another), bad things can happen.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,1/6] ext4: Remove ext4 locking of moved directory
    https://git.kernel.org/jaegeuk/f2fs/c/3658840cd363
  - [f2fs-dev,v2,2/6] Revert "udf: Protect rename against modification of moved directory"
    https://git.kernel.org/jaegeuk/f2fs/c/7517ce5dc4d6
  - [f2fs-dev,v2,3/6] Revert "f2fs: fix potential corruption when moving a directory"
    https://git.kernel.org/jaegeuk/f2fs/c/cde3c9d7e2a3
  - [f2fs-dev,v2,4/6] fs: Establish locking order for unrelated directories
    (no matching commit)
  - [f2fs-dev,v2,5/6] fs: Lock moved directories
    https://git.kernel.org/jaegeuk/f2fs/c/28eceeda130f
  - [f2fs-dev,v2,6/6] fs: Restrict lock_two_nondirectories() to non-directory inodes
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


