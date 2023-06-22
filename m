Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76404739683
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 06:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjFVEsL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 00:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjFVEsF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 00:48:05 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F66F1BD0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 21:48:04 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-7651c01c753so47412485a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 21:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687409283; x=1690001283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6UCsy+QyUCZWP4W4J9LZYEzDKcZk8p92T6bjDRjYR2w=;
        b=oHfwniBLfU5HGulzijE8rCOrITTPgYSHgaooGQjjBWcKJFnuX4h7FKKdx3euoGAiag
         CNXrIlIW6VqzXj5t4QwmXirYnnI8yjgA0tWab8D5CWa7JGh5T2YLjLyE62Wb3r1XSep/
         UkB5SOoL7QfpVuMjXErHR5GzS/3vV6jgOe7ATt5W50N37sMlHXXBiECxpmIFyEgrlkaA
         eqkYtwh+PaO9xjpExzf7QOIrgyko8Ae6+vexQzTCtwB27FAlIP/D5s/RY27bakRdkIGc
         H3bcV9rwCVJj6leoNif7r0OG+mrGE0daQXPoveDc3nZ8dve0t4D9vge6I+ABbIj0BqkK
         7vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687409283; x=1690001283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UCsy+QyUCZWP4W4J9LZYEzDKcZk8p92T6bjDRjYR2w=;
        b=LY9RrquVfdVzX66UlLsQENMhLrIrLOF4S226F849vCFhJN+2WC5bAdQeJCfg2LHVRn
         b6i7Xze55yo0sQaBmgdKIE/TH6HKrvILpmkI2RWEG6JrUeqFwM7zdRucKjKsP1TOZhTR
         b+iUUmXQbiqLxl6n3+RQ1/ontgJMCqQ19+JH6gy+K701PHN0X37mgoRba7QmnmShgsoo
         mXcvghA3M52YYM+6KicFd3YuiGVbegh8Jo2OW/8lfXGqcX2VUXErhBJl3ZZwWIYjbQTP
         mxjBAQuH49ZOzg/pIXE0Y/dqbksXCF7JdjuNISCsQiAscDpKJlybqN1IEt2I1Y4bFYmi
         X2/A==
X-Gm-Message-State: AC+VfDyh/H6AMefsx3VHJCxxuIIPPo+alof5bwHaipszUND611OlgcFW
        al9ceO+VWBFOq6Gpk7OZeWY6GqznY25Zl3qqPMI=
X-Google-Smtp-Source: ACHHUZ72A1f9sdf2FYb00UtlkIKrC2QPw8XEMRY/JilXxNxyniq4rSm97aY9T6jpPwLgh+IxJerivQ==
X-Received: by 2002:a05:6214:27e3:b0:62b:4590:78e8 with SMTP id jt3-20020a05621427e300b0062b459078e8mr21102017qvb.34.1687409283200;
        Wed, 21 Jun 2023 21:48:03 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79251000000b0063b6cccd5dfsm3649765pfp.195.2023.06.21.21.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 21:48:02 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qCCEh-00EiVj-2w;
        Thu, 22 Jun 2023 14:47:59 +1000
Date:   Thu, 22 Jun 2023 14:47:59 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jeremy Bongio <bongiojp@gmail.com>, Ted Tso <tytso@mit.edu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Allison Henderson <allison.henderson@oracle.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/1] iomap regression for aio dio 4k writes
Message-ID: <ZJPSf0nEYoH9Oq14@dread.disaster.area>
References: <20230621174114.1320834-1-bongiojp@gmail.com>
 <ZJOO4SobNFaQ+C5g@dread.disaster.area>
 <ZJOqC7Cfjr5AoW7S@dread.disaster.area>
 <ZJO4OAYhJlXOBXMf@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJO4OAYhJlXOBXMf@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 22, 2023 at 03:55:52AM +0100, Matthew Wilcox wrote:
> On Thu, Jun 22, 2023 at 11:55:23AM +1000, Dave Chinner wrote:
> > Ok, so having spent a bit more thought on this away from the office
> > this morning, I think there is a generic way we can avoid deferring
> > completions for pure overwrites.
> 
> OK, this is how we can, but should we?  The same amount of work
> needs to be done, no matter whether we do it in interrupt context or
> workqueue context.  Doing it in interrupt context has lower latency,
> but maybe allows us to batch up the work and so get better bandwidth.
> And we can't handle other interrupts while we're handling this one,
> so from a whole-system perspective, I think we'd rather do the work in
> the workqueue.

Yup, I agree with you there, but I can also be easily convinced that
optimising the pure in-place DIO overwrite path is worth the effort.

> Latency is important for reads, but why is it important for writes?
> There's such a thing as a dependent read, but writes are usually buffered
> and we can wait as long as we like for a write to complete.

The OP cares about async direct IO performance, not buffered writes.
And for DIO writes, there is most definitely such a thing as
"dependent writes".

Think about journalled data - you can't overwrite data in place
until the data write to the journal has first completed all the way
down to stable storage.  i.e. there's an inherent IO
completion-to-submission write ordering constraint in the algorithm,
and so we have dependent writes.

And that's the whole point of the DIO write FUA optimisations in
iomap; they avoid the dependent "write" that provides data integrity
i.e.  the journal flush and/or device cache flush that
generic_write_sync() issues in IO completion is a dependent write
because it cannot start until all the data being written has reached
the device entirely.

Using completion-to-submission ordering of the integrity operations
means we don't need to block other IOs to the same file, other
journal operations in the filesystem or other data IO to provide
that data integrity requirement for the specific O_DSYNC DIO write
IO. If we can use an FUA write for this instead of a separate cache
flush, then we end up providing O_DSYNC writes with about 40% lower
completion latency than a "write + cache flush" sequential IO pair.

This means that things like high performance databases improve
throughput by 25-50% and operational latency goes down by ~30-40% if
we can make extensive use of FUA writes to provide the desired data
integrity guarantees.

From that perspective, an application doing pure overwrites with
ordering depedencies might actually be very dependent on minimising
individual DIO write latency for overall performance...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
