Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C660A6D9FBB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 20:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240121AbjDFSZf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 14:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239721AbjDFSZe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:25:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAE57DB6;
        Thu,  6 Apr 2023 11:25:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B5AF60F37;
        Thu,  6 Apr 2023 18:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5529AC433D2;
        Thu,  6 Apr 2023 18:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680805527;
        bh=TjkZqObnX6Ozi0JkMk8YeQobLclqYcS5rFl3Axh7jNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EySMTc1+Gui6oWZ3Z73LoRaOkTzZnNKvZ5OShzR8luJnMJwt+oCjo1sSBbSzI+abI
         jt6UrOwjuwQz1dykl2pTeGQoqJgiHjW93tnj5iZdIUUPaXLx0WhEDhbErqRH5kHp4c
         HFCgYVOVuo5dEDfsEVteXRF9Fa2z2ia7HYRGBmW8zXvLSewntDNo4pRjclV218Ubjo
         gNmq/ed3w5JuVZtcyIfCatHFZ1B/7wW7X+C8fPWhi392wagflK4w9xVSQen+UKeL7z
         uTZ1ddwj/GcVRrf1NJGVKqSd5drJQvjyLx0vq8GYVD8b1wzcBBnRjGxSpZzsH/q0Ih
         fAS5jgNIn8JMA==
Date:   Thu, 6 Apr 2023 11:25:25 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     fsverity@lists.linux.dev
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2] fsverity: use WARN_ON_ONCE instead of WARN_ON
Message-ID: <20230406182525.GA1190@sol.localdomain>
References: <20230406181542.38894-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406181542.38894-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 06, 2023 at 11:15:42AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> As per Linus's suggestion
> (https://lore.kernel.org/r/CAHk-=whefxRGyNGzCzG6BVeM=5vnvgb-XhSeFJVxJyAxAF8XRA@mail.gmail.com),
> use WARN_ON_ONCE instead of WARN_ON.  This barely adds any extra
> overhead, and it makes it so that if any of these ever becomes reachable
> (they shouldn't, but that's the point), the logs can't be flooded.
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/verity/enable.c       | 4 ++--
>  fs/verity/hash_algs.c    | 4 ++--
>  fs/verity/open.c         | 2 +-
>  include/linux/fsverity.h | 6 +++---
>  4 files changed, 8 insertions(+), 8 deletions(-)

Sorry, forgot changelog:

v2: also convert the three WARN_ON in include/linux/fsverity.h

- Eric
