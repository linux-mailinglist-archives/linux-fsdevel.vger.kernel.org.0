Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACD350C08E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 21:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiDVTyZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 15:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiDVTyY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 15:54:24 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EBA2D8846;
        Fri, 22 Apr 2022 12:35:10 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id y129so6531867qkb.2;
        Fri, 22 Apr 2022 12:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uaw3jQI0O7lfuasFDAU1iMGalKK6DqU9oePbaLb6Lpo=;
        b=jSBuMPPxD+TRF+uvoRePfqLx62akhHX4yKi60akXL8zvbnY79lrrPOv9UdoTTN6G03
         Z3Z6xJWsC44e2+sH601gYFYQRahbzOlLTXCLTR7DpvXVU7hdwors1gULh5GCqc6Ai1Xp
         xH2iybM481G86VuD9jW/RRoA7ua81x00JPulz+mRHkD1xdubsNPwLiT4kmVqxX7Rwm0+
         bWXe1pdPRZ/WrNqxSXBKagepCTNXYFpKudiprDzf06IGDaereV2WJ1I+PhmjNJcvMCER
         qqEMvrIVug0YQphPqXtbOOyBwQi0iB/t+Dyq8nT6ygBsRs4PscXLhPGC/9Je3uLiCX0R
         juyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uaw3jQI0O7lfuasFDAU1iMGalKK6DqU9oePbaLb6Lpo=;
        b=2X8WOImVhKdMo0TGPNY3KZo0A+tqRfF2CF80XBSU+QaGtTd50MKKin3wJ5bb0R1pmg
         sX21ewhszMCtim9Pa/ZGO0sJNAr2YbxUmT+WWaAszsScwZv9mrgninPMmSUskjo8FMAH
         eJrtXv8Oy9mQz73k1AMPDOl0We0By9k7hLuBL1KyzwZ1/CHc9QlyPsXe/Z1x3ZWPLUFb
         dg+6Ft7YDJEQcixLjTsAWi3VfnxtDadzHlLsgIEt4CGE4o+3SkBmqKxL6+wXhnITGRks
         1ne9NNDZFOXTBeLq8y6rovBpCNJQBqiFwxvCufOLDebLSBWgCQV0Yeq0QGJ9xgIg1ufs
         8W2A==
X-Gm-Message-State: AOAM530cs6eX1vqWvq+Z+CD7jARDTcbQsidB6tcDvT49L3e+yGXSkVg5
        bdenq8RSTO9zn1dUBJyiqzABVP0BKdEi
X-Google-Smtp-Source: ABdhPJwRNFuGFN5zUpqH2tATD7eZCTHBc5A5LvoxXTRq8ugddn1nAMCTX2JWMw8ITL691waO11UeTQ==
X-Received: by 2002:a37:6902:0:b0:606:853:fe50 with SMTP id e2-20020a376902000000b006060853fe50mr3597093qkc.751.1650655818042;
        Fri, 22 Apr 2022 12:30:18 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id bl14-20020a05620a1a8e00b0069e622e593esm1219789qkb.95.2022.04.22.12.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 12:30:17 -0700 (PDT)
Date:   Fri, 22 Apr 2022 15:30:15 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, roman.gushchin@linux.dev
Subject: Re: [PATCH v2 1/8] lib/printbuf: New data structure for
 heap-allocated strings
Message-ID: <20220422193015.2rs2wvqwdlczreh3@moria.home.lan>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
 <20220421234837.3629927-7-kent.overstreet@gmail.com>
 <20220422042017.GA9946@lst.de>
 <YmI5yA1LrYrTg8pB@moria.home.lan>
 <20220422052208.GA10745@lst.de>
 <YmI/v35IvxhOZpXJ@moria.home.lan>
 <20220422113736.460058cc@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422113736.460058cc@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Steve!

On Fri, Apr 22, 2022 at 11:37:36AM -0400, Steven Rostedt wrote:
> On Fri, 22 Apr 2022 01:40:15 -0400
> Kent Overstreet <kent.overstreet@gmail.com> wrote:
> 
> > So I'm honestly not super eager to start modifying tricky arch code that I can't
> > test, and digging into what looked like non trivial interactions between the way
> > the traceing code using seq_buf (naturally, given that's where it originates).
> 
> Yes, seq_buf came from the tracing system but was to be used in a more
> broader way. I had originally pushed trace_seq into the lib directory, but
> Andrew Morton said it was too specific to tracing. Thus, I gutted the
> generic parts out of it and created seq_buf, which looks to be something
> that you could use. I had patches to convert seq_file to it, but ran out of
> time. I probably can pull them out of the closet and start that again.
> 
> > 
> > Now yes, I _could_ do a wholesale conversion of seq_buf to printbuf and delete
> > that code, but doing that job right, to be confident that I'm not introducing
> > bugs, is going to take more time than I really want to invest right now. I
> > really don't like to play fast and loose with that stuff.
> 
> I would be happy to work with you to convert to seq_buf. If there's
> something missing from it, I can help you change it so that it doesn't
> cause any regressions with the tracing subsystem.
> 
> This is how open source programming is suppose to work ;-)

Is it though? :)

One of the things I've been meaning to talk more about, that
came out of a recent Rust discussion, is that we in the kernel community could
really do a better job with how we interact with the outside world, particularly
with regards to the sharing of code.

The point was made to me when another long standing kernel dev was complaining
about Facebook being a large, insular, difficult to work with organization, that
likes to pretend it is the center of the universe and not bend to the outside
world, while doing the exact same thing with respect to new concerns brought by
the Rust community. The irony was illuminating :)

The reason I bring that up is that in this case, printbuf is the more evolved,
more widely used implementation, and you're asking me to discard it so the
kernel can stick with its more primitive, less widely used implementation.

$ git grep -w seq_buf|wc -l
86

$ git grep -w printbuf|wc -l
366

So, going to have to push back on that one :)

Printbufs aren't new code; everything in them is there because I've found it
valuable, which is why I decided to try promoting them to the kernel proper (and
more importantly, the idea of a standard way to pretty-print anything).

I'm happy to discuss the merits of the code more, and try to convince you why
you'll like them :)
