Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B94E6DD60D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 10:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjDKI6Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 04:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDKI6R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:58:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030842691;
        Tue, 11 Apr 2023 01:58:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FDEA60B54;
        Tue, 11 Apr 2023 08:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1F9C433EF;
        Tue, 11 Apr 2023 08:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681203488;
        bh=k4ge5HqnVcBGWNMlqm6Oo2tJAFivoB8nrqwqk8ZUbjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ouJXDogODS75tgfWWbqqtrgkaSB8DNavqQkmT8J7sYznPTElWBYkWxEYRBfuAnBiO
         t8gQab2TFRQNvAVlxpWJOQlOGAXF3XGbXU6DDR+9KSZkimnjSJGmQJE9oAmxaldxjG
         2efHCilCeMQVIFXzx8+GqyPFkXUHbTusaZ32aOZTfPOHjlkJiMqjx903gPtkuYYAIu
         AZfIwz/jz/0QjHwHV27jlg/vCGHmXs8T12aPzMxcUZm7vWxEpM2I/uPxgmzXUihhrj
         JyfJIHvLxIPTXScdlab/ymvEMW6lN+K77F0WsO1FV/IoV3+Z+y1eKIoMK9wzrMnzwY
         OJ0aZSlAEfXzA==
Date:   Tue, 11 Apr 2023 10:58:03 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2] fsverity: use WARN_ON_ONCE instead of WARN_ON
Message-ID: <20230411-duktus-leitsatz-33c2dc2c7bde@brauner>
References: <20230406181542.38894-1-ebiggers@kernel.org>
 <20230406182525.GA1190@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230406182525.GA1190@sol.localdomain>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 06, 2023 at 11:25:25AM -0700, Eric Biggers wrote:
> On Thu, Apr 06, 2023 at 11:15:42AM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > As per Linus's suggestion
> > (https://lore.kernel.org/r/CAHk-=whefxRGyNGzCzG6BVeM=5vnvgb-XhSeFJVxJyAxAF8XRA@mail.gmail.com),
> > use WARN_ON_ONCE instead of WARN_ON.  This barely adds any extra
> > overhead, and it makes it so that if any of these ever becomes reachable
> > (they shouldn't, but that's the point), the logs can't be flooded.
> > 
> > Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >  fs/verity/enable.c       | 4 ++--
> >  fs/verity/hash_algs.c    | 4 ++--
> >  fs/verity/open.c         | 2 +-
> >  include/linux/fsverity.h | 6 +++---
> >  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> Sorry, forgot changelog:
> 
> v2: also convert the three WARN_ON in include/linux/fsverity.h

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
