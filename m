Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF3352D166
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 13:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbiESLZJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 07:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237392AbiESLZH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 07:25:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59FD1A5AA6
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 04:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652959504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7vdcYJPfw3K20SGqsUJxe2PIWkf1u9aw8heNjncBU0s=;
        b=dUEhrUd6G+EoVVjIQwmre9njzCJhFqkU6qzSc7k9EO+2z+gMrFyQYFB73WhsyORmhOh1G4
        glWmiscztvv84CkJAdKWEUglh6445IhBq6eqPgEpCRxycWHix8iT+ybBzbbgOGjqpY3NDP
        Ny7eNd0JTlwn0jDrYNeAn2VVeXqSUxQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-kXXIiY8BNgSbhAz3wVPKGw-1; Thu, 19 May 2022 07:25:01 -0400
X-MC-Unique: kXXIiY8BNgSbhAz3wVPKGw-1
Received: by mail-qk1-f197.google.com with SMTP id j12-20020ae9c20c000000b0069e8ac6b244so3906295qkg.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 04:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7vdcYJPfw3K20SGqsUJxe2PIWkf1u9aw8heNjncBU0s=;
        b=lOyXKOKQuQMKMbemyhBFp9kTlH2WZsg1gCyN+MCE+RBD5F/IHFs3ekc9Ih0BgaPJqT
         awX9+/Xemx2eq3XWZezYEeIAn/5R+EFp4T2kHu4029mG3SB9eSBfU135wr9dkptto+Jv
         m9e5Y1zbmgrC7db7gER+rDv+wxQ3miGH1OTwvUngESieG6eqpSfl4NDryps8X5a0g/tU
         Uvt9DDxPUPawro8QsTt3PYwUpawzobuEum1tETnEQ/nY488H6yDNg1hU1qjQN9HgQB1g
         1pcMxAu0nagKgfAT2ZnLS6PhCsB/ewTJChA1AiM93GU3ZvkwrIs5sxR8ERlE4oeQ0GpU
         fzoQ==
X-Gm-Message-State: AOAM531XBHGx7vRVUBz9acOL4rKpKVCgbQ/2v9nDV8kD9D3fJkYsRPIv
        9iOp8DPFn5L39pfA/AyQ9t1emVNKZxBP6bYlQu+qTPTCjvD+iiCB6wGZqV5PcdQYRq3jWgRVn6R
        VqF6j81ys3IXicehbzPZBVmZlXw==
X-Received: by 2002:a05:6214:21ee:b0:461:e557:6051 with SMTP id p14-20020a05621421ee00b00461e5576051mr3192101qvj.25.1652959500836;
        Thu, 19 May 2022 04:25:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzVLRXKQV7vapB74AbsI6Pv2aIVCodGu8MZhS0bY7xw2bb4xa+6a46uJRM71FEqv/6H91NNA==
X-Received: by 2002:a05:6214:21ee:b0:461:e557:6051 with SMTP id p14-20020a05621421ee00b00461e5576051mr3192088qvj.25.1652959500596;
        Thu, 19 May 2022 04:25:00 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p66-20020a37bf45000000b0069fcdbabdb4sm1084980qkf.69.2022.05.19.04.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 04:24:59 -0700 (PDT)
Date:   Thu, 19 May 2022 19:24:50 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, pankydev8@gmail.com,
        Theodore Tso <tytso@mit.edu>,
        Josef Bacik <josef@toxicpanda.com>, jmeneghi@redhat.com,
        Jan Kara <jack@suse.cz>, Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jake Edge <jake@lwn.net>, Klaus Jensen <its@irrelevant.dk>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [RFC: kdevops] Standardizing on failure rate nomenclature for
 expunges
Message-ID: <20220519112450.zbje64mrh65pifnz@zlang-mailbox>
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org>
 <CAOQ4uxhKHMjGq0QKKMPFAV6iJFwe1H5hBomCVVeT1EWJzo0eXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhKHMjGq0QKKMPFAV6iJFwe1H5hBomCVVeT1EWJzo0eXg@mail.gmail.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 09:36:41AM +0300, Amir Goldstein wrote:
