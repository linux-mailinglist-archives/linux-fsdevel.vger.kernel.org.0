Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9669791C6D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 20:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353445AbjIDSLS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 14:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353433AbjIDSLQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:11:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECCE13E;
        Mon,  4 Sep 2023 11:11:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9F0EDCE0F9C;
        Mon,  4 Sep 2023 18:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59525C116A6;
        Mon,  4 Sep 2023 18:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693851069;
        bh=9V05BJ+Zrz7p6pZ+b0iissf5Ol4gDyoeQK0k983jp/8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=q//cpDgINdSIlQFIs/BZqxxdsINFkxrc4Mu7UetIPc7BiMzw0uhEfroJJYNGh9Y/7
         mcKD20fU3Rg0ULNFUaFzGSTO/O9D6mpFmSlZrY6Ctgzwsoh5Z5pwuCl+wC3uPthmeP
         D/QeifcpwXU3D/ZU7TIO3dldJCslfK8p6OTbUXlyC/NqKvUCWSmvxZrbJI2HCsF9pp
         sqlPbcWpavpzVrBexl9HiVhvAgFLNI89jQuhlm3r2RUWQLYugwGmVaBWfUONhbqiH4
         YVBprbBK1yL+uyTmzhN5hdyR3iCLSBy7Vu1R3nwrj2DP1dzSYcc40YeMS2z68Wr2Bp
         btqg4yNrLqmwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29183C2BBF6;
        Mon,  4 Sep 2023 18:11:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2 43/92] f2fs: convert to ctime accessor
 functions
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169385106916.19669.6288590634358957039.git-patchwork-notify@kernel.org>
Date:   Mon, 04 Sep 2023 18:11:09 +0000
References: <20230705190309.579783-41-jlayton@kernel.org>
In-Reply-To: <20230705190309.579783-41-jlayton@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     brauner@kernel.org, jaegeuk@kernel.org, chao@kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, jack@suse.cz,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Christian Brauner <brauner@kernel.org>:

On Wed,  5 Jul 2023 15:01:08 -0400 you wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/f2fs/dir.c      |  8 ++++----
>  fs/f2fs/f2fs.h     |  4 +++-
>  fs/f2fs/file.c     | 20 ++++++++++----------
>  fs/f2fs/inline.c   |  2 +-
>  fs/f2fs/inode.c    | 10 +++++-----
>  fs/f2fs/namei.c    | 12 ++++++------
>  fs/f2fs/recovery.c |  4 ++--
>  fs/f2fs/super.c    |  2 +-
>  fs/f2fs/xattr.c    |  2 +-
>  9 files changed, 33 insertions(+), 31 deletions(-)

Here is the summary with links:
  - [f2fs-dev,v2,43/92] f2fs: convert to ctime accessor functions
    https://git.kernel.org/jaegeuk/f2fs/c/c62ebd3501cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


