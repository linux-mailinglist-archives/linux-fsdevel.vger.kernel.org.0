Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A8D6918E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 07:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjBJG6O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Feb 2023 01:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjBJG6N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Feb 2023 01:58:13 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08ACE5AB30
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Feb 2023 22:57:51 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id a8-20020a17090a6d8800b002336b48f653so2796710pjk.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Feb 2023 22:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1U8Y/0tbcD9B+rFGh6iJhmikTGHljyJ4FQw+gensxqM=;
        b=4Z1SYdNbd8WuXmbNbPTp5CPsq+GgaHbcr8G8z8Vf2uXbpsOUdr/18311fSoj/DAvdM
         vKD8kJ4v+dlInCvARG32DgUVW8yzfAhNkAyg4PrXHQ8xbnM6qm00vXAjizV3lv9K0Sf/
         yhmZ9myipWzdAp3N3yBHfaKYQ0cJ0ZZ9R3JLCAc8crow8cakcI10UvY9qknPlyW1qW2Z
         DMKFP+tHUhN2tmNEIcIcgczDV7s8cjMmG51ixCnGXX2nvFqjCTjT9YADasror/vi7CU8
         10fPbGPPQUto5nhsZhX9kHLpIDYok04ij/5sDWe8+1g8aQUBeNpw+SaOrYegc5uSMILw
         cGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1U8Y/0tbcD9B+rFGh6iJhmikTGHljyJ4FQw+gensxqM=;
        b=cRJqoKe2XGzjYtX0Lq7dOK6QHqzTgVknxO5NRmEsW6Zbx0fXHLIGgas2JXJ81iT8wT
         W3zv8xh+S3CHV2MwXk7+fWmPnTddYaHNoT18SYTBLrZCV5JAQnZBz6PD/qOzpp42W88I
         0LyNArYmXfqTQNKCSqeJ+R7eAwBMzEapcLR+hwDPFacsdwWqx01LmkGFEFVmlB1bYFO5
         2MuNujGuLghHbEPZOLaE/OxN7+VJgJiIRYL9FcI8VYg0K4/o1WWJigwIYpPsfzsirrLW
         arSGhiYploT5KmKNm2FlUUvkQD9wXgpVUKb73UkeBDyIZTIqogeEh5serxluwOOgjzZ1
         Wkhg==
X-Gm-Message-State: AO0yUKUiWQbQGqALk1hotABRpJRmXnXAlxekx5qCa+BzXW4Cy402eu5o
        T9VJJwmxXpOzpYnycNM00bkb0A==
X-Google-Smtp-Source: AK7set9t6gqJxoHDZIn5ha1EJDlZJueE1TdlQVqKbhBYcp7XjUdmkxQUWlM78CqsSipLc15u/SU+4w==
X-Received: by 2002:a05:6a21:3613:b0:bc:30aa:8a6d with SMTP id yg19-20020a056a21361300b000bc30aa8a6dmr11239502pzb.2.1676012270527;
        Thu, 09 Feb 2023 22:57:50 -0800 (PST)
Received: from dread.disaster.area (pa49-181-4-128.pa.nsw.optusnet.com.au. [49.181.4.128])
        by smtp.gmail.com with ESMTPSA id i76-20020a636d4f000000b004fb171df68fsm2298927pgc.7.2023.02.09.22.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 22:57:50 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pQNLv-00DXUC-AP; Fri, 10 Feb 2023 17:57:47 +1100
Date:   Fri, 10 Feb 2023 17:57:47 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stefan Metzmacher <metze@samba.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API Mailing List <linux-api@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Samba Technical <samba-technical@lists.samba.org>
Subject: Re: copy on write for splice() from file to pipe?
Message-ID: <20230210065747.GD2825702@dread.disaster.area>
References: <0cfd9f02-dea7-90e2-e932-c8129b6013c7@samba.org>
 <CAHk-=wj8rthcQ9gQbvkMzeFt0iymq+CuOzmidx3Pm29Lg+W0gg@mail.gmail.com>
 <20230210021603.GA2825702@dread.disaster.area>
 <20230210040626.GB2825702@dread.disaster.area>
 <Y+XLuYh+kC+4wTRi@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+XLuYh+kC+4wTRi@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 10, 2023 at 04:44:41AM +0000, Matthew Wilcox wrote:
> On Fri, Feb 10, 2023 at 03:06:26PM +1100, Dave Chinner wrote:
> > So while I was pondering the complexity of this and watching a great
> > big shiny rocket create lots of heat, light and noise, it occurred
> 
> That was kind of fun

:)

> > to me that we already have a mechanism for preventing page cache
> > data from being changed while the folios are under IO:
> > SB_I_STABLE_WRITES and folio_wait_stable().
> 
> I thought about bringing that up, but it's not quite right.  That works
> great for writeback, but it only works for writeback.  We'd need to track
> another per-folio counter ... it'd be like the page pinning kerfuffle,
> only worse. 

Hmmm - I didn't think of that. It needs the counter because the
"stable request" is per folio reference state, not per folio state,
right? And the single flag works for writeback because we can only
have one writeback context in progress at a time?

Yeah, not sure how to deal with that easily.

> And for such a rare thing it seems like a poor use of 32
> bits of per-page state.

Maybe, but zero copy file data -> network send is a pretty common
workload. Web servers, file servers, remote backup programs, etc.
Having files being written whilst others are reading them is not as
common, but that does happen in a wide variety of shared file server
environments.

Regardless, I just had a couple of ideas - it they don't work so be
it.

> Not to mention that you can effectively block
> all writes to a file for an indefinite time by splicing pages to a pipe
> that you then never read from.

No, I wasn't suggesting that we make pages in transit stable - they
only need to be stable while the network stack requires them to be
stable....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