> [adding fstests and Zorro]
> 
> On Thu, May 19, 2022 at 6:07 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > I've been promoting the idea that running fstests once is nice,
> > but things get interesting if you try to run fstests multiple
> > times until a failure is found. It turns out at least kdevops has
> > found tests which fail with a failure rate of typically 1/2 to
> > 1/30 average failure rate. That is 1/2 means a failure can happen
> > 50% of the time, whereas 1/30 means it takes 30 runs to find the
> > failure.
> >
> > I have tried my best to annotate failure rates when I know what
> > they might be on the test expunge list, as an example:
> >
> > workflows/fstests/expunges/5.17.0-rc7/xfs/unassigned/xfs_reflink.txt:generic/530 # failure rate about 1/15 https://gist.github.com/mcgrof/4129074db592c170e6bf748aa11d783d
> >
> > The term "failure rate 1/15" is 16 characters long, so I'd like
> > to propose to standardize a way to represent this. How about
> >
> > generic/530 # F:1/15
> >
> 
> I am not fond of the 1/15 annotation at all, because the only fact that you
> are able to document is that the test failed after 15 runs.
> Suggesting that this means failure rate of 1/15 is a very big step.
> 
> > Then we could extend the definition. F being current estimate, and this
> > can be just how long it took to find the first failure. A more valuable
> > figure would be failure rate avarage, so running the test multiple
> > times, say 10, to see what the failure rate is and then averaging the
> > failure out. So this could be a more accurate representation. For this
> > how about:
> >
> > generic/530 # FA:1/15
> >
> > This would mean on average there failure rate has been found to be about
> > 1/15, and this was determined based on 10 runs.
> >
> > We should also go extend check for fstests/blktests to run a test
> > until a failure is found and report back the number of successes.
> >
> > Thoughts?
> >
> 
> I have had a discussion about those tests with Zorro.

Hi Amir,

Thanks for publicing this discussion.

Yes, we talked about this, but if I don't rememeber wrong, I recommended each
downstream testers maintain their own "testing data/config", likes exclude
list, failed ratio, known failures etc. I think they're not suitable to be
fixed in the mainline fstests.

About the other idea I metioned in LSF, we can create some more group names to
mark those cases with random load/data/env etc, they're worth to be run more
times. I also talked about that with Darrick, we haven't maken a decision,
but I'd like to push that if most of other forks would like to see that.

In my internal regression test for RHEL, I give some fstests cases a new
group name "redhat_random" (sure, I know it's not a good name, it's just
for my internal test, welcome better name, I'm not a good english speaker :).
Then combine with quick and stress group name, I loop run "redhat_random"
cases different times, with different LOAD/TIME_FACTOR.

So I hope to have one "or more specific" group name to mark those random
test cases at first, likes [1] (I'm sure it's incomplete, but can be improved
if we can get more help from more people :)

Thanks,
Zorro

[1]
generic/013
generic/019
generic/051
generic/068
generic/070
generic/075
generic/076
generic/083
generic/091
generic/112
generic/117
generic/127
generic/231
generic/232
generic/233
generic/263
generic/269
generic/270
generic/388
generic/390
generic/413
generic/455
generic/457
generic/461
generic/464
generic/475
generic/476
generic/482
generic/521
generic/522
generic/547
generic/551
generic/560
generic/561
generic/616
generic/617
generic/648
generic/650
xfs/011
xfs/013
xfs/017
xfs/032
xfs/051
xfs/057
xfs/068
xfs/079
xfs/104
xfs/137
xfs/141
xfs/167
xfs/297
xfs/305
xfs/442
xfs/517

> 
> Those tests that some people refer to as "flaky" are valuable,
> but they are not deterministic, they are stochastic.
> 
> I think MTBF is the standard way to describe reliability
> of such tests, but I am having a hard time imagining how
> the community can manage to document accurate annotations
> of this sort, so I would stick with documenting the facts
> (i.e. the test fails after N runs).
> 
> OTOH, we do have deterministic tests, maybe even the majority of
> fstests are deterministic(?)
> 
> Considering that every auto test loop takes ~2 hours on our rig and that
> I have been running over 100 loops over the past two weeks, if half
> of fstests are deterministic, that is a lot of wait time and a lot of carbon
> emission gone to waste.
> 
> It would have been nice if I was able to exclude a "deterministic" group.
> The problem is - can a developer ever tag a test as being "deterministic"?
> 
> Thanks,
> Amir.
> 

