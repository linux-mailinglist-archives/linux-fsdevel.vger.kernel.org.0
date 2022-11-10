Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68B3623D56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Nov 2022 09:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbiKJIV2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Nov 2022 03:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbiKJIVN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:21:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4093E303EF;
        Thu, 10 Nov 2022 00:21:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D48D261D9C;
        Thu, 10 Nov 2022 08:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C99C433D6;
        Thu, 10 Nov 2022 08:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668068468;
        bh=V4PksRxciyWcpEl1FdsFkRS1q41vAQbL5WxWCTxZ4R4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ATUHt+2OYi+BTLL9Rfxm4zhC247eXcHkpbBDYWoqk2gEP9R45S/C5ZMMpgvvfeNHU
         cCw5wY6Kd+ABxfmMZ6j1Z15h4eUDR3qTwej29NIYfbSkbHIrBY8m+lAIlr/QSev1Ju
         I2awfYbJ+HG+OO7LUcG7KW0oZZHmtahpxI8cOOg89EN/nTS1g97axe09YJ74/jmyT2
         Xxl/lesbwfM4GDXzdAlu9r+EWOVWakcbb/cwUdGOqT4Wh/PvRvKbJbGmv1JNwiqHHp
         8xcwbvEEZvbQGFRHk3FA4BnAn7lwgtQd2t8UTYS63n796Of1ee7CL7MO2kMmC5+xAu
         SRmskugnBGtmg==
Date:   Thu, 10 Nov 2022 00:21:06 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3] fsverity: stop using PG_error to track error status
Message-ID: <Y2y0cspSZG5dt6c+@sol.localdomain>
References: <20221028175807.55495-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028175807.55495-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 28, 2022 at 10:58:07AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> As a step towards freeing the PG_error flag for other uses, change ext4
> and f2fs to stop using PG_error to track verity errors.  Instead, if a
> verity error occurs, just mark the whole bio as failed.  The coarser
> granularity isn't really a problem since it isn't any worse than what
> the block layer provides, and errors from a multi-page readahead aren't
> reported to applications unless a single-page read fails too.
> 
> f2fs supports compression, which makes the f2fs changes a bit more
> complicated than desired, but the basic premise still works.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> 
> In v3, I made a small simplification to the f2fs changes.  I'm also only
> sending the fsverity patch now, since the fscrypt one is now upstream.  
> 
>  fs/ext4/readpage.c |  8 ++----
>  fs/f2fs/compress.c | 64 ++++++++++++++++++++++------------------------
>  fs/f2fs/data.c     | 48 +++++++++++++++++++---------------
>  fs/verity/verify.c | 12 ++++-----
>  4 files changed, 67 insertions(+), 65 deletions(-)

I've applied this to the fsverity tree for 6.2.

Reviews would be greatly appreciated, of course.

- Eric
