Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D457A313B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 17:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbjIPPvS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Sep 2023 11:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238407AbjIPPvA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Sep 2023 11:51:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32199F7;
        Sat, 16 Sep 2023 08:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q9NosZnRxeft56oj4p2r/NWATsovvrHRZyqFuy7rBbo=; b=HygmhOnBUvsHJeiHPubdfb6ZLL
        hrfrPa1q2R2TpeY5Ad9/H0TbJtEgaTml9EaeGSj21539hAQJqfKtMQOJ9r2F2KnqPGhePdSCJyR0s
        ZMgMGUgWo+sLl4xPf3Omm+XgP1gXCJirGlrJp9oiHhOMZacR/s+44GBXYUuDh0Ci/b+qZ00nx+raO
        oLFtCGoCxtIrvnOXjFdY1f3NhsgMUYB+obMrsjscvx0EHfezQAh3qHadIVrejW2o6A2vAUWuoeM2Y
        BM6Grx2D+H9d1C32e/gNSxNTNorwHumwKS+bDZvXb80Li/a3gGdpkY330aynHXUPuZXxrtET18XSK
        lEyjgYEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhXZL-00H0DC-O8; Sat, 16 Sep 2023 15:50:51 +0000
Date:   Sat, 16 Sep 2023 16:50:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 02/17] iomap: Protect read_bytes_pending with the
 state_lock
Message-ID: <ZQXO27KCTaWvuPPA@casper.infradead.org>
References: <20230915183707.2707298-1-willy@infradead.org>
 <20230915183707.2707298-3-willy@infradead.org>
 <CAHk-=wh4=cYh5OC5PiiX_nAQkyViXL21bpmaARduGOLiOOgTyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh4=cYh5OC5PiiX_nAQkyViXL21bpmaARduGOLiOOgTyw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 05:11:55PM -0700, Linus Torvalds wrote:
> I think it ends up looking like this:
> 
>   static void iomap_finish_folio_read(struct folio *folio, size_t off,
>                   size_t len, int error)
>   {
>         struct iomap_folio_state *ifs = folio->private;
>         bool uptodate = true;
>         bool finished = true;
> 
>         if (ifs) {
>                 unsigned long flags;
> 
>                 spin_lock_irqsave(&ifs->state_lock, flags);
> 
>                 if (!error)
>                         uptodate = ifs_set_range_uptodate(folio, ifs,
> off, len);
> 
>                 ifs->read_bytes_pending -= len;
>                 finished = !ifs->read_bytes_pending;
>                 spin_unlock_irqrestore(&ifs->state_lock, flags);
>         }
> 
>         if (unlikely(error))
>                 folio_set_error(folio);
>         else if (uptodate)
>                 folio_mark_uptodate(folio);
>         if (finished)
>                 folio_unlock(folio);
>   }
> 
> but that was just a quick hack-work by me (the above does, for
> example, depend on folio_mark_uptodate() not needing the
> ifs->state_lock, so the shared parts then got moved out).

I really like this.  One tweak compared to your version:

        bool uptodate = !error;
...
        if (error)
                folio_set_error(folio);
        if (uptodate)
                folio_mark_uptodate(folio);
        if (finished)
                folio_unlock(folio);

... and then the later patch becomes

	if (finished)
		folio_end_read(folio, uptodate);
