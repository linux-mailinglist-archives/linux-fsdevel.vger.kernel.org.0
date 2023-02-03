Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABA268A518
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 22:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbjBCV6k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 16:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjBCV6j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 16:58:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A1C8E6B3
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Feb 2023 13:58:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C29D66200C
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Feb 2023 21:58:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA6EC433EF;
        Fri,  3 Feb 2023 21:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675461517;
        bh=hRBqqqesfuLo7VBuv3Yssw6Ibjh21u+vuMqun3IcqIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZOQ881oYCknWoHFHHEV4kTkV57TEobDmtpbaCP2WLMbaiU2bVNoJe0cZ8fX1p+qTR
         CkqvpZuIFx0xxUmkZTpE8EUZ8SZDeWoZpWPxacMebTAR2lcZU4sk8krJk++NQrm2T7
         bvdRCCCEDR1sQ2YVQWE+at8DuQPNeDLGNtJteePkdqZMUUhInDqrXJ9cCIl0WSMt9I
         B21HeTPK1sKq40M2T+uFUhWgxJyDJ6eD6upbB5/hRhN8QZY7oFhTTQJFtkjs6jY64q
         HVC5JoTJ4gCTkmWUifUXpnIh1yf8cR6pjmPhX2Yhj6aijiLCFlDc2sUrT5Fl6r8UZp
         ZRFcPwfglAMlw==
Date:   Fri, 3 Feb 2023 13:58:35 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     fsverity@lists.linux.dev
Cc:     linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] fsverity: support verifying data from large folios
Message-ID: <Y92DiwxOmc+EE+Tu@sol.localdomain>
References: <20230127221529.299560-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127221529.299560-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 27, 2023 at 02:15:29PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Try to make fs/verity/verify.c aware of large folios.  This includes
> making fsverity_verify_bio() support the case where the bio contains
> large folios, and adding a function fsverity_verify_folio() which is the
> equivalent of fsverity_verify_page().
> 
> There's no way to actually test this with large folios yet, but I've
> tested that this doesn't cause any regressions.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> 
> This patch is targeting 6.3, and it applies to
> https://git.kernel.org/pub/scm/fs/fsverity/linux.git/log/?h=for-next
> Note: to avoid a cross-tree dependency, in fs/buffer.c I used
> page_folio(bh->b_page) instead of bh->b_folio.
> 
>  Documentation/filesystems/fsverity.rst | 20 ++++++------
>  fs/buffer.c                            |  3 +-
>  fs/verity/verify.c                     | 43 +++++++++++++-------------
>  include/linux/fsverity.h               | 15 ++++++---
>  4 files changed, 44 insertions(+), 37 deletions(-)

Applied to https://git.kernel.org/pub/scm/fs/fsverity/linux.git/log/?h=for-next

- Eric
