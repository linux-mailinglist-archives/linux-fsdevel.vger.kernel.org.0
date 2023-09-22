Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAC57AA80E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 07:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjIVFDl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 01:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjIVFDk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 01:03:40 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B237192
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 22:03:29 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c4194f769fso14418865ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 22:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1695359009; x=1695963809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eKfvtCzoPO1DjRH7hqL/PCP8n2qTK2huPA+M1ou1kWk=;
        b=FwGewhCC5HKma6r5rqI6P2X3O27I5AexLq1aWMQ5AVZLvIRv0bUVveR7vzOpzOzng2
         xAB5PM8RBCwMhKBVevp7QEdWj8S1cEy12lZJ4E6X5g1xcbQDt/HOEJg7qumcZUzC4WQc
         6mn8PemkY+2B5mRpE2mzkpn88OwNkzVR75s+NAaK3dp/NDpB2KtLnuoFl93Y5VNevlIc
         LDlWRmM+udJv7MvAXVk/J4/1VzAjSKCIayNrIn17yzWTOxU8LIyqT/YgaHzR+CRhScPh
         29CgLo/nACgxpSFk1RFzuXlErW6HoWrznzs7wVwkkB6pRpEE6G49sPHEOXJ7+hZzJ89q
         IXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695359009; x=1695963809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKfvtCzoPO1DjRH7hqL/PCP8n2qTK2huPA+M1ou1kWk=;
        b=T92kaBxJAXR846ExItvahPR5E5uhYCS7bsTifcym9hZ77trZNDes4moF5StlQYSdlP
         td5GhF37IaRHntNzqo12F3B6vqlos+dIUXXgW2LmxVHdtjCzRM22okzWiO4tiBXy926u
         IOJWp09VVfMe9wGcYM7KQS4qohQRxH7Nqv97E4m1X7U8RWoywM9Wvwvm9vKUWdsM4sWz
         HdMzdNr8TPkIfToGYLsenQdyRNCXhy7C/1H8Wt5RNV+ypDp7SxFH/Vhe5yQHPN8wGSYV
         f0+qdQz4fb7f7xUBcHNGY7+uWmvRvLr/mesASGk2la15EKlyu3v4tMTMxJdcbZkkaQy4
         vZ9A==
X-Gm-Message-State: AOJu0YyndXnOk+s/X5eNAPNRYEn2sQwryj+6nkkMPLQA98Czk8sGG+/5
        wjBDPi2GQTN1+Rh2IRpmpj8pgg==
X-Google-Smtp-Source: AGHT+IFeu1EA7GyGKW4frzHTSmVZS0RTtP2XJVF07Ex6N8rmUJE7dIUep7oHw3F8G6mpIGwAto30ww==
X-Received: by 2002:a17:903:2305:b0:1c2:36a:52a5 with SMTP id d5-20020a170903230500b001c2036a52a5mr7889794plh.57.1695359008731;
        Thu, 21 Sep 2023 22:03:28 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id jk13-20020a170903330d00b001bbd8cf6b57sm2466460plb.230.2023.09.21.22.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 22:03:28 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qjYK5-003xpJ-0X;
        Fri, 22 Sep 2023 15:03:25 +1000
Date:   Fri, 22 Sep 2023 15:03:25 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Pankaj Raghav <p.raghav@samsung.com>,
        Pankaj Raghav <kernel@pankajraghav.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        da.gomez@samsung.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        djwong@kernel.org, linux-mm@kvack.org, chandan.babu@oracle.com,
        gost.dev@samsung.com, riteshh@linux.ibm.com
Subject: Re: [RFC 00/23] Enable block size > page size in XFS
Message-ID: <ZQ0gHRvrbZUjO/rA@dread.disaster.area>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
 <ZQd4IPeVI+o6M38W@dread.disaster.area>
 <ZQewKIfRYcApEYXt@bombadil.infradead.org>
 <CGME20230918050749eucas1p13c219481b4b08c1d58e90ea70ff7b9c8@eucas1p1.samsung.com>
 <ZQfbHloBUpDh+zCg@dread.disaster.area>
 <806df723-78cf-c7eb-66a6-1442c02126b3@samsung.com>
 <ZQuxvAd2lxWppyqO@bombadil.infradead.org>
 <ZQvNVAfZMjE3hgmN@bombadil.infradead.org>
 <ZQvczBjY4vTLJFBp@dread.disaster.area>
 <ZQvuNaYIukAnlEDM@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQvuNaYIukAnlEDM@bombadil.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 21, 2023 at 12:18:13AM -0700, Luis Chamberlain wrote:
> On Thu, Sep 21, 2023 at 04:03:56PM +1000, Dave Chinner wrote:
> > On Wed, Sep 20, 2023 at 09:57:56PM -0700, Luis Chamberlain wrote:
> > > On Wed, Sep 20, 2023 at 08:00:12PM -0700, Luis Chamberlain wrote:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=large-block-linus
> > > > 
> > > > I haven't tested yet the second branch I pushed though but it applied without any changes
> > > > so it should be good (usual famous last words).
> > > 
> > > I have run some preliminary tests on that branch as well above using fsx
> > > with larger LBA formats running them all on the *same* system at the
> > > same time. Kernel is happy.
> 
> <-- snip -->
> 
> > So I just pulled this, built it and run generic/091 as the very
> > first test on this:
> > 
> > # ./run_check.sh --mkfs-opts "-m rmapbt=1 -b size=64k" --run-opts "-s xfs_64k generic/091"
> 
> The cover letter for this patch series acknowledged failures in fstests.

