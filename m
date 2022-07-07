Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A1556AD30
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jul 2022 23:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbiGGVGw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 17:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236049AbiGGVGv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:06:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9621C2CDC1;
        Thu,  7 Jul 2022 14:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C0nxCXSvIJFifBPbNh2ICXJsxRsY23DCodgFgLSiFL0=; b=2s6Yzx/YaL1FQFAI756Pbfd7eD
        bGVW7hLp7m3QO5O4SRA8wkUdWI1n5seO03ccH39RP8q1fW6NRa8PpjTMXkocnv5PaiknM3AI2+rBD
        g0LqvqBN/qwn/tMvsZGeby6u73XXhZCrZZFgk0NY7MZDO9qc5n1bOXGnJ6o6p/eov1aW2X/MtWJji
        WjCK5mpT9ywL2/yU8U5hiCHYjHZa2HjkT242rqafpFKfxII/hLPezCPwggvwJC+d+Iuppm1P53yG6
        4ifBqZo8SrEHHXB3Az59fswihKnfVhQ2U2+fDw4mdvmcuRO2qA/qqo+Gwe6aB4c+9Kni0taHdzLsm
        qsNUtP2g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9Yhz-000Fnp-UM; Thu, 07 Jul 2022 21:06:47 +0000
Date:   Thu, 7 Jul 2022 14:06:47 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        amir73il@gmail.com, pankydev8@gmail.com, josef@toxicpanda.com,
        jmeneghi@redhat.com, Jan Kara <jack@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jake Edge <jake@lwn.net>, Klaus Jensen <its@irrelevant.dk>
Subject: Re: [RFC: kdevops] Standardizing on failure rate nomenclature for
 expunges
Message-ID: <YsdK5wHkasEneDt1@bombadil.infradead.org>
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org>
 <a120fb86-5a08-230f-33ee-1cb47381fff1@acm.org>
 <YsGaU4lFjR5Gh29h@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsGaU4lFjR5Gh29h@mit.edu>
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

On Sun, Jul 03, 2022 at 09:32:03AM -0400, Theodore Ts'o wrote:
> On Sat, Jul 02, 2022 at 02:48:12PM -0700, Bart Van Assche wrote:
> > 
> > I strongly disagree with annotating tests with failure rates. My opinion is
> > that on a given test setup a test either should pass 100% of the time or
> > fail 100% of the time.
> 
> in the real world, while we can *strive* to
> eliminate all flaky tests, whether it is caused by buggy tests, or
> buggy kernel code, there's an old saying that the only time code is
> bug-free is when it is no longer being used.

Agreed but I will provide proof in reply to Bart shortly a bit more
related to the block layer. I thought I made the case clear enough
at LSFMM but I suppose not.

> That being said, I completely agree that annotating failure rates in
> xfstesets-dev upstream probably doesn't make much sense.  As we've
> stated before, it is highly dependent on the hardware configuration,
> and kernel version (remember, sometimes flaky tests are caused by bugs
> in other kernel subsystems --- including the loop device, which has
> not historically been bug-free(tm) either, and so bugs come and go
> across the entire kernel surface).

That does not eliminate the possible value of having failure rates for
the minimum virtualized storage arangement you can have with either
loopback devices or LVM volumes.

Nor, does it eliminate the possibility to say come up with generic
system names. Just as 0-day has names for kernel configs, we can easily
come up with names for hw profiles.

> I believe the best way to handle this is to have better test results
> analysis tools.

We're going to evaluate an ELK stack for this, but there is a difference
between historical data for random runs Vs what may be useful
generically.

> We can certainly consider having some shared test
> results database, but I'm not convinced that flat text files shared
> via git is sufficiently scalable.

How data is stored is secondary, first is order of business is if
sharing any of this information may be useful to others. I have
results dating back to 4.17.3, each kernel supported and I have
found it very valuable. I figured it may be.. but if there is no
agreement on it, we can just keep that on kdevops as-is and move
forward with our own nomenclature for hw profiles.

  Luis
