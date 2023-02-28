Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675CC6A50BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 02:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjB1Bav (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 20:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjB1Bat (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 20:30:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C18525D;
        Mon, 27 Feb 2023 17:30:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29A3DB80DD4;
        Tue, 28 Feb 2023 01:30:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDCCC433EF;
        Tue, 28 Feb 2023 01:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677547840;
        bh=6EQygXN8kukb7xm8ElTC1sWTx2fOUPnzwfRnnHir0SI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X5G2bH9NLF+y6DAWm3C4skJJzRgvigSXnX2FpEPoftZkh4Js4TJhQz39F0yfuBc4+
         wGYJfgnaQn8OApX8WXE/A6K8i+AGLRrm02Bb974d0Gie8HBYP6K5kVgAcESKSGoK4b
         VMD2nG9gLw8XmVoBgmBGuNo2fgQUM4ahH7KLi/1vzO5/s9G7I++hxYqixvJqJwCe3k
         R5WzZB6PDMETiydk3l4+LebgKGAg0irUwXQbDy5gnZ0eJNydQYu++C0S6uXcWm4/Zz
         sO2RyTarFPwlvvZVqsQ32RCohoZPZZ5cmrjyynzZYyzdWRV40lvgGyTBJuAvesw34a
         8vNGxrE3bAgvA==
Date:   Tue, 28 Feb 2023 01:30:39 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     patchwork-bot+f2fs@kernel.org, linux-fscrypt@vger.kernel.org,
        aalbersh@redhat.com, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/11] fsverity: support for non-4K pages
Message-ID: <Y/1ZP9pc1Zw9xh/L@gmail.com>
References: <20221223203638.41293-1-ebiggers@kernel.org>
 <167754611492.27916.393758892204411776.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167754611492.27916.393758892204411776.git-patchwork-notify@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 28, 2023 at 01:01:54AM +0000, patchwork-bot+f2fs@kernel.org wrote:
> Hello:
> 
> This series was applied to jaegeuk/f2fs.git (dev)
> by Eric Biggers <ebiggers@google.com>:
> 
> On Fri, 23 Dec 2022 12:36:27 -0800 you wrote:
> > [This patchset applies to mainline + some fsverity cleanups I sent out
> >  recently.  You can get everything from tag "fsverity-non4k-v2" of
> >  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git ]
> > 
> > Currently, filesystems (ext4, f2fs, and btrfs) only support fsverity
> > when the Merkle tree block size, filesystem block size, and page size
> > are all the same.  In practice that means 4K, since increasing the page
> > size, e.g. to 16K, forces the Merkle tree block size and filesystem
> > block size to be increased accordingly.  That can be impractical; for
> > one, users want the same file signatures to work on all systems.
> > 
> > [...]
> 
> Here is the summary with links:
>   - [f2fs-dev,v2,01/11] fsverity: use unsigned long for level_start
>     https://git.kernel.org/jaegeuk/f2fs/c/284d5db5f99e
>   - [f2fs-dev,v2,02/11] fsverity: simplify Merkle tree readahead size calculation
>     https://git.kernel.org/jaegeuk/f2fs/c/9098f36b739d
>   - [f2fs-dev,v2,03/11] fsverity: store log2(digest_size) precomputed
>     https://git.kernel.org/jaegeuk/f2fs/c/579a12f78d88
>   - [f2fs-dev,v2,04/11] fsverity: use EFBIG for file too large to enable verity
>     https://git.kernel.org/jaegeuk/f2fs/c/55eed69cc8fd
>   - [f2fs-dev,v2,05/11] fsverity: replace fsverity_hash_page() with fsverity_hash_block()
>     https://git.kernel.org/jaegeuk/f2fs/c/f45555bf23cf
>   - [f2fs-dev,v2,06/11] fsverity: support verification with tree block size < PAGE_SIZE
>     https://git.kernel.org/jaegeuk/f2fs/c/5306892a50bf
>   - [f2fs-dev,v2,07/11] fsverity: support enabling with tree block size < PAGE_SIZE
>     https://git.kernel.org/jaegeuk/f2fs/c/56124d6c87fd
>   - [f2fs-dev,v2,08/11] ext4: simplify ext4_readpage_limit()
>     https://git.kernel.org/jaegeuk/f2fs/c/5e122148a3d5
>   - [f2fs-dev,v2,09/11] f2fs: simplify f2fs_readpage_limit()
>     https://git.kernel.org/jaegeuk/f2fs/c/feb0576a361a
>   - [f2fs-dev,v2,10/11] fs/buffer.c: support fsverity in block_read_full_folio()
>     https://git.kernel.org/jaegeuk/f2fs/c/4fa512ce7051
>   - [f2fs-dev,v2,11/11] ext4: allow verity with fs block size < PAGE_SIZE
>     https://git.kernel.org/jaegeuk/f2fs/c/db85d14dc5c5
> 
> You are awesome, thank you!
> -- 
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
> 

These commits reached the f2fs tree through mainline, not through being applied
to the f2fs tree.  So this email shouldn't have been sent.  Jaegeuk, can you
look into fixing the configuration of the f2fs patchwork bot to prevent this?

- Eric