But this is a new update, which you said fixed various issues, and
you posted this in direct response to the bug report I gave you.

> For kdevops now, we borrow the same last linux-next baseline:
> 
> git grep "generic/091" workflows/fstests/expunges/6.6.0-rc2-large-block-linus-nobdev
> workflows/fstests/expunges/6.6.0-rc2-large-block-linus-nobdev/xfs/unassigned/xfs_reflink_1024.txt:generic/091 # possible regression
> workflows/fstests/expunges/6.6.0-rc2-large-block-linus-nobdev/xfs/unassigned/xfs_reflink_16k.txt:generic/091
> workflows/fstests/expunges/6.6.0-rc2-large-block-linus-nobdev/xfs/unassigned/xfs_reflink_32k.txt:generic/091
> workflows/fstests/expunges/6.6.0-rc2-large-block-linus-nobdev/xfs/unassigned/xfs_reflink_64k_4ks.txt:generic/091
> 
> So well, we already know this fails.

*cough*

-You- know it already fails.

And you are expecting people who try the code to somehow know
that you've explicitly ignored this fsx failure, especially after
all your words to tell us how much fsx testing it has passed?

And that's kinda my point - you're effusing about how much fsx
testing this has passed, yet it istill fails after just a handful of
ops in generic/091. The dissonance could break windows...

----

Fundamentally, when it comes to data integrity, it important to
exercise as much of the operational application space as quickly as
possible as it is that breadth of variation in operations that
flushes out more bugs and helps stabilises the code faster.

Why do you think we talk about the massive test matrix most
filesytsems have and how long it takes to iterate so much? It's
because iterating that complex test matrix is how we find all the
whacky, weird bugs in the code.

Concentrating on a single test configuration and running it over and
over again won't find bugs in code it doesn't exercise no matter how
long it is run for. Running such a setup in an automated environment
doesn't mean you get better code coverage, it just means you cover
the same narrow set of corner cases faster and more times. If it
works once, it should work a million times. Iterating it a billion
more times doesn't tell us anything additional, either.

Put simply: performing deep, homogenous testing on code that has known
data corruption bugs outside the narrow scope of the test case is
not telling us anything useful about the overall state of the code.
Indeed, turning off failing tests that are critical to validating the
correct operation of the code you are modifying is bad practice.

For code changes like this, all fsx testing in fstests should pass
before you post anything for review - even for an RFC. There is no
point reviewing code that doesn't work properly, nor wasting
people's time by encouraging them to test it when it's clear to you
that it's going to fail in various important ways.

Hence I think your testing is focussing on the wrong things and I
suspect that you've misunderstood the statements of "we'll need
billions of fsx ops to test this code" that various people have made
really meant.  You've elevated running billions of fsx ops to your
primary "it works" gating condition, at the expense of making sure
all the other parts of the filesystem still work correctly.

The reality is that the returns from fsx diminish as the number of
ops go up. Once you've run the first hundred million fsx ops for a
given operations set, the chance that the next 100M ops will find a
new problem is -greatly- reduced. The vast majority of problems will
be found in the first 10M ops that are run in any given fsx
operation, and few bugs are found beyond the 100M mark. Yes, we
occasionally find one up in the billions, but that's rare and most
definitely not somethign to focus on when still developing RFC level
code.

Different fsx configurations change the operation set that is run -
mixing DIO reads with buffered writes, turning mmap on and off,
using AIO or io_uring rather than synchronous IO, etc. These all
exercise different code paths and corner cases and have vastly
different code interactions, and that is what we need to cover when
developing new code.

IOWs, we need coverage of the *entire operation space*, not just the
same narrow set of operations run billions of time.  A wide focus
requires billions of ops to cover because it requires lots of
different application configurations to be run. In constrast, there
are only three fs configurations that matter: bs < PS, bs == PS and
bs > PS.

For example, 16kB, 32kB and 64kB filesystem configs exercise exactly
the same code paths in exactly the same way (e.g. both have non-zero
miniumum folio orders but only differ by what that order is). Hence
running the same test application configs on these different
filessytem configurations does actually not improve code coverage of
the testing at all. Testing all of them only increases the resources
required to the test a change, it does not improve the quality of
coverage of the testing being performed at all....

Hence I'd strongly suggest that, for the next posting of these
cahnge, you focus on making fstests pass without turning off any
failing tests, and that fsx is run with a wide variety of
configurations (e.g. modify all the fstests cases to run for a
configurable number of ops (e.g. via SOAK_DURATION)). We just don't
care at this point about finding that 1 in 10^15 ops bug because
it's code in development; what we actually care about is that
-everything- works correctly for the vast majority of use cases....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
