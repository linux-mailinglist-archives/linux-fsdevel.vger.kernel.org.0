Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3762956AD4D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jul 2022 23:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbiGGVQT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 17:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236225AbiGGVQS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:16:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A4C2FFE9;
        Thu,  7 Jul 2022 14:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vz0EFpm4EW4gscqucL2WOCV1P8PWt/Mzd6nQNhrFspc=; b=x+aYVaGFXkMC2Yz6p9/PsALvoX
        u+VV36hM4Et20cfaBCQlKV3uGFbzdzbo2SdPvmGV+LLu9XAM5KRz4adGbbc/xumshei1IrzvJqXEk
        KXLb5YFtucnwluV9wPvHtxbMbGOfoJLbtWeR22lQcosq2mi5sp/3jlPnEFQZs1BKR1LSmYYd/2uLK
        cuQiEFZnRrs2wyO731M8kctC87h4CWOWln9XlcXCAiWDvWRI7Cp5yMynlyvjW4zhs4J0qzfFErifu
        anG3g89WjmjUkTdJUko6YqEfOJhkXYeV8Dei2Ppo7LcdafBnmYW0hOEysNrHQWvQM10P2ydraKDSF
        WFGwV7gg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9Yr7-000ILa-DQ; Thu, 07 Jul 2022 21:16:13 +0000
Date:   Thu, 7 Jul 2022 14:16:13 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, amir73il@gmail.com,
        pankydev8@gmail.com, josef@toxicpanda.com, jmeneghi@redhat.com,
        Jan Kara <jack@suse.cz>, Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jake Edge <jake@lwn.net>, Klaus Jensen <its@irrelevant.dk>
Subject: Re: [RFC: kdevops] Standardizing on failure rate nomenclature for
 expunges
Message-ID: <YsdNHQZdlT1IU5dv@bombadil.infradead.org>
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org>
 <a120fb86-5a08-230f-33ee-1cb47381fff1@acm.org>
 <YsGaU4lFjR5Gh29h@mit.edu>
 <1abb9307-509d-e2dc-5756-ebc297a62538@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1abb9307-509d-e2dc-5756-ebc297a62538@acm.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 03, 2022 at 07:54:11AM -0700, Bart Van Assche wrote:
> On 7/3/22 06:32, Theodore Ts'o wrote:
> > On Sat, Jul 02, 2022 at 02:48:12PM -0700, Bart Van Assche wrote:
> > > 
> > > I strongly disagree with annotating tests with failure rates. My opinion is
> > > that on a given test setup a test either should pass 100% of the time or
> > > fail 100% of the time.
> > 
> > My opinion is also that no child should ever go to bed hungry, and we
> > should end world hunger.
> 
> In my view the above comment is unfair. The first year after I wrote the
> SRP tests in blktests I submitted multiple fixes for kernel bugs encountered
> by running these tests. Although it took a significant effort, after about
> one year the test itself and the kernel code it triggered finally resulted
> in reliable operation of the test. After that initial stabilization period
> these tests uncovered regressions in many kernel development cycles, even in
> the v5.19-rc cycle.
> 
> Since I'm not very familiar with xfstests I do not know what makes the
> stress tests in this test suite fail. Would it be useful to modify the code
> that decides the test outcome to remove the flakiness, e.g. by only checking
> that the stress tests do not trigger any unwanted behavior, e.g. kernel
> warnings or filesystem inconsistencies?

Filesystems and the block layer are bundled on top of tons of things in
the kernel, and those layers could introduce the undeterminism. To rule
out determinism we must first rule out undeterminism in other areas of
the kernel, and that will take a long time. Things like kunit tests will
help here, along with adding more tests to other smaller layers. The
list is long.

At LSFMM I mentioned how blktests block/009 had an odd failure rate of
about 1/669 a while ago. The issue was real, and it took a while to
figure out what the real issue was. Jan Kara's patches solved these
issues and they are not trivial to backport to ancient enterprise
kernels ;)

Another more recent one was the undeterministic RCU cpu stall warnings with
a failure rate of about 1/80 on zbd/006 and that lead to some interesting
revelations about how qemu's use of discard was shitty and just needed
to be enhanced.

Yes, you can probably make zbd/006 more atomic and split it into 10
tests, but I don't think we can escape the lack of determinism in
certain areas of the kernel. We can *work to improve* it, but again,
that will take time, and I am not quite sure many folks really want
that too.

  Luis
