Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A09E741BB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 00:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjF1WRq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 18:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjF1WRp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 18:17:45 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F732116
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 15:17:42 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b8033987baso279245ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 15:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687990662; x=1690582662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5/gmMRiFqqJ+Lsen9zPMWgthjvjxQcSheMjSUphDCJM=;
        b=d7qH+KgoGAPGoTPMx8m9/Hrt2b2VhaNypZ0WskDBHIdCwRRA3rLkNrUKBcdYP/gaAQ
         cpg+gX+EJN+pJZV89Z9d3qtV6vK/gNa/Xrze+KmjqYRYPSLqYIPaXVgDS8sMJVClXX58
         +5GBew/ctHMLeRIQkcFt4aCXGAexxGGSBVUrLxweWn/gxH8moGmYR09JW+c5t1y1fRhE
         D5Ooipzsf5QL+/Mq3YSxTGjD6DVi5m4rP85kaPBMGM4ZzK3n2mjqECtZmyRSppC9m061
         ovlLAvcUzXPhIeB554pIVlA2GLV5y6Wp96uaWhkDEIlq0v56TkbntwytQpp4n/Cm4W0d
         P2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687990662; x=1690582662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/gmMRiFqqJ+Lsen9zPMWgthjvjxQcSheMjSUphDCJM=;
        b=TpQ9OsgsXZh5aBc7hJWtLJdaWqielPIUi+Lb+P2hQe97puD2PcMhGrygcQvieMWer9
         wQ/JZhISnau2OcyQWWLnVvAgyKWTd6tQ+nm8eqmPRPEPMCk07zRxuSkbeQq+n7bfAofm
         oPRwWZNndKd2rIMDMnOW2ITwWwu/V3xUTrLESEm/kSjrFP1rfOLrisCsB+5sr2umIRJq
         3/lV/TWu/sN5PvY2CbB3gP74pEZ9NTL+NAYgrYrypa9O/TeinNsYdumlGvB8lQ8QgmQ3
         xhJlNAG9LcgpwI4n1arYz32OFt239ocD7XxSaNqkYzwbbjUDFR6aPTRd6T3w79asWqY2
         10eg==
X-Gm-Message-State: AC+VfDxPQbDRwFERAs+9zJBNCm01tFS4YGtECf7nR06209W01elaOpsg
        820I3pXLTtF3wUafzHZIfm0MzA==
X-Google-Smtp-Source: ACHHUZ6unZGfFsyCYjaAJZn7z1KDMKA76rEnPDR2xxlmcqL/XcD52Nbw4Xu57xIEJ5a+D7GMLvWbjQ==
X-Received: by 2002:a17:90a:fe14:b0:262:fc6f:88c7 with SMTP id ck20-20020a17090afe1400b00262fc6f88c7mr3217158pjb.23.1687990662075;
        Wed, 28 Jun 2023 15:17:42 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-94-37.pa.vic.optusnet.com.au. [49.186.94.37])
        by smtp.gmail.com with ESMTPSA id 12-20020a17090a194c00b00253305f36c4sm10685355pjh.18.2023.06.28.15.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 15:17:41 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qEdTm-00HOGV-0w;
        Thu, 29 Jun 2023 08:17:38 +1000
Date:   Thu, 29 Jun 2023 08:17:38 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Matt Whitlock <kernel@mattwhitlock.name>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [Reproducer] Corruption, possible race between splice and
 FALLOC_FL_PUNCH_HOLE
Message-ID: <ZJyxguAkaTMc+UM2@dread.disaster.area>
References: <a60594ef-ff85-498f-a1c4-0fcb9586621c@mattwhitlock.name>
 <ZJq6nJBoX1m6Po9+@casper.infradead.org>
 <ec804f26-fa76-4fbe-9b1c-8fbbd829b735@mattwhitlock.name>
 <ZJp4Df8MnU8F3XAt@dread.disaster.area>
 <3299543.1687933850@warthog.procyon.org.uk>
 <3695109.1687976846@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3695109.1687976846@warthog.procyon.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 07:27:26PM +0100, David Howells wrote:
> Matt Whitlock <kernel@mattwhitlock.name> wrote:
> 
> > In other words, the currently implemented behavior is appropriate for
> > SPLICE_F_MOVE, but it is not appropriate for ~SPLICE_F_MOVE.
> 
> The problems with SPLICE_F_MOVE is that it's only applicable to splicing *out*
> of a pipe.  By the time you get that far the pages can already be corrupted by
> a shared-writable mmap or write().

That's not documented in the man page.

Indeed, I think Matt's point - and mine, too, for that matter - is
that the splice(2) man page documents *none* of this
"copy-by-reference" behaviour or it's side effects. All the man page
documents is that the data is *copied in kernel-space* rather than
needing kernel->user->kernel data movement to copy it from one fd to
the other.

The man page *heavily implies* that splice is a "fast immediate
data copy". It most definitely does not describe any "zero-copy with
whacky post-completion data stream corrupting side effects"
mechanisms. There's not even an entry in the "notes" or "bugs"
section to warn users that they cannot trust the contents of the
source or destination pipe to be what they think they might be as
the "data copy" implied by the pipe buffer might not occur until
some arbitrary time in the future.

Hence, according to the man page, what it is doing right now
definitely contrary to the behaviour implied by the documentation...

i.e. If the data that is "copied" to the destination pipe is not
resolved until some future action by some 3rd party process is
performed, then the man page must tell users they cannot use this
for any sort of data stream where they require the data being
transferred needs to remain stable as of the time of the splice
operation.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
