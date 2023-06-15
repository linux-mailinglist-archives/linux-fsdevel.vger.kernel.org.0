Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1222731357
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 11:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241004AbjFOJPN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 05:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245676AbjFOJPJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:15:09 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FDA10EC
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 02:15:08 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f7f7dfc037so87695e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 02:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686820507; x=1689412507;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XoVSt871a8NGCTmDUS5BfwyaK5m5+GTgYV3kshkE7t4=;
        b=Dx4le6AYmSF192Sc1T8RggBmikepgdS34Lk8wWGr26axpgLgwuopIfNt280dIFw59g
         KfLTfSmlf9uSJjHq9JDE9VW3jeI7C/29UxGt0Vs4JmXur50TJR+onmAzeY5gu/CvREM3
         57hABUPhN+fCvFZMO0DeJVBQ+cI6IZY0Vbj+6UW2hMGZ0kh5QjVes82huaMqA/DEThEc
         pdOR0yFhgDATTQsZz9/WyNXiSx/45556qpzJp7pCknWfBre2c4d5e9aPYM/t/AV+jpi1
         EbtCYzvqOyFTrYF/iCR75wfHJpXgnPMn3yiv9OaBVAg+glqnO4R/OxNyUjij2/FY/68e
         AvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686820507; x=1689412507;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XoVSt871a8NGCTmDUS5BfwyaK5m5+GTgYV3kshkE7t4=;
        b=CizqKYsqV+n2tetX8+6mBb+xnHdDTiwP0jQGNV9AxWxB9gNWPj6S2k4DhfDk9ZC3NZ
         y/VNVMYEw6ZhmFhES93UeSohwdcHJhHTVU2FI2LduV8itsrEQvCf3wuqBo7YFkl0EWhI
         B7wHJIGUXAWm/HPdoXTmMoLFkAk2oxJVByaIVfoci+ATsJxxnuzhuytLsi3tZ7ftM3Ow
         04fpF5iMo47+ObpgrdSLv8heIdlHJDXn/oZRxFbop1IOqsXo9THLRYnTzBxgSzbEGj9Z
         wRsNnwUOEp592FBuHhYwbEzuSbJmsT8ZZhFVq2jdkVlJGMvpsb+uPSfD4uq9d0wb/RSo
         Gitw==
X-Gm-Message-State: AC+VfDx9bQA4W4+cx2FF6J0QNhyfTEitgjf1YAuma2ezqd5gAj3ReJpX
        FctUjweew4LKipRCO8Ecr7suX5JpkIsQL5gyAjXywQ==
X-Google-Smtp-Source: ACHHUZ7+UwPN9qbvGYCyHwg0Je5fkNMNcAcV2HwQZAGiyqV5c+8mcPMXxd6GtEKSHek8AWqLXX+tMTxJVVxmK21+/5o=
X-Received: by 2002:a05:600c:880b:b0:3f7:ba55:d038 with SMTP id
 gy11-20020a05600c880b00b003f7ba55d038mr99012wmb.6.1686820506904; Thu, 15 Jun
 2023 02:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230612161614.10302-1-jack@suse.cz> <CACT4Y+aEScXmq2F1-vqAfr-b2w-xyOohN+FZxorW1YuRvKDLNQ@mail.gmail.com>
 <20230614020412.GB11423@frogsfrogsfrogs> <CACT4Y+YTfim0VhX6mTKyxMDVvY94zh7OiOLjv-Fs0kgj=vi=Qg@mail.gmail.com>
 <ZIpPgC57bhb1cMNL@dread.disaster.area>
In-Reply-To: <ZIpPgC57bhb1cMNL@dread.disaster.area>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 15 Jun 2023 11:14:53 +0200
Message-ID: <CACT4Y+aqL_woqyGuxVGc-F2TEbk7i4OguiudDrA1cWpOi-n50Q@mail.gmail.com>
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted devices
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, Ted Tso <tytso@mit.edu>,
        yebin <yebin@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 15 Jun 2023 at 01:38, Dave Chinner <david@fromorbit.com> wrote:
> > > > CONFIG_INSECURE description can say something along the lines of "this
> > > > kernel includes subsystems with known bugs that may cause security and
> > > > data integrity issues". When a subsystem adds "depends on INSECURE",
> > > > the commit should list some of the known issues.
> > > >
> > > > Then I see how trading disabling things on syzbot in exchange for
> > > > "depends on INSECURE" becomes reasonable and satisfies all parties to
> > > > some degree.
> > >
> > > Well in that case, post a patchset adding "depends on INSECURE" for
> > > every subsystem that syzbot files bugs against, if the maintainers do
> > > not immediately drop what they're doing to resolve the bug.
> >
> > Hi Darrick,
> >
> > Open unfixed bugs are fine (for some definition of fine).
> > What's discussed here is different. It's not having any filed bugs at
> > all due to not testing a thing and then not having any visibility into
> > the state of things.
>
> Just because syzbot doesn't test something, it does not mean the
> code is not tested, nor does it mean the developers who are
> responsible for the code have no visibility into the state of their
> code.
>
> The reason they want to avoid this sort of corruption injection
> testing in syzbot is that it *does not provide a net benefit* to
> anyone. The number (and value) of real bugs it might find are vastly
> outweighed by the cost of filtering out the many, many false
> positives the testing methodology raises.
>
> Keep in mind that syzbot does not provide useful unit and functional
> test coverage. We have to run tests suites like fstests to provide
> this sort of functionality and visibility into the *correct
> operation of the code*.
>
> However, alongside all the unit/functional tests in fstests, we also
> have non-deterministic stress and fuzzer tests that are similar in
> nature to syzbot. They often flush out weird integration level bugs
> before we even get to merging the code. These non-deterministic
> stress tests in fstests have found *hundreds* of bugs over the
> *couple of decades* we have been running them, and they also have a
> history of uncovering entire new classes of bugs we've had to
> address.
>
> At this point, syzbot is yet to do prove it is more than a one-trick
> pony - it typically only finds a single class of filesystem bug.
> That is, it only finds bugs that are related to undetected physical
> structure corruption of the filesystem that result in macro level
> failures (crash, warn, hang).
>
> Syzbot does nothing to ensure correct behaviour is occuring, that
> data integrity is maintained by the filesystem, that crash recovery
> after failures works correctly, etc. These things are *by far* the
> most important things we have to ensure during filesystem
> development.
>
> IOWs, the sorts of problems that syzbot finds in filesystems are way
> down the list of important things we need to validate.  Yes,
> structural validation testing is something we should be
> running, and it's clear that is does get run (both from fstests and
> syzbot).
>
> Hence the claim that "because syzbot doesn't run we don't have
> visibility of code bugs" is naive, conceited, incredibly
> narcissistic and demonstratable false. It also indicates a very
> poor understanding of where syzbot actually fits into the overall
> engineering processes.

Hi Dave, Ted,

We are currently looking into options of how to satisfy all parties.

I am not saying that all of these bugs need to be fixed, nor that they
are more important than bugs in supported parts. And we are very much
interested in testing supported parts as well as we can do.

By CONFIG_INSECURE I just meant something similar to kernel taint
bits. A user is free to continue after any bad thing has happened/they
did, but some warranties are void. And if a kernel developer receives
a bug report on a tainted kernel, they will take it with a grain of
salt. So it's important to note the fact and inform about it.
Something similar here: bugs in deprecated parts do not need to be
fixed, and distros are still free to enable them, but this fact is
acknowledged by distros and made visible to users.

But we are looking into other options that won't require even CONFIG_INSECURE.
