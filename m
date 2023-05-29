Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B437151F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 00:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjE2Wjp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 May 2023 18:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjE2Wjo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 May 2023 18:39:44 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481EED2
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 May 2023 15:39:37 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d577071a6so4423907b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 May 2023 15:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1685399977; x=1687991977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wx7H79kjT6gmQYpSqCpEUZ9C7FgqkhS0HzDi2l0vcVg=;
        b=Ha0SOdPQTwrcubn4x3Dlo6qyJ1FJqfxqxiG//TSDuEy81m7MOuSLkf9aKBle6u/6k7
         qNCkslgWkbSl/mOavuL27vq2J0/BUEUXfRiT6HVGV/HJm7+B7c0AycgV0REuhSOEaUBL
         bY9tVrU3Irp+H7GUBOV7PXmfIyoYB3u5cl/yXLWG1CwJkJNagfiL9fwp8ZATL8wVc+UV
         dZGlHatOACtmkISIddPQ+rQWoe4tmVvyyIEDMlXSmxqZhNTinYMrkKhMOjz7WEjLTDF7
         YUrowfNT71l8OeMb2o0EVkhed3GXT5s/zSLzBKBeQvqtifa8rCr9hYjI6HKId1cjvvqd
         R3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685399977; x=1687991977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wx7H79kjT6gmQYpSqCpEUZ9C7FgqkhS0HzDi2l0vcVg=;
        b=i/J3o5l5W9ZOeBwi//WncPQDmJ3HmAu3yXhoNVa7hV5ln6s5owFmHMoCh4PmigFKFx
         Pfk0R1hQRv8wtK1j/jyB+Gar6egC6o8SjTvW1Zrorsvkhy8qwq08+DDeh7BO9F0WXfWn
         38sxMm/1wEu/DUePbAGQ52+ds4BM1i4sk9f4LvACNLHwMrQ7Chvosa6kK7kqWRsakzhD
         GEyxa6xjFRnmLpBz78NY3qflVvKWSqY0vcXyxgPAwOyfNwrqNW5qAtsCGoY0shD5dnF7
         ogHbMJscwC83FOlkajFoT9TmbZMzIDwmm615/b+6uqp5P1/Se7ywhqu/agxQkassHz2+
         6cqA==
X-Gm-Message-State: AC+VfDxvpJfDMAB0VYCsHSuGxCf1Nzk4QAVPylB2PG911OSpi96gZq9O
        xEl3J9DzIHPCzrA649xHFr3w19UmyBE0IlBysyk=
X-Google-Smtp-Source: ACHHUZ5eN4x0CrceYVmiIHZfFyM7yZnNYI0D1umb+f9fyzYPL4eeXeyev/gh9wYQ49lM0B1QXna/0Q==
X-Received: by 2002:a05:6a00:b84:b0:64d:4a94:1a60 with SMTP id g4-20020a056a000b8400b0064d4a941a60mr113964pfj.18.1685399976657;
        Mon, 29 May 2023 15:39:36 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id s5-20020a62e705000000b00634a96493f7sm391665pfh.128.2023.05.29.15.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 15:39:36 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q3lWW-005U2h-25;
        Tue, 30 May 2023 08:39:32 +1000
Date:   Tue, 30 May 2023 08:39:32 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: Splitting dirty fs folios
Message-ID: <ZHUppPtjIjXVsacC@dread.disaster.area>
References: <ZHUEH849ff09pVpf@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHUEH849ff09pVpf@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 29, 2023 at 08:59:27PM +0100, Matthew Wilcox wrote:
> At the moment, when we truncate (also holepunch, etc) a file,
> the VFS attempts to split any large folios which overlap the newly
> created boundary in the file.  See mm/truncate.c for the callers of
> ->invalidate_folio.
> 
> We need the filesystem and the MM to cooperate on splitting a folio
> because there's FS metadata attached to folio->private.  We have per-folio
> state (uptodate, dirty) which the filesystem keeps per-block state for
> and uses the folio state as a summary (if every block is uptodate,
> the folio is uptodate.  if any block is dirty, the folio is dirty).
> If we just throw away that per-folio extra state we risk not writing
> back blocks which are dirty, or losing buffered writes as we re-read
> blocks which were more uptodate in memory than on disk.  There's no
> safe state to set the folio to.
> 
> This is fine if the entire folio is uptodate, and it generally is today
> because large folios are only created through readahead, which will
> bring the entire folio uptodate unless there is a read error.  But when
> creating a large folio in the write path, we can end up with large folios
> which are not uptodate under various circumstances.  For example, I've
> captured one where we write to pos:0x2a0e5f len:0xf1a1.  Because this is
> on a 1kB block size filesystem, we leave the first three blocks in the folio
> unread, and the uptodate bits are fffffffffffffff8.  That means that
> the folio as a whole is not uptodate.
> 
> Option 1: Read the start of the folio so we can set the whole folio
> uptodate.  In this case, we're already submitting a read for bytes
> 0x2a0c00-0x2a0fff (so we can overwrite the end of that block).  We could
> expand that to read 0x2a0000-0x2a0fff instead.  This could get tricky;
> at the moment we're guaranteed to have the iomap that covers the start
> of the block, but we might have to do a lookup to find the iomap(s)
> that covers the start of the folio.

Yeah, that seems like a problem - having to go back and get a
different iomap for read while we currently hold an iomap for write
is a potential deadlock for some filesystems. I think at this point,
we would be better off backing out of the write, getting a write
mapping for the entire large folio range and running the existing
"sub folio" zero-or-RMW code...

> Option 2: In the invalidate_folio implementation, writeback the folio
> so it is no longer dirty.  I'm not sure we have all the information we
> need to start writeback, and it'll annoy the filesystem as it has to
> allocate space if it wasn't already allocated.

I don't really like this - we want to throw away dirty data in range
being invalidated, not take a latency/performance hit to write it
back first.

FWIW, is the folio is dirty and the filesystem doesn't have
allocated space for it to be written back, then that is a bug that
needs fixing. Nothing should be dirtying a folio without giving the
filesystem the opportunity to allocate backing space for it
first....

> Option 3: Figure out a more complicated dance between the FS and the MM
> that allows the FS to attach state to the newly created folios before
> finally freeing the original folio.

Complex, but seems possible. Also seems tricky with respect to
making the entire swap appear atomic from an outside observer's
perspective. 

> Option 4: Stop splitting folios on holepunch / truncate.  Folio splits
> can fail, so we all have to cope with folios that substantially overhang
> a hole/data/EOF boundary.  We don't attempt to split folios on readahead
> when we discover we're trying to read from a hole, we just zero the
> appropriate chuks of the folio. 

That sounds like the best idea to me - it matches what we already in
terms of sub-page block size behaviour - zero the part of the page
that was invalidated.

> We do attempt to not allocate folios
> which extend more than one page past EOF, but that's subject to change
> anyway.

Yeah, i think we'll want to change that because if extending
sequential writes don't exactly match large folio alignment we'll
still end up with lots of small folios around the edges of the user
writes....

> Option 5: If the folio is both dirty and !uptodate, just refuse to split
> it, like if somebody else had a reference on it.  A less extreme version
> of #4.

Also seems like a reasonable first step.

> I may have missed some other option.  Option 5 seems like the least
> amount of work.

*nod*

Overall, I think the best way to approach it is to do the simplest,
most obviously correct thing first. If/when we observe performance
problems from the simple approach, then we can decide how to solve
that via one of the more complex approaches...

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
