Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7D052D70E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 17:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240406AbiESPKw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 11:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbiESPKt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 11:10:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1065A17E01
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 08:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652973047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pYo9QwJshnDwtzE/AWbi/Y4oLV1EYJTk8x6AWwlRJHM=;
        b=WnpN8iOkXmnxrp93krqjpxl+W1fcCNgm/ZxDbnx4rgp0TSJIOCH9dY/OBmd5SKCyEoIG7K
        797W72EF40ywt2+O8sL049uQB03y5PjprRfBd2Ioh4qIayuRhRGZXvmF6PLL2larsGIH7S
        TB+MsQuwPXcWCXri+yliQEm3D82BKsU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-a0Q-d8VbOgmi0HgYGOMI7w-1; Thu, 19 May 2022 11:10:46 -0400
X-MC-Unique: a0Q-d8VbOgmi0HgYGOMI7w-1
Received: by mail-qk1-f198.google.com with SMTP id bk23-20020a05620a1a1700b0067b32f93b90so4346893qkb.16
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 08:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pYo9QwJshnDwtzE/AWbi/Y4oLV1EYJTk8x6AWwlRJHM=;
        b=mUSL0/FXl0K3b7k0e4ct/tgYonfXnk2Cm+vxRVWWclY2vimFiXIMgYCe/yG7k999dN
         e6du5nFGscyG2BhfeAwnWmSIoQm6xoEJcZVn2bSq38bqaza5oKh0CBFMipuUu8D75PbO
         +b4jHZYuErY6gYJ2hpRkTbsL3rRUt8msPg3IxNj6BQydo39sCQb4k/kognVwC68Rgyp6
         E4cTXOfwJxLCZFEQNPd5StSeR3frcYC+kKJYlqlKTgs87IFxy4UkqQEvtSjbbRpfN3TV
         tSY7SVPgExFpEdL9Q1LNlc/Ytp0/MLpXTvpL4j+MuE36+AO4yDEErHhG72vPmyV5mh5v
         XsHA==
X-Gm-Message-State: AOAM532P/LnJyGEJxmzcGSFc22K1Ooq5UIAUNkZLLGMQsqG85FM0mvjW
        RlWniBJapTWyJ1lLye0xVZFk1bsFLDIIEhpTKe/gys9bo2xkM/rN1+PU0XGwjnPPPj1a3bsj8Jl
        z//8ZyCoovfEXjL6at+qtISbi8g==
X-Received: by 2002:a05:6214:2b09:b0:45b:59b:5df6 with SMTP id jx9-20020a0562142b0900b0045b059b5df6mr4346729qvb.22.1652973045467;
        Thu, 19 May 2022 08:10:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJU85gOlN5d5110p13TXYG+vSYE/1AP/JpUKdLmb8S5bbZQ1cCJysU/GHuoawEe0a316AkSw==
X-Received: by 2002:a05:6214:2b09:b0:45b:59b:5df6 with SMTP id jx9-20020a0562142b0900b0045b059b5df6mr4346686qvb.22.1652973045149;
        Thu, 19 May 2022 08:10:45 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g7-20020a376b07000000b0069fc13ce22dsm1385619qkc.94.2022.05.19.08.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 08:10:44 -0700 (PDT)
Date:   Thu, 19 May 2022 23:10:35 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, pankydev8@gmail.com,
        Josef Bacik <josef@toxicpanda.com>, jmeneghi@redhat.com,
        Jan Kara <jack@suse.cz>, Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jake Edge <jake@lwn.net>, Klaus Jensen <its@irrelevant.dk>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [RFC: kdevops] Standardizing on failure rate nomenclature for
 expunges
Message-ID: <20220519151035.ouqegv3o4vktykfz@zlang-mailbox>
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org>
 <CAOQ4uxhKHMjGq0QKKMPFAV6iJFwe1H5hBomCVVeT1EWJzo0eXg@mail.gmail.com>
 <20220519112450.zbje64mrh65pifnz@zlang-mailbox>
 <YoZRyGOwde+xkK1y@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoZRyGOwde+xkK1y@mit.edu>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 10:18:48AM -0400, Theodore Ts'o wrote:
