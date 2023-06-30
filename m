Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04C1743E92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 17:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjF3PUA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 11:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbjF3PT0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:19:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABFC2703;
        Fri, 30 Jun 2023 08:19:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18F7361782;
        Fri, 30 Jun 2023 15:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C11C433C0;
        Fri, 30 Jun 2023 15:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688138359;
        bh=0OcMf9HI6oDlP5s96FA6hXvlby0mTwGL255F60fmJNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oq6SRXemZv3QPiYrxSGaCswEqBNCx4KmAFohDEmaVSWQhjF6v7shFbQLXFl7y9UUt
         KhheirUrp06qdtMvnhiWU+Lejx3RY86tVjq03epKOAkw+hkExs3HaLwwk0iAfcRmtD
         YK4ehi7CKWHgtMOXqOTjhnuQVCD4aUqezAdq1zeSFoq5GFcAlXDD7iG0Jtg+EtRrws
         E7YYO1HUD1n2hwY4igPS/nBFtuuyzSj7sS70XDJLpJEotBepbevEc2/aABE3sEcqnw
         W7rFpy30JPR4C7PLt76qUUA4sIcS81Muwb1Srh8zvHWwzdvSzcf82JEW+OrIEttNB7
         lT/gMrs4D9vdg==
Date:   Fri, 30 Jun 2023 08:19:19 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     zenghongling <zenghongling@kylinos.cn>
Cc:     hch@infradead.org, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhongling0719@126.com
Subject: Re: [PATCH] fs: Optimize unixbench's file copy test
Message-ID: <20230630151919.GK11441@frogsfrogsfrogs>
References: <1688117303-8294-1-git-send-email-zenghongling@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688117303-8294-1-git-send-email-zenghongling@kylinos.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 30, 2023 at 05:28:23PM +0800, zenghongling wrote:
> The iomap_set_range_uptodate function checks if the file is a private
> mapping,and if it is, it needs to do something about it.UnixBench's
> file copy tests are mostly share mapping, such a check would reduce
> file copy scores, so we added the unlikely macro for optimization.
> and the score of file copy can be improved after branch optimization.
> As follows:
> 
> ./Run -c 8 -i 3 fstime fsbuffer fsdisk
> 
> Before the optimization
> System Benchmarks Partial Index              BASELINE       RESULT    INDEX
> File Copy 1024 bufsize 2000 maxblocks          3960.0     689276.0   1740.6
> File Copy 256 bufsize 500 maxblocks            1655.0     204133.0   1233.4
> File Copy 4096 bufsize 8000 maxblocks          5800.0    1526945.0   2632.7
>                                                                    ========
> System Benchmarks Index Score (Partial Only)                         1781.3
> 
> After the optimization
> System Benchmarks Partial Index              BASELINE       RESULT    INDEX
> File Copy 1024 bufsize 2000 maxblocks          3960.0     741524.0   1872.5
> File Copy 256 bufsize 500 maxblocks            1655.0     208334.0   1258.8
> File Copy 4096 bufsize 8000 maxblocks          5800.0    1641660.0   2830.4
>                                                                    ========
> System Benchmarks Index Score (Partial Only)                         1882.6

Kernel version?  And how does this intersect with the ongoing work to
use large folios throughout iomap?

--D

> Signed-off-by: zenghongling <zenghongling@kylinos.cn>
> ---
>  fs/iomap/buffered-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 53cd7b2..35a50c2 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -148,7 +148,7 @@ iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
>  	if (PageError(page))
>  		return;
>  
> -	if (page_has_private(page))
> +	if (unlikely(page_has_private(page)))
>  		iomap_iop_set_range_uptodate(page, off, len);
>  	else
>  		SetPageUptodate(page);
> -- 
> 2.1.0
> 
