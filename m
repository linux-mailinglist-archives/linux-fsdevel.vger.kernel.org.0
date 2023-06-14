Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887EE72F0F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 02:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241422AbjFNA0l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 20:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjFNA0j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 20:26:39 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5548C199C
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 17:26:35 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-53fbb3a013dso4433785a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 17:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686702395; x=1689294395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QajGQslzzctkaDr1mgFDGYFv/dJbKUMY50GQqUSjsyU=;
        b=0d+yVoOF9RLKOLDioGzBjk4of6B/ELGbtZeDRidEhiXoi0k01UmVts9bYGLhAALO11
         It/k6o+eieUvWaAbmWudWu3sHqqmpOhO1Q+JynFDmO0DqYdLhqpz7Gjob/hQYJ2oCQz3
         mJBo8I0G0/tBIeh5LGCMUD5mSNhe9K8wN/5UJxnFNvPQIIWx9cVOEOVwjJOU2RndF7ph
         5unDMdpwvVwxNrvF/bhWMhJ5Q5upTHf3Z0wHOTSVJjgKcAYk01g4d/8eJVEn3Du6EUMZ
         4vxDFkPBFJGpTuNvzqeRGJPloNc4FJ9LsKY4saelLj/IHKq09gcAAeE+wWvGFfObQrg6
         Ra/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686702395; x=1689294395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QajGQslzzctkaDr1mgFDGYFv/dJbKUMY50GQqUSjsyU=;
        b=g4Zcr56pJ45rpGeTF+b/1gQEYuc4uB9MZUNmkf04FLuRaxJm3aMHhknhN7uzuYVEZy
         P5NDdiq8KNwEXP5POCZnOZFF4JMXyc5HR5kefyU4K/AmADIh1DjPzoeEeMVWTlzzN0N8
         XK9wJgcwkTtUB5YciiBrls6CC4EayEVN2oc4WGZ2x3Dvkd7uldD9X9zn/6c9jxfYhpWp
         biUW6YdDLn/L5odrllIU3YwhUiU3Q/tkNwOl5gdhctUI5xQzQSB6lNMHlR0oERs75opt
         TC/vreA43crEU5bGc7PTXCFQFvVWekar68zwEiRIdQxZ2xy+3TzLbRD+SBXqrVQG2ci6
         619Q==
X-Gm-Message-State: AC+VfDyGraJBaGP/YiZvHR1x5Wyl1+0JrVFNa9HNy5klW3nsnf0s6wD/
        y16eefxglqRggsLAITwawnFfcg==
X-Google-Smtp-Source: ACHHUZ7hUVmtofcr2phlzKmyh0/J/vmdnLeHcAWruzJ4Rla8wEpdmbXk7zXylq6Vb0/lk/S1qmcCpg==
X-Received: by 2002:a05:6a20:a108:b0:101:73a9:1683 with SMTP id q8-20020a056a20a10800b0010173a91683mr335461pzk.33.1686702394620;
        Tue, 13 Jun 2023 17:26:34 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id x2-20020a056a00270200b005d22639b577sm971152pfv.165.2023.06.13.17.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 17:26:33 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q9ELG-00BTYW-2T;
        Wed, 14 Jun 2023 10:26:30 +1000
Date:   Wed, 14 Jun 2023 10:26:30 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ted Tso <tytso@mit.edu>, yebin <yebin@huaweicloud.com>,
        linux-fsdevel@vger.kernel.org, Kees Cook <keescook@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted
 devices
Message-ID: <ZIkJNmpO/S7pv0A6@dread.disaster.area>
References: <20230612161614.10302-1-jack@suse.cz>
 <CACT4Y+aEScXmq2F1-vqAfr-b2w-xyOohN+FZxorW1YuRvKDLNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aEScXmq2F1-vqAfr-b2w-xyOohN+FZxorW1YuRvKDLNQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 13, 2023 at 08:49:38AM +0200, Dmitry Vyukov wrote:
> On Mon, 12 Jun 2023 at 18:16, Jan Kara <jack@suse.cz> wrote:
> >
> > Writing to mounted devices is dangerous and can lead to filesystem
> > corruption as well as crashes. Furthermore syzbot comes with more and
> > more involved examples how to corrupt block device under a mounted
> > filesystem leading to kernel crashes and reports we can do nothing
> > about. Add config option to disallow writing to mounted (exclusively
> > open) block devices. Syzbot can use this option to avoid uninteresting
> > crashes. Also users whose userspace setup does not need writing to
> > mounted block devices can set this config option for hardening.
> 
> +syzkaller, Kees, Alexander, Eric
> 
> We can enable this on syzbot, however I have the same concerns as with
> disabling of XFS_SUPPORT_V4:
> https://github.com/google/syzkaller/issues/3918#issuecomment-1560624278

Really?

This is exactly what I *detest most* about syzbot: the recalcitrant
maintainer who thinks their ideology is more important than any
other engineering consideration that might exist.

We want *better quality bug reports* on *current code* that we have
to *support for the foreseeable future*, not get buried under
repeated shitty reports containing yet more variants of problems we
fixed over a decade ago.

I'll repeat what Eric has already pointed out in the above GH issue
in the vain hope you'll listen this time rather than making even more
extreme ideological demands on us.

The XFS engineers put in place a planned, well documented
deprecation and removal process for V4 format support back in 2020.
We are well into that plan - we are not that far from turning it off
v4 support by default. The V4 format is legacy code and users are
already migrating away from it.

As such, it has much lower priority and relevance to us compared to
supporting v5 filesystems. The syzbot maintainers don't get to
decide how important XFS v4 format support is - that's the job of
the XFS engineers responsibile for developing XFS code and
supporting XFS users.

Because V4 has been deprecated and support is slowing down as people
migrate off it, we don't need as extensive test coverage as we once
did. i.e.  we are ramping down the validation in accordance with
it's lower priority and approaching disabling in 2025. We are
placing much more importance on validation of v5 format features and
functionality.

As such, we really don't need syzbot to be exercising v4 formats any
more - it's much more important to our users that we exercise v5
formats as extensively as possible. That is what we are asking the
syzkaller runners (and syzbot) do as a service for us.

If your ideology demands that "the only way to stop syzbot testing
XFS v4 filesytsems is to remove the code entirely" (paraphrasing
your comments from the above github issue), then the entire problem
here is your ideology.

That is, your ideology is getting in the way of practical, well
thought out, long running end-of-life engineering processes. It is
creating unnecessary load on limited resources. Further, your
demands that we place syzbot coverage (if syzbot doesn't test it, it
must depend on CONFIG_INSECURE!) above our direct responsibilities
to distro maintainers and other downstream users is, at best,
terribly misguided.

Syzbot is a *tool*. It's not even a critical tool we depend on - we
can live without it just fine. We'd really like syzbot to be a
better tool, but the ideology behind syzbot is the biggest
impediment to making it a better, more effective tool for the
community.

If syzbot maintainers won't listen to simple requests to improve
test coverage according to subsystem requirements, then it's clear
that syzbot is being driven by ideology rather than engineering
requirements. This needs to change.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