> On Thu, May 19, 2022 at 07:24:50PM +0800, Zorro Lang wrote:
> > 
> > Yes, we talked about this, but if I don't rememeber wrong, I recommended each
> > downstream testers maintain their own "testing data/config", likes exclude
> > list, failed ratio, known failures etc. I think they're not suitable to be
> > fixed in the mainline fstests.
> 
> Failure ratios are the sort of thing that are only applicable for
> 
> * A specific filesystem
> * A specific configuration
> * A specific storage device / storage device class
> * A specific CPU architecture / CPU speed
> * A specific amount of memory available

And a specific bug I suppose :)

> 
> Put another way, there are problems that fail so close to rarely as to
> be "hever" on, say, an x86_64 class server with gobs and gobs of
> memory, but which can more reliably fail on, say, a Rasberry PI using
> eMMC flash.
> 
> I don't think that Luis was suggesting that this kind of failure
> annotation would go in upstream fstests.  I suspect he just wants to
> use it in kdevops, and hope that other people would use it as well in
> other contexts.  But even in the context of test runners like kdevops
> and {kvm,gce,android}-xfstests, it's going to be very specific to a
> particular test environment, and for the global list of excludes for a
> particular file system.  So in the gce-xfstests context, this is the
> difference between the excludes in the files:
> 
> 	fs/ext4/excludes
> vs
> 	fs/ext4/cfg/bigalloc.exclude
> 
> even if I only cared about, say, how things ran on GCE using
> SSD-backed Persistent Disk (never mind that I can only run
> gce-xfstests on Local SSD, and PD Extreme, etc.), failure percentages
> would never make sense for fs/ext4/excludes, since that covers
> multiple file system configs.  And my infrastructure supports kvm,
> gce, and Android, as well as some people (such as at $WORK for our
> data center kernels) who run the test appliacce directly on bare
> metal, so I wouldn't use the failure percentages in these files, etc.
> 
> Now, what I *do* is to track this sort of thing in my own notes, e.g:
> 
> generic/051	ext4/adv	Failure percentage: 16% (4/25)
>     "Basic log recovery stress test - do lots of stuff, shut down in
>     the middle of it and check that recovery runs to completion and
>     everything can be successfully removed afterwards."
> 
> generic/410 nojournal	Couldn't reproduce after running 25 times
>      "Test mount shared subtrees, verify the state transitions..."
> 
> generic/68[12]	encrypt   Failure percentage: 100%
>     The directory does grow, but blocks aren't charged to either root or
>     the non-privileged users' quota.  So this appears to be a real bug.
> 
> 
> There is one thing that I'd like to add to upstream fstests, and that
> is some kind of option so that "check --retry-failures NN" would cause
> fstests to automatically, upon finding a test failure, will rerun that
> failing test NN aditional times.

That makes more sense for me :) I'd like to help the testers to retry the
(randomly) failed cases, to help them to get their testing statistics. That's
better than recording these statistics in fstests itself.

> Another potential related feature
> which we currently have in our daily spinner infrastructure at $WORK
> would be to on a test failure, rerun a test up to M times (typically a
> small number, such as 3), and if it passes on a retry attempt, declare
> the test result as "flaky", and stop running the retries.  If the test
> repeatedly fails after M attempts, then the test result is "fail".
> 
> These results would be reported in the junit XML file, and would allow
> the test runners to annotate their test summaries appropriately.
> 
> I'm thinking about trying to implement something like this in my
> copious spare time; but before I do, does the general idea seem
> acceptable?

After a "./check ..." done, generally fstests shows 3 list:
  Ran: ...
  Not run: ...
  Failures: ...

So you mean if the "--retry-failures N" is specified. we can have one more list
named "Flaky", which is part of "Failures" list, likes:
  Ran: ...
  Not run: ...
  Failures: generic/388 generic/475 xfs/104 xfs/442
  Flaky: generic/388 [2/N] xfs/104 [1/N]

If I understand this correctly, it's acceptable for me. And it might be helpful
for Amir's situation. But let's hear more voice from other developers, if there
is not big objection from other fs maintainers, let's do it :)

BTW, about the new group name to mark cases with random load/operations/env.,
what do you think? Any suggestions or good names for that?

Thanks,
Zorro

> 
> Thanks,
> 
> 					- Ted
> 

