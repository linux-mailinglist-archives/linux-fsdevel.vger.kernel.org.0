Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBFF6A5216
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 04:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjB1DxH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 22:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB1DxG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 22:53:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B168B44A;
        Mon, 27 Feb 2023 19:53:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E847FB80CA7;
        Tue, 28 Feb 2023 03:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302CFC433D2;
        Tue, 28 Feb 2023 03:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677556382;
        bh=u8P31QxD6VV0jVGuvboxfDzZUtsbvH8OqzD+6Goz13Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e2ZMcf24XxXbmCDzekB/T7YgJd/1GyrFRUrcuJfG9m4ayef66+7XXgKFql4BMYnLI
         p3ky/n0i1OnZR19uWIXn1JvY16gg4xY0q+gyTYsqXUGGVBpkRbqy7K11DH7OLx5oQg
         f7COZR8BF+TRB8PPa6/um00w3t3VQDwhMNyrVXQIwYLR235/Uw3h1WX6XJZ1dYtcV/
         qHMFfpCP07a6FXcHhw/nYLLJkaStaw6d1+MUfdsMtT8+tPcRNOb2D9Qoa/StZ1rRjT
         HIYWGv7xoXxJxIRin1Ui40Le9yyuYE2MfFWwbjN5W1hvaCdmsqgZbuZscnkHj1knk4
         zPMU2QcVCsdSw==
Date:   Mon, 27 Feb 2023 19:53:00 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     patchwork-bot+f2fs@kernel.org, linux-fscrypt@vger.kernel.org,
        aalbersh@redhat.com, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/11] fsverity: support for non-4K pages
Message-ID: <Y/16nEs4stc/0qmb@google.com>
References: <20221223203638.41293-1-ebiggers@kernel.org>
 <167754611492.27916.393758892204411776.git-patchwork-notify@kernel.org>
 <Y/1ZP9pc1Zw9xh/L@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/1ZP9pc1Zw9xh/L@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02/28, Eric Biggers wrote:
> On Tue, Feb 28, 2023 at 01:01:54AM +0000, patchwork-bot+f2fs@kernel.org wrote:
> > Hello:
> > 
> > This series was applied to jaegeuk/f2fs.git (dev)
> > by Eric Biggers <ebiggers@google.com>:
> > 
> > On Fri, 23 Dec 2022 12:36:27 -0800 you wrote:
> > > [This patchset applies to mainline + some fsverity cleanups I sent out
> > >  recently.  You can get everything from tag "fsverity-non4k-v2" of
> > >  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git ]
> > > 
> > > Currently, filesystems (ext4, f2fs, and btrfs) only support fsverity
> > > when the Merkle tree block size, filesystem block size, and page size
> > > are all the same.  In practice that means 4K, since increasing the page
> > > size, e.g. to 16K, forces the Merkle tree block size and filesystem
> > > block size to be increased accordingly.  That can be impractical; for
> > > one, users want the same file signatures to work on all systems.
> > > 
> > > [...]
> > 
> > Here is the summary with links:
> >   - [f2fs-dev,v2,01/11] fsverity: use unsigned long for level_start
> >     https://git.kernel.org/jaegeuk/f2fs/c/284d5db5f99e
> >   - [f2fs-dev,v2,02/11] fsverity: simplify Merkle tree readahead size calculation
> >     https://git.kernel.org/jaegeuk/f2fs/c/9098f36b739d
> >   - [f2fs-dev,v2,03/11] fsverity: store log2(digest_size) precomputed
> >     https://git.kernel.org/jaegeuk/f2fs/c/579a12f78d88
> >   - [f2fs-dev,v2,04/11] fsverity: use EFBIG for file too large to enable verity
> >     https://git.kernel.org/jaegeuk/f2fs/c/55eed69cc8fd
> >   - [f2fs-dev,v2,05/11] fsverity: replace fsverity_hash_page() with fsverity_hash_block()
> >     https://git.kernel.org/jaegeuk/f2fs/c/f45555bf23cf
> >   - [f2fs-dev,v2,06/11] fsverity: support verification with tree block size < PAGE_SIZE
> >     https://git.kernel.org/jaegeuk/f2fs/c/5306892a50bf
> >   - [f2fs-dev,v2,07/11] fsverity: support enabling with tree block size < PAGE_SIZE
> >     https://git.kernel.org/jaegeuk/f2fs/c/56124d6c87fd
> >   - [f2fs-dev,v2,08/11] ext4: simplify ext4_readpage_limit()
> >     https://git.kernel.org/jaegeuk/f2fs/c/5e122148a3d5
> >   - [f2fs-dev,v2,09/11] f2fs: simplify f2fs_readpage_limit()
> >     https://git.kernel.org/jaegeuk/f2fs/c/feb0576a361a
> >   - [f2fs-dev,v2,10/11] fs/buffer.c: support fsverity in block_read_full_folio()
> >     https://git.kernel.org/jaegeuk/f2fs/c/4fa512ce7051
> >   - [f2fs-dev,v2,11/11] ext4: allow verity with fs block size < PAGE_SIZE
> >     https://git.kernel.org/jaegeuk/f2fs/c/db85d14dc5c5
> > 
> > You are awesome, thank you!
> > -- 
> > Deet-doot-dot, I am a bot.
> > https://korg.docs.kernel.org/patchwork/pwbot.html
> > 
> 
> These commits reached the f2fs tree through mainline, not through being applied
> to the f2fs tree.  So this email shouldn't have been sent.  Jaegeuk, can you
> look into fixing the configuration of the f2fs patchwork bot to prevent this?

Hmm, not sure how to fix that, since it seems patchwork bot reports this, once
I pulled mainline into f2fs/dev branch.

> 
> - Eric
