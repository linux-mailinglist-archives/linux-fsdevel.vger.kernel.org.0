Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A9F749265
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 02:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjGFASW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 20:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjGFASS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 20:18:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD62A19B9;
        Wed,  5 Jul 2023 17:18:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11A55617D8;
        Thu,  6 Jul 2023 00:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3203C433D9;
        Thu,  6 Jul 2023 00:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688602695;
        bh=Wq4Kf5jvhnktrqkplac3NbW2zj2tA4epX9jlz+qsmxU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FqFLZi+08sYjnqaXYAl7RC8hWusLeRJdeJY3rxkQpMAg2656v3faM7lVBPC47eq9w
         Ye27mWuDhpMkkbOOWhIfBLD7GWqruxk/n/4E3YevhZscqfl1NYaHhydhD8Y1w7MhOi
         t72EFVvoOgabyvl1EvnEIHoGc9gW57dQGKiys/9Tt7JEjmdbNnvXszJOzgTHk0ZtGL
         x5tXDyb7XsDe0FZOuxbCSC80OgwapO1qbNtM21geupHJfgNFOygMaX5FugtGkwYFKR
         Wljo4GjMOilwWQ+w28lEf2vFPf8rU73LLcFJe/sDPVUCdXPSczpV+xwnaknMRFn8wz
         t1C0p5ZN3fGPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C19C0C0C40E;
        Thu,  6 Jul 2023 00:18:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 01/13] iomap: update ki_pos a little later in
 iomap_dio_complete
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168860269478.29151.608883953593901827.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Jul 2023 00:18:14 +0000
References: <20230519093521.133226-2-hch@lst.de>
In-Reply-To: <20230519093521.133226-2-hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     willy@infradead.org, djwong@kernel.org, linux-mm@kvack.org,
        agruenba@redhat.com, miklos@szeredi.hu, cluster-devel@redhat.com,
        idryomov@gmail.com, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-block@vger.kernel.org,
        dlemoal@kernel.org, viro@zeniv.linux.org.uk, jaegeuk@kernel.org,
        ceph-devel@vger.kernel.org, xiubli@redhat.com,
        trond.myklebust@hammerspace.com, axboe@kernel.dk,
        brauner@kernel.org, tytso@mit.edu,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        anna@kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Andrew Morton <akpm@linux-foundation.org>:

On Fri, 19 May 2023 11:35:09 +0200 you wrote:
> Move the ki_pos update down a bit to prepare for a better common
> helper that invalidates pages based of an iocb.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/direct-io.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)

Here is the summary with links:
  - [f2fs-dev,01/13] iomap: update ki_pos a little later in iomap_dio_complete
    https://git.kernel.org/jaegeuk/f2fs/c/936e114a245b
  - [f2fs-dev,02/13] filemap: update ki_pos in generic_perform_write
    (no matching commit)
  - [f2fs-dev,03/13] filemap: assign current->backing_dev_info in generic_perform_write
    (no matching commit)
  - [f2fs-dev,04/13] filemap: add a kiocb_write_and_wait helper
    https://git.kernel.org/jaegeuk/f2fs/c/3c435a0fe35c
  - [f2fs-dev,05/13] filemap: add a kiocb_invalidate_pages helper
    https://git.kernel.org/jaegeuk/f2fs/c/e003f74afbd2
  - [f2fs-dev,06/13] filemap: add a kiocb_invalidate_post_write helper
    (no matching commit)
  - [f2fs-dev,07/13] iomap: update ki_pos in iomap_file_buffered_write
    (no matching commit)
  - [f2fs-dev,08/13] iomap: assign current->backing_dev_info in iomap_file_buffered_write
    (no matching commit)
  - [f2fs-dev,09/13] iomap: use kiocb_write_and_wait and kiocb_invalidate_pages
    https://git.kernel.org/jaegeuk/f2fs/c/8ee93b4bb626
  - [f2fs-dev,10/13] fs: factor out a direct_write_fallback helper
    (no matching commit)
  - [f2fs-dev,11/13] fuse: update ki_pos in fuse_perform_write
    (no matching commit)
  - [f2fs-dev,12/13] fuse: drop redundant arguments to fuse_perform_write
    (no matching commit)
  - [f2fs-dev,13/13] fuse: use direct_write_fallback
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


